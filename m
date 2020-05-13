Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A5BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608A92065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 18:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="efeksO4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608A92065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvpa-0003D6-AQ
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 14:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoR-0001Uv-Vy
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:09:00 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com
 ([40.107.237.63]:6106 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jYvoQ-00005f-6Z
 for qemu-devel@nongnu.org; Wed, 13 May 2020 14:08:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkYLus//yC9GxtX+WXLjsJVU/G5aKThAGriXI79L1yrtL5jwWNH8rCed6GQ/wZ48qsEtleXKb6NgrTnyObjbGOKAUAO22GDtMxuWoCjRU6C9NuvBTHiK0wmmWqD+599Mf5pD/EUiF2sjm71+m1JHPGWLYmBztg/CV7emISfQVdu1ISDgI6iStIu3KJTTiaYsoC/RLmY48y8YP/4phF3PWYA+pkANsap+J8O9W/JO/LWD+/gHvyv6HE0FMyvXiepdTNxVd8x30g9GAZMunl0c4eYh9bVvy1Jb7KlkiO36q2p9+JWPnkrKcQKceDjZrNmCnyszr9keyBn/UnS21GzaAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmFreeuRNGTY0LY6peknR4B18TyDk5OTPDn1Wgu7a1k=;
 b=b6eCNl2MXwJLvVDnsB7Uud+A6YfHpD1wCnTB2KyJ/zljsd05/TsE3Do9FiCRw0X5rmdFjV+YtavjYcyF51op64XfyfN6xoAEFvyljdDygswCjVQ9zWXiz5rEzJ2TCdClRNaRudwOy+MrtiMy0tUedGDbkgEY1GWD0qn9kd+SRi1xp3AWG8gDPyaOjFlmVc1T+yafeqe2ZxNHRlNk5yW6R5xzvEpCoChe/Zn2KS2H49CI0qxnA0MoHY9ojfZRpdZPr1Vwyf9BI/WJjno0+bRTtTmxhRLSeYgRUs1Gm73AFU+EkS7sjhMSTbWyBNWUKrWB8hXwf21pzVTx7zpNX8fXCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmFreeuRNGTY0LY6peknR4B18TyDk5OTPDn1Wgu7a1k=;
 b=efeksO4WEscZZSEA+jBuUufZ3QuqcIWWqtiljSieUeX9EHyLGmHle3lirER/Q+E/AS2yq0LTQNy9HbQ0gC7nQGssAD/yNzGuxoEiKqnTScgWkUsCW96cSr99Oa+uG9xk5oxEAAb4uHdRWp1ee/pC163c1hBKnqdQEOn/wt4lRX4=
Received: from MN2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:208:178::35)
 by MN2PR02MB6079.namprd02.prod.outlook.com (2603:10b6:208:185::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 18:08:55 +0000
Received: from BL2NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::9c) by MN2PR19CA0022.outlook.office365.com
 (2603:10b6:208:178::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Wed, 13 May 2020 18:08:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT059.mail.protection.outlook.com (10.152.76.247) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Wed, 13 May 2020 18:08:55
 +0000
Received: from [149.199.38.66] (port=59448 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvo4-0007yG-S9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:36 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jYvoM-0002TI-NF
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:08:54 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jYvoI-0002SZ-68; Wed, 13 May 2020 11:08:50 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V2 0/4] target/microblaze: Add GDB XML and correct SReg
 reporting
Date: Wed, 13 May 2020 11:08:49 -0700
Message-Id: <1589393329-223076-5-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(39860400002)(396003)(136003)(46966005)(33430700001)(8676002)(426003)(186003)(2906002)(316002)(478600001)(33440700001)(356005)(44832011)(70586007)(26005)(4326008)(2616005)(81166007)(70206006)(36756003)(7696005)(6916009)(8936002)(9786002)(336012)(82310400002)(47076004)(5660300002)(82740400003)(86362001)(107886003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 381f4887-7aed-4592-263b-08d7f768b32f
X-MS-TrafficTypeDiagnostic: MN2PR02MB6079:
X-Microsoft-Antispam-PRVS: <MN2PR02MB607991322804AD8943E0C94ED0BF0@MN2PR02MB6079.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg2X+pBXvbnmIgsDj79X+s2FllkmxgZdROMeBtlEifcbRR7l1NRnaq2Pk9tCZYDbWrrUvVXOI8tb2/kFbQE1vTZHOw7j01kHiaK3o9cgB0K5bgg3s3wfEwGBpdu9L9zkE5gRouknyfira2Ammuz9WBtZDQZBydUItxuBhFatKNtlFNVhZStdDmZbRS7F8rnbUyByPt2HZCPTi51Hcjr+WA9UCbfOpub1TA58JRRojSSpl1u+AAXGc8cnBqVM4uz5d3OPtTgp7olDvakYYE9oIFTPybctusBm35mSNo5dNjHZ7bTTVJEQR4feWUat/YBhM6PcYcyTR2huVGdxlnUf6xWGneL+U49B1jul+YPnhHNeQQ0RPDqNfI764xU08NEFDt+iinlYtFta3BG6f8zXV37/bR4JxQphbDEeXer4BzUmSJICXqJo8cGYahzbjAWEna3Osu+LuY7yDJ7tcBXiP073TAtqoGfWRVdc936yQdIkdXwM2xiSfZNoycWdG0CJm8Aw5X8fYVgoWJPMCjzayoK8l7uuMd4f4cHPe+/XB8W/TshArK0TuWYl3wTHl7bI29n04o2npjf2vCng3YkWKw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 18:08:55.0885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381f4887-7aed-4592-263b-08d7f768b32f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6079
Received-SPF: pass client-ip=40.107.237.63; envelope-from=komlodi@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 14:08:56
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

This series adds dynamic GDB XML support for Micraoblaze CPUs, and 
fixes an issue when reporting Microblaze SRegs through GDB.

The SRegs used to be printed out by iterating over the SReg array, but 
the SReg array isn't laid out in memory in the same order that GDB expects them.

When reporting register to GDB, note that even though 32-bit 
Microblaze supports having certain registers wider than 32-bits, we're 
repoting all of them as being 32-bits wide right now to maintain compatibility with GDB.

Thanks!
Joe

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Changelog:
v1 -> v2
 - 1/4: Added missing core XML file


Joe Komlodi (4):
  target/microblaze: gdb: Add dynamic GDB XML register support
  target/microblaze: gdb: Extend the number of registers presented to
    GDB
  target/microblaze: gdb: Fix incorrect SReg reporting
  target/microblaze: monitor: Increase the number of registers reported

 configure                     |   1 +
 gdb-xml/microblaze-core.xml   |  64 +++++++++++++
 target/microblaze/cpu.c       |   6 +-
 target/microblaze/cpu.h       |   9 ++
 target/microblaze/gdbstub.c   | 214 +++++++++++++++++++++++++++++++++++++++++-
 target/microblaze/translate.c |  16 +++-
 6 files changed, 304 insertions(+), 6 deletions(-)
 create mode 100644 gdb-xml/microblaze-core.xml

-- 
2.7.4


