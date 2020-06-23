Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78085C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB3E20780
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TpB3WtkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB3E20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsYd-0000vn-7W
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsVM-0006dv-Bo
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:39:04 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com
 ([40.107.244.59]:3296 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsVK-00016I-5N
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU1V5Eg3QAAq8xLL6fGCUzJMD/I48D/Bfi4oqfgtRmNfTDhqEPFWAhlY/sutmE/LRFqj5nDSp2CyWE8uno+U8LSnD6yINCOTCA+P5c+1oxFfwWCjlGcIq2XKmu/lLXuZHHsOQyEuldlfRmLJV7qE6d2dK1aIp/GmyO7/SYGquxHQFWwQbrL7F027dZFG4cNzzs/OqXtOGyCCZ0frd99/bJ1bxW73QLj6PWze9fxgAXLqtZZC2irulQ2EJYAKwVl6Hj3CFrAWXLckEs4oo5VYUjPilMm3Ec2GJKsWgwuzuUqqgmPTq584O27/uf8szkjYv1WAcycA82/WUqCyfpLSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZQjnrZLPV6paKUnLIvRVB7x1LniQ+jsId5NE3l+yjk=;
 b=lrbFA8IsRlKbdz29aQXOXGhG3sGM8ex7E+JgaozK7/koeKL611xeQ1DEFLX1KqTAInRfb8JAJoQ7ys0J6A/qh6me8E+N2tUZL08RPS0sZDOEm5kApeq+HKYVC6XzWMRzb2niYkPrzJ1mhsOmrGD0dRQ4kM5QN7KpRsZjvEYcvGRTM9HEs+E9x6+gHlXJG2mP/5UCXfja+MxPU2L/LOzVWY2D0m6Rah90yQjyYSRhGOoL+36D4kk4rD6Y+6GqmCSxvNvb9uGhA80QyfNEOQEd69sjZRpJ8nkJO8OkNJY7Hgr6VzvF76vMwnREgB92nhiU/kgMgyUo1wbOtco/NGCaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZQjnrZLPV6paKUnLIvRVB7x1LniQ+jsId5NE3l+yjk=;
 b=TpB3WtkV7quea0gdCg+a7jK81b9yXnEPGzid7+rdbxGHy/BIkDngSueavkuLPZdGJVveIVfIAz13YTM2vN5FMVlpQRXsdf/Wi1vbFlPCYyHZVxpXCUBH/SE3I8FEY/TvbAZh0Vu2GKC7s10PTFJDrnBwlbhF+8zzlVuWoOxN5Ec=
Received: from CY4PR18CA0066.namprd18.prod.outlook.com (2603:10b6:903:13f::28)
 by BL0PR02MB4387.namprd02.prod.outlook.com (2603:10b6:208:45::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 23:23:57 +0000
Received: from CY1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::63) by CY4PR18CA0066.outlook.office365.com
 (2603:10b6:903:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 23:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT047.mail.protection.outlook.com (10.152.74.177) with Microsoft SMTP
 Server id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 23:23:56
 +0000
Received: from [149.199.38.66] (port=35686 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jnsFX-00009R-GB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:22:43 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jnsGi-00084l-JM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:23:56 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05NNNs2R019028; 
 Tue, 23 Jun 2020 16:23:54 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsGg-00084e-1k; Tue, 23 Jun 2020 16:23:54 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue, 23 Jun 2020 16:23:32 -0700
Message-Id: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(39850400004)(136003)(396003)(46966005)(83380400001)(82740400003)(36756003)(107886003)(8676002)(26005)(2906002)(6916009)(316002)(47076004)(2616005)(186003)(82310400002)(6666004)(8936002)(70586007)(5660300002)(478600001)(70206006)(7696005)(336012)(81166007)(9786002)(356005)(4326008)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 678bdfbc-4722-42be-b450-08d817cc806b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4387:
X-Microsoft-Antispam-PRVS: <BL0PR02MB438784C64406FC1385AE920DBC940@BL0PR02MB4387.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6q9PtPe3Hq+nsusWUDYPMbQNCWrK3xOrtdNonPsn+oC0+cbUczOl67OKqEoRP5pMvqdMowUfO3uUto95x+gHa7HS6eeXoqFsVO6ekRBqc2dNp33+UHPFT6QcIBUgIlVhhDddVvBX3l/UNScciWXV/+G9HQQvks4s0iiURykcyvxIwk2Kf0HXjQ6sr/g1uZnuCMV/D2cpW3iCdwrCSYfQXKvjfE1j2cKg6NtUzCVkoumFMiUwqlttuuCn0ih1Zd9nEJ1Rq2mpZJA0+nuI/4kmKZb3WkYsuyjdJe/Ikoe0rvPo32lp00fbiunVO4PHTb5h8+w4d1mpTXN13Q01z6dq8mm/doZVmexqoGrhCWbzwxeLm7eBBCG5Ccndc9IUc9jqwypBBXaVEduj3JYdlsCbw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 23:23:56.8214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678bdfbc-4722-42be-b450-08d817cc806b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4387
Received-SPF: pass client-ip=40.107.244.59; envelope-from=fnuv@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 19:38:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Changelog:

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
 hw/arm/xlnx-zynqmp.c             |   28 +
 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1163 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    4 +
 include/hw/net/xlnx-zynqmp-can.h |   79 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  367 ++++++++++++
 8 files changed, 1652 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


