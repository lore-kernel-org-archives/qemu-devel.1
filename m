Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58876C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102C6206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DLM8X40Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102C6206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCooy-0003p1-1z
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kColf-00072N-RF
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:59 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com
 ([40.107.75.74]:33025 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kCold-0007Xk-Na
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmzmN9HczdQ2qkG6IwC5bWHZJgAWWsd4hwy8owyBvvt8YIHTO3u4ZBEns2onUNzcqe7ZXqj+BL4sQ05LJRlGrG8N9Hq5sNfLxj91o1DwZ1VPCcphvBrhCa+CYQRXURmt+7Yxcsn4LMkOI3h2HnGzGGRcfPzrLIsa/IkXfPsiP5W+R9NFEcdo/f/uFJ4Jb+DB1aCW4KKAywS+7CYZbmVPsXTyISKkBl57ZvY4pp+oHKAeYmPQB+9CHJW0zlQ8/nLhn+loKMjkhe6VXe2BSiZyjy7uGYN6A2Frg/Q0dJIkkLT+EHhoIDi9j2l8zPZklI0iXnUnYbM1Fo+BbXSr+UxGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlwyayzh/Oh2fpmwlVfYPM3lNKfFc2zhDr++mOEk8Jw=;
 b=PlmZ/dCTv32LJ7ibNPu3mAQt/+1SzTQY6o5n+WAGfpCtyqn07iCvlZaY3/ZCYwFGfZdIehVpa+mpmGCn4m/F/s7X4IDQn3uTLXBfRX+11iEf9O6bMhSWOepvSkVJGmbEVC5dr5ijKrZMNVYfE3450dcTLQP/2r1vr6fhIyUYLecoM4HvnYZPexrIXDV6It+WhLUTRvJZlN1wnRGdKerLKS7OrvTWWrjVYXGhCLK8uOjMNJAOaPCYNvGM5yFjGNhWsPywoqhHyBM4W9v1f5QXgDjFZqNUO2I3SW2Bny4H6AXvswUeh3/ntUYAtfWTgg4lmmtBzHTJYR/ulzN/j8yK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vlwyayzh/Oh2fpmwlVfYPM3lNKfFc2zhDr++mOEk8Jw=;
 b=DLM8X40Z6GGJOYrjVvO5gQf8VemFw0jTGLwA2hrsP9GPDBRQE2X4XxyALR6eIEtTZr8Z0gP14ZOcVoxebSCyxaYsFLT9OGn1WuFf7qmPIvKPQviDGOcbT0N37DDTrwJ0UO2dVDkpFrFWh0vElHuQPvBlNdxirplqPRU2a8ZwpWQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2559.namprd12.prod.outlook.com (2603:10b6:802:29::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 18:42:55 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 18:42:55 +0000
Subject: [PATCH v6 08/10] Revert "hw/i386: Update structures to save the
 number of nodes per package"
From: Babu Moger <babu.moger@amd.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 imammedo@redhat.com
Date: Mon, 31 Aug 2020 13:42:54 -0500
Message-ID: <159889937478.21294.4192291354416942986.stgit@naples-babu.amd.com>
In-Reply-To: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
References: <159889924378.21294.16494070903874534542.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0701CA0035.namprd07.prod.outlook.com
 (2603:10b6:803:2d::25) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0701CA0035.namprd07.prod.outlook.com (2603:10b6:803:2d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 18:42:55 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d1861f04-5db1-4824-7ca3-08d84dddace7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2559C558F58ECC9623312A3695510@SN1PR12MB2559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:353;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QH4QVFfZGKxoNTKUxmI5FkjZMFmgzohEIV+qQAYyKdLwSR9IyEdncf0rFtOlcrsKi04jQw2YkzXCP9Hn0I9kHABi8Hx2f8twYDbOXCHtwT/A8juXhZtfVp7UIFiCeTt1F8+U7BIvHlv8hrO3eb1rpXuAUnjn+Nfgdqnk9FrUEl/jbj3P5OTookYLBcDvuedfxtOoima3uuUjzhDmn4qxwf6sbgXXsT2pPJnQuzeHaItsBbnoSGCZdEBZbEfr5YaY/+DG5AnLCzO9nwB2NLtkmYlMNZTKoyZ/N4V4NkB9sOtoBlm8o1pHBk/GFRQW2D92pp9GuUQDw5y20EgwWFNdcw9MkTYxYJXYhtQ5JlGeKS7gXUlIi9vwOVAOOvAu2M2H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(2906002)(66946007)(83380400001)(66556008)(4326008)(26005)(956004)(316002)(16576012)(5660300002)(186003)(66476007)(6486002)(8676002)(478600001)(44832011)(8936002)(86362001)(52116002)(103116003)(60793003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 786NZamkHsO2sm9PZAZ7zJqxOPC+7UhitpBnoHg6EBek0rM7IBLOS+pErMIZxfHJjNhzWxO2v5NXpz6f69M1gnGRy1IaIV8r6pcnrYIALVRHL7dVirlI3EcfZoZsZuMVcq+DJKRl42V4yZlp7bhHdoKCsuZnbUOTg7Lk3xpSbWxVvMJVVCUb80AwodlmQW8WaGvylgjYEpcNrkkOJZhgzO8yYjoLXgxONrvr9G7g6xTxi80zhj6c5rOWPDGf4g15Kt0VFFbxEaw5li7DoO1JWkhGxeY/56wC7KXgRQIMLUcUyBK9uXx7K8uoDGVz4hPvKTDDmVlJsuDkyPgopWophrlj9w+ueYSF15BODfyZUQZK40vWMWiYTVB9pfZFjRTrlGZDr1qGJPpQy0ks9QQarWeWsEmuS1VUEvf1GUbHc6Ev1zex8gGgFQPFza/Po+HvfdONvyXt7Za4XjcoojeBA52gmmhTjeW//aaCc7a1lRD7XJrbDttEyGvl5z9bc/uVN5FHv3bS0/fBCS1i4HUIQEmPaN5l5hYkFqmaVX1zM5KNge56OVi5O0vepsFxtspbBbKtx8voR5yABl3xb/aoc2R84ZSlnawWzfbvBhkxZUIaBL6DnX/bPe5Dn5F5N0rulR5CL3CweW+EfRAUo7x+EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1861f04-5db1-4824-7ca3-08d84dddace7
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 18:42:55.8257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJDQ3I7po9G2vZiHjwNRXB7i03iijyPSW5dHhvPRIiWmLhmqybsnXBA31jYQvyL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2559
Received-SPF: none client-ip=40.107.75.74; envelope-from=Babu.Moger@amd.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 14:42:32
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

This reverts commit c24a41bb53c0854d22c96b30d57cfcaa543c409d.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    1 -
 hw/i386/x86.c              |    1 -
 include/hw/i386/topology.h |    1 -
 target/i386/cpu.c          |    1 -
 target/i386/cpu.h          |    1 -
 tests/test-x86-cpuid.c     |   40 ++++++++++++++++++++--------------------
 6 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0677d6a272..d11daacc23 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1501,7 +1501,6 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
-    env->nr_nodes = topo_info.nodes_per_pkg;
 
     /*
      * If APIC ID is not set,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 727c4a0f1d..c1954db152 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -62,7 +62,6 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
 {
     MachineState *ms = MACHINE(x86ms);
 
-    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
     topo_info->dies_per_pkg = x86ms->smp_dies;
     topo_info->cores_per_die = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index b9593b9905..81573f6cfd 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -53,7 +53,6 @@ typedef struct X86CPUTopoIDs {
 } X86CPUTopoIDs;
 
 typedef struct X86CPUTopoInfo {
-    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 256bfa669f..ba4667b33c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7023,7 +7023,6 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
-    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5ff8ad8427..d3097be6a5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1629,7 +1629,6 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
-    unsigned nr_nodes;
 } CPUX86State;
 
 struct kvm_msrs;
diff --git a/tests/test-x86-cpuid.c b/tests/test-x86-cpuid.c
index 049030a50e..bfabc0403a 100644
--- a/tests/test-x86-cpuid.c
+++ b/tests/test-x86-cpuid.c
@@ -31,12 +31,12 @@ static void test_topo_bits(void)
     X86CPUTopoInfo topo_info = {0};
 
     /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
@@ -45,39 +45,39 @@ static void test_topo_bits(void)
 
     /* Test field width calculation for multiple values
      */
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 4};
+    topo_info = (X86CPUTopoInfo) {1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 14};
+    topo_info = (X86CPUTopoInfo) {1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 15};
+    topo_info = (X86CPUTopoInfo) {1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 16};
+    topo_info = (X86CPUTopoInfo) {1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {0, 1, 1, 17};
+    topo_info = (X86CPUTopoInfo) {1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
 
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 31, 2};
+    topo_info = (X86CPUTopoInfo) {1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 32, 2};
+    topo_info = (X86CPUTopoInfo) {1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {0, 1, 33, 2};
+    topo_info = (X86CPUTopoInfo) {1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {0, 2, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {0, 3, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {0, 4, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +85,18 @@ static void test_topo_bits(void)
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,


