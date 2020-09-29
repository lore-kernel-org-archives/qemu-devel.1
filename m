Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2761C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450D7207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e80t13V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450D7207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDHo-0005w6-9b
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kNDFU-00044l-Fp
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:52:44 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com
 ([40.107.236.71]:36359 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kNDFR-000172-OP
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFgMqo7end55LGK20Tcqt0PlncGJ8qcsK1XepAC0tOq5RiEnnaOg/LHQXvGw0CIczjgs6CHZX1YB2qSM+Vs8V0RIYQX3Km3XdrIIhXAz3AqYv8dKS9Xn+p7Tpl6Fle/4zQumzAWtEP8OoFrQvJ6VxIhxp3I9GiC3QztCa0kyo4fNH573H4twQQcUdr2FdLJhL4jxy4cqMF7rdYJVl8/q9w0Wh6biVGSo+qLH6dFA9wXWLhfv24yinzZdJhPVGiow7PUnoePX2U6KzEwPQ7o0lnl6z6+yfoPy83NayjZVB177ZCs8b1j9vd2usFri6i1QoEquPiL9/d2Fl9YfbiIEUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWLs7NikC2xONtTR10ycaCZcJfQv+3VUX4HvlUNAwLI=;
 b=CRO/7ySnO0XhnS9ZMHmIz2s/wj7onrAPHg8WrVtv9mRe/yf+A5CGWDc1FqjrKyD56Y6Zm6g+W0bg0EGgiRIODk/ddxwXysyDDSeGDItQCf/h+WoY/NnQwiS0dTY0lDrU1JFjaWjaP92H1dqAKy0NEMDnWDf5b913LdOXT/6xS2ll+vj0N7qYeTDc+vsz1sDH9QQ19BNoeiKS5dLDYJq6cqDrjZCyhDpnud1ahBKEJv87hgJy1qatpSLfys5s8da4GRwQudjnBjuxIWKVrFlIEP9JseMFAQVk7C/PUcLCuboOMw52w05yVq2hvpDbZNn6svYxapB27TwZtFj1dQpDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWLs7NikC2xONtTR10ycaCZcJfQv+3VUX4HvlUNAwLI=;
 b=e80t13V5W7hrOQarB6mshAfcySbbKSpjk9ryfRzojyKTDnPog2TFvKGaudoZHswZD8VnKsUEkz0iPLiYs6RZQBACb5rikHMdTpeSnXQiUJb8aF9uYTttynytr4wM3AnCDE6DYwb7eH5Y40Ba7Jp0QHH+nOoUaeRxjLMX4KiP2r4=
Received: from SN6PR16CA0065.namprd16.prod.outlook.com (2603:10b6:805:ca::42)
 by DM6PR02MB5467.namprd02.prod.outlook.com (2603:10b6:5:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 10:52:38 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::22) by SN6PR16CA0065.outlook.office365.com
 (2603:10b6:805:ca::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 10:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 10:52:38
 +0000
Received: from [149.199.38.66] (port=56276 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kNDEz-0002aC-QH; Tue, 29 Sep 2020 03:52:13 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1kNDFN-0000Mh-T2; Tue, 29 Sep 2020 03:52:37 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08TAqaoR023480; 
 Tue, 29 Sep 2020 03:52:36 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1kNDFM-0000MH-Fq; Tue, 29 Sep 2020 03:52:36 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id E793913C0569; Tue, 29 Sep 2020 16:25:44 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?=27Marc-Andr=C3=A9=20Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>
Subject: [PATCH v11 0/3] Add Versal usb model
Date: Tue, 29 Sep 2020 16:25:39 +0530
Message-Id: <1601376942-9648-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 48994390-30e8-41d0-5564-08d86465c807
X-MS-TrafficTypeDiagnostic: DM6PR02MB5467:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5467F1D696F8EC0232661C59CA320@DM6PR02MB5467.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmPRyDjhn8YPLYw89aZ1FJzB9j+29Yq9ev7zuz69OsYdt3PdkJj1gD7DM7VyBmE3zEBdKfY+wcVwI2H21LxsgweN7UNV7pNy8+qRaNTSc8SHDNCD2V+HoHnYH711NPNsPKo7giZbYyBOyPrh0zQmUg7U1vlLSQezKNV9ialvCxxDBdLeYb3ERQYzz7nrtyh7eXIgHsWHHclnyioJzqNieLxtUbuuGCcIbkiLbSCleZKqdI5QRNjxgku1zm7uy0SVIlGeN4nri7U7jbSxUN031eS6xyJ1FsSfnGEwLQgvdTzIe1uChPKgT095IQbUmdQ48IxdqNnBC6VixHMQhBjTvgLi/sov0DPMmRsOSAbtHQy3qKhzQQ95juXQHmwqgVzYcx0foOHtaREvrEvrlFZyf9frKwhdggZ3m1IwE8WBDiP1cW0NmxVkkQgtEb8a6U9y
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(376002)(39860400002)(396003)(136003)(46966005)(2906002)(107886003)(316002)(42186006)(110136005)(4326008)(54906003)(2616005)(6266002)(5660300002)(6666004)(70586007)(70206006)(478600001)(336012)(186003)(426003)(26005)(8676002)(36756003)(82310400003)(82740400003)(8936002)(47076004)(6636002)(356005)(81166007)(7416002)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:52:38.3183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48994390-30e8-41d0-5564-08d86465c807
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5467
Received-SPF: pass client-ip=40.107.236.71; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 06:52:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) AC_FROM_MANY_DOTS=1.041, BAYES_00=-1.9,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
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
Changes for V10:
    use vmstate_post_load avaialble in VMStateDescription
    tested vmstate cross migration.
Changes for V11:
    Removed the patches which got accepted
    Changed object name "USB2Reg" -> "ctrl"
    Updated Subject line on cover letter.


Sai Pavan Boddu (1):
  misc: Add versal-usb2-ctrl-regs module

Vikram Garhwal (2):
  usb: Add DWC3 model
  Versal: Connect DWC3 controller with virt-versal

 hw/arm/xlnx-versal-virt.c                    |  58 +++
 hw/arm/xlnx-versal.c                         |  34 ++
 hw/misc/meson.build                          |   1 +
 hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 222 +++++++++
 hw/usb/Kconfig                               |   6 +
 hw/usb/hcd-dwc3.c                            | 717 +++++++++++++++++++++++++++
 hw/usb/meson.build                           |   1 +
 include/hw/arm/xlnx-versal.h                 |  14 +
 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++
 include/hw/usb/hcd-dwc3.h                    |  55 ++
 10 files changed, 1153 insertions(+)
 create mode 100644 hw/misc/xlnx-versal-usb2-ctrl-regs.c
 create mode 100644 hw/usb/hcd-dwc3.c
 create mode 100644 include/hw/misc/xlnx-versal-usb2-ctrl-regs.h
 create mode 100644 include/hw/usb/hcd-dwc3.h

-- 
2.7.4


