Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC27FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A584A206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AQ+w3XbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A584A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCorN-0007dX-Rs
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColB-00068e-Sf
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:29 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com
 ([40.107.75.79]:20910 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColA-0007Uh-5N
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiLBMYFJTeMoFpyxeKsHARSCWY5ymDsB1QLoTnV3oMZndCCJiQ4bPGDMx5/2MVo1W0/KKm8njCdIYUQ9eQAjlNuLyuGEnRCdxE6I8jkDoj9Nf4VxST3meBIy++HRTtaCDlD7RC+HrzTsazroCBRch6wluvaovEV5xcx4yGJVbnItzUmluTGOGY2rm5PVzY7IXnkYWO+wHbMOHQtTFFWNiGXXJvRxNwleYd3CLL2CEgBgHyEF520T1LvCgRsnvNTZe2qVCDw6mDgI6LqVcfS1OiM21rOxp+TywScFldi+v9ooEnWqyAxwIYkuXoayeap1c8SStp88MW26FysqXAXHcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RifX0ctDpmOifbi7XCqPWHAAJNQ6Z6wtmfyU0cxe2A=;
 b=J6eJws5D0s6DR08sSvBmwbKy5vHscL+p+LvsH7nCoiA8vH/KmDWuroEM1yRyULeWd/TmUiwu+gWHoZxT3vUzNYNlro/DWJj1YOHWs7yOMcFxMrGDQBndJ7S5a4858RSipJMJn9jIj+vKSs7wDl12mUhk7Z/mrEJhTr6qsI7GrDYzugz9yVIuYskbunFMoDrInNgYnywiPFtbYF0792DFxmBjIp3aG1Dfx8NZqSqBGyqeEk0VoBOevV1hCOr7aQtR+ZPfDhoxfbro/5MvtvqpmBNl2bnbi0iWivnrB8KdbXsqI78hlA9CExCYwaY7IBDnC5M/DwFnnKqdrqnjrgvETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RifX0ctDpmOifbi7XCqPWHAAJNQ6Z6wtmfyU0cxe2A=;
 b=AQ+w3XbIl3TE4gQ5NLeBgvImJBRWQfTbqqD7B5dfHD3Qj0doltISoWx1qfy4HnJpBOFEcmQswyAXCJdacK48L18zVueftbAwb8QN1LFhtVTR/N4rrU92rgXW4hBeS2F8Gvs5i6EGXLpkWAmya8xvLUxDh0IezB0LXNlF5BzRCW0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 18:42:24 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:24 +0000
Subject: [PATCH v6 03/10] Revert "hw/i386: Move arch_id decode inside
 x86_cpus_init"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:23 -0500
Message-ID: <159889934379.21294.15323080164340490855.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:806:6e::33) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SA9PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:6e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 18:42:24 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 631f2d78-c72b-4d99-1c7d-08d84ddd9a7b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2559066BF0D01141E0CA27DB95510@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVbJLgZ0LwfzLbhDF/BAZJwk0/v/qeXi1AQnAzUPiaoU4sQZKFhKnbg6slTcx2gPfrRKM0A75yIBlk7L4CWA7cQfvPCEcV6i9LpVJqz4SQJz0yTVdXarLAY6XVraFx4n0Eji1SyC3+h/0d507sDAB47EQ6R/7rLK60O70pvMIOmEYZxSicCZ+bwnANky3KoiZnGRH3+8SnQ54RWY/mW0/JwSYjvBqQ2EJuB81aVGyCJesMwfgivYeGSZAbgNB2I+d9ltGW7+eQFU8f5/rGk6iSHyLN/q6URZ871jVSrSw656EIAkMZCV2Xw0qbHPk/B9RcCT95z07rKfP7uWMlmfow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66946007)(83380400001)(66556008)(4326008)(26005)(956004)(316002)(16576012)(5660300002)(186003)(66476007)(6486002)(8676002)(478600001)(44832011)(8936002)(86362001)(52116002)(103116003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Guy8oaZenw2c91FfKHI2n3InQPyWcCTDFbz9HU81+GC11FIouu9qwWmfg7BXCnhMstOoD5hVw5MUIvHf4FZhA1T6G6WiTxf8u6QLBUUGjkt+nq1KTX8qpfN5Ew83l7W3CUjaekLPKo+syFCndZcZr2GIEaBmFZvM3fa8c8oR/0VZ9nggN/H0U3bU4MQSNvqNKMi/40WVaPrO/FNcDthwWlgwc4N644UtEwZ1IaMZs0qUJk3d7ZZhOFhp8RkL76YJW2YCIp+yCwqZhij6Ob4JNIyVnYmeqMf0EgJmfvdTYHAp1PDU6QlOUe5Pi4xn8sRvccZ9Q0H27E3pKKlbiuFRmVFXYm8lOrYtfdd/yFMP8/l3XXdEs9MRBfB6lo6SWfHHdXe7Qla4CwdAbWCicT2j+F9AAEeUwrxWKSw3BcNnNZzFNsTVmrVP2xYso8GJaUNZHt3pMGdtdk/ncd53JBleh2+mm/ho6+iKC1K+1mJMo6lpMX5vpHcSiaLxttzPTV24Y1QN9uKlfqB8VId5w/3jJxF2L9IUMLqsCWgkPiTI4V3cDmecd17RQuIZ9wOWidjvdg4BoI7iOBtynw/jt8w4e4evHdzHo8FduiIAknhCOZcgjkiuiZFSLzcmwXSFpupy5DobMs99Xsz2TWXx5c8gmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f2d78-c72b-4d99-1c7d-08d84ddd9a7b
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:24.8905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15yf/z2t604LCSe1+2Mh/AeeBEpLA0kF1Svm4m1NzVXkakn1uA1zsdhn0yZhdLtt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
Received-SPF: none client-ip=40.107.75.79; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001, RCVD_ILLEGAL_IP=1.3,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: babu.moger@amd.com, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 2e26f4ab3bf8390a2677d3afd9b1a04f015d7721.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c  |    6 +++---
 hw/i386/x86.c |   37 +++++++------------------------------
 2 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6b708f4341..0677d6a272 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1556,14 +1556,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1584,7 +1584,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index cf384b9743..3cc2318212 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -68,22 +68,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
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
@@ -102,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -136,11 +120,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
-    /* Check for apicid encoding */
-    if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
-        x86_set_epyc_topo_handlers(ms);
-    }
-
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -154,12 +133,6 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
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
@@ -184,7 +157,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
+   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                            &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -215,7 +189,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
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


