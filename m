Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AABDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68470207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 00:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EBQu/b+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68470207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k61Ax-0003te-M2
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 20:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k619d-0002Qv-EG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 20:31:38 -0400
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com
 ([40.107.243.57]:38983 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k619Z-0000bO-7s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 20:31:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl+mFV+9mlSgfAFutTwR7kHjWeW3h0IJ6Dzoyr40Twwj5BjJ5TsVqmrOb8GkypFG6bTcezFUlWj+bG6d0dNhTpvG/bAV6XB+N3jgRFk36GqAOw+1M+/jr0R9Qkpb7BkAwK57uV+M88QH3RSGT9BrwWR9S8RDjmjsSXnxDbAGBt3wLFPp2SKdfAG13Lwc4HpbiaMfIPaklh5BosCQM7rNH6x7hvI8xu896pdKctT2Oh3glKUQskgqDqkND1h+3JOoRLURLdHceFqFBmA+Q8mMtulYXKCKykkjPYgPgPj2SY50DcMgiqSA7deJ+xbUgqbvBhdvnsVVx3yV1bg8heYspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4bU/P0757RU2BIV9V6EDPHmvu4qjb2Kg0E+sfeCRfk=;
 b=DmTexmj6FoHdblHYsGPQTVd8o8sBZdWQDEapluPy/UkecMl+t7ko4BNAVmwhPknxwyMrClCcIBKiiw3im4+Y45y4z1taF+LEDhJD5DkTUHS7esA8j9GdOLkzJxJW+35tdSdCMgqBxzaGzsBFFl3CAO7/6qNuRe7otFW4E1EK7yuWmWaOzu86oUqL2cied4OvSAvVAr2v1htkFtfPbMGenu5n2Mi4xeA9K6zE0sFIsMC6y6zGYso5JVUF1e0k/1fqy20uApAiyZwOyivgTHm7zT55hvAp9u7W2FO60VX9Qmo7Jyxznnnx9avjXC8TXG5afYColMj6JGRg0B1PzEQ47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4bU/P0757RU2BIV9V6EDPHmvu4qjb2Kg0E+sfeCRfk=;
 b=EBQu/b+O0ymAFf5hWme5Me77vSCK+gukS00ikXHwwgJYMXa8cu1S1OxZNnOV6+e5rY3JfEDjYBBtOLwigzgZ0v52nAgulgrUbG81OhQ3W6ZYbKI+Euh2aYyy6a4be4odqsXVbJo+uiSR4PjEGMQGzmtVvMs7kkJ/+eSJN94SYlE=
Received: from CY4PR01CA0008.prod.exchangelabs.com (2603:10b6:903:1f::18) by
 BYAPR02MB4471.namprd02.prod.outlook.com (2603:10b6:a03:56::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.25; Thu, 13 Aug 2020 00:31:27 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::60) by CY4PR01CA0008.outlook.office365.com
 (2603:10b6:903:1f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Thu, 13 Aug 2020 00:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 00:31:27
 +0000
Received: from [149.199.38.66] (port=57235 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k619J-0006yr-Sn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:31:17 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k619T-00080l-4p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:31:27 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07D0VGGZ029492; 
 Wed, 12 Aug 2020 17:31:16 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k619I-0007xR-GO; Wed, 12 Aug 2020 17:31:16 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Wed, 12 Aug 2020 17:31:04 -0700
Message-Id: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32cb5b78-e1b8-42dc-255b-08d83f203761
X-MS-TrafficTypeDiagnostic: BYAPR02MB4471:
X-Microsoft-Antispam-PRVS: <BYAPR02MB44710AB7B834AAF6C6F28589BC430@BYAPR02MB4471.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7lSjecV67gqywvLg6XVHCaCQYui1t+DYeLwiWchEkRwHozxMoTrsp8OV3zYPCiCPoTwviM8PLqzsD7/TFT5ZVoriWtDXNAvjS+TXps0/YL+GyTezd+Qe1rJc2LKgEsmVkdqP7lHMGg2jpLjGxW6fml22fvX2UpZV3/5+fzSmyw3ewfrWSx4gfW/f4+8cp58CAmu7BiLT8e0PYQM9xQfu//TNkaZODcvO2etNp6VO0ieM+RF1Mm+Z4Z/vi6lWoArzfuF7MzmkS1azw+YRtnlKyJWAtbix73Ay9ig4kxsSCIgbtG2nhLTTOLx1siHH1up4gYyrDU0JVBOWzjesP6H22/bhpnZ9TnzY54rC9Gmsob4NP2Fny7ML+AbaaOFT7fUlvR1Lpr6ODFDk2hh2GG+eg==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(136003)(376002)(39860400002)(46966005)(70206006)(26005)(70586007)(36756003)(2906002)(8676002)(4326008)(2616005)(186003)(5660300002)(83380400001)(7696005)(6666004)(47076004)(426003)(9786002)(356005)(316002)(82740400003)(478600001)(107886003)(81166007)(8936002)(336012)(6916009)(82310400002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 00:31:27.3521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb5b78-e1b8-42dc-255b-08d83f203761
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4471
Received-SPF: pass client-ip=40.107.243.57; envelope-from=fnuv@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 20:31:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

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
 hw/arm/xlnx-zcu102.c             |   20 +
 hw/arm/xlnx-zynqmp.c             |   34 ++
 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1165 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    8 +
 include/hw/net/xlnx-zynqmp-can.h |   78 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  359 ++++++++++++
 9 files changed, 1675 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


