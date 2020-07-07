Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38095C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002DD206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jaHO6/lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002DD206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr7k-0001Fy-8L
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jsr6v-0000FS-0m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:10:25 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com
 ([40.107.93.43]:33504 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jsr6s-0001De-Fz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:10:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWizipbjOWt0pvME1gLKeKSxBsjnu2BcVbJOIX7nar2czCxwOI2gmVAOw9bC8CO/s/gGrMAJ8lELjG+V6WYZhCB9AUY4WAhMEqruftLS8pkG5lsjOzv4oMg5sh/mTYJ8tO98RzplUi8gxJYK02rGqvTqUolfx8ioLXpDORCmK6FnN13E0FN804l8GQVswveZJ5TBniJ37/LVpACuiSMvB3d1e/9iN3kC3AGLqAnmq1xOidBOD0RkgC96cWcXy66oEXgGgsiHzcbxXAhkmmUTR9xrnI81iclXdsBmHDD1be9tV4jAX0vMUQKXlfQoJLHo0qU6An/sN9HueLwx8/F92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX/bUnB+XnGNu34X0yKw677MYikDRL80QdROiA38+yk=;
 b=lcIrn/5b4Yx0N0c9i6QthqnE8aW8cnoW01Imi4/yR0IpSOgP2nia76zc+gis5K0At4aD1a9mtxON3Lw+Akd01tQCG327Jg+1XnlFKWaXGI68rUtkFOAequAZS0WAb/uLPoli0rLdbocbZ1atT4nmEDbSaMRsdJBctaGreVYloJp158OkKPnULffa0LADw63HEp6QeYLI5JiZAQTWV4l01OcKPDOq9JRNxcJ3d8IcTTdS3V9l6bRRRovNF3fdiYF/nE+2i/MuXokeZzQ32rJz173r6JjZALEnAA21MhwzmedBdV40BJFT+QZsul4KLp7KkdkQ01L9bCvuTy9VAd4X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX/bUnB+XnGNu34X0yKw677MYikDRL80QdROiA38+yk=;
 b=jaHO6/lmJcim7BKyj/eJnmIy1Ff0IAlICQJFB89jQaY7bWrXT+akRMBAAq3TMHdtrIDcrYRgaWfKdu2WcNbvG9d7c2naSUOaMWUowid5W4A0iAabtZRgW8FAcjfzce6opAyCqPsQ2VXEvyMdKEMt7ynoWFlVhxpdFKGcTC0A8WQ=
Received: from MN2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:208:178::37)
 by BN7PR02MB4979.namprd02.prod.outlook.com (2603:10b6:408:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Tue, 7 Jul
 2020 16:55:18 +0000
Received: from BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::89) by MN2PR19CA0024.outlook.office365.com
 (2603:10b6:208:178::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 7 Jul 2020 16:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT019.mail.protection.outlook.com (10.152.77.166) with Microsoft SMTP
 Server id 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 16:55:18
 +0000
Received: from [149.199.38.66] (port=59888 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jsqqn-0003gn-Lw; Tue, 07 Jul 2020 09:53:45 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jsqsH-0001eU-Kb; Tue, 07 Jul 2020 09:55:17 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 067GtGsQ015019; 
 Tue, 7 Jul 2020 09:55:16 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jsqsG-0001dn-3E; Tue, 07 Jul 2020 09:55:16 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BD84C13C0347; Tue,  7 Jul 2020 22:14:37 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 0/3] Make hcd-xhci independent of pci hooks
Date: Tue,  7 Jul 2020 22:14:28 +0530
Message-Id: <1594140271-16462-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(46966005)(70586007)(6666004)(82310400002)(426003)(47076004)(8676002)(2906002)(4744005)(83380400001)(70206006)(498600001)(81166007)(4326008)(356005)(8936002)(42186006)(2616005)(7416002)(5660300002)(36756003)(107886003)(186003)(26005)(54906003)(6266002)(110136005)(336012);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 09a1d414-9ebf-41f7-730e-08d822968723
X-MS-TrafficTypeDiagnostic: BN7PR02MB4979:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4979BB694EFEF754C95B242CCA660@BN7PR02MB4979.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cKIC0c89X4n4jlwhw3QN386aiCjl5Yfd/vpREzgh4k/Rb9FBjVQ/BYKGVQ5lQSiLCf78dLYvPldltNfEihnfose56/MPVGooiI5sSOrRHndche8gOPlkUD2EekdrsXleIyA937cvMCxKofN6W/u9s3H4o8/DLFd5iefOOK4iv3wZI29boKie2m87MVIj3wSdCZnImLu2e6iFeaRibw4X+3nrk6Pggug2lAsoRE5NbwaYKaE3NdsCrFYF3YWCNPRC37aY5koWhG8IQGDCpIL0Dp1gSRrigJLeYrLucgH2zwp0198YyQONU21RrxUP26/epDyMoaKAiXAFE+YnybhZDJh8juYMbDHDrur0QaekaPG2PHy2I7DUHmES+4/+yHWEn14wlFxcbzDKrSiGE7UKA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 16:55:18.0411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a1d414-9ebf-41f7-730e-08d822968723
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4979
Received-SPF: pass client-ip=40.107.93.43; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 13:10:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) AC_FROM_MANY_DOTS=1, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Vikram Garhwal <fnuv@xilinx.com>, sai.pavan.boddu@xilinx.com,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

This patch series attempts to make 'hcd-xhci' an independent model so
it can be used by both pci and system-bus interface.

Changes for V2:
    Make XHCIState non-qom
    Use container_of functions for retriving pci device instance
    Initialize the AddressSpace pointer in PATCH 1/3 itself
Changes for V3:
    Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciState.


Sai Pavan Boddu (3):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model

 hw/usb/Kconfig        |   6 ++
 hw/usb/Makefile.objs  |   1 +
 hw/usb/hcd-xhci-nec.c |  18 ++--
 hw/usb/hcd-xhci-pci.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-pci.h |  45 +++++++++
 hw/usb/hcd-xhci.c     | 259 ++++++++++----------------------------------------
 hw/usb/hcd-xhci.h     |  20 ++--
 7 files changed, 367 insertions(+), 224 deletions(-)
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h

-- 
2.7.4


