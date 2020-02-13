Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1211721734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mBjBdVhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1211721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JFH-00029V-85
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3f-0003Cy-8t
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3d-0000dm-Tm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:51 -0500
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com
 ([40.107.223.43]:6114 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3d-0000bY-NS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoTKMYSX9DIbE16jOumT0EpLVXgbQt1b5vGeYerrSLZ+Um3SFTsJ1Azrf3oh+zZk3jDs8dzKCvnt9Eix2MYyYgq8GzM6RJZZw7zN2wY7kRRxnu2MpuMKQsGcblSDUayjUQcU2/OYadDdzJNhZhVOzzAvZux5gP94FdYMWCVtv+Vq0NwTxi7XhJDam93Vl5u4QNlNJfihlAH68i1JaSPRr62oqf9RS/P98CSEKBbyQu9ssItfzYS8GdWzdDFmMnSzdm+KGDXl/Hk0UKv+Pn2s1TT4zPxbNpbVB50aCtzzopsxR3qPmfK3HTstkis62xMPUvN/pQBlWHBy8NGyNt55+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jcBD25IXAAeks/Woxx18Syfm32L9rY5LYbHICkaLpA=;
 b=l2yMvSM6+N7YNlWI+DxyYH8WZ/hkNeTswDaKITtx+7GCHsnVyC79bxM4RjUC6MyuVNSMD3jSQl8dogYuh2kDkSQ0QRHiN28+T4SBY2pP/jyZbMnh5IttQS9dt3XXnA1XkjTEBGspM4BDWOhrBhwSikLwWR0aL6+OCoNL25vtSpaQmZIk0vaP+7tddCmAbK/sDOVqscqlJTSDCyC0xzR3IDjoaa95MlXpSBh0dRZAp1PVcqU4Wv6MiIonRzpWFaAp8UkrBzdRjMwoD8vgsd5PZOSCDihsazXZIIEaieXwv8aq8CE7Dyz2IaGNWj8aobhHyVpK/qaFCNtEhh8VHaCV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jcBD25IXAAeks/Woxx18Syfm32L9rY5LYbHICkaLpA=;
 b=mBjBdVhTaXjI370N8GjVBEYSuBy7+6Ak1oVBRn+6Ikim+43XqfIzL9izpVqWokDsfwbmhjIdHz/7uO9Fpn+kyFpYVVCsu5504QIuvgLsKoW1zIVLYaJl7+BjUx2B3/BtRm6dtw9HSXJLBDO/M1EnReFnyWT38gX3Tta7dukaNa0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1222.namprd12.prod.outlook.com (10.168.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 18:17:48 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:47 +0000
Subject: [PATCH v4 12/16] hw/i386: Use the apicid handlers from X86MachineState
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:46 -0600
Message-ID: <158161786628.48948.1813866541108702762.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0113.namprd07.prod.outlook.com
 (2603:10b6:4:ae::42) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 18:17:47 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4e6373a-40e4-423f-e63a-08d7b0b10771
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:|CY4PR12MB1222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1222EFF412EEE75F4B2AABD7951A0@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(7696005)(26005)(5660300002)(103116003)(956004)(55016002)(4326008)(86362001)(2906002)(44832011)(186003)(16526019)(478600001)(316002)(81156014)(81166006)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1222;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ec72NGd/irsb4CpFCsmxAS5eAQdO+3BpsIojkIaBB70VNc+Wskn0eSkg8rxNfYyW3Pl/ebdkoYm4zSH6izaggYlfi0FhwXBKDIR3dmu4K3VGPHBahrf/5rnJcZQWPt6o0VOuFxHZ9MaL3V+lMjOTyMZlWmauN6lbQ//jk+03GCyFWBsGWG1ee7gh+41x2Uam5Uk557dQcTnFshCaVuFVEhOz76zcTUhWxTV8B/yzGRVgLSJ27ETL3fv4ubrTcJ8EVL36DOXcsKoWgZgRulLHPFc0ccli8gYA+/BnBmEE9hqATCbM5iU2AFkPVMlVXytYYmw5eGJGWOQWj5sRzX54mxe9KmSjTMBnRnNpf5UzaPVKr3yRPKzj6yRd0ed7k0EajmfoqYnQW+AXKzsXiA/DxgPQpJA9oOj6rfu1TOYTCFdFwMGKEW5AqhtQpQURuRUB
X-MS-Exchange-AntiSpam-MessageData: 1Q6up3qYwaQ/9ebFw9o4Eax8QSdMzSyZL29nMa0SSoCwIQPumWDt/dRR9IUo1ssCCU1nx/2xGuXb3WNbSiBPwCdg5yuKETDN/lIAdtm/iTvz1xqVKApA4K/9R1mJMVmMea3315K5Ror0VJi7Rvq/Gw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6373a-40e4-423f-e63a-08d7b0b10771
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:47.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mI9hh4xq1X56NW3ZILSGYVmmWTWLQ2p+ftfAIsMXLucblcDH+qDmo0Z4RkDK4WBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.43
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
 hw/i386/x86.c |   27 +++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index be72a49716..93063af6a8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1808,14 +1808,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
@@ -1836,7 +1836,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
      * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
     if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
         error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
             " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id, topo_ids.pkg_id);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3d944f68e6..b825861b85 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -52,6 +52,22 @@
 /* Physical Address of PVH entry point read from kernel ELF NOTE */
 static size_t pvh_start_addr;
 
+/*
+ * Check for apicid handlers in X86MachineState. Load them if
+ * not loaded already. These handlers are loaded from X86CPUDefinition.
+ */
+static void x86_check_apicid_handlers(MachineState *ms)
+{
+    X86MachineState *x86ms = X86_MACHINE(ms);
+
+    if (!x86ms->apicid_from_cpu_idx ||
+        !x86ms->topo_ids_from_apicid ||
+        !x86ms->apicid_from_topo_ids ||
+        !x86ms->apicid_pkg_offset) {
+        cpu_x86_init_apicid_fns(ms);
+    }
+}
+
 /*
  * Calculates initial APIC ID for a specific CPU index
  *
@@ -70,7 +86,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
 
     init_topo_info(&topo_info, x86ms);
 
-    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
+    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
         if (cpu_index != correct_id && !warned && !qtest_enabled()) {
             error_report("APIC IDs set in compatibility mode, "
@@ -148,8 +164,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            &topo_info, &topo_ids);
+   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                               &topo_info, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -169,6 +185,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         return ms->possible_cpus;
     }
 
+    /* Initialize apicid handlers */
+    x86_check_apicid_handlers(ms);
+
     ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
@@ -182,7 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id =
             x86_cpu_apic_id_from_index(x86ms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  &topo_info, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;


