Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3E4C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967A72074B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IE7TZZj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967A72074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAGp-0003sV-KD
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEo-0000RG-O9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEn-0006KH-AI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:06 -0400
Received: from mail-eopbgr750049.outbound.protection.outlook.com
 ([40.107.75.49]:45878 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAEn-0006JE-4i
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Di4R4p+DpoO1siUaMLztprq+/1zDGsELcNH2j0gEaDzjB+V8seMcCUvgbVXlCRm9Xd1wOHWUoPCaFBPkKYBydOPdWyUDzpgWYp8bHGBBt2+LnPFODvxK3H+gl1kfAtSjibPhSp3qSSYoLmlxAJw7N2eEoM2qvfYu40Az2ePXlH5SAP8VL4RL4o7OQAVX0kz1HVUQBDLctWz1bFSXvPSVbSbkz31YcQ+kMoVd+w51CjLun+KcQMD/vYYDVXk+eN422syUFZ3hEr6ml1YvJ3j/84Z2XV2+kK7MhWtDhq/Dqlf2p4J7N0LLKM96uN7FU2Nj1OR4/TwszcVpWNyJB6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBK7AhF4nsw2ytXwGEO6Z6sgbh4u7psNTW9Tt3Bkf6U=;
 b=ThLiwHF+pYXVO5fVxaKMc3fGkoM6aul7tSMTARhUxOJIBTFsg2ruc0L2lAZMlvc/KeyUDHptSl7BA+HCrk1RJQuriqlDaTlR5T9w5bGTVKf2Kd7Fg6GCxf8+32ku46IBInEgsiBHGQ0VjN5iq3TKGFLLEJT8B4Jly+eumfjO8y6LAXkP9IwCYginhuYsEbtDzFkf09v9KIaQd0D+UHBnJZAHSx/lOqyqGhCjr2zkJj07vZkP6UiF/Td5MamaeUDqnA8QB8EcKIXPJltapwcDxhW6c8VQ7/4eQd/wNqgJvRapBhnQ+6TYsv0gr3rwVb/3CCs6gre+crEQTUxRkxl+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBK7AhF4nsw2ytXwGEO6Z6sgbh4u7psNTW9Tt3Bkf6U=;
 b=IE7TZZj2DT66r3tB4GEg7lJLntDArrxF18DliGOZ44OxyiP+f9Uw1Aciyxc/IEP845MsIMVGhekEHPw+GET1Tdc+8AA5lRnuLaP0Gz5Fc0YXy8tRUeQt2pCioWF962CcNG/k4ktThfFdmtpWHFhsHowf0rQJIWqgT7JpuedAp+0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:54:04 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:54:04 +0000
Subject: [PATCH v7 11/13] hw/i386: Move arch_id decode inside x86_cpus_init
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:54:02 -0500
Message-ID: <158396724217.58170.12256158354204870716.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:3:13d::22) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR20CA0036.namprd20.prod.outlook.com (2603:10b6:3:13d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 22:54:03 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ee0ab38-1052-4cc7-0a57-08d7c60f18af
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB234948E154244407D1B6053895FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/8Q8cUmBhx5/pyK39TbCe0VJB3ImVfcr96DvXEUm64Ogazp05yrFUcCYul7OuXaFI2dmP53wo4qfPJZ6YAq2gyb1IHM/gcndC3+eINZKYF3nyom1y8/J6R/766dHe+sSmMp9DIY2XT9PJpNPI9XhQQkwo6P13jR/IqlDQTCQH2jtGdL89qdrgfTzskE7KuvyBs9p1mWmh4gCKRHQzdWbqwIHze5UeCmpR5o9736FdTG3mM1BzJqBOvJFHMcDfKWxvO8stqjDsjwJk+ricn4MQrjhCadpJ55/bgbsU+h9wFfrRPjnjWOH1JJgop6/wxl81ZR7TIQKLw4A/Fpo1j7Wwo9f5RLVrtxxje6vNw5Mlb48uUHz99Ma5wlIGwrPbjb8zX0cCLf4Bp3OI+dDUvz/9X1Y2cJYOl0f7eNaoLfrYnmvSvaXtjPYiCwlYixoEuD
X-MS-Exchange-AntiSpam-MessageData: rsc15e2mdlHPDkaDyYiwBGgsK1Sk6Kp787l4e3JVudX26oVFpkipFkI2gBJAIW7+ECJ1IsmaoefUjvkr1xwtQD9vGuO9rvvJnY6BSk0ieCQCj1jDliptaKv5LjdsumJ5FLB9EqT9CEFXXzQBMg19Cw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee0ab38-1052-4cc7-0a57-08d7c60f18af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:54:03.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNGVHagJ4jkz4tvTMocSLzO35O8WmUcsJ0YaF+ib1unptpgMnfxRNo7xrMDSGqAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.49
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

Apicid calculation depends on knowing the total number of numa nodes
for EPYC cpu models. Right now, we are calculating the arch_id while
parsing the numa(parse_numa). At this time, it is not known how many
total numa nodes are configured in the system.

Move the arch_id calculation inside x86_cpus_init. At this time, smp
parse is already completed and numa node information is available.

Override the handlers if use_epyc_apic_id_encoding is enabled in
cpu model definition.

Also replace the calling convention to use handlers from
X86MachineState.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c  |    6 +++---
 hw/i386/x86.c |   37 ++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 10 deletions(-)

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
index 0a81ab5151..023dce1dbd 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -68,6 +68,22 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
     topo_info->threads_per_core = ms->smp.threads;
 }
 
+/*
+ * Set up with the new EPYC topology handlers
+ *
+ * AMD uses different apic id encoding for EPYC based cpus. Override
+ * the default topo handlers with EPYC encoding handlers.
+ */
+static void x86_set_epyc_topo_handlers(MachineState *machine)
+{
+    X86MachineState *x86ms = X86_MACHINE(machine);
+
+    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
+    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
+    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
+    x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
+}
+
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -86,7 +102,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -121,6 +137,11 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
+    /* Check for apicid encoding */
+    if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
+        x86_set_epyc_topo_handlers(ms);
+    }
+
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -134,6 +155,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(x86ms, i);
+    }
+
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
@@ -158,8 +185,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            &topo_info, &topo_ids);
+   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -190,10 +216,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 &topo_info, &topo_ids);
+        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {


