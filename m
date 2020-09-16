Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0392C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E24F22288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c+bcnsCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E24F22288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYJW-0004OP-3t
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHj-0002TB-DP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:49 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com
 ([40.107.94.75]:9665 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYHh-0003iy-B0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:19:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eygrTI0wPsZi2hGh5+7DNJKjJyALlGakjqtgwjPw9b420VO15C1lhmeqF6M4OFDtS/OQG1RMddB8qCsUHllZ8NDXoo46PrNpMUgBMp5C8BsWpJsTWhXwa9ApKEQ+MwZLjeOgULD2OFPfgWx5mQWBrKHhyxrGDVDiSLc9ls/KDs+77oDEmZmMSiMkLLf6UL5fZh9fInz3pg/lwtoy+gMu9OUuPilpIJxeU6pkJiQrEMDrQ5R37wDTQEyhkN7i5al6iByVqZa30ZSmwX4TshTXfVl7KH5gGUKPg90DFfHSxHFBBoPbbXfEElgQTjd2JccR+ealxObAhA5y0W11jRWfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cm5X+KAJQjdECtOlfiscIk1nsGeoBM3z5Kgx2yj3UY=;
 b=nG+XeySHfkacsHURzvoxhfCsaysKxHW0dhS8y0Nc0EWMsSb+qsPR2HQMZaz4B9F7HwIZrink0vNiH2iGbwyb004HOjFiq1fzmkbYJdYvuNmw80po5xS+RKEVSEbKAwJqgd8PlJUnlBsQ2DXmEkxwJKoT6VibOsTIIZG5Xwuo0JUoVqRQH0VncUPKUOLo4RzRZ67D4sU0le3RsLW/tLTTCFS0ieewxdoe0WIyYf0j42awxjICCi0HXHrPEBe4YRib6dB2YG4NH4tyQofUtTF6G3Ye5OOTdcqnmyMcP6ve/9TUs3TLXlLTHF+ZLBuGg9o5H0u9R7W8ihQWGgSc453v3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cm5X+KAJQjdECtOlfiscIk1nsGeoBM3z5Kgx2yj3UY=;
 b=c+bcnsCfYEkL93st+mOqYKWEEVVH3O5flDRijHo1p7UFcca0YdAd9SpkZ3xzj8h9TtwRW6o4xvxkEi7jQnhr7+eweZdt4lxg56dV8JsBfKnGDKJTVn8uCPEtTStICijowcxK/OKGrJkb5Vl+V/yW4/YwTIqQIN6VG5sol/GRiLA=
Received: from MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22)
 by DM6PR02MB6892.namprd02.prod.outlook.com (2603:10b6:5:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 14:19:42 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::d5) by MN2PR22CA0017.outlook.office365.com
 (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 14:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 14:19:40
 +0000
Received: from [149.199.38.66] (port=43102 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHV-00049w-2A; Wed, 16 Sep 2020 07:19:33 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kIYHb-0004pQ-Sb; Wed, 16 Sep 2020 07:19:39 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08GEJcaA010151; 
 Wed, 16 Sep 2020 07:19:38 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kIYHa-0004pF-9g; Wed, 16 Sep 2020 07:19:38 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 683C213C0235; Wed, 16 Sep 2020 19:53:21 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v7 0/7] Make hcd-xhci independent of pci hooks
Date: Wed, 16 Sep 2020 19:52:13 +0530
Message-Id: <1600266140-20763-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8131b051-6468-45f9-5aae-08d85a4b8cd2
X-MS-TrafficTypeDiagnostic: DM6PR02MB6892:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6892CB65AEA279504C744783CA210@DM6PR02MB6892.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYhMcUtxfhb31cFGZC+dsF1NM+P4gVLAkjeyONSQs9/F3n+j4YJ5MfW7ythI2z+HautLSamKjXAVUww/UwAzIGdOqrwP0N3Ez+5noDK9eJKBjPKjB75r+AM+p4Fi0ffw9FuTbpeTG8pGhYe14rgAp4aRgTgVLOztwebA2bOxX/WCvIxPDAiuwI+h9qBKEheePvg5Rum7b1oLsdLioYshIexTZwc4k8Mw/SN2up1Ybes2JcDKuQSSRowaxopwaWdPm6UP3nv9LExUgrsobajK5huGCOKUJ/b3/ZvHS1q2rMcYxBT+cqYClnUG0qpMpg8hgzOzTUDVmVkX8IwPHzofmSs5ZphEzAQHoOvHaxAuRgztScByOnOmuBusdX/TJGoRmTxAe08/IUwKgfV4v7XChA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:ErrorRetry; CAT:NONE;
 SFS:(396003)(346002)(376002)(136003)(39860400002)(46966005)(54906003)(47076004)(316002)(81166007)(82740400003)(6666004)(8936002)(356005)(6636002)(8676002)(83380400001)(42186006)(7416002)(186003)(2906002)(36756003)(5660300002)(70586007)(70206006)(26005)(6266002)(110136005)(4326008)(478600001)(82310400003)(2616005)(336012)(426003)(107886003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:19:40.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8131b051-6468-45f9-5aae-08d85a4b8cd2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6892
Received-SPF: pass client-ip=40.107.94.75; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:19:43
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
Changes for V7:
    Create a usb structure to keep things clean
    Remove the repeated patch in the series i.e 5/7

Sai Pavan Boddu (5):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device
  misc: Add versal-usb2-ctrl-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c                    |  58 +++
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
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 17 files changed, 1661 insertions(+), 225 deletions(-)
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


