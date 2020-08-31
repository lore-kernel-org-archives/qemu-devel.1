Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3347AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9756F20866
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UZU32BF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9756F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCos8-0000IJ-Ee
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColt-0007MJ-DK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:43:13 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com
 ([40.107.93.73]:31936 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColr-0007YO-Fa
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:43:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emhLceN4EniX7MxCcMx9QfsIa75mGSAuPTgIuNxLQOQqumELM8pAAIULuj25sMLyY1e2q/56c3bB8Yo3w2H5VPIPAo1zrVSDH+kz/vyxU0zFN9IIeTrXc+oyyTJ9rgrSBf8SifG853zkyTj/w03yGwYJd7zkyjk7WQMWOna+3C6nfU7ZxgNixgDDOJMK96aHl73pR5S0/nYdxmEhQUSUl8Fg5fsnrOL1pSjVxrdxP2GZvU3As5VB0/sz5Vcg+uA2lMDuGKchmvn4N8SbeVQcp+fHZr8Ef7t436nMuOmno/Uw5UWq4Jvi2Tmxm81mIL95e6/ZT1R0WyTz6x2LnXkY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDB+aFGQhxsTmPbYoNcSTI+2GoyqdGwkphCHHSzqwms=;
 b=UpgTuW4bLfimZOK7wQoqq5ofw5TOyyC1lruCEsMEyyuXMTqXwaXO/pt7gSDMz60j43ZbwB5i81H+x/n9ptGRSZVRqdtftiEeEBgyMguVgq7ZNHmtjANRbvQdb0jxrf87x20BQ80gQIYQqZ6jPcBCvDADLW85XkRf/nf89BWkfzfH1fqqS4Qc6m1GobXNVn8x80uvBUmH1uQnKz1YEkAI+niyYtpnQbDpWEylhVjrs3U4Ftvtlfp6WUGkpwHO1bBUZc0eHiVmidBfi+Yc00DrPIVz5d10bwrfvszEMmPndP7YRMesf1UC7BSUYKIHZbRlgKODI2Oc5tk/D9v2aGhvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDB+aFGQhxsTmPbYoNcSTI+2GoyqdGwkphCHHSzqwms=;
 b=UZU32BF8upIwOfF/mhxc7cBsVrdiGcVxfzsryku9t7lBJxzyIOa2hr8ylHAwYW1PgPa9mB6qVMxcHKyrxf0FeO46hPE7aBujONBBWOQ9jFjbx1IOojKKAG6pGiXbm1UYCDcDb2mFZkie4Yw3qk9KZKiMrTopY8zdMQgqj1oAZ3o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 18:43:09 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:43:09 +0000
Subject: [PATCH v6 10/10] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:43:07 -0500
Message-ID: <159889938728.21294.12746724309255308236.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0055.namprd07.prod.outlook.com
 (2603:10b6:5:74::32) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 18:43:08 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7aff72f6-1e80-43f4-dae5-08d84dddb4e0
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43836D18221027728F8F6AB995510@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S109gnlkGiCg0FcRHmnbntX6gygULxuo95B/qgXJHtGog+JgoynEXBqQsonGAwt4gQhZOmgszPgA+H9h1lAvN3qpbM2uph+f5Z/JkG6vkDQzc0WHQrF1cQq83WN8AVljb/VMj063SHu2JOKJeiy+ktJfiQ2i0w45h3xdAgn5WiNKIH9U2Be7gQiGQK/IFLsZQFO5SmTrvsqYCKu+25yeAvOTsicvSCV6jvYM49CgdxRCwZ88REK7WmyvWQ1VANwCzfvjwNugHFbjkioEBJfpjMUzXRKiHGdmiAVVHaj5VGrS4mETpXQWfF+PxgiS+i8ZqtYNQKCdw5o/qD8B247bwHMXjWbqNFweoVT6+DfpaSoOLcwyTZ73Kg3Ek1DOmAOC8yA86LgEA0EJbPvIW5rF9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(316002)(2906002)(26005)(66556008)(478600001)(6486002)(4326008)(186003)(956004)(83380400001)(8676002)(66946007)(86362001)(5660300002)(52116002)(103116003)(8936002)(66476007)(966005)(16576012)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Ey5SG05uCzn4M479Sdd/rdyzDi2WC9bS2kM1pWfaM+7c/bmTe9Xrr4GK0v5mNdsxzfQTeQ7Q+N+Mc0eXcxGu+k3ygdfthDCOUW8nsXOoB6JNTuWStvCXuhz5EdOZYSZ3nl4lTfAIN8EHV7DwTFeBqwAvZucsWEXMSlRAjm4r2eH9ZFZvbWjBbizjADD1jfqTEVfJuI8r8QlSVyCQK54EgAKSH2vJ99Eo8NTOiJX3OL7+aADngTb4G/jhxUFSwbvvddKMI9iRZDxlI4kjFe2a2CsqcwNRmL9HRg62DF5h63bZweVf1K+mqVkBt07PXjcgJ/rAH0UZ7+Z4GQ1UtK8d2Byj2q16zzChvhLH5Zziuc8/Q+GJS9GOqNdI8U/xX7X4t59LzjoTQHQhJZMrQIBL/PQR79ULc+Y+3JMw0CHMSXDA3v8hJsEbhA4LyTMuqNKShO28IbKCQVjrIDAiKgRHwfFUONBadq68IaspCEfpXB7Uy2aMT+islyWdI82ze9jRNRbzaOrJYuTlso3dpMt+Kiuvqa1qkBiwn6zTTLViGuCDCrib+bU1+IK4uGNdonFcJqIQDhjY6B4wzGuGMLI7UbyrcPgKi258b4ivtQOnAOgK2I31I4A2OQyK1BVfuAvBbewYBcniKZxHNiIqtD/Mzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aff72f6-1e80-43f4-dae5-08d84dddb4e0
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:43:09.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7VnlOYsiuP6PXochLnt6uMBpQAkgQIxEy63uGGs/2tmUd2/You6/5OYvHvx+/kN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: none client-ip=40.107.93.73; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:43:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

apic_id contains all the information required to build
CPUID_8000_001E. core_id and node_id is already part of
apic_id generated by x86_topo_ids_from_apicid.

Also remove the restriction on number bits on core_id and
node_id.

Remove all the hardcoded values and replace with generalized
fields.

Refer the Processor Programming Reference (PPR) documentation
available from the bugzilla Link below.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |  195 ++++++++++++-----------------------------------------
 1 file changed, 45 insertions(+), 150 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d434c8545a..ada9ec8f3a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -338,62 +338,6 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     }
 }
 
