Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B50C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C750E22450
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rrhHQJsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C750E22450
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZl2F-0004Jh-Gk
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 20:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksi-0006f6-Ou
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:04 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:25952 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZksc-0005Yp-PB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 20:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkyQv0eSJzgbGNpM5F9r2fUbJdc77zf1bom0zZuvlW5o3mpoTlsB3jp5U+fXZ1k/fuP0NdxTLtZp31QYThT+F20waU8yAZTFAVDVgfoupP9+zX8nAYssO52lT+bJTJ3v3Z7QLTml9cy+lohlblWcU+RDq3hL+g8cfeuk97A/zsKsHP35nRw0J1ivDRqyT8BfwP6w30JjU7W0vG9J2rV4eb5uBtFIJ6e+AbX9Fs98nff9cJvpMAXXq9M2zpDcpWGoCgiostHNfYLE8W2+UyBHHpc20mlJLCuIUaBtQ12PgDUs0pjcXLUgjtvqJnx4RF0rar1RuT2IZXaCjBzWkH+lPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=DKtIW7jT7oax636SXuZsN1IuvNgfqyFPeG6gZgdB90ggjaJOMYYUMRbn3JnVLCuCnVfwFAsJqwAneQnD/JxwMoK/Iny22g9VHZsKr+tDxM9/Tum+BaNOiDje519z/QxwGHnt+VAh2jjzxgmzfVdrsafKS3p1IgN2j4hgDCCPe8Wu4aC11awDhNZm0bbmEIyUt45HI5U2cpzZAKsjWZoh68B0ZiY843zPfaZiSoFWrfgXGf7HsGyHp6ja/fRxABibw49TFFGqRSoxcOd+Cl3728Qr3yPW3628gnhHYpGDMz69A6g5KGkxFngFNr3TYIOegUyNO/7z0FyeECKRM6m+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=rrhHQJsfuWVpeCLKgQGVJZ8U9TZDoGb1kkdoE2JW/0t8G73Wf8BIecWCEm1b46Hn/fWYOPLfVQ8dotSi5qFMMFCHp2SdZnLbv2JJsAUGc8VRm+YQjWR6kMcQ56RTM8trxtINQqFdMleXjpIuKnbWe01nwqJUjxdnlbKUsOFi6U0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 01:12:30 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:12:30 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/12] qga: Flatten simple union GuestDeviceId
Date: Mon,  2 Nov 2020 19:11:26 -0600
Message-Id: <20201103011134.887744-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103011134.887744-1-michael.roth@amd.com>
References: <20201103011134.887744-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:d3::7) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SA0PR11CA0002.namprd11.prod.outlook.com (2603:10b6:806:d3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 01:12:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8e7634c-3db2-45ad-1eac-08d87f958916
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5001D8606133C0D1147B305795110@CH2PR12MB5001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZNl1igfe7Luv+s86zNbiEsZgfNZcqQw2UEfYrR2dvmbi/ZTyjGJdzeEHdOMHKBobI1K+h2jNqZpLzkBt3t/l0MIwir0VLrvyGc71eh+6nRvx2xJKtDigZ14ugTiZy3XId6o0HyEQ0ptENvcpG6CItTMESeLrBeBxxNfLW/K6vf24HASlF+pdDvAD2HoBnY2bNE/m5Sik0J4LQNjG2uZxfh8j+0Sr7KuZk6LOw9As47RaFapW/dnonE8KJSmOxcPJ9pxME3sNBbiOyyMzVS7ypEakZMDhZ3yllMLLO0lZn5BXQ4hzBpZuCKo0B8LolyP5VMF37foMkJPc7xNrAKoTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(26005)(44832011)(66556008)(66476007)(66946007)(8936002)(86362001)(6486002)(6666004)(83380400001)(4326008)(36756003)(54906003)(2906002)(8676002)(5660300002)(52116002)(478600001)(186003)(316002)(6916009)(1076003)(16526019)(2616005)(956004)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MWJ7fc/i1UrflMM5apT9q7vBxeT/WVSxHCG35gRKVmg0AqR4czSCVOLpizQl9WcyFf4SirGQPv3SHa1DJ+slGveZpFMRsAm9wil6EbM3zwN9fjL2rY3plgE0ivQ5+wAI34qiKbosc18tA4I3SFFPj8e0MfdhXGrc23b6Kl9nJ0VW50FZg/CunugBsf9VWx0nBESutXKNjUxWhKTChgx6L3kaZYvzOEjpsNVEKMlD7+oeTGcnOktSvL0SYYOYaMvAtvLeukgukNvV1ifVXT0Y8pWAujnTl1ThPumQHvfPZiei1P6lutNB0vo4cOu1gUAcIR5i2OFALp0sNucZJWv8szQQJUzl1N5Gcy+OSrd3UopZ+MgxYT2rnQO2kysTHvGJhrvlTXkQpOTbNIcov3OUqFUo8r+aWCxUjCxe0jPuE0ufmo1giLnhnUDgZeQcjimc71RxwvsG7e/Znc+6hRWt8c8yGRyGnW/srNzQySGkmFBq8uDiWYDdLkLHOgmbRJWK4dwFPMMcj8MIMITjfdldgsacBX3wMd0aiimYngnz7Z4UeCzVFkW04N6f9+n5UGtwI4WAUFexJPPTQ+abmELz2LBr0Tw8a4URZFTlCsZlURqiKmoV9RVDZBIysXAbP3e4tlH6Ym/S2saKam93Ig9YAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e7634c-3db2-45ad-1eac-08d87f958916
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 01:12:30.1251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpliANdpVBktPPc/9gU1VXhOqLXowWBJyEtK9kZWc/MP+yIUFnhq5y8EHpDmsd4+8S5DKTITe75OHFGDkz6LRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
Received-SPF: none client-ip=40.107.94.55; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:12:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


