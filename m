Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E31C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895152084E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ltbfmi5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895152084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyix9-0004Zu-O7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 16:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1iyivv-0003il-67
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1iyivs-0004V1-Ms
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:07:01 -0500
Received: from mail-eopbgr690048.outbound.protection.outlook.com
 ([40.107.69.48]:64261 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1iyivs-0004NH-AG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 16:07:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoKh+/QgjZv6B7PFNfwG6k+TagjFeawVDVr/Gx/h9hpALtvTm6T3ArFRSLGzxN6MdzfyKh+ZmZmK7DS5Mvoa6s667NXbif6ukvljtrf0ZJshKnEjp5SJwPLxF7/r4MQHtzZKybDqdg4ftKodp9Ii8+rKHuP17pTiTRCRVQd1fY7MdPz9wm3DRE8HFFONtKsIwNigrSwkuKwTE0JprhdMtP92UjoCVxEje25HheZTlwwWGI2Eng8d723bPPH1eHlqYSAhChMbP7xHhfOgRsGiUhZA8X0AmnlaROuxllx1aWnkx8Q77G4s6fDKhui2A1VMLJRfXm3mlLY6UegGYNFs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyCBbuIg53jdY3iZT0T39bNNJKJrHjcmS42/5FL4cQs=;
 b=M0ys5FLtYfH4ZekSjMf4h96/uLE5A/68od9U2VztEwnylen44uOADrECyzzCzKvaMhjibb6Ve03M0HwqVYoh+yx1dMx10MMWnPZRyZLhDINGNNcXm5yMfkiC9XB8tDdpyS/PyaNWBNHsdKvUJZY8v+r/FrWlHaNvXqfs9toCAlLwxAAOm1wJXvwjDIt4fqSdOPHGtW1UaqraAr6Bl5IY9/09GEzf/p2Nsio8V61kAFL9kN7T88FWQy9OWXjMEQ3tBH7DYH9SbPlbUiPPp/69Ea5kwSSOBwxZt2BBD5C4laXPPINkPA9jJGbMgJFY4YkwlGeSzHWU30cPjDL5a1JZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyCBbuIg53jdY3iZT0T39bNNJKJrHjcmS42/5FL4cQs=;
 b=ltbfmi5cseoBiuo7RjIlhE6HlQi7G88lX6RGPgOdjSvfwq8bh/1HXEsTJjCGxlcrqHe3X8fOGYuX/s56vHM2Yg+PY2t9+NC5y9TNLifM2q2qzq84BLnTGhqTqACq+kpGkALzeIe1yx+zufOCK28hKsfNsW9wvsM/Y7lMY0ZiU1U=
Received: from BL0PR02CA0090.namprd02.prod.outlook.com (2603:10b6:208:51::31)
 by DM6PR02MB6828.namprd02.prod.outlook.com (2603:10b6:5:223::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Mon, 3 Feb
 2020 21:06:57 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BL0PR02CA0090.outlook.office365.com
 (2603:10b6:208:51::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Mon, 3 Feb 2020 21:06:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Mon, 3 Feb 2020 21:06:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1iyivo-0005Dl-1z; Mon, 03 Feb 2020 13:06:56 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1iyivi-0002hL-Uh; Mon, 03 Feb 2020 13:06:50 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 013L6oAv026158; 
 Mon, 3 Feb 2020 13:06:50 -0800
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1iyivi-0002hG-2I; Mon, 03 Feb 2020 13:06:50 -0800
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] Introduce Xlnx ZynqMP CAN controller for QEMU
Date: Mon,  3 Feb 2020 13:06:49 -0800
Message-Id: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(199004)(189003)(2906002)(356004)(4326008)(9786002)(81166006)(81156014)(8676002)(4744005)(316002)(6916009)(8936002)(426003)(26005)(5660300002)(478600001)(36756003)(70586007)(70206006)(2616005)(7696005)(186003)(336012)(42866002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB6828; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e123355-b1b5-4208-aaa6-08d7a8ed0088
X-MS-TrafficTypeDiagnostic: DM6PR02MB6828:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6828954AFFB8EE9B58A0BBF5BC000@DM6PR02MB6828.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0302D4F392
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3JxJgco1qrIgrB42rsSBW2yv/sOpeuiqpEcvbpRrIMoRabyhG+XUPlpbxfjXa0+Wtlvr9U7DBnF4PYqqV5XsPJC6XbgrBFtz+9EzwFHqljQU7ttyD39R+LCB6vSvqyF8fq0uPhwmcgzO8zef8vhn9v3tEzJRfDctQ2iMWYY1waV5ITogrvH3SrsX7I1ztysYp/6nQGjbEbABWluGwTEfxxdpEeNXBv1b4rYT4h51xXzTJlJvptuX98FUJlpuSxOrBo0V1rQJHVDoEJ8K4S0xKJlBlbBrWtpfx+jY08DMlGHozyl0wbjr7w29BoC0CyUG4/UEM7TQrnCsjSN8kuo6K9fEpKLxmfJ1EBsqcyBVk5g+SCHjMJgAVgy1pgQ6/f0FVAo8ClCah/YuWyykruyVDFTfgRMPbewmJORTPc/1w72m79j4S8259tLVFdoCzM1UZJGuWL1x04eox9G+A5cNDprVknUgM5xuGHYyhbVJ2+aon8SRTII3XUmwf/kWMHr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 21:06:56.4595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e123355-b1b5-4208-aaa6-08d7a8ed0088
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6828
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.48
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
Cc: jasowang@redhat.com
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

Vikram Garhwal (1):
  hw/net/can: Introduce Xlnx ZynqMP CAN controller for QEMU

 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1106 ++++++++++++++++++++++++++++++++++++++
 include/hw/net/xlnx-zynqmp-can.h |   77 +++
 3 files changed, 1184 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h

-- 
2.7.4


