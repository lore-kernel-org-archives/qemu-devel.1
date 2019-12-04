Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F2C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D966206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ES0zCT4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D966206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJIS-0005rD-HR
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIu7-0005Y1-RZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIhF-0004lV-Et
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:39:14 -0500
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com
 ([40.107.223.51]:42208 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIhA-0004hx-Hs
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:39:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK1CGXg8Njp3eelxGFmXSUxBz5MBCP8t7vFodBKeaqGPr9dvPugWTVmj9W8oPE2609iieL3PTTunpON/CcXX+1Bn4A+0M2mRtqKLyOX1EUNt8pYFk96X1wU2pyx0v7z2pwmnP5A27Dq74MTDyCBUOgQHr93t+886YEkP2MVk8o2wvvAnbnZy6Dm4qmdheFCcQmZ+EKQ5Bxb+gCtrvwj3ZDUK4rhfLSCDPWtpU7M2JVC8/e1rdM7cXibEvFyw6B8cBb2aI9ws4x7Ny7WxZ+WIqkaaDkNAu608HLUBnF2EFgS0o6W8Pe20BlUpEGAIs+8iG/uNh70AJrhG4ThiLHzjVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=RgU+0mkjkYXAvIcJWvpPXa3LRBEjaDBhIRhF4Fy2y4YFhQJhNYqWoHSN+SgDb4nU+PgcmoLl5NbKJdHC0I+iQByBS7Gs5mUeT6WSXcW572ncJuzZz0giZNd9FCSROkkohggS3CxFcZzjQMQktmXyBPLXSk+/p9Tzg9tg+Fan3CzgmW7Khzd8O43rgnPN382o84JvdP/0D7OJB3EkBC60sz7bSUpe9wxnAkB8E/GXeJSrtgHhR5i1D5QfUVoUGIBY3Mx70gwAkgn/iutEADxUeGhePtSkr0eA8TWbP/smgTk6SBEybWTLsmDPeT2c2m8YPX1srm0eKNt70Jukfj9qOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=ES0zCT4YAVgI8fwQheApy/Zkh4mc82PqoWdcawAsjj9DHHMJ9xqHeUlBkt4zmgs7YyjYAJ4AdwMK32SofTc+Ss2/0JbgEHHYOUlJnbEylmupKGAxgZEr32wdIuw6btSuOO/lbCZVwSWVDiqbCM29cyA4SSKGUGQetC+4439/aZI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:39:01 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:39:01 +0000
Subject: [PATCH v3 18/18] tests: Update the Unit tests
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:39:00 -0600
Message-ID: <157541994039.46157.2036450511065834532.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:805:de::37) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1c8fbe2-bb6f-4253-efc0-08d778525bad
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB136989D9C66969D17BFE3048955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(15650500001)(14444005)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1lhY6V9Ki4R6XKxXIikthhHsEBWv8FpDzJtxDBEs4byiILOItcD4sfOkzkHy3e46DF6NhF5g8ZiS2v2j1KKWmZ6Zyye3h7fZjF3QvhW3hY4Mrz8H/h/fVlCXyXlg3Nzw7nDPSddrv8V74K0omINjtFpiTpVejYswhA9Eg3YpSwsOhDRPwtLZgcAYIOcwFilL586xH8NtCAk8To2ue6xIjZO8UUru44+QlN7Si4XVbCmkkpa9v7akn31iXUM76zLdA/H5bbEqcIklpr4BfuujlMjPTz8mVUf6SiPDU8dGj+fMjLkym0g3/XFFNUWhwe9vAnbrkWB3EFajD3ShkeVPhIbd7WB1i7uoxRTK6UmBb34K90PzHuVUmIEEgNJcIhAxnLbfde7Z1EoaLyZmUO3i8L0wm6e7GaNi1HfplWSc16ez2e0Rs+TnEaFnwHwyLqDf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c8fbe2-bb6f-4253-efc0-08d778525bad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:39:01.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJEHfGo2JQRj/SvOmyJMFNaezioJTK3MFrJtlt74Fp95Q/F7d2q0hvS3BFJ/zZMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.51
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since the topology routines have changed, update
the unit tests to use the new APIs.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 tests/test-x86-cpuid.c |  115 ++++++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 47 deletions(-)

diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 1942287f33..00553c1d77 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -28,79 +28,100 @@
 
 static void test_topo_bits(void)
 {
+    X86CPUTopoInfo topo_info = {0};
+
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    g_assert_cmpuint(apicid_smt_width(1, 1, 1), ==, 0);
-    g_assert_cmpuint(apicid_core_width(1, 1, 1), ==, 0);
-    g_assert_cmpuint(apicid_die_width(1, 1, 1), ==, 0);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 2), ==, 2);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 1, 1, 3), ==, 3);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3), ==, 3);
 
 
     /* Test field width calculation for multiple values
      */
-    g_assert_cmpuint(apicid_smt_width(1, 1, 2), ==, 1);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 3), ==, 2);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 4), ==, 2);
-
-    g_assert_cmpuint(apicid_smt_width(1, 1, 14), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 15), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 16), ==, 4);
-    g_assert_cmpuint(apicid_smt_width(1, 1, 17), ==, 5);
-
-
-    g_assert_cmpuint(apicid_core_width(1, 30, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(1, 31, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(1, 32, 2), ==, 5);
-    g_assert_cmpuint(apicid_core_width(1, 33, 2), ==, 6);
-
-    g_assert_cmpuint(apicid_die_width(1, 30, 2), ==, 0);
-    g_assert_cmpuint(apicid_die_width(2, 30, 2), ==, 1);
-    g_assert_cmpuint(apicid_die_width(3, 30, 2), ==, 2);
-    g_assert_cmpuint(apicid_die_width(4, 30, 2), ==, 2);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
+
+
+    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
+
+    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
+    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
+    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
+    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
      */
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    g_assert_cmpuint(apicid_smt_width(1, 6, 3), ==, 2);
-    g_assert_cmpuint(apicid_core_offset(1, 6, 3), ==, 2);
-    g_assert_cmpuint(apicid_die_offset(1, 6, 3), ==, 5);
-    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), ==, 5);
-
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2), ==, 2);
-
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 0), ==,
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
+    g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
+
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
+
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
                      (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 1 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2), ==,
                      (1 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0), ==,
                      (2 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1), ==,
                      (2 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 2 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2), ==,
                      (2 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0), ==,
                      (5 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1), ==,
                      (5 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3, 5 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2), ==,
                      (5 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(1, 6, 3,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
                      3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
 }
 


