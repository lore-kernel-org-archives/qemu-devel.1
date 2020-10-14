Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB8AC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CFC21582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MxtbUmpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CFC21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZoO-0000E1-8d
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZj8-00047G-Ln
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:53:30 -0400
Received: from mail-eopbgr680076.outbound.protection.outlook.com
 ([40.107.68.76]:18259 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZj6-0004w3-Cx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNLXX3XkJ6RZkZzQJr7857fAk3YtITEzPjWEkzW1IOrgGwhR+KL9s1tPr9Rw/BUBgcWGCIOdTdaxOw4Xnq4oLHxnAIA3/BVssOBdGJnnHLwSJthN68GtNyhLTV3juJPlCg9MPh6WIlAGkyenaXs6lOlzOPfhdwpCKjvNM/bny5z76G1fh27e5kAi8Y/nvN/unBt7o36G+8TulkAqpAPO0QYFAcBOVRhC7hVfwYI/F4XGlrxbWhxY8KRJ20hoDRnvaqVLlyCGnqX79+xu+LkyH5ZWB+LgkSlXYaw7bUHf0umfnaRZg08r7D3/ED/u72TMZd4upjrGXsBQPOZ4tB0q1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17SvV8frksWTTBCTKT9pztI+DD0roojNr8Nr8evePQ=;
 b=LKkgyj/mSk++oTl3AomV2oxXVomOj+GfWfxQywT7Hyt9xp/r+ijVtIdZAmJ1s8lApVV/YiLce1X3eQ/znVqYful15fvtKNSCc0aPuoy5GwlOb88b4kPFHolcEZVOv91h2U7i19YxOaSIIp8Rdg1jY/E4jGag6AQYYa9KiNKrdXRjnnWdIN0qzSHJwCJvIr4bPM3AkB8FWRVl31jzTsqFEihKhxuRYXY4ShG3KVu/+U7dMAoMqmYOBH7GIWa3Q969WY6tJB11Gm+gOxPhsE859sKu1f9YJ/ochL9NtmiqjhwGOwUEDoEp5kGOAS+ZJfzw8Gl1+3T6ZubPNadQMGZNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17SvV8frksWTTBCTKT9pztI+DD0roojNr8Nr8evePQ=;
 b=MxtbUmpdjLdwL0RkIoURfNhg/PBvUVoCidUbYBs9LZc3CNaO/sUPJDeURQCvsUiZjkCEFC7sbhyuAgwidLPtpESHjBQKc1WcpF/0viq7PHhLJLhFmJmZsJHuAVa8cPf0fXhJtOpEa6wvQLcxZ64jFO68QQfMV5Kyw0PpjuPMVWM=
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by BN6PR02MB2835.namprd02.prod.outlook.com (2603:10b6:404:fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Wed, 14 Oct
 2020 05:53:23 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bc:cafe::1a) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.15 via Frontend
 Transport; Wed, 14 Oct 2020 05:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server id 15.20.3455.25 via Frontend Transport; Wed, 14 Oct 2020 05:53:23
 +0000
Received: from [149.199.38.66] (port=35508 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZiH-0001gn-8u
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:52:37 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZj1-0003eG-9j
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:53:23 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZiy-0003e5-9J; Tue, 13 Oct 2020 22:53:20 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH resend v11 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue, 13 Oct 2020 22:53:02 -0700
Message-Id: <1602654786-35589-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1279e1ba-9fe3-4334-9bf7-08d870057661
X-MS-TrafficTypeDiagnostic: BN6PR02MB2835:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2835E12965E65FA8D1F9A4A1BC050@BN6PR02MB2835.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4USJnW8fR58TeSdC6mVq5HUmxoJrpFPG0lrM0WzikOKsHxDsnebERD+AOkxMC7cAv61EVXsyirlPZHL6/SW3jYqNc6afnxnvp+unjUWTP18egW07DmaELapVDVPmBit31NDEcB/v/1OvrMRlrKE0d1TIxdWIkr3qRvR/VDrysHzhlE2Hq3qrnqQyNOK4BcrBWhlVRyKn4TJrAdnmsOna4rchZLX8z56GYDWr/+IULq+g5yei3JzyvSBpx/nY8pn+wb8u4Ep7riZilt9ODcZGlWL9CZS/Qtk9pdYU35My69HfijsYb1+dM1Vick5R9W25utL8GTZ6Q7cR2UKd1nJ5KEAAzVenWdx+Vzlsg2paskRRh5RoNmxDzjAqQtS4Jr7rla7fV9SZL0dAxxelNy/JAQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(376002)(396003)(346002)(39850400004)(136003)(46966005)(82310400003)(26005)(8676002)(36756003)(4326008)(336012)(5660300002)(7696005)(9786002)(83380400001)(6916009)(82740400003)(186003)(356005)(316002)(2906002)(8936002)(107886003)(2616005)(47076004)(70586007)(6666004)(70206006)(81166007)(426003)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:53:23.6150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1279e1ba-9fe3-4334-9bf7-08d870057661
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2835
Received-SPF: pass client-ip=40.107.68.76; envelope-from=fnuv@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:53:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

v10 -> v11:
    Resending the series with correct cc.
    Replace DB_PRINTS with trace-events.
    Removed unnecessary local variables.
    Added const with tx/rx buffers in qtest.
    Added reviewed-by tags for qtest.

v9 -> v10:
    Rebase the series with the new meson build system.

v8 -> v9:
    Use g_autofree to do automatic cleanup the object_get_canonical_path() used.

v7 -> v8:
    Change CAN controller to keep one canbus per controller.
    Add canbus connections at machine level.
    Remove ctrl_idx from CAN controller.

v6 -> v7:
    Remove '-m 4G' option from xlnx-can-test. This option causes the fail of
    docker-quick@centos7 build test.

v5 -> v6:
    Add ptimer based counter for time stamping on RX messages.
    Fix reset issues.
    Rebase the patches with master latest changes.
    Added reference clock property for CAN ptimer.

v4 -> v5:
    Add XlnxZynqMPCAN controller id to debug messages.
    Drop parameter errp of object_property_add().
    Add formatting related suggestions.

v3 -> v4:
    Correct formatting issues.

v2 -> v3:
    Rectify the build issue.
    Rearrange the patch order.

v1 -> v2:
    Rename the CAN device state and address code style issues.
    Connect the CAN device to Xlnx-ZCU102 board.
    Add maintainer entry.
    Add QTEST for the CAN device.


Vikram Garhwal (4):
  hw/net/can: Introduce Xilinx ZynqMP CAN controller
  xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
  tests/qtest: Introduce tests for Xilinx ZynqMP CAN controller
  MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN controller

 meson.build                      |    1 +
 hw/net/can/trace.h               |    1 +
 include/hw/arm/xlnx-zynqmp.h     |    8 +
 include/hw/net/xlnx-zynqmp-can.h |   78 +++
 hw/arm/xlnx-zcu102.c             |   20 +
 hw/arm/xlnx-zynqmp.c             |   34 ++
 hw/net/can/xlnx-zynqmp-can.c     | 1159 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/xlnx-can-test.c      |  360 ++++++++++++
 MAINTAINERS                      |    8 +
 hw/Kconfig                       |    1 +
 hw/net/can/meson.build           |    1 +
 hw/net/can/trace-events          |    9 +
 tests/qtest/meson.build          |    1 +
 13 files changed, 1681 insertions(+)
 create mode 100644 hw/net/can/trace.h
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 tests/qtest/xlnx-can-test.c
 create mode 100644 hw/net/can/trace-events

--
2.7.4


