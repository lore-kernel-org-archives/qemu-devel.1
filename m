Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBFDC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ADDB206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wr4gP9fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADDB206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCopQ-0004b8-Gl
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColT-0006mh-Pp
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:47 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com
 ([40.107.93.72]:2528 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColR-0007WY-MW
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoSa2gQe6eklvvaGxsmp+7KyEbY5wikfwx5j3YzHajlrV2xRdgf/SxVA/nJGTPxeQsxOR7atYgVFgViz+Rdg+qLxSru94ayS/vo7cUqJLGXMjuhMl2MnMGtlHJzzPbcn+GM5g1PYHgluv7NLvA2HJbO7LqHflPwbPtJJ6QlMFLTGeUm4Yd7F0cq0XuzWfeSIeUkvq50tb1ViwIIBFLjtZ0jxrN+lg562B/GuXI84h5EXZqvxJZN6FtomwVcDBc5JZPT2SOffr+U8L4+WK2Q8ftDJWI30vNsG3ymo1NgqibRYNGIhNIfNgjBftxW5FfonY2LFOm8xOqr1p+KKx9deKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAcDXsVNONqLK6Vw/mK3T8qrdG4uwmiHFD/Uf7PptzE=;
 b=VUNC6+P2BBE1K3BAh4eux0JGEEiyGRLvD/YnXzs0OPIvZSMl4aeQlz7zK+FsfCtrAJMmfKLgNVVI5F4bqq4E/zDvb6B4YYGZ5ipdQ9rMQMPIJZArA5GE9NE0HlF8oL0e735nDQleId69PDGVQNb1n85FeAnXSIOKdI2aB+xOnVRp9bu/i4xy3mBlH3W1dBaTaXrUMsFslUaVhvexijDDZY6acMuUnPmsckW0EcnQOMrwehisfiP0VBOgd93sMBmfCceMn9Jte7i1z0Xkm6ZEDH4PHWW7JRAs5IWUMtApL0JuIJImQ3zLIElxWz+1FexGbsyGgXxQBtES1iw3DfAKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAcDXsVNONqLK6Vw/mK3T8qrdG4uwmiHFD/Uf7PptzE=;
 b=Wr4gP9fAxQTonjr0SWcvz1g+267FXsLNtXdgCxfT9iT5Nvmx+nwyb3YfomgypUr7QIv0b+KCdqXk736VaSpMD9QqnR7JEzgK9B2F5x6KadDSbqJtjLbdPd6HfJLZM4Rw/7/3+nvRaNdFefJvdwtnsqisekZFwg4Lwjm84iPSGm4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 18:42:43 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:43 +0000
Subject: [PATCH v6 06/10] Revert "target/i386: Cleanup and use the EPYC mode
 topology functions"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:42 -0500
Message-ID: <159889936257.21294.1786224705357428082.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0026.namprd05.prod.outlook.com
 (2603:10b6:803:40::39) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0026.namprd05.prod.outlook.com (2603:10b6:803:40::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend
 Transport; Mon, 31 Aug 2020 18:42:43 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3a957ee-0b22-4180-4617-08d84ddda59c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4383ADC15C2C42C5ECA6D71295510@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pYHUnZFlaReY8ECh42kuZ0LoaPK1eeiFg+50E56ZKTnYubdIWvxfmbxgJKFFM/rws3OOdEVSikWtfls6HQpVs81gy6WWBkpGbURF6I41OKzOMdCpApXrljCLmv3tiSFIZOS4jSCWob+v3hQoxnSrlxPCxzcutDmeLvrM+DskWsabdA6nACxHu9uEyjBmDMpIzKftp9ErKluPeZWLMsF6BxdJ3x3c5JrTTAEojzkPh3PSmhMzyInnk4EpyJNSZMHt3Gg0hZcEA3JQT3paAsqB0nL1VYsXhX2uhAWfsWpNS0wJH5VWBswKEuVyp+FGcKgpGmf9fXfGEmjRUJdmqEJnLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(316002)(2906002)(26005)(66556008)(478600001)(6486002)(4326008)(186003)(956004)(83380400001)(8676002)(66946007)(86362001)(5660300002)(52116002)(103116003)(8936002)(66476007)(16576012)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kLbsr2JmcOc5RGoF/KjX8t16u19tOXs5FqJlFC6URXurfYUfawV6tjcDvxJx90Hux09t7KHXiCGt0NFp/1oQ2yxxvdDFRaGu4MAOjk4UR8g0AEluLrISHuxCrEGefDh8CkDc3Ws4iEcWhIJaO4081PsHyYb6PH1snKMf8SHIyRmD9vwa+TNNAL2P+LMSL8+vjulxYyH7JBr9/a3UP72pN6iRMJU7uB4+SFYHUayLHfDSEhvReFycrntGzrHh15cZ/VmUTwdAV8QGiU0oP853tweMXiyqyY26wbEqQSTJQEouJkW0ghFMJcDwnQtvunt24t6/otDhxlKINk+qOuxgtDsLf+h0RcLY1CNxxHsAcQOIaDeG8sNo6WLYrOOul4F5AOkLDltAnzWFvCbNnFVFLa4w+VCLWnZ704u3PYjLSzIfd/iO31zfntTUJHRLXPaoIiND84nCiG9BmSKAkdpgIvQX8xkchuA4zoqVCIRf9ELu272SiW6lVGd7BECIsUN74O2zdOJIU5BJjU+bl2cRQTcte51kx45vqJqOfpgLcA6PUQlZBzZJTY1aojWSok5cRjg5hUkPlHo23oAJb71Nv4a5ESrXay4xprXlEiTFR31Eby4ioH2Wv4hCSN3dSlZQPRpnhsVsYGRjlCxLCjTYHA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a957ee-0b22-4180-4617-08d84ddda59c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:43.5557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHH15PhT94IkcZVM9wwh10cFtq38rLutvi84Ezc6Y9PpX/A6+5qxIEUENRdYEfsl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
Received-SPF: none client-ip=40.107.93.72; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:44
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

This reverts commit dd08ef0318e2b61d14bc069590d174913f7f437a.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c |  161 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 127 insertions(+), 34 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b72b4b08ac..256bfa669f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -338,15 +338,68 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     }
 }
 
