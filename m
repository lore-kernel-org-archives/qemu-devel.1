Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2651DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C9620855
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 22:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UdDaPpEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C9620855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9FI2-0004v3-5X
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 18:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHG-0003nl-Nu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:12:50 -0400
Received: from mail-eopbgr770088.outbound.protection.outlook.com
 ([40.107.77.88]:43270 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1k9FHE-00026u-Gc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 18:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3udcoKL22Tpsqm7Vx8DKLgeh2ymD6JKT/LhP8Ukd5oltuyBM+duWKGgZW/KyUIqfOCJl9uX/ajBiU96hhxt5BdD1iqX5WHh/iNXQupQB2uC9ZQgXDyQhPgmLmwddOUUHv6c3OJ2v4XoybuSN293RJRj8NzlLd4pQzsny7XUYM4SSEyWKTdENfgqHTI/6fVc0/dLw6wBB+OECh/0i9sZonzDDdLgGyQ3QGoKNSlXsQcb7mdoyvtsqxxVvGAzzzyTqnib8P6Syjlu6dJIa+VW8fYPpLOdDNbWJakJ7079zMHZi7hvtRnVAxh436LaIoq2a2qDzFAGdTfBs7e3VAuL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrNbCRUfb1bckqbwMDMEDWp67q/9G4cwOe1N9qLlaqU=;
 b=NKCy3hODEqZ+RXCmQ2E1SU6VTE9dV2sDgBeDdgOciIznGs/U5KjS494PQ7AqkULEC5uphnqlg+EsP/BIRqyzJ3CblxyTlrZZqGCI3GLrmZjI7wYypZuBnwI125r3A25g+UVBUHTe+Gj4mxKvLRAyiLPYKoqE/qV32lKzuvPEHkwxs932CWQ1LyhNxbDAzk8rEBRUwhLqHJAsLj8LFqIjsxCxBYKqqe7BvaV872aXZZC6lHyah3MS1tR9+tUqeVlFneIh4/2RDtiM3PNkYq9BBf35nM04YOBpkdUw/2keEcDPpxXwLr0LNEKFmnpSDiWl/sM9K5wp2axHuNJ8VwL65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrNbCRUfb1bckqbwMDMEDWp67q/9G4cwOe1N9qLlaqU=;
 b=UdDaPpEZnh+YGG+ygYz8PZNh13vnqLMjm0D5yrdEt5kV4ElA130Uz4G6PoBpGeoogBZ8vXPu37BSqj+P3cbZakTMebQBrpeO0zdxDsrKwnk9gtWZ2+MICsrJq/+4yDFLvm/DieO3N61D3Gg26gqPU91WWeLteo5l6WAuiExlfg4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 22:12:45 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.024; Fri, 21 Aug 2020
 22:12:45 +0000
Subject: [PATCH v5 4/8] Revert "hw/i386: Move arch_id decode inside
 x86_cpus_init"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Fri, 21 Aug 2020 17:12:44 -0500
Message-ID: <159804796398.39954.2535043746732107351.stgit@naples-babu.amd.com>
In-Reply-To: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0088.namprd05.prod.outlook.com
 (2603:10b6:803:22::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0501CA0088.namprd05.prod.outlook.com (2603:10b6:803:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Fri, 21 Aug 2020 22:12:44 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20dbf6ca-5339-4e05-b064-08d8461f5462
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-Microsoft-Antispam-PRVS: <SN6PR12MB26705ED144052FEE71423D13955B0@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn9N1oRAB5l7i8Tpj9ZKD95BBAXAZfc3f1BJBYcGq3tskMTpFv1mBC4UOfNjcL6tDMXBXj+X+YcxGS0DL1b0sSL5QycL2xP/VGt45nDidVxoNMX6yuEELRd4695jeo/j8A7dIct2IS2AEA0YKbgD6nuMvZ2jNIKIKEggnTWo0Szqp0QKbt/iPmn2Zh2eGcxuLEpYWnS7uZWcOWtCeMRq9bV4z1TrgBPJoD50NNtOPki7BWh1usscfFPLvNXqCy/gg5X9proR3BoP1PnHIgmh9a9FAVcmbwY68oFOSP0K1vSbzcnLwbvr3QmwYLXJ9ssudx4VbeUwdY6eNDPcIMUjapsJ0Df3sLxdVs+J4ImAzCDA+AYo8xe6BU+ShUyl5vTh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(5660300002)(83380400001)(86362001)(52116002)(110011004)(8676002)(316002)(26005)(186003)(956004)(478600001)(6486002)(66946007)(66476007)(66556008)(8936002)(44832011)(16576012)(2906002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CGan5VUfGf39yXs/o54KO4wbRpcs/HMdilvPNe8j9067cpEz9O798Bo/OXUqEaiZd7GGuPXqjFik7irsjzVzEy6nNwC7gRlXDEa6/Pk2FkZyeSghz1b7rpY0YH8E/OFiV9IiRU56tKhBRD7tJLGwsTB9DRsS4Pjs3GoXdcQfa+0biVCnoG/GEDV2Wv/LG6FX2K6aV5j90X6d5fTG/A+Sm/KVM1BhN2llec/OAnAEf8lcasqNQJBtcDkR+isvao9LBwzx92j+l0F5i4Y9YQTNDu29dvT3C4jOmGwZvuSdZLJKGRozcsWuMacmuS1kAUVH+/Kyb59SHmSMyGLhrJFLq1FvDkN8HoN9HWtNWJij/khzUGJw1GHUE7BX5LUm+QbvB+H4n6vXqIMawm6CDCzlEgfBvvCmYBEdxDsH7r5NKia/oWjBSncyjea07vhEuwp6IudjpbERpr3mwU5DT3YgBFL3VVYYSSNs/gB4m7NF/K3eB3P7IgB4nldms0zvaGPNO7dR3yBNDvnRvgPm4LXgB4U3Zlu17x2cKpvI158RWXQDCMGXaB4dwbukWQYDxkHOZkoj9KesdK5w2LzX3dGDOyg1/ZIlcY1evbrNakRbrajTO7OslL6pEdHpL3DlbeX+aT4Gd/8+0uwaneXWSHtP0Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20dbf6ca-5339-4e05-b064-08d8461f5462
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:12:45.0357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LFzBH4c3zpWrqs0LZwCDKc6sAKKr0P6UB171W8YYwyjG5p66Vr7vWyo583qNo0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
Received-SPF: none client-ip=40.107.77.88; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 18:12:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Remove the EPYC specific apicid decoding and use the generic
default decoding.

This reverts commit 2e26f4ab3bf8390a2677d3afd9b1a04f015d7721.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c  |    6 +++---
 hw/i386/x86.c |   37 +++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e74b3cb1d8..6abe7723e0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1552,14 +1552,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         MachineState *ms = MACHINE(pcms);
 
-        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
         error_setg(errp,
             "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
             " APIC ID %" PRIu32 ", valid index range 0:%d",
@@ -1580,7 +1580,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f6eab947df..0a7cf8336c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -67,22 +67,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
     topo_info->threads_per_core = ms->smp.threads;
 }
 
-/*
- * Set up with the new EPYC topology handlers
- *
- * AMD uses different apic id encoding for EPYC based cpus. Override
- * the default topo handlers with EPYC encoding handlers.
- */
-static void x86_set_epyc_topo_handlers(MachineState *machine)
-{
-    X86MachineState *x86ms = X86_MACHINE(machine);
-
-    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
-    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
-    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
-    x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
-}
-
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -101,7 +85,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -135,11 +119,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
-    /* Check for apicid encoding */
-    if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
-        x86_set_epyc_topo_handlers(ms);
-    }
-
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -153,12 +132,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
-
-    for (i = 0; i < ms->possible_cpus->len; i++) {
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
-    }
-
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
@@ -183,7 +156,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
+   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                            &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -214,7 +188,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(x86ms, i);
+        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                 &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {


