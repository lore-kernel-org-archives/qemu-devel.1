Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7C2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21B721734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EaT/W/K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21B721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JDP-0007Db-6z
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3L-0002Wk-RU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3K-0008FS-2B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:31 -0500
Received: from mail-co1nam11on2082.outbound.protection.outlook.com
 ([40.107.220.82]:60704 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3J-0008CU-Ox
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYqpKbYqE0ddJiGiEafPjZf03YehmMWrrv/5B0Idc45y6ynPjKSQiClZ6XC1yjw9BGTsi19J8lzr2zSf3n/4r0YBu1hyyYJkk+Pa9A8C1Je08ELm0yQVvh+rcHuiqtkYC1AOTZH1OHDY7+1oX9nGNRLtVlW8VW1DEnUT1MffjAq5sEP1IT5vICKn0JE1Di3c+VUMNFQyGxTr5wHxR8IeKcZbl97UQFsmtBjm9XlRPdIuoN5oqgeDoPZQby4Cq2v4Xx/8yo0Pt/Ap8kNpfQdBfgAaZQS6KwS7IAHbPMOjpzt3vQOnQXrGd28KW2IhM782zY1WLtOTCNaHUbfCYakXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lj0xAV0OSpwF91Oj04PV0bSv6tunIRZzCxDcQahcE8=;
 b=VzQrM0eOwqJ0OqNhR1s61v0lzRuhWYF92RcMOIRNjJLhhD38l2Hm+D/Uv7FbvCy8o7A9JQuCHGghR22MNVROFDNFZWL+YJxdpPNDkw9Q53Hz67PbNgG/fYwK2FYzRGOLcU+yOCQJTuzQH3jHZx6TwVDmMDHQNL1lY7WFYNKRDzTQ+Hv8wRr4+//r958dJ/21wvLp/StzfJezljpVaR1JIdk2iEiP1CFL5AHghMtF47aO4MUe8XARBkFrGwpNC1go5MayQit94bQ5VBkmCaAWe5ZjVqQg7hh4UXbWGbo7X4AE4l0bDujOcxbo5vxdLdQ+9+2W1tOtWPl575Zk8Imshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lj0xAV0OSpwF91Oj04PV0bSv6tunIRZzCxDcQahcE8=;
 b=EaT/W/K3gB0Sp3ea5IHDkM+vf4RZ5ULzOHw8dO3nXfaBSKQVVHpAB2MoR3OFQ1goy23zDkol15hOtEEUaPGr0oscJXqzBG6gQWLKAG2dB3lglN+m0AMFIcq//dZUXFTdcEp6Ojr2BIIk78BJ7Sif2+BMwxxTBM6YLLfxgr5xnaU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:27 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:27 +0000
Subject: [PATCH v4 09/16] target/i386: Cleanup and use the EPYC mode
 topology functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:25 -0600
Message-ID: <158161784564.48948.10610888499052239029.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN6PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:805:66::39) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 18:17:26 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3e51231-c6ff-4745-c6bd-08d7b0b0fb21
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318F88A4105176FE98FEAF6951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
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
X-Microsoft-Antispam-Message-Info: YipMIKRuEVt7cE7nG8t0AJdVNfJ9BldWyGeHz4QZRYhzwGU1QoxuZEkSXyD4V5soXTi3ZQpN74WyIM6UBKt8KSIN2i8PDbM1jSmJb7nW1XrGoSoOOej4zf+qszlMTv4CffnCDkxCASH/UIJ4KN7s80Gq6Ukmq6kFI2fZQhICI4WcLiKTimqG1m9GLOW+CLOznKklaJJLTbUh/7AnULnNYtvv7dHGqQzAhBSnBcr5en0D6SDH3ba7QNv29TNg241o6Mn2zzKaMFCLZDZ1kotfjLfYMqEGpupqHrpp8kPGD59l0JGM+9TYFqVh2lRkgycJ8Pesu27LncgoJupmr+OUDGzqO3stASGL/CshSEx+zuHsvQ/s4RFzf3QvgxPxSZ/L88ds+XgBr68VwrN+pZm4YE59pmGqdBMy+1rZRcqfGQRTId506AliqmOuKxBd34IF
X-MS-Exchange-AntiSpam-MessageData: pfirflFwcjgyNSRB0BpmynG+V+QOdptZ9+oB2BAlLd50+8mcuks1DvdfzMfc9wTtFCF/Mu3yyImPoBmGE74e7eaP3h+lxSj223oM5k5rW4IKH6yzgRC4Z8MnIAlw88nK6WIn+6nKzw2uGR229R4ojw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e51231-c6ff-4745-c6bd-08d7b0b0fb21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:27.1821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYrmspCN2iGCZiHUbf44bOVzqhdubmgKy4k0S2BUwD1lj0d/rTdEp/QedLcJAaiP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.82
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

