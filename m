Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B6C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB22074E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 22:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kqs69k7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB22074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCAI5-0006mm-QJ
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 18:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jCADu-0006ux-Qj
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jCADt-0004dP-LE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:10 -0400
Received: from mail-eopbgr750079.outbound.protection.outlook.com
 ([40.107.75.79]:52550 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jCADt-0004cZ-FM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 18:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjJFfU2mQLs5F2mWwa9EC0VHuEY8dUTASt30VYnu/QANRf1qmOYy9jKTMrkj3fj4dtLpdyzqyIjC1Uj5lRQythDMTzlLQTuQ8SkzedvqyciuqGfNzIxArMJOZzuS1ZE6vJCbMnJbpBpZ86PDd0rkDxIsWSuJ2sL0k2FpbdlYqU2Ox6DckMRHmqs6uoKr4SmOTRPKJTZVWaLyLzn6ahkxJcFfmwSn11FuvcUAo45JrNViPK4sKzIWlN2/kaLlQelBCNSg/mVb12nfVhNrgFkAyGUZ4fYFpfug8ATEOW4RExGbu8t54VlSS9H5xUmsglptLTO4D8+R93mbpNZDj99Eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/CNt1p8YBYKlVd8s/6CN1lFk5MvgDBs7vZdCxCOBWE=;
 b=dBaOYyk+V5k4P+CF9B+sQ4b38kRcMx6pSBSuXeYt8JWis1sOEbYY7EWLCQgAUuxLMc1ZTdQbz0u9pqEeUrPzkRro6DE0utax/349aqPC4GCyXJ+1xuExbhAYujNHECpDIxU83Lf4N9cTAvuYoFH0yv9tnSoA9S2sFzv47VYjXPgbDpvfyKyCeC3yLNb110Lkk1Rjoc+iqMWQihYxzoZeV96FTCTLv9K+pAWNuahhGg33CGcnddhvXr0AdsW9CaTGZLiOQN0HX4YZZi7641EE6qUYWy+Mkox0U6WpytJo4kBKEx592BEB4abveQoJxtooGPQ/9MvNVrlT4GkhJgkUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/CNt1p8YBYKlVd8s/6CN1lFk5MvgDBs7vZdCxCOBWE=;
 b=kqs69k7GXVX0Eqwhp5Sp+3IAvPs7pRrIHm+n2nC0/Ji578rVuL7YLa54RnnfQoOh7sKngTvu1SDse0TIekFHo+sefrTcUvhVn09didC2kQkj4rC3nZtyKTedmH3yeLJEX0vLmPvXPWQDBnLbpYJWGQQWK7lfwL9aTyQRz9JYdpg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 22:53:08 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 22:53:08 +0000
Subject: [PATCH v7 03/13] machine: Add SMP Sockets in CpuTopology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Wed, 11 Mar 2020 17:53:06 -0500
Message-ID: <158396718647.58170.2278448323151215741.stgit@naples-babu.amd.com>
In-Reply-To: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:5:120::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 DM6PR06CA0017.namprd06.prod.outlook.com (2603:10b6:5:120::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 22:53:07 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93db425f-ac4f-4cdb-8e7b-08d7c60ef776
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:|SN1PR12MB2349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23491F7B8BB9B663B6DC603695FC0@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(199004)(44832011)(478600001)(55016002)(5660300002)(956004)(81166006)(8676002)(7696005)(81156014)(86362001)(103116003)(4326008)(52116002)(16526019)(186003)(66556008)(66946007)(316002)(8936002)(2906002)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2349;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmjeqG42gOhbkLk4S5dE+pNMWsImmOXDJomQjokUcb+oJsni67DXsx9Mmih5UvCVFBCpfMFRzdPTJxicpkif6EjOCJPRuk4KdZ8EzkL2ClO9TTcxoXo5QAMUYNHOXLdqrcHIDnNjCUZ/yTjUiCBGMxE1YI3OQD2qrd9h5xgaBdjy91A0FCCdYQOIRndMzMNllRtNa98aBqNFg1/HbWcnxum5OaHgmYYN7ovmLWeInpx+a9uKK/zkGzgS/0zLslUiCOSeX8KwPcLR07ZriMpUc8ru6+iHU2PcMf4UiMuEAgwNDore5ViUBALEDAiKycyubb1MjYz3H3MCEcUGAyHXd0PT0Lj+iBd1G7U3cmahEUhHmJovnFisfn45bPBs0tt94JAFiJFYmMfYxYAC4xCENP/xk80YdFWNMEMA0QLR0g4uZDruPAMRU4uGFc0YvcRg
X-MS-Exchange-AntiSpam-MessageData: 2QW2YdQO4hxryBW7pm8SfYSAM7b9ARlKzGY2wqr4Pqg1gRqHWRyO7tr3f32IfvoGLt5LKu75rIJwPsKztPLHnjHSfKDRnMaWKAHd3oLxtEyEBDjKEhTfCIxZwRQbdJBEHoHPkjUp5D0MYPtM7ne1EA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db425f-ac4f-4cdb-8e7b-08d7c60ef776
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:53:08.1267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NXLoSWKYY4oG25/8Wyo0x9JvmE2yNPz9tWS+Dow8olM/yP3F0MtsMgnESZVbYQ3A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.79
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
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/core/machine.c   |    1 +
 hw/i386/pc.c        |    1 +
 include/hw/boards.h |    2 ++
 softmmu/vl.c        |    1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4778bc6b08..b958cd1b99 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -757,6 +757,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
     }
 
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 662abb549d..05e7f1090f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -781,6 +781,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
         x86ms->smp_dies = dies;
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9bc42dfb22..d01056286a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -236,12 +236,14 @@ typedef struct DeviceMemoryState {
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
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index ff2685dff8..dadb798ac7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3935,6 +3935,7 @@ void qemu_init(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus = machine_class->default_cpus;
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
+    current_machine->smp.sockets = 1;
 
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));


