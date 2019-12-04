Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61711C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FEC20661
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ReW4PP41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FEC20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJk2-0000NN-AY
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuJ-0005bI-Ot
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfi-0001sp-Ou
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:40 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75]:13319 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfi-0001pO-Eo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9e7Rg651eOdVIxkz5UHedATUWvqHGezQTZoqSaMQmmckqFvI5riXmbQdzmtnInmzu+/UZ5uor6aDVMWBpRXWF6loPVQEOwkDFpzZ5nLDzbnGQxBdg6vDcYK0Qq4r14R32iREHZs8lAGtJsDFxFdoBuAQbg2Q/HkPBEnrILaYTm2mGdQXRLfl03eebFEG6VVptdeGqfLjHYeoIw3vRAOgQIQ7UAyk9z57sPFwpyPU/Zamt5cGAtrQl3vVAa1irQ38K5qySgJGDgr3ibmCCFLb8zZ5Y8E708PAW8PB0AcmB49vwAHxGZ9b6nHFzhHpWfRQ00TbM3iApMs4PB+XLKb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9jftLSw0ZOJ33nKRFRwXhtiLUno4ZEmOhZyfyRSmgc=;
 b=EMIUZI++0sFSEkn/ml6giuFKYSXPqM6a6JsmKTG86KNlCf0uB/nbPtKCv6aB8i6tArdV5fm9tBzckMfBrCfg4UReAkaItJaBTqUz41xkwyolnVqmjm+UzjjyD35TZ7Qdli498JLCkjd5QvTh2Vto0NnFKeyt6j66RvVpvlOlkUaWbUbN459LT+CdLNQHEMFFIzVVwIzcenBSlMCHkN5OI16m6skSiKmeREjjG+yCjuLMIbM44qQZ+17YDbmvNMy4ys4EGFcys0C4okB/PlUP7XN+AFEyQ4qLAc3u1oWfXE19Pia8UUBuTVe7/quIrsHpxW/oOZ5kKMI+bleqKif8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9jftLSw0ZOJ33nKRFRwXhtiLUno4ZEmOhZyfyRSmgc=;
 b=ReW4PP41KGvZgSZou0GnGhiMGuYlSmfu1H0njRKFOQ/dyytRZbnhx0naHk+GD4SCHqhtgP1Yq/fzUoa0nJ1R9ninJFg3+dmi1F1MJZZecfyJo5KBW7nAjS5Ks8wNDt+aY45plHPA6fvZLW/ayebaxHfiim94mN/8XgjK1Gp9Dlc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:37 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:36 +0000
Subject: [PATCH v3 06/18] hw/core: Add core complex id in X86CPU topology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:35 -0600
Message-ID: <157541985531.46157.16935250205964640126.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:805:de::25) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3618d264-d407-46e1-9fcf-08d7785228fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369A5BCEA3EC36F6F0F20F6955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
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
X-Microsoft-Antispam-Message-Info: wmd2Pt44fuxGbEnM7WSiHeMJ8Lr/rf7Ftsztdx47JYhPKCDulffNKbR7EuTqxlyuzeURsouhLkGdSWwyJFZvHY95PMP082LE7Tyt9sYIKPcTsZBxVHq66RBtvHhQSurAx6iY0thzGF5/qHPieimTGIziZh4Ntq6clQk/9M41Aua/s1vaK5EF6GMcW17cPJfQMD+qc13X7NpYZgBofFZp9uYbfeHpqwt34/oGFV4iLi47sAnFP3i1kVgpIOWwKClFwJizfe4ydkMxHVZZeDymGwICNBYWDKFDwYOTumWh+IvzMG1fJajEqyOL9LFfFgPFOmYeL2gUQ7cmMz+0MjQ6ND8DFqPA0tpjFKzN/A5fM9HH4l40JKkriqySygoSbDxu+UiMkB79snabfIGEo/nWwYVtjEgLG3l1xI8OtxMhGUGCqmgg7B3X/GKf+TIPFMnE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3618d264-d407-46e1-9fcf-08d7785228fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:36.8319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpl/ydD3NF9mrxlAIHx1eUxkzS16NDiMrDD7IopCHE9VdJFrwyr51e/OPHD+3j4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.75
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

Introduce last level cache id(llc_id) in x86CPU topology.  This information is
required to build the topology in EPIC mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/core/machine-hmp-cmds.c |    3 +++
 hw/core/machine.c          |   13 +++++++++++++
 hw/i386/pc.c               |   10 ++++++++++
 include/hw/i386/topology.h |    1 +
 qapi/machine.json          |    7 +++++--
 target/i386/cpu.c          |    2 ++
 target/i386/cpu.h          |    1 +
 7 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index cd970cc4c5..59c91d1ce1 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -90,6 +90,9 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
         if (c->has_die_id) {
             monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
         }
