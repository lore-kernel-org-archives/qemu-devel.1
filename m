Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA02C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 214F2222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hy+QHEFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 214F2222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JJj-0007py-A2
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J4A-0003tw-Nh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J48-0001f3-Q6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:22 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com
 ([40.107.223.67]:8065 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J48-0001Zy-3E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj5bMCww99qvQODZShzbiilHtu5waK+8Adv/PG+PI55sJdNdd7o5VkigaFzhgpLEGQklLV1UUgRr4kz6U087K50neAAFfEnrP+Ff1G7vdQsDw9GRNbCh6HJE3DlQbGnCKSFzFCDWTDBALjLbO/16Kv3SvT/pejccBtbMKVhCziAfQy7Pxl77gPRupWF6H54g5QwVF5kwQu0Vx0eULGwUB05flXwFMtEPuCHETylEovXmYhmQiRhCNv81jDCl0M00+m9E5se8l5lQ01bDQyh+QwtiEGxZhpR5KoWu6idz3qqBDlYDhtKIsmlFrEDsa0BK3B8y5ivM3nC3sU9UVNau+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=fkaQ0xUTz5xgsXXW7IwQHehe9ZikCKutnKHwreQ8E1FVbs7t+bAHRhposzdjBlckl6srEIw7nfJBzNGmnFtZc7YpOKZ57JM5BmLR2J3Tc+ECGrPfB1fTZzwcu6TLUX1VrV6o/8EXvQTrUD8Ix5DrHsoG3Tn/uNf65wO/LGfxjnH+tDRrjDvKgY89JKOlw8rE8fy4NNyvWcUSVL6VQH+XdEmxX95OQpl3RFhd7PaLOkMaDA2DuTBACn521wJ120ZmKhwfkm2rag0vTHnq+NFNZk0F3VwIUfHKcOifI4PbNx4VQIacTgZpem6aV9YubCIIB68Kr6WVSQzqtzLYpn3jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=Hy+QHEFvY6E8kc24qFSdbAK4mgAkBh39lc1XC++gHsr85ONGqaq1XshmwOaPIXNfsTyoKEZ6ABBr55KWGQeIXTEsUKXQpK4RwCPqpfQdPkbU8uHn67KApvIfgY1duhrcgFvbQEp6VsOYR1xfHdkixlRn1iMZwWResVsoYjMzMYw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1222.namprd12.prod.outlook.com (10.168.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 18:18:15 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:18:15 +0000
Subject: [PATCH v4 16/16] tests: Update the Unit tests
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:18:14 -0600
Message-ID: <158161789401.48948.15080057701047052272.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0085.namprd07.prod.outlook.com
 (2603:10b6:4:ae::14) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 18:18:14 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86d994ab-6d59-41a8-9ee5-08d7b0b117ee
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:|CY4PR12MB1222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12223FE3E6FE960A5E29BA3B951A0@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(7696005)(26005)(5660300002)(103116003)(956004)(55016002)(4326008)(86362001)(2906002)(44832011)(15650500001)(186003)(16526019)(478600001)(316002)(81156014)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1222;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4bZEH4uW9TifjN0qGJxZ0WTdB4jA9ndLj0sD2ubutdRI7v+nY6bOfzIrQ3speyK85MpiRY7R8tC2KFcs0yLzDPGechR579KMnGfCq/4L5Kk/V/xg4Ei1y0M2b3ZXlVEsmiB4IneCuL/1oQ9fMYW9yiAtL2/NOIyhVJpVybcTPb+Td7vFxZEETFxZwGPyjDmS5+nHqae3pxsEVpRQfI2gLE3in8Uea2euYTDtsMiBQsARpcX32Kt2e5heXGVDcFwKx0BvT8zESV0hTs9GN+nXlJ0ihDD6Pk+BhUiCGuFheFiuhUPcz/D9ZLx7MBeoGLe1WhdQp4Tl/oi9nN3V9MWUz8tRcmkXqdmMOT9FnjsJ7Qm8G67GQ+xF0Ap3gUUHOLdYL34DxxH0K0TShdz5SCPMI5xZskbdHW7LRf4hDy+iGsIdOojzJnnzKaquky/a2hz
X-MS-Exchange-AntiSpam-MessageData: xAMnkc3zHoWg8j+R5s9fjyqvimAWyZmQUfKrkBxcoNEHSKn7GsalK9mfJpkKg/BRSzMhNxJV1hXZhD3GQqa2048mmSz0wmuhA4Yjb/K29VklrHxTAfGPQIO+C9tSVaERa4/gV4oK6dllBuHsJKlr6w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d994ab-6d59-41a8-9ee5-08d7b0b117ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:18:15.5857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +E+ta8rPzafVP9XwrQsvG6Z59ZhoRBQPgRTv1yI/3Yi/IxBU7VzOzKF+CFo0FyrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.67
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
Cc: qemu-devel@nongnu.org
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
 


