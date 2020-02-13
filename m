Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47267C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183EB21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GxvMmZ0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183EB21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J9V-0001Wq-93
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2w-0001nf-DR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1j2J2u-0007Fz-C4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:05 -0500
Received: from mail-bn7nam10on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60b]:6189
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1j2J2u-0007B7-42
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:17:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsOrrJ9Xs+d6Be3M6thdrECin+9KtmqJNDdpuLgVPPcC4K/wcqzDMgqeN8hTsvfZTfqa7J3X62UCAUorG8CM03WOSCMZPSL/DH06ogq3EUsfGIkKSAb1hDkUGYm6IxP7BtKy+Au+3xufaLxz6vLJuoLamQXKLZZV5438ACDkmC02MI54CQawSd88jFSpw5hnazM7eh78l+VTUZeBU4k6O+U/xkh4lorhIa7JCixVCJ30PvxnNzDv++Xy95R9F7mBRqpN3cdghb8q8yW06u/SB3vhwoOOZUgCjKCl80u2CwSd5lmN5PtYest/cmffmzDzdY2OmWkDHDuTn4x/y8Ls2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY5EblooCvrRGolnk6yNopmDzImb23dQ0t5sMPQDJgE=;
 b=jvt3fYfHxRgshLxHJJ/YP34J+mV1j3mKr3GMxR9wSkk1ViFGEj5TwKuCVbKYv5e5RX/MnStj27gqVdV2LwSq4vclMarXZG/+rLenUW+QX7mMGEcUqyBNkJuGNDomRLDuVljZ2rWUubhSBRg/8ujSv9mD74SyG/w5fPfRsuLmA/ppHoOU6C59Wua0XjjjL3cv530jH+eGkO97bJhnLy3h4VIcR0frow+5MFl+eppblvMnkayyBzouoOGOEWIEmzlKROs5uyHsiZQFEg9uaRMK90NSdaJPEIIBUUgNzF7zKQ1LFk+LISTfssq4q8cgxVEDkLwXG776KFx5omIQbSeyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY5EblooCvrRGolnk6yNopmDzImb23dQ0t5sMPQDJgE=;
 b=GxvMmZ0COYVXajau2YkVuS4XLkLy2E+/bq9CW8kSeWES16TBik4c+xDuFNNqu/ca/4ZvKnW88KD7brIHTVkFO6Rd+QDVW4Q8On+F+3N3TVIvPBqVwIjAvcq87jFlh08c5Ybfa2UHHLyPKFIw29HKPcp4m6QdZwUvJHrFaQP2CXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1318.namprd12.prod.outlook.com (10.168.164.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Thu, 13 Feb 2020 18:16:59 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::e0cc:653a:e9bc:aa8e%2]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 18:16:59 +0000
Subject: [PATCH v4 05/16] machine: Add SMP Sockets in CpuTopology
From: Babu Moger <babu.moger@amd.com>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net, mst@redhat.com, imammedo@redhat.com
Date: Thu, 13 Feb 2020 12:16:58 -0600
Message-ID: <158161781807.48948.6804322747644119810.stgit@naples-babu.amd.com>
In-Reply-To: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0086.namprd12.prod.outlook.com
 (2603:10b6:802:21::21) To CY4PR12MB1574.namprd12.prod.outlook.com
 (2603:10b6:910:e::23)
MIME-Version: 1.0
Received: from naples-babu.amd.com (165.204.78.2) by
 SN1PR12CA0086.namprd12.prod.outlook.com (2603:10b6:802:21::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 18:16:58 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 224af5bf-d630-4073-8591-08d7b0b0eabb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1318:|CY4PR12MB1318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1318131AD6A67E37E65A2C2B951A0@CY4PR12MB1318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(66476007)(66556008)(66946007)(81166006)(26005)(186003)(316002)(2906002)(52116002)(8936002)(8676002)(478600001)(103116003)(86362001)(7696005)(5660300002)(81156014)(4326008)(956004)(16526019)(44832011)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1318;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjVUQfmaXBadT/OsaOcMqQWoA7eV39V6U9laXI+8l7y14xIiofxxS3DGPTyiEvcoB7vBfKPwK9dqDl9bL0cia1F1Rn8jrjsmBTw+OBWCwdEHqtUwvJzUVxBkyg8iNud0vzEaCW3vV9X9BvCL7HwZzU6CT4uBulO9CMA029IO7a15FXOBwcFVIQ9ifOM1NShapGvahUGv1r41xrZ7ieJ2dgzP+TXBmzuQ1sNwjTFBPYYDuLFoQ+4mKgtnzoHxc/CMyCFQb3Zc3rf2dfORgupuIwDoXhfc9YmS23U4nJg/zDMJ7KOiqwaYzGmfetyo5HEClH3MTPcjCpTQqyMTuc3EAxxakf0b4t2Tw+l1TSpfSpPsBij2PCVMiM38KQgb3MsQUiDvzlzVd39MvEwLk8n2V8fDeJFsI/Yea4OJCvmNj16rCT5p5nhSpodMtD8fm42x
X-MS-Exchange-AntiSpam-MessageData: nk7sN+v6xbn1NyPfMncSHcrelD8m/l+9Ehvv4wgdTaUlFSOSbnSufWfTl/PaazMMZ2F/E7m1TezAPw0LFjo9y4xB4BhvT6o7RAHOkA3Yq6sVGMf5V0DXWMhjgwnTP1Ey5XcIBUVOyHw+L86dXGwU9Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224af5bf-d630-4073-8591-08d7b0b0eabb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 18:16:59.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpnLZ9a06uw4OixLToqlNZyVLnglgY0zWnv/6XgiLXHBy1QWne+agDbztpP9EPFq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1318
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e8a::60b
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
---
 hw/core/machine.c   |    1 +
 hw/i386/pc.c        |    1 +
 include/hw/boards.h |    2 ++
 vl.c                |    1 +
 4 files changed, 5 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 023548b4f3..ea03c25565 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -789,6 +789,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
     }
 
     if (ms->smp.cpus > 1) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9803413dd9..f13721ac43 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -978,6 +978,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         ms->smp.cpus = cpus;
         ms->smp.cores = cores;
         ms->smp.threads = threads;
+        ms->smp.sockets = sockets;
         x86ms->smp_dies = dies;
     }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 24cbeecbae..a50a2d779e 100644
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
index 94508300c3..3f6d396a95 100644
--- a/vl.c
+++ b/vl.c
@@ -3819,6 +3819,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.max_cpus = machine_class->default_cpus;
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
+    current_machine->smp.sockets = 1;
 
     machine_class->smp_parse(current_machine,
         qemu_opts_find(qemu_find_opts("smp-opts"), NULL));