+        if (c->has_llc_id) {
+            monitor_printf(mon, "    llc-id: \"%" PRIu64 "\"\n", c->llc_id);
+        }
         if (c->has_core_id) {
             monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
         }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e59b181ead..ff991e6ab5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -683,6 +683,11 @@ void machine_set_cpu_numa_node(MachineState *machine,
             return;
         }
 
+        if (props->has_llc_id && !slot->props.has_llc_id) {
+            error_setg(errp, "llc-id is not supported");
+            return;
+        }
+
         /* skip slots with explicit mismatch */
         if (props->has_thread_id && props->thread_id != slot->props.thread_id) {
                 continue;
@@ -696,6 +701,10 @@ void machine_set_cpu_numa_node(MachineState *machine,
                 continue;
         }
 
+        if (props->has_llc_id && props->llc_id != slot->props.llc_id) {
+                continue;
+        }
+
         if (props->has_socket_id && props->socket_id != slot->props.socket_id) {
                 continue;
         }
@@ -1034,6 +1043,10 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     if (cpu->props.has_die_id) {
         g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id);
     }
+
+    if (cpu->props.has_llc_id) {
+        g_string_append_printf(s, "llc-id: %"PRId64, cpu->props.llc_id);
+    }
     if (cpu->props.has_core_id) {
         if (s->len) {
             g_string_append_printf(s, ", ");
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 17de152a77..df5339c102 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2294,6 +2294,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
         topo_ids.pkg_id = cpu->socket_id;
         topo_ids.die_id = cpu->die_id;
+        topo_ids.llc_id = cpu->llc_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
         cpu->apic_id = apicid_from_topo_ids(&topo_info, &topo_ids);
@@ -2339,6 +2340,13 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
     cpu->die_id = topo_ids.die_id;
 
+    if (cpu->llc_id != -1 && cpu->llc_id != topo_ids.llc_id) {
+        error_setg(errp, "property llc-id: %u doesn't match set apic-id:"
+            " 0x%x (llc-id: %u)", cpu->llc_id, cpu->apic_id, topo_ids.llc_id);
+        return;
+    }
+    cpu->llc_id = topo_ids.llc_id;
+
     if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
         error_setg(errp, "property core-id: %u doesn't match set apic-id:"
             " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id, topo_ids.core_id);
@@ -2752,6 +2760,8 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
             ms->possible_cpus->cpus[i].props.has_die_id = true;
             ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
         }
+        ms->possible_cpus->cpus[i].props.has_llc_id = true;
+        ms->possible_cpus->cpus[i].props.llc_id = topo_ids.llc_id;
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ba52d49079..1238006208 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -48,6 +48,7 @@ typedef uint32_t apic_id_t;
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
     unsigned die_id;
+    unsigned llc_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoIDs;
diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..1ca5b73418 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -646,9 +646,11 @@
 # @node-id: NUMA node ID the CPU belongs to
 # @socket-id: socket number within node/board the CPU belongs to
 # @die-id: die number within node/board the CPU belongs to (Since 4.1)
-# @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
+# @llc-id: last level cache number within node/board the CPU belongs to (Since 4.2)
+# @core-id: core number within die the CPU belongs to
+# @thread-id: thread number within core the CPU belongs to
 #
-# Note: currently there are 5 properties that could be present
+# Note: currently there are 6 properties that could be present
 # but management should be prepared to pass through other
 # properties with device_add command to allow for future
 # interface extension. This also requires the filed names to be kept in
@@ -660,6 +662,7 @@
   'data': { '*node-id': 'int',
             '*socket-id': 'int',
             '*die-id': 'int',
+            '*llc-id': 'int',
             '*core-id': 'int',
             '*thread-id': 'int'
   }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index bc9b491557..3c81aa3ecd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6222,12 +6222,14 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
+    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, 0),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
 #else
     DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
     DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
     DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
     DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
+    DEFINE_PROP_INT32("llc-id", X86CPU, llc_id, -1),
     DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index af57fda8e5..a56d44e405 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1711,6 +1711,7 @@ struct X86CPU {
     int32_t node_id; /* NUMA node this CPU belongs to */
     int32_t socket_id;
     int32_t die_id;
+    int32_t llc_id;
     int32_t core_id;
     int32_t thread_id;
 


