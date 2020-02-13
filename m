Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A995C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E98A206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GgAaEYvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E98A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J4R-0003XC-In
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2f-0001W5-TE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2e-0006nP-1N
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:49 -0500
Received: from mail-bn8nam11on2074.outbound.protection.outlook.com
 ([40.107.236.74]:6088 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2d-0006la-RA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWjT6oM4+Dv5YQUdE4QLYPdRJIFYgH5afRax/p7JmnXH6wIzxuz+Rya8nRp9G5sMroQvJr1lGRAQ3A0KSp8aakssop9pKTLYo9RF3sDyIrziEH3XqQ1dRcQ+uuV3Q1LoExscRxoeChDu/KxQhB21Uh9UitmG/NegKYx47UehA1+DCRiclOTIZ6BtsuR74ANEVltVPo+/vd6k5FdoxkOY49tjkAXrUpF2grlGMbLeRCp3koZB8yKdv/2Zu/vh77s5eZ6sppYMfCp8qsTuKf03fCtsaxhwYJMgEsUEq9JAQcMSaB4Zo0uDsvT/+0+9BABPN9z7uu3eL0qfVVESiqWRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HeXIHxwtuh4qWcS4pltITffarHfzAf3J7Bo6jHNheU=;
 b=Sj4+HouRYTMKneQ1678XKWUDORgkbL3LY72Y2CWaDypSk6+4Jvcj/1PzxaZ91C31gHYppfO47a3IPhGGQc6kSp6bNVvM0jQQApXypW4Qpcwo2yVd0wAN1pvy1XOzsadjweEpjTbVq5vM0ZHTjx4TtoxQ4AzAMLOeDn5U2cfn81Vn+I1EOabEVAd49jspAz2ua6r67U2hK+MNqnn9XxPnzqydd9pvY+LUSoFU3evEa3Z5Wuoq/6E5EzrYJBoSUv7IwmNkiKl/8KEeERuiGnelhqbcH/D2wbAZDHnMk2fof23wU38AEgTYX79Pk7r0cRdekfGTX71l65DvhGfI/mtpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HeXIHxwtuh4qWcS4pltITffarHfzAf3J7Bo6jHNheU=;
 b=GgAaEYvSrH8Qayn+Oxw3bNtH2OI9k2Ax/5aBSJn99HOPQA08sbn7iMGUgz6D+B6jnQ4wJJQgvHlPWNMTt5EcdNEAiz/H6TnutNGR5axsr8UmidjBVyGS1gQkftZ4FEf2kzjU2tzqabUzNu8oFc3+2ZUpwjS3Q3zsq5BgOlVrE4o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:46 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:46 +0000
Subject: [PATCH v4 03/16] hw/i386: Consolidate topology functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:44 -0600
Message-ID: <158161780451.48948.17670134135373550954.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:805:66::32) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 18:16:45 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fdaf45b-aa2c-4558-b72e-08d7b0b0e28f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318C2991481DC1B2B0FD41F951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YW3rCrEdc/3pJaFHqE7eUXTFvvtD4rmyVnDd2QJSrNSgDovlEwp0Do0CqZrzFbjo8g6NiaFJKGf891gls2q+03wewJSo+8NUcYgtbPafExY/VDMp/2yVTCEDOSQpuu0oE7pgD7la03yKYGUwcxkVD3Ziyo/3iBtEVANJ8KrvFvN3pC7wdfN45mIGKijxLNU60e4xqAc1E3b8NNA08Fft6pr3L8D0bIvBN0LvLLArT0QSyquWdN6UoB5uRKsyrOIOlPTmVtPIH/CxiUPly/Yf4KGRIIlO6Wu0A81X2dP4DfrAdSmh63i0hFcNFl+j5hbrKh00owUcRmO/k4SsVCSj8nrZF1HGXXV7WCC/hUd2LTYcs27/MsvAzhKO8ERH5NM/Y95AkVDnTJvWSm0/CqFjE0Dz97fHTRy9M64FhOuvmuSmBCeS7OpGZZfPqvy+Ogk/
X-MS-Exchange-AntiSpam-MessageData: kylVbY6Jh0i3EOPsx5VPpDCNP+ko9mX15PSIT8SZUjDFX8zUJF55DPk6+WwWSAG2c4s1tISxVIRsQf4WTDtX+KQC/Jd3sg5V+vTO6nu4bKMtpeGhqZQ7p2tcJwA2AK3Un0CxOmXsVyLc62EUshLliQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdaf45b-aa2c-4558-b72e-08d7b0b0e28f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:45.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ndQWLiwaHnpA9UgI/welMORmy3t6cDL/5cBaWcQxhzxmpAyzP40PzJuqf7qaXZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.74
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
 include/hw/i386/topology.h |   64 ++++++++++++++------------------------------
 target/i386/cpu.c          |   23 ++++++++--------
 2 files changed, 32 insertions(+), 55 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index cf1935d548..ba52d49079 100644
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
@@ -128,13 +114,9 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
 static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids)
 {
-    unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
-    unsigned nr_threads = topo_info->threads_per_core;
-
-    return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+    return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
 
@@ -162,19 +144,15 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
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
-    topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
+            (apicid >> apicid_die_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
+    topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba5e9d5d6b..7e630f47ac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5316,6 +5316,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
@@ -5402,8 +5407,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset = apicid_die_offset(env->nr_dies,
-                                        cs->nr_cores, cs->nr_threads);
+                die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << die_offset), cs->nr_cores,
@@ -5494,14 +5498,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
 
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
@@ -5525,20 +5527,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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


