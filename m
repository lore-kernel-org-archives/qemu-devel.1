Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4EBC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F97222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oVFipI6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F97222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2JI6-0004y2-55
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J40-0003mx-Qs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J3y-0001Pc-MG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:11 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com
 ([40.107.223.40]:62944 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J3y-0001NI-H2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:18:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHq05fygmjV7n/DXjEDWC1obgV4hy02sZh3wrUdA0udnxpEUhCIczeUskqK0woI/6YNxZg24367tN+RKI089YxURQCzLJ2ZyXxYZ0Jwr3nS4oN01HQWtsEVMyAb88SSJvTSSkH5zREjQ9qsxpdXITEDHS3hmhdwaWb6K1oUVpMMHgudDe4o3l3NZC/7qpEIF+1CeyljPtBydldoKW8xLIjjv4AzcMq6zb08zoJ6b9wgfpMsIoK8U10DnHMoksvP62Z+kbbZIWnrgSEqL0gi2b9h1yK5pr7bdRuQLAyiaGIz9nCsWPWKnqokWFG8k89nHZZiDAyw2Hf7EWYs5E+YGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82BDvXMRZvf3zVqwwIS/WPswdRRRO0zvBCyK5+YzSn8=;
 b=lQfIKDPQX5fT8FuL13fvzGffcKlkCk1hCf0gjaGzO0mpegyP+Jgv8qQBoYpdGk02NMARNVhm+XcK0UsG/AZmfK9Bdy+K3Os/eAxGNq0sO8TAFjzgf0qIv7cHTw5AkSu/0OsgyBG0Cnln8qnCewiI/6S7PwmKBB6StDYEgZeTEg3nJ87lNyxzzq/DdA2hqs9nyFxbE00pSr1ZAsUeNtY9fdbCXJUUGOilS3IXKrKnF0tJcZKSP/BsaMFECZ6NvqdgW6Xjt5dkqHBwlkGZa3CGy8HAqjnW1NUIVrtCxuHbZWkuMJ1ss3pbWtq+nBGqhkJRWuCoOF8GQtTZxQV1a6IiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82BDvXMRZvf3zVqwwIS/WPswdRRRO0zvBCyK5+YzSn8=;
 b=oVFipI6q8BP6PaB/U8Bu8nhX/YHykROgORO9o2qMOQ2ZCc8VpY8PqiiFDa3XzkK8Uey6Gfxsb+Y6KiIDFMk1aDks5VVskK5buUEcUGF3Arey126tz7EpTd7kyLQqRZX45A2W05R+/OtB+bVtL+ymOq2B8pMBKAGG4tK32Umxr0k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1222.namprd12.prod.outlook.com (10.168.166.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Thu, 13 Feb 2020 18:18:08 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:18:08 +0000
Subject: [PATCH v4 15/16] i386: Fix pkg_id offset for EPYC cpu models
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:18:07 -0600
Message-ID: <158161788726.48948.3019001029706753681.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::32) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR17CA0019.namprd17.prod.outlook.com (2603:10b6:5:1b3::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 18:18:07 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be8cc7bd-c08e-48f8-eefb-08d7b0b113dd
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:|CY4PR12MB1222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1222223129433C35855EE1BA951A0@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(7696005)(26005)(5660300002)(103116003)(956004)(55016002)(4326008)(86362001)(2906002)(44832011)(186003)(16526019)(478600001)(316002)(81156014)(81166006)(8936002)(8676002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1222;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcIO7qq5MH0e76Y13sci6pLomoGKeLsE2os3Bw3NByx7S3/5dKsCbHjit6qhSr7vg1H9O62HlEQ4dQoIvbvKI2MiEGym4egaQ6/PQmujigQNsz342zZm+rg0NeNmVGv3+QQVnQ6FksNhdBuHQkCTPBb3RYvpSpIN3qDx6T19IzeDKY+wGZawDV2/tDfe699I6n7J5ogxPl3gQnaJ/C+7y/ugqNPHU9OKAKhQBRZuXW4HfoLm6Oyu529qTCTJD1cV7a6eiFbb6pVyYGrTtlKg/GY0QyWZR45SsJoW+KwH/LpFROAVb5JgpvLX24kzHZqPi61BsRSu72pk0ZMD2F6iRpC0byNO1TZn8OQxYhVTSp2RlPK6pLbLrer347MCzSTuliACHcoTqndjTJ9R3bEmPBXP2l1XmptXYat1GSNwEs+/cMNzg6Yc1+upfZ0heXk0DZ1tLAXHXxzp5Aicnc3Hp3BhFi0Od10d0fijagF/098AAe2o9nfysjKi5SiFsPyw
X-MS-Exchange-AntiSpam-MessageData: frhp6KPQjQJjQBIzCt+mjEQ4s2m7LgeG4R8Q/osId1v70qktjARC/tvHzP1d9BCgmXdKskeV/S8oDMucPx8koBMgDNGhEO8Mo++v4+K+i87byuO2DGvu5sqexXfg2RdDAmMC0dFfdazEmP1j3M3ieQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8cc7bd-c08e-48f8-eefb-08d7b0b113dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:18:08.7375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT9GgzyHwJTQr1dWvR4G1dwcbh9BFfl9jrBNOiXxayrnB2iVUlU/IfifwjTF7Ock
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.40
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

If the system is numa configured the pkg_offset needs
to be adjusted for EPYC cpu models. Fix it calling the
model specific handler.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/pc.c      |    1 +
 hw/i386/x86.c     |    4 ++++
 target/i386/cpu.c |    4 ++--
 target/i386/cpu.h |    1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 93063af6a8..e56780b1f0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1754,6 +1754,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
+    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     /*
      * If APIC ID is not set,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 472dc3eb77..99f2a67d69 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -106,12 +106,16 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     Error *local_err = NULL;
     CPUX86State *env = NULL;
     MachineState *ms = MACHINE(x86ms);
+    X86CPUTopoInfo topo_info;
+
+    init_topo_info(&topo_info, x86ms);
 
     cpu = object_new(MACHINE(x86ms)->cpu_type);
 
     env = &X86_CPU(cpu)->env;
     env->nr_dies = x86ms->smp_dies;
     env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;
+    env->pkg_offset = x86ms->apicid_pkg_offset(&topo_info);
 
     object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
     object_property_set_bool(cpu, true, "realized", &local_err);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 082865d72b..b793da7c6e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5454,7 +5454,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
@@ -5488,7 +5488,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
-            *eax = apicid_pkg_offset(&topo_info);
+            *eax = env->pkg_offset;
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 64a1cca690..641e1cacdf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1604,6 +1604,7 @@ typedef struct CPUX86State {
 
     unsigned nr_dies;
     unsigned nr_nodes;
+    unsigned pkg_offset;
 } CPUX86State;
 
 struct kvm_msrs;