+/*
+ * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
+ * Please refer to the AMD64 Architecture Programmer’s Manual Volume 3.
+ * Define the constants to build the cpu topology. Right now, TOPOEXT
+ * feature is enabled only on EPYC. So, these constants are based on
+ * EPYC supported configurations. We may need to handle the cases if
+ * these values change in future.
+ */
+/* Maximum core complexes in a node */
+#define MAX_CCX 2
+/* Maximum cores in a core complex */
+#define MAX_CORES_IN_CCX 4
+/* Maximum cores in a node */
+#define MAX_CORES_IN_NODE 8
+/* Maximum nodes in a socket */
+#define MAX_NODES_PER_SOCKET 4
+
+/*
+ * Figure out the number of nodes required to build this config.
+ * Max cores in a node is 8
+ */
+static int nodes_in_socket(int nr_cores)
+{
+    int nodes;
+
+    nodes = DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
+
+   /* Hardware does not support config with 3 nodes, return 4 in that case */
+    return (nodes == 3) ? 4 : nodes;
+}
+
+/*
+ * Decide the number of cores in a core complex with the given nr_cores using
+ * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE and
+ * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
+ * L3 cache is shared across all cores in a core complex. So, this will also
+ * tell us how many cores are sharing the L3 cache.
+ */
+static int cores_in_core_complex(int nr_cores)
+{
+    int nodes;
+
+    /* Check if we can fit all the cores in one core complex */
+    if (nr_cores <= MAX_CORES_IN_CCX) {
+        return nr_cores;
+    }
+    /* Get the number of nodes required to build this config */
+    nodes = nodes_in_socket(nr_cores);
+
+    /*
+     * Divide the cores accros all the core complexes
+     * Return rounded up value
+     */
+    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
+}
+
 /* Encode cache info for CPUID[8000001D] */
