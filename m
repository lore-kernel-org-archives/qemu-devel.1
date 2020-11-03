Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F46C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C2522265
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1XR2mZwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C2522265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmTJ-0000Or-Dd
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJu-0000vS-Gi
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:14 -0500
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com
 ([40.107.244.72]:13281 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kZmJs-0007gm-Pf
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:45:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmPdPSzqCGGhAN9+QplPYbJX9v6zyPRDNOM3RkYRZp41XpTjD4Vvx+73oLr1R/HzKrLNfb+/4so0KQfd+WaT4qi+MxIpSXa6GDSb6aV/7DFz0YOLeLpr+pxL9jPbj7kpJVqm4PZyqR7xpwwwN8MW6cBhu8DjSTKAWUbpz7EiJPKA0/wZvKOGfCwpIVfsKRCy9YAaFHvLuc1SOoNd7s/Hyzzd8y/rbsnMbFYzJt0qrnfkomyZxHJOv9+49U0HVFMHUqpcMH5nUvRiGH/GaJ/R0eyLdqmpAUNMgJMraHnro9V01k/jUJ876jhOFT8+8bP+ABmLUHbkn/XuhF6RafWmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=bwn6PLLZkrfdXgLMnjFTX41O5R7ciuX8VOliBWmhsh976TBQiAjBtAGbMwD418P3mz6hiuR4Q/DWdK9RKRHFjjxcHtWNsB3NXvSUDeEMPiyOMhiTiZBLXyCusEGtTKEs0v43m22KEwEWYQ58xcut7tWdMYeyieH6YqDkkl+r3KNLUpO505xmil/Lzodb7wCrP32XWJKRa5yhx+3WZrTih6+Lte4R7RIdMeo+9NkaokK5Bel6rre6ElT4/bm5deZdCQ9m/UgKtiXPcgZs92PrFbh9n81YLewFxXPRz4OW6VXwzq6pKjyEeO2aWS0M99idkn7Yn+DxSGoRKv11KBRlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gqDMia7c4BktleQtq4MXU98cKjxCSJ/JIUaGfLlL6E=;
 b=1XR2mZwDJnuSjlYGwfrdwLV8Pe5Me0W0d8KkwdmFkMXvGUhMJUCsZjyY+WN0kq4NbxuaqM3Ydncl7fHNwpvI4ZqzHNDFErZONIuOm8g9L3ODjjBKlFQZFd0tzv3YgdkETbePDM+OZYtuFuZfFaplrEwVNiGQZw/Fd13JLue2bWU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 02:45:09 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 02:45:09 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/12] qga: Flatten simple union GuestDeviceId
Date: Mon,  2 Nov 2020 20:43:36 -0600
Message-Id: <20201103024343.894221-5-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103024343.894221-1-michael.roth@amd.com>
References: <20201103024343.894221-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0401CA0001.namprd04.prod.outlook.com
 (2603:10b6:803:21::11) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by
 SN4PR0401CA0001.namprd04.prod.outlook.com (2603:10b6:803:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 02:45:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 252c55bf-7e1d-462b-5f56-08d87fa27acf
X-MS-TrafficTypeDiagnostic: CH2PR12MB4311:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4311F5B3A754A8070B25A28595110@CH2PR12MB4311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyt0QSz+5ZaCSAqTt+cdp56A1HXgiGIAJXHybsaQvSso3NYfGHA210Du6awWRW/NYkqRknG2WJaKn1leVsToVXu8IyYqo+ILyFCha56uBfJhpJQbmiWZDa0s+h5G3PsQjFIQo6+0S+5V2G3OjCNfXCq3JieUFAOOdmHlHaUvzKvMHc7/fZBi6AJ3UoKNjOxuO0RzMZqLBBfZ7aY0GONNNLGBL27Fmoe2MxEoEozoKv3v9sCRFa7skhPgWIvh0QSPExFiR2WH/FfkLlya/nTaNdhV70P0IcJwxvlU9qv2DT01TjY0ybvh+Ht/Si7sob9tXZclVBvRsMmyRGI8uemDGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(16526019)(186003)(5660300002)(8936002)(6916009)(8676002)(36756003)(478600001)(86362001)(26005)(66556008)(956004)(66946007)(6666004)(6496006)(2616005)(6486002)(52116002)(66476007)(4326008)(1076003)(83380400001)(54906003)(44832011)(316002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mxM2SpqMY1w4cziM8bED9lrPgkqE4mlam6u+vCz3UzBITjnl9kMoNVnjEpwiwJEYcTht7Zsik8WKutDPS5vo9J0UZWJ/VbxdsvZHJ0bVpKl1b/AaROWEr7hsINqkacYnk6A2p8DPsHegv9yyoK19dXrOMHK0cYkRsvfSaTEKIJ8tMFNo9gzVGcGnQH/oDr8wiiPgHnme1b4ewbGcOg/xNsXor5p9vPvIJRHDIIcIUaQedWxOIQm0ANbVgI0UZkVc2slGYvU50DIxGAT7nNqaTZq+deEjuriib3je6JVg7XiYwiscBWfn1SW7HjTvdQZeJu6K1NX73GcH62Bd0USAfBgFQgjbaZApk0KYx3mwmiRqERam+nhLnf7Gd4XIudCO6FXOft6Hi7w2S4dbIlT0p/Z2G5EyDm8GM3A9DE3pg1dDt6DzNPwWuilwvSK/c6+7K8IU6w7BctiBjPscSidby8A29IUUZjjB65UCtuaxzY5706F1c156//rOM1PiRVu2mMiJk4uqyodT9HwxIPcG12Gp+V/ckw/T/ZSLCZZWn9WLm4bUmK8I9xuU162HSMLJI1QqxmKYtjFCGjW3vR3xZn65QWzOAJMNkTNQIwZPwfg0LIQ2OIA41celfiKbb5rvPg3qkHAPBcPuFnZNBBLZhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c55bf-7e1d-462b-5f56-08d87fa27acf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 02:45:09.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/tI2KF4MO/cNgJRn9NUOcqL5h1HNjf/jCqwI80nI/CNkliFNqRJUbjFV3VKVzdAqaL+hfXMeNmeZKLCN+cVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
Received-SPF: none client-ip=40.107.244.72; envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 21:44:34
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


