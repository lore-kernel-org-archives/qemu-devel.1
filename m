Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E053321582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SbUv0E+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E053321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZht-0002Lh-S5
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZgV-000189-Lk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:50:47 -0400
Received: from mail-dm6nam08on2066.outbound.protection.outlook.com
 ([40.107.102.66]:3617 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZgT-0004BA-Od
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyXDqKCWOdCwLLUpr+YhQJVFXWnhf2QADUojznAUjoA1f12wjXIUfQBKGiITWVcEFj7JKkkAWbN7gt9Dhz2RJ1cPtI9p6005fsnCX4EdFvp1u8Kx8sZy6aQ/gKlck2S4rvecnRYmP3rN+lxkh1OuLTBivhwYJkdw0Jbrr+uy4+4PNLs5khp5D0VsQpjCPL3CeEUXUFPdsbymunRqq4mZ5eDbKKq3jyIf5Xe9fESbyu8kOFpim502CO3Rc56auVs36oN8vQf8CpMw4G5P/iDlgENbWzMg8K+pDxQlE0OUDT2qTxnzEVDjOfOpWEZsdXAA/UFK5cQyUQyAZAMWF2EWXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17SvV8frksWTTBCTKT9pztI+DD0roojNr8Nr8evePQ=;
 b=UxpGlnSMSogdWwHu2jV9FkzaGiZq0sRlouHJw0EFBeeZnf+Fg3tke2C+07pE7j9zkWUcAbqG7UrS/hxiv9SjmUBGXx8J/mpmn0nG46+txS4T3zl0UgzyMfvL+U+0Y3176S83MznejqZCLSPSlQU0VIDjJ76aSiv2JS006dnR+0moCIK9OasragPcCY+ti17Z+jGBivZ6SW18B7DqBxU7hpoCyav3mEYfmS0Jcxvzg6pKU3BuzKRTWUha+bNXDjAVwjaFvHhm5R39DQ0ZwlysgL8t1hZGsrbE5JVNXuaj+Y/O6yJaKl6AacSj9h5weH8XwdkIBGZAFXkZlAn/z/JsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E17SvV8frksWTTBCTKT9pztI+DD0roojNr8Nr8evePQ=;
 b=SbUv0E+oc7AutAO8QcLAoxZFoS5ITQlOWLu2rSIXte2YkMgj1vjDShPoVFcZl++yaYe6cQKCxqFhWG+nEW98wA6CmHcIFxUu42em9moOgjddgmUiNo+vN42b+A/L/NxgfSP+xYgh0z03zSNfQ92xAbdXptt8N4FYp1VEnS28uTE=
Received: from CY4PR18CA0039.namprd18.prod.outlook.com (2603:10b6:903:9a::25)
 by BYAPR02MB5638.namprd02.prod.outlook.com (2603:10b6:a03:9f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 14 Oct
 2020 05:50:43 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:9a:cafe::c2) by CY4PR18CA0039.outlook.office365.com
 (2603:10b6:903:9a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Wed, 14 Oct 2020 05:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 05:50:42
 +0000
Received: from [149.199.38.66] (port=33451 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZfg-0001eE-EB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:49:56 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZgQ-0003D3-F5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:50:42 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09E5oZ4b006464; 
 Tue, 13 Oct 2020 22:50:35 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZgI-0003AT-TT; Tue, 13 Oct 2020 22:50:34 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH resend v11 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue, 13 Oct 2020 22:50:30 -0700
Message-Id: <1602654634-35418-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f8d14a00-aa5d-41ef-f3d9-08d870051674
X-MS-TrafficTypeDiagnostic: BYAPR02MB5638:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5638F4AE98A9D202A30732ADBC050@BYAPR02MB5638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmXd0y8GBsjB+3DR6PRCi+g/aPd8BW7rsITlAjxtl7uKq05A+K+pH9QfiNtAhq/R1eYesE8YbcBwUAa7xrb8Q2dUGt+wsBEGcKH2ZXW3jchQ1QxjmT6CfrG+jmNJAqmhpyuUI3h16eSjE/Fku5jsBr6e3LI1pbNtQMai84HJes/3ujHTR0G/O+0a1C+m8ihQC4mMZJDr+PsE7AtC4cRRU5TNdgMYq68TxKfvnKHw1vs94ADG0AcBdWvO48OlKKUeL85JczETZv0qlNU9HmzeZj7GgP1fNiDJuqJeVmX9vpzZ21nmK/rNzOHOA4j09VCgXUP2G3hf/66+szoIt8l8cmtC0DVIpFWXkIOQEtq38exSwvP6lneXV4S1LB0u4Tc8BDt/c0lllaWKXEOl5YWfJQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(39860400002)(346002)(136003)(376002)(396003)(46966005)(426003)(82740400003)(47076004)(356005)(2906002)(4326008)(8676002)(8936002)(83380400001)(70206006)(9786002)(70586007)(82310400003)(6916009)(186003)(478600001)(36756003)(107886003)(2616005)(6666004)(5660300002)(81166007)(336012)(26005)(316002)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:50:42.6695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d14a00-aa5d-41ef-f3d9-08d870051674
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5638
Received-SPF: pass client-ip=40.107.102.66; envelope-from=fnuv@xilinx.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:50:44
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com
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


