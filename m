Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA8C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E69121734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RIhQK5fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E69121734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J9b-0001jS-Q1
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J31-0001sS-7m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J30-0007QP-6C
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:11 -0500
Received: from mail-co1nam11on2064.outbound.protection.outlook.com
 ([40.107.220.64]:57185 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2z-0007Lb-H0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzfQ/mffsmKF7FCpY7cGIe6PFrtqpjIyGKnybwQPFDqQ2p3CVdQJuLWnAjHTNJC9zgezdVT+l8H6IULC7hCo3wkkTQ3P8i5odwb5mOtmDtKeSeRy8dfhU0SZtEKrsvLpT1ZlpC+XlcNLu2P09pSx7/lScLFBAI1+NdwdEnT/caV7pNWpT8SxsZh3Gpbf18mtQAW2NdXqSd3kPdXOPCqQwglJnQn+HDXFiuzMI3cIf7etdsaHsx0cys59gYibywCQ6oyjON8E3/H5EvilTVB83bW54Ea0oG/x1c8ViBjgwqEa/BIrqq7a9ckAUR2MJBpegcfET4aHDOmVWfu8LxRdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlEw3NCuvSauq7ab74+CBDRSTA1LiZ4dpyR+996CpIk=;
 b=YwZH1Ht/W41C8Vo06mwzqKMp1hyJhkIHLBewOWL6cwNVoCabFew+sapLWGgniI/kLho+8klTTQAHwZMR11Q4SsWZdoMyzWmDtdPAPPjDqSM0d9OpdU0oki9KW90DxsvYwe5fXoLIDVQOtgpRt9qEIUrYRyTBMaR6vTuQLbpis2RU2wmwtvZoqZLOr5iRLw4457m7mouMpnJqKHzWjUvtB/Lwk53SZWB2hrh7jKnEyu5K/drJ9QGTHoRYOnctzigTe9c+Osah2/kTI8WFP42BsV+sDdggtY8ZdKaHbW8melQME+eN7DyDy0gzqZAF8F79z+rf3EyX0IZiCB5Kh0SDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlEw3NCuvSauq7ab74+CBDRSTA1LiZ4dpyR+996CpIk=;
 b=RIhQK5fWKMzVpn/d+VqZttuaSoidQ3cJSYfWYwAA7R+rgc2cIgengoAsWdsv3Xw7XzJnF9GXQcwROVPCzDeObslzzmNZ9E/nqL14sMd9nKW0cA82dcXXjnWwF+0Y+Gtz7CybKhyiwIpd5eL3xJZiaZ+X+0dLCzc6EI3g4HIsgK4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:17:06 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:17:06 +0000
Subject: [PATCH v4 06/16] hw/i386: Update structures for nodes_per_pkg
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:17:04 -0600
Message-ID: <158161782489.48948.9328710425201785950.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:802:20::19) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0048.namprd12.prod.outlook.com (2603:10b6:802:20::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 18:17:05 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03bf95e2-2759-46c6-a238-08d7b0b0eee5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318168453C2A50F8E144E15951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(15650500001)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bh2NiwUemJJn84yoedPV+E9t3gf96Doxwhjl87aFEOOYLcT0v5cD7sha7qrcoYSdXCQYzzSK5IS3bKiPvIdhRoLCLR9t3Q69ZQQdpRW2Iuqc6FE0qQO/8mI7MuFVRskfZlnxaUXSSelISZrWQWb/utEqmhDoZ6KiGu3xNMRNVkSdLSXj/Rk0+JWDXH0LS4GTBW1PMH++axVHgxF/qCtgJq87jfMH9jCiLbzEd1QV9TvFcMK/kABvbPpdbVMenKz7qba3sBChnN6/M6jQeHs1ZJYguvzJYBSG6s45GpAl9EgZXaGXlPzXRrauYtpp4CsfTvJ+Wa3QvchtLV1T/bmnD4BTh8lC8TPToGUJdSpZ0jAZwlC7aSCeYj8lDtkO9B9Lan25zwZLq9GbxAXTmVL1kmGTJFMuD603sYdtKY6xAZdJgmFK2UDc9Vmyx7BsoMoi
X-MS-Exchange-AntiSpam-MessageData: PmbTDmR0vkoHktK9ugC13hXnGm/aTXyv8HKTWWmESuCBscXt3cvgAPsf2tM/o5D8asgovgybhjpUsKSSh1ZbhMqbiKCj7Wnb8uIl3scIe8SuzJAslS50l/ogeCu5jttVEmwlhVKLgXF07dVzGvVbyQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bf95e2-2759-46c6-a238-08d7b0b0eee5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:17:06.7062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDv2BlpmcTHH+o9jvpijVqgLeUbXB3wKC8x9CxDjRFO2bvme1ay2UcSgfOz0uYps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.64
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

Update structures X86CPUTopoIDs and CPUX86State to hold the nodes_per_pkg.
This is required to build EPYC mode topology.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    1 +
 hw/i386/x86.c              |    2 ++
 include/hw/i386/topology.h |    2 ++
 include/hw/i386/x86.h      |    1 +
 target/i386/cpu.c          |    1 +
 target/i386/cpu.h          |    1 +
 6 files changed, 8 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f13721ac43..02fdb3d506 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1753,6 +1753,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
+    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
 
     /*
      * If APIC ID is not set,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 083effb2f5..3d944f68e6 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -89,11 +89,13 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     Object *cpu = NULL;
     Error *local_err = NULL;
     CPUX86State *env = NULL;
+    MachineState *ms = MACHINE(x86ms);
 
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
     env = &X86_CPU(cpu)->env;
     env->nr_dies = x86ms->smp_dies;
+    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ef0ab0b6a3..522c77e6a9 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -41,12 +41,14 @@
 
 #include "qemu/bitops.h"
 #include "hw/i386/x86.h"
+#include "sysemu/numa.h"
 
 static inline void init_topo_info(X86CPUTopoInfo *topo_info,
                                   const X86MachineState *x86ms)
 {
     MachineState *ms = MACHINE(x86ms);
 
+    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
     topo_info->dies_per_pkg = x86ms->smp_dies;
     topo_info->cores_per_die = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index ad62b01cf2..d76fd0bbb1 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -48,6 +48,7 @@ typedef struct X86CPUTopoIDs {
 } X86CPUTopoIDs;
 
 typedef struct X86CPUTopoInfo {
+    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7e630f47ac..5d6edfd09b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6761,6 +6761,7 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
+    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index af282936a7..627a8cb9be 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1603,6 +1603,7 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
+    unsigned nr_nodes;
 } CPUX86State;
 
 struct kvm_msrs;


