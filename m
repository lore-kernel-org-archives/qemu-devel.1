Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78CEC54E8F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0C79206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aTprwc5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C79206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWmJ-0004Qt-S9
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWSX-0001Uf-Op; Tue, 12 May 2020 11:04:41 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com
 ([40.107.93.42]:2216 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYWST-0002eB-Vs; Tue, 12 May 2020 11:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPXLjEMAiPBduoZSwECmYPofOgt7Br4gBrePWQGr7TvblTs+qyy2pfROSb4NJh4KvhPPpFGpx7amo6gfodXzmuFgV6E54HH0QURZJC5g0tcEgNWZdU/zfpYSXPIM4QLIrxhB7tHvtQySl7hG0LlCuRcCSc4fQSw7ImlWsPqvb0DMKLCas22qHU4Yb9s6R/YR9wbLw8Aosxmo4TIA/jH3a4aERfNVe9l3aNalPmHzcUKcHAT2H/7ObqV0YJtW+eYsWbFYCYkiD6RHL5ckN3BNrLylkt0zSKNCb0L4ohmWrHHBHATSugCLZ6fzebbM/w/UGUWPqjwL40sJDH4n/p7Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtwpcPomahXG7hMnwdJlgvbTNyL9IpnPp01g7Fxnnxc=;
 b=WB2lmPVg0lPIukwIzOFDiZEokXgjBHOa/wu6sTqbv0/Rdsbpl/haSX0L0mMqZPCiVxMHLFgEVYZdQu/aO5Y0hiJsq9a5gpwFamvqXF9PizGagSAL5i4+7LhDJ4pjWy27nRN8zptk4pT0pU8r9vIVtg3KmaFiyg22ntmGIljNKYLvDVSH/xxc7/XLVzQKui6iQwX9qYR3IKicQjsBKEFOKDHU7L2mJhVFEI1nneTpTNgU/q18Pw5Z5/vvp4bIzLBJtJ9o+YtEMEcAUTKdQysEJ6T8lWd7BImnyysqHgDLp7GSB61lddbUYrxY5djHwHVhQhXd87bACroCH3hViy4jpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtwpcPomahXG7hMnwdJlgvbTNyL9IpnPp01g7Fxnnxc=;
 b=aTprwc5PCtqMw3BS6djYHeJ5kM6+o5r8qJRc2P6v94mrsyFsjuw4yAHpgJ7di7oOCrVv0OXxkGlkgfpyJThSlr4OAHTuCSvp/WEMrhGvNyhBp/G56z9UOK/VY8/6q/XJCGh69Kw+NrirdLw0uxROs68Jh9s9jJywuqdRjiMFFtk=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 SN6PR02MB4304.namprd02.prod.outlook.com (2603:10b6:805:af::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.30; Tue, 12 May 2020 15:04:34 +0000
Received: from BL2NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:25:cafe::3d) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 12 May 2020 15:04:34 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT063.mail.protection.outlook.com (10.152.77.121) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Tue, 12 May 2020 15:04:33
 +0000
Received: from [149.199.38.66] (port=48776 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWS9-00045U-4Q; Tue, 12 May 2020 08:04:17 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jYWSP-0003ns-Ew; Tue, 12 May 2020 08:04:33 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jYWSO-0003nj-Mo; Tue, 12 May 2020 08:04:32 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 1FB5F13C0170; Tue, 12 May 2020 20:26:28 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v5 00/12] Cadence GEM Fixes
Date: Tue, 12 May 2020 20:24:42 +0530
Message-Id: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(346002)(39860400002)(46966005)(33430700001)(33440700001)(356005)(316002)(36756003)(110136005)(82310400002)(42186006)(426003)(2906002)(2616005)(70586007)(70206006)(478600001)(6266002)(6666004)(336012)(8676002)(81166007)(186003)(8936002)(26005)(82740400003)(47076004)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c4d9e54-393f-4815-5a89-08d7f685c7c5
X-MS-TrafficTypeDiagnostic: SN6PR02MB4304:
X-Microsoft-Antispam-PRVS: <SN6PR02MB43047F94730993540F271F23CABE0@SN6PR02MB4304.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nA8thQEA8tmwoM5wJoJmbjOjDvvlYfK3MWEfqrTw9l8SVO+YnGiJ52sJvEVv5EI3SKm3GRM0v3VX+l2NIWPy3k95MFCHKgankYkcXNXFcTsv5lNRGJddtdY2mx6mgm2Lwjl55NgWa1hoNSTXJoNGc2bU7jPgBqinxPkeep3/TpVuqffE5ENRrLB4ts1B5GFXS33j2iGrsFDGtCtncaB5IogWlAxAWncnfO4p4ms63dBjGkDKDpd/aNEXvXQb5xPeUvzb72wu93LQtxqBl7x5zB1wpbGuehfPEMK0xacs2Z/f+KqqKfwd7C/IgQhxypbFHjTTJxQ8tuhEiwx9TF9DU5oSjqj7LSEyuuabn6nzegfWYSbPD++oWsplegfdp1g1kbvoiTEd8AHNQqrtVqtSl9d8Zq6EAVSsg90kAZx8yZXejvyVb0Q3B6BBWCen6aouHGoLzq6djKaEyBRbCCdCEukuuewzDAjorpfUTeT9X38oAGONbnDG7FYFhdscHyj+dHhO2ZD18W+E7BUcFQqBbi+HN6GjnAA8PM+RSXcgSkz06wnBO0+kd9VknuICw7Lf3zepkQjiCJbfkqcCtIkjfw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 15:04:33.8757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4d9e54-393f-4815-5a89-08d7f685c7c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4304
Received-SPF: pass client-ip=40.107.93.42; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:04:36
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
Changes for V5:
	8/11: Add a cap on jumbo frame size and print guest errors if exceeded.
              Move jumo_max_len property into static properties section.

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

 hw/net/cadence_gem.c         | 458 ++++++++++++++++++++++++-------------------
 include/hw/net/cadence_gem.h |   6 +
 2 files changed, 265 insertions(+), 199 deletions(-)

-- 
2.7.4


