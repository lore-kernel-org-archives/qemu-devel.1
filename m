Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1129620714
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iQ4Mllfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1129620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Doq-0008NT-7n
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgE-0001yL-Ab
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgD-0003MX-52
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:14 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com
 ([40.107.75.80]:17038 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DgC-0003ME-VC
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T36tzclmBouQUsUozpmsfHAQxFt4mbWksy2qlX7wQ+SNOO7YPkubHXnmL/Pyxg8Cgj5xeOGN9+7kU061M1k534SvqRhlnxNA5k5RaqW0uxCOhRvE/3HMcfphNr6y/0IDiaK2D/9j1DbfAI5At6jI1imP1PhiD630J+DeIHl70AeSx5PUk3ONSbZUftynG6dmNdHrAukx30kZJuIphfiguYR/ILkfoGH7lpo2XtlT5OHBGZjq6YWM+923M3DJqkloOEZ9D/XL3GlI7MnS5KGCItJhBRYlqDM1s6lvnGqw1TwcQkFQDx+8DFOSPZkJ6Uq/tE3vdEyE6mhdjcANgCEKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4MRTCgeO9CNedx9KR/tPEvUxAx2M+BlFOsF2JihnMc=;
 b=LLfriGqA0PbqR06L4ngXvSQLnk/0SAncoPHS6H0G7LxazkItQclv8xQmbqulbhPArKazWFPJ+vDVjKadKzyKSaJm49kmx1LQTZmdFdybYMDRjAvR9w6rvZD7fxRRBVEn2sHHeBy2PL4IrdcKB3ifp1m2vWDmKVuDvTeXuY2035tsKSTgQMIDdukmVUeLPIIC+SjF70D24ORw49+oz+aL+2PIC2ZX2OQN/AXAam/ZBfb9EKTNleaklG/2/LYQeQB/132yb9IBpv+iQto1LN3oGtMU29i33QFK3IxIddR+5Er00usZa7h0cbnsI1FP9vjptdtVMyxDuNxeyhKXMpWm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4MRTCgeO9CNedx9KR/tPEvUxAx2M+BlFOsF2JihnMc=;
 b=iQ4MllfiHCQf4ss+3HrHt4EvEv2dcLaTnXMWJjwin75yzcacTdkrqoJ1snVZ06wAWv/xgTu/i9VPdZfv/z7djZBeR2XzkfIBXvORBdePVHs+KxQtIuzVnX8TebxSFwo9IzSGzpI3o8medPxe6HZOmrD9QT2Q5MOIUhgnL0ZBRls=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:11 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:11 +0000
Subject: [PATCH v5 12/16] hw/i386: Use the apicid handlers from X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:10 -0600
Message-ID: <158326548999.40452.9247570542382737462.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR1101CA0011.namprd11.prod.outlook.com
 (2603:10b6:4:4c::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR1101CA0011.namprd11.prod.outlook.com (2603:10b6:4:4c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 19:58:10 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5333ce80-77a6-4899-f36d-08d7bfad33b1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573CA17D4545FE918E50EA995E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kxm0cIary9txP6hQnsnLLLMR/s3vWN3Tmoc1YolZSzQu1WQYtoZNDCj655dZv7GJRJ+H5oujvlcUjTd7wCA1pwWoeVTY7vuWhYu4L2ODQBdkml+Nw2lDNwxyqcu/tpB0409/5ik35fscGOXnEtA/FQpMXBp2JqQCQvRAt9QYNxhh0GIrVyv5uYoUOStEusfvMpZeXXwZ/DvQo7a6Wly0WiB0miIttAbS29pwCm3PeQBU8eGmjVUAkZXcTrB2L2OfaHWN3SBQyEwDdkIeNSL0BoiRRDyDIWWJAFlvUfmTic6PqqY+bz2nhFQlZ2kMEAb52lkIF8eQc5GEiOmgZ5qW/IC71PEvSHpcok3eJ1/ZmoFeQVDyxq8AlpYa0s8Kc8PF2nW+v07tFq+vp8SeHsD7od1OdOxDQgB+9nTkvgwAtRcnLrSYLNLEJdWgiTJ1ZOBR
X-MS-Exchange-AntiSpam-MessageData: QwtXJ9vF+z+zl63oStRggVawQXPguzFLS4xq6rldjy/EplZpOhwPHrIgoomIqWefujqGqhRV2qp9xWXmiOhZZELlEog/5pqyviUDELLxKiN2zKgxvv1uGS6+TBcs+Yr1LFcDJDqkH3QG8SvVOeSS+w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5333ce80-77a6-4899-f36d-08d7bfad33b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:11.5521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMQrwQ01IXOVOcs+EKretl0Rv0Cir1lHJAOjnUpDzskVVYpknW2nITcARMDj6mSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.80
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

Check and Load the apicid handlers from X86CPUDefinition if available.
Update the calling convention for the apicid handlers.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c  |    6 +++---
 hw/i386/x86.c |   11 +++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 17cce3f074..c600ba0432 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1581,14 +1581,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1609,7 +1609,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 15b7815bb0..d46dd4ad9e 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -86,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -158,8 +158,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            &topo_info, &topo_ids);
+   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                               &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -179,6 +179,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         return ms->possible_cpus;
     }
 
+    /* Initialize apicid handlers */
+    cpu_x86_init_apicid_fns(ms);
+
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
@@ -192,7 +195,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id =
             x86_cpu_apic_id_from_index(x86ms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;


