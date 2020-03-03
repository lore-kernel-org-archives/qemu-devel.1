Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E192C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBBE72073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ysFeUwh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBE72073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DkD-00086I-2Q
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfz-0001QX-IG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dft-0003Dl-PH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:59 -0500
Received: from mail-eopbgr680058.outbound.protection.outlook.com
 ([40.107.68.58]:13380 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Dft-0003DV-Ic
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmO9ZeXWjEDr1jOlLZrvEDAJlF1jf+cRFGX72ivVpgwQU7FTUilU0rssF8JAojWDsrDcRSQfnkM/3MzkJkeo3Zxt/0jY4RBWJ6dxO6FwBEJW4/w2V/gt4RZ3ItN+N2FXYI5HfKvnjWcDGp7Z1IN+ekoqaio2l+55PyRxetVfc3ZBdrr8fmVNdWwgKP4pZQ2Lo+ycwwLiZP5bmzgvAqS8Yt5cQFEr09f8KFENXc8NOghnxBbXg8XcaXqrw4JhpNclGepwWna5FJmapiHjEFrUNJGnrGQk5wMc8iq973HRaqErvEuYMmKtbb7aCTQIFsjyeG1Oba7Z217pKeR46wySuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfC1sh24BhBwezs8E2nL/ruyPoX/4dpi7o+Z+JRXd6w=;
 b=RD4sHeNzEJ7qwHbQfkbf92DsSgDRdM9gJ7KZ/9WhRd6JhCC7ADSEMPQWu0r4E1kyzpDdd5nhfCQNUuPIalotU//Jaqk0zVhPSJwum8oEGPHC+Ap2iO2+mK79acNflBXf8raA5NpHIFGza5doL2TR8qsDk5WEdPmczjjg47s1UV+cGcL8JSkSStauib/DErXJdyA6TQWqAe1sodz9de9oOa5JlkNHSKh6K5XrvOKuSkbkMHqDZ1f+Rjjc6rvTtj5WLY6GwQDszZJrKcZg+BxrjkYl8+Q9vvTphtA4PwG8UaRhAlE3CaitzSKK63avpbLEDdaFYAc1IOcrz9s0d9lwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfC1sh24BhBwezs8E2nL/ruyPoX/4dpi7o+Z+JRXd6w=;
 b=ysFeUwh3XScqm0x+WESMObNhJO/OYkAn997nIlyHeI8sBs8jI7y7i5qAcR/0fkyM3MkCjmWqbrklhJ79Tg2RetLKutb8QAYlU4l0OO93pTvntT10u6LgNHqp38pXVCXI09MYrcwchL4Sa1iWoQqRca2NxEmL1dEKx2ZcuD60u6s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:51 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:51 +0000
Subject: [PATCH v5 09/16] target/i386: Cleanup and use the EPYC mode
 topology functions
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:49 -0600
Message-ID: <158326546983.40452.10693492138041061735.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:5:74::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16 via Frontend Transport; Tue, 3 Mar 2020 19:57:50 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1c602cb-f0e8-4e18-9026-08d7bfad27b8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573F0A43BBE8342DAD1757995E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
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
X-Microsoft-Antispam-Message-Info: 6x8oZPDUw8pGLp77LBw50l+RsuFf3zFXJH7BtwO785zo3YOEM7JPYqf7hL2UNPPUoW2cRXY0p+FLeRPLsX9a9ndroJzq1QJqy1FzLikujvrigaR04ye/23139YqXJaw/lAqCkrQEKLspcWd+ueZnCXuke2h57O2nAMI3GNN87GIH111oPxg7OMAlxjcUvM6k+679P7qbCBXV6FZ4xWSYLcjPK9RxUtzDO5u/9lCD746iyDUeTbJl1MWRbhvt0j3GDPjUiyj79AtggL2TUceQAVxCsebgMkA/jWDcppI4ajLLBWIYjMayUAvLahI0hcgo1mM0DOq/Dyo0hcp1l2Uw/cBdb+1SuZYvkNbaEqmCNgD+yDl4+E/jPI0by8Ux6emvr2E6JT6ubJoCOX4EoXuQRwCyZlIHKeqhJoaXnswDRpMoPigJMB1SDv3AIDYAi2SD
X-MS-Exchange-AntiSpam-MessageData: yDs3lVryNF8/rKOYUzw4Ae4Vlh0IuIh5sPkCjk5mwNtHao9tNdMi+dfBzPthiYsdmHa7Z1ZD6Lq4xsedUeI3QSDmIr+uXsfjkvL24/aGSAJOSdy65+o7eOwzfxzFknjANqNbPMVEu6/9bIigodtB1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c602cb-f0e8-4e18-9026-08d7bfad27b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:51.4897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hqsyc2kmQAwyVBE23p2w2J9aCL6QbMwNfy8hPw7AfCbrAy73eMeC9WJoveQwNRBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.58
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
index 40670f8aca..c75cf744ab 100644
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
@@ -5371,6 +5279,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
=20
+    topo_info.nodes_per_pkg =3D env->nr_nodes;
     topo_info.dies_per_pkg =3D env->nr_dies;
     topo_info.cores_per_die =3D cs->nr_cores;
     topo_info.threads_per_core =3D cs->nr_threads;
@@ -5790,20 +5699,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index=
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
@@ -5812,8 +5721,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, =
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


