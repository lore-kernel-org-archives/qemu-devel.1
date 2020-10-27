Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4397C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3163207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 23:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pI15crtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3163207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXYe0-0007br-0y
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 19:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXYd4-0006JT-N5; Tue, 27 Oct 2020 19:43:50 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com
 ([40.107.237.83]:62000 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXYd2-0006VL-Kx; Tue, 27 Oct 2020 19:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsDKHczY62AFhU/RmgxaJtebKxa2tbACxqU5wPPAceooNa4gnA1C0HjtCSQ/BULeDC+JxNYBfDsHdf3JnH0a2ncMIylY3kgzEzERE+mcyhXeaRm+b77yCAUE+pHFBa/XhVmrIsZlLmkQyjbyLuLY1oT7jUAnvuBtM4oSt/RaZBoeQCj98gYnEoSST5BQXoWw/C3ZSW2eWNrcpajyutg4qc51zEkzuiiY0tQawOhNUuhHE5ImM/1UiIklEVHgCH98SeGxIqTvQyen/7pZrRQUOHV+hniMDTdWBT6RO65jdxXxg88yAH/yzEuPdr/jrCSfR6vsY80uPAnh8A40pjlCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJDs+6ThG48Xvg/KtKWuu7moOMzwl56wZ+Az+DVNkJc=;
 b=hBXbQcYiro9EAHqgdKU1GEBWuzAlyXxWj4ks+gPiCl80Zl94C/tgEt+9SPJ/qaCAOC4qlZa9vI2KkGAj8k0nYQfwDnOlchc5u53dSfEHXDKnUTjGQAb/krEsnqQS/RCKd/BF3LM2UqcCiWdvsRHVvW8kbZpysNqSgpBvYcFKgamKLHJdqDvwGVxI6BuwOW6FJ0wVjAWzxBDkKmu8DjJnqWgTG63PO4u18wfO0wIeDzzcPwPL9tspWWhRJ+mykJkvhRzBOFtG0r0b2MO5I+V2ifiNG0D0l268OjdxO5ftckCZdz82JL3PuF671qS3jieJZH1WxHfyGaGt2+D5kRkx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJDs+6ThG48Xvg/KtKWuu7moOMzwl56wZ+Az+DVNkJc=;
 b=pI15crtC99N2pL6zHYqkEb8GVS+RZb5QlqrOs1LFpY00zmkZuEHAvPCmAXj1EJ4FguBlQAUjBG5uu/F5Cgz3r+C1bcKN7kGfa9O+X1rs/8eazBJowTKztIXIPW0EYyH0/feGN/SCrKrPYmHeYQyZv1ndi/xnL4WOHZCMntItLFE=
Received: from SN6PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:805:106::11) by DM6PR02MB6169.namprd02.prod.outlook.com
 (2603:10b6:5:1ff::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 23:43:45 +0000
Received: from SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::75) by SN6PR2101CA0001.outlook.office365.com
 (2603:10b6:805:106::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend
 Transport; Tue, 27 Oct 2020 23:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT007.mail.protection.outlook.com (10.152.72.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.20 via Frontend Transport; Tue, 27 Oct 2020 23:43:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 27 Oct 2020 16:43:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 27 Oct 2020 16:43:40 -0700
Received: from [172.19.2.32] (port=45998 helo=xsjkomlodi50.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <joe.komlodi@xilinx.com>)
 id 1kXYcu-00015W-AY; Tue, 27 Oct 2020 16:43:40 -0700
From: Joe Komlodi <joe.komlodi@xilinx.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/1] hw/block/m25p80: Fix Numonyx flash dummy cycle
 register behavior
Date: Tue, 27 Oct 2020 16:43:39 -0700
Message-ID: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf83d85-e97f-4c94-79ea-08d87ad224f4
X-MS-TrafficTypeDiagnostic: DM6PR02MB6169:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6169A59C7CD7B5C4A60D821ED0160@DM6PR02MB6169.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qFfPDNOU2Hu3atNcY5Ze+/ZqbUVjbgDcOjykNkTXpNthQqR+5D5sVUaGG8p7OGgilf7yrZD5UFNoeLWsZKlb7QsZYtLiAl9XMxh31FIxrI9SyS+azzLWghojDmbjitpmBc0C70H6HM+kznwhdCwL/SydmciMtUDWmIZZwh4e2Gcf5hQOPCH3KAynHp38ExystbDgbSVOHavnK22VZtRTWqQk+84H/KXMRkuCEus9pM3skAifpMoORTg5P4R3SmGYbo4qPnXy3U3j66dK2SE36PBYksUU6IFR+u4zNr12/C/HroxToZmQvTFeaBpmYfBSxI2+Lu+BXbeon8V2umjtWlvkUOG+yqmHQgrx0IFqpNCghgMT6BrBBS9R0u9Yp6hN2zh1W28PMFfBV8rYKKCEd6t3mN9QfOB4Na9Jpdth9Y=
X-Forefront-Antispam-Report: CIP:149.199.62.198; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-62-198.xilinx.com; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39850400004)(46966005)(54906003)(82740400003)(478600001)(2616005)(426003)(2906002)(9786002)(47076004)(8676002)(8936002)(186003)(6916009)(336012)(7696005)(356005)(36906005)(316002)(7636003)(26005)(4744005)(83380400001)(82310400003)(5660300002)(70586007)(36756003)(86362001)(4326008)(70206006)(44832011)(102446001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 23:43:45.3839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf83d85-e97f-4c94-79ea-08d87ad224f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.62.198];
 Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6169
Received-SPF: pass client-ip=40.107.237.83; envelope-from=komlodi@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 19:43:47
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
Cc: figlesia@xilinx.com, kwolf@redhat.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changelog:
v1 -> v2
 - 1/2: Change function name to be more accurate
 - 2/2: Dropped

Hi all,

The series fixes the behavior of the dummy cycle register for Numonyx flashes so
it's closer to how hardware behaves.

On hardware, the dummy cycles for fast read commands are set to a specific value
(8 or 10) if the register is all 0s or 1s.
If the register value isn't all 0s or 1s, then the flash expects the amount of
cycles sent to be equal to the count in the register.

Thanks!
Joe

Joe Komlodi (1):
  hw/block/m25p80: Fix Numonyx fast read dummy cycle count

 hw/block/m25p80.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.7.4


