Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E978C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ABC2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3UXqq/Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ABC2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Dnz-0006wZ-Kr
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgS-0002QQ-Ig
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DgR-0003Oh-Fr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:28 -0500
Received: from mail-eopbgr680044.outbound.protection.outlook.com
 ([40.107.68.44]:12441 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DgR-0003Oa-Ac
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gA2lFw3TBojDAZ81xKTsYpR/dnBeI/0f8KI094gZNDLlk8jAU6yEdKYoNIbPcdbXmWXQosFBTRYCGg4CXaRNhhyXx0RV9x2rBwysQvTwEl5FmGlA7A4U8i0t2RPp00o/2tWNEgFn6HqKjAu/L4svGzrrlbrpH8fZxHQCOZQw75rqzPs4xYHBxsmqkEkhVLu43rc9oWKvr/6AFe+9ZwItnOTh2lq8ubsZUpl7wT4WbhMrYJh3ifvAv8eOnMN5fVIn/qB3r/JhpCAerSDz/FqfX/unj3uTMFygVR5mwGwYpoCdH31CeRd42b2osN4W9Z5UhyjNG/ulVQDB/hlW3pA33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ+iUm6fjVmmjcFl73APMr59faKnGQ6BP2PBLUKQJF8=;
 b=Xp7iCzYi4aQ9H5iaG/2fv7ahRHaDWZKUSsctLgSsDRA9oqpSCXxRVoMhlo0/5BXTzeIvc8AL0YC2/XE04iqaD5gtWM+JGWoG+uQvQi9zva7PIu4zyfIsZTw+DoR0ayW8RhimN5f7pxxosxXFQyyCmMMOtTBmonaPPnRetoRfMlcm7PJH0kGRtIekZZpd05qkIievTJVrr8IoazrHSaPuLzsha5sQCxA6Ss7lUuSx480aN4tuBft3MEzSmxfkSueb0OPaSw+oAGiaeuQ5C0tz5tQI7AX95p9QrrwKGPdEzIcbOy1lrC/P95d+B1RTSEom+GiFFssaFG+7GDk2dMAfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ+iUm6fjVmmjcFl73APMr59faKnGQ6BP2PBLUKQJF8=;
 b=3UXqq/Gd9c+pp9/LzA4R/xOphYWsz2viBbknBKdbb8VW4sm0ts7HTWd4hKd4UC3ZIgii2YHEXcpWGMD6XOq6+MRwrwqL/vR+ANu9Z70+T9QRqiiuyCgJlMLWaCbaAXMAoUGRXIWYYmyzBdrW+67Tn42SaNESGdoRdPWGup4MG/Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:58:25 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:58:25 +0000
Subject: [PATCH v5 14/16] hw/i386: Move arch_id decode inside x86_cpus_init
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:58:24 -0600
Message-ID: <158326550403.40452.15934956681175349815.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:5:bc::28) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:5:bc::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.5 via Frontend Transport; Tue, 3 Mar 2020 19:58:24 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddcf8b7d-0a05-48df-c8f2-08d7bfad3c19
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25734AD08DE137CDE883B6D195E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(81166006)(8676002)(81156014)(8936002)(103116003)(52116002)(5660300002)(55016002)(7696005)(66556008)(66946007)(44832011)(16526019)(186003)(86362001)(956004)(26005)(4326008)(66476007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2573;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSJbfKYw/DKlt9owjqV2VAhz1ZZ5aXd7pFAUEPjBfHL6GiWWO3XTdpEA9JMDJQGfNrab1FQDmYXIkTdIAZzQuLt1G+XjkZ3l/3SUroLOEC3yJRQG9xIDgbp8ER1EIUYdCW+nTQah9VAbYPU5AOwwKtt5Kk814oFI2IBianZqaPR0CI/Fno9TJ3JOQEj8iBzmhnDjnGZeI4zCxmO4BODo6h+ktxb08CA9XxRD3YsSjNyL5SYUwesEMSwh92LZsqVHtrhMoHjJf6j37V/28bGZ+oMU9pL/U3HxoRJT2gvanrf1wfkuZ01/mTtHlKUxJLF4d7qEjE2nFxyN36uoP5Co1rJp5SmzdeUKOonqly4WcyW9ZwmFUlCHgg1dQ0DJgiE6vnsJMpIEFSF7hhYOBqJ0tuvJNCaooo5Jyz8jG/VXxAr2FVaczNxRlFoxFUeH0WRM
X-MS-Exchange-AntiSpam-MessageData: tir7xTpsX9g1iPsNSQLOKdHBVzDqKeVG3Y1DbzpWUIg6ZnC2Yc9vAFP95rsFSuHljSiYYPxPn6nGjhIAhQtAdaO+bJNyWp/IUmI9m97m1sFo/nkZtdvc6PsASMPC1suwIz3Y3zoJ+6afiNMgiK9iVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcf8b7d-0a05-48df-c8f2-08d7bfad3c19
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:58:25.6423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsgR53BbDb3Z2O+xmbc2d2vJIUobvrOwF81yRf3uMVOVS3lJg1c/wvgoOCpDuFs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.44
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

Apicid calculation depends on knowing the total number of numa nodes
for EPYC cpu models. Right now, we are calculating the arch_id while
parsing the numa(parse_numa). At this time, it is not known how many
total numa nodes are configured in the system.

Move the arch_id inside x86_cpus_init. At this time smp parameter is already
completed and numa node information is available.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 hw/i386/x86.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d46dd4ad9e..66998b065c 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -121,6 +121,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     MachineState *ms = MACHINE(x86ms);
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
+    /* Initialize apicid handlers first */
+    cpu_x86_init_apicid_fns(ms);
+
     x86_cpu_set_default_version(default_cpu_version);
 
     /*
@@ -134,6 +137,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(x86ms, i);
+    }
+
     for (i = 0; i < ms->smp.cpus; i++) {
         x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
@@ -158,8 +167,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
    init_topo_info(&topo_info, x86ms);
 
    assert(idx < ms->possible_cpus->len);
-   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                               &topo_info, &topo_ids);
+   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
    return topo_ids.pkg_id % ms->numa_state->num_nodes;
 }
 
@@ -193,10 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(x86ms, i);
-        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 &topo_info, &topo_ids);
+        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
         ms->possible_cpus->cpus[i].props.has_socket_id = true;
         ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
         if (x86ms->smp_dies > 1) {


