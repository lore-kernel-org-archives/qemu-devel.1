Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DB82073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 02:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZeSG0g14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DB82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icJzH-0005qi-TS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 21:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1icIuK-0005Y1-NG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1icIfc-0001T8-QE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:34 -0500
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75]:50853 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1icIfc-0001Nw-Iq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 19:37:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK8pUszzXqqW99uyGYpQHjWdmFt4s0wwrqmj3XOYKY5+1O33DcveMSPIPNyC4ZGO/Px8LdIlplwcVR/ocEJW+1n31n8U1j81zz6DJKtNegulPwdnY8NO9+9RPdabffeokhkemSNaPr9QWUVNq0KtKCjrX0IvChtAgm0A83cijd6/fZmxfytdQrGNRKTgP+mf8YGiBjoDYJ/lJ5yLWdsGlHXrPo7HnsdevmBj1reHpI3/h9vvGpdY5vmdsdm0Bg+FMmy+ji9NhFvqDVsAOySy0Jb/bmweHruhKDv0yKFWwgYk57fkaD3hZUGR3MRpDemDdFaMrU1riHrM7mcFAM4pHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9KwkYXBhn9P11MzKRcQct5TvpoANTDz8Vwaw+0ORI4=;
 b=HRNiJo/zhRF1IiVmFT1jTdUXK++yRSYYZ4zA6dBl1C273AYNNyTDSxjyWoNiLGIOPQWJtMTvQOaVnJS95JhbxLcotZ1s/caaDzSnZ+D5P+tJ3jagOa0JT/kWIkvX/HS+ObaS19Zy44IbqS4aFg+DVHXpftlhv9/mg46v4evYY0D4I5XDEvBvkSvHBD5Gbk5IAhnMI2Mb7A85tVHWAX5eqcFMCatNW86IzbhjkkI01oZ8QsJU8/DlnwZRyAX3mdUc+5cv+x6kuapJ00k9HDEmUKvUkrpX/SSLdjb0qCQzx1+GyGOPIOf22Frjx6sk1phyhXiysXu86wn84Rf6l+NMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9KwkYXBhn9P11MzKRcQct5TvpoANTDz8Vwaw+0ORI4=;
 b=ZeSG0g149U0PxQDH/s7XVDlTkWUG734Jlf/9xrINzBDFm4hejUytPAkpCi0iVJHC6JojY2b4PgIsa3s9YD5PzUGJ95PxLr7WzFV8nlVafOw3KGXpVdReGxnMRH+geq2YDXLcKcRy6VOFcZcMyUwh6ta8vPLklidYM/vfI1ALoXs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1369.namprd12.prod.outlook.com (10.168.234.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Wed, 4 Dec 2019 00:37:30 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 00:37:30 +0000
Subject: [PATCH v3 05/18] machine: Add SMP Sockets in CpuTopology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com,
 imammedo@redhat.com
Date: Tue, 03 Dec 2019 18:37:28 -0600
Message-ID: <157541984859.46157.16271709119317180051.stgit@naples-babu.amd.com>
In-Reply-To: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0145.namprd05.prod.outlook.com
 (2603:10b6:803:2c::23) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
MIME-Version: 1.0
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 440e3702-d3ac-488b-73ed-08d7785224f1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:|DM5PR12MB1369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13693479774D800A44DDBAFD955D0@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(2906002)(25786009)(103116003)(50466002)(6116002)(5660300002)(478600001)(7736002)(3846002)(66476007)(230700001)(66556008)(44832011)(4326008)(11346002)(99286004)(14454004)(446003)(6512007)(23676004)(316002)(58126008)(81166006)(76176011)(66946007)(386003)(6506007)(305945005)(6436002)(6486002)(81156014)(2486003)(86362001)(8936002)(52116002)(8676002)(26005)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1369;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1KOEs22YJSkTzbi7DnZnv8AsNAAeoXpVWZe/1On9b7cxCReOvNDxVtdzXf4Jzdem1pB0jxINh9VUTllAxXr5BPbCH/4nIyjMELLlfG+kXQAT4peLAFlyFkwrkS0wHOF3ndJNNahfjwAvtYZaHYUhUe0+gC7ExCdWQrgdH1zlsova+I9vQHRMjBH7BMR9etldYyARZ0KPZsX2ErdW+60JUUOgHWGz2NCOQC4N6oaasRmBZRCRNUErzcH3AN3qbQubABBLDy4g5LUe9iTf7jPWZJKvFpwNmcIGGN+l60EycrbAVFOZ74KvJN75bKt9U447C2A+YwR3Gcxy/e2YD0/c1BHxPUyMOCdsjfYAqHtmqao+BoWfkAYiBwFiqGVbh3mAQ9D7PfDFb+Kooxq4xA/ymcbqNkle0cKTmOqDibeN8I+mR/kDAYdZVok29queD1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440e3702-d3ac-488b-73ed-08d7785224f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 00:37:30.0458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naH73cGkc6ar9BnZ5IJKt2u587qyQu5R+HaShC089RSSiWMjt+iNXIqHINmxfLJl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.223.75
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

Store the  smp sockets in CpuTopology. The socket information required to
build the apic id in EPYC mode. Right now socket information is not passed
to down when decoding the apic id. Add the socket information here.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c   |    1 +
 hw/i386/pc.c        |    1 +
 include/hw/boards.h |    2 ++
 vl.c                |    1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8..e59b181ead 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -784,6 +784,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
     }
 
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cafbdafa76..17de152a77 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1473,6 +1473,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
         pcms->smp_dies = dies;
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087f34..d4fab218e6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -256,12 +256,14 @@ typedef struct DeviceMemoryState {
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
index 4489cfb2bb..a42c24a77f 100644
--- a/vl.c
+++ b/vl.c
@@ -3962,6 +3962,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus = machine_class->default_cpus;
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
+    current_machine->smp.sockets = 1;
 
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));


