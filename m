Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21818C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD22C20637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="33mWs8uw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD22C20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJaG-0004Wf-Uy
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuC-0005bI-M2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIgR-0003C5-2n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:25 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com
 ([40.107.223.77]:6103 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIgQ-0003AV-Q9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUHVfWajYP+Lg2as+n2Vz+n6/RdxZY+LH2v/MgRfeDhcKfrihvGEXAG7YBERdX//GLirjIcXhu7H5RGVb91oVV902PmfQzxOq6MIEj8ldA7OVHwGxeKnlME1v9dHuWo6z3mh4kSvEPjXsoJ5mIuQd/6VBVUpxJ6KODO1i19C3mAskdSxnBJ6RnXAEmA/I1WoTXj4owmkOsWertqFi20Ieh6d0J7wlGwqWpRt/H5d1+nqBUDxDvsBMOXAgnFLnbttQLw7wNAaQ/SIqie0q2mSca1FzUW5E+T+hNw2cv53FXHiWaS1wnyZByu8SdjBWO89repkMVbhVypAxKFa4+BegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Msdmi6/SijaK5PjoEa2E8xpS92/j8z+g1ci0wn9iU8=;
 b=l5IZyn8L6V+WvPtJ+Z6B9ni3EqD1dPf/J029PDi/XEtMUSjs5BEmWs5MGXf7Bgj3QcaZj4TCtc2R5a6NDg021pLbojfPUDqc9/DMlWucSdMQYAaL9vfYAu84N/HihzoN415+jdUpS4bIMPcO4oxYI1NkGIos70KHejZ9db0Kt8ha8aCvC+0qgYHtxJjdPNAHKPV4596s1k3Mb81i7gsH0N46c13bMkANMyJ5mTxcESe8DtkNC0wFQKaJohAGOz6G8mqgL2szGjOfY1ayglO8T4V4jmevt9NLSF/WTe85jPYaXs57LruBhlP0zoml5s2YzP94aY6fgckf0PpNyqIVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Msdmi6/SijaK5PjoEa2E8xpS92/j8z+g1ci0wn9iU8=;
 b=33mWs8uw1SRRatW3fss2InTaDMw6JkT996dFrtkoBVAZIlT43OpwdM4Y6OqO/MdS/ZN6V5kum2lPQIw8WXpQI0gu/wCjulvOffQEdtz5YfWmU+dlKDoytFnqDUGI3r+Gl1vnD2OySND80hes2hDodQnUErU+rTMVkxtiLhp3ODI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:38:20 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:38:20 +0000
Subject: [PATCH v3 12/18] numa: Split the numa initialization
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:38:18 -0600
Message-ID: <157541989879.46157.15315443378951392179.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:805:a2::43) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa609597-2b70-4643-5108-08d7785242e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13697DC965E5E8988BF4A5B2955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
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
X-Microsoft-Antispam-Message-Info: 0qDT3hXliwOc9OHN6sx8TbBPHGblVfePgyyu7Pp8HPLHkqpm4GnfzRqLWU9+S3BpjqoBG1bi3YleFVWYecejUfsPejE5KknIHyohBPXJH4pWriFAYQPjmGWA9qHlktArrxYOY/RToRimdol/zxu0myJ7uV9qp8r0nzPvtnomK63ZNQBMTZDufTJq0wil2j5H7SRPBaetoPl5tES43Btx6ZiRIRvZG3r2Gni0e/pPIlX0SYUNfvnW+D15LYjgYSRdZ121KvxlvkzeYC0OFW+uGVSNYfcTNO+fG9vrg6yYqA+m+EgTgk/cXdNN6yZI/xOgf3FRrLqhfoil8B4WRI0KyYPhPdF4SAKTFjQhghleL7rWA0PJB4/u0mJ4p54p7MjzWla8ujfy9GCzXp0AqizwULncPeB1CIxuz/46P9xJQcIGVT3eu8R6G1I2l/Si9S3a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa609597-2b70-4643-5108-08d7785242e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:38:20.3089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqoSWvFxxsu409phlurIzodEW6fNuhdvc/jCjxz+fsUZfTRnlZFsvWTV2/zR31Tc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.77
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