-/*
- * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
- * Please refer to the AMD64 Architecture Programmer’s Manual Volume 3.
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
-    nodes = DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
-
-   /* Hardware does not support config with 3 nodes, return 4 in that case */
-    return (nodes == 3) ? 4 : nodes;
-}
-
-/*
- * Decide the number of cores in a core complex with the given nr_cores using
- * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE and
- * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
- * L3 cache is shared across all cores in a core complex. So, this will also
- * tell us how many cores are sharing the L3 cache.
- */
-static int cores_in_core_complex(int nr_cores)
-{
-    int nodes;
-
-    /* Check if we can fit all the cores in one core complex */
-    if (nr_cores <= MAX_CORES_IN_CCX) {
-        return nr_cores;
-    }
-    /* Get the number of nodes required to build this config */
-    nodes = nodes_in_socket(nr_cores);
-
-    /*
-     * Divide the cores accros all the core complexes
-     * Return rounded up value
-     */
-    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
-}
-
 /* Encode cache info for CPUID[8000001D] */
 static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        X86CPUTopoInfo *topo_info,
@@ -434,107 +378,58 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
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
- * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE)
- * right now. This could change in future.
- * nr_cores : Total number of cores in the config
- * core_id  : Core index of the current CPU
- * topo     : Data structure to hold all the config info for this core index
- */
-static void build_core_topology(int nr_cores, int core_id,
-                                struct core_topology *topo)
-{
-    int nodes, cores_in_ccx;
-
-    /* First get the number of nodes required */
-    nodes = nodes_in_socket(nr_cores);
-
-    cores_in_ccx = cores_in_core_complex(nr_cores);
-
-    topo->node_id = core_id / (cores_in_ccx * MAX_CCX);
-    topo->ccx_id = (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
-    topo->core_id = core_id % cores_in_ccx;
-    topo->num_nodes = nodes;
-}
-
 /* Encode cache info for CPUID[8000001E] */
-static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
-                                       uint32_t *eax, uint32_t *ebx,
-                                       uint32_t *ecx, uint32_t *edx)
+static void encode_topo_cpuid8000001e(X86CPU *cpu, X86CPUTopoInfo *topo_info,
+                                      uint32_t *eax, uint32_t *ebx,
+                                      uint32_t *ecx, uint32_t *edx)
 {
-    struct core_topology topo = {0};
-    unsigned long nodes;
-    int shift;
+    X86CPUTopoIDs topo_ids;
+
+    x86_topo_ids_from_apicid(cpu->apic_id, topo_info, &topo_ids);
 
-    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
     *eax = cpu->apic_id;
+
     /*
-     * CPUID_Fn8000001E_EBX
-     * 31:16 Reserved
-     * 15:8  Threads per core (The number of threads per core is
-     *       Threads per core + 1)
-     *  7:0  Core id (see bit decoding below)
-     *       SMT:
-     *           4:3 node id
-     *             2 Core complex id
-     *           1:0 Core id
-     *       Non SMT:
-     *           5:4 node id
-     *             3 Core complex id
-     *           1:0 Core id
+     * CPUID_Fn8000001E_EBX [Core Identifiers] (CoreId)
+     * Read-only. Reset: 0000_XXXXh.
+     * See Core::X86::Cpuid::ExtApicId.
+     * Core::X86::Cpuid::CoreId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:16 Reserved.
+     * 15:8 ThreadsPerCore: threads per core. Read-only. Reset: XXh.
+     *      The number of threads per core is ThreadsPerCore+1.
+     *  7:0 CoreId: core ID. Read-only. Reset: XXh.
+     *
+     *  NOTE: CoreId is already part of apic_id. Just use it. We can
+     *  use all the 8 bits to represent the core_id here.
      */
-    if (cs->nr_threads - 1) {
-        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
-                (topo.ccx_id << 2) | topo.core_id;
-    } else {
-        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
-    }
+    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.core_id & 0xFF);
+
     /*
-     * CPUID_Fn8000001E_ECX
-     * 31:11 Reserved
-     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
-     *  7:0  Node id (see bit decoding below)
-     *         2  Socket id
-     *       1:0  Node id
+     * CPUID_Fn8000001E_ECX [Node Identifiers] (NodeId)
+     * Read-only. Reset: 0000_0XXXh.
+     * Core::X86::Cpuid::NodeId_lthree[1:0]_core[3:0]_thread[1:0];
+     * Bits Description
+     * 31:11 Reserved.
+     * 10:8 NodesPerProcessor: Node per processor. Read-only. Reset: XXXb.
+     *      ValidValues:
+     *      Value Description
+     *      000b  1 node per processor.
+     *      001b  2 nodes per processor.
+     *      010b Reserved.
+     *      011b 4 nodes per processor.
+     *      111b-100b Reserved.
+     *  7:0 NodeId: Node ID. Read-only. Reset: XXh.
+     *
+     * NOTE: Hardware reserves 3 bits for number of nodes per processor.
+     * But users can create more nodes than the actual hardware can
+     * support. To genaralize we can use all the upper 8 bits for nodes.
+     * NodeId is combination of node and socket_id which is already decoded
+     * in apic_id. Just use it by shifting.
      */
