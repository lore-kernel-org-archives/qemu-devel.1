Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE69C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2956A20780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ECs6Yub5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2956A20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVmL-0002Ds-QD
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkU-00012s-JO
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1jPVkT-0001Ya-1z
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:29:58 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com
 ([40.107.92.78]:25433 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1jPVkS-0001Ww-Ov
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A43b8VXlVU7LoYPd0O9JvFr0+1Td9T9BBktpyK1xF+ePmYh6axeQmBWxROmUXfonAR89ygLHWsOFu+iZ0/olYwfPTNJGE40inFX29gP6lJpxbhCOishDW3aHPOJS1hl5nZGWc1NmcPkvMgw3vfuFKVBL8lIsR+7N7PoW4DZqtRyOjGJsJc/llIbU1D2NK8BvWcnjOe5uZdfJW6Lbb7shkBhamQmfkr5ovCicyIvPcBYYT6SlC/FHRuwL6lOtD3OPzUYFmVZoQEZ/SPdXFVMy1YEJyY3O1Rut5B2zT7kBEbe96nop2AXReEul66GnuOWT2vXHDapdERmwcI2B+XPHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tMiNkb9OGMgk2l82ZyFQWFoSjbfuMys+w96lBq5efE=;
 b=mAPKWokNQBCzfrBezBu6E8nkmxfWxM0L1cUP/Tm0DzNYVLsHGwQmiwhwYN5Hh6Egt3px1wnmG/DOcPsJXqrkD7lPtn0B94qXJKIvk8arrDqHNzltGFLaFmjpQHS38sPJTFGmVWikaY/h7SLMWopKQYLabBr0VsSeyvZjxSjGFf6nIdmceTXjzDmbTQQLj936oTDjbo4NSGkGNIHRcV9G8LqWSEjQ82XJVmiRXSppJDd4CR5D1+6Y7lQR0r7nhQTtxHjp6i1UvzCpbGjZDams04lubLIvHM4bCz8Y6eYqVjs4KsbkEpJdh0mOsHhiZUeDQ4oU6GbllDH7PxwmR7zRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tMiNkb9OGMgk2l82ZyFQWFoSjbfuMys+w96lBq5efE=;
 b=ECs6Yub531le7lO8rfS3jx4s7KCjNv+JNqeDCLnCq23C+wpsFy831cogoCZ0DOQevYH5OqsqSJQawv1S5LTvQ2/hvwk+DqZUtIaoxi79UkxqYjpUeyHpPtMGrzV1thRM5fl44ErS6ba2Xl6oZNoGqbU8UJK5cYrGaYg7zucmE4k=
Received: from SN4PR0401CA0015.namprd04.prod.outlook.com
 (2603:10b6:803:21::25) by BY5PR02MB6388.namprd02.prod.outlook.com
 (2603:10b6:a03:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 18:29:54 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::5) by SN4PR0401CA0015.outlook.office365.com
 (2603:10b6:803:21::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29 via Frontend
 Transport; Fri, 17 Apr 2020 18:29:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 18:29:54
 +0000
Received: from [149.199.38.66] (port=57643 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVjc-0007Jd-3K; Fri, 17 Apr 2020 11:29:04 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVkP-000562-SF; Fri, 17 Apr 2020 11:29:53 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03HITn66009101; 
 Fri, 17 Apr 2020 11:29:49 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVkL-00055H-0p; Fri, 17 Apr 2020 11:29:49 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [[PATCH v2 0/4] Introduce Xlnx ZynqMP CAN controller for QEMU
Date: Fri, 17 Apr 2020 11:29:25 -0700
Message-Id: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(8936002)(336012)(8676002)(81156014)(316002)(4326008)(9786002)(426003)(478600001)(186003)(6666004)(107886003)(36756003)(2616005)(2906002)(81166007)(70206006)(70586007)(47076004)(6916009)(5660300002)(26005)(356005)(82740400003)(7696005);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e87c172d-464f-4087-9c12-08d7e2fd52e6
X-MS-TrafficTypeDiagnostic: BY5PR02MB6388:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6388F972008E6525DC6F4D2CBCD90@BY5PR02MB6388.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rOH4CpVa+Gcz2SW4bdoC20rLsv2dYVq4E+mWlmQxRHL/7bWGBjauRxUm/WCCOduVcUrFAi7JIKC6O1o2HhTH+zBM0ARowtG0J8bM6qpvT166xzbu0Jj5PLYvDrlHVsLa1BFgJhaVdXJTlG8iLKuegwYTyjPcrrnJmwJpavlax79dqsbHjZD1lqi+e9HZniaVrBSQKwBk6Wik771Yi2yxfaukilIhb/0+LJYLGV32oDaTHwX/k7ypRJAn1mJosvVRVYHE7zNN4TRefKyt1fynpbggN9oLkkpFfZ7IaaOPnjcfGOOcerPVCynMTKH/2T8sSz+2w3h6OpT8oIrN6p0F8TH23ZgnYIH5Li1LglnCJLYaBjZAfV0E2Lxp6Z7lP96VuTd2RDCjMXqCAm6tb+xeXuvJoIQHSvf2xWv+0Z/hEEe70Dl6jBAzZfLmUIzDEwgPUUZFvO/Kvkp1nc7QEwW47FoY9EVMbKIkc8bDCyN0GmgHtAN/SlUi2QpjdPIbe8VENDBZwxGdm2OSTuy/gfShg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 18:29:54.1612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87c172d-464f-4087-9c12-08d7e2fd52e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6388
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.92.78
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
Cc: francisco.iglesias@xilinx.com, jasowang@redhat.com,
 Vikram Garhwal <fnu.vikram@xilinx.com>
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
      -object can-host-soc

Changelog:

v1 -> v2:
    Rename the CAN device state and address code style issues.
    Connect the CAN device to Xlnx-ZCU102 board.
    Add maintainer entry.
    Add QTEST for the CAN device.

Vikram Garhwal (4):
  MAINTAINERS: Add maintainer entry for Xilinx CAN
  hw/net/can: Introduce Xlnx ZynqMP CAN controller for QEMU
  hw/net/can: Connect Xlnx ZynqMP CAN controller to ZCU102 machine
  hw/net/can: Introduce QTEST for Xlnx CAN controller

 MAINTAINERS                      |    7 +
 hw/arm/xlnx-zynqmp.c             |   26 +
 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1113 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    3 +
 include/hw/net/xlnx-zynqmp-can.h |   76 +++
 tests/qtest/Makefile.include     |    1 +
 tests/qtest/xlnx-can-test.c      |  367 +++++++++++++
 8 files changed, 1594 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


