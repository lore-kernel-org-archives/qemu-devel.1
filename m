Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A93C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A07207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 06:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SpCyUXLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A07207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGG5D-0006HH-QQ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 02:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3U-0004rX-RX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:36 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com
 ([40.107.237.66]:21472 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kGG3S-0006C8-JF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 02:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxmQRH9kUe/KlT8W7wLM6SIT7vZPqCvoEXKkKTY76kwkTiO5exD+8He9iny+5unAkhYbYeGJX0k3xHz+efDulnIf9+fPEWTcglYkGwc5T11gBl+WlbO39hw/4630HwRrc0MnLgw/IE9TCApHi2J/A3ed7FuVEVSABE2da7XqMOc0eYU0JQMySXoTjqPUmBw1bauqAOV4pj1OB9h6ym/GT0Y7An2i7sSffTqcfIJGr+PZiBm6ZbelbJRs9OkQe3pTB4Mjl14PvzMDDtUgFb4D0KU/Nf57b5BjC5gD95gI6sqFo12neaIlllTks4BO9E4iK/B1mDyTC30mS5q5Hiqt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw+FCaAx4O33VaU5rmb3obkxeXjwUuZ5CfvQ6PVYW6k=;
 b=EzVzw6svXs61cyLPuQbTqLyMddGc8Qga9duEV6W+H3Ai333r7n/GdiQeR/AZpkM67UOrxvNu30TPbrI99+TWoUo0J835Nhf2q3GeIUN9/dDSl4saxBhQlZJgcZlfFvKAGA2o7RdNWKMVOSSuJIjmQBXzlae8K5DEGDLsKRb8BRhZv1jvOL0STGE4girCfzU8K6vVcuYIk3NfZ6gNfxNALbxKuCxtjzD9z7TWe4riBIw0OJdN3jRL/IgjFBGvnUwXbsyWnGqI5ghh8be2/AgLM6OFlZywUP3hR0MQI5/s05MrvjFy9A1C6/bN2i3ZX0nPZacjCfNdRDFfFyfOuoqZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dw+FCaAx4O33VaU5rmb3obkxeXjwUuZ5CfvQ6PVYW6k=;
 b=SpCyUXLbZKkjB7emxAkRIck20rhmEaHS80ZwljfkZHEP926FNyAJVkfLtCfhea90ZGSBVbPUR7wyKArWO/WpjgwJFRuL8w1AHJht8bz48WJ6NGE6xMwCRV8cU3KELw4G6LCtbb5KSvOMw2xtBOxfpujR25p+SyJcUn41bs/ogq0=
Received: from CY4PR13CA0004.namprd13.prod.outlook.com (2603:10b6:903:32::14)
 by BN6PR02MB2627.namprd02.prod.outlook.com (2603:10b6:404:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 06:27:30 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::95) by CY4PR13CA0004.outlook.office365.com
 (2603:10b6:903:32::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Thu, 10 Sep 2020 06:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 06:27:29
 +0000
Received: from [149.199.38.66] (port=57148 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG36-0000J2-RF; Wed, 09 Sep 2020 23:27:12 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kGG3N-0001Tm-9g; Wed, 09 Sep 2020 23:27:29 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08A6RSdB002436; 
 Wed, 9 Sep 2020 23:27:28 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kGG3L-0001TT-Q6; Wed, 09 Sep 2020 23:27:28 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 389DF13C0565; Thu, 10 Sep 2020 12:01:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v5 0/7]  Make hcd-xhci independent of pci hooks
Date: Thu, 10 Sep 2020 12:01:02 +0530
Message-Id: <1599719469-24062-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e436d54-e279-4f07-174f-08d855529803
X-MS-TrafficTypeDiagnostic: BN6PR02MB2627:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2627662D940FD70C74DBAAD3CA270@BN6PR02MB2627.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gs8FVr3a1xjZXnKNtmcHsR59ImuZIVHcwth03lgG3gVnbYXtaBlLVQEXZvrVi8iuZFEVhQVUgsWvg//dt4j/ZSSIOsn54QFih18zCjbR077Qlid0lgt393KZtHlo738L2bxR9/HL/FCWRogjW1X/yvUXyb2CdWdBn0OTnt8eyHXPpS/uY6rPwyfw4yOSgmTONSbPLU3Y8/A4XO6R3yBO4oVKb6Y7UXaiteK2u9tCv13lTUttgt+ZqRS/wVruzuvUyJ+asE+BVINtrp2QdzjjRYnG/R/CnKZihoDdURo+D1FV1M5TJ+bukG+izkWlqsRwDI41aTN+ZUSFrY3stPP0Ft7NCgNvhWTmjNoJjI6P/pCr4MWmv5R4IDt38OgPGfinQ++Csh8PyebCiBhnjIZ6dw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(346002)(396003)(136003)(39860400002)(46966005)(107886003)(8676002)(82740400003)(426003)(36756003)(110136005)(54906003)(81166007)(83380400001)(42186006)(356005)(47076004)(2906002)(316002)(7416002)(4326008)(336012)(70586007)(82310400003)(6266002)(70206006)(6636002)(478600001)(2616005)(26005)(186003)(6666004)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 06:27:29.8803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e436d54-e279-4f07-174f-08d855529803
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2627
Received-SPF: pass client-ip=40.107.237.66; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:27:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) AC_FROM_MANY_DOTS=2.999, BAYES_00=-1.9,
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
 sai.pavan.boddu@xilinx.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>,
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


Sai Pavan Boddu (5):
  usb/hcd-xhci: Make dma read/writes hooks pci free
  usb/hcd-xhci: Move qemu-xhci device to hcd-xhci-pci.c
  usb/hcd-xhci: Split pci wrapper for xhci base model
  usb: hcd-xhci-sysbus: Attach xhci to sysbus device
  misc: Add versal-usb2-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c               |  59 +++
 hw/arm/xlnx-versal.c                    |  38 ++
 hw/misc/meson.build                     |   1 +
 hw/misc/xlnx-versal-usb2-regs.c         | 226 ++++++++++
 hw/usb/Kconfig                          |  17 +
 hw/usb/hcd-dwc3.c                       | 717 ++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-nec.c                   |  18 +-
 hw/usb/hcd-xhci-pci.c                   | 244 +++++++++++
 hw/usb/hcd-xhci-pci.h                   |  45 ++
 hw/usb/hcd-xhci-sysbus.c                |  99 +++++
 hw/usb/hcd-xhci-sysbus.h                |  32 ++
 hw/usb/hcd-xhci.c                       | 260 +++---------
 hw/usb/hcd-xhci.h                       |  22 +-
 hw/usb/meson.build                      |   3 +
 include/hw/arm/xlnx-versal.h            |  14 +
 include/hw/misc/xlnx-versal-usb2-regs.h |  43 ++
 include/hw/usb/hcd-dwc3.h               |  55 +++
 17 files changed, 1668 insertions(+), 225 deletions(-)
 create mode 100644 hw/misc/xlnx-versal-usb2-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 hw/usb/hcd-xhci-pci.c
 create mode 100644 hw/usb/hcd-xhci-pci.h
 create mode 100644 hw/usb/hcd-xhci-sysbus.c
 create mode 100644 hw/usb/hcd-xhci-sysbus.h
 create mode 100644 include/hw/misc/xlnx-versal-usb2-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


