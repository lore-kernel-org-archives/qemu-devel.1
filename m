Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A78C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E12EF20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BQdVsj31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E12EF20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbv1-0004Gj-27
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrL-00070N-Ro; Mon, 04 May 2020 10:14:15 -0400
Received: from mail-eopbgr690073.outbound.protection.outlook.com
 ([40.107.69.73]:55182 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jVbrI-0005U8-Vt; Mon, 04 May 2020 10:14:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw1PtOA0lAqrS6LQFPm1qfwAzk5bwQCcpXqc9nO/D8oTfIRdS+x8DtZ8r+8E9zhfEXjrbmOzrdTzDWShx9fUYFwbnx1Fz26N4z9HrduMCAo+Z6gWHQ4dWFJvL+m0gpnDANnCV9XJB2y3oooBe/a98OLuUlHmlh4UEEg0i23jT+yFDlKvijtOWDdI68A5s5JCNpM0feLQncHpbMVcq648cJJ9Z40Em3OB3l0dEb5d11O7f3tWmPm61Pxtz4o+PgyWeM3XgWtHcMbLWGPgtm5mMN0TGjtHPztKBgTQDPvz2HE46PxkK/rLI7aV2yRiW1DskJbmpXqOtkltdRx5Lho4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYBD0GY0s6dCHGtc7Rl++atku8A18ubsif2qHKvkozQ=;
 b=A/IeNUQqonh72atNK0YUC4QYcvr3hiBotV85vK9r5V9ABKIAlnBpg+bvCOxoPr7+g33KQicP3NceFbTq8J2y3O0jR5ad9JE0aMw9iTdQHmQcI3Z66pKv6w7KFfF8MVx0sPTp2IO1OOPMzqaFVoVAKhXiPbQ77moXDAM4uvKAlv2ssxPMEGL8uytGg5OTQOW80C5ClLCkzDhHoyGKYMy9bi2mfnrUKpNbWrNe8IC7CZv9xt/tI4h4k+nHl5VsQSY+CUsvPfF70C3FyCutgkCqgu3uFH62DP6EopBoEKZjkB/iLFJHtWGMo3tXGGLHLiswz3bPI6AWopOC8bc2bbqXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYBD0GY0s6dCHGtc7Rl++atku8A18ubsif2qHKvkozQ=;
 b=BQdVsj31AZA5NG2+0xGOtqJG/TmEgix61GDDSsmO8Tl13JqVhgw3/f6yhd7rhSZgrwU8DPSi0qwXuqupSZoIhq5cAULboeQOwJthDGnahfVS/tRXNce/eMN4yygD2ppAkWvIdX/fHwOZpI7dqrIEzazQtJLvUl+HEf65PXyeVyQ=
Received: from CY4PR13CA0018.namprd13.prod.outlook.com (2603:10b6:903:32::28)
 by DM6PR02MB6858.namprd02.prod.outlook.com (2603:10b6:5:223::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 14:14:07 +0000
Received: from CY1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::c5) by CY4PR13CA0018.outlook.office365.com
 (2603:10b6:903:32::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.11 via Frontend
 Transport; Mon, 4 May 2020 14:14:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT015.mail.protection.outlook.com (10.152.75.146) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:14:07
 +0000
Received: from [149.199.38.66] (port=42862 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbr7-0000GG-5W; Mon, 04 May 2020 07:14:01 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jVbrC-0000ub-QL; Mon, 04 May 2020 07:14:06 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jVbrB-0000uJ-O8; Mon, 04 May 2020 07:14:05 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 70CDD13C2E73; Mon,  4 May 2020 19:36:24 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2 00/10] Cadence GEM Fixes
Date: Mon,  4 May 2020 19:35:58 +0530
Message-Id: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(376002)(346002)(39860400002)(46966005)(4744005)(6266002)(26005)(2616005)(47076004)(356005)(81166007)(82740400003)(82310400002)(2906002)(6666004)(4326008)(5660300002)(426003)(478600001)(336012)(70586007)(70206006)(36756003)(8676002)(186003)(316002)(110136005)(8936002)(42186006);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38335a08-6279-462a-574b-08d7f0356865
X-MS-TrafficTypeDiagnostic: DM6PR02MB6858:
X-Microsoft-Antispam-PRVS: <DM6PR02MB685840BF0A9609D240255EFBCAA60@DM6PR02MB6858.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zg4fuGTvbvfKPfpQNeS2UzifGAUyaweBhK24C3JGgWlGFokXifmxFC38PKhbbU3z/P3zdZ3PfozFQNkgmfC3cHNxNWiWps3MmUac51TPhd5fMSmYsnemJV8x1mmCKn7wrwlSENfji6ONGHz2DPTT9/X82KestMk298qHEqE7ua4jD+RL+zDIaepCgtiSrFT0Al4GzAv7cNrUSN7rV8tClMccHlarGRbrXdqYUEYwoperjfx3x0NS/sThtu8LPxCMhiCYziMajs/OjfycstY92quuM2fThj5313FTV9qXVyPr96RIFGfo5eQpUsDFnEngAT+yjsgPQEUQJLVNc7R705TpfjxEcxB9Fuk0Jde8Z+F3r2qWz7HUzDgSB3NIOeFZzF279hmD5pzEApQOgGlAeoUkikUxULcQwf/jyYIRHpSQLEHwQUKHCl8GdVtsTPUmY+SFg24awB/iyIq4QKUi6fQ9OQPisx4mzK4yKOYiTCFmUVBRA5S4InDXF7blRGo/cAmHerETz8W7nxkf2ScU3Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:14:07.1464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38335a08-6279-462a-574b-08d7f0356865
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6858
Received-SPF: pass client-ip=40.107.69.73; envelope-from=saipava@xilinx.com;
 helo=NAM04-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:14:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Sai Pavan Boddu (9):
  net: cadence_gem: Fix debug statements
  net: cadence_gem: Fix the queue address update during wrap around
  net: cadence_gem: Fix irq update w.r.t queue
  net: cadence_gem: Define access permission for interrupt registers
  net: cadence_gem: Set ISR according to queue in use
  net: cadence_gem: Add support for jumbo frames
  net: cadnece_gem: Update irq_read_clear field of designcfg_debug1 reg
  net: cadence_gem: Update the reset value for interrupt mask register
  net: cadence_gem: TX_LAST bit should be set by guest

Tong Ho (1):
  net: cadence_gem: Fix RX address filtering

 hw/net/cadence_gem.c | 167 +++++++++++++++++++++++++++++----------------------
 1 file changed, 94 insertions(+), 73 deletions(-)

-- 
2.7.4


