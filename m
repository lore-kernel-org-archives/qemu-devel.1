Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4FC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF04C2073F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Sa4l3DTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF04C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icK5l-0001C7-Ns
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 21:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuM-0005bI-Bd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfC-0000b5-Kl
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:09 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com
 ([40.107.223.47]:33580 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfC-0000RG-96
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwSvAGelqRKXFOyPXFOz7YsUepDqxtFHBaq86xGB7F9HeAEepc6/68R1jERAhf62qxJf96CcN7Ewk1Jc4cApcizEZtJFJsaGZZmsCKJMjyatjLzgtoP//mqmcuNHHt82O7BPLjie09sseLk0tbg9freFckKhUXgPtS/PZ0KRKg71o8WAra6aWtDEvd7BncOhQzNRMNvH0P4NImOAp5PF3FLQqaz9PI+TogaGKeXfT9Sjf6KCeanmD0RHI1/rr1ZbgtlcUWZHVmwhVl9F46I+xi2I+kTNVXoWuD5hmchcbVrPwubi/aYvWxaTICz+s9VreElwAhRpLqzpSEVqsi1eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suTZ4O2wu+J5wN699up00Ce5gTe6wxTqSEWNHmUMAxs=;
 b=V8xdNSJXWy7s30JyjJOMZrcLBmhs1u8MvNDuxHbMPw541ACCIjuh1T0OBlkRrsoFFmFt3YsEps72zmJg61zZlLJ9dlcHi1oAZMLvUv3xBx74M7fj+LXklxc/APdrnRWGjWTZpkembUt/AJQxH6jjPFYMMvdaEFDUaBZD42NDc4GWZHBf8jdbDziWzStr4d0iq5rIKgOwI+bHMYjrv/bq9Zd2YUU6T3pUHFG+MpvwpkFefxUKuajRGxAnOsKozaq0OYF843x/2ftciYnbz0vDek+SVja8DhfhuzdcAFANW/z5DgsYNfBHCltt2N8T3PQ7srY2H/plhSFWfNGQJ+ovLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suTZ4O2wu+J5wN699up00Ce5gTe6wxTqSEWNHmUMAxs=;
 b=Sa4l3DTQHl8Taff8k0ijBzMleWJcVla7zbfA8lyEcjQswSLT25gCsn5GD1NQBSKItku3sdHY8CIcnVuFBDBXpA3ntn3u5AmBsMaQfo/3LWrnCPXIkNuIzmoV0wL23EDysk6NcDlRA2iPO+aAzq8B8d62mqVNJT30X96lY80yhY0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:03 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:03 +0000
Subject: [PATCH v3 01/18] hw/i386: Rename X86CPUTopoInfo structure to
 X86CPUTopoIDs
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:01 -0600
Message-ID: <157541982144.46157.2428083754645928332.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0133.namprd05.prod.outlook.com
 (2603:10b6:803:2c::11) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d340fb73-7849-488f-e5bc-08d7785214d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369DA646477DCDB7A5FC78D955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iS4FEOfhXkbYmpGxiC5cYem2NFX75M11IEp6fjq6CtRR6tDUBBHoTM5C7ZLzjih5rn4XaA8aT2RvZTSYNR+9xLaEn5B9Q8V9uVsIcctrnghqS9qpnaaB8y3SYqG7FXse3GItK+2ijX6TM0NQJHS7PyzkbqXR2ERzrl4uVzhRQldl+OpuJaxUQDIXHykPSIJF8KP6+SJYxsDeUwJfwYW0Bjq8p/oQWKsNDGUyWVqdeDXS/oE1OrT3FAjXqHEGC9lO/njKcPuvZ01doEnSCqTtCw2ifSY1wrkhb0lo5pDFeUrqIr+AZNHdoV0Tkm4bmGyBHz8rdLQSIDUBRj0GFNHEf3NTG8eWHQEND1WMAmPpi8TfaytNmvKKY20Kjigyq1eCunz578aZwm8LAazZiHcKuz1dBqQJyJWoyGCr6Rv58qBP61U+d6L/TMa76KlfdxI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d340fb73-7849-488f-e5bc-08d7785214d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:03.0443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gycZSFS4/kiXTd8+ryldCVUD2i9RZ2Vq4X1xbDed6AgKb8S91s9wbYgbbSRIqDab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.47
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

Rename few data structures related to X86 topology.  X86CPUTopoIDs will
have individual arch ids. Next patch introduces X86CPUTopoInfo which will
have all topology information(like cores, threads etc..).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c               |   60 ++++++++++++++++++++++----------------------
 include/hw/i386/topology.h |   40 +++++++++++++++--------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 51b72439b4..5bd2ffccb7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2212,7 +2212,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     int idx;
     CPUState *cs;
     CPUArchId *cpu_slot;
-    X86CPUTopoInfo topo;
+    X86CPUTopoIDs topo_ids;
     X86CPU *cpu = X86_CPU(dev);
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
@@ -2277,12 +2277,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
             return;
         }
 
