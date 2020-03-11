Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9B8C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E7C20637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RrJ7nOOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E7C20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrHp-0002su-EM
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrC9-00009D-5z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrC3-000733-Nc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:34:01 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com
 ([40.107.220.53]:6137 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrC3-0006zv-Bg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcHhAKOGoZaDsWrJtikMVx+hziGHuTd20E+47KstwhsYUiLI0mSR5PKkHDk9cvmgb7CqgLVIJPIVT/J7Ghb4PVd4UQ9/Qku14yQ8xk2YnDHDVv1gRJ8b9D4cAOK/E03I3z222lmzTnvXe3KfrKC7Cy41eFYANP/mbKDwB6Qr1zD/eMcfT6CfKBZ1PxUCSsJGKCm8o2/GHoz/lDHvi/YRa+p9y1FmZp59yHiCu0225lbWFshfWq3aLE+s7Iw4EL+rZmri6mfXCm1KMCk5gs2EHJSFCZOzZfGHMMcZBVDN5W8JPl6PvNMPn9t9rftTHk5eTj/EawcFwZZXswNrsjwHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U38N/j8ekYDyGtvJbFj2sFEYNq03EM54VlFz8se/kEQ=;
 b=L+8WHn1LkQQXZZTpWcxsC7dOvuQ6JEMgnjo/3KLOVOaF7SIlYDvyIQp4FcMtPL2+YAp6FpxVwpw5hpafD04bynaFqRqpash7mR7rwaW4gAK4UOu5lImhatEO7zynZdpWVq1/Pk6VjrKuApIxC+fwBQ8GBTYymmbIZKxJZ3fJPCOkA0R88oHm7/kfM+glxznirFJcNfOjQKqEXAlTCrkQsREfnSc1K4fz5YSNl04prGJOjL58I5UyiDUrRVc2m7shBWAqUwTbQ6zmD6bg9yIRhikBMMAZbRiBzB/szbXKR9UY4ZeIglwobMLXxXMu/8ZYB/VhtdpDJ46VdHD982VD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U38N/j8ekYDyGtvJbFj2sFEYNq03EM54VlFz8se/kEQ=;
 b=RrJ7nOOmgH8kxfwGSJ93x7T+UCJOgxKIW6mloz4rDpb84XUcrAYLyq2vaTDcQdILI0ygBXoeq+6kK7Q8mYLBf6I4CTlHowLCxe6oPP7cgukjkdHlNViabR085qORQWgtFVgbBn6wFJ55QxLBl8r+Hajt7LrAyovqTdDepSWHqAY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:53 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:53 +0000
Subject: [PATCH v6 05/13] hw/i386: Update structures to save the number of
 nodes per package
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:51 -0500
Message-ID: <158389403107.22020.18234003063551182953.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:4:16::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM5PR2001CA0010.namprd20.prod.outlook.com (2603:10b6:4:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 02:33:52 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 115e1910-ddca-4a08-898e-08d7c564a399
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493308690714B2D237F24C495FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(8676002)(5660300002)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(15650500001)(16526019)(2906002)(186003)(81156014)(26005)(60793003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4fx610BuEW8cOqYOqAO39FTmfHQb8bF15djN3leVFiLBIzsjX5k58qbWsPry/+U2shNqsmPPcoejGT6u73yNvzHWXjFxNehau4VQQiMBchkbbcRDvHi+hHnoBKsMXDjjEzcUh9TPWd4TNUlrmwBdc+M5Ec7IuqyRQ8DImLtvsClHPveV79mvvidk7w0XNVcqlcX5/WjdC5b3x+XCAAusvIr1w5zgqpROZEWI1csC56Cuj/6ZZN1KU+Sm5uzaQzrEHrOzA6J5QN+9VdnD1poyNJsCTGdv11gi0/vvPh6lkImAW15aw7ksHnGMhIZhzcMOtmuOLUU9IKmyXOdYKiN3HevfFLiWp+oNOCYkPhRI5K9TFK7nRrRtrrsCqO7KXFW4F3vnG74HmimMyFHJfxAuhdpaqRbTA9rEE7y9U/FvldkFatkh1IXxilM/UOr+C5oRoKsp2vlcmcgRwfm4CsyHxv5Rb5AnQlk9HS5z0bPrfLTY9jzAMlK9uar6mAqYNtv5
X-MS-Exchange-AntiSpam-MessageData: q5iB7I8JbEZEmzoaQMEgRBffLMgrCAKG8Q7UFo5J2AIokNF56ztDEjbn9+3kr6m+Cw5sSHk9E07Mk621b+gynvGsFcytiNsAwQWEKyvtVrbq60lJ6QxHLYfRxoJGtd1SeiKBOpM3JKtxnvWboS97vQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115e1910-ddca-4a08-898e-08d7c564a399
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:52.9963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2Vye1Dsn9W/LN4etWZBL+ZSmsLhKYOeHgwuQgaoEeZ0QcGifhhv984vxFNcPSxL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.53
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

Update structures X86CPUTopoIDs and CPUX86State to hold the number of
nodes per package. This is required to build EPYC mode topology.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c               |    1 +
 hw/i386/x86.c              |    1 +
 include/hw/i386/topology.h |    1 +
 target/i386/cpu.c          |    1 +
 target/i386/cpu.h          |    1 +
 tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
 6 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05e7f1090f..ee89fcd1c3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1525,6 +1525,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
+    env->nr_nodes = topo_info.nodes_per_pkg;
 
     /*
      * If APIC ID is not set,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 79badcc4ec..929b80c9c7 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -62,6 +62,7 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
 {
     MachineState *ms = MACHINE(x86ms);
 
+    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
     topo_info->dies_per_pkg = x86ms->smp_dies;
     topo_info->cores_per_die = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ba52d49079..04f01e2a09 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -53,6 +53,7 @@ typedef struct X86CPUTopoIDs {
 } X86CPUTopoIDs;
 
 typedef struct X86CPUTopoInfo {
+    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6df3127fd7..2e5be37b21 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6957,6 +6957,7 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
+    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 68b186d258..7e9e963d78 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1609,6 +1609,7 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
+    unsigned nr_nodes;
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index bfabc0403a..049030a50e 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,12 +31,12 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info = {0};
 
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
@@ -45,39 +45,39 @@ static void test_topo_bits(void)
 
     /* Test field width calculation for multiple values
      */
-    topo_info = (X86CPUTopoInfo) {1, 1, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {1, 1, 3};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {1, 1, 4};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 14};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 15};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 16};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 17};
+    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
 
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 31, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 32, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 33, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {2, 30, 2};
+    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {3, 30, 2};
+    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {4, 30, 2};
+    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +85,18 @@ static void test_topo_bits(void)
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,


