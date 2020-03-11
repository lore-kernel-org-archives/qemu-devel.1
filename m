Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1304BC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE5721927
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UNk2Mew/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5721927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrGw-00014D-Va
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCa-0000be-JN
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrCZ-0007xN-0U
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:32 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com
 ([40.107.223.48]:31967 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrCY-0007tt-Ob
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgxwLxgM1sMjhCsz+cTy+dUx2DtirlQs+zHS5TFEVgsgr0+xscYxrSO5TxSCaxr8zJ8rIwNpKn+R0Od6z26o/vGnhyOnsuNK69TNh2xiIGfLHg/U3lCEppwdtAp7+o8t4wH1qdWiZYbu3PoG5cE4OsmZWiVau86BZtoESxpLzSHekmtBJAXrBlH8eTwjJKdwYYMgh6r+LyoTdGHGzYOQl0bIaWmNxI43a2uI4gE9zrnHQTG7L82MGOWVnJqxXOVpEGtpkpLS/hiqStzHEl9bZy7bfVePfH8vYDg6Q9eQDE+/F6dgyGn70t0AUPbJK009Bio5SglNNpb7VXyppC7p8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tqvj+UCh00OS508PbjxeUt8385/p9uHKHaIoiv2K8E=;
 b=hH036CnKChVcZ1Zgi/mTWmbdtz5swr9BknsYZm/smcqVrMFxEEd+t602mQWGWvUoz8Lh1bjlBD11eytnLv9qmjwTlGdlRZrYhSmG2oM7dOdVBYaaGqIo5e58APdBrTIneRphmAGR7zr0WXx4eWL8qJp3Gab4Q5TSKUZTvtG35C4558HhaiH8J8rRDBISPnXuWET0BU+rjeFtRxmxf7BUYZ2Z9Vw068Fj8dNLEHxlsaMsqWjMkA/D6QmavT6GCKpbSYKa+/7uTyNO3LbSk6e7whGlDdeInc/hqvMpK3raxtHasWIc8ZxOeYWJEDed0oJ3ZUHUeWljIYyI1m2tb39wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tqvj+UCh00OS508PbjxeUt8385/p9uHKHaIoiv2K8E=;
 b=UNk2Mew/xMEZCbz5fC28hg7Ncc+vulQ4mtvmMOcaEwT+pUCw29leaHMj1JyVXRNI1MTrZg9XF8JctSyAhWh37qbmOuYJ8zMnf5CzCeUxkV3pk/LweEQZ6+cPEqmTOvxz25VxDS6sTjkp8ww1EvODw2/vN8+WVq5I+KCOHpsrDsE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 02:34:27 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:34:27 +0000
Subject: [PATCH v6 10/13] i386: Check for apic id encoding
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:34:25 -0500
Message-ID: <158389406581.22020.12203992175835061363.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:3:37::31) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR06CA0069.namprd06.prod.outlook.com (2603:10b6:3:37::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 02:34:26 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f1c247a-3bc5-4155-04f8-08d7c564b83a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:|SN1PR12MB2575:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575C9566FA3E4E504E0F06995FC0@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(103116003)(81166006)(81156014)(8936002)(8676002)(7696005)(186003)(16526019)(66556008)(66476007)(2906002)(55016002)(5660300002)(52116002)(44832011)(956004)(66946007)(478600001)(316002)(4326008)(86362001)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2575;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUL1Sb7sZwiqcqb6X0Tur4s101ABn9uA2f4fGSEY1nNjDG+i93MkollX/Z1KLlSIZ2VHwijIWgHji3pVHGkubNm13HYEHkwb4CiQhungEX5GHXqRDjl4b9wu3Zgr2Uj/DyZgE2sDnAS/fiRYKgkiY/mae54rbrSKiVsGPcg8Fk0XxK+RQntGawghiPQOSqVbpRLqTVwX8vCZxtO3sDmgo8sO0GjEOm50Wg6dTd2xak+bRjuQ9f7+LlP2kYfuqwKKGjc1GwigBFLxv/syDtl0L1k3Zf11GwQ+Q2vZkFM6ASxscW83QYMLEZFj7qpaXPZ2bBtLcLl17oSuM49iWlWiF760ZiLI6PC1NN9lw2/7QvnkHItgZpaCajwZHnqly6caPleu7vX1koDeeJ9BOYcSdAF3PVw8ob4t0MskoF9jmMbylYDdSftvtbBmh4ty9fOE
X-MS-Exchange-AntiSpam-MessageData: odnCxhIcXWLwQmmsEp3JVxmKau7YxoF0uqCq55nxZeRsq7BnZkdYVikNqRZ8622ikW6pYecg0Y4ArHssbRfJuM29uW0St7CeJKrRzWLMACANEE4I3o/KrNqbD8dx7iPizH9zYtz5jb3KaT5qFmLD6A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1c247a-3bc5-4155-04f8-08d7c564b83a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:34:27.6345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RByFY1fxXsrSZqMztRf2GKZl+b9H9UQ6jA7v7Ucb2ahSDAxDgTDV98/Djk4jwT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.48
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

Check X86CPUDefinition if use_epyc_apic_id_encoding is enabled. If enabled
update X86MachineState with EPYC mode apic_id encoding handlers.

Also update the calling convention to use apic_id handlers from X86MachineState.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c      |    6 +++---
 hw/i386/x86.c     |   32 +++++++++++++++++++++++++++-----
 target/i386/cpu.c |   11 +++++++++++
 target/i386/cpu.h |    1 +
 4 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 98ee763f68..2d7d611184 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1580,14 +1580,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -1608,7 +1608,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7dc237c014..ad85347142 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -68,6 +68,25 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
     topo_info->threads_per_core = ms->smp.threads;
 }
 
