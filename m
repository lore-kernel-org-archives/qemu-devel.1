Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C61C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A940720738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fIlBlftB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A940720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJmo-00086v-9G
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvm-0007MV-EV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:02 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com
 ([40.107.92.50]:55041 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXHvk-000447-VN
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgJ/uM9zksHwXuxMJM7AHs3K700SzyXS65c4/SZuxjEPCyQFsuevr4NEKPeMEMWLaKNBWoU7cy3dg982j4TdTuzrANDzlMJTh5+5+leJaiMXyHB7bmk+LI5Aalq0J8GkthQboLj0aUYslMKfb8D8h7EmQ8qGYfrl20qI4XjBrdvP+acOpKQ/4lvM9o9nsYiWhgFYv/0avbghxOQOF3uCyBHr9fGHOwunIxSygjs+pj1b2RnZ8IMWdvkQ/9cTrbK9vk8FnJaIhdHeiZGTO9W/6srDrD5iCkeAkbFQzvvW4fk+6HfRU6mQocMUoKU9TIuBDOi/ppWRPSzjbFjBo6laQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=XRa1EcYI3/ArhN/ptjqdHS/C9Ug6CAScseCTnA2eG+9DF2pHjnKb6Zy+qcXMVQwwTCe5Bq1lNT2oU8pwEd+HAhJSejlo2891+Spgz42IGqkPXxCz9h5AVX2JTpXBnJUfh4GUhoRF1UvmsAqkv/A9/YDQw1wjWwhuT1alpO5+Qd2xIir3mCWnXLDFmCqiBrvzStdjeu7oYKnjxqJtptYWs57fKFyoHe1lQ/MwDoks6p32JPep/U5g696tFqW/PNPVl22HjMR1K1Fq4JAdby/tXwBNFdJmIwxprkFzZQcqLABxIH8r3tKv9+HHvvkPA4+UhQv0GnwTs8XcTkXcXgs/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=fIlBlftBAQBW67aGcvlem+lWgXLCnsXim7uz0c8t1C+O6KvLQRfzgXmvrdZEbMdWWHBPwdKb85iFUCbgy/AHKTwSUJwJIzvRW/ZY0hm/11bXZYG/wHylFnvW4DSd7Fy8cvJXUC8n06spHgHUf47ekmhVPBCZ+vNAg88ad2vz4R4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5004.namprd12.prod.outlook.com (2603:10b6:610:62::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 05:53:47 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 05:53:47 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] qga: Flatten simple union GuestDeviceId
Date: Tue, 27 Oct 2020 00:53:09 -0500
Message-Id: <20201027055317.351868-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027055317.351868-1-michael.roth@amd.com>
References: <20201027055317.351868-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: SN1PR12CA0102.namprd12.prod.outlook.com
 (2603:10b6:802:21::37) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 SN1PR12CA0102.namprd12.prod.outlook.com (2603:10b6:802:21::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 27 Oct 2020 05:53:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74d81e74-9cd6-4429-4775-08d87a3cac0f
X-MS-TrafficTypeDiagnostic: CH2PR12MB5004:
X-Microsoft-Antispam-PRVS: <CH2PR12MB500415D310D18E49AEA2846495160@CH2PR12MB5004.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6b/F3xXa8CoQVZzF1mxcG6/jy96enxSwrLT0Vz/37H4BGHVTPiS0Hv+TJo7C6+Ti8NbA1uaqGa0a3B9vMqXQMgPBRYw8MsqpbXzEglzYao/RH60yvhM1tRjY9ZoZpstQqfbK2Ssp3k34zzEyj6C66vPbbwsn2T0uF4FBvUaeh/QbJImRlAcfOspdIwBu2kiiaH4zIi6IV4MCdXeq2DeifCekgAxsaQt2Q5Noqv6uFqi0ebmNSJkXJxC2ZRVP1SsNLvT/CLPKCFuZ58LHt3XDibH09kGZaeLWMM9MQurk/GOxkc20rWAhH2zcyGSmzeABe47yWrBgPJZALGittJaoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(54906003)(316002)(956004)(2616005)(1076003)(8936002)(6496006)(5660300002)(86362001)(52116002)(66556008)(2906002)(6666004)(6916009)(478600001)(66476007)(26005)(66946007)(16526019)(8676002)(186003)(6486002)(4326008)(44832011)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: pVqpyUBRredj446BWKMJvDA0lgzb8NZYJlXBoK9/lSSg/wz3V2Fj4cLmqPj5PZpuiNssIRrfMIbs3zwjyFnngg1n1OK9KKFGLYN/L3RrtvfT/aHVGmyn7Gtx1Grjy/mmuSL9UARkCNTx94tvYcuw2B1Y295JpeUraGGrSxkLDIdcauCZAxr6KO+GPqnkZsHpGYWR7/Uk0zCnbul36DaOWBApkf8Qh24+kyIrHVS7awQKIG/wuZBaxIr10QUGYYtean5+HYf4WsLd8Gt87CmsgprxmKFZs6uGI8FXv/lfIXF0it1k49bww8QpE2v9tPL86LT5ig1Kv92nncbbtjAdZfh+8I6yXcf3tzaROY7fpwsgPzKEKoD7BMnnQeuNFbKeUjTe77zhmFmiHfqVodcvgrISjiLNLGJuHKXxb5mbwpkT4VI5FXAbGQRu6cK0Jyz9t8LF85BvF2PYFpgKy2ar5NjtTtS1Reh6bBp/QBDfH0AT7+pUurAePI1PJzuMjFy2H+mGf4JzM9nz870Mtua/Wmig8OLCS+hvGNy31umyGFEeeJzu9B9paeSuPm7IJuRjaaM0B+/IvyY7VbzMS5WHGerHkv03Fe4APx1rSIXh8VcxpAo+PMfacEXKZCjFu6Fky+/csi20AXlDQHJav15tQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d81e74-9cd6-4429-4775-08d87a3cac0f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 05:53:47.8115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGAAcIYpYAaasHzA47aBxmWSpUxgj25PQvALG0ivWv3Yi1ujO52xWqKWSsrqy0zhRMb3vYCntwobJJm3HEctaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5004
Received-SPF: none client-ip=40.107.92.50; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:53:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:47 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Simple unions are simpler than flat unions in the schema, but more
complicated in C and on the QMP wire: there's extra indirection in C
and extra nesting on the wire, both pointless.  They should be avoided
in new code.

GuestDeviceId was recently added for guest-get-devices.  Convert it to
a flat union.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 qga/commands-win32.c | 9 ++++-----
 qga/qapi-schema.json | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 1efe3ba076..0c33d48aaa 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2400,16 +2400,15 @@ GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
             }
             skip = false;
 
-            id = g_new0(GuestDeviceIdPCI, 1);
             vendor_id = g_match_info_fetch(match_info, 1);
             device_id = g_match_info_fetch(match_info, 2);
-            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
-            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
             device->id = g_new0(GuestDeviceId, 1);
             device->has_id = true;
-            device->id->type = GUEST_DEVICE_ID_KIND_PCI;
-            device->id->u.pci.data = id;
+            device->id->type = GUEST_DEVICE_TYPE_PCI;
+            id = &device->id->u.pci;
+            id->vendor_id = g_ascii_strtoull(vendor_id, NULL, 16);
+            id->device_id = g_ascii_strtoull(device_id, NULL, 16);
 
             g_match_info_free(match_info);
             break;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c7bfb8bf6a..fe10631e4c 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1256,6 +1256,12 @@
 { 'command': 'guest-get-osinfo',
   'returns': 'GuestOSInfo' }
 
+##
+# @GuestDeviceType:
+##
+{ 'enum': 'GuestDeviceType',
+  'data': [ 'pci' ] }
+
 ##
 # @GuestDeviceIdPCI:
 #
@@ -1276,6 +1282,8 @@
 # Since: 5.2
 ##
 { 'union': 'GuestDeviceId',
+  'base': { 'type': 'GuestDeviceType' },
+  'discriminator': 'type',
   'data': { 'pci': 'GuestDeviceIdPCI' } }
 
 ##
-- 
2.25.1


