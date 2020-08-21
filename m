Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3825A20855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yJYYD6oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3825A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FIK-0005Tt-GF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHV-0004B6-4t
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:05 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com
 ([40.107.220.76]:40513 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHS-00027r-It
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:13:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnXI9vrWY2TW+jWTsahh+KSBAvqADqDcxAcERTiPeE9xyApL+E14zjKoLfZQSe8Xspnp0/+tVv4Fg3dYVseh0Ko2q2nNSNnDbA84SPgfwC0SgfJUuuAjbHiwSiyA8zHWxnh4NCq39vr6JDUtydKq+wV54kEacador77/1FoQ8+vo9ruOjB00Bx4fzDXcsivHsqiu/gWbYU9AUyVoqNhqjdqOBsGK1SnOWhnOGD8RYio6Z2GBnHj3SFecZ3tIW+AI8xgn+5Gq18yLCc2y+mP6fNhb+jz1a5M8sVxJkOj2O3k2D4L6AxZqWgnwJ+X8DAiIisWFCUEdvIPf3u/YY6M2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/+GPq0tMiDVqTmTmlHX3zfJu1ZVTco3skOgXWktpJc=;
 b=NZGH+fwckcfDq9Ui80lBB6TgAk1lM6mJ6YO9kcQPaLvJOtOTGQs5Z3xKBd8rYA267BiMbIzhkoKImL0dBAXkqdd9rhgGQM9lJ5G1sISni69aixiwCfzxyIaNgpeAUa72hsiYaIl4YAmAP0RGLOKNMy/LpVneB9zs6ctZ07lh86HOnj0IKBJlAyuCT/CRjafkHj+Q2P+cFmdmOvOiK5loThYsGekSYt7pvCDZQB7Q7ES9hW2pEwql9DGf956A9QrrjSvPwHjGcui4gBvWq21e3AI96UyaqvKOy+V03TZwFSvxIYD7T27OSbk1qhbjTxTfPnmdH7cxOSBY319qtM+a/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/+GPq0tMiDVqTmTmlHX3zfJu1ZVTco3skOgXWktpJc=;
 b=yJYYD6oytsg5i9O2OVrE9ysCgzYJXw4K4u1cmOmMlVzqTQBm3U3sPep9BOOTIoDdaCaQzsfGri12+9TT32fEdQisU35vcMCsxdHvku/I9AOvnHv1LKk55FbmnaMlazlp5q/QmX1fgropfUo0onj0k2ByABWAesKOT65xIJC1XCM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2383.namprd12.prod.outlook.com (2603:10b6:802:26::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:26 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:26 +0000
Subject: [PATCH v5 1/8] hw/i386: Remove node_id,
 nr_nodes and nodes_per_pkg from topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:25 -0500
Message-ID: <159804794520.39954.435753698576266461.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN6PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:805:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.0 via Frontend
 Transport; Fri, 21 Aug 2020 22:12:25 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6cf49585-792d-4345-fcd6-08d8461f4953
X-MS-TrafficTypeDiagnostic: SN1PR12MB2383:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23834A75B4467C5884D1188D955B0@SN1PR12MB2383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7skliowSqtDE7bGOKnuLB1FHfAxxs6Nq/EOBvFEFeJ+o+R3k44GqJyKYmMO69IjvxS8dwKubz1GWwrgQr0vtNobXUYIQ25C3VX6kbGJOmi0nFgeOc5CGwVoKHqvZd4/dnIvCqeyiGLq4H5IOJeIplqOwlb1WkbTPh9S55fT3FS8Qr1gSjDFP/KHxfSRaKDemBOlfrmykQQqLQK2fpmw2YqvfjQgQrebwsLsJxsxrqX/IMFvPhOizC0EwWciArIRqlmaC0sKxDS0vPUJBKAlYWE+lPpaP/5nOrz9b+bg0bQiXIN4bFDIcwTVlzgL0jPnm7ZIBdabvYNYO7LRvH5nlE3nXXGASjiVxTyK2pN1uENmmubGVQizweDQGxdL7AIcitXQqtwo6MXehLeJYjaWocpC0Lv5BuDa7qAlhAdHb1eGOvAjazst03G0qIP6/2wMiyDRtzhsw62E5eXlZizMaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6486002)(2906002)(8676002)(103116003)(956004)(8936002)(44832011)(110011004)(26005)(478600001)(86362001)(966005)(16576012)(316002)(52116002)(66946007)(186003)(66556008)(30864003)(66476007)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BKIlC93F3sh8knAKYkocmOD0ZhOeQzQtcw1An2GY2SqH3b41Gq28EA9TT1SyJ+EvpJiQUw2XF7oJS0x7nFoxoR89w3bmbRq/LbmoReyDK9nxh1oKjkKmntGJQPDFHHU/yHzDgq4KhJRZeAU6bXxlq+/irRa6YdBecycEHKiWb7k9oty0ReI3QjN1lqxXqRUlfSqfwnQZMQUXobFaJGsy3D9UlZuiQiGhoN/agkfpled45sgxaXfYxW6K3DnB2I1prEWXO61PPAAP46XphIuF3KilvuhQYQCi366ZeP38C+7Q0g6obsLdSBFcNOQwMlhA9YTaKaQZVG7R43mTTDOlS+2L8zQqhW2z7b8+3C1tm+yxaneqMxfwr4LMQi2G23kt2zQBNeu9cHZxGM7cwiY+rC5iOQJbLzwlib4rRsqLAsA7Ujf6OFpmFoxfbLyMVbBCWGvD4btKCAracwec0DgZILNMniofa2Avw/Hg6Jw7YT57xSEEADfrCn/BKhBACDoF5f9jsAsPxGBTgENo1oPtNNjsrjeHi/snjqG5AvYHadLkNbtp/lThapdv+KwMTRV33HvAY+XXFgEkLX73K+ngARSDeu3c+RpUvgQ2nMU+BOvjidSe0tMijQ449g1l0sU4iraRtzARn2BoZIzl19LikA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf49585-792d-4345-fcd6-08d8461f4953
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:26.4674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFEBdFKZVxi0Ov23G+OZD5y7yOnrexvhIgPbYib0E2qPZcDuTbtX8IBHBfNmn8p4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2383
Received-SPF: none client-ip=40.107.220.76; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:13:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

With node_id removed in topology the uninitialized memory issue
with -device and CPU hotplug will be fixed.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    1 -
 hw/i386/x86.c              |    1 -
 include/hw/i386/topology.h |   40 +++++++++-------------------------------
 target/i386/cpu.c          |   24 ++++++++++--------------
 target/i386/cpu.h          |    1 -
 tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
 6 files changed, 39 insertions(+), 68 deletions(-)

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
index 67bee1bcb8..f6eab947df 100644
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
index 588f32e136..3c58af1f43 100644
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
@@ -387,7 +385,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
                                        uint32_t *ecx, uint32_t *edx)
 {
     X86CPUTopoIDs topo_ids = {0};
-    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
+    unsigned long dies = topo_info->dies_per_pkg;
     int shift;
 
     x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
@@ -408,7 +406,7 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *             3 Core complex id
      *           1:0 Core id
      */
-    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
+    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.die_id << 3) |
             (topo_ids.core_id);
     /*
      * CPUID_Fn8000001E_ECX
@@ -418,8 +416,8 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *         2  Socket id
      *       1:0  Node id
      */
