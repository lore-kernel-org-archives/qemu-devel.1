Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAFC2310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xKrYueng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAFC2310F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xut-0008Fc-Cr
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xqM-0002LD-8N
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:38 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com
 ([40.107.237.84]:40417 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k6xqJ-0000QD-Ry
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:11:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFdomoFQEuw/0yad/2kxZsAq/0tmKk8NS0QI5VZ/G2UDzjeqQKUzClU3V8g4x5v22sw6KQuepEiNDDWAXvMvedEbfKAXkkDzYdG/aYievTkhEVEojGhUgpszUoFjvEfjTem1SH9NYL4ub5R0LN4ZkluxISBCMf+HH39m2AeCq9YPpJ/KTZwXRhlIubfSVYqkmFaaAZ81Y/BQk96BOdl3I82PkMnwUKzZhmbAwR38vcdP50e/X/SC5QssvB6wpfOh0Wl1BuVDUftAyK0BdhGynWJqScs8AjV6x41E/4blYQ3ZSX9WJmYf/v3lDplA0UgOd5x9ZtP+j9K7e6/rmexUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybYEXSBoOxQUSvQPmPxghDJ8IANQct8GyKDeplE7/Uo=;
 b=P68Rlrd9Nz7LCGJWeQk79PBL9b4fmKEruVAllMJDW3jX5li1KZ870P5B4IR5OIVxJDP312UmN8u5WJKLJRSSA7KCD6HPfeyhnaApwAvj82KAgVHIvmy/O6lvIbt/r5ZXOLxSxQTfIslNWRT1dXgFNGdBKw3/Kkt7WjWuFqosxlF9Alw53Iz8ahMojpaZg+0wfU1ZPZzo7273YhwZDJRfxkrNQQMu2IUD8QcVczRf6Pk6lak7wYLVTI/manGbeYQMLVuctraoIV3JbwJs/qKaAS28+Aw6LzDKOmtdugIohlH+mJ2/19tW5iTjhsqgkjpjxtnZ6KdcozazbG1amYM05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybYEXSBoOxQUSvQPmPxghDJ8IANQct8GyKDeplE7/Uo=;
 b=xKrYuengeVn/pN400RIKAseF+5bN3TF4fqbklJId7DGH+5kBhmJ2mkUelxYFT55eOqnp+qRrHN/fv8FfRW/ieS8xnAjzez7aRxSaj8hRONWN4yiUuRzi/L0I97XBMiisEW1rBWSK0Guw8E9ioysg4CGa3psPk83xzzxyblR4jds=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4528.namprd12.prod.outlook.com (2603:10b6:806:9e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Fri, 14 Aug
 2020 21:39:41 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::691c:c75:7cc2:7f2c%6]) with mapi id 15.20.3261.026; Fri, 14 Aug 2020
 21:39:41 +0000
Subject: [PATCH v4 3/3] hw/i386: Remove node_id,
 nr_nodes and nodes_per_pkg from topology
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 14 Aug 2020 16:39:40 -0500
Message-ID: <159744118012.39197.535122421806420639.stgit@naples-babu.amd.com>
In-Reply-To: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
References: <159744083536.39197.13827776633866601278.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR2101CA0013.namprd21.prod.outlook.com (2603:10b6:805:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.2 via Frontend
 Transport; Fri, 14 Aug 2020 21:39:40 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fed0aba-7eff-4748-347a-08d8409a8d30
X-MS-TrafficTypeDiagnostic: SA0PR12MB4528:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4528714AFD14E7A65AF063F795400@SA0PR12MB4528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hLNqIHl106xAi9ofbf6uSyjrEs60Tp2doZI6M1BgsiLknimJV7exK6GZGAV0LkUnphJustpVnG5jD5T0Ar131rmM3aNm2Zuq1lGSQeGJjKHN3xls2P62QDpqwjYwjKsI56vfIzBlOH67xtW3z6nbC2459mQfpXZxdDywMTKbO0hryClPmnfrZ8WjE+ztWCOcjZ3zrqj9XRf6HoqA6xI8B18i7cprV1grb7Af5/m7+dO+B6XJWzfRs0kOAWmwf4R6XauPhN8o2KGhaBxAa0pm058mdQs4iZMOqN/VWBNGx7Bd9RBcloHubHYEpni9dId24g4ug4SzjWM8YFLJDGu864CLlXbxctmFH3hR16DoZZs8fIKT4MO1Do5sb/ZMbfhEIE1wOW68qPW8kGvnjxxjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(956004)(186003)(16526019)(26005)(316002)(478600001)(966005)(8936002)(8676002)(2906002)(86362001)(44832011)(4326008)(52116002)(7696005)(55016002)(83380400001)(5660300002)(66556008)(66476007)(103116003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iwjgrwZVOIyRN9qQlvmg45OJU3gyKWdtlXu/y7S9c+ckXSJnkYgIzmpa8tPIbz6O4SLGiqc8dQ4dJe1wM3cqDYFF3LsKAOODrejvXlMJbJiKmmiEuAcWDlepZAJc0Dq11IB8WeH32pYKpTwgE0TagaybTiyWX/86fzCu1SQNvNhd/8rFRyhpNHtTYyTYujm5UBi4O1NPEhBFBPKTm/HlIzvqI+5atOq9N+GE/w+dwd7hLkD3SLRy1WLlFYtlvsp5tXh303ATXZxiapnFT8m4CBq7M92en5cENe1Y2Qp4DzVIChIqwg+VC3UTlzWBaF+r5F0GD716uHNTNT4gJCnHqfxx1SHvWBFWY/6CqbsV5MRqp5hMwQrqutE4zhCwcZTnQOX4bca+LCPl3YjsITNhzpXFCig58McOPfRIjmzQnapFhk1aY10uEwkel3+DUn/XteZzUaQUupD/Kl9XKXHZheMiZMFXL9BMNLAcbPvTNmvcDj2nREtzox5oWNF30eZB0whL0zambiBlPU8lagqNgm0m8B/HqMHsKGTv+7xsjv2pwpqAKDz/TmMqVKidrC1ucGUhcXSlhnNHpxlm5TbvZC8PeWhO4+NGeVnUmtv+pCj5XJ7Gt+4HkZYAsA0bzgr8B7QTB8gPl32xcHSsHEdcQw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fed0aba-7eff-4748-347a-08d8409a8d30
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 21:39:41.2512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1vJd9a1flUiaHdJB/7KikozXp24CpzUE/3nQYl2iO+N6eHdEEfT89VXJt1C1d2g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4528
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: amd.com
Received-SPF: none client-ip=40.107.237.84; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:11:33
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

With node_id removed in topology the uninitialized memory issue
with -device and CPU hotplug will be fixed.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1828750
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
index e90c42d2fc..4efa1f8b87 100644
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
 


