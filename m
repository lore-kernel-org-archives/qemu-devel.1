Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A18C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E03D92073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 19:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dDud1/bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03D92073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9DgQ-0001lt-0W
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 14:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Df9-000830-75
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Df6-0002u0-B9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:07 -0500
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com
 ([40.107.244.45]:25633 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9Df6-0002tj-13
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAR32lR+bsfMF7Ew4cpX9fvw6vLyhahtcKSVEobb8nhhHQTlnODzmPkiRGXcRK/mtiOGrUQJKehdGwKD2QhhRvx7DbQtHNN4Jcw4dvEXm92eD05D8bEHciybddKmpZsowYXSlbgPqQKAdbEKiICO+RyOiyuRu0cPnSAdgqr8/Q2XNyOVA2d6g2IdtcctRyoW/N8NQDP9ygjzVnwNCPbHBzy8Nzx42F58XVfaIspQ4AVUkPgr8dcQ9liGBWPsy+H/UHpslnzeQ06vo5YjocKzgmaTpACXFmCbQxs2ykbCqRh5ghCna7SXHoWHYcyA8dTu4ax1lChZ2ncDskh70Ocm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxKAxNxgzF3wHaoeHlASpyHZB/3aHfo5uditPKr51uk=;
 b=D849TgqMZVDP/DChGmWLoInzUG3v8T1W1o5O+zfb0JuOAeZbttKP2sKNI+zb7U1oufO8Z0Mku+Ajos+R4BVPm30Ol5+FCEr0vz9SLtMk4bewDjVOtGpAD0dZi10eSG3JZ3RlJ568EMtqROomsfudRIwj+iQ/7XdqsQQBq4gg6lzL86TrEvDvfD0x8AE1w9vgtdoNHjbpfD6L4XgPygO/5YLHr5Qi8TmqVsa8b3+K7IKlDvTWzOSDKC2mdRSdlSVmHkeQkSMQYBV6aBm2WW5vC0jrbhWvzu/4693ix5gWVaw/PLd33wfeWDhS+FX7F+w3mQKxX/TR5u27pUdZ6rcSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxKAxNxgzF3wHaoeHlASpyHZB/3aHfo5uditPKr51uk=;
 b=dDud1/bVI0x6V5I/XfBuk2hcwfvtAtO/Nn24D/uW2MkNfrzLYt+yCjzNXtx161x/HL9R+RNxDSvyBp30efMTc5fV5QVe7zKsWXg8m3Z5jJssqM1x6MaZ8YLUWaqT70EqCv4yOi5G06jzxmQhNgf2bQZhpybNTvsN1wIcA7jUsr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:00 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:00 +0000
Subject: [PATCH v5 01/16] hw/i386: Rename X86CPUTopoInfo structure to
 X86CPUTopoIDs
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:56:58 -0600
Message-ID: <158326541877.40452.17535023236841538507.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0045.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::19) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR08CA0045.namprd08.prod.outlook.com (2603:10b6:5:1e0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18 via Frontend Transport; Tue, 3 Mar 2020 19:56:59 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5620e198-76f2-41d0-8a31-08d7bfad0952
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:|SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB238226D33A3BB6FB80DC45FE95E40@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
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
X-Microsoft-Antispam-Message-Info: 3GBAXM5J/R912Bkp0yYX7+unMOV5czcXAc4HxAevekS3NCGpiFhENK6oHQ09HJZL5jG6d+vcOIieZQsD1Y20McMSvWQaDTMpkkmCtkielPsBxTO7xtZs3Fxk+RezWJWqMYLAlljRMM1o6OrqtUiKxAGmgca9ZhDXHkz6meLPCf/Iqep87AEXSgMlr5gvMvnCDO9elx9MFCG7vkPki5Vpdss4l4VJV4lfOQSGa8fyq3eX9YX/4ypTfTjEzqagOMlzbTAAUVLtKJpnSZP858F8RSgqmZDiAoiMpIMpYC+Z94ly43Gl7H1r0a2mH84+UEaKTOmdOyO3KCsOaAYQIElbTUxx+QskwXfDlQHy0aElyFdd21+xY2431V3F8vZ8psNG8uO90Ul/VrSy2TSv1rxHBS9n3ICl+48rcIKaS8mFKvsnIrrg6eZ7q/95bO2DxDIG
X-MS-Exchange-AntiSpam-MessageData: 1vVrURFGqXepC3kDuc2bvD096jvZ5ixzq9c/cf/Ws+vmyRO3C/G4JcfWlNYBZbnIFeOIUSi3sKYZdFn+y0JQPMYmbS7Ti47NeQ4K9p3DaxKD4dqmayqLfxLNvLhOyt4eFkdsSuNXwRrK6dcNqaUQdA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5620e198-76f2-41d0-8a31-08d7bfad0952
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:00.4605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVr79lu/XN3vmM1AKJ61V8cia8otdZozxC4I6s7mqwl0xVZJaZCTvkbSGLpvnKa5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.45
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
 hw/i386/pc.c               |   45 +++++++++++++++++++++++---------------------
 hw/i386/x86.c              |   18 +++++++++---------
 include/hw/i386/topology.h |   44 +++++++++++++++++++++++--------------------
 3 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ddce4230a..715f79f58c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1506,7 +1506,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     int idx;
     CPUState *cs;
     CPUArchId *cpu_slot;
-    X86CPUTopoInfo topo;
+    X86CPUTopoIDs topo_ids;
     X86CPU *cpu = X86_CPU(dev);
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
@@ -1572,12 +1572,12 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1585,11 +1585,11 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1607,34 +1607,37 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
     x86_topo_ids_from_apicid(cpu->apic_id, x86ms->smp_dies,
-                             smp_cores, smp_threads, &topo);
-    if (cpu->socket_id != -1 && cpu->socket_id != topo.pkg_id) {
+                             smp_cores, smp_threads, &topo_ids);
+    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
-            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo.pkg_id);
+            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
+            topo_ids.pkg_id);
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
+            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
+            topo_ids.core_id);
         return;
     }
-    cpu->core_id = topo.core_id;
+    cpu->core_id = topo_ids.core_id;
 
-    if (cpu->thread_id != -1 && cpu->thread_id != topo.smt_id) {
+    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
         error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
-            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id, topo.smt_id);
+            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
+            topo_ids.smt_id);
         return;
     }
-    cpu->thread_id = topo.smt_id;
+    cpu->thread_id = topo_ids.smt_id;
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
         !kvm_hv_vpindex_settable()) {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7f38e6ba8b..322fb6abbc 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -143,14 +143,14 @@ x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 
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
@@ -172,7 +172,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (i = 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
+        X86CPUTopoIDs topo_ids;
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
@@ -180,17 +180,17 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
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
index 4ff5b2da6c..52def68610 100644
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
@@ -122,12 +122,15 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
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
+    return (topo_ids->pkg_id  <<
+               apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->die_id  <<
+               apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
+           (topo_ids->core_id <<
+               apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
+           topo_ids->smt_id;
 }
 
 /* Calculate thread/core/package IDs for a specific topology,
@@ -137,12 +140,12 @@ static inline void x86_topo_ids_from_idx(unsigned nr_dies,
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
@@ -152,17 +155,18 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
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
+    topo_ids->pkg_id =
+            apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
 }
 
 /* Make APIC ID for the CPU 'cpu_index'
@@ -174,9 +178,9 @@ static inline apic_id_t x86_apicid_from_cpu_idx(unsigned nr_dies,
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