To generate the apic id for EPYC cpu models correctly, we need to know the
number of numa nodes in advance. At present numa node initialization and cpu
initialization happens at the same time. Apic id generation happens during the
cpu initialization. At this point it is not known how many numa nodes are
configured. So, save the cpu indexes and move the cpu initialization inside the
numa_complete_configuration. Cpu initialization is done in new function
numa_node_complete_configuration.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/core/numa.c        |   62 ++++++++++++++++++++++++++++++++-----------------
 include/sysemu/numa.h |    5 ++++
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 038c96d4ab..ba02a41421 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -33,6 +33,7 @@
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/clone-visitor.h"
 #include "sysemu/qtest.h"
 #include "hw/core/cpu.h"
 #include "hw/mem/pc-dimm.h"
@@ -59,11 +60,8 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
 {
-    Error *err = NULL;
     uint16_t nodenr;
-    uint16List *cpus = NULL;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
-    unsigned int max_cpus = ms->smp.max_cpus;
     NodeInfo *numa_info = ms->numa_state->nodes;
 
     if (node->has_nodeid) {
@@ -87,24 +85,8 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
         error_setg(errp, "NUMA is not supported by this machine-type");
         return;
     }
-    for (cpus = node->cpus; cpus; cpus = cpus->next) {
-        CpuInstanceProperties props;
-        if (cpus->value >= max_cpus) {
-            error_setg(errp,
-                       "CPU index (%" PRIu16 ")"
-                       " should be smaller than maxcpus (%d)",
-                       cpus->value, max_cpus);
-            return;
-        }
-        props = mc->cpu_index_to_instance_props(ms, cpus->value);
-        props.node_id = nodenr;
-        props.has_node_id = true;
-        machine_set_cpu_numa_node(ms, &props, &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
-    }
+
+    numa_info[nodenr].cpu_indexes = QAPI_CLONE(uint16List, node->cpus);
 
     have_memdevs = have_memdevs ? : node->has_memdev;
     have_mem = have_mem ? : node->has_mem;
@@ -360,12 +342,50 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
+
+void numa_node_complete_configuration(MachineState *ms, NodeInfo *node,
+                                      uint16_t nodenr)
+{
+    Error *err = NULL;
+    uint16List *cpus = NULL;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    for (cpus = node->cpu_indexes; cpus; cpus = cpus->next) {
+        CpuInstanceProperties props;
+        if (cpus->value >= max_cpus) {
+            error_report("CPU index (%" PRIu16 ")"
+                         " should be smaller than maxcpus (%d)",
+                         cpus->value, max_cpus);
+            return;
+        }
+        props = mc->cpu_index_to_instance_props(ms, cpus->value);
+        props.node_id = nodenr;
+        props.has_node_id = true;
+        machine_set_cpu_numa_node(ms, &props, &err);
+        if (err) {
+            error_report("Numa node initialization failed");
+            return;
+        }
+    }
+}
+
 void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     NodeInfo *numa_info = ms->numa_state->nodes;
 
+    for (i = 0; i < ms->numa_state->num_nodes; i++) {
+        /*
+         * numa_node_complete_configuration() needs to be called after all
+         * nodes were already parsed, because to support new epyc mode, we
+         * need to know the number of numa nodes in advance to generate
+         * apic id correctly.
+         */
+        numa_node_complete_configuration(ms, &numa_info[i], i);
+    }
+
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
      * options explicitly on CLI, guestes will break.
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ae9c41d02b..91794d685f 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -19,6 +19,9 @@ struct NodeInfo {
     struct HostMemoryBackend *node_memdev;
     bool present;
     uint8_t distance[MAX_NODES];
+
+    /* These indexes are saved for numa node initialization later */
+    uint16List *cpu_indexes;
 };
 
 struct NumaNodeMem {
@@ -41,6 +44,8 @@ typedef struct NumaState NumaState;
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
+void numa_node_complete_configuration(MachineState *ms, NodeInfo *node,
+                                      uint16_t nodenr);
 void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
 void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,


