Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189ABC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7951C208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YJExBpu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7951C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHwfb-0002UL-B7
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 18:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHwev-0001lK-83
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:09:13 -0400
Received: from mail-dm6nam08on2067.outbound.protection.outlook.com
 ([40.107.102.67]:27377 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHwes-0000Ys-By
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:09:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQPY+6bbR+A4b3OVRCV3Sma24lx47xQwKTOmVcmdi8iVhX21B7VVfhD/rviKStjgz9ooQNG5KHHUC87Nushu4MZ2rXSXIy7aP3B6wmZIch56IzLRO4DSGI7NVoWlcs50w9D54j1lXgHxH2wPMQ3+lz2lBA5M+elhJArEjgqTz8I1bm/C4nZzKlfM+51hAnAN7XnLoTQ0US2L5zgBeMJYKR1qRbymr8tZa2Zuug/Z3JmBGZ/7WaxFtNsFM9OzyZ7iB/NWqzlJTj0YmeTUeaqD86aWU7nSR8LGdXNEoscCC+5VGPJvEuzTSsenU17U1ikZB23b1+xkrhD4IlLvlPc5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S+c8KLpt3Q5GnkqL69GRx8DmPJliNC1z+0ywvsq/LQ=;
 b=TAnPg+ygAgFeWLci77+tymQkyd7YZTPk66Aj8w1LqN3f/nHtClN0eTqKjNkwClZBZU/OSrjRkZVvw666Ypkst567a6n9BTicIUtKfdWmCqCzLig4glNIEOGyN2vQiQVnrXbi4457z/2598K7xPQKOoNWdVxXXTlqLdjK3VnOHAfOzVGXVQ08FWiYBoZ/aDLqVZKXAxgjVaj9Ia4rCNY0rGxJKxFPU8gbb9vuer9Nm4bJzMwqMlkoUiYwqJ/RDrwQ7QVgaECUQshAY2cKXvUz5Mls5QHr9Uw+O3OB5wMbTXSGTsNLTWHaorrq0gaD0TNBrF6zOpG13oJjDWYvoKDj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S+c8KLpt3Q5GnkqL69GRx8DmPJliNC1z+0ywvsq/LQ=;
 b=YJExBpu1YdJ5jJxHXmWpdLwEOXqt5smnC/Rg8IlGOukp1miv0Y5T22I+Kiu6Zr4U1z6aLbIky5Xm5v7MDJXaD8ryb8xbAPaQIFlQf1RLWTxZzAOS3V4kYXMZ0zU3xbKb0u2QDcS9Wv3MQa5FJO6Y5xBx2sMgeRokgOV20Ta8Tss=
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by SN6PR02MB4158.namprd02.prod.outlook.com (2603:10b6:805:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 22:09:07 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::74) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 22:09:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 22:09:07
 +0000
Received: from [149.199.38.66] (port=48056 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHwek-0003rO-0r; Mon, 14 Sep 2020 15:09:02 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHweo-0006kE-Pk; Mon, 14 Sep 2020 15:09:06 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08EM8xWa016596; 
 Mon, 14 Sep 2020 15:08:59 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHweh-0006b8-1X; Mon, 14 Sep 2020 15:08:59 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Mon, 14 Sep 2020 15:08:40 -0700
Message-Id: <1600121324-31337-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 67be2de8-cb0b-4f28-9215-08d858facca2
X-MS-TrafficTypeDiagnostic: SN6PR02MB4158:
X-Microsoft-Antispam-PRVS: <SN6PR02MB41583F8280D1103D0546D342BC230@SN6PR02MB4158.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QTM0zi4vfRfrEATZE2NbfrTgoFGCfssDFshx4elTigMMC2kOF1OzmlKuyMkXTlBbCFVQfDyDCWINe3IK9ZTfAEMKcMBpoVtPxFb2bY8PTiRxmtS48DbQIw+EG6iksadgpmDYXUIDAyUt16LOR5GzmQ1zG0L7Q3x07FyY2gDDx09T294YonhiN5IPcCv88s56mgclSshwqE2o6k1H7bzF6bB16SuMg7ublCtiZr7q55gm1voOU/t+s2hmuZ/BpfDdxb6+tg6K6rzXUYE/YOQGkUREOpqoAYpPE8i/SnvuuuZ/yLQVSHXZXPwioCZ8XY+8+83wvdiZZZPNUB2IFVHjJ048g64yVRRmJF+penVuyqrIlpL1vMEgjEibgyvk6cm88jMMik8JwVwP+0yXOwgaQw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(136003)(396003)(39860400002)(376002)(346002)(46966005)(4326008)(186003)(356005)(426003)(2616005)(81166007)(7696005)(9786002)(5660300002)(82740400003)(47076004)(478600001)(6666004)(316002)(6916009)(336012)(70586007)(70206006)(82310400003)(107886003)(36756003)(8676002)(8936002)(83380400001)(26005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 22:09:07.1169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67be2de8-cb0b-4f28-9215-08d858facca2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4158
Received-SPF: pass client-ip=40.107.102.67; envelope-from=fnuv@xilinx.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 18:09:08
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

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

 MAINTAINERS                      |    8 +
 hw/Kconfig                       |    1 +
 hw/arm/xlnx-zcu102.c             |   20 +
 hw/arm/xlnx-zynqmp.c             |   34 ++
 hw/net/can/meson.build           |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1165 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    8 +
 include/hw/net/xlnx-zynqmp-can.h |   78 +++
 tests/qtest/meson.build          |    1 +
 tests/qtest/xlnx-can-test.c      |  359 ++++++++++++
 10 files changed, 1675 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


