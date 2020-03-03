Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FE0C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E9B20714
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aZaxk0y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E9B20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dq3-0001j1-W4
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dgh-0002sA-3F
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dgf-0003Qn-K4
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:43 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com
 ([40.107.236.67]:13536 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dgf-0003Qb-Dh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPgRM/pFVigLnQH3cFb0EK9WWlu4VCYw1WtZmPGIBxAp/0FLwYkkXm0fnF6JC/pfjKk7tHdjKHdrAXByz1GQ+zhV5FjRRfGy+qMTlbc3jHzDNVS8OYsH/H3H2oE/3cQUX3VItdQiBfPmR6VbdU0GXom10FeUYtxhFC67zgsakDg6735fkd+STeYUUkllCB3vtdmv1wau2gvU9TJ1TtWvy5aDmKX9r/DjTB/33gzusiAsvxMzPQloqS+b/3Y3laQNveDFXj81SgBxLMCm8gDnDwq8DYyynf5J5z5F00JYyhrLaENcQZjdeOYmqyzLxAoGtje8p61i8eeKn+hUh1x6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=GFG+Shzu5U5qKcJH/SVBUNlrYEw1zp7x+fUQLha5xjQ2/28c0PJtxhVVAk7aRNHu8EvwTSDYO92YGVJhvFFgEcBnrF165GTW9K8+//DQWtLpCEB56EBKVDluC0Fa4ts6B47VvEoY0xqkmMfg539aCYUelflnXtevuHUBtMY0jiutgZjZkyNTl6XuMd4QGdSimAHrz3kW6sCm/HXyzLVgKni405m0f2hMoFRGqPVJyp/gdlO+wscPPZ1wMdg3/098Yfr1gEXYoewK7voeBu8iyyrvs3WG6Xp4+TeoFZFz9iIbV1wGIugfOO1JYFR7V85SFLnpNpeEgPnLbdaRBopOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAQb04Z8pY4pWGNtekpdV2h7RNoU2rwJnd2aRbQmSO0=;
 b=aZaxk0y1P8eBL7ws63bt/eiZXpejCSOVFTYQeTOgFJCzfvICT1e3zpY7ZZ8nRfydUV8jNWXT+3+Q1OBtCp7EBammbN5nGnV8nkF/kiDqJ0YqR41Gadw3E7Vnt9ibnAXh3qj29NwGanu3Fg9QvFs2TJj1l4xfsh8K8OFQm6s0o30=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:39 +0000
Subject: [PATCH v5 16/16] tests: Update the Unit tests
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:38 -0600
Message-ID: <158326551802.40452.18371333088303667854.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0043.namprd02.prod.outlook.com
 (2603:10b6:5:177::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:5:177::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 19:58:38 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45a0530c-587e-49c2-e497-08d7bfad4471
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:|SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23822B47ADCD7C521EA69EEC95E40@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(186003)(8676002)(8936002)(81166006)(81156014)(26005)(16526019)(15650500001)(5660300002)(478600001)(86362001)(52116002)(7696005)(956004)(316002)(2906002)(66946007)(66476007)(44832011)(66556008)(55016002)(4326008)(103116003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2382;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s52UCjmCXRE/s1MJ5PSX3VPoBTM0lYDP3rVdwEuRAkeMmNfa7yvcLDh8lV5rqhOa+TL6A5ERh8rCGdZQNjxbKz00vt0g3ekCgNKR1EwHVaRBrjsaGnBcYdAebrpmlUAJBPup4hX1lZHuYCdCX5tN6vj9G6QKwihHQNSUBdRicIlMc4TEkLT9CPc/aZy9GsF0a0wVFqLTm9N2/SodtLJTXuM9UmK6KTGq8qInzmxAH00gVfSey8TvLLTtH7nTlBEb+b+Fl9/lR0z25ZnbC9M7+aBDoyl6/DB5aX/839tgH7wZquOf/IXAmNh7oFH8D/lkpkwTIXl50GPephVKAsnPMCRAU2HZdd/udsHE7xWwXCuee4hN9g3E74xca2m/D1ueqc+MGeWxqiz+hfA0BMC8+pYJVEVwMgd0E3GWkfFeIAXFdZWVkWaBR3tS/9rS5UIO
X-MS-Exchange-AntiSpam-MessageData: N4RDO7Uogw2DKgm7DQNvZZV5SJhfvBR0gXFSrPt4675b0zWD/2s1D0MBF9hS61dPhz4O93t5JDXB7hPYc4EnnA6GEKnzrXSqjh5dtRjdju79/bB0KpCJDngVoum0ckR4qW1TKHwpN9wfJVPOtcnqZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a0530c-587e-49c2-e497-08d7bfad4471
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:39.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVZuMJFgF6csATj7CsHu/gYRgBycvUf4ukEfGLowanrM8BwyFYv+gGaXzSxlE7nd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.236.67
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
 


