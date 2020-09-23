Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B780DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FF320725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eyEMz+Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FF320725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8vd-0004oy-TM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kL8rD-0000a2-Gu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:47:09 -0400
Received: from mail-co1nam11on2040.outbound.protection.outlook.com
 ([40.107.220.40]:30688 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kL8r9-0003xb-Nq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/umoUnA54XpLXfzl6AGlMCzlMbs+Vb6FpFt5/ihC4gF+/z25dyZNorOv+7TeQBUCitH/rvv00ddTEKEh7XLK9KXUbV7CO0KB9Tjb/BkbB6Z9Tz4fj5404HRdbYuV6n0+H62tLr9ifvrCAwH3/4m3bD1JEQEkh89/1+Uyt7t0Nc5FpkaWHyhRevPWYH+akOU2vvdBS0zpTVwfI72u+bsoAuxkEF2Vj9vrGtvDiGV+9jGpTy3fq3ZG+DMB1lTBFoauX3AKwNbjasjDqiZh0wTK+VGH5SmZuW8hLK8IsOFmDGLEWO3ECBQtQ9w8xS7+jZnQ61kfYlWMotiOXsTpNwSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYuslF5JM6BJfTpIeeJQooOkhtj4xh9wzSvqg57T9P8=;
 b=DY1QcUptU13sjkVWCK2tyZkuPBiK3+QpvwrJH75lIDJqTvcGimGLZh7bgwUD9ll5+vQ6tYGwLQt2rAWyQNb+QxvsWSrHG7CU7vobwFNo/qG8utAyXCu0/wnmuiBJfV6IinoTuW1NxNHQoy3ogdqLuNjWrTati04HUXIE4Hri3ijQWDffIUDPkhGszaKEgjbArt4ganQ3RmLgIr4p+MWWHH1d60nRFK/Ng8hxPgakqbwOg2Fe6iQUz3OUdkYPLMkO+tZToVpZm0DlIkpbUO3pyaVIFaqv/nRAofs2o2cUsQmCTSSCM91HuCTEAXERTf0MUwGu9QTIe8kzs4z0Y1pMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYuslF5JM6BJfTpIeeJQooOkhtj4xh9wzSvqg57T9P8=;
 b=eyEMz+JhN+/YFmIOi+6nGGhylQZqaYMDo/ehMr4HmmqYOHfie1xJsubaBcMqLBt3PWDv86Bo842rTPLdysZJO6WygXqPNcZLoyhPdHWZH9YjEU4cWvz0WHG52vuoKqy+z/1qzEO4NE4ZAAFBZqG9xNyMI5v4JOA2UpYFOBmBhZA=
Received: from MN2PR22CA0023.namprd22.prod.outlook.com (2603:10b6:208:238::28)
 by BL0PR02MB3745.namprd02.prod.outlook.com (2603:10b6:207:43::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Wed, 23 Sep
 2020 17:46:55 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::46) by MN2PR22CA0023.outlook.office365.com
 (2603:10b6:208:238::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26 via Frontend
 Transport; Wed, 23 Sep 2020 17:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 17:46:55
 +0000
Received: from [149.199.38.66] (port=50490 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kL8qk-00063V-QK; Wed, 23 Sep 2020 10:46:38 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kL8r0-0003Lc-Cw; Wed, 23 Sep 2020 10:46:54 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kL8qz-0003LP-ON; Wed, 23 Sep 2020 10:46:53 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 9060A13C06B8; Wed, 23 Sep 2020 23:20:17 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v9 0/7] Make hcd-xhci independent of pci hooks
Date: Wed, 23 Sep 2020 23:20:00 +0530
Message-Id: <1600883407-15147-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5765c721-b02c-4eed-58f2-08d85fe8a952
X-MS-TrafficTypeDiagnostic: BL0PR02MB3745:
X-Microsoft-Antispam-PRVS: <BL0PR02MB374504C7EFEB4397CA2C90B6CA380@BL0PR02MB3745.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKM+BTuNIjorBBBs83TDslb4doUKlqVLXoioOocSkrLaQRPDQKYl9emVR6IFSSc0vegTOcUwSg6H4N0VyHIsu6hsGOwo/2qR98vXVHitBu/jCQlus6jox9tHq2pxGGNzFtgJ0FPq2C1ZxPTD6d6UifJmzu80RF+5ST4RWnLJzxuj7efwBZ+wNavB6pSHT9ZCUJbUl0Vuj1sp6O4g5EDyLVacT7x+sMTC0UpLh/Fs/Bm/ci7sGCDVB9UT713eFUuI8vWVu0/6A8ulFuudjE/gbzS5vjf4NtX8IsbCYjmouPP1MgP7MqT1GKUHz31TrtYn1POCdspoPKu38mFycOIJ0jLZ+Y8OeAnmtn5ONnr8WcHMOv9dVgzib/z10/EgfYJ/BrAb3h9KD8qxsnnH5V7XEO30OmCeimaq9BbebGyu/1xtXb9X2IW9Ycza8gbF7cmw
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(396003)(376002)(39860400002)(346002)(46966005)(8676002)(82740400003)(186003)(47076004)(336012)(36756003)(426003)(54906003)(2906002)(7416002)(42186006)(316002)(6636002)(110136005)(356005)(4326008)(478600001)(70206006)(6666004)(70586007)(26005)(107886003)(5660300002)(8936002)(6266002)(82310400003)(83380400001)(81166007)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 17:46:55.0582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5765c721-b02c-4eed-58f2-08d85fe8a952
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3745
Received-SPF: pass client-ip=40.107.220.40; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:47:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) AC_FROM_MANY_DOTS=1.072, BAYES_00=-1.9,
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
Changes for V8:
    Fix vmstate sturcts to support cross version migration.
Changes for V9:
    Added recommended changes to fix vmstate migration.
    Fixed commit message on 3/7.

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
 hw/usb/hcd-xhci-pci.c                        | 260 ++++++++++
 hw/usb/hcd-xhci-pci.h                        |  44 ++
 hw/usb/hcd-xhci-sysbus.c                     | 109 ++++
 hw/usb/hcd-xhci-sysbus.h                     |  32 ++
 hw/usb/hcd-xhci.c                            | 269 +++-------
 hw/usb/hcd-xhci.h                            |  22 +-
 hw/usb/meson.build                           |   3 +
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 17 files changed, 1691 insertions(+), 229 deletions(-)
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