+/*
+ * Check for APIC ID encoding
+ *
+ * AMD uses different apic id encoding for their EPYC based cpus.
+ * Check if we need to use different handlers than the default.
+ */
+static void x86_check_apic_id_encoding(MachineState *machine)
+{
+    X86MachineState *x86ms = X86_MACHINE(machine);
+
+    if (cpu_x86_use_epyc_apic_id_encoding(machine->cpu_type)) {
+        x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
+        x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
+        x86ms->topo_ids_from_idx = x86_topo_ids_from_idx_epyc;
+        x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
+        x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
+    }
+}
+
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -86,7 +105,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -158,8 +177,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            &topo_info, &topo_ids);
+   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                               &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -179,6 +198,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         return ms->possible_cpus;
     }
 
+    /* Check for apicid encoding */
+    x86_check_apic_id_encoding(ms);
+
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
@@ -192,8 +214,8 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id =
             x86_cpu_apic_id_from_index(x86ms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 &topo_info, &topo_ids);
+        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                    &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a3051524a2..19de79d01c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1615,6 +1615,10 @@ typedef struct X86CPUDefinition {
     FeatureWordArray features;
     const char *model_id;
     CPUCaches *cache_info;
+
+    /* Use AMD EPYC encoding for apic id */
+    bool use_epyc_apic_id_encoding;
+
     /*
      * Definitions for alternative versions of CPU model.
      * List is terminated by item with version == 0.
@@ -1656,6 +1660,13 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
     return def->versions ?: default_version_list;
 }
 
+bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
+{
+    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));
+
+    return xcc->model->cpudef->use_epyc_apic_id_encoding;
+}
+
 static CPUCaches epyc_cache_info = {
     .l1d_cache = &(CPUCacheInfo) {
         .type = DATA_CACHE,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e9e963d78..6e522fcd34 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1897,6 +1897,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
 void host_cpuid(uint32_t function, uint32_t count,
                 uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
 void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
+bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
 
 /* helper.c */
 bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,


