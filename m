Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1677F20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="we2WWaXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1677F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k45Jc-0007qk-1i
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45Ik-0006uG-Gs
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:02 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com
 ([40.107.92.74]:60938 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k45Ii-0002WB-KE
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7PPSVi3sSnKT2dsd2HZxtRxJA8l/5wf9Swt9j5TRYqT7GC5EJpuGGBzHOKeFIhA0SfRIlQZUUXzQBTIKB8fvt4Fm3MAIzDysXYiMbPjnrUyCWzDx6RpD4zv2ODmmqhAHWmmggoyTqi18o30kViQmJwF5qUN9Yuqz4v09XTlH3BGPoFOFCme71FqrQJEMuyR8T1nUelZvUMU80qCLf3LUtGFYKI11DGwsJeaKwZEZtFM8kFmwhr4mUtpNji3gVaH/qBA7AI0sdzsL6Z0BChDd+jjYPzhl2IAY5+nxjsa6KStECjitvX+pJ47GQOtCYcMH0adtBPCbEWdJ7YylGEzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOETgrYAYM2orICWPNZ+UfikKBv7UJQ7NmE/ajZzujY=;
 b=Q7AjIPSYMJnvU0rC+7ZrxC/JY9ncRLnIoCFmP1jGrzNlIwWhCjmrIxBcts+Fdy2Lss1WnJeDtwdefxIwmQbnMQFrkCE2voiNExcbqZFf8qMhjckzpPiHrmLc+BQGA4Hf/i/7CMZFGzpgWadX1sdtavZeQ9DXEIPeXW8kLqAA80kmUXqLccNjdJJuoqCVo/MXw6CF0Q2HiFpog9j0D0LoFUU/iDGamRcnVDz2fSWqdHc0o6eIe9JyQkT4/RJ0eemhCax/FfedrVwcOKzOrQjUSXpPzWAap82ed7GbpJRJ2O3D5Riv8zx6eVDYr3wPrNMTYSBh10nMkPRZsMDHEupYEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOETgrYAYM2orICWPNZ+UfikKBv7UJQ7NmE/ajZzujY=;
 b=we2WWaXD1X39rJTrqbo3IpTPrPB2sD1AEYsTE5RXRpHvfZM2wEH0mKrNzqqYok+DJ3GOWoyKSNkD0Y7MHza/FiXgIzyvPF5kspXTcuBm2FuV6EyFesKMg2bWsLQC66JtwXnqS8h0ODYtxcFf2u+qdpOgEATjezq/K08TxWI+JZQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2429.namprd12.prod.outlook.com (2603:10b6:802:26::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 16:32:59 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3239.024; Fri, 7 Aug 2020
 16:32:59 +0000
Subject: [PATCH v3 3/3] hw/i386: Remove node_id,
 nr_nodes and nodes_per_pkg from topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 07 Aug 2020 11:32:57 -0500
Message-ID: <159681797783.9679.18340388367001883091.stgit@naples-babu.amd.com>
In-Reply-To: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
References: <159681772267.9679.1334429994189974662.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.1 via Frontend
 Transport; Fri, 7 Aug 2020 16:32:58 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b67245e4-a233-4b91-1a5f-08d83aef8ba3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2429:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2429B0BA9C3FDCE144A20CF395490@SN1PR12MB2429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQmFMZntp49L0HW2sheNKQrYd36wPZxmQ+CwEJv77KxIXJqRW9trZmpUx0Br7YE7br2BE64ko4rRQFZ8OLOcr/Aky6W9ewtYlz0AYiVRpwn2gN8QQS4nYb4Qufc7YDX0sSUi/MeDAEXUBxyz1yQRzCo38SSBUxZkotoiudHdk/x6iT0Ct1X2V91p92E7jHS4KeshPmpTAaauqWsbPpNRT0n1zb7Nk1bpEn/r6vTZedI5Bqn53L/0MNfGVr13Y/TOJqfdhWY4vO753wQI0feGm7JhguezDo7rcqH7ObU2NkImphH1xiSbiD7ew1e1QSkB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(2906002)(52116002)(7696005)(66946007)(478600001)(316002)(55016002)(16526019)(26005)(186003)(86362001)(44832011)(956004)(103116003)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HxBAjWTUgVlUZ6K698hjMOe8CuzDMVNj9wOFx6PWSJgMa1UHxjAOWNP/DLLaFNkXkpVJg1X7APYZJGAsMPtykVZxA+WBIBYBFdLX6e13E16+prfJ6tCvx1+3eDvmxKlTNGxRBTWuKZ4EnODcL6RLNbOWtYJDSLzt88GSnN4dD42iVMLgGEx5waX//jK+Xq9XMm2wJAgUy0RbbCsqlta73tWbTHpr5k7uHB69ssmf1ZP9FJKyRi3+vvscOvFEPdj5qqdU6jctTYNgjin+gCIm6hq43mQ8Ir0Vy8C0y25nw07tCwrKdaONmeHTVNes+bVeYpCNL0/7zybb8S6xa7DZF5ngvAOu/ABCRvDHY/hLzsrPsPRVAk6trNU3i7ihjEpcnH8wikEN7My/jRwIlLDa1jQsdq3osbgUlwIUNwfXad8nWuUV6kSEPkuZT+0MA6NRXkDhKmg40nwy9EiSOw17RCe1z7LiOWT2GdOCC3R2HjQ4P+YHBU5H1jwsh3NCnT8Yre9en7T1FJ16NzJUCDX/1udPccf3ULxo0y96XDr9iNjXVH1kb9Z4Hj+Tkl1gpfU0btUtY8AKrP0JMh9mOCtYc37VHAQl2M+j0MHaiT0xeUvasQ0JaJAgOvs+X31IVlyTS4KRSKL+tChGkKvzkV6OfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67245e4-a233-4b91-1a5f-08d83aef8ba3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:32:58.8531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAvXRY5LAhCBY70iiFsrGR0wEH770Kf4oNXoSONGZRooWidfR/Xw2ptgPoZJ+79U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
Received-SPF: none client-ip=40.107.92.74; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 12:32:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove node_id, nr_nodes and nodes_per_pkg from topology. Use
die_id, nr_dies and dies_per_pkg which is already available.
Removes the confusion over two variables.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    1 -
 hw/i386/x86.c              |    1 -
 include/hw/i386/topology.h |   40 +++++++++-------------------------------
 target/i386/cpu.c          |   11 +++--------
 target/i386/cpu.h          |    1 -
 5 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 47c5ca3e34..0ae5cb3af4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1498,7 +1498,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
-    env->nr_nodes = topo_info.nodes_per_pkg;
     env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2a6ce56ef1..3ac46960db 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
 {
     MachineState *ms = MACHINE(x86ms);
 
-    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
     topo_info->dies_per_pkg = x86ms->smp_dies;
     topo_info->cores_per_die = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 07239f95f4..05ddde7ba0 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -47,14 +47,12 @@ typedef uint32_t apic_id_t;
 
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
-    unsigned node_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoIDs;
 
 typedef struct X86CPUTopoInfo {
-    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
@@ -89,11 +87,6 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
     return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
 }
 
-/* Bit width of the node_id field per socket */
-static inline unsigned apicid_node_width_epyc(X86CPUTopoInfo *topo_info)
-{
-    return apicid_bitwidth_for_count(MAX(topo_info->nodes_per_pkg, 1));
-}
 /* Bit offset of the Core_ID field
  */
 static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
@@ -114,30 +107,23 @@ static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
     return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
 }
 
-#define NODE_ID_OFFSET 3 /* Minimum node_id offset if numa configured */
+#define EPYC_DIE_OFFSET 3 /* Minimum die_id offset if numa configured */
 
 /*
- * Bit offset of the node_id field
- *
- * Make sure nodes_per_pkg >  0 if numa configured else zero.
+ * Bit offset of the die_id field
  */
-static inline unsigned apicid_node_offset_epyc(X86CPUTopoInfo *topo_info)
+static inline unsigned apicid_die_offset_epyc(X86CPUTopoInfo *topo_info)
 {
-    unsigned offset = apicid_die_offset(topo_info) +
-                      apicid_die_width(topo_info);
+    unsigned offset = apicid_core_offset(topo_info) +
+                      apicid_core_width(topo_info);
 
-    if (topo_info->nodes_per_pkg) {
-        return MAX(NODE_ID_OFFSET, offset);
-    } else {
-        return offset;
-    }
+    return MAX(EPYC_DIE_OFFSET, offset);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field */
 static inline unsigned apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)
 {
-    return apicid_node_offset_epyc(topo_info) +
-           apicid_node_width_epyc(topo_info);
+    return apicid_die_offset_epyc(topo_info) + apicid_die_width(topo_info);
 }
 
 /*
@@ -150,8 +136,7 @@ x86_apicid_from_topo_ids_epyc(X86CPUTopoInfo *topo_info,
                               const X86CPUTopoIDs *topo_ids)
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset_epyc(topo_info)) |
-           (topo_ids->node_id << apicid_node_offset_epyc(topo_info)) |
-           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->die_id  << apicid_die_offset_epyc(topo_info)) |
            (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
@@ -160,15 +145,11 @@ static inline void x86_topo_ids_from_idx_epyc(X86CPUTopoInfo *topo_info,
                                               unsigned cpu_index,
                                               X86CPUTopoIDs *topo_ids)
 {
-    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
     unsigned nr_dies = topo_info->dies_per_pkg;
     unsigned nr_cores = topo_info->cores_per_die;
     unsigned nr_threads = topo_info->threads_per_core;
-    unsigned cores_per_node = DIV_ROUND_UP((nr_dies * nr_cores * nr_threads),
-                                            nr_nodes);
 
     topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->node_id = (cpu_index / cores_per_node) % nr_nodes;
     topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
     topo_ids->core_id = cpu_index / nr_threads % nr_cores;
     topo_ids->smt_id = cpu_index % nr_threads;
@@ -188,11 +169,8 @@ static inline void x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
             (apicid >> apicid_core_offset(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
     topo_ids->die_id =
-            (apicid >> apicid_die_offset(topo_info)) &
+            (apicid >> apicid_die_offset_epyc(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
-    topo_ids->node_id =
-            (apicid >> apicid_node_offset_epyc(topo_info)) &
-            ~(0xFFFFFFFFUL << apicid_node_width_epyc(topo_info));
     topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c892432cae..ba0a24f6b8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -345,7 +345,6 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
                                        uint32_t *ecx, uint32_t *edx)
 {
     uint32_t l3_cores;
-    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
 
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
@@ -355,10 +354,9 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
-                                 topo_info->cores_per_die *
+        l3_cores = DIV_ROUND_UP((topo_info->cores_per_die *
                                  topo_info->threads_per_core),
-                                 nodes);
+                                 topo_info->dies_per_pkg);
         *eax |= (l3_cores - 1) << 14;
     } else {
         *eax |= ((topo_info->threads_per_core - 1) << 14);
@@ -387,7 +385,6 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
                                        uint32_t *ecx, uint32_t *edx)
 {
     X86CPUTopoIDs topo_ids = {0};
-    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
 
     x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
 
@@ -433,7 +430,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      * NodeId is combination of node and socket_id which is already decoded
      * in apic_id. Just use it by shifting.
      */
-    *ecx = ((nodes - 1) << 8) | cpu->node_id;
+    *ecx = ((topo_info->dies_per_pkg - 1) << 8) | cpu->node_id;
     *edx = 0;
 }
 
@@ -5484,7 +5481,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
 
-    topo_info.nodes_per_pkg = env->nr_nodes;
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
@@ -6944,7 +6940,6 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
-    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..4c89bee8d1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
-    unsigned nr_nodes;
     unsigned pkg_offset;
 } CPUX86State;
 


