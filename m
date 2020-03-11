Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC0C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCAD2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AnHbwDR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCAD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAGZ-0003bY-82
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAEB-0007NE-7A
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCAE9-00053B-JY
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:27 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com
 ([40.107.244.43]:6248 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCAE9-00051C-8y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jphBSEnCSHfYnFb9IRx89TYzvfSR/YYNmJ6meCiEPm9EX0EDfrR6EtbSfDekQhv84FnXWwrByK8laY/OeAdrebu4kQgp8lEgW6lLTDYYW9MzX6kxfbBNKao5AJ8mm2rbaza9yl4K4e9ySLibKi4NzIOfOTv/J/qhysTCtsjKWqqUbHqmPfTBtkK97iKMEoEt24WnfdkKli2vsP/FBI8x03YPL/ov/f0BFkHmFaTM3HxWuillTEfXvU+dbNDmgUV46DVVyCmm9FpT8WHH0NCunvFhkNmkdBHXVzLX/P85tuqXJGiYcbaIjVljOKj8zRMIHcMnMwihRskXvFtdle351g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts19tF8lkvm4awPgDDvOublQVq8xxTwDfXUounFNYBg=;
 b=F9wqY5wgn41Z2I3YUG5ABOe9A1x0nI7DnjcQdBiemPawHx2/SfbA/zeR62y5liP4drSYPa5uL2QKo9V8mWZvRbGCj9sq/sH5FrKllJJz4GYxTawqxM+JZbbfMXZYAlrow8qNZwRTEwsI7l2d0O46Z13NdJmyJneIbjK7EnjA6bpN5we6aNlNZV9KUUFqEGAhV2+6uOo5cNtoFOKVulcn+hYnnaMecnKyXZGoGJbeewyKIcRCWr7edyDDYk4hWdzUgdDTPr1WJbtDNnS40MacUBlIDIjgOYF0PWRay8yPK3v2MaEmMMhpTjCsBNu2swbZHGLAExdaYkMy1Ikp1FMJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ts19tF8lkvm4awPgDDvOublQVq8xxTwDfXUounFNYBg=;
 b=AnHbwDR2HDX+jgKJyDQ1+sa/wDnw9vb1KmY++oLmf54RQtBlwIxhUpU8l6zzuDx50+rCq0Uvu4nn5g/aCz+BQ2bwgB0+WLhgYYGu8aHPjNai0P0SzsdGY0HLJUyArLVPHQbOH/OONEZ5LuoVzeF8+KBw671A1LHExMWpjONo2uA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 22:53:22 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:22 +0000
Subject: [PATCH v7 05/13] hw/i386: Update structures to save the number of
 nodes per package
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:20 -0500
Message-ID: <158396720035.58170.1973738805301006456.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:5:120::14) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR06CA0001.namprd06.prod.outlook.com (2603:10b6:5:120::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14 via Frontend Transport; Wed, 11 Mar 2020 22:53:21 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fd2b412-207f-4be6-448e-08d7c60effdd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2480:|SN1PR12MB2480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24802AC688CC46C5FB353E7C95FC0@SN1PR12MB2480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(186003)(4326008)(478600001)(2906002)(16526019)(15650500001)(81156014)(26005)(55016002)(316002)(956004)(66946007)(8936002)(44832011)(66556008)(103116003)(7696005)(52116002)(5660300002)(8676002)(81166006)(86362001)(66476007)(60793003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2480;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo2yTtrgiFi6e2wge7MxrtD9YaZdpOvZgbHzkHuUBqaYBdUoHjuFDPR+JY3a4P+EBWozguLE2/4Xiivo/W5kwR5IGfGemY+u3CVKTP9X3vRCAGzf3er0S+9NhoSN3KdxEPYRwNl2SzTJmiI4y0K2SBNbfuH/kw86kmVBIAGWV63qN+CBk4gYrIJT03os1o3ziIYgDPOut8Kq4V4tHpmddfienspwxiji4HMgwpWiBRxPfaL3tV3jKx/sPqQPb7azsvP2Ul7XLhItQytV5RpjKRN49oGKCy5zPcggSFghyRGadIPWm42j31+a/RVKa9U61UXdg92jWOaDTDVLKg5zQo2eBC7uQkSlSi1f76MM+cvL12ztbSh+9OGoycjLEWcLSs89qPgmBMXfMa3IebLscH1Pd5diQw7IpKBUPWjZQdLnx16UrAkw4ObEFJnnOahsmGoXat66rWn2q7NcKC3Gw0sZzFvk2uv+giDC5Dx7ZkykrmVW/lP78csoj/v/nzR8
X-MS-Exchange-AntiSpam-MessageData: lfMGJ1q9mpnjKlpQkgSt/5kOuvQUNr0v+sxBx6zhyLi+jjDaTriCF3PdABToXoRCeGqBhsONqp4YW8+zLebeLI5L8DYoBFhUcmrwyHyXbqEUOVR3gyppxaeYemGTjGNNzUkF3QogL1jTU9PGPGiUYw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd2b412-207f-4be6-448e-08d7c60effdd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:22.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spWAMjVsw9pLoT7HIdJGnsYyzNYbPokBvKp0pL6L21E4DmfQqlHJcwRvg3mXAK+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2480
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.244.43
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
index 84d1944a34..42834d2319 100644
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


