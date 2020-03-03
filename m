Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3979EC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023052073B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 20:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QKFL4JbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023052073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Di3-00050e-JP
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 15:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfQ-0008VV-1w
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j9DfO-0002yq-NN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:23 -0500
Received: from mail-eopbgr680062.outbound.protection.outlook.com
 ([40.107.68.62]:33922 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j9DfO-0002xw-HW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 14:57:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdhp/6ian/Zbmf2jzLLP47wiSxPeLfv0GWZGLcCfLeSnqbzs8dnFCb3QEe2+vR+KX3tTWTPQ1bBxQ+Uupw1sdwKLvkAtm/uMtgTnXhcvqVOF+pgGnIThVaLRsUVG/euT6vyQZKb+9Q5iFaXp7F157ed48s0nbcmFAhKyaoWYIx7pjgzaysOdbOWlqCKOmINTQykwS+Guufz/09ZssbZCfyElkHsYfAhCfWq846mDhzoqHb5X8xobGe8kwWO3bCZ7Nu2fqD00SzM3Hl47SFK5b4HMawCV4iQwRtkxj6J7HbSPH+QFmq4hifuErb9bd3//mQm2WNG6SFy7gqIhogvQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rad23UMfdNy9LIHmhE+UOd2++OzXyNFDWNC91oWlLPU=;
 b=DdsAj7rcuvNUVTc7ipCCdl5Lf20MZ0VSqpjeW5cyOQOY21uQmLMgkdg+83Kc0DUJdE+UiGA4LIR5TjD3/Cv8EBNSCAOUoLrPFTECjnPdgQN6Yvyc2TNX2Y/7QfpenTBXV2tdXzxbLRNEiCeq021d0oNlEMpkXhCV+R6c+lY+oqksrJPoCL+Q1D2NXinmVo/4U8p838Smc4G3ddsJuOexE8YQx/VZZ3zq0wPRMQ6tFarM9LqBeI2XmoEhZIeT2aCk61TJWSViDOpKMH2ABcSzQ5syPYI2VWRKD8kHu+G1v3d0/ug2sXFk0AQAfylgZtHVns1XFRCxGbHj1Pe+kpntPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rad23UMfdNy9LIHmhE+UOd2++OzXyNFDWNC91oWlLPU=;
 b=QKFL4JbIhbIGMwy9MTYtoPkNVOncjPwZnrGKB2EChAQ1kFdfIFy0j2Y1wj6pOeW4H6n6KPkPQlkzf6xN2VgtPIFGL1w7GlbLqlWKMuAtL8Nl9O0t2gP2zuQiT5FPGIVqy+RNoA/AVSzCOTnJsQKpNpayjH4gCtc+ttKtLgVca5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 19:57:19 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:57:19 +0000
Subject: [PATCH v5 04/16] machine: Add SMP Sockets in CpuTopology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 03 Mar 2020 13:57:18 -0600
Message-ID: <158326543822.40452.17598145031344735065.stgit@naples-babu.amd.com>
In-Reply-To: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0043.namprd05.prod.outlook.com
 (2603:10b6:803:41::20) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN4PR0501CA0043.namprd05.prod.outlook.com (2603:10b6:803:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Tue, 3 Mar 2020 19:57:18 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7108ebc-9b9c-4aa2-6e77-08d7bfad1484
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:|SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573E5B323105C5CC68A554895E40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
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
X-Microsoft-Antispam-Message-Info: lKqol37nBUYP1lLkWDg8hMQlyQ8/KiPQe6mjNs5Aue9gQk76gVgyPvc8/Xm2zy5UGCwrvNfdcLYKnlM03sf61tUz7E+yBCtU2Jv+y4ur3zg1fj9pqjCepIeSixBpefpS76sbiDAcVULF7w3CoSxfbIP7NPekyG79AduFA2kzhjKSW7SWwN9Ix3UXclsAq30B09d0Kg4F8dy54ZCI52GqgAi/Wu1qotJK58iIEJRII/LC1LKlYVhHVdE8bsnU+T5bb8DrOXL+6NWJFWRRzQcqFp/IZBS5zlZTCpka+mR0wsxR59uu1gepj6ub23yS13rG8SaDsIDf+3ay1HmucRA0iUKwpYSSrgyN3kSgrrqIJ5AXnvl7ojZLZRC9JY2qiFLV4Oy8oTUO2YOL+1YNsqwCu27fTk26ewEfHXCpl0jOlGCco+IG74a05oHmU2CNF6mI
X-MS-Exchange-AntiSpam-MessageData: B1WfdS0VTPVDn6n23S/OqdA+FLXuONqBywRggz8dOfGM/A54dKqBYYc6Ud7m5FVY8RCN0uuYviJ+dCsC+VeMU6F3Ox95BKyjSbGwUFG4gQwLizEeW4ZsBPM98y2wqyfrc2WSYRZ92b8xuchym/a0NA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7108ebc-9b9c-4aa2-6e77-08d7bfad1484
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:57:19.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CkdLHuuT9qw+o+/Xs0FVxRJMTTlkn69ku58WfD8zYph69DtLyvZEXnRrd+vEvUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.68.62
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

Store the  smp sockets in CpuTopology. The socket information required to
build the apic id in EPYC mode. Right now socket information is not passed
to down when decoding the apic id. Add the socket information here.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/machine.c   |    1 +
 hw/i386/pc.c        |    1 +
 include/hw/boards.h |    2 ++
 vl.c                |    1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index d8e30e4895..2582ce94f6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -728,6 +728,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
     }
 
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ef23ae2af5..68bf08f285 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -780,6 +780,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
         x86ms->smp_dies = dies;
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fb1b43d5b9..320dd14e02 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -252,12 +252,14 @@ typedef struct DeviceMemoryState {
  * @cpus: the number of present logical processors on the machine
  * @cores: the number of cores in one package
  * @threads: the number of threads in one core
+ * @sockets: the number of sockets on the machine
  * @max_cpus: the maximum number of logical processors on the machine
  */
 typedef struct CpuTopology {
     unsigned int cpus;
     unsigned int cores;
     unsigned int threads;
+    unsigned int sockets;
     unsigned int max_cpus;
 } CpuTopology;
 
diff --git a/vl.c b/vl.c
index 7dcb0879c4..f77b1285c6 100644
--- a/vl.c
+++ b/vl.c
@@ -3949,6 +3949,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus = machine_class->default_cpus;
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
+    current_machine->smp.sockets = 1;
 
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));


