Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8FAC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4918220759
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 01:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VlC8tt94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4918220759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaqeR-0001hK-1c
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 20:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqcl-0000Ui-E4; Thu, 05 Nov 2020 20:33:07 -0500
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com
 ([40.107.93.78]:64673 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kaqci-0001Xm-GT; Thu, 05 Nov 2020 20:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr7IQjBeFnsCQaKPMv+sTRSOdoLNlth67HNh3hxJMEx6xDhCcsSv4YRJi8dcSf1JVFQ+zsVukfUINsQkqSmOxJQ5+IjoULYs4V/CncXMFQ0+2Cs6J2qtr3gpNRw9O3HUf7gLwASFV/NBCumfsprQ7ovm4weM69Vt27qI/t1SK/WW+gmiYave77nwLzQrVh2xGzxGjsUbTxx460rMVHlw0L7Zi/I2/l26dojWGcvWnRASAYyFgoCP2PbIM/jd6kvMJW17w3Gy2iza5pZt53ozNhfkfcTgYxfBWpUh2eeh1gSUlSfn+zbF4FPKyya46Iei6goEuWhPmdGr02t0uX6yJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTj7tcGAt7hgLlSFNyrkYt7jrr+Nf9hQT0aB2QOWto=;
 b=ShdMGHQV77Dsjq99axnSTF8Lmzc66SKGjHRj+dIRNVphk+EN31a4sIN+1LfKbD0P4L+qs+wCc4/C5x7uWayLplpDnOdKSR4RaesBidhMa1BdhY/MkWmqJRHkhTHptYjuhiIv+XMJCekDBEn1B6TzzmzSS71y/aKtDaylggfcicY3kjFjlArf4Q61itmelvnuXMXDFL9PROfWlViuZH9DIuKxI8o+XGOYShHMdjV64b1plk/lJc2U5S118aw7H6wyleE2F8WTSfIW+jUC8qcKeK3BqaA7dPkY0yOHDQFaj92Vpgyohh4fn875Yr9313tzNI9zBUZVaEnDPF61yyBxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBTj7tcGAt7hgLlSFNyrkYt7jrr+Nf9hQT0aB2QOWto=;
 b=VlC8tt9422cIb2phSZ6CRzXDqYD8Z5bddnFwVk2b9vzRdIE72SaDKD1L/shQ9qzpiWvlTj2L+NkyX5WfftGeoA8z8N/1MGqvnSQt/TaIL9msxwqHMYv/BL4ttw1NzcM4oFnR7CxAZCqbXnTFvw8+9W+lRQGXutlnVzioSU3xs7I=
Received: from BL0PR0102CA0021.prod.exchangelabs.com (2603:10b6:207:18::34) by
 MWHPR02MB2878.namprd02.prod.outlook.com (2603:10b6:300:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 01:32:59 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::d5) by BL0PR0102CA0021.outlook.office365.com
 (2603:10b6:207:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend
 Transport; Fri, 6 Nov 2020 01:32:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Fri, 6 Nov 2020 01:32:58 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:32:58 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 5 Nov 2020 17:32:58 -0800
Received: from [172.19.2.32] (port=50874 helo=xsjkomlodi50.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kaqcc-0005r0-6H; Thu, 05 Nov 2020 17:32:58 -0800
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3 0/3] hw/block/m25p80: Numonyx: Fix dummy cycles and check
 for SPI mode on cmds
Date: Thu, 5 Nov 2020 17:32:55 -0800
Message-ID: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e8f3f4-0d80-4f97-591f-08d881f3e4b3
X-MS-TrafficTypeDiagnostic: MWHPR02MB2878:
X-Microsoft-Antispam-PRVS: <MWHPR02MB28787FE80EAE07737D2B3585D0ED0@MWHPR02MB2878.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lyaG4D++mtyp07zsjWp/L7B8zLxmm6uZW38G9D3I5QxrXC4jWgXiQRZ2XcaNAPy95az5ETZN08kZOVUHKC25J39pRRd3zecGTa/Dxl3GqjMYdgdnsAvBk3bKALLR4tmieLE7YZxD485zT6KvTfmzhRP/oy8AVwqHCi2c/GlqhYsTHLzrasRWpK47eRA6zkoP9SRsx56EDWEA6fZNviG68xB9ci05zfKSzJmJPbB/ULNI3oOQZECZD+HPsDthn2hTIwxtcO2hA8tpc7iKFnYmxZbkeeWcyIRJ16iFceuU3p44h2LeIVcLQ5M5xc/oD1IK0ikdzHFQVhawn5oKFaoEWqE/6ajM4e+zJcSxDhCd1NdHhPGUBO4padqKyRB/PJffuVrwY8rc13YTVfp2gCggBmLdvcdapRVyML2Lb3irPk=
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966005)(7636003)(44832011)(8676002)(36906005)(7696005)(356005)(82310400003)(8936002)(336012)(9786002)(83380400001)(86362001)(6916009)(82740400003)(2906002)(426003)(26005)(2616005)(186003)(47076004)(5660300002)(54906003)(478600001)(36756003)(6666004)(4326008)(316002)(70586007)(70206006)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 01:32:58.5507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e8f3f4-0d80-4f97-591f-08d881f3e4b3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2878
Received-SPF: pass client-ip=40.107.93.78; envelope-from=komlodi@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 20:33:01
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
Cc: figlesia@xilinx.com, alistair@alistair23.me,
 philippe.mathieu.daude@gmail.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:
v2 -> v3
 - 1/3: Added, Fixes NVCFG polarity for DIO/QIO.
 - 2/3: Added, Checks if we can execute the current command in standard/DIO/QIO mode.
 - 3/3: Was 1/1 in v2.  Added cycle counts for DIO/QIO mode.
v1 -> v2
 - 1/2: Change function name to be more accurate
 - 2/2: Dropped

Hi all,

The series fixes the behavior of the dummy cycle register for Numonyx flashes so
it's closer to how hardware behaves.
It also checks if a command can be executed in the current SPI mode
(standard, DIO, or QIO) before extracting dummy cycles for the command.

On hardware, the dummy cycles for fast read commands are set to a specific value
(8 or 10) if the register is all 0s or 1s.
If the register value isn't all 0s or 1s, then the flash expects the amount of
cycles sent to be equal to the count in the register.

Thanks!
Joe

Joe Komlodi (3):
  hw/block/m25p80: Fix Numonyx NVCFG DIO and QIO bit polarity
  hw/block/m25p80: Check SPI mode before running some Numonyx commands
  hw/block/m25p80: Fix Numonyx fast read dummy cycle count

 hw/block/m25p80.c | 176 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 15 deletions(-)

-- 
2.7.4


