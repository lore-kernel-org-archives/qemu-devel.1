Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E36EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8CB20674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 01:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MlX4E/gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8CB20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJl6-0000oO-SH
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 20:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuE-0005YT-HO
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIg3-0002qg-1D
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:38:00 -0500
Received: from mail-eopbgr820040.outbound.protection.outlook.com
 ([40.107.82.40]:42098 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIg1-0002ld-4y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFU0bki4uzA4x5okcI8bP01+F7KDFDR/ayTk/iH+Rhr4IU7XJPRKfDfiGXZWS/BZiPGKfsDY28Rsl8nZa9RpAcZfHgaJFruJCPTPd4/Y3UTp/YIWbx/4vkngjFXSsKQT12LOj8ThOg710jUPEsctl5K1A7XYdEwgOS+nQee5XvTx0Y2bTjjOdze9uI1FaeNJJX8z0Ped52/LI2wCMA/vQgKvrzROccSfW/hcih2vkT/QCcSb4iCvzu7Iv3TRhk4vf73uHHkuJSN3HSnaBAHrrfCyZvmUZm0YeqI7H52yAFyn1zCDckyZjIX3l7T1T947KsR7cLPwAqswd6zQB/F6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtZ9dKqJ/zsn02SG07hRgqm2AI8/P2vrJCO2Ofpf7bc=;
 b=PTWMCa1gUgejY0EsDobdsUP4p0nlSAjQ6NlHgli/Y388XRphdMGa6eEkexIiWXL3gH+ulCD3l0DoPJ7vL0AOgR3x0EElc7ndzz3X8J+M5Zook/Er7IFnuFQ3k8CPfslSkGjp82MuCtwDoRsShDK5K/PNaSwcFWqwGcwvoTbPY6vPJY8GhmYVLtx5cQehTzFoY2f7YuYGwVyeD8RquaJYatETbgPJPchfu5VTJnat0s4eyU31nPamJfeI2w7OmontKnNAyXBbDlaUL8Ls4BnmJHovaNRO5I7LXZfE4B98gviBvTp3p7/kwCceq0uGS4dSH70KgO0GFDUhij3/dHcIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtZ9dKqJ/zsn02SG07hRgqm2AI8/P2vrJCO2Ofpf7bc=;
 b=MlX4E/gpkVaQU9i04bIe+UMY6hIzPh1JIlijZcyWgLv91iRdotcYfsMISDaxjG1XvpsbqZ+SGWoIcZej/HP0hMQqadL2bx1aCDMUxfY4sb9e/QxA1MY6Tfj3MtQV/bZ03LssEbAhCMbregndlqQ9XUX2OZSjM1dQwIUGn2jwPtc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2535.namprd12.prod.outlook.com (52.132.141.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 00:37:52 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:52 +0000
Subject: [PATCH v3 08/18] hw/i386: Update structures for nodes_per_pkg
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:51 -0600
Message-ID: <157541987113.46157.12421621035195290598.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:805:ca::24) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 952d456a-1099-4922-1716-08d778523273
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:|DM5PR12MB2535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25358DB07D329443983AD1A2955D0@DM5PR12MB2535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(5660300002)(76176011)(4326008)(14444005)(6506007)(386003)(3846002)(44832011)(11346002)(446003)(52116002)(186003)(230700001)(66946007)(2486003)(86362001)(6512007)(103116003)(2906002)(6116002)(50466002)(8936002)(81156014)(99286004)(66476007)(66556008)(26005)(15650500001)(23676004)(305945005)(7736002)(6436002)(8676002)(478600001)(58126008)(316002)(6486002)(25786009)(81166006)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2535;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTl9zPk68mTb5SNI+ePPMxt9eBWYyhziHVVDmnQKkrvanIP1Yetm+VktFAZy7bCL2wAOmrZ6qtHaXeBp5xtiBMJ4Ylgu4AohimCtNhYtZJDi5mLhKBB9ThYF1Prmkk+XeFgwnKLp3mVhl7z7SPFIhsgjnURCrccunrW+ff715stqWmkRbKdpQcyFPMDWHuZ03OWmil9ma3xZdSMb7d5KYk18kwSYW6j2us7GmH5in8IxJDL7Ps5gUPN/GIc8Y2on75r+wfiV2BnGHTke/UJLQ7XXkA+l67zqm1/NfJJ8IYs39uX+xDdqem+gR/ke9jKd9RuNvyNdOFj5xZUt+avT2p/NvEEYqFhotkD4aI/YZ5sW0+NkbmQNMtMWr9Dj/VLcrEWAnNFI2iIcPC4B8dJvu0lhEd9aFR3eo6BHboVo048Wdv2S3jHGYm1/M/OikiSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952d456a-1099-4922-1716-08d778523273
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:52.7138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VUTyxxd8Wiz46Y9+QewfA8jfeokBoWA/hb24XApZyPEs/vT/+UQrS4WnArmbYUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.40
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

Update structures X86CPUTopoIDs and CPUX86State to hold the nodes_per_pkg. This
is required to build EPYC mode topology.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c               |    4 ++++
 include/hw/i386/topology.h |    1 +
 target/i386/cpu.c          |    1 +
 target/i386/cpu.h          |    1 +
 4 files changed, 7 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index df5339c102..5dc11df922 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -870,6 +870,7 @@ static inline void initialize_topo_info(X86CPUTopoInfo *topo_info,
                                         PCMachineState *pcms,
                                         const MachineState *ms)
 {
+    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
     topo_info->dies_per_pkg = pcms->smp_dies;
     topo_info->cores_per_die = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
@@ -1390,11 +1391,13 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
     Object *cpu = NULL;
     Error *local_err = NULL;
     CPUX86State *env = NULL;
+    MachineState *ms = MACHINE(pcms);
 
     cpu = object_new(MACHINE(pcms)->cpu_type);
 
     env = &X86_CPU(cpu)->env;
     env->nr_dies = pcms->smp_dies;
+    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
@@ -2242,6 +2245,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     initialize_topo_info(&topo_info, pcms, ms);
 
     env->nr_dies = pcms->smp_dies;
+    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
 
     /*
      * If APIC ID is not set,
diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 1238006208..cfb09312fe 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -54,6 +54,7 @@ typedef struct X86CPUTopoIDs {
 } X86CPUTopoIDs;
 
 typedef struct X86CPUTopoInfo {
+    unsigned nodes_per_pkg;
     unsigned dies_per_pkg;
     unsigned cores_per_die;
     unsigned threads_per_core;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3c81aa3ecd..9b2608a4c8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5996,6 +5996,7 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
+    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a56d44e405..0ef4fdb55f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1591,6 +1591,7 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
+    unsigned nr_nodes;
 } CPUX86State;
 
 struct kvm_msrs;


