Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0814AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB682078D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q+FUbmRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB682078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgbH-0004tq-Kw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZr-0003le-Ez
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:19 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com
 ([40.107.68.81]:64518 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jqgZl-0003Sq-VC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:31:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDYbPsKe53ZudWBaGWlFuGAOqQp0H0jP3UUCzTas5+FWxSZfswPoPFPoESJoZ+KCwBaGkKeGn9mC24J/soKfWoePOGOmWjgaIl5QbiPqNgzWK/yTt8W5aasjWoGgzuOk6sgt9dmtwtDOUcEC2gCnOcn8sItsniHpJpb13I0uJqFwjlr817qj7JeVif1B5rgRRiIupQLHVCe3h0bEq1TGPs5pTCDipVDu48Ruh3t2nACBS2I+5Ek6r/zMypuSKHRaRvEoFlae2u9jv8W0bzVCohGrC2OtnSy6ZHUi5sD70SAXhXTPoc9n341qSVISZ9eMm9aLqrCGO8KNPjKz7x/vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZQknR+lcI8J085mX0mumUjC8GgMpwrV8wNAacEr9bA=;
 b=heX91lndo00N63WDb3OhvvSTmwy+khCoq3KyN8aRVgCMh3iOJudJnx4RSOqfE4KEbqxilgruQ7y6ZrNrM5scvYwc9q/p4U/4xnm1thGib3egP6/3XISAZysS8Mp6vAaOmBPJpsvuhI12SaaPUtB3XYU0LQMn14Qmp0fE8pyogRve65q2Lms59x1FWYkg44ZjHf57Q14mdfHU8YFYjuayWQ9J7nZr4kwRDLrAm6XIjhXttqyFcQhlO4+Lu/xalzEwjMcTK00XFSMXu22HGwiYfrJzBAk3G4bSNDLCanvAVvI8YsTNbDBIzNeaEVtBT1VD4+sV2W+DjeWMSBC1Wj8pZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZQknR+lcI8J085mX0mumUjC8GgMpwrV8wNAacEr9bA=;
 b=q+FUbmRgOGfmPbfvscvg6ku8T/WsHzQAG1+7ES+bGWhreiYt1hf57auFX14e71NDMq3FUWpzBDgJ/r3ssbp0U9m6ECMXL+Z+83vFpLhR6b2rhXjx2pXdFZ6B337ogEmh3ANipm7Dg0M1mq1exm2AYkdOYb6sk4798dIDpY4YUP0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1278.namprd12.prod.outlook.com (2603:10b6:300:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 17:31:10 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::9c8e:f3d8:eb8a:255c%6]) with mapi id 15.20.3153.022; Wed, 1 Jul 2020
 17:31:10 +0000
Subject: [PATCH v2 2/3] hw/i386: Build apic_id from CpuInstanceProperties
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Wed, 01 Jul 2020 12:31:08 -0500
Message-ID: <159362466828.36204.14044362989991188460.stgit@naples-babu.amd.com>
In-Reply-To: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0401CA0011.namprd04.prod.outlook.com
 (2603:10b6:803:21::21) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0401CA0011.namprd04.prod.outlook.com (2603:10b6:803:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Wed, 1 Jul 2020 17:31:09 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7acd7487-2053-4f71-9aa3-08d81de48b64
X-MS-TrafficTypeDiagnostic: MWHPR12MB1278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB12780D3DF6FF60EEC7DEA9F4956C0@MWHPR12MB1278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGrJDPOr0deW0bAu+qyp4i+O+smqrr81Gojh189Ac1BgLrcNvR/+scfgjA/ygWcGjD8NN7e89yT+dAUn/fZrt9LWWjIo+9vVWJXnnWf7+dLwSUE1n50RynYCfCv2CQkF9qyiNj25jYQjDI2NcaH0OUvMsLCvXPlRqms3YCGp97443NMFaiI1cmHANSNuK+Ul4/XSNqnKdbExoiLB6ELD1LAJJRl5uTaWnu2sXNOaMr1TeHDVux1wQCvIurEOgjP4jtr1kM6PJ27BzZW/97Sbfyni37tcd0sRHFNtECtufhmGmyigAIfX6ekzAQv8ZL220WV3EaNz4N6x/C7WH+dIHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2556.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(16526019)(316002)(8936002)(8676002)(26005)(66556008)(66946007)(66476007)(55016002)(5660300002)(83380400001)(478600001)(2906002)(186003)(4326008)(44832011)(86362001)(103116003)(7696005)(956004)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0QdSPkYZVyjR/ABaWtMpdi1MQd20sx0gcnttPWWo+w3kpId3/EaGcj3JdPOg0nV4wS474S+Q8n2elZSdAK0eVlAywMSDIxDqyiycBMb+a3hFklX8QkRbR7GBvG2ocIqlFD9nZF8U3PQ31T9y5Un2IRTYniAS2TgL68x5cisy6VEkrU+NEgqYyEEljYlQxWfj+JBOVKCIOyLZc7qOZS220GkhlnPR8AAfjrcjNdPB+AqkToEPpAB8d6n6lMoik6LzbLGse8WaR4rzXoBqtBopm12oXKImeP0A2KqWDHEff44n3aureavjJ2fk217L0NNZ7MpqxokzIDQzPednLZ8HzdwMk//IXKE3boH15zL/on+5Oriwm/zD4qlJx9Who21UAKcG923DTINn+f67uI0iMueVTl2rWkLrOorJA2b4OsX9wcqZYmEVveVJknXo0yeeSKOwzuvl0NAaemw7Z5oUoK0DG+o6pzg37L3HIpGcaAo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acd7487-2053-4f71-9aa3-08d81de48b64
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 17:31:10.3019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N2X9s+J0PXGqWneT7ZJgO7xqT8JFPK7pL7HhhFN9r/xXPoIg10ZaBpHYy3RePRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1278
Received-SPF: none client-ip=40.107.68.81; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 13:31:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build apic_id from CpuInstanceProperties if numa configured.
Use the node_id from user provided numa information. This
will avoid conflicts between numa information and apic_id
generated.

Re-arranged the code little bit to make sure CpuInstanceProperties
is initialized before calling.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    6 +++++-
 hw/i386/x86.c              |   19 +++++++++++++------
 include/hw/i386/topology.h |   14 +++++++++++---
 include/hw/i386/x86.h      |    6 ++++--
 tests/test-x86-cpuid.c     |   39 ++++++++++++++++++++-------------------
 5 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d103b8c0ab..e613b2299f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -800,13 +800,17 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(ms);
-    int64_t apic_id = x86_cpu_apic_id_from_index(x86ms, id);
+    CpuInstanceProperties props;
+    int64_t apic_id;
     Error *local_err = NULL;
 
     if (id < 0) {
         error_setg(errp, "Invalid CPU id: %" PRIi64, id);
         return;
     }
+    props = ms->possible_cpus->cpus[id].props;
+
+    apic_id = x86_cpu_apic_id_from_index(x86ms, id, props);
 
     if (apic_id >= ACPI_CPU_HOTPLUG_ID_LIMIT) {
         error_setg(errp, "Unable to add CPU: %" PRIi64
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 34229b45c7..7554416ae0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -93,7 +93,8 @@ static void x86_set_epyc_topo_handlers(MachineState *machine)
  * all CPUs up to max_cpus.
  */
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
-                                    unsigned int cpu_index)
+                                    unsigned int cpu_index,
+                                    CpuInstanceProperties props)
 {
     X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     X86CPUTopoInfo topo_info;
@@ -102,7 +103,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index, props);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -136,6 +137,8 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     const CPUArchIdList *possible_cpus;
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+    CpuInstanceProperties props;
+
 
     /* Check for apicid encoding */
     if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
@@ -144,6 +147,8 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 
     x86_cpu_set_default_version(default_cpu_version);
 
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+
     /*
      * Calculates the limit to CPU APIC ID values
      *
@@ -152,13 +157,15 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
      */
-    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
-                                                      ms->smp.max_cpus - 1) + 1;
-    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    props = ms->possible_cpus->cpus[ms->smp.max_cpus - 1].props;
 