-static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
-                                       X86CPUTopoInfo *topo_info,
-                                       uint32_t *eax, uint32_t *ebx,
-                                       uint32_t *ecx, uint32_t *edx)
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
 {
     uint32_t l3_cores;
-    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
-
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
@@ -355,13 +408,10 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
-                                 topo_info->cores_per_die *
-                                 topo_info->threads_per_core),
-                                 nodes);
-        *eax |= (l3_cores - 1) << 14;
+        l3_cores = cores_in_core_complex(cs->nr_cores);
+        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
     } else {
-        *eax |= ((topo_info->threads_per_core - 1) << 14);
+        *eax |= ((cs->nr_threads - 1) << 14);
     }
 
     assert(cache->line_size > 0);
@@ -381,17 +431,55 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+/* Data structure to hold the configuration info for a given core index */
+struct core_topology {
+    /* core complex id of the current core index */
+    int ccx_id;
+    /*
+     * Adjusted core index for this core in the topology
+     * This can be 0,1,2,3 with max 4 cores in a core complex
+     */
+    int core_id;
+    /* Node id for this core index */
+    int node_id;
+    /* Number of nodes in this config */
+    int num_nodes;
+};
+
+/*
+ * Build the configuration closely match the EPYC hardware. Using the EPYC
+ * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE)
+ * right now. This could change in future.
+ * nr_cores : Total number of cores in the config
+ * core_id  : Core index of the current CPU
+ * topo     : Data structure to hold all the config info for this core index
+ */
+static void build_core_topology(int nr_cores, int core_id,
+                                struct core_topology *topo)
+{
+    int nodes, cores_in_ccx;
+
+    /* First get the number of nodes required */
+    nodes = nodes_in_socket(nr_cores);
+
+    cores_in_ccx = cores_in_core_complex(nr_cores);
+
+    topo->node_id = core_id / (cores_in_ccx * MAX_CCX);
+    topo->ccx_id = (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
+    topo->core_id = core_id % cores_in_ccx;
+    topo->num_nodes = nodes;
+}
+
 /* Encode cache info for CPUID[8000001E] */
-static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
+static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    X86CPUTopoIDs topo_ids = {0};
-    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
+    struct core_topology topo = {0};
+    unsigned long nodes;
     int shift;
 
-    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
-
+    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
     *eax = cpu->apic_id;
     /*
      * CPUID_Fn8000001E_EBX
@@ -408,8 +496,12 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *             3 Core complex id
      *           1:0 Core id
      */
-    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
-            (topo_ids.core_id);
+    if (cs->nr_threads - 1) {
+        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
+                (topo.ccx_id << 2) | topo.core_id;
+    } else {
+        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
+    }
     /*
      * CPUID_Fn8000001E_ECX
      * 31:11 Reserved
@@ -418,8 +510,9 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *         2  Socket id
      *       1:0  Node id
      */
-    if (nodes <= 4) {
-        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
+    if (topo.num_nodes <= 4) {
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
+                topo.node_id;
     } else {
         /*
          * Node id fix up. Actual hardware supports up to 4 nodes. But with
@@ -434,10 +527,10 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
          * number of nodes. find_last_bit returns last set bit(0 based). Left
          * shift(+1) the socket id to represent all the nodes.
          */
-        nodes -= 1;
+        nodes = topo.num_nodes - 1;
         shift = find_last_bit(&nodes, 8);
-        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
-               topo_ids.node_id;
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift + 1)) |
+                topo.node_id;
     }
     *edx = 0;
 }
@@ -5471,7 +5564,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
 
-    topo_info.nodes_per_pkg = env->nr_nodes;
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
@@ -5902,20 +5994,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -5924,7 +6016,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
+        encode_topo_cpuid8000001e(cs, cpu,
+                                  eax, ebx, ecx, edx);
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;


