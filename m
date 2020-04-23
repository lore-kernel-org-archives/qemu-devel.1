Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870DC55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FDE2074F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 01:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IXLvHy+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FDE2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRQPf-0004Gs-OZ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 21:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQOs-0003jt-21
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 21:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jRQOq-0006PO-VJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 21:11:33 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com
 ([40.107.94.49]:12760 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jRQOq-0006GN-D5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 21:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrNc0mOQbSNMETCYdV1xX5BPexenKmuRhfLOWAq9lttVLjZJJggyXwQCNVV2FWrhuibIoFhyfWo1ud99GwljU4fz+j4JM2B36sqpfz3SuENhr2ffXwUyNFKZWN9/nspy5JxSxxoc/jROVgIzoR/NT6/KBPeL2gTigi+jhBpo1tb9W7OCyRVDTMoMDs3CtqUlEATzezDU/yMmdAlfvW51dvQHr/mnKRfVLT/sjE4vJmhffsx74TCRCvREOZNTOVswu/IPdIzcdhU88DxAASJ3Qp+x9JjAy1bQvwic7q49Hz7arGheVMUaoBbVFReH++knxKmmKG/XD6Sjf4iS+4b4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luGqGX5buupRad561VGOWmLlvpek4djHfbcGtgceNqI=;
 b=EOG3E211BmYZ95NORXgXGmvnksoWrgBmz2yfKRtmY3CaDP6DeM6gXAg7oMcmxiKVv1Hc3G60MxAS3irhFeDQWlMXCF03JYtIUMA2i95hO+p8RTrJPz965CCpMCb7pn4+Yo/1DkNrauC4Te9baAaEU5MWkxK6sgmiIsbjG8yem/XyAzS8DGdf4+eLrGba23OmNMlzIyaskjCR0kGw71Z5koNfrcN9YSUdWd5lmF3BHHHId7WoF2zCTneDsfH0EAP1AiWATbfJ202judmSFQtfni9ZW3qU+OwxXlqfucQwg7AYse8sm2OZGCgZcEEZju0sE1V82H65rED0ttD3nZfoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luGqGX5buupRad561VGOWmLlvpek4djHfbcGtgceNqI=;
 b=IXLvHy+6CdxTcVflQl/pj0ECfqEa5mHFo+0iVWPlVuRu+aUiKv9/EKEFWYFYO8LDkjVPTO8sq9kqgR8bbC/zWmgIJNuNZ4YvYSVNTFCJZ0/fCkkK+w6FrvSJKc/BO7w59OWVBGa74PA/fLBH6vQkrbfpKbOCtXnzPzkzpgt1bpg=
Received: from CY4PR06CA0057.namprd06.prod.outlook.com (2603:10b6:903:13d::19)
 by MN2PR02MB6062.namprd02.prod.outlook.com (2603:10b6:208:1bb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 00:56:27 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::2e) by CY4PR06CA0057.outlook.office365.com
 (2603:10b6:903:13d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 00:56:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Thu, 23 Apr 2020 00:56:27
 +0000
Received: from [149.199.38.66] (port=51566 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jRQ9B-0004I5-BV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:55:21 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1jRQAE-0007ot-Q4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:56:26 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03N0uOQk012536; 
 Wed, 22 Apr 2020 17:56:24 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jRQAC-0007oW-8y; Wed, 22 Apr 2020 17:56:24 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Wed, 22 Apr 2020 17:56:05 -0700
Message-Id: <1587603369-14644-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(7696005)(426003)(107886003)(2616005)(82740400003)(186003)(4326008)(47076004)(81166007)(70206006)(70586007)(26005)(336012)(36756003)(8936002)(6666004)(316002)(81156014)(9786002)(478600001)(5660300002)(82310400002)(8676002)(356005)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467ac83c-9c4f-4fdd-e73d-08d7e7212704
X-MS-TrafficTypeDiagnostic: MN2PR02MB6062:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6062D4478C7C3F056BB4375CBCD30@MN2PR02MB6062.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNXdiM3wEFZoUK4nU/tkz2AANUGBCUkfT0bBTsBwJFx6otZHcOta8IyNB2ryUtaqr2HZ3U1PDN/+EuDKrSgb5GNtx9KiBFVGzR64G5uTLcHNVo8na355/kU9OpDzQlQIjRI03aAIscqSfr3aE2/9/0NFHxHPJuo8ORGyZkKd8epDS+RtSlaNAyDq5/r8GIGRg2OXA/99DuynIR2OWzNrfJudBOwuzdoDk62gS4ebfeUF++6+wTjRsN0Rn5Ldv4ssEjPB5pkOsiBFRlKr3cH0E+In3uTNhCgmfkf82Juu+M2jGKW5yEEWfa1/lz0Su6I/RUFHJVQbuszEWUnGc5asjCmASNJaPY3IDz5TELiUTt+D9M3rzI31vpiUGUb+E9myUaZ8CD66ljGf+kp/wBAoGR/UO263G8CnuTzPnXBzWaNDmtpQ7Y7Oib26BBDqauBC47sUnAIvwu3Ll+p4kc8Pjlv3Ebw+pqMUbLWguEF19/2Jtlf80MFL9crAC1ExmgyixRpBczoC5hkcsLsBEq5ptw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 00:56:27.0754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467ac83c-9c4f-4fdd-e73d-08d7e7212704
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6062
Received-SPF: pass client-ip=40.107.94.49; envelope-from=fnuv@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 21:11:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.94.49
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>
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
  xlnx-zynqmp: Connect Xilinx ZynqMP CAN controller
  tests/qtest: Introduce tests for Xilinx ZyqnMP CAN controller
  MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN

 MAINTAINERS                      |    7 +
 hw/arm/xlnx-zynqmp.c             |   26 +
 hw/net/can/Makefile.objs         |    1 +
 hw/net/can/xlnx-zynqmp-can.c     | 1113 ++++++++++++++++++++++++++++++++++++++
 include/hw/arm/xlnx-zynqmp.h     |    3 +
 include/hw/net/xlnx-zynqmp-can.h |   76 +++
 tests/qtest/Makefile.include     |    2 +
 tests/qtest/xlnx-can-test.c      |  367 +++++++++++++
 8 files changed, 1595 insertions(+)
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 tests/qtest/xlnx-can-test.c

--
2.7.4


