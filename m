Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F5CC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18077208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aoRCB1Sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18077208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrDc-0002A2-7c
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37649)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBi-0007yt-0O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBg-0006HN-2V
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:37 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76]:10848 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrBf-0006ET-OF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxJO+eXNSVI1aR9s5fEI/ma5qPXohy5oJGMY6oruKu839748BSGbS5rlAGdqUvbEfEDFED/2BPXDp53MvzemmrduWQLtJvUloOL1oWEQ1FUExSWIe9BTquwVJTdDKxNx7UfoFFBQiPBrhaFHJMj2ZvLSdPnS0ZjkfSHVogj3SCS6D06u0wCP0FDxK6xvnlk0ATHLVc2LqyOzN3svWOnRyg70f6WXWFx0QPMLwSFLBTv59fUpQsz+8RwmlxWhn9afXp7gpsV/ylSVwgUsltnYNJ/WEBEiOzR5iBp2jq7FPZcZj9y6xSMhtrGOq3EsYilqkYmB9Gh5HxrrV6FK/lyGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OlO91gkjYoVB7elpFVrJW3hmvRxzUi8KMnNWPilSGQ=;
 b=VoqSULf9Z+1+VtgUtsUAREPey04dyqfxwMPyL9aifaUuY61vp2T3y4OUY21ZgImUGahnelCLFb0oY/v0lWAzlHOd1LF+WgY5c7mrIb3hP3jvAmnmvDC84/q/QhBe1S4gRhcdrd1oPDjhSsPRsRtJf7nuvFaQQLgns6GU3FJrmmQSH1VydjhYRLOSSAOwk6TYuI0priaAdlLxg4GiKxT86FUahc6olgmJ/Zj6a19s2CAApumLJjoxD+XDeCDlDJYrTn9J+fxDDHAQshkGvEpQ4kdhtTIFLijG1uRbw0+UWHXcx4Wp0RYPREOPfB2VRqz/dXX2f47pmdyKvreZkcFkNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OlO91gkjYoVB7elpFVrJW3hmvRxzUi8KMnNWPilSGQ=;
 b=aoRCB1Sz26S+DW9Xk8FDfCTShSL999WywZ235q6ur3aCdC75Y9fbMcqfteAPw0GU6PMRU1K9QHPES0CUxFPbdoq1mdSHwc3nqBDbqR+Nphfl2eJh+okErhsK5PGLa3nOtUqdak+8MHA2N73g8XjOjJoUsAgnXgV/ZtVrJPFTryw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:33 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:33 +0000
Subject: [PATCH v6 02/13] hw/i386: Consolidate topology functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:32 -0500
Message-ID: <158389401201.22020.3435322250467814934.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:803:2b::13) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0201CA0003.namprd02.prod.outlook.com (2603:10b6:803:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Wed, 11 Mar 2020 02:33:32 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da829074-972b-4502-5f6b-08d7c56497b8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB249358033DAAFD3E66ABE52195FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(30864003)(8676002)(5660300002)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qScCKv5WTbftEuj3K+p0CafO/SAcmZX7SAKSKZkLmzoFlVqkJr85OhjpU5UwhMJoyyIddsMUA4EmBcl1emh3S1auJNyTA17bIKEkMbVXITWplLCFkivuv6JpSMlTzr9LatJb9dGfUkwZ+Nm/XvcT/ImnYzzvXtEFgTnhlea80790pQybG5VBxiSbdcj7WwVYx9UHf4hjFvY1vD8J9vSYE/rUt8I2PThqtEocjN3by9Mj+9VV24v+YkwqB54vfn6Wg4nLQwWwxh/t/uzk2hmaeQzPb3/hRgwH82WdQ02qeXgly7lneh3hgtAPnvLDAuvfZ1O+fGOn9GkMWmsFf5TlnIbMu5xr8lFV1XBDh5JqizPL2jV8FNWjdxYfEfvKEZHZqLA7yhjvpza4skFT5XA1YSsEIW6D3NJ6is+WhZKSDwsODT3W3RlWTQwvYv3QctcH
X-MS-Exchange-AntiSpam-MessageData: al5LV+j574zi5vEpl0ODk3Cg+pTvbYtnDXWbUkVWKCM947V+O42+/B1lpLC0EdJgU2GHv7mtAHn0wFBJ/NKg367onX7OR/lA4vnGYFDzLjLdfUfCzZcTe/LmdzuAIq2aMGUjfeZhh5vnxCrbsTXhMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da829074-972b-4502-5f6b-08d7c56497b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:33.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxXWF1ddfZI4R8WPIpzscRwN+KFuZaQ6UghI/5N0exGigESzWdwzjXY+UnQQGb9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.76
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

Now that we have all the parameters in X86CPUTopoInfo, we can just
pass the structure to calculate the offsets and width.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/topology.h |   68 +++++++++++++------------------------------
 target/i386/cpu.c          |   23 +++++++--------
 tests/test-x86-cpuid.c     |   69 +++++++++++++++++++++++++++-----------------
 3 files changed, 75 insertions(+), 85 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 7ea507f376..ba52d49079 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -69,56 +69,42 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
 
 /* Bit width of the SMT_ID (thread ID) field on the APIC ID
  */
-static inline unsigned apicid_smt_width(unsigned nr_dies,
-                                        unsigned nr_cores,
-                                        unsigned nr_threads)
+static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_threads);
+    return apicid_bitwidth_for_count(topo_info->threads_per_core);
 }
 
 /* Bit width of the Core_ID field
  */