-    if (nodes <= 4) {
-        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
+    if (dies <= 4) {
+        *ecx = ((dies - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.die_id;
     } else {
         /*
          * Node id fix up. Actual hardware supports up to 4 nodes. But with
@@ -434,10 +432,10 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
          * number of nodes. find_last_bit returns last set bit(0 based). Left
          * shift(+1) the socket id to represent all the nodes.
          */
-        nodes -= 1;
-        shift = find_last_bit(&nodes, 8);
-        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
-               topo_ids.node_id;
+        dies -= 1;
+        shift = find_last_bit(&dies, 8);
+        *ecx = (dies << 8) | (topo_ids.pkg_id << (shift + 1)) |
+               topo_ids.die_id;
     }
     *edx = 0;
 }
@@ -5489,7 +5487,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
 
-    topo_info.nodes_per_pkg = env->nr_nodes;
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
@@ -6949,7 +6946,6 @@ static void x86_cpu_initfn(Object *obj)
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
 
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 049030a50e..bfabc0403a 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,12 +31,12 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info = {0};
 
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
@@ -45,39 +45,39 @@ static void test_topo_bits(void)
 
     /* Test field width calculation for multiple values
      */
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
+    topo_info = (X86CPUTopoInfo) {1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
+    topo_info = (X86CPUTopoInfo) {1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
+    topo_info = (X86CPUTopoInfo) {1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
+    topo_info = (X86CPUTopoInfo) {1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
+    topo_info = (X86CPUTopoInfo) {1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
 
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
+    topo_info = (X86CPUTopoInfo) {1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
+    topo_info = (X86CPUTopoInfo) {1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
+    topo_info = (X86CPUTopoInfo) {1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +85,18 @@ static void test_topo_bits(void)
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,


