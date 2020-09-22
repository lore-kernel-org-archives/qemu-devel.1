Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0CDC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0492A20936
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 13:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="LZiNBHmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0492A20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKiRZ-0007xk-Ts
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 09:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiPi-00073P-0x
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:33:01 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com
 ([40.107.220.53]:12927 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kKiPf-0000AN-0n
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 09:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gL4evOYr3Ydnur29QN+vMmB8oMj0mOZzcJjFDSK454jjHSqNA39wuUvunTysI42yg8ptbXwKiQAqoxmjMe7yEBoVYVgKJKSeVYvFDGTUCnV+7RbpKVCTlhRkuVldF+H7QEzQsjp7r7NFouUReyZwJKRa9Hgt0y1DimwzrLOBMosHowA2tBoEYtI2M2L7CJGiifBaWOgo1jg4D8+E38agVhVTFdCnAbeG+5oA6qDuLyo7/eSOlUBNaJc0yl6PBh7i/BHCpBQRt+visSFAb1+87MoqEiIHMA5HFKg83StNmdGGcgQJ96NXlhbk9eu3kn0MnzU0vA4UMN40dDG8RhJ04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd+hshLPSI9WHD+/ZAibAcO5WOG6G0A3AEY0r1lveuk=;
 b=QlkzawbJHymCodeIezDqzv+hub0EwMkkSI8+PkkPga4kcmgGg7k+2p0WLihJ/o6lX4XIyudIeb3m8aQCL9CyCxSqOK7M0xX1iiM0w95Jgl7VxQ1qMqkNkCUlnKmxNRr7WTZMu5+LD+iRpH3plSC4bYLLYIN7nCKl8m0NxXZVwTrFgbyk4wgWy1ZVGxC7+RLAlh04cgMCpPvwea6d0P4LOFutgBCLulLgv9JQnvD3MX8cc2MIiWIYKZxvnbU807g4u44z38o2O1nk8s81IynlkqnjwHb2Cekvcq39OV7ymCwrBZhzc9CjuGdSMLhV3aAB6FKXrr7JW0GQpILiK41c2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd+hshLPSI9WHD+/ZAibAcO5WOG6G0A3AEY0r1lveuk=;
 b=LZiNBHmcgHZpmOroVrtKh8tVrC3m+FlGdToDD9Cig4G8dg5MpmNXurWeiQX/AJm/345e1GGBywkSjqCEZrk32YS0AgxdbMbaHdrzDyPJ6ubGIuGbSQ1udjl4UstzdRUmRdzvo6v70mmLJWYlOak1hY6ShQTAKjxbsM1rUJbyPJ4=
Received: from SN4PR0601CA0016.namprd06.prod.outlook.com
 (2603:10b6:803:2f::26) by DM6PR02MB5993.namprd02.prod.outlook.com
 (2603:10b6:5:156::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Tue, 22 Sep
 2020 13:17:47 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::9d) by SN4PR0601CA0016.outlook.office365.com
 (2603:10b6:803:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.21 via Frontend
 Transport; Tue, 22 Sep 2020 13:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 13:17:46
 +0000
Received: from [149.199.38.66] (port=37229 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiAl-0000Or-Q0; Tue, 22 Sep 2020 06:17:31 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kKiB0-00089Q-4e; Tue, 22 Sep 2020 06:17:46 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MDHilR030336; 
 Tue, 22 Sep 2020 06:17:45 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kKiAy-00089H-Lw; Tue, 22 Sep 2020 06:17:44 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id ACD1213C03E9; Tue, 22 Sep 2020 18:51:11 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v8 0/7] Make hcd-xhci independent of pci hooks
Date: Tue, 22 Sep 2020 18:50:30 +0530
Message-Id: <1600780837-8231-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a9afe9d5-9677-4e42-d25e-08d85ef9e5d5
X-MS-TrafficTypeDiagnostic: DM6PR02MB5993:
X-Microsoft-Antispam-PRVS: <DM6PR02MB599381362752D012F381BE6FCA3B0@DM6PR02MB5993.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCECXcdMImXNN4caayA8AkwNf+JAFhUJ+zRQ+6hbjK6qn4d+H2Oi5xsaY0G78ARpZg4p/gm7mTtkekiR+pdQVamHBz/MKhpad7+yAOWaLcZtjhBKNYh0WoVzr306HELWfUxwdh3w71H+z3VPxOtAkVDJPAL7lJkbB+OrXdugJM8RBaYKfH++BfBQAuj+avXk1ysEzh93F2X6Elr1y4E0LgPRIB7Q+0f8IsEnVRYfRXquyEbTuluFslofLLNIYuBQ8NBiOmUFAWlsPx9TQnNLw0f3usHTxiWwY/W232EtdWvo3O6UuurTRi89Dc63yNh4lJ8UyjjJihebTMa4HfIibBwkoW/5Q6Pyjah1HGOMpOhRTe+D5nS/MSKZAh5KC2l+L5rL3xRR6xxwSjR+NdnTlQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(396003)(346002)(39860400002)(376002)(46966005)(7416002)(6266002)(107886003)(2906002)(83380400001)(36756003)(8936002)(6636002)(356005)(81166007)(478600001)(82740400003)(8676002)(6666004)(82310400003)(336012)(186003)(26005)(2616005)(426003)(42186006)(70586007)(70206006)(54906003)(4326008)(110136005)(5660300002)(47076004)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 13:17:46.8638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9afe9d5-9677-4e42-d25e-08d85ef9e5d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5993
Received-SPF: pass client-ip=40.107.220.53; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 09:32:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) AC_FROM_MANY_DOTS=0.866, BAYES_00=-1.9,
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
 hw/usb/hcd-xhci-pci.h                        |  44 ++
 hw/usb/hcd-xhci-sysbus.c                     | 109 ++++
 hw/usb/hcd-xhci-sysbus.h                     |  32 ++
 hw/usb/hcd-xhci.c                            | 264 ++--------
 hw/usb/hcd-xhci.h                            |  21 +-
 hw/usb/meson.build                           |   3 +
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 17 files changed, 1672 insertions(+), 226 deletions(-)
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