Use the new functions from topology.h and delete the unused code. Given the
sockets, nodes, cores and threads, the new functions generate apic id for E=
PYC
mode. Removes all the hardcoded values.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |  162 +++++++++++--------------------------------------=
----
 1 file changed, 35 insertions(+), 127 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5d6edfd09b..19675eb696 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -338,68 +338,15 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *=
l2,
     }
 }
=20
-/*
- * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
- * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual Volu=
me 3.
- * Define the constants to build the cpu topology. Right now, TOPOEXT
- * feature is enabled only on EPYC. So, these constants are based on
- * EPYC supported configurations. We may need to handle the cases if
- * these values change in future.
- */
-/* Maximum core complexes in a node */
-#define MAX_CCX 2
-/* Maximum cores in a core complex */
-#define MAX_CORES_IN_CCX 4
-/* Maximum cores in a node */
-#define MAX_CORES_IN_NODE 8
-/* Maximum nodes in a socket */
-#define MAX_NODES_PER_SOCKET 4
-
-/*
- * Figure out the number of nodes required to build this config.
- * Max cores in a node is 8
- */
-static int nodes_in_socket(int nr_cores)
-{
-    int nodes;
-
-    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
-
-   /* Hardware does not support config with 3 nodes, return 4 in that case=
 */
-    return (nodes =3D=3D 3) ? 4 : nodes;
-}
-
-/*
- * Decide the number of cores in a core complex with the given nr_cores us=
ing
- * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE an=
d
- * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
- * L3 cache is shared across all cores in a core complex. So, this will al=
so
- * tell us how many cores are sharing the L3 cache.
- */
-static int cores_in_core_complex(int nr_cores)
-{
-    int nodes;
-
-    /* Check if we can fit all the cores in one core complex */
-    if (nr_cores <=3D MAX_CORES_IN_CCX) {
-        return nr_cores;
-    }
-    /* Get the number of nodes required to build this config */
-    nodes =3D nodes_in_socket(nr_cores);
-
-    /*
-     * Divide the cores accros all the core complexes
-     * Return rounded up value
-     */
-    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
-}
-
 /* Encode cache info for CPUID[8000001D] */
