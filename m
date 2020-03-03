Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B0C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2332073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h7V8mocw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2332073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DiK-0005Fn-Ur
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfE-00088v-0z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfC-0002vB-8N
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:11 -0500
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com
 ([40.107.244.84]:6034 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DfB-0002uc-KL
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqvn2Mj7tWVnd2jZ2ahJh3k/kVCY87nsgS8Z4+yccg3U3cqlTw0lsh19RAnf9owaflSCrjY7rpxNgXFzOCbUc2tAdyxTJd3467i5tfw9tjZ28jLmhHxqlxF8JAXUQhRao5iXsk1iIfO3mFiWciFD2BIBdTP3vh0xB229JD3DIiyWvV1KPYF6K/Zu29HtYkkEZsEvwpVEq6wEQY6gC+Rx5j/YYYp+bnorzEJT29ZX5uthJ913NqeREEkzB4HTQncECx3HaBGHZeL19EgJNIU0uiZBrovmGeGRx2yHTd5GKPKslSvpsRLiQqQs/w/cR6ihIMZr4was6ppjoWwNpPM2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5afSzfhXe+Q0IL8ZUhihzM/CWBnrbHmzSyboKS1nVJY=;
 b=Jc1A+tSmZDQMqByCTH7CHDCE1vQ5Y7xl3SP5mlZT68MKyTj44BERNKo9YT9+4dExWHOfJsqLvW+2FAVl64WBoIDt6A2wBo0kgTjsk3ewL6bD1pv6MGjBfc6bs0JKXWgtU826iLx8zuf2Sjn98N7nb0+oE5X0K3o4naK1ekdJP2dx2apJtxff2YM4MR38H/vyXHlKMkbyI+3m0I79rdbsKzigTu1tdWdmOY4qAr/QCksm68JC8Rj20Jm/L1HRn2OCtI2sMH7ucbnIb3xrVQJ3x8Y9Psbh7YR8YAkihElgRcSEECzEkYEi+8uAdruCrtowcfZvaj/Zx1ETlQ8nJ+VHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5afSzfhXe+Q0IL8ZUhihzM/CWBnrbHmzSyboKS1nVJY=;
 b=h7V8mocw/0cgvEuL6NRE0Aqnq4rryzzhJeDNVQ5+R0RJtX4gUccTUfh5FoCFwZaNJO2DyUMhLAV14zaKo1VKThPX/BlRrd2ox6PH8a/UyZ2pga4jepleYMmUO6CGnTA/2sm+YrpCrGGSya0cc04/A641OjbJvCxtIEbJfQmx2YM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:06 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:06 +0000
Subject: [PATCH v5 02/16] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:05 -0600
Message-ID: <158326542572.40452.15331466265190906874.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0084.namprd12.prod.outlook.com
 (2603:10b6:802:21::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0084.namprd12.prod.outlook.com (2603:10b6:802:21::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19 via Frontend Transport; Tue, 3 Mar 2020 19:57:06 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d8c6974-6e0b-4af5-f26c-08d7bfad0d14
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:|SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2382D013440B5EE06164C54E95E40@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(186003)(8676002)(8936002)(81166006)(81156014)(26005)(16526019)(5660300002)(478600001)(86362001)(52116002)(7696005)(956004)(316002)(2906002)(66946007)(66476007)(44832011)(66556008)(55016002)(4326008)(103116003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2382;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eINom45hl9TIV8lAB60nCs6o19UzZg+BHXBvv7iX1eTLXntE60YdwGyavUTeZCM0bdyy3Wv83Gy9pE47hae2h7wVPGucC4CSaREdXX4Hda8tSGUSSAWyQ/2YeU7XHuJ4CY1aNhO8qOuln2OrFBF2laf7SLMAunldurOGeP4F5hU3VCvl0+Jw8JGcn0RaMVuFdHIrE7/Uasu2dtx11wIB7NViy//r74V6LpwpBLu+dqHwjcqq33So/pp/vjgEwwHniIG7O8N0e+n15w39I0mY1+6mzkh4YI2R4tt38vjSbnh3/9mWXd5VzfzEs/baCVCMrayql4/z1xN6Lny3YSzdriwMzOhgS5h8Z3HuQs2zuENKioMJVqVzIeAfLjZRlkI/AqSLqX0ANMG4xCkL/wkZRgHE/cUtt4jm7ugIj6YnlsTYNh9tU4MDWyErbUmceL2
X-MS-Exchange-AntiSpam-MessageData: ZFG2czGoWObRG879hDqaubwwCvOK1yYt7rh2w+CrS+iwXsNjEaI/ZJTPLbYUSqsoGEExEZKhScbP0CQQzcLU89ePesEcwq3nADA/EZXGvn3yQwxJ314SkNj29uK169dNbVNj1ZE3XTJjTs/tRaeoNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8c6974-6e0b-4af5-f26c-08d7bfad0d14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:06.7427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDuDK+dToFTUoek5oHBDCoO1X4FsISwpAtmScefuwerxcAD24KqOB8F1LRAvTJft
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.84
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

This is an effort to re-arrange few data structure for better readability.

1. Add X86CPUTopoInfo which will have all the topology informations
   required to build the cpu topology. There is no functional changes.
2. Introduce init_topo_info to initialize X86CPUTopoInfo members from
   X86MachineState.

There is no functional changes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |   12 ++++++------
 hw/i386/x86.c              |   32 ++++++++++++++++++++++++--------
 include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
 include/hw/i386/x86.h      |    3 +++
 4 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 715f79f58c..ef23ae2af5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1514,6 +1514,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     X86MachineState *x86ms = X86_MACHINE(pcms);
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
+    X86CPUTopoInfo topo_info;
 
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -1521,6 +1522,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    init_topo_info(&topo_info, x86ms);
+
     env->nr_dies = x86ms->smp_dies;
 
     /*
@@ -1576,16 +1579,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = apicid_from_topo_ids(x86ms->smp_dies, smp_cores,
-                                            smp_threads, &topo_ids);
+        cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                                 smp_cores, smp_threads, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -1606,8 +1607,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                             smp_cores, smp_threads, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 322fb6abbc..03b8962c98 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -57,6 +57,16 @@
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+inline void init_topo_info(X86CPUTopoInfo *topo_info,
+                                  const X86MachineState *x86ms)
+{
+    MachineState *ms = MACHINE(x86ms);
+
+    topo_info->dies_per_pkg = x86ms->smp_dies;
+    topo_info->cores_per_die = ms->smp.cores;
+    topo_info->threads_per_core = ms->smp.threads;
+}
+
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -68,13 +78,14 @@ static size_t pvh_start_addr;
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index)
 {
-    MachineState *ms = MACHINE(x86ms);
     X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
+    X86CPUTopoInfo topo_info;
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.cores,
-                                         ms->smp.threads, cpu_index);
+    init_topo_info(&topo_info, x86ms);
+
+    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -145,19 +156,22 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms = X86_MACHINE(ms);
+   X86CPUTopoInfo topo_info;
+
+   init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            x86ms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo_ids);
+                            &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     X86MachineState *x86ms = X86_MACHINE(ms);
-    int i;
     unsigned int max_cpus = ms->smp.max_cpus;
+    X86CPUTopoInfo topo_info;
+    int i;
 
     if (ms->possible_cpus) {
         /*
@@ -171,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
+
+    init_topo_info(&topo_info, x86ms);
+
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;
 
@@ -179,8 +196,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].arch_id =
             x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 x86ms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo_ids);
+                                 &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 52def68610..7ea507f376 100644
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
     return (topo_ids->pkg_id  <<
                apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
            (topo_ids->die_id  <<
@@ -136,12 +144,14 @@ static inline apic_id_t apicid_from_topo_ids(unsigned nr_dies,
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
@@ -152,11 +162,13 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
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
@@ -173,14 +185,12 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
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
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 41fe37b8a3..22babcb3bb 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -21,6 +21,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 
+#include "hw/i386/topology.h"
 #include "hw/boards.h"
 #include "hw/nmi.h"
 #include "hw/isa/isa.h"
@@ -82,6 +83,8 @@ typedef struct {
 #define X86_MACHINE_CLASS(class) \
     OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
 
+void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
+
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
                                     unsigned int cpu_index);
 