-        topo.pkg_id = cpu->socket_id;
-        topo.die_id = cpu->die_id;
-        topo.core_id = cpu->core_id;
-        topo.smt_id = cpu->thread_id;
+        topo_ids.pkg_id = cpu->socket_id;
+        topo_ids.die_id = cpu->die_id;
+        topo_ids.core_id = cpu->core_id;
+        topo_ids.smt_id = cpu->thread_id;
         cpu->apic_id = apicid_from_topo_ids(pcms->smp_dies, smp_cores,
-                                            smp_threads, &topo);
+                                            smp_threads, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
@@ -2290,11 +2290,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         MachineState *ms = MACHINE(pcms);
 
         x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
-                                 smp_cores, smp_threads, &topo);
+                                 smp_cores, smp_threads, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo.pkg_id, topo.die_id, topo.core_id, topo.smt_id,
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
             cpu->apic_id, ms->possible_cpus->len - 1);
         return;
     }
@@ -2312,34 +2312,34 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
     x86_topo_ids_from_apicid(cpu->apic_id, pcms->smp_dies,
-                             smp_cores, smp_threads, &topo);
-    if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
+                             smp_cores, smp_threads, &topo_ids);
+    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
-            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
+            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
         return;
     }
-    cpu->socket_id = topo.pkg_id;
+    cpu->socket_id = topo_ids.pkg_id;
 
-    if (cpu->die_id != -1 && cpu->die_id != topo.die_id) {
+    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
         error_setg(errp, "property die-id: %u doesn't match set apic-id:"
-            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo.die_id);
+            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
         return;
     }
-    cpu->die_id = topo.die_id;
+    cpu->die_id = topo_ids.die_id;
 
-    if (cpu->core_id != -1 && cpu->core_id != topo.core_id) {
+    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
-            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo.core_id);
+            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
         return;
     }
-    cpu->core_id = topo.core_id;
+    cpu->core_id = topo_ids.core_id;
 
-    if (cpu->thread_id != -1 && cpu->thread_id != topo.smt_id) {
+    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
         error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
-            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo.smt_id);
+            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo_ids.smt_id);
         return;
     }
-    cpu->thread_id = topo.smt_id;
+    cpu->thread_id = topo_ids.smt_id;
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
         !kvm_hv_vpindex_settable()) {
@@ -2692,14 +2692,14 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
 static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-   X86CPUTopoInfo topo;
+   X86CPUTopoIDs topo_ids;
    PCMachineState *pcms = PC_MACHINE(ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             pcms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo);
-   return topo.pkg_id % ms->numa_state->num_nodes;
+                            ms->smp.threads, &topo_ids);
+   return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
@@ -2721,24 +2721,24 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
+        X86CPUTopoIDs topo_ids;
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(pcms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  pcms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo);
+                                 ms->smp.threads, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
-        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (pcms->smp_dies > 1) {
             ms->possible_cpus->cpus[i].props.has_die_id = true;
-            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
+            ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
         }
         ms->possible_cpus->cpus[i].props.has_core_id = true;
-        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
+        ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
-        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
+        ms->possible_cpus->cpus[i].props.thread_id = topo_ids.smt_id;
     }
     return ms->possible_cpus;
 }
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 4ff5b2da6c..6c184f3115 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -45,12 +45,12 @@
  */
 typedef uint32_t apic_id_t;
 
-typedef struct X86CPUTopoInfo {
+typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
     unsigned die_id;
     unsigned core_id;
     unsigned smt_id;
-} X86CPUTopoInfo;
+} X86CPUTopoIDs;
 
 /* Return the bit width needed for 'count' IDs
  */
@@ -122,12 +122,12 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
 static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
                                              unsigned nr_cores,
                                              unsigned nr_threads,
-                                             const X86CPUTopoInfo *topo)
+                                             const X86CPUTopoIDs *topo_ids)
 {
-    return (topo->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
-           (topo->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
-          (topo->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
-           topo->smt_id;
+    return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+           topo_ids->smt_id;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
@@ -137,12 +137,12 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
                                          unsigned nr_cores,
                                          unsigned nr_threads,
                                          unsigned cpu_index,
-                                         X86CPUTopoInfo *topo)
+                                         X86CPUTopoIDs *topo_ids)
 {
-    topo->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
-    topo->core_id = cpu_index / nr_threads % nr_cores;
-    topo->smt_id = cpu_index % nr_threads;
+    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
+    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->core_id = cpu_index / nr_threads % nr_cores;
+    topo_ids->smt_id = cpu_index % nr_threads;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
@@ -152,17 +152,17 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
                                             unsigned nr_dies,
                                             unsigned nr_cores,
                                             unsigned nr_threads,
-                                            X86CPUTopoInfo *topo)
+                                            X86CPUTopoIDs *topo_ids)
 {
-    topo->smt_id = apicid &
+    topo_ids->smt_id = apicid &
             ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
-    topo->core_id =
+    topo_ids->core_id =
             (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
             ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
-    topo->die_id =
+    topo_ids->die_id =
             (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
             ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
-    topo->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
+    topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
@@ -174,9 +174,9 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
                                                 unsigned nr_threads,
                                                 unsigned cpu_index)
 {
-    X86CPUTopoInfo topo;
-    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo);
-    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo);
+    X86CPUTopoIDs topo_ids;
+    x86_topo_ids_from_idx(nr_dies, nr_cores, nr_threads, cpu_index, &topo_ids);
+    return apicid_from_topo_ids(nr_dies, nr_cores, nr_threads, &topo_ids);
 }
 
 #endif /* HW_I386_TOPOLOGY_H */


