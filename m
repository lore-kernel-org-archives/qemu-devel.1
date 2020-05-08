Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A2C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704AC206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TAOIALx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704AC206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX189-0006uq-Lj
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX16d-0005QQ-EM; Fri, 08 May 2020 07:23:51 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85]:52608 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX16b-0000RI-Re; Fri, 08 May 2020 07:23:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH3Lqvht746QHpytDIlLcvvXpjHB32V1XRvdq9SIqLk6VK9nZ65Hhy9xY+dRGLilXHj9ld7QhknmEFNsnYtGFYBOztJrvAcOg4IjZAVstzyDs70X51xfJDJbwVWX2NuwasAKYK7148fF/m0h+Fwu7YI3Z98Vgysty5jRLKTiUwZyJbxt7xK5vNiqWgNe75R7w2Hyn/KjWnPHcciFMWSqE77pQ6sLB9CCXxzEGpZw8oTiKLPO0+Y1R6wDCC6ZKD8BlEnQLrLz4GQEqK+WDL/NPP/BZZsTD83xhAGrT2PJjMYMNRNKpMCQN64zYpWtTl5S2nYv0DCszcJ3Yk0VmyIikQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reSzmGPtX+dRBZxkhovPyeXLiomAonzfHw4MjuHWCZE=;
 b=fZqXT7+JYZkEwbb0v242YPFDLtNfnaE4XI/LKKOjRttGkg9UnStrEXdRiLxIy47UcIHwCO1pD0yplgp0cfEjt1m65l9yeaJ7ipJaCjaFhUJpv8o1fm8IsSi03tc01vQ6SyLieJVOqSylKNwrWHbUizX04fUQPSmoWTUoIpY5yMFn7e+H1i9U8U277lYUPhdJEjW8Gxqb+KSer38nOa8H+H1kt4Zu9uSid8q24MDIPosKuU9k6PW4QW0NaocGwzDRoeBm4mRQM5mvKae+q0SqDLdQ7iasMPOd0bV2lvIr5Z/tbMyzU+RrskuLU9NbDhuMRbixRo4jmNrbOS9lmfoAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reSzmGPtX+dRBZxkhovPyeXLiomAonzfHw4MjuHWCZE=;
 b=TAOIALx14BL2EN1yMWRQp6cxGOcOe5o9Tj2WHIuzF5sfYiAn1tX9yuZi9rSA4hvbNs7sPZrf6v6yWahTrUSHBkfSTareU4eM8vTeMYCghyHXOv0L7RTI4RHl7q/E1zO41YiqifOrd+WoqmOjEn5EOvhUEjHQxwjxdHAHHxDXr+A=
Received: from SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) by SN1PR02MB3728.namprd02.prod.outlook.com
 (2603:10b6:802:31::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Fri, 8 May
 2020 11:08:45 +0000
Received: from SN1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::11) by SN4PR0201CA0060.outlook.office365.com
 (2603:10b6:803:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Fri, 8 May 2020 11:08:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT030.mail.protection.outlook.com (10.152.72.114) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Fri, 8 May 2020 11:08:44
 +0000
Received: from [149.199.38.66] (port=35543 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0rp-0002Ta-Hr; Fri, 08 May 2020 04:08:33 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jX0s0-0005YF-Az; Fri, 08 May 2020 04:08:44 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may
 be forged))
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 048B8hiq021128; 
 Fri, 8 May 2020 04:08:43 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jX0ry-0005Xj-RJ; Fri, 08 May 2020 04:08:43 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id BF02D13C03F7; Fri,  8 May 2020 16:30:50 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v3 00/11] Cadence GEM Fixes
Date: Fri,  8 May 2020 16:30:34 +0530
Message-Id: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(33430700001)(42186006)(356005)(5660300002)(82310400002)(47076004)(336012)(8676002)(426003)(2616005)(4326008)(6266002)(70586007)(110136005)(82740400003)(33440700001)(186003)(478600001)(8936002)(316002)(81166007)(2906002)(70206006)(6666004)(26005)(36756003)(42866002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a920c2e-3936-4178-f411-08d7f3402c84
X-MS-TrafficTypeDiagnostic: SN1PR02MB3728:
X-Microsoft-Antispam-PRVS: <SN1PR02MB372845A81FCA17917BB11EA0CAA20@SN1PR02MB3728.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hgRnkaE0af4ufMQ8W1s7RIBcLQUGMPGvXZzIbjWtYu1LBsVzM8DZmJW+rBzcfhpRw/yawyiL0NU47/auEkO5a+/3RC5eNDY9+tpNTV8AmXINw/51+Ncj9V18Sv+O0ubObK+Yflfo8flzBdwnkvbnBc+iJrnDhvUjdtT0bQB8j+AryVCb+UwrBDOFIsL62j94OwrUx+uzGclI6Ut4IfN0Qi9s12e0/Wy8ftpiC9jjy6EnIcoy84n+tHB2fbJrHRRFSxV2+klpLZ2OFf/Kx3LAQc8JCOQEZXhZAyovMy2WzFepFIqIiko9nl7i41XeQA2r61NPxzstIeEJuxIt7CkB1m3WdTZ6UKwVcqwmVSzzX6zLlB9pCo+exYBVT8NBRO6SRADT2hi+YK2pyD8IEqIiDNNM2OtgE+TdcR+m6S36kS7cZRMYnwh7+ZrDOFDYdAyLMc4i45LfgFrP4vya++N91hQ5yg+HM/1niCWMm6xBEwp3ccNad+AYKIqqylGQ/lih4G2Nw3qjKfdyBBBjYrD5e6TIKwBe12mCsTQx6sirR47SIr1S93S7AMG5Wt3SXMA+Dj8jRhuRW1BZkxOiPNfIv+NmdaAW8L1XbtCfNi0FQY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 11:08:44.6451 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a920c2e-3936-4178-f411-08d7f3402c84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3728
Received-SPF: pass client-ip=40.107.93.85; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 07:23:48
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
	1/11: Fixed debug statments to use %u and %zd
	      Remove rxoffset for buffer address
	2/11: Add inline functions to get tx/rx queue base address.
	4/11: fix read only mask
	5/11: Move packet buffers to CadenceGEMState
	6/11: Add JUMBO MAX LEN register

Sai Pavan Boddu (10):
  net: cadence_gem: Fix debug statements
  net: cadence_gem: Fix the queue address update during wrap around
  net: cadence_gem: Fix irq update w.r.t queue
  net: cadence_gem: Define access permission for interrupt registers
  net: cadence_gem: Set ISR according to queue in use
  net: cadence_gem: Move tx/rx packet buffert to CadenceGEMState
  net: cadence_gem: Add support for jumbo frames
  net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
  net: cadence_gem: Update the reset value for interrupt mask register
  net: cadence_gem: TX_LAST bit should be set by guest

Tong Ho (1):
  net: cadence_gem: Fix RX address filtering

 hw/net/cadence_gem.c         | 236 ++++++++++++++++++++++++++-----------------
 include/hw/net/cadence_gem.h |   3 +
 2 files changed, 145 insertions(+), 94 deletions(-)

-- 
2.7.4