-static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
-                                uint32_t *eax, uint32_t *ebx,
-                                uint32_t *ecx, uint32_t *edx)
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
+                                       X86CPUTopoInfo *topo_info,
+                                       uint32_t *eax, uint32_t *ebx,
+                                       uint32_t *ecx, uint32_t *edx)
 {
     uint32_t l3_cores;
+    unsigned nodes =3D MAX(topo_info->nodes_per_pkg, 1);
+
     assert(cache->size =3D=3D cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
=20
@@ -408,10 +355,13 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *=
cache, CPUState *cs,
=20
     /* L3 is shared among multiple cores */
     if (cache->level =3D=3D 3) {
-        l3_cores =3D cores_in_core_complex(cs->nr_cores);
-        *eax |=3D ((l3_cores * cs->nr_threads) - 1) << 14;
+        l3_cores =3D DIV_ROUND_UP((topo_info->dies_per_pkg *
+                                 topo_info->cores_per_die *
+                                 topo_info->threads_per_core),
+                                 nodes);
+        *eax |=3D (l3_cores - 1) << 14;
     } else {
-        *eax |=3D ((cs->nr_threads - 1) << 14);
+        *eax |=3D ((topo_info->threads_per_core - 1) << 14);
     }
=20
     assert(cache->line_size > 0);
@@ -431,55 +381,17 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *=
cache, CPUState *cs,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
=20
-/* Data structure to hold the configuration info for a given core index */
-struct core_topology {
-    /* core complex id of the current core index */
-    int ccx_id;
-    /*
-     * Adjusted core index for this core in the topology
-     * This can be 0,1,2,3 with max 4 cores in a core complex
-     */
-    int core_id;
-    /* Node id for this core index */
-    int node_id;
-    /* Number of nodes in this config */
-    int num_nodes;
-};
-
-/*
- * Build the configuration closely match the EPYC hardware. Using the EPYC
- * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_=
NODE)
- * right now. This could change in future.
- * nr_cores : Total number of cores in the config
- * core_id  : Core index of the current CPU
- * topo     : Data structure to hold all the config info for this core ind=
ex
- */
-static void build_core_topology(int nr_cores, int core_id,
-                                struct core_topology *topo)
-{
-    int nodes, cores_in_ccx;
-
-    /* First get the number of nodes required */
-    nodes =3D nodes_in_socket(nr_cores);
-
-    cores_in_ccx =3D cores_in_core_complex(nr_cores);
-
-    topo->node_id =3D core_id / (cores_in_ccx * MAX_CCX);
-    topo->ccx_id =3D (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
-    topo->core_id =3D core_id % cores_in_ccx;
-    topo->num_nodes =3D nodes;
-}
-
 /* Encode cache info for CPUID[8000001E] */
-static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
+static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *c=
pu,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    struct core_topology topo =3D {0};
-    unsigned long nodes;
+    X86CPUTopoIDs topo_ids =3D {0};
+    unsigned long nodes =3D MAX(topo_info->nodes_per_pkg, 1);
     int shift;
=20
-    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
+    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
+
     *eax =3D cpu->apic_id;
     /*
      * CPUID_Fn8000001E_EBX
@@ -496,12 +408,8 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X8=
6CPU *cpu,
      *             3 Core complex id
      *           1:0 Core id
      */
-    if (cs->nr_threads - 1) {
-        *ebx =3D ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
-                (topo.ccx_id << 2) | topo.core_id;
-    } else {
-        *ebx =3D (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
-    }
+    *ebx =3D ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id =
<< 3) |
+            (topo_ids.core_id);
     /*
      * CPUID_Fn8000001E_ECX
      * 31:11 Reserved
@@ -510,9 +418,9 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86=
CPU *cpu,
      *         2  Socket id
      *       1:0  Node id
      */
-    if (topo.num_nodes <=3D 4) {
-        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
-                topo.node_id;
+
+    if (nodes <=3D 4) {
+        *ecx =3D ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.no=
de_id;
     } else {
         /*
          * Node id fix up. Actual hardware supports up to 4 nodes. But wit=
h
@@ -527,10 +435,10 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X=
86CPU *cpu,
          * number of nodes. find_last_bit returns last set bit(0 based). L=
eft
          * shift(+1) the socket id to represent all the nodes.
          */
-        nodes =3D topo.num_nodes - 1;
+        nodes -=3D 1;
         shift =3D find_last_bit(&nodes, 8);
-        *ecx =3D ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift +=
 1)) |
-                topo.node_id;
+        *ecx =3D (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
+               topo_ids.node_id;
     }
     *edx =3D 0;
 }
@@ -5318,6 +5226,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
=20
+    topo_info.nodes_per_pkg =3D env->nr_nodes;
     topo_info.dies_per_pkg =3D env->nr_dies;
     topo_info.cores_per_die =3D cs->nr_cores;
     topo_info.threads_per_core =3D cs->nr_threads;
@@ -5737,20 +5646,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
-                                       eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
+                                       &topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
@@ -5759,8 +5668,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <=3D 255);
-        encode_topo_cpuid8000001e(cs, cpu,
-                                  eax, ebx, ecx, edx);
+        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
         break;
     case 0xC0000000:
         *eax =3D env->cpuid_xlevel2;


