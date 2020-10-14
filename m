Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159EDC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D447221FE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 06:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Gn+UQKD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D447221FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZsu-0004Ku-Fq
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 02:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZrD-00037I-Az
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 02:01:51 -0400
Received: from mail-bn8nam12on2056.outbound.protection.outlook.com
 ([40.107.237.56]:11872 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kSZrA-0007et-3s
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 02:01:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcGgan51xb6KsgHbz19T6BP4qGS2yndBkujUHLYRQGrrIWGVIDthW5a73RPrNv+Nk4eu+0kCEYnVoAlQg1nwRnvHJyQ+T9nXEHMHTUGzfEBQTnTkl3o44Z0MpGAyOZGPwxaBtnrS5OgafAIGa2I1MEGEadRHGGWFBNEHkm6+gEN3Y8BC0u3+GWCs9Kugk64YKt6VXHVZ0ypln7f7Ql//bXl+5x815LXbTxb+PxZIpJa6sXyxV1O9ZXdphBweLESXjyZvZWSZCN6tt6E95J210yg/PuHlOeCk3wt4uNxxThAFvbjzCzd1zpxJXFc5OWBHZEGMXwLtfDH4NUqak/bVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnprlbqsY2MjYdFTTiXLIAZuyWYcFhoHOxJ5sSxnN08=;
 b=gcDFAUkY13JJvr2G8lWszh5rMZBbEdIg+9m8rYFR8+URs+tC4GQe+YTPgMTkg6Ph+LD4dktPcfhmOUMoRzsSW15w+3XkhIv7PmzNSaBXzJwsX+A5wCkAlS25BABN/nLcxgxa1kE26SKZI4Mfyr9A82YoMwIxc9r+smzD2/DF9IRcTbwsZNtqlB5f6uhSRm1aATJAKzwIx9b96kkww9wLLsBdx4d3ORhUWi984jaKNDo0HvqUJjRZJ0CAz3YOMQ1EDSgjrK+AF742JQw4XqH1C4YQ08UUZa/hUFuVgd5reY8ywYaruGxb7V0QAMduHlf2BxAKJc/N7HzpZFXQLLhQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnprlbqsY2MjYdFTTiXLIAZuyWYcFhoHOxJ5sSxnN08=;
 b=Gn+UQKD+I51G4OmDmBJLn8A72kkXcycHySqA5avo06OaF/L0w2B9XBsiOoxZ2CJl4P6zkp+4kTpIwnQkpKwLzAz8eG1NrssXEm0iQ6S+pQfMGcKE/g9CnRlhd/BRQZa6kW55MOOrPC3PvcK1XzMnT20t29ecbh7dKzNBDJuXHPg=
Received: from CY1PR03CA0028.namprd03.prod.outlook.com (2603:10b6:600::38) by
 DM6PR02MB4154.namprd02.prod.outlook.com (2603:10b6:5:a3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.26; Wed, 14 Oct 2020 05:46:41 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::be) by CY1PR03CA0028.outlook.office365.com
 (2603:10b6:600::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend
 Transport; Wed, 14 Oct 2020 05:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 05:46:41
 +0000
Received: from [149.199.38.66] (port=54704 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZbn-0001ad-A8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:45:55 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>) id 1kSZcX-0001oH-Aq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 22:46:41 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 09E5kb7e003867; 
 Tue, 13 Oct 2020 22:46:37 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kSZcT-0001nf-2s; Tue, 13 Oct 2020 22:46:37 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 0/4] Introduce Xilinx ZynqMP CAN controller
Date: Tue, 13 Oct 2020 22:46:33 -0700
Message-Id: <1602654397-35162-1-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 53b3c821-4b57-47e5-b6ab-08d8700486b8
X-MS-TrafficTypeDiagnostic: DM6PR02MB4154:
X-Microsoft-Antispam-PRVS: <DM6PR02MB415446B86E581A7A4CDCB110BC050@DM6PR02MB4154.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6J6CjIloSi46c0VADhZuQjk/qmP07ccJzNqIMQenQ8i/F6BA96lvLhsHCeNnIBwgw5U5phym8zKuTUxqIwplJiPsjPrLuG8mOqzU/ue+tU35XdbYMYQexbB13OP/ImsJg9uUsuJZvmuD6cflOir8dJerT0mlhGMqh0DdxUzYWKFRBoenZ+XcekrDqS12t7FYDNv6yZVDf16A8qU/FFTNMD/+VGgWHtFNPIaLHvC0vn3CSi9c4VR7nbCwYCINnuhDwfAEAbTpCwEBCp/mixzNwdhdDCU76MtTmybo2grCEIDdtMtovnnusH3ZN/X771xKhhpqo5WG69FCbguyVwqYzQZjgQxLNKE6WAL/Lt6IQqkKGunTZ8LEyGEFk0t1V+sF5rum7N1DI0yXUanvTkXbwaApLSTIc0vLsFVNCXm09gM=
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(396003)(39860400002)(376002)(136003)(346002)(46966005)(26005)(82310400003)(8676002)(36756003)(336012)(5660300002)(4326008)(7696005)(9786002)(2906002)(83380400001)(6916009)(82740400003)(186003)(356005)(316002)(8936002)(107886003)(70586007)(47076004)(2616005)(6666004)(70206006)(81166007)(478600001)(426003)(42866002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 05:46:41.5337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b3c821-4b57-47e5-b6ab-08d8700486b8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4154
Received-SPF: pass client-ip=40.107.237.56; envelope-from=fnuv@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 02:01:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:

v10 -> v11:
    Replace DB_PRINTS with trace-events.
    Removed unnecessary local variables.
    Added const with tx/rx buffers in qtest.
    Added reviewed-by tags for qtest.

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

 meson.build                      |    1 +
 hw/net/can/trace.h               |    1 +
 include/hw/arm/xlnx-zynqmp.h     |    8 +
 include/hw/net/xlnx-zynqmp-can.h |   78 +++
 hw/arm/xlnx-zcu102.c             |   20 +
 hw/arm/xlnx-zynqmp.c             |   34 ++
 hw/net/can/xlnx-zynqmp-can.c     | 1159 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/xlnx-can-test.c      |  360 ++++++++++++
 MAINTAINERS                      |    8 +
 hw/Kconfig                       |    1 +
 hw/net/can/meson.build           |    1 +
 hw/net/can/trace-events          |    9 +
 tests/qtest/meson.build          |    1 +
 13 files changed, 1681 insertions(+)
 create mode 100644 hw/net/can/trace.h
 create mode 100644 include/hw/net/xlnx-zynqmp-can.h
 create mode 100644 hw/net/can/xlnx-zynqmp-can.c
 create mode 100644 tests/qtest/xlnx-can-test.c
 create mode 100644 hw/net/can/trace-events

--
2.7.4


