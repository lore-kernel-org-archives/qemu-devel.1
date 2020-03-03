Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C62C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA9B2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yRuWQA8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA9B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dgd-0002Ba-7x
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfI-0008E3-KV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfH-0002wj-1m
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:16 -0500
Received: from mail-eopbgr680046.outbound.protection.outlook.com
 ([40.107.68.46]:6446 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DfG-0002wQ-SG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0dQKXHq8e80lDmt0xVNnpMavfWS3ySb/TQ2g8T0dUUs65X0y9W0otwdvdcaF7kDyWYA/qqhc0SeMoZtSBA2F7vsT6RK6ZSSDQ3PTx1I3032T9G8SL6TLBsOZvr3ej/2e+8/18vlBIgV66fsUwLrV0JHCygven9IWsUok9/Aht0e8S9tjqAQcYWPdCRU0oialErGFHShEMm58+20wgRnDMuehHqV2DxUbZ26LwLXxCPrXQZM0Monh8owTk9NsdZdeVmDW8nmiwQdz7ELbbpoCxndhoppOyIG6KAtmfakGj1olJJdGNHjtfAjO/2FPuHlJjK+m6RQT2YLAKpy2F8D/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd27KtSeSVoX2w30gqahJo34DlLFxc/0r5KcA6+kKVU=;
 b=lpq8HHqsonkFJRS/n++GrQSyZtHI6ESoTmW7Khnq/vDywho+53m39L0RJSiK82EokKii87Q1QSpNRIDxtKFkTwymOnXEL1HnxdFzl2iIE0Rmj7dEWEQFW7bJAMKpOAajHpXuoSOQdJLSMDF8FDt+JyYSMcnPZuOyF/sz3lI+wjKffGgo2VvpWgdQ/TxdES95VabAkfv2QEM6PH/0CRPAxJBM2M1TNVkR19reABjUVLVo/vFEPIFvbCWSorSrY/ISFlkbhfA4WsVEspcVXn6uY1zu/Lcu74080SAjO1PkEg7KwXqrz6rY7BJb1lTXFoCXFAlei6BKOo64RpFt/dyaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd27KtSeSVoX2w30gqahJo34DlLFxc/0r5KcA6+kKVU=;
 b=yRuWQA8IYFm+/7DXFLV5GVg03j1uunVuflREa/A53Ay/+D958nOguJdebwd8CDxLK1vT2nqIRuImWQa6kJcJV50ZYT+F+zrTP9PYqkylxx/cb1LiLCrsiIXAFk7BJ4nBjzVsKcpI+mG9e6QBOaJy5zqWzAsR02/ZTLJ1VQTxbvQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:13 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:13 +0000
Subject: [PATCH v5 03/16] hw/i386: Consolidate topology functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:11 -0600
Message-ID: <158326543195.40452.7437947098625099601.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:805:66::29) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0016.namprd08.prod.outlook.com (2603:10b6:805:66::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19 via Frontend Transport; Tue, 3 Mar 2020 19:57:12 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1490c453-3098-43e2-e81e-08d7bfad10cd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25737553B0A9431DF640FE1495E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aAWSJ8XQFjBvdJJVAhTU0zU34gab2o6JD7ZE3n+KOMWAiPGj8u7fTbEhx7Pjct/Ype7hSSkW1dkCyXt/y9L7jy8woSnFZ3BO1OiqXSWvpwk9jOZw0oAWzh2sUSreVW3DIVan+jzdeuSu/I9mdlXSM6LkiFj81fyygYv/4tRIbA+1InWXQsc9/lU7a6HAevORFoDxGZUbgl1Mbvuj8j9PcBz+IF0rjJV8d81h4oXwd9NM+SFMXUxt4QyYnUCVP/YxR/LIGUw+ADcLj5aUEljTuvH83aWgo4lbucoDcxEQLMFDYJfEMZoOCRCpPu1znIIlhdoJaYdG5zfD0kl++kFg1x6ZLvXylmdthQq91OA8RUP1TtxEW9X+d5IgoDOv+IWCd21QFsUm4852+emK1J0D91eW/AfhtFyaB4u3luhXJOA82BOsuZPhu0afAD6N16nY
X-MS-Exchange-AntiSpam-MessageData: rbF6VwWzGfLyuhg9RXslOmoJCFVqjzyV2EmS0zZPfBlDBBlZUFktd9kjSV4BilRajD639cwAJA3tJwxir2OUtkP6ZiyAsu4YGKOvGORzrmZUTWgV5VBQN1T1flr9SlCnEnCkbGK2MOoXZANTRBSxQg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1490c453-3098-43e2-e81e-08d7bfad10cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:13.0040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OixT6bM48tCVQgoz/z3UqM2WTpWx0jkpKnE8EfVDSp8d885EWEa3dpvpuWHwadHY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.46
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
---
 include/hw/i386/topology.h |   68 ++++++++++++++------------------------------
 target/i386/cpu.c          |   23 +++++++--------
 2 files changed, 32 insertions(+), 59 deletions(-)

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
index 92fafa2659..1263271edd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5369,6 +5369,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -5455,8 +5460,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset = apicid_die_offset(env->nr_dies,
-                                        cs->nr_cores, cs->nr_threads);
+                die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << die_offset), cs->nr_cores,
@@ -5547,14 +5551,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
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
@@ -5578,20 +5580,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


