Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE5DC54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 340252080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="R7ahxeFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340252080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBy2-0004a0-9G
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYBsS-0000Jj-Nr
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:06:04 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com
 ([40.107.94.82]:36801 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYBsP-0000WA-85
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:06:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWjmoPLbPgjkQKl0n8IdJKb39CxJVG4d2yQJrvzF4sXqjp/HaR3HpXwPFX3MAZyjrSI5HnAaBeiSGNVSy+DAxc71ubpn/rp0VgMUEVLTX+c24EFJesq6ME8oKMErfZDJSy+TfdD/tlw/mxhz1cR3EDCPNWa6PZXOnKOqkGtnWYrifn276nIfvNSNhWqCWk8PJxj974tKha68NSforl1+GQRmztI0qxLhaeHOfUKLHYIb9CFqiJlJw0wR1iFopsnoWFwHhmE58M6zUgpcUMCjhLePg8MIjW3hrHlmQi+pZgC5CggUCiXNucJ3ciTZTNpp1/UubjE/fIWgQiTPXG6ZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o60L6e30yi1g7LDrK0JYu+UbNwYEeJaHIddk9UYupak=;
 b=fl8nrFtkCSUxjlPjVW5jSHJ0a9XvwMwA/Wbxx7fXVwVqmsXHVr7w2V4IVqBQywWApG41iassvdezS+JfQHad4NmX5bCKNDWtpbvLtMhldbw/GjyMedris+ry54zhOOpclUW8Za+qaMeE505sJGUBHDc6Y4Qit6Df+Qrn9s30l6cERElXlXWg1TxulyF/kn4oCs+0Ys8crRktkrqXNITUMRAqCu4LhDXkO7LYiiNHya3FmZr1MVljE55He/Jn8oMBMLq/C2kcfqQC3Nq02jSWzSA47VjU3Dk1otD+B+Wu09Tcx9JLP7xIEiH9XDazkiZKOLloTi20c30+F2p0XPX9sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o60L6e30yi1g7LDrK0JYu+UbNwYEeJaHIddk9UYupak=;
 b=R7ahxeFhDtafEzIC/qyQM3mu2T5vaMZIQxOwcgI0U3oQU6nxc7ha23jQTirNAInXwIkqw2LdjXJ4fPhFrqPshrk9ycr/SepGkqnx2Q7y7canM86vgCbMilya29icJq75emuFl/KWdNKP3mIb1owPc6LduVPNmzA31tJoMbFFIds=
Received: from CY4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:903:18::25)
 by DM5PR02MB3735.namprd02.prod.outlook.com (2603:10b6:4:af::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Mon, 11 May
 2020 17:05:57 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:18:cafe::f4) by CY4PR02CA0015.outlook.office365.com
 (2603:10b6:903:18::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend
 Transport; Mon, 11 May 2020 17:05:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 17:05:56
 +0000
Received: from [149.199.38.66] (port=35087 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBs5-0007nH-1d
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:41 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYBsK-0004Py-6F
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:05:56 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BH5pdY028917; 
 Mon, 11 May 2020 10:05:51 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYBsF-0004PW-NY; Mon, 11 May 2020 10:05:51 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/4] target/microblaze: Add dynamic GDB XML and correct
 SReg reporting
Date: Mon, 11 May 2020 10:05:47 -0700
Message-Id: <1589216751-106038-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(136003)(396003)(39860400002)(376002)(346002)(46966005)(33430700001)(6666004)(2616005)(356005)(81166007)(426003)(36756003)(7696005)(82310400002)(316002)(33440700001)(478600001)(186003)(70586007)(26005)(9786002)(6916009)(2906002)(44832011)(70206006)(107886003)(5660300002)(4326008)(8676002)(8936002)(47076004)(82740400003)(86362001)(336012);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291d7168-0f9e-41ff-37d1-08d7f5cd921c
X-MS-TrafficTypeDiagnostic: DM5PR02MB3735:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3735C2A20376DB67C2A17B1DD0A10@DM5PR02MB3735.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLLhR3xWipD4QBKzcs5o2Ej8lbP6LpRM/2xqfrl24kcCm9WLsBq+KBNR/vXNYjmZKuhmI2ahXLNqmCA0FeaD0/4lPXYfMij3mTTgOF3l/4Owip0zPpj8XlIcr3p7aDEg4VzotKLBSiB8Kbg8sQkdkymEsMvGebcArzcKRxP7rtj/n4sO46CcUai7A+pDYNhtjGFlpAWVdraSnjIvL9eVpUCtDYQf4lGuBwjCrC1AO8+We1/aWxs1+k1UU+p8W1Z3WdtZI+VzfG4fqupo3EtuxRwredNVkHuRFYoByRYl1dGAa0cwETExCDsPYs4QOU4IXJDF9NHZsWhqn4SPFRrk2p1Cm8tHMafzm+MGwrtuNrCmL0v40SQuLQ3m0eaJsXCtyxlV25KWY9TodoDTmRyWUy89tChNDcvsCdknnE5VYmDv1wvG+knb2Glaoq3S89fQOoWTqMIOvsElaV3Jxz1ekeTxT0HXTgbl3IkD6AWB9REeeKxo9kDR7Wt98dToP44vcK5W1PvO0oU3XGYSsG3WR2hBZbrjMjbj24v36ODmR49U358CLBvk9eJG3GLet/bqsVGUyv2Lb+psfPT46RZxdw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 17:05:56.4368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291d7168-0f9e-41ff-37d1-08d7f5cd921c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3735
Received-SPF: pass client-ip=40.107.94.82; envelope-from=komlodi@xilinx.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:06:00
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This series adds dynamic GDB XML support for Micraoblaze CPUs, and fixes
an issue when reporting Microblaze SRegs through GDB.

The SRegs used to be printed out by iterating over the SReg array, but the
SReg array isn't laid out in memory in the same order that GDB expects them.

When reporting register to GDB, note that even though 32-bit Microblaze
supports having certain registers wider than 32-bits, we're repoting all of
them as being 32-bits wide right now to maintain compatibility with GDB.

Thanks!
Joe

Joe Komlodi (4):
  target/microblaze: gdb: Add dynamic GDB XML register support
  target/microblaze: gdb: Extend the number of registers presented to
    GDB
  target/microblaze: gdb: Fix incorrect SReg reporting
  target/microblaze: monitor: Increase the number of registers reported

 configure                     |   1 +
 target/microblaze/cpu.c       |   6 +-
 target/microblaze/cpu.h       |   9 ++
 target/microblaze/gdbstub.c   | 214 +++++++++++++++++++++++++++++++++++++++++-
 target/microblaze/translate.c |  16 +++-
 5 files changed, 240 insertions(+), 6 deletions(-)

-- 
2.7.4


