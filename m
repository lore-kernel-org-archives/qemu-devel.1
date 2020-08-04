Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A492C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C2320842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EeqcmiZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C2320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k34Tp-0005W7-5u
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 17:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k34So-00050z-3K
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:27:15 -0400
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com
 ([40.107.244.48]:61600 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1k34Sh-00040Z-KG
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:27:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoLf8RSVVGRpvisTNUzqRrmH6Wykw4rErKRKzjL+4kc/mrXX83zoZI4eliUjc7u8EfTIaYtyBZ+w++P0lr1m2sns2lKrVB/wzLZ+SqwwZEeJA2God8/w/2WwfoweU2MOtOh+6jVLOI5Ra9nX8Wc8J0e/Q7KqppM//plhwpo3/YO8vKoFt1eu7NFXrXmghpdM7Cq9GLXh937FKIohpLyW6RKA/5LCan6cbX2mZdH4p7Zo8PlNkoFEmNN97Lepp0Jr9WeDM0uRi8IhdbI98tFXVggHB2s4FqbKRP+ivdc23/ninAbJp6nmxGqT4iviRXA9Ep7xfePZvhCZC/gNUR8bRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAcCI0kIQM8pB6ce7EnGxFJEAaiurYQ0M/VpjlSlbCo=;
 b=nlkrzJphXwPYD+pYZGjcZTenn2tatCbvdu/r8GR+dSmcCqTgkMOGURIdnIfP+GEDr6jBmD/Qi2lBSAha9P0pLYh+P+Pc5S7xLFVV6Q6uOuTbLjZM83hXtcy94nSXejJQCVlPMmxMT6PoGhaZucuQJoYV2HOu/LfdgdkjCVtsgRTRuMHXvkWv5fA8Yu2rhuq0IWpxoTVEkWMGpwXgAlgVli5dai6Ce5Ri4D0dd5aQLBd09+jcnyBW8rzpwHCXIZ3rVKMM2L9ehJZUx//Z1Ufsek1a7vcAYkgBqRfEfeThmWBL3/mpK2cONXN1dDdi8a/ju0Xug55l3K8oGISdcuyGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAcCI0kIQM8pB6ce7EnGxFJEAaiurYQ0M/VpjlSlbCo=;
 b=EeqcmiZ6HFX08R7vlwJW03DLsNwD1loUgLRb1g27B3aNsqzCs/XuvK4EqOVtRID7JGxAGUdLTmsX1awuJZid8BKkHub1/Oa5oHOOpdcEbC+v8hewpsEd5vVaa2yzwac/a8u0KEjwL+UkIv1/znRBxeTs+t446DA//K5uuvYAqsI=
Received: from SN6PR04CA0089.namprd04.prod.outlook.com (2603:10b6:805:f2::30)
 by DM5PR02MB3211.namprd02.prod.outlook.com (2603:10b6:4:6b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 21:12:01 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::83) by SN6PR04CA0089.outlook.office365.com
 (2603:10b6:805:f2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Tue, 4 Aug 2020 21:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Tue, 4 Aug 2020 21:12:01
 +0000
Received: from [149.199.38.66] (port=46687 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k34E0-0007xd-Nn
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:11:56 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1k34E4-0008MC-T1
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:12:00 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1k34E3-0008KU-0M; Tue, 04 Aug 2020 14:11:59 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue,  4 Aug 2020 14:11:41 -0700
Message-Id: <1596575505-163040-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ad59a06-e7e2-4f7c-91ad-08d838bb07b9
X-MS-TrafficTypeDiagnostic: DM5PR02MB3211:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3211296DCD4EF90DA9A83354BC4A0@DM5PR02MB3211.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e81eXSxgN4meHSqwaA3GbSVIVHepQgz8dvMBaRnPtQZJEJvYZHf6vYDxhHE4Myw23bxurOFsSeVMC+A/2QcrLGBPqTZm8wR7v7NYenI765oF9uERRZozIOSwGOnCoqaQhGd866B261Nk8SJEMvBTCJXzuc55vPZt5BErWK4ohuBC6mFfuQAN4mJzjWjx12OG2OA6k5s2zeko0qJJGhFl5eMBzNfOHdj8KTWEKbrOD7GxROTASma0+aEJiu4cpbkveO5nBxr16t8+kUjjY+XH7t6HsjWMgn1XubVuKkiApkDZrl/JIDmWQOvmSFEnSBbaxIb8zzpYWRx58Hs0iNZ0ViNJruTVHykCz/PHuBoGYn2TjFJ4pB+J1YrZ66NG3cfWa0NaiQtrWQpL54wQVHN2A==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(39830400003)(136003)(396003)(46966005)(26005)(186003)(5660300002)(6916009)(8936002)(83380400001)(4326008)(107886003)(9786002)(36756003)(8676002)(316002)(426003)(478600001)(2906002)(7696005)(336012)(82310400002)(81166007)(356005)(2616005)(70206006)(70586007)(6666004)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2020 21:12:01.2546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad59a06-e7e2-4f7c-91ad-08d838bb07b9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3211
Received-SPF: pass client-ip=40.107.244.48; envelope-from=fnuv@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 17:27:05
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
 hw/net/can/xlnx-zynqmp-can.c     | 1152 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    8 +
 include/hw/net/xlnx-zynqmp-can.h |   78 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  359 ++++++++++++
 9 files changed, 1662 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


