Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A119BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BF3206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MBZj++Hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BF3206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8g0-00035y-D4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8fC-0001Pw-CY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:38 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com
 ([40.107.243.59]:34589 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kD8f9-0003bQ-Vb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IysgA0q/XVxOkzebVbxDmWGyB/023+OGxEXk9yOwhQZUAvM8iVt/brMidNeAKcY2sieuLHAtJQzp2LNAPItxI0X/zny7HbYZtxXfKpfKvLqlB6A2scKg2ymK62mZki4jDqzEprxn6g12Xp6T6wM6Vmd998Ysk1Cucts/xJTnxKNTSLTWSPxlXa0pDnIToO35phZfNFh10ECIkiV3q778tlQHEWLqDlFXLwal9hE3EO6RLpC4Soala1QbGSAxLX8kWUUqHcXt7R017HdzGqt7tDGmDpgH7WQrXWgxXZRHqeL+ddOd16mscwxQMUNegXLYrYMMR7krDNvdMXetkTvRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCNcLOfh6HW2Cj24bHIpjFu97N1DX4GbJOrOCd/QLrM=;
 b=MI3oahhEkhx4dGlNk36K9TWOocfvgiCJfFY4yNYtNxeQivvzj7sYq74I5BQCM6x8jfpXoZsTuy1s39bDkn3OgGimjG0J1wzIHMUx0IBi9WC3ey9vStW0Hl7fRgQ5+JLKsn0a1ojlffWkVz0a+W9s6glYR0iGTgvu4azXEAm9+4eXAZmMmihth5WG8hVD2IcC6zE0kYfjcu6ulh6ZTQpAtVqpsssrWhsD94njHYCBen5MW3AzgozBJoSgbhX0i4G2G6DrhXF/QpFTM9fDA8z1/1pa7N6UXprUhiZwx4wQHWSzW4VvblUFiWXSnwa0lMf/aAgfUsge7j1UR35/Ckv+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCNcLOfh6HW2Cj24bHIpjFu97N1DX4GbJOrOCd/QLrM=;
 b=MBZj++Hq2xdXY1QPdPbRvGGzo5AExdl8jkO8a4bNuyqs+iJbuMpQXmVLQCgEH7fnVRPAt/AdegVG5kvaeupfFLtevPyxH+7jvRPeUuGzCQ8OXV6dnGxp/yGJe01BCrg5n+EFMWVt9uSe18G+oJSdpSB0RYKhFzn4jlTEfWuAdmQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 1 Sep
 2020 15:57:33 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 15:57:33 +0000
Subject: [PATCH v7 2/2] i386: Simplify CPUID_8000_001E for AMD
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Tue, 01 Sep 2020 10:57:32 -0500
Message-ID: <159897585257.30750.5815593918927986935.stgit@naples-babu.amd.com>
In-Reply-To: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
References: <159897580089.30750.12581669374705391794.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.20 via Frontend Transport; Tue, 1 Sep 2020 15:57:32 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b34d0a66-addc-4dc5-9e26-08d84e8fbd0c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4445B37C3BD8943BBBD6510A952E0@SA0PR12MB4445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXJeuvQSxEUtyhepKDftFv4D+nipVlLFpzYtCDFUNMe6KERYlBorj/nF0R/fRQSzDb5fSqRKEWCrgA+eTmjmU/hWTS8FyO9nhQK0znJXwUC0RyeslN4Q+O0xdQkN7XmoUBUWHEQzAeFDBSZycJS5WbeTe0uvbOa4wgoA7BdouKIl7o+AmdSVhCLgULAkh5nXzG1z/R1XGhlhh/FeJHH5hCnOYUGe9Yuh1Lk46r0yNWM5qJKkHumaTQFcVM0eXZTNynPMvpaZUiEWmIoobBpv5swEf+44yiImhFI2jj8RHBsKAoca+R4jmm+ozR+go89GjHdvGNLj6NMl0I+HH+ebFcNHE/YwwlYeP0N4UKue8O0hVjF2AZziTTOAoYZPA4zIyKPI4U0crzLbg73gZLKPKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(103116003)(8936002)(8676002)(956004)(44832011)(966005)(16576012)(52116002)(66476007)(66946007)(66556008)(478600001)(186003)(83380400001)(5660300002)(86362001)(2906002)(6486002)(26005)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L4WHoXb11wq8yRryJJb0pldLKe0K0bfph8RRwKXi2eAZJ7rGuIcDMKPN2BZKxQxri95iR2+5aFr+m39EePP5ShiK2OmP6zZUbWdRY7CYxk37qI66EdEAfroXdgJTZLq2tfPD+C94Ffd+Ivv0Hs51N2529bPMn1uX4hT751e3abFSDZKiLu4jZERkAUAoTxYq0C9Px3dEBUlvI9u6rm5/OV5IVKSwIEoC4l17wbEPvwAmxjG9H8tIpjo/4b0htgkMD1cHlcqb56bQZYQd7JRKOa7WQ5Zalk7gYweSwaz9wwWOt337BxHjTbLamFAv2lk8Cs8CskJR6lvQvXOQx+0tiFqDb9ojd10FQs/u9iCxryDl4d1yp4APzMNtj2j0u8Ob/auT/3sHcKrqLiHDBmUz6oThEBVdVIF8YgAyrMJjBGcnl+lcQIzCbAP3IH7qnySzEmXZZ/ubMBfn9HdZmTDLfxWdbj/VYUCYnuhSqi1IorZjFRSKHF2vpBGb1c1HA3IEXGg35/2wuzJW4sgoUY3Ggmgdf7UsYfNq9gCeHfavdyoAjSM6apGEdifhn0Hq6oHVTaPzpjbPBYnndy4pXGBmPAYMz7V7+/unQxBKoQ+OUeyPd9Ith9cHUfQsrbId3q8xNXgEMvuxpPIJ6l6VwYf7zw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34d0a66-addc-4dc5-9e26-08d84e8fbd0c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 15:57:33.4184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN+CKCHpO50ieU9wXgyl9335YGPF47KFmlLLIg/jJOToUGipP53hWc82vQ2q6AET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
Received-SPF: none client-ip=40.107.243.59; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 11:57:34
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.c |  195 ++++++++++++-----------------------------------------
 1 file changed, 45 insertions(+), 150 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b12addf323..ab2fcbd51c 100644
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
@@ -432,107 +376,58 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
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
 
@@ -6017,7 +5912,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(cs, cpu,
+        encode_topo_cpuid8000001e(cpu, &topo_info,
                                   eax, ebx, ecx, edx);
         break;
     case 0xC0000000:


