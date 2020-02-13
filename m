Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D18C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B5D21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B+C1T20x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B5D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JBV-0004K9-MH
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2b-0001M0-9K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2Y-0006aK-J5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:44 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com
 ([40.107.236.40]:6190 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2Y-0006V3-BP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsapkurmnSXSarqb0BcoMfnctfulCf62DpW5pHZDpSicLDkDWGZBj2ihyf0oMWxHskTlZCMYlw7NEQ74b3y7jlqvlZCZbIwl2u1MrP/yWbg35ua8R6+6ILKjSCs2bc8cT2HI79uurZi3YA+uU9bR/urwHfqUkTc39D9qgxUFPgVV/NdTzOKsQJDMhSHScjnXlf6EGrbmIRhaeR3+VrB5+UTKogGSiXVF1ROg929v40o0zLwikYfWnUeNMnzwAJf5CR/j5Pv/f325SmAcmsEIpyYADo+ZQLpqkAzdl2NZaiqdj7skSrmUjITM/YKBaSVSp3bmlrKXWuLFFRFlot8feQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JBnXuL23nzX8rI859rHV1vReYZyd+7QMk+8MF/BJ5s=;
 b=RcnFIIu08am6ePr3Btkw8jsTVF1rLwnmk21HPMXBnLglE0nHBixraY8jAkyMlLjE7JEh8UJeTHZADewilVRCIWmxZYcHR8iqi5HPHy7XhkSthbSDzJvoEAPrz9Cyp2+25Gzh4t1aJxNw2obBwCaZrWmlsUY4o9hqcoF6k+nm98DqEadHQBhtUbPdbtRhpjnRihlh4UhxdLyWypusgwW596yfzmpYI09BUnmX/wit00BettjJ9WaD9q2lqrAKQquK+FsXzS2SouO7ARhyGjstf7SXQj/KYP2m6gR9wSwyGpneEVeEJDuogewS+R5+JuZO/Xlt0j27w2OSrzImDFmX3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JBnXuL23nzX8rI859rHV1vReYZyd+7QMk+8MF/BJ5s=;
 b=B+C1T20x0jrG3RYf0S/DLRwxPF/e5dUn0DWaN/6IdnV9NzCn2jCsNpruOJVv+BdPdXILAwaANJV+A/X43ryz5QVlgqUlUfUmpSJor6LEmZqEng39qP1CA7ux+gArHAI9Z6fdsTey0Xi45QIKF/6ozbKLrFrpiGWnMY324QHhems=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:39 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:39 +0000
Subject: [PATCH v4 02/16] hw/i386: Introduce X86CPUTopoInfo to contain
 topology info
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:37 -0600
Message-ID: <158161779774.48948.3579168862801203963.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:805:de::32) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR05CA0019.namprd05.prod.outlook.com (2603:10b6:805:de::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.18 via Frontend Transport; Thu, 13 Feb 2020 18:16:38 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 568460ee-748c-4286-41ec-08d7b0b0de96
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB131869AB52B7A044D3B5E7A4951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
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
X-Microsoft-Antispam-Message-Info: U2lFcjZVbGlpFxgFOd/7C70pNf/++QxjCRhVTKuGgiRRnph7+WapHtpXfFhPwGDJIDi7pSdZQd/V7gegBt4215ptJh7VG7ZLsebS/Wg/YFHADwhTqh29qxQbxIu5RaBkMTn1hIkMU8vrtmLyeOyr8Al5Nq3dXoZm4MtjTC6fnq7fT95KfCJOH+H91P6RY7COs/ePpDO3dICLVebOG+ypit8LjQh2/l0UIVXSzVaJ2xd2adkqmzXKBBpOJuc6t6cI67hzl/C5A7w0pZ8vpST9zsACH9NtMq+41pvjQjfaSHEBT1+8K3u6MX5xFn2uv4n//9I+F8Laa0JXWVossSm2b008Gx5zj6DJDF+n+I1IExaT3ratkvO2CHGU0ju+mY5Nho3q/u1XqeMJILFN3BA4o/HqIf9Qis9LEhTH0QCdp6cvZXj6JTirO3KyFcX4uuuM
X-MS-Exchange-AntiSpam-MessageData: NiQGtoxtvEbfPWrAG8CpSFb1eh3EursYBP2o8TzHsEy5XDyWM0z5jqJ60e5AvGXO67LU+I/GnFlibHVaU4NGV5C4uaa2EMCHsSuEYPcrl+qEFJcAEm2708XBHuSQuC2y1gs67ihUAbVhx5LxKpYxgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568460ee-748c-4286-41ec-08d7b0b0de96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:39.2735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqxuCnpWZzmouDYO5smAPkAfVItyFKNHe7xRx9gqfmlT5O+thAP2MzL48FhtUCoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.236.40
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
Add X86CPUTopoInfo which will have all the topology informations required
to build the cpu topology. There is no functional changes.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/pc.c               |   14 ++++++++------
 hw/i386/x86.c              |   28 +++++++++++++++++++++-------
 include/hw/i386/topology.h |   38 ++++++++++++++++++++++++--------------
 3 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3a580f6a60..2adf7f6afa 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1741,6 +1741,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     X86MachineState *x86ms = X86_MACHINE(pcms);
     unsigned int smp_cores = ms->smp.cores;
     unsigned int smp_threads = ms->smp.threads;
+    X86CPUTopoInfo topo_info;
 
     if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
         error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
@@ -1748,6 +1749,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    topo_info.dies_per_pkg = x86ms->smp_dies;
+    topo_info.cores_per_die = smp_cores;
+    topo_info.threads_per_core = smp_threads;
+
     env->nr_dies = x86ms->smp_dies;
 
     /*
@@ -1803,16 +1808,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1833,8 +1836,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                             smp_cores, smp_threads, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 4a112c8e30..f18cab8e5c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -65,11 +65,15 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 {
     MachineState *ms = MACHINE(x86ms);
     X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
+    X86CPUTopoInfo topo_info;
     uint32_t correct_id;
     static bool warned;
 
-    correct_id = x86_apicid_from_cpu_idx(x86ms->smp_dies, ms->smp.cores,
-                                         ms->smp.threads, cpu_index);
+    topo_info.dies_per_pkg = x86ms->smp_dies;
+    topo_info.cores_per_die = ms->smp.cores;
+    topo_info.threads_per_core = ms->smp.threads;
+
+    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -140,19 +144,25 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
    X86CPUTopoIDs topo_ids;
    X86MachineState *x86ms = X86_MACHINE(ms);
+   X86CPUTopoInfo topo_info;
+
+   topo_info.dies_per_pkg = x86ms->smp_dies;
+   topo_info.cores_per_die = ms->smp.cores;
+   topo_info.threads_per_core = ms->smp.threads;
+
 
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
@@ -166,6 +176,11 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
+
+    topo_info.dies_per_pkg = x86ms->smp_dies;
+    topo_info.cores_per_die = ms->smp.cores;
+    topo_info.threads_per_core = ms->smp.threads;
+
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;
 
@@ -174,8 +189,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
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


