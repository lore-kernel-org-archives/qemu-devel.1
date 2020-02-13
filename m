Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A54DC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2F821734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t3LWuBWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2F821734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J7Z-0007SS-9J
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2r-0001gL-1k
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2o-00075n-Lh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:59 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com
 ([40.107.220.65]:24582 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2m-0006zk-M8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:16:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+8biz1sIjf2++YTucYJOmFm42jgugN4CCCVjTFy4zm6LZyfDBCMnHKt5n7Bzld3nNlv04vAdcPzVO3EX7z778j98xsfVtvxcAnYVB/lc6PSnKaQV9qDT+1GksZ4XWb95r34BpEQedJNrfZD3CQ3kCWWnnRnXkaNK8sVkh28n/VyxxPys089BweqehGfkTtsunCAul0RTV9D4GCqItLt5u5abF1N5S1wQ4TYTgpYowzwNx054SsEcToCe69ILfVQtcBPgvHTgr4KfhTVTFgM2V0Z9KxviR1v4bfZyNpKXNXitP5bZVH80WvlfdGuXWLN0/aqXlDLM7SGxywLUBLajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNe3huCaHLb5U4U6YnLGBCxi33Xr+1+zob87QqmkfzQ=;
 b=cQ3sWiTrlPmQOFqjiTsk7+wclQo3IaHm6sWeriCdtYr2PLH45ks5E9nOFkWlYa54WIl/ylGMuxRHze1cBP7Ib5q7K1DouZODg5kagHksFcKzBACE4mluj+MWuge/3aOS9MCUR6pS9nG5dfIHkP9kvN+HTQtLNDJMATh1r5ZJnUzirfEXPxIh5PCeDuUFJNgLBZVkpN1M0OBAiVkGfqmJo2RjqAAW+83b3nl5TH8bbYCT5JwKVm/vaormlFIJFycNaVY3xkY4h4WplQcecUML0hiyfqYwPfh1FfHatcDZUdMMbSgb5oR7SOgAw0XA7oEicZfSb9FRthyO3SwW6gwdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNe3huCaHLb5U4U6YnLGBCxi33Xr+1+zob87QqmkfzQ=;
 b=t3LWuBWEiF5AbEnKPiNua3R0oYhCVsInP4o6lqXGzr6608IXmhV786rz9Bpec78tsTfGIv5yrk0Xr8FapjCboej+/G4la+jW0NLmBWWXy9NysvBDKVSJg76tpA2sNFHVLNeq8MQP153VrzW8g3D1pQAkHWCoTMWaV3DrYxQpp/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:53 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:52 +0000
Subject: [PATCH v4 04/16] hw/i386: Introduce init_topo_info to initialize
 X86CPUTopoInfo
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:51 -0600
Message-ID: <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:805:66::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 18:16:52 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90cb85bb-7f1b-44f0-8ad7-08d7b0b0e6a5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB131810AE5A93D10331F77958951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
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
X-Microsoft-Antispam-Message-Info: 2EgwgCNALvSiTLES0/766gkQc/BGHDb4G3M7lRornW4dqQLG0aJE0DJ30g72NaYxtFDTOEsA0fLRJgp2CxmvT/3vDGnWcOY4hwrwDNaDbeMSPnaHPVFHWUOVc2W19UOfv1efDKFyQCon+dK5gdCjXZSmQECj8agqdWlVOunSBRVEfL1atHC+vv7rw5yJf3XKPf2MH/02xS1ltPM5Uwu3+L6UYcbGvu4kG/oMfeMcInCvvLXiPwI9oZqrODAyAIJX7A7M9ErDiHmmYDX0LlGKzgvXXEcEOcyGvZxihrkBfAN92WG9oznNkCNFymO379d9DDXhtrv/EUcdlvQOQp9S4ChKCcawuZsFeSK/n0lwJC4x7vlTX7Y9FuzVwZvlPMtod24LWzVA1qJCLQAHZG32cxRmAGBAWm/6d3KEdy12p4vS+QPh6OQBx4moMQTFNxZD
X-MS-Exchange-AntiSpam-MessageData: x6k1XmR3K5V9MfV9pAyOi7Ma/F+9nes6vrcvCglgMHxtWFbeHeOhWln5fLvvYXRKiMCXihEI6JW+94mrR3rPljQhM34rfwoW2lpMiWOdv/xMwPyH8VEubPVRiI5fZUo3N2nousNsroCALASDbSIHGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cb85bb-7f1b-44f0-8ad7-08d7b0b0e6a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:52.8355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0D1kjwJVgD/DckPKT0hiPV2UGljet6BTfzRHDNo1NOTfWZRaIeB+yABJ03OaUM7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.65
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

Initialize all the parameters in one function init_topo_info.

Move the data structure X86CPUTopoIDs and X86CPUTopoInfo into
x86.h.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c               |    4 +---
 hw/i386/x86.c              |   14 +++-----------
 include/hw/i386/topology.h |   26 ++++++++++----------------
 include/hw/i386/x86.h      |   17 +++++++++++++++++
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2adf7f6afa..9803413dd9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1749,9 +1749,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    topo_info.dies_per_pkg = x86ms->smp_dies;
-    topo_info.cores_per_die = smp_cores;
-    topo_info.threads_per_core = smp_threads;
+    init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f18cab8e5c..083effb2f5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -63,15 +63,12 @@ static size_t pvh_start_addr;
 uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index)
 {
-    MachineState *ms = MACHINE(x86ms);
     X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     X86CPUTopoInfo topo_info;
     uint32_t correct_id;
     static bool warned;
 
-    topo_info.dies_per_pkg = x86ms->smp_dies;
-    topo_info.cores_per_die = ms->smp.cores;
-    topo_info.threads_per_core = ms->smp.threads;
+    init_topo_info(&topo_info, x86ms);
 
     correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
     if (x86mc->compat_apic_id_mode) {
@@ -146,10 +143,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    X86MachineState *x86ms = X86_MACHINE(ms);
    X86CPUTopoInfo topo_info;
 
-   topo_info.dies_per_pkg = x86ms->smp_dies;
-   topo_info.cores_per_die = ms->smp.cores;
-   topo_info.threads_per_core = ms->smp.threads;
-
+   init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
@@ -177,9 +171,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
 
-    topo_info.dies_per_pkg = x86ms->smp_dies;
-    topo_info.cores_per_die = ms->smp.cores;
-    topo_info.threads_per_core = ms->smp.threads;
+    init_topo_info(&topo_info, x86ms);
 
     for (i = 0; i < ms->possible_cpus->len; i++) {
         X86CPUTopoIDs topo_ids;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ba52d49079..ef0ab0b6a3 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -40,23 +40,17 @@
 
 
 #include "qemu/bitops.h"
+#include "hw/i386/x86.h"
 
-/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
- */
-typedef uint32_t apic_id_t;
-
-typedef struct X86CPUTopoIDs {
-    unsigned pkg_id;
-    unsigned die_id;
-    unsigned core_id;
-    unsigned smt_id;
-} X86CPUTopoIDs;
-
-typedef struct X86CPUTopoInfo {
-    unsigned dies_per_pkg;
-    unsigned cores_per_die;
-    unsigned threads_per_core;
-} X86CPUTopoInfo;
+static inline void init_topo_info(X86CPUTopoInfo *topo_info,
+                                  const X86MachineState *x86ms)
+{
+    MachineState *ms = MACHINE(x86ms);
+
+    topo_info->dies_per_pkg = x86ms->smp_dies;
+    topo_info->cores_per_die = ms->smp.cores;
+    topo_info->threads_per_core = ms->smp.threads;
+}
 
 /* Return the bit width needed for 'count' IDs
  */
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 4b84917885..ad62b01cf2 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -36,6 +36,23 @@ typedef struct {
     bool compat_apic_id_mode;
 } X86MachineClass;
 
+/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
+ */
+typedef uint32_t apic_id_t;
+
+typedef struct X86CPUTopoIDs {
+    unsigned pkg_id;
+    unsigned die_id;
+    unsigned core_id;
+    unsigned smt_id;
+} X86CPUTopoIDs;
+
+typedef struct X86CPUTopoInfo {
+    unsigned dies_per_pkg;
+    unsigned cores_per_die;
+    unsigned threads_per_core;
+} X86CPUTopoInfo;
+
 typedef struct {
     /*< private >*/
     MachineState parent;


