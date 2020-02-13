Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3001BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E699A206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zbb/6A3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E699A206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J3y-0003Dx-3y
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2V-0001F3-9b
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2R-0006J0-He
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:39 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46]:6216 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2R-00068Y-5A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez1Uid/PZuqxkVcREbshTjqM2zsDIFn7QkGHVG/pq5OBtO33IF/Xvro6qFgpr/Nvu3dmqC6fwT9aPIHopphyIxdUZgxVSN1kmeZDFw3FFSOskKlT/sxeCYjPpwM6KP9gBm37Qiiue41onLs7E86yA7zwej/xAM0BMY2RaSLUFEPQm59cc6gbW6O4CTehlpVy0hP4CPzSg+GOQK2QIJmtM0hLHVssxpUOdnokNh5rmSefBvidmasWGZxkZLUwLnMV7v8h5W49v+rftaGIrRoWn4ZoKr8vkZzsqLZMJHxo8vJjy7UONzVzleVNMG79L3ERxbVMT6BrdnEUfy4ttotPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzMci3Q5XJCGEeio/uBn0T3rZ7Gf2qCX06cUe+Ju96s=;
 b=lNc3J6ChcK1rlYrv+TxVezEUWOir+FQth+OE6TcCwypwRUIZTrkn135EHPnsLHCiCZ8vUZ201Kdipd48m1OYZe3Rg2KLOWUMAjBZKfRcQOnpHs0jPnzFXElPWUWDXyoSc3Euj3bCZ/80I+5vmMk1e2OUEptmalghF3Qn0GXs12BOuwxm/mrSaW//hBJKi/TudiRi8w0wWZnAU05PL/ZoBgpVfU3JudhGTLn9pr2fxiN//PZsdU/irw14gqM/yPtWjWP5eaj/rTVeozmcegN3jmpZalO6xpLkhfihi83HMFOPcAku9IM8lCq9ET9zMq5Llc7cVXTnyzUoOka267rCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzMci3Q5XJCGEeio/uBn0T3rZ7Gf2qCX06cUe+Ju96s=;
 b=zbb/6A3rUx7AGjo4eoUFjUST3qHBrBzCRc9RmM1t6LxvubZvfGPPp3L/wpY7xPQxcBxhG9qKKCVPXmA4ZYkz0vMPu/f5I0P2tS2WQsKCwHid3vE6U6okuh4HpYvJMDyH+49f+yeF+DBhQavPJdPXaexdcFyawv2hY8HV3ODKDCU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:32 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:32 +0000
Subject: [PATCH v4 01/16] hw/i386: Rename X86CPUTopoInfo structure to
 X86CPUTopoIDs
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:30 -0600
Message-ID: <158161779073.48948.6547974317266276442.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0059.namprd07.prod.outlook.com
 (2603:10b6:5:74::36) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR07CA0059.namprd07.prod.outlook.com (2603:10b6:5:74::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 18:16:31 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e29b569d-2e03-4bc9-b796-08d7b0b0da8b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB13189A3AB31A5C91F34ECBAB951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hm8mXPTuet02JHj/1pvMnNJg8GRLzCMhsprgCZwB10RWjvC7yNnXtKYcNxHQhQnJxLjg2epnm7kR0uG8G7PNUTGHmZuozQfJkdRYNEMtmldt1F6Xn8zWKxJd+NRDvG36j2yiGGMaPa9ILG/oHMlRonL6c/1lxP04yz1t9JMGvopLx/yhYZ9d1GyMAwpruIWU48JzheZwqVSawQ3goTRXchGcwKbm56X5OoZuT8ISzm7KZ3FMFvspf7M5gDfHNyNoY/UTps/Pf2ByTCFmr9ITHL/iHOQddhBYgMyKmNYV2IMDI3xHJEdIQzmCVHt2V4ln0AEn8LepOxaS+GYdlJERtBVLtEk+OPRM0O4fRROYXLvHbspJePmi8UMDTzFDxuG2n3T3zZ17zmGnH/gdzbCW5luAuh1iCqI0sUZfpue8Bd36GRtovOMAcolu88v9hp0z
X-MS-Exchange-AntiSpam-MessageData: uQU9KP3BEmzQfizIq0nh6EI05YgPQlEBlbUfRCkZ7KJAqXNEpqsGd/SDXQ1e0sIhna4Bym2UeYwq/tZewuUVJLuv9xfYdI2wMWpqOpQE2uI8l70eMRLmJeaJfEvBWlhbZq/VZkChhpuFlxyml5du7Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29b569d-2e03-4bc9-b796-08d7b0b0da8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:32.4996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iK2ACGj2hwYQq1/1/ccvzaHzS+qv1ibSNqfJovBbtWZDpkXrqea/hrJLC3AicSsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.46
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

Rename few data structures related to X86 topology.  X86CPUTopoIDs will
have individual arch ids. Next patch introduces X86CPUTopoInfo which will
have all topology information(like cores, threads etc..).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c               |   42 +++++++++++++++++++++---------------------
 hw/i386/x86.c              |   18 +++++++++---------
 include/hw/i386/topology.h |   40 ++++++++++++++++++++--------------------
 3 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 58867f987d..3a580f6a60 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1733,7 +1733,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     int idx;
     CPUState *cs;
     CPUArchId *cpu_slot;
-    X86CPUTopoInfo topo;
+    X86CPUTopoIDs topo_ids;
     X86CPU *cpu = X86_CPU(dev);
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
@@ -1799,12 +1799,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
         cpu->apic_id = apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
-                                            smp_threads, &topo);
+                                            smp_threads, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
@@ -1812,11 +1812,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         MachineState *ms = MACHINE(pcms);
 
         x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
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
@@ -1834,34 +1834,34 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
     x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
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
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 394edc2f72..4a112c8e30 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -138,14 +138,14 @@ x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-   X86CPUTopoInfo topo;
+   X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms = X86_MACHINE(ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             x86ms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo);
-   return topo.pkg_id % ms->numa_state->num_nodes;
+                            ms->smp.threads, &topo_ids);
+   return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
@@ -167,7 +167,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
+        X86CPUTopoIDs topo_ids;
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
@@ -175,17 +175,17 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
             x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  x86ms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo);
+                                 ms->smp.threads, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
-        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {
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


