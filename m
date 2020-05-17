Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C215CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCFC206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 07:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VZa17BPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCFC206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaDuZ-0000TP-Ng
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 03:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jaDti-0008MZ-G2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 03:39:46 -0400
Received: from mail-eopbgr750045.outbound.protection.outlook.com
 ([40.107.75.45]:34786 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jaDtg-0003qt-LH
 for qemu-devel@nongnu.org; Sun, 17 May 2020 03:39:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCV1goiQwlS80qK+SP4irzXhp72tp/Fez19CkG/Ld8A1Q4l30bVgvR35r7pEPlBnKMIio7HUDhOVI50C4k+mf/BB87dzAiFI+3QWwV9ZZJTl7BcrnKw3nsElmBzcgvf+LpgItR4pmgLwvMkjS2vbp7vWOCsFU8b/1SB9WsaTE+uIu4S6QeSx9375Lwn2luVYi/aC/FtkZYbJ6Qz/FsP2S8vsqoxeMtolJy1yeY94moXLszE/tNbk8NE963VMeBAYwhT2pySo5RhlhpEsfIkw6v+EmJyteGBkQQYda/kXm4z7Sp1dbx+J2iUj7tAbL9DR/seyr/bOr7r7Fk50T9mv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiCcL/Hg8yWcfh8bIGxvbWWYtPqf76NgqMPGQ3aCMqM=;
 b=X3nzMMEVEv69MZnYojAD3m+RGkLyyzsr3deAXfl+/HplVgTWAltGgYh0bs53Xbs4xVIp4X1yC0YgD6s6X+yFxJ5jB0DzHtFjMzoxCfAl/aW7jS+VMwrCuPJODz3VwG9WMk/pDCgP2I/JvhSUxFsDI47Vx9l8q0QOiqWQNg5ZMwioxUyUzuKp2u90VQOyO9nZ4BRYmGxe7ZlMfDKrbuUhvVWUWEpnXN4M2KQpSm9dGymLuIU6FelgaoDR46Nlg1JOH0IPLH+/2e8ALNo5LP7e9YCWL/ftnpDrn3EsfFRJiRxSK51i+it+WaDP2/HkPreqIKyKXLUDfKV8v6kgMfEu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiCcL/Hg8yWcfh8bIGxvbWWYtPqf76NgqMPGQ3aCMqM=;
 b=VZa17BPBYyDshLsaR7nyeP1Tzge0oUBAMdJkCsw4ML6sE9S1h7Yuo7tPUPJI5riT1mqQr2hlwozc1X2uBB1RgEC8y25ubDc+PUtL7RP6ooAJgvRJkcu41jPCWL7JZleiYPxgAC0lnsIj9koBtzjSueJgi/tb8mHN3Tc/pP7O2og=
Received: from SN6PR04CA0105.namprd04.prod.outlook.com (2603:10b6:805:f2::46)
 by BYAPR02MB4424.namprd02.prod.outlook.com (2603:10b6:a03:57::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Sun, 17 May
 2020 07:24:36 +0000
Received: from SN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::fb) by SN6PR04CA0105.outlook.office365.com
 (2603:10b6:805:f2::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Sun, 17 May 2020 07:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT042.mail.protection.outlook.com (10.152.73.149) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Sun, 17 May 2020 07:24:35
 +0000
Received: from [149.199.38.66] (port=37084 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jaDef-0002Ed-0H
 for qemu-devel@nongnu.org; Sun, 17 May 2020 00:24:13 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jaDf1-0002cx-Jm
 for qemu-devel@nongnu.org; Sun, 17 May 2020 00:24:35 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04H7OW9q020356; 
 Sun, 17 May 2020 00:24:32 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jaDey-0002ct-0V; Sun, 17 May 2020 00:24:32 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Sun, 17 May 2020 00:24:00 -0700
Message-Id: <1589700245-142782-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(39850400004)(396003)(346002)(376002)(46966005)(36756003)(70586007)(70206006)(6666004)(7696005)(186003)(26005)(2616005)(5660300002)(336012)(426003)(8936002)(8676002)(9786002)(82740400003)(47076004)(82310400002)(356005)(81166007)(316002)(107886003)(478600001)(6916009)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3cf0526-25c0-44a1-12de-08d7fa335a27
X-MS-TrafficTypeDiagnostic: BYAPR02MB4424:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4424A26ABB37702489010D8ABCBB0@BYAPR02MB4424.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 040655413E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfM60szjqSwEMrEX+4GiahP2423IAL/jpojX9KCl1aE+6iQaBFieasv97LaurVRuBPEmOIrywwuEw2FhtztIDhph6nxv0bNtEpdVhzDoGzOoOskF9+MBej8wGik5wl8FzVAmNHhhlo83DeFvzS5roUuPaqgCsC4RWU2i4+XuysCfdNhgBeuWPhLGiJq7Rre8GRU00CMy8qYMGzQpzC97Y4kMIfvfdArnfSYAiTNZ7qVFB+3EvX001o9gz5xjwpCJ63BnX/xC0qFqpsAPY+VP9QhJDdVhB4cxuck59cH56Pqv3A+BDkZk9Zf0GXXD5zmnL9lRCNhGrSz1E8393az3tY36+pkfQivhkS6GBWE0DH6mInXlRRk1lzkFpO4zhfuod0sLzVIXmHxJ+dhX4uxmPwLl+2yb2q/PRTUFvRBjTum9mmNA2/wSzRYlJ/m3Rff9q8IAnAwFCnK16KZvLsNDjIRrpoKRvEBXxEC4UPbzJ7kdAjRzVrsliteV43ukjSC7h8/bkuN6w+f7PVPDsz0ZLg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 07:24:35.8970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cf0526-25c0-44a1-12de-08d7fa335a27
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4424
Received-SPF: pass client-ip=40.107.75.45; envelope-from=fnuv@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 03:39:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Example for single CAN:
      -object can-bus,id=canbus0 \
      -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0 \
      -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0

 Example for connecting both CAN:
      -object can-bus,id=canbus0 -object can-bus,id=canbus1 \
      -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0 \
      -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus1 \
      -object can-host-socketcan,id=socketcan0,if=vcan0,canbus=canbus0 \
      -object can-host-socketcan,id=socketcan1,if=vcan0,canbus=canbus1

Changelog:

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
 hw/arm/xlnx-zynqmp.c             |   26 +
 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1116 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    3 +
 include/hw/net/xlnx-zynqmp-can.h |   75 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  367 +++++++++++++
 8 files changed, 1598 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