+    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
+                                                      ms->smp.max_cpus - 1,
+                                                      props) + 1;
     for (i = 0; i < ms->possible_cpus->len; i++) {
+        props = ms->possible_cpus->cpus[i].props;
         ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
+            x86_cpu_apic_id_from_index(x86ms, i, props);
     }
 
     for (i = 0; i < ms->smp.cpus; i++) {
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 7cb21e9c82..a800fc905f 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -221,10 +221,17 @@ static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
 static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo *topo_info,
-                                                     unsigned cpu_index)
+                                                     unsigned cpu_index,
+                                                     CpuInstanceProperties props)
 {
     X86CPUTopoIDs topo_ids;
-    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
+
+    if (props.has_node_id) {
+        x86_init_topo_ids(topo_info, props, &topo_ids);
+    } else {
+        x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
+    }
+
     return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);
 }
 /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
@@ -280,7 +287,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
  * 'cpu_index' is a sequential, contiguous ID for the CPU.
  */
 static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
-                                                unsigned cpu_index)
+                                                unsigned cpu_index,
+                                                CpuInstanceProperties props)
 {
     X86CPUTopoIDs topo_ids;
     x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids);
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index b79f24e285..3109f39554 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -65,7 +65,8 @@ typedef struct {
 
     /* Apic id specific handlers */
     uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
-                                    unsigned cpu_index);
+                                    unsigned cpu_index,
+                                    CpuInstanceProperties props);
     void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo *topo_info,
                                  X86CPUTopoIDs *topo_ids);
     apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info,
@@ -93,7 +94,8 @@ typedef struct {
 void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
 
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
-                                    unsigned int cpu_index);
+                                    unsigned int cpu_index,
+                                    CpuInstanceProperties props);
 
 void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
 void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 049030a50e..a1308e214b 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -29,6 +29,7 @@
 static void test_topo_bits(void)
 {
     X86CPUTopoInfo topo_info = {0};
+    CpuInstanceProperties props = {0};
 
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
     topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
@@ -37,10 +38,10 @@ static void test_topo_bits(void)
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
     topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3), ==, 3);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3, props), ==, 3);
 
 
     /* Test field width calculation for multiple values
@@ -92,38 +93,38 @@ static void test_topo_bits(void)
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
     topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props), ==, 2);
 
     topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0, props), ==,
                      (1 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1, props), ==,
                      (1 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2, props), ==,
                      (1 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0, props), ==,
                      (2 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1, props), ==,
                      (2 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2, props), ==,
                      (2 << 2) | 2);
 
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0, props), ==,
                      (5 << 2) | 0);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1, props), ==,
                      (5 << 2) | 1);
-    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2), ==,
+    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2, props), ==,
                      (5 << 2) | 2);
 
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
-                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
+                     1 * 6 * 3 + 0 * 3 + 0, props), ==, (1 << 5));
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
-                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
+                     1 * 6 * 3 + 1 * 3 + 1, props), ==, (1 << 5) | (1 << 2) | 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
-                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
+                     3 * 6 * 3 + 5 * 3 + 2, props), ==, (3 << 5) | (5 << 2) | 2);
 }
 
 int main(int argc, char **argv)


