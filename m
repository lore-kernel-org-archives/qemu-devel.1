Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADADA2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IjyCLlh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADADA2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXsI-0007fj-V3
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1joXrg-0007Ft-4I
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:48:52 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com
 ([40.107.244.44]:37083 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1joXrd-0007Fd-NH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 15:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAhCWpe6X9IfRz8vFhcYpnAFgoYROXlQTal6wNMOZWWW9SsbwZ/1j20boGiTsAF6j2FcK1q/lPHv2T/R7n5X1WicQN3NjLJ0oofjAcwHLg5wknVCrtR+tTB/EbWqiB8TsLA5aW3U2SxxzRrGpVm4YxOhJBMCJOP0fL/mI6OlhLtjkEhyRHZh6t5L+GfRxumSwB+QOR+0jgbQozGJxm8wbkqJ0bUA7SJWdaDAwZSPgT4q4BGnoOvVZFwf+8fEymk1D86P5bStjOuJq25u/xEgRsUTWrEy0zaAlMKXauNX+CAdkjox0UNNxCc+RWaf/KVEKp/lS7aBJVozjF+yzJHB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CChF7qKlFjdqgd6NLQhIQbkkE6USdf++3WbkaRB2aH8=;
 b=JAPWL5iLc5iIRM8dVK+weKpIWAxbwt1TePez9WPw3fY5Kyp/a34w+PS7xt8qW8+kpOzW4q6eyc+xM9OG4cKJN7GqTP6ygax+B8OCRcz6bm0SqawMqR1g3LRq9W7PEfVNfoeTKySPP/Eek6Jg5SZLWrjwzhatvjbgy5U+s+NLAxAXOtroPD78VfZhes2V5Ybx9LJWBY+jh15UXBwBILg8USKGIOJh3sBTRnbEiW/Qo0So62dKA54mqEjUnOJCLkjZWTygqQAHqe3zsIlr9DPQOxg8TtPxLIi32BjBrIzUUHbg+G9uhnx4uQ9oQXnL3sv0CAixcOLt8nO5rESN6TIslg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CChF7qKlFjdqgd6NLQhIQbkkE6USdf++3WbkaRB2aH8=;
 b=IjyCLlh6AmDLkp6q8e5gzCNbUIVLgQ5eu5ajMDRfQrU0ZVRDTwHhrjcaqV4MX3FWGbFO5EmK3zAo0c/C/u2qcBrhknHrZiGGvnYaaUjyV75eq9HDwK4Eh9cExppLZZrNyTbn50jr6uFhYFaLJ4w5Pd1M5XZRctVewOeUV3dsyyQ=
Received: from SN6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:805:66::15)
 by MWHPR02MB2253.namprd02.prod.outlook.com (2603:10b6:300:5c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 19:33:44 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::5a) by SN6PR08CA0002.outlook.office365.com
 (2603:10b6:805:66::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Thu, 25 Jun 2020 19:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 19:33:44
 +0000
Received: from [149.199.38.66] (port=50560 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1joXbo-00080h-1y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:32:28 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1joXd1-0002wM-ME
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:33:43 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05PJXb6U004890; 
 Thu, 25 Jun 2020 12:33:38 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1joXcv-0002vc-RN; Thu, 25 Jun 2020 12:33:37 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Thu, 25 Jun 2020 12:33:23 -0700
Message-Id: <1593113607-321118-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(39860400002)(136003)(346002)(46966005)(26005)(316002)(8936002)(186003)(478600001)(2616005)(7696005)(47076004)(81166007)(82310400002)(356005)(5660300002)(70586007)(6916009)(336012)(2906002)(9786002)(82740400003)(70206006)(36756003)(4326008)(6666004)(426003)(107886003)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ea88239-7106-4f6a-4140-08d8193eac2f
X-MS-TrafficTypeDiagnostic: MWHPR02MB2253:
X-Microsoft-Antispam-PRVS: <MWHPR02MB225332E99C3579CFBA888C74BC920@MWHPR02MB2253.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sghBRISfH4NjjsnXHilokNnIDUP/3UAQ3+9Bi/B+/jWFy3FA7SSWePoflP4VeXxck3UnaX0jYoNd4RqVqaN0GjIVOrEWSej0WAnTYlUO5el3T+s1Nxtgy7uejMZymV6OmPa87TEBg2luAXSY7GZfQXoHJ6RDV+t5pRn7BkkRvWLtXfWbqps/QnP2BaMWNAIn4iF0IAf7fTBeXJn+Jp8ySEr0YgmhSfA8ai2rjiurt6MYKsQtIK28XS62mnxdt3j+2qrvht9V+5uX/h0pC9dIr8hFi5Nzp5J7xYksxnRe/v037rFz4Bpaa1B7K7EYajpxBtEZ83y4KE3+O9MUAMeZZw4ejdwgoRuEvNtp0QCQ5sSBNNk6c+1eODjhi+eFaehy8k0GAbtZJoIL9NTtAjX7Ng==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:33:44.0220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea88239-7106-4f6a-4140-08d8193eac2f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2253
Received-SPF: pass client-ip=40.107.244.44; envelope-from=fnuv@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:48:47
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


