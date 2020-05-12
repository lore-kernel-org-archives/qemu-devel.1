Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34645C2D0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B30206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WPcpk4cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B30206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbZK-0006E4-2U
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jYbYT-0005FR-KU
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:31:09 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com
 ([40.107.220.44]:58718 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jYbYR-0008Pm-N4
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:31:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4J0B0kYRVyc2bfE5Nyfre/PQU+sx9pwEbDKd8XU2+f989bjdXXLv450TZhCCMthF+trqltzIr/26LpmBGR+s+uv0MkLEyNM6hx5tzeUUiteIoB0dovrOwIxGJUTp1KFLgTCQDWxpVOP+OC4fNuAj0X+IB4SctQ+NvSgukL48bamkP0F8lk00uQ+EMHaZobn1LX9BJe1VFuxdbmJwzP6XooWmI6teNxGkP2J1xjX2PL3Uy4KIVMihdE8Nl6++TWexO8xPGyt8f86fCire3lED/f61UQinCWKcIJ3w9EY4d2mTHxdkdhJWU/3lAdNSkk4mFfyPNjERIyzxcueSNc3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZwcxeIkB9n8lR/gdi/l8HrGAmtGem8GLJKNsQ+xD/0=;
 b=J9+/MvAGsesyJY1543SHgesrvKVgym9jhtucNBWasSXYw5MIJQuPJexYX8i3ULpa1IqXyZyOJpGp/Jy+KgwRKEMVzLGPqse63uSJu7UC+/P3/HamjF3lxGUdSbr2cGTTR2L0nZATyQOCyaSA2/2pi4bXGGINem0dGHhyBgudQxey2wSw7t1hiD7+fKWuONuj5uoqZG5kOmVO29GYbr03RAt87C5iU1o7XU1oBnhC9FK+hRTwysZ6uiF8ymVVyUwKLsRJIERmdsRopsY3L379gfWMIE7uwczxOcwybEYCqpJBZThosWYHzmt1dNfkP7btW3552d0dDOQjv0ieGVCmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZwcxeIkB9n8lR/gdi/l8HrGAmtGem8GLJKNsQ+xD/0=;
 b=WPcpk4cmE8AxC/iQlmljiivDVn1PeoogZt6U7+VBULwm2Hcv7Jp2bsAmutubWZEvTMESioGvVkCCHurZznVRbJKYioLPs5cUuZZ1Ec3R78YXGKklqp5nY2+d9z5q3s5J+NMODgEkuhEx2B5+DXJf1dgEcpCWb1PaD/WdTMaHQl4=
Received: from SN4PR0701CA0021.namprd07.prod.outlook.com
 (2603:10b6:803:28::31) by SN6PR02MB5549.namprd02.prod.outlook.com
 (2603:10b6:805:e4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 20:16:03 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:28:cafe::33) by SN4PR0701CA0021.outlook.office365.com
 (2603:10b6:803:28::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 20:16:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 20:16:02
 +0000
Received: from [149.199.38.66] (port=34761 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jYbJZ-0000UN-HN
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:15:45 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jYbJq-00062i-5q
 for qemu-devel@nongnu.org; Tue, 12 May 2020 13:16:02 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CKFq8g021434; 
 Tue, 12 May 2020 13:15:52 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jYbJg-0005zy-8y; Tue, 12 May 2020 13:15:52 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue, 12 May 2020 13:15:48 -0700
Message-Id: <1589314552-1375-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(39860400002)(376002)(346002)(46966005)(33430700001)(9786002)(8936002)(316002)(2616005)(33440700001)(6666004)(7696005)(356005)(478600001)(82310400002)(81166007)(426003)(36756003)(26005)(186003)(8676002)(70586007)(70206006)(6916009)(4326008)(336012)(5660300002)(107886003)(47076004)(2906002)(82740400003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14d9b7e6-9e3f-44c2-6053-08d7f6b14b0f
X-MS-TrafficTypeDiagnostic: SN6PR02MB5549:
X-Microsoft-Antispam-PRVS: <SN6PR02MB554927F3C1F0C82C005FC97ABCBE0@SN6PR02MB5549.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uWfXZuKYCgLUgjPKR6jeJXUSkbhy/T4Twgad1T5usMooqsOVbCSw5WVXQJqeKgAlqBUjyOZDgWJHfqdRN8DBY7Ndy2oXkBF7LSg9oPSpezca6058WBHj0jaT+TeW+CHqlPTC5+FqnAieuGKqCVZuga/iIk4d0OdQoPKNfmlbdW1Wte4aa+82CxoGaqMfoOJmOBwnqyJLk0KYFJ521piL25DkwT/klqO/yUZfmhUdpsoNJjPAxnLzCYt7smu6RxEK+69LIxjOq4kyocGElzS7hJvbKzK+zyrqM+yMF/jKLryASqxF6+jr18f0IcvAU25izronlo0T/MKqImWMqJZzRUCYJnJHNme2cG2H5tbyZXmvY2RIvuVeYeX+NDw/IM+UlEPKIF+W6D28jF7RJkZIr1ql6D3C65xmpSl7SO7tYP4NxxnElzYyaojczrMP9AbxkYavBknaKbYhyvgePHtnq9Km+NOM6SzaCTmcwRQHWX+kHcjSLRxK3ENZyUgrmMYLp2Y+OGZo/T7BzS+zWoSrN36shrCIgyDVF4Zau0WK4X+0Q2Pdl94OSydkM0niXLKfiC3Bu7QftqLEPEMzYM8lw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 20:16:02.5037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d9b7e6-9e3f-44c2-6053-08d7f6b14b0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5549
Received-SPF: pass client-ip=40.107.220.44; envelope-from=fnuv@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 16:31:05
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
 hw/net/can/xlnx-zynqmp-can.c     | 1111 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    3 +
 include/hw/net/xlnx-zynqmp-can.h |   75 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  367 +++++++++++++
 8 files changed, 1593 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


