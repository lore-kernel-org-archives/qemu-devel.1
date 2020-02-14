Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16505C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27CD2187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EF4Xc90o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27CD2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2awR-0003w4-4Q
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j2auF-0000lu-JN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j2auE-00051S-Hj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:19 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com
 ([40.107.92.45]:39704 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j2auE-0004ye-Cw; Fri, 14 Feb 2020 08:21:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM+K7rtIJbMx2UBL0HAVnPCX3U7vkh+WUrZCMKNDJj5e8UBv6pGTayTT5pyL6mAOPNyrqzg49ksSs2U5D7Re0i/hOn979EhGG5jSXvZIz6ec+BAJ5MZ2rxpiIp362eGDdEbb2unUnMu7+GmMYmJcaoFZEzMYOOzAShZSTHDOklxTIeu3eNzvq+9EQEb2wKlOg1/fSjXQguGW1e5rTltyuPPFUhOPEaHTB/HOW4rGZsw6wCW1b1x6gQW1zuELHPMtieIQT189lQPIvW8Q1/kH6HtNbTawUqPYIC75QUjqOthJOoObprmfGJRvoY9usHKlk0pgQZtQX10CL/7omkgWbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcGr1Qr5JydrV5ET6Vr1InXd3Uv3Lp6a6CD9kG5YAEI=;
 b=cJ9JzR88fLRdn90iIiXhAtDAwEGJjdtPQxSJ0uthYFOdjX7Nq/nJ4vO5DKmRjpQfOkHxk6c2RSsf0htLWQQu0ADFJRLs90VBHKC5J66F0oQSzjWInfpGirlEnnFxERRdKXvqJpYuk2W1wo0q4nlvtjQcSNJRmTGXoccV5TLuAm8NoTX/gy4PvyJEPg19TSixkmXpqLC1xY0nKx334qrJaBoouDxWQ1lYfZ8mwUR7mRkXxd8eWv/nsDKtwviODLZsc/+TKRui6PkBTPUG1ZVUbqH09q3enMEIgbaSz/fcba0Vsm9t31+AJi10iXZO3Yk8JPmAAdPqzNbmudVb+CeOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcGr1Qr5JydrV5ET6Vr1InXd3Uv3Lp6a6CD9kG5YAEI=;
 b=EF4Xc90ozDc/kmkQi44rYmwnoG/8d4XfNudYYV7gE6xJUEGKN+2fe/1a3oGq1PKZxIAIpPtuLOkCsr5X/Traw9OFhhazuO1vP0vDquy2hp5KBcQ/iMpuU4nl7Bep/X4qpJ1+6q605SY2PkdAHwB/zW0nsvsqep6UpmMMFCFWmZ4=
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by SN6PR02MB5549.namprd02.prod.outlook.com (2603:10b6:805:e4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Fri, 14 Feb
 2020 13:21:16 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Fri, 14 Feb 2020 13:21:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Fri, 14 Feb 2020 13:21:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2auB-0001WR-GC; Fri, 14 Feb 2020 05:21:15 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2au6-0006g6-Cc; Fri, 14 Feb 2020 05:21:10 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01EDL97s013816; 
 Fri, 14 Feb 2020 05:21:09 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j2au5-0006fq-DM; Fri, 14 Feb 2020 05:21:09 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id EB4CB13C0374; Fri, 14 Feb 2020 18:47:02 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH 2/3] cpu/a9mpcore: Add num priority bits property
Date: Fri, 14 Feb 2020 18:46:51 +0530
Message-Id: <1581686212-9625-3-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39850400004)(189003)(199004)(478600001)(110136005)(2616005)(26005)(6266002)(186003)(4326008)(336012)(316002)(70206006)(70586007)(81166006)(81156014)(8676002)(42186006)(8936002)(36756003)(356004)(6666004)(5660300002)(2906002)(426003)(42866002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR02MB5549; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22ea4f00-23ac-4881-a674-08d7b150c558
X-MS-TrafficTypeDiagnostic: SN6PR02MB5549:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5549E479CEDB0383CA4F381FCA150@SN6PR02MB5549.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHPJDShSk0EN6pRR0KRrRp/l6pi1KEugsTvhsRSL9wsDmvL2KyAzLQ2o13RKpTB1iFIsPehx0mnVMgm/9/TFUs4ATgiLD/7X7Fro/pMCAfivNIXfSEhIgFTu+D/topFqnoQLkHupTbFcDGDvhZNO5jhgRjUt2D6m8abVWa20m7qRZis8mO6KC7UfDAoCSksGV78VGKnygQmNjUi6vg9ci3MF1KczBr3/E39h2oh0ZfsWHPT287UzaBhU9gNnFrH++33Ns9QMcCcKHqw9fIk3q7qxmLmvWhoqizYOzdHXzC5miaSF/OguiplhXOB2/X29toXkDnCQdkiKwVsHKHl40Lb2iBHSTz9wBrpqSEW7mnDBIwp/gLLwXI6kMbk4a1hCiHo94jUwjCvP1g/eOPsbXtjtHhd+CM8vQufPtMX4kZNZBNzB9p+72Vj7wgycuZ4Ti8yjnnh+rGrT8MTnLOa+YcCli/3Ps95qsUnSTsXvS9M=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 13:21:16.0894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea4f00-23ac-4881-a674-08d7b150c558
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5549
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.92.45
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set number of priority bits property of gic as guided by machine
configuration.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/cpu/a9mpcore.c         | 2 ++
 include/hw/cpu/a9mpcore.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 1f8bc8a..eb1e752 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -68,6 +68,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-prio-bits", s->n_prio_bits);
 
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
@@ -167,6 +168,7 @@ static Property a9mp_priv_properties[] = {
      * Other boards may differ and should set this property appropriately.
      */
     DEFINE_PROP_UINT32("num-irq", A9MPPrivState, num_irq, 96),
+    DEFINE_PROP_UINT32("num-priority-bits", A9MPPrivState, n_prio_bits, 8),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/a9mpcore.h
index 5d67ca2..4f146bd 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/a9mpcore.h
@@ -28,6 +28,7 @@ typedef struct A9MPPrivState {
     uint32_t num_cpu;
     MemoryRegion container;
     uint32_t num_irq;
+    uint32_t n_prio_bits;
 
     A9SCUState scu;
     GICState gic;
-- 
2.7.4


