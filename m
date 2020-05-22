Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C61C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29BBA2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 04:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m54mm0C0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BBA2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbzMt-00050Z-BU
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 00:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jbzMA-0004Sv-4e
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:32:26 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com
 ([40.107.236.60]:6867 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1jbzM8-0002FZ-8R
 for qemu-devel@nongnu.org; Fri, 22 May 2020 00:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3hdrSU9hZ2Yj9oASBFLX7b+auhaL9PBoBNA2S9DkdhHA5hY0QM4d7x98UtnyUoB4TXlmdXguYT7leTNcDXpH3xP295xT8hRwL21Jg4BOntNGGqmb3V8isgD4/Fcznsb+TOO9Ymq33m7ZR17STpWZesemXrw8giluaViyYRYYCAl3bmBh5C8GITkHBU+LQIBqRmkgVJEhvcdh+mPf9+WEZdK7oIUFXUUyl5hlSBpxdrjWUnaWDtbUjxzSkLYW5GCZ4jfRXt8/rOcFYMLyA7Qg9MBnl9wixyQRAQETDRjf8Bs+q6cwa/PbvLsv8LwUYX3I7U0vDibbHqLk26m4oN8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdX/T111o/HcwGdAZjQw3K/ihs/cmTYF1Xz0y/tvgI=;
 b=myET7eQfgjkKAmRM9K5jiqXHMjz5AYV4yEMACFhr7puldRsZu2My+PFXWa7IvQKsXRoo3cfOqabYcgM0z2UK1vcrEIlcnnDtghIZiaMZiUhWMNKCB/R4Kh3TpIQ+CbhjH0c4a5mUnuLXhypeDGV81aBDR59nCn4k0UteCCNwx0ca5dElVc7Q314Gms0hU/gbEWP1lytZlah5vmpNE2hu0kPgEgjx8oLYb4mHdKokaBgpLnw5+AXDzUGKJjOu8xUtf4x3MWtfHfZrLvmWH7pcvx3n7DHhLMu54bDmCb2B/81MURNojDr798x7EOPAAiQM4S6lFfrJdJloGAdeYJ1cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdX/T111o/HcwGdAZjQw3K/ihs/cmTYF1Xz0y/tvgI=;
 b=m54mm0C0DEm0jzgMAQFkVpUfmBN9QKN9Gm34YYUscqrFwAmv+oJKzMtFtuhdiePbS6/l3XT7deTAPD9XyZWuVsNKuacQXJu7yBKVMauuRFZC+R2nykDXGNnqjxtNIBokqnoNoBr0MhcMgm0gFvSWUPBcvCIm4KLBKXUE5QeH7kg=
Received: from SN6PR08CA0010.namprd08.prod.outlook.com (2603:10b6:805:66::23)
 by MN2PR02MB6158.namprd02.prod.outlook.com (2603:10b6:208:186::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 04:02:17 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::e3) by SN6PR08CA0010.outlook.office365.com
 (2603:10b6:805:66::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Fri, 22 May 2020 04:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 04:02:16
 +0000
Received: from [149.199.38.66] (port=37148 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jbysV-0005Ef-8R
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:01:47 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <joe.komlodi@xilinx.com>) id 1jbysy-00025n-CI
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:02:16 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04M42EQo016836; 
 Thu, 21 May 2020 21:02:14 -0700
Received: from [172.19.2.32] (helo=xsjkomlodi50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <komlodi@xilinx.com>)
 id 1jbysw-000253-6K; Thu, 21 May 2020 21:02:14 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] target/microblaze: Add GDB XML files
Date: Thu, 21 May 2020 21:02:14 -0700
Message-Id: <1590120134-39470-2-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590120134-39470-1-git-send-email-komlodi@xilinx.com>
References: <1590120134-39470-1-git-send-email-komlodi@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(39860400002)(396003)(136003)(46966005)(6916009)(356005)(44832011)(36756003)(426003)(82310400002)(2616005)(4744005)(186003)(5660300002)(478600001)(8936002)(8676002)(316002)(336012)(70586007)(81166007)(26005)(47076004)(70206006)(107886003)(7696005)(2906002)(4326008)(9786002)(82740400003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0ed39163-5dc5-4290-0741-08d7fe04eaaa
X-MS-TrafficTypeDiagnostic: MN2PR02MB6158:
X-Microsoft-Antispam-PRVS: <MN2PR02MB61589B59CA3F43C27B0EDEC1D0B40@MN2PR02MB6158.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATjpRJBOYPlZHVMozGzerwCbDTFtwpywCbwGt+zh+Y8GvdjIb3gYQgyXhytAWNIkjajoyHLpgr7R43saq566cavLfOp7QTARW5MOkRZXz/zS1DqMmGHzDHxoL6yumhfrFF8meu9huj+6a4YYYkSBVFp+i14yKqak3L6o2X3wq34dtbXfEKP8IQN+nLWOkAyxTCAeXHsD6Uvg/uAz4tUueoNqbotmoKWRDsCxNSRz+ZSZZ4laaaByOwR+MVQF4z95F8uaS4am5R9iXmuYEC2M9eQGQPB29Vs/euOxJvbO+s4N1yJDQe/sSUSdel1WQgRd9lsPZpoDMq/hlnB+Q+UUvOgPX6Y9kXBsI8g4OS8HuSTzm7FFBvuuelwQBT2Yx4OvUmkh2T8ktfCFzWDzUXIEsg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 04:02:16.6520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed39163-5dc5-4290-0741-08d7fe04eaaa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6158
Received-SPF: pass client-ip=40.107.236.60; envelope-from=komlodi@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 00:32:21
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

This adds GDB XML files for Microblaze CPUs.
For Microblaze, it's split up into core and stack protect XML files.

Thanks!
Joe

Joe Komlodi (1):
  target/microblaze: Add GDB XML files for Microblaze

 configure                            |  1 +
 gdb-xml/microblaze-core.xml          | 62 ++++++++++++++++++++++++++++++++++++
 gdb-xml/microblaze-stack-protect.xml | 12 +++++++
 target/microblaze/cpu.c              |  1 +
 4 files changed, 76 insertions(+)
 create mode 100644 gdb-xml/microblaze-core.xml
 create mode 100644 gdb-xml/microblaze-stack-protect.xml

-- 
2.7.4


