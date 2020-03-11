Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B40C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC27420637
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 02:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rPXKvIrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC27420637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBrEf-0004Uf-SO
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 22:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBm-00088f-PH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1jBrBl-0006Z3-Jk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:42 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com
 ([40.107.93.61]:24451 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1jBrBl-0006We-Dd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 22:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyDjX/3YmqKiUPbAxIEL5j9kCWyBGmIPLeGuIopFIaWzpma/9MkhICT9boEW3LamIaBTTtNmKaNXfUrbezNSZx9XZ6N3gsW3gZSmgshCpbr2I2PfmfSHcrbFpu0W/h7zQOnjK2w5gjnUvAmyvB7zFizeLXuGSvc/19pKNEYdQepnDxpKUdqt6QbDWjIsJ5xSv9NyBYy9TQfi5X41sTwh22GWAhEmUPjbn+q9PFLYUIGTK+otQCRAt+OzgJR+8/Unyj2NPshESxA79UiCeCISx79dJee2UznvmnED3mqY4e3Idiwg8wyEBEy4Fh2jbx+XAREPmb7vzW2hvBWVTTwtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/CNt1p8YBYKlVd8s/6CN1lFk5MvgDBs7vZdCxCOBWE=;
 b=Jful+5dVnju/Kj5OU1Go/lxDM+Fz6CbOeB6+CnrX/1Yr+CjgedXvdFnFqIZ3z00+ke8D89RbDqtErwnPhWrye9pW7GI2K24cPKXkvklwx0qZV9mn8XhzgD0qnjH59vKEotnZE6BSXOx5hvJq+pzMEkSufhLuZAWSCisy1Cal6ONVwrJ6lv0y5l45r1FZGR0ZuI02LG4x9O6OED273YuB3yB/HeXf/Bl1juK8nfX1NeANb+blTG8JTEE4zhVAOgxa376tK/BvqQnXPAkWs+8XoslPm/lIuZhQK9gImrIvJmdpW6L03LIjzQGPPjtSO9zwacSRX9f1BW0YzRBMmgxijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/CNt1p8YBYKlVd8s/6CN1lFk5MvgDBs7vZdCxCOBWE=;
 b=rPXKvIrGfRM+0eaaiRXuBnqSIrjMny1ngTfo1HsAzjosLWezpH3cAAYynT0ow8JZHkKhB0ku8dpnvenXFuj3i5l17O+hNINfVolRZjhl3m+Nm5h+UtcFKWIw760gw1Qztuin3wAUyTUnWnafbN6vVNXR8aDPAzM9xQ1/JpPmuas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 02:33:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::382f:640c:215f:be93%5]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 02:33:39 +0000
Subject: [PATCH v6 03/13] machine: Add SMP Sockets in CpuTopology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Tue, 10 Mar 2020 21:33:38 -0500
Message-ID: <158389401871.22020.15275663805151094425.stgit@naples-babu.amd.com>
In-Reply-To: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0044.namprd12.prod.outlook.com
 (2603:10b6:802:20::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 02:33:39 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bbd869b3-e4b0-4114-e88d-08d7c5649bab
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB24934A6637C7D30B39860E3C95FC0@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(199004)(86362001)(44832011)(55016002)(66946007)(956004)(8936002)(316002)(8676002)(5660300002)(66476007)(52116002)(7696005)(103116003)(66556008)(81166006)(4326008)(478600001)(16526019)(2906002)(186003)(81156014)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2493;
 H:SN1PR12MB2560.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riF2bWqFboW/CJZ9aD+I7GWG8et87o6AHXAv5wXVYgJHgH7HCDR/PLSIJnT9UPgX/ozO6YvJkmbcSTJmrWX7cHr+qjR8/qMPZkjkc2WlFHAcAx6k/1/s3cuAMozJ7LRu9HpKOc389TUuOlwoDhr0uS69r+MVPaTD4EGX5saK84DtHFSi2dT9iOsDBgltlpot/V6Pk6r+Sv8M+MJgSL1SNFC3Otxu+QHjqgjfuCYBMVMPPcfiMbMZKclg6Rbx9ZBB4Gz2JcRukl+4R+FJcQnhlaJdgEClxXKChY0+qoj+fwl1TuiNDBPpgHYv6o991Yn0H1wKd2SIf3gF2/SFByJ1AW/iYVSt3To/U2f4XV0RYB/4UEP4u1FiVZoRffUUm6kE1SzEvlk7DJXL0klRUUvPOMG9t3o8+RyTM3WXkh5/hECHplIsBI2qj67N4PmM5d17
X-MS-Exchange-AntiSpam-MessageData: 9+4ufrZSFZ3ZOZ/Fzi59t6LJDMrtpMt+MlBHx7Nd53TGZi9hmO1ob1ZJlXb4fF5rI+pP3H6YvMNbjmS7wGtxL91rY307Mw7qBI/Umsimy09j8EW9hASzeg7b3grEvPAW/5MiiF7xOifdnTTMIDXsRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd869b3-e4b0-4114-e88d-08d7c5649bab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 02:33:39.6749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7vwMaP85INcXVHKb1o5OcnSLuaEHSciy2IQm/tIAi2MEfB4y2abbAvlcaFcqmz0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.61
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


