Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81602C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6072073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HxvEcwKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6072073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dkk-0000U7-9u
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9Dfb-0000Yg-7v
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfZ-000374-T3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:35 -0500
Received: from mail-eopbgr680046.outbound.protection.outlook.com
 ([40.107.68.46]:13799 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DfZ-00036o-K7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVYnXhYPwz4m4kV+39eIUObJ+eJ1fhei7+YP0U7fB73DX6HSE6ycY7TLyVMpi6k2DiVL2h+hkMCLiekZXbYGWrQ7uElLHMLR7fpw5VlsLfX3uMfWDT97tCUDJdsNQpcGEK0vvXCsv70NEUNiUWrG29qx4YELqv/HMnJvPvEo8eD1KTF3mdZ8AX3gmZrchT3R3EmUo2aDad5V2Fa7h7iEerygPTV4KDqB0o6WBC5gAVlF+XIBv8dOYxIwPPF2kB5bxFt1q2nRZXguKUElHssaSChW/bgrpOB7Mhridmc2PJ9ssC/HgXOCDXNzv7xnOJzgN4Bi0uMUyQCJPiWN8wvdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5gmNRIWq1pWWeg50Tsw5x5yoK2dwsGFK7mJ4WcjmxU=;
 b=WP0s8VapnFSVkC2mvggGt6gjmTDu2O/0mAtgbOf+xMVxCZR5XrCKJbSNXKj8U9DbuSrgiAfqR7yMJVPnkQ5dySHDtWrcqh9o1nBYQVHcTOPU1PReO5+Jp6EyS1mrUoKd6bKrhI1mHSKIlOfHrVivUhOIxFEyA0IuU6lRph13UMN+oVJC84Kzy2QriUr2CCOc95WzimPuSGkeLbNdMNB1zo/sbnvADrDYslylK2AHK4FMUcNrbgZzVxLBwGbLBvAvfBNta2frFsWc+m9jDLIp6BlyMTUn3aix1XKT0ymffAiC50aP/04+SikLSgCS24I5J+q05orXKSyrjQzJgux7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5gmNRIWq1pWWeg50Tsw5x5yoK2dwsGFK7mJ4WcjmxU=;
 b=HxvEcwKv9XFKy+dLQDzmSFa/gm9WDb2bFhNBbfm5lQoHW9Sy64Q1nFMdOA3PGZ5LFrhFyonGNeoKjv+XoevEXlDAMlejNR80S3RXyAMYBAyWN7qm87m/axWeTkMM6JMUWMutvMWE58QyWXN3p9yOF5ZdyZiFYcpjGm5CLoXbWHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:31 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:31 +0000
Subject: [PATCH v5 06/16] hw/i386: Update structures to save the number of
 nodes per package
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:30 -0600
Message-ID: <158326545066.40452.2744012199788458115.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0501CA0049.namprd05.prod.outlook.com (2603:10b6:803:41::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Tue, 3 Mar 2020 19:57:31 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2584e4cd-ba18-4e0a-bbc1-08d7bfad1be4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB257303A5B7FA1606520C0A7C95E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(15650500001)(4326008)(66476007)(478600001)(60793003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bud30QjqKsqaBi76/u3v4b/QM0rGGhzxxYR11N2WqmOlj5bsv/PKGPfDHIT5PUwJd9suMD5wnC0K1hG91EXHkuTq35L7Ky5Gi7sDxn7sXSS82poGTkEFg85xsvthhQDa0klXP8uJgP4QHp+nEGfy7QJQAmbBaslBSjZ5T8cWYE3FcXCzj1WUyzp/ehox9uvwwfmJ/sMcVXrVqTXW2w7KTSoGnVBMsSy7J6hFARhU60B43M+lbi8/PgDS19FYrgR5rNw9chWu8ULWgWklhwsS8UAvPn0Rl+3CVUz2jxs6QvrKYHmuOOBsa3wNyuJ9PVv9bAt/7vo5FwGR6x4FK4R75dZR6JLB7Lw2ueyC2oT1uMmAtzApIP8aj/MuMXduOma9CqFTLBkAq+ZL2y+nseR05WA1SOr1ZaWLhP5O9ew2I3hCdbj8ZHvfOdOBUpZb8D0IHZvvZCQ5HYDB1X2jkzddU5CVkGuStixSMPjedvsOcLJlrIIodRIgQ+vu1JuAWYh+
X-MS-Exchange-AntiSpam-MessageData: 3XCqu3dqEg+YnHV9Be6+P0cw15l3fx9ZFMclunohrm/C4ihsy/KjPH4VbfAE5HQ+SbNjQ6DlsqinGWubU4/dSFKgsfG5yTvb/SGziBBwA9W+VRqJ5fwHkMMjPvck3zsOLB7ZDn54CljDbznlJ7+nKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2584e4cd-ba18-4e0a-bbc1-08d7bfad1be4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:31.6056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Gqd8h8nhY9Ekc1IGyVTOy18GrB0U1ymkNGAnVrjZMWEGc8oUHYr82pJOedNtitv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.46
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
---
 hw/i386/pc.c               |    1 +
 hw/i386/x86.c              |    1 +
 include/hw/i386/topology.h |    1 +
 target/i386/cpu.c          |    1 +
 target/i386/cpu.h          |    1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 68bf08f285..3d13cd46d6 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1526,6 +1526,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
index 1263271edd..40670f8aca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6829,6 +6829,7 @@ static void x86_cpu_initfn(Object *obj)
     FeatureWord w;
 
     env->nr_dies = 1;
+    env->nr_nodes = 1;
     cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "family", "int",
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..20abbda647 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1607,6 +1607,7 @@ typedef struct CPUX86State {
     TPRAccess tpr_access_type;
 
     unsigned nr_dies;
+    unsigned nr_nodes;
 } CPUX86State;
 
 struct kvm_msrs;


