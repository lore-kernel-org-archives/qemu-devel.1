Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1179CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E35206E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RcgYFNo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E35206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJyD-0005Ox-Of
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 21:00:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuN-0005YD-AW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfO-00015H-6F
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:21 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com
 ([40.107.69.73]:61568 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfL-0000xo-Ht
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eouCQS4RiBd4MdqaRyjglwo/A87NvvnWUsUEDbJDN5nnRQhe3U/TKMUKvmlsSEXYtHbQHC5rg1cXIeGOH5EE8JNjugs2KJ1ziZ7+Lh/mw3AEl5o8YrzfulNGhWX0AwuuFmDOFzp8uHBc8I+R+LbEkfE84ngWBbxOMdCTSyyIEpChtAFNH1tw4Eukg+vvoawZ8+3CmlHyKecGLZ4yo08CVPu+0T5OAse+pwL7+d2EAHg5B+9e3pMg+F0BDyTyE3bziGQPW5pVKz+N3Xf1/ACswDXpCMXAqz6+7tXysXYL0DgykxF/17sOc3x0X5ycCyUSkmKfC3kMDqouj1BhpFuH5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmuezkPeCBIYt5fS248WZR9XloatsSelXJ7OmfO15Mg=;
 b=QrMG/4uH63SnDIMWIr6EO4QuAYeCwNfbkx05w9VS+Z3GKckCdCRqkpFwFnaD7f+TJQSzgAag5FmZJ7ynTFHFkSskqZcU/rWhQBnzNv/xamNv9waqTj8ObAsh1Rx+XhTjr8huRqt9m8wuh8gNx14JRs2UUPhR+x0N+EDk9b6n3AFVsAiqK2Qq7YSXQKVS0L/+SoJhiC0fmZCgTn87tbHjTjSzDBnlYMq8eElepMr71aE+bWTb+9s6OciN+a5m4LNArLAz8ocR25MAAjf+4ZHVAhPPrkWFXxpE/WiHEJjEC/rLiJFs83Ai4xCtcKvHtJr+tO20MLqXl1kdK0FolLboFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmuezkPeCBIYt5fS248WZR9XloatsSelXJ7OmfO15Mg=;
 b=RcgYFNo4cbSD4oCSlGZnexieNo8D1j+zIuRqg5GPqnwwIXmuwvmqP+4SNMA8Ln2Y4NhXga5fh0lTBp9hg1k0GBqZSBE20z1bTbWRt+tklQpzqENXXcFmcm5bduHIrOQhoM670rYBSbOILqwtP1MUJMy+pobsUufdlqapb7TX5Ho=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:09 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:09 +0000
Subject: [PATCH v3 02/18] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:08 -0600
Message-ID: <157541982831.46157.16635542688144831181.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0108.namprd12.prod.outlook.com
 (2603:10b6:802:21::43) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ba7798e-8c8f-4ac8-8bd4-08d7785218d9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB136990B834217FEEF74862B1955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(498600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lz1w09LtU/4Q1UDaZf6XqAr/LgIcfO7oLTbWu21UBvES8SA2jM12N3XCpBw8GFtAv9AjlPIdQ2Nchjxanh+OfkDQ4DaQwY/RRbALlIem33vlHBKlIuded/sq3BGD0/dUH/1hCGoKAiqLcBCj1lD24bFfwFRmozAce2xj44SBBpFw9Id2+d90obTJIGhESymqM6yt/l0JxleS7nW54mN4L6nsszB0BOLcjx7RVRsgAKFgIBGzImeVD1psGeohAn5G0wcgpQ/mwXkcv+iDQ9B2HUC3uXEAAdN07sWhlHSS2wyt077v4o6LXGPtU5FSj/6FADfaJt8Tf+JObxKFQyulrsKfK0CTzSpjvoakdVsjvBLk+/JJewYHRCsWcWfeB+qtGqt+A/w6GwLNOVSAsF2ttkO8WdE516GfACzwdjGWmWGCtrIaNeggqLFCWdu7cJR/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba7798e-8c8f-4ac8-8bd4-08d7785218d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:09.7535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBlhMHRBg4DKO09l6d2lfulm1vCmGhUzjLupGfP6cWwWGgNjyEBzr5Mppkf58zjR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.73
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an effort to re-arrange few data structure for better readability.
Add X86CPUTopoInfo which will have all the topology informations required
to build the cpu topology. There is no functional changes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |   40 +++++++++++++++++++++++++++-------------
 include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
 2 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5bd2ffccb7..8c23b1e8c9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -878,11 +878,15 @@ static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
 {
     MachineState *ms = MACHINE(pcms);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    X86CPUTopoInfo topo_info;
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
-                                         ms->smp.threads, cpu_index);
+    topo_info.dies_per_pkg = pcms->smp_dies;
+    topo_info.cores_per_die = ms->smp.cores;
+    topo_info.threads_per_core = ms->smp.threads;
+
+    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (pcmc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -2219,6 +2223,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
+    X86CPUTopoInfo topo_info;
 
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -2226,6 +2231,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    topo_info.dies_per_pkg = pcms->smp_dies;
+    topo_info.cores_per_die = smp_cores;
+    topo_info.threads_per_core = smp_threads;
+
     env->nr_dies = pcms->smp_dies;
 
     /*
@@ -2281,16 +2290,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
-                                            smp_threads, &topo_ids);
+        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
-                                 smp_cores, smp_threads, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -2311,8 +2318,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
-                             smp_cores, smp_threads, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
@@ -2694,19 +2700,28 @@ static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoIDs topo_ids;
    PCMachineState *pcms = PC_MACHINE(ms);
+   X86CPUTopoInfo topo_info;
+
+   topo_info.dies_per_pkg = pcms->smp_dies;
+   topo_info.cores_per_die = ms->smp.cores;
+   topo_info.threads_per_core = ms->smp.threads;
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            pcms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo_ids);
+                            &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
 {
     PCMachineState *pcms = PC_MACHINE(ms);
-    int i;
     unsigned int max_cpus = ms->smp.max_cpus;
+    X86CPUTopoInfo topo_info;
+    int i;
+
+    topo_info.dies_per_pkg = pcms->smp_dies;
+    topo_info.cores_per_die = ms->smp.cores;
+    topo_info.threads_per_core = ms->smp.threads;
 
     if (ms->possible_cpus) {
         /*
@@ -2727,8 +2742,7 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 pcms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo_ids);
+                                 &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (pcms->smp_dies > 1) {
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 6c184f3115..cf1935d548 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -52,6 +52,12 @@ typedef struct X86CPUTopoIDs {
     unsigned smt_id;
 } X86CPUTopoIDs;
 
+typedef struct X86CPUTopoInfo {
+    unsigned dies_per_pkg;
+    unsigned cores_per_die;
+    unsigned threads_per_core;
+} X86CPUTopoInfo;
+
 /* Return the bit width needed for 'count' IDs
  */
 static unsigned apicid_bitwidth_for_count(unsigned count)
@@ -119,11 +125,13 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
  *
  * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
  */
-static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
-                                             unsigned nr_cores,
-                                             unsigned nr_threads,
+static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
                                              const X86CPUTopoIDs *topo_ids)
 {
+    unsigned nr_dies = topo_info->dies_per_pkg;
+    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_threads = topo_info->threads_per_core;
+
     return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
            (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
            (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
@@ -133,12 +141,14 @@ static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
 /* Calculate thread/core/package IDs for a specific topology,
  * based on (contiguous) CPU index
  */
-static inline void x86_topo_ids_from_idx(unsigned nr_dies,
-                                         unsigned nr_cores,
-                                         unsigned nr_threads,
+static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          unsigned cpu_index,
                                          X86CPUTopoIDs *topo_ids)
 {
+    unsigned nr_dies = topo_info->dies_per_pkg;
+    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_threads = topo_info->threads_per_core;
+
     topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
     topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
     topo_ids->core_id = cpu_index / nr_threads % nr_cores;
@@ -149,11 +159,13 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
  * based on APIC ID
  */
 static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
-                                            unsigned nr_dies,
-                                            unsigned nr_cores,
-                                            unsigned nr_threads,
+                                            X86CPUTopoInfo *topo_info,
                                             X86CPUTopoIDs *topo_ids)
 {
+    unsigned nr_dies = topo_info->dies_per_pkg;
+    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_threads = topo_info->threads_per_core;
+
     topo_ids->smt_id = apicid &
             ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
     topo_ids->core_id =
@@ -169,14 +181,12 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
  *
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
-static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
-                                                unsigned nr_cores,
-                                                unsigned nr_threads,
+static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
                                                 unsigned cpu_index)
 {
     X86CPUTopoIDs topo_ids;
-    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_ids);
-    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
+    x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
+    return apicid_from_topo_ids(topo_info, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