-    if (topo.num_nodes <= 4) {
-        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
-                topo.node_id;
-    } else {
-        /*
-         * Node id fix up. Actual hardware supports up to 4 nodes. But with
-         * more than 32 cores, we may end up with more than 4 nodes.
-         * Node id is a combination of socket id and node id. Only requirement
-         * here is that this number should be unique accross the system.
-         * Shift the socket id to accommodate more nodes. We dont expect both
-         * socket id and node id to be big number at the same time. This is not
-         * an ideal config but we need to to support it. Max nodes we can have
-         * is 32 (255/8) with 8 cores per node and 255 max cores. We only need
-         * 5 bits for nodes. Find the left most set bit to represent the total
-         * number of nodes. find_last_bit returns last set bit(0 based). Left
-         * shift(+1) the socket id to represent all the nodes.
-         */
-        nodes = topo.num_nodes - 1;
-        shift = find_last_bit(&nodes, 8);
-        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift + 1)) |
-                topo.node_id;
-    }
+    *ecx = ((topo_info->dies_per_pkg - 1) << 8) |
+           ((cpu->apic_id >> apicid_die_offset(topo_info)) & 0xFF);
+
     *edx = 0;
 }
 
@@ -6019,7 +5914,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(cs, cpu,
+        encode_topo_cpuid8000001e(cpu, &topo_info,
                                   eax, ebx, ecx, edx);
         break;
     case 0xC0000000:


