Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3572BC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF36C206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 13:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ciRM6XNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF36C206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUpn-0000pC-1m
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 09:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnr-0007T1-IF; Tue, 12 May 2020 09:18:35 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com
 ([40.107.94.64]:6145 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYUnp-0001zC-Sb; Tue, 12 May 2020 09:18:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXtmw2Ai4+YF8rY62GeRQUq/mPfgHX8ccTP73m5C+mSFOS0aH7gStR33T2fQIgVh5fREHSmIyxosCqcZVsIHm4BspjyEASp/TqcKC+j3IbfaJnpqBFA83dgN5ug2T+OO/EhXfRDDvUAn5Y9gvon4S+gk+6WB3RQbPiL/JzGgp8arn2SWNGYiP7ARufNI+64E082sEC13NsUnkFYLuCQulb8CestyyacJghuA7oWL3fL5EJ50HcgpWI50NMqhF7uUJA/21lmWSLPsEEnb5Tw5ZEtk1Gzt34XJcyzahtKW0Rz/g82n7pCTTmKYCxqRYLRaJWBBtX4YR2tWtR/iBOslEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXNdFxGW0sTf0/7o7k+pawDvfv7e8b/Pzl6aIVb+bJc=;
 b=Zj8ih787s49o2VCsaLxtq2rs3IYbG15IzuROGVYgBv7vQS533fJAnHIuZKdnENbafwfZ5Kg7MDBOArMHGnHA0U4bLwe8vXd0s50X6N+5tvqsb5W4y4OdHouQbktvKEdPstW+VXk7V0XXbaCdVOHp9hqNwkUN6MAJBsyNBHhIXLwn8ZAEo7+B4xrRr6kuqpXJPGGv+/9jfFzCDM20cwiOL4ZLSj8lMZj5lcAQtxt3A/trz0piXgNnW4/0QVGz/4f4ouaDU2aUS69aon9ooJ2O0eGiMMbHy5/d7x7aVScx8b3u+XC1JZ2RAc8DT1qnT7oHkOcryCRS66ttJX0EU9WO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXNdFxGW0sTf0/7o7k+pawDvfv7e8b/Pzl6aIVb+bJc=;
 b=ciRM6XNtJ/5bFtUte8Abm8gziEWU7GBFOwMzmf3YnFQobtuqhDCGaqiEejNxanBTuBMfLxhbeOQBMMkewvEgVlhmwTekv11F+oCu58fEKnQo0/ne8cuJjc2OC29Mx6D4yi38lxtXVcUzB2mpZlEAICUR9IRxhzCyfEOfruyLR68=
Received: from CY4PR02CA0040.namprd02.prod.outlook.com (2603:10b6:903:117::26)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:23::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 13:18:29 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:117:cafe::2e) by CY4PR02CA0040.outlook.office365.com
 (2603:10b6:903:117::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 13:18:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 13:18:28
 +0000
Received: from [149.199.38.66] (port=47602 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnU-0002QD-6K; Tue, 12 May 2020 06:18:12 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYUnk-0005Ya-DM; Tue, 12 May 2020 06:18:28 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04CDIR8q016830; 
 Tue, 12 May 2020 06:18:27 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYUnj-0005Y5-4z; Tue, 12 May 2020 06:18:27 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BF24913C0168; Tue, 12 May 2020 18:40:23 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v4 00/12] Cadence GEM Fixes
Date: Tue, 12 May 2020 18:39:55 +0530
Message-Id: <1589289007-23629-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(376002)(346002)(396003)(136003)(46966005)(33430700001)(110136005)(8676002)(26005)(6266002)(478600001)(42186006)(316002)(4326008)(426003)(186003)(2616005)(82310400002)(8936002)(81166007)(36756003)(47076004)(356005)(70586007)(2906002)(33440700001)(5660300002)(70206006)(82740400003)(336012)(6666004);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ddb9a21-04cd-4e63-b64c-08d7f676f5d7
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4332580DA4E19B0D7F55C803CABE0@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMb0MyNloREmBeDEXYCWOtDDfhSQ+N1MnwDISp34xtpvSn2MIEbe7Dmt/YgTqRJoVvANqiJor8aroMGT/mMqZT4+jRR1F9P4UilFX+5D3KKmh3CbLectkozbwszvVpUsarhCtMKD6qYlZbwhHajqWC2QQvgCkuy/why+KHU1m1PYrR1yNm9zVXJokAD/mP/R08GjdX8SsIW5x6OX7Fs5FVRiKZxrYQp3P0MMrTWJRBBiCIOh3ksXr9uDYMu6EbqkJPo/cE910fK1QuAUpGXAYl82fye64DSzTRXSnyDs8CQ4m6EAM1Xy0r83oy20UsgklhV54+WJdHGx1WpiGf8Ldta0+WjLOx5Q+913bI9CyZRvbGvSWsxop0AYVo8wqAMiBQH4hnsvQ+UfyP4IlR1S0MPxqtKnXO6N4ijxKyJuiJrBVp8J9eagq37FcJWqzA5veg3/dFFFQEplv2tY6LDbCKtensyCr1Aa88n+/3uovf8RXCdLeh0FxkvDt+LhbG1Txmol2PXrdI3+PMNWeWqaBd7qWYcp3m3KCO7stcLLDZuMgiPPRwJcsGylXxnmAQjO1CZONvHZecpVB7xiq1sj2g==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 13:18:28.7203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddb9a21-04cd-4e63-b64c-08d7f676f5d7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Received-SPF: pass client-ip=40.107.94.64; envelope-from=saipava@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 09:18:31
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Following patch series fixes issues with priority queues,
Adds JUMBO Frame support,
Makes Debug statements compilable &
Fixes related to multicast frames.

Changes for V2:
	Fixed build failure on fedora docker machine
	Fix buggy debug print to use sized integer casting
Changes for V3:
	1/10: Fixed debug statments to use %u and %zd
	      Remove rxoffset for buffer address
	2/10: Add inline functions to get tx/rx queue base address.
	4/10: fix read only mask
	5/10: Move packet buffers to CadenceGEMState
	6/10: Add JUMBO MAX LEN register
Changes for V4:
	7/11: Fix up the existing code style in register defines
	8/11: jumbo-max-len property sets the default value of jumbo frame
	      Add frame lenght checks for tx and rx

Sai Pavan Boddu (11):
  net: cadence_gem: Fix debug statements
  net: cadence_gem: Fix the queue address update during wrap around
  net: cadence_gem: Fix irq update w.r.t queue
  net: cadence_gem: Define access permission for interrupt registers
  net: cadence_gem: Set ISR according to queue in use
  net: cadence_gem: Move tx/rx packet buffert to CadenceGEMState
  net: cadence_gem: Fix up code style
  net: cadence_gem: Add support for jumbo frames
  net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
  net: cadence_gem: Update the reset value for interrupt mask register
  net: cadence_gem: TX_LAST bit should be set by guest

Tong Ho (1):
  net: cadence_gem: Fix RX address filtering

 hw/net/cadence_gem.c         | 453 ++++++++++++++++++++++++-------------------
 include/hw/net/cadence_gem.h |   6 +
 2 files changed, 260 insertions(+), 199 deletions(-)

-- 
2.7.4