-static inline unsigned apicid_core_width(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads)
+static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_cores);
+    return apicid_bitwidth_for_count(topo_info->cores_per_die);
 }
 
 /* Bit width of the Die_ID field */
-static inline unsigned apicid_die_width(unsigned nr_dies,
-                                        unsigned nr_cores,
-                                        unsigned nr_threads)
+static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(nr_dies);
+    return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
 /* Bit offset of the Core_ID field
  */
-static inline unsigned apicid_core_offset(unsigned nr_dies,
-                                          unsigned nr_cores,
-                                          unsigned nr_threads)
+static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_smt_width(nr_dies, nr_cores, nr_threads);
+    return apicid_smt_width(topo_info);
 }
 
 /* Bit offset of the Die_ID field */
-static inline unsigned apicid_die_offset(unsigned nr_dies,
-                                          unsigned nr_cores,
-                                           unsigned nr_threads)
+static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_core_offset(nr_dies, nr_cores, nr_threads) +
-           apicid_core_width(nr_dies, nr_cores, nr_threads);
+    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field
  */
-static inline unsigned apicid_pkg_offset(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads)
+static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_die_offset(nr_dies, nr_cores, nr_threads) +
-           apicid_die_width(nr_dies, nr_cores, nr_threads);
+    return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
@@ -128,16 +114,9 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
 static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids)
 {
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-
-    return (topo_ids->pkg_id  <<
-               apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->die_id  <<
-               apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->core_id <<
-               apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+    return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
 
@@ -165,20 +144,15 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
                                             X86CPUTopoInfo *topo_info,
                                             X86CPUTopoIDs *topo_ids)
 {
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-
     topo_ids->smt_id = apicid &
-            ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
+            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
     topo_ids->core_id =
-            (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
-            ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
+            (apicid >> apicid_core_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
     topo_ids->die_id =
-            (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
-            ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
-    topo_ids->pkg_id =
-            apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
+            (apicid >> apicid_die_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
+    topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 350b51b346..6df3127fd7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5497,6 +5497,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    X86CPUTopoInfo topo_info;
+
+    topo_info.dies_per_pkg = env->nr_dies;
+    topo_info.cores_per_die = cs->nr_cores;
+    topo_info.threads_per_core = cs->nr_threads;
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
@@ -5583,8 +5588,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset = apicid_die_offset(env->nr_dies,
-                                        cs->nr_cores, cs->nr_threads);
+                die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << die_offset), cs->nr_cores,
@@ -5675,14 +5679,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(env->nr_dies,
-                                      cs->nr_cores, cs->nr_threads);
+            *eax = apicid_core_offset(&topo_info);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(env->nr_dies,
-                                     cs->nr_cores, cs->nr_threads);
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5706,20 +5708,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = cpu->apic_id;
         switch (count) {
         case 0:
-            *eax = apicid_core_offset(env->nr_dies, cs->nr_cores,
-                                                    cs->nr_threads);
+            *eax = apicid_core_offset(&topo_info);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_die_offset(env->nr_dies, cs->nr_cores,
-                                                   cs->nr_threads);
+            *eax = apicid_die_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = apicid_pkg_offset(env->nr_dies, cs->nr_cores,
-                                                   cs->nr_threads);
+            *eax = apicid_pkg_offset(&topo_info);
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 66b953113b..bfabc0403a 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,9 +31,10 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info = {0};
 
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    g_assert_cmpuint(apicid_smt_width(1, 1, 1), ==, 0);
-    g_assert_cmpuint(apicid_core_width(1, 1, 1), ==, 0);
-    g_assert_cmpuint(apicid_die_width(1, 1, 1), ==, 0);
+    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
     topo_info = (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
@@ -44,35 +45,51 @@ static void test_topo_bits(void)
 
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
+    topo_info = (X86CPUTopoInfo) {1, 1, 2};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
+    topo_info = (X86CPUTopoInfo) {1, 1, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+    topo_info = (X86CPUTopoInfo) {1, 1, 4};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+
+    topo_info = (X86CPUTopoInfo) {1, 1, 14};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {1, 1, 15};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {1, 1, 16};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
+    topo_info = (X86CPUTopoInfo) {1, 1, 17};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
+
+
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {1, 31, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {1, 32, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
+    topo_info = (X86CPUTopoInfo) {1, 33, 2};
+    g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
+
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
+    topo_info = (X86CPUTopoInfo) {2, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
+    topo_info = (X86CPUTopoInfo) {3, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
+    topo_info = (X86CPUTopoInfo) {4, 30, 2};
+    g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
      */
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    g_assert_cmpuint(apicid_smt_width(1, 6, 3), ==, 2);
-    g_assert_cmpuint(apicid_core_offset(1, 6, 3), ==, 2);
-    g_assert_cmpuint(apicid_die_offset(1, 6, 3), ==, 5);
-    g_assert_cmpuint(apicid_pkg_offset(1, 6, 3), ==, 5);
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
+    g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
+    g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
     topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);


