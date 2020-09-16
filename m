Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A49921D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="s2fDi58c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A49921D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVoN-0008Pv-0j
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIVm6-0006Ct-BA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:38:58 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com
 ([40.107.75.85]:27742 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIVm3-0006oi-ML
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFzKYMIzQCgQMxNja+LHlFpzw08+JbhEuv6KTaLc27Fj+9BlIO+CLhtYdxtw2UH90L/mh/WA1oh5tfLmbfI45U29gBeNtVZphmhQAkisePKuNYtZD4mbyBOagnQ9zw1BjwMMGPKQ5XPMBZ988L65G8qor6gV02yr+J/1/8WWgjbqDaWx9LX/gnydV9F7O6n7W0C7FNg/cUML2m9ukO7IDjcj1FQxCRnNMhPGvSbTnP21MmBA1wT8YXsC5RhWWOkwkgd8avpLZmX7QKF1aTPf+jljn9s4/ibaBeNh02/mtgUYURZkObh6GSTh/YVPgfbmZDcnAOtwlk0Tb80m0DIJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUHN59S0HPsYdjWoRfoUmZCr0Uq9/mFoNaO2L3GaLXo=;
 b=fLmaRXcedYt2K4QDbZLpy5fAG5hPxWSJ5lPVSwNOmP8wGN2vukFvMSfR7H2o1yj6SUcaMR4obginjbF1o9P1s1skimxA4TjWLQKLgVj7dXtuvZ3P56+QE6SoG3e6TNSopK54aOLkcoqyE3vfjcYfhx3IcPuR6qvi82b2ABnpJS65/6+qCNu1hljll6bAmBGumQjx0nrvcwlQdZBKRqnFdHHpb82UREBEejar1MCfu9fphpBUWuUPxLLtFghopnCwB4FKPnC5jBK7P92BaPtz9MFj+mv0kp8IX9ZHYG/Nli1ffZitN4kC8V1akqJcyH0cFBATgaze2AIJEOmrdhd9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUHN59S0HPsYdjWoRfoUmZCr0Uq9/mFoNaO2L3GaLXo=;
 b=s2fDi58cfabKW6/V3ixu/u3sSYwOiuwjAeuGq5hZuTkD0epFAfD9972zyKzVPAN/yqTR6pt/0HD/4A13IFa0VnnUQWyrt6rCYTqOG1c7wetuMCMH1sInmJUpRQuDqdCRIb7GSiHj2YHgD8cITzbUeoDHo4KuspdvWNeIHYegVFU=
Received: from DM5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:3:13d::12)
 by DM5PR02MB3210.namprd02.prod.outlook.com (2603:10b6:4:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 11:38:53 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::b1) by DM5PR20CA0026.outlook.office365.com
 (2603:10b6:3:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 11:38:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 11:38:53
 +0000
Received: from [149.199.38.66] (port=45525 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIVlu-0001bT-7W; Wed, 16 Sep 2020 04:38:46 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIVm0-0007MI-OB; Wed, 16 Sep 2020 04:38:52 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GBcp6w002809; 
 Wed, 16 Sep 2020 04:38:51 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIVlz-0007MF-7j; Wed, 16 Sep 2020 04:38:51 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id B2ACA13C0235; Wed, 16 Sep 2020 17:12:34 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v6 0/7] Make hcd-xhci independent of pci hooks
Date: Wed, 16 Sep 2020 17:11:01 +0530
Message-Id: <1600256469-13130-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aaedbc83-50e9-442b-2fb3-08d85a35169e
X-MS-TrafficTypeDiagnostic: DM5PR02MB3210:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3210FA39AF55EABEA72C68EECA210@DM5PR02MB3210.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xj7GpBGAMCdh4yjka4Wp1j7+4H9vLUu2DfUGozGET0s3G3b0jq2l2l6SbDaVF5JrXg6tzQN0w47TIz+iEteMdjX/fq4T57clVD7Q9glphbxi2fp0mTad4sX754sp+h8Pq9ELBHuq1TYGcGnV9ScWiHt+EGzVs5tta4q7FXHsYuxyJ6jMxLO0CDhR1d+4KeXfPU02VlVw/kVDZGjspsCufSVTAq/4vnzugH+iaqfZLpkjxdJYBsGC/Q3bvhXmQYhVH1v4/MbxAl6IFZpAEOLyRGN1Z9pSlr4L2ufQD8AWwa8NBvdG7hM0y2md/73oNbhnfjr0QKTwLgP55wTSnl9xqZnYLiPdh1TTIPlm/DxkV+zGg6iyHuutC8UZKKskuvcHvxwb/kXyrK2/Txv2rfAs4A==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(136003)(346002)(39850400004)(376002)(46966005)(6266002)(70206006)(70586007)(7416002)(107886003)(26005)(54906003)(83380400001)(110136005)(426003)(478600001)(356005)(5660300002)(2616005)(81166007)(8936002)(6666004)(186003)(316002)(82740400003)(336012)(82310400003)(47076004)(6636002)(4326008)(42186006)(8676002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 11:38:53.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaedbc83-50e9-442b-2fb3-08d85a35169e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3210
Received-SPF: pass client-ip=40.107.75.85; envelope-from=saipava@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 07:38:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) AC_FROM_MANY_DOTS=1.303, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 qemu-devel@nongnu.org, Paul Zimmerman <pauldzim@gmail.com>,
 Sai Pavan Boddu <saipava@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?q?=27Philippe=20Mathieu-Daud=C3=A9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series attempts to make 'hcd-xhci' an independent model so
it can be used by both pci and system-bus interface.

Changes for V2:
    Make XHCIState non-qom
    Use container_of functions for retriving pci device instance
    Initialize the AddressSpace pointer in PATCH 1/3 itself
Changes for V3:
    Convert XHCIState to TYPE_DEVICE and register as a child of XHCIPciState.
Changes for V4:
    Add DWC3 usb controller
    Add versal, usb2-reg module
    Connect sysbus xhci to versal virt board
Changes for V5:
    Add extra info about dwc3 and usb2_regs devices in commit messages
    Use only one irq for versal usb controller
    Mark the unimplemented registers in dwc3 controller
    Rebase the patches over master.
    Move few mispalced contents from patch 2/7 to 3/7.
    Fix the author names in the header.
    Move the inclusion of "sysemu/dma.h" from patch 1/7 to 3/7
Changes for V6:
    Fixed style issue in patch 7/7
    Renamed usb2_reg model to VersalUsb2CtrlReg
    Fixed author in headers


Sai Pavan Boddu (5):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device
  misc: Add versal-usb2-ctrl-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c                    |  55 ++
 hw/arm/xlnx-versal.c                         |  34 ++
 hw/misc/meson.build                          |   1 +
 hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 222 +++++++++
 hw/usb/Kconfig                               |  17 +
 hw/usb/hcd-dwc3.c                            | 717 +++++++++++++++++++++++++++
 hw/usb/hcd-xhci-nec.c                        |  18 +-
 hw/usb/hcd-xhci-pci.c                        | 244 +++++++++
 hw/usb/hcd-xhci-pci.h                        |  45 ++
 hw/usb/hcd-xhci-sysbus.c                     |  99 ++++
 hw/usb/hcd-xhci-sysbus.h                     |  32 ++
 hw/usb/hcd-xhci.c                            | 260 ++--------
 hw/usb/hcd-xhci.h                            |  22 +-
 hw/usb/meson.build                           |   3 +
 include/hw/arm/xlnx-versal.h                 |  12 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 17 files changed, 1656 insertions(+), 225 deletions(-)
 create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h
 create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


