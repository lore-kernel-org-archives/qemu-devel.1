Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893FCC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569362187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eedu+rHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569362187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2avK-0002Dd-Dq
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 08:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j2auD-0000iW-4y
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j2auB-0004uZ-QM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 08:21:16 -0500
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com
 ([40.107.94.55]:46529 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j2auB-0004nk-CL; Fri, 14 Feb 2020 08:21:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmbCgq8r6qZVLyd2oBK7lp1NcNgAjpUMETtZAjnEYNvTWfvs610rY2tWXuw9B6vEW6MbXFoaAVNmMb4QwV7OHPWLyIkr7xq9l1OeO4CxqIjcLRBcP5FCUG5lU25fXjK0xjTu9EpH/2rCPqmTOY+2wRL6bcfITUVMQCaVUD2Fg7yMzbUzXdU6ZUySQFpqluJ/cDHgn5iHM1apSpaJtIHrgM0jBWaR6vA+mB2LuDdOzSAZ8PEF4B+j07QeBfNSnnC0gMDborpCAbMPuNsuZxoy69LaDEnZQYnCSuCyezKw7FjvHhhyh+N9Lx7YHJpmSV+ickLqx72V+uXrnk/clx0nUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymvym/lU3LVPyVg39R87Hg0dd3qtaLOMAeHDSox53gs=;
 b=hGFGmZsEHwS1+fQAb1SHU6ljrcKVFdia4Z1+oSoyoix/4SB4GaDOEjZGU0jxHZMtFq5wAqDhCY1avho2LA7r23VFlURUzeTxcuzODOPoYZUpgs4Cyo7LOD2taKyaJo4+LysEtX/mw3ub0b9wbHfu9+FslwHL9S3rpQTzBZnkrEw939r6wJP7yW9CJ+vwcN6lA9k4EXQMKz3+CgWG/33PH7Z4odQ/fpudMdOeCdu81G9xRjGCdOWTF3bVCyjswpIo3U/b0AS0kll3RERtnY6En50GaTltOSRS8MV3ztE/Nh0MryE2Pk2p7dv7IiTqrjVVKikgY2WVBapsmL9Wl19ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymvym/lU3LVPyVg39R87Hg0dd3qtaLOMAeHDSox53gs=;
 b=eedu+rHdLDDcnKHpDjysVuEyXdXjeEpgzQMjdT+w7F+3eiig1b0c2UiviAttZrP32hfJS3eSdIw50uQotWUuNnfGlJcVRJ2hbfOxDP8ppP0fGoBxQ8HpC3bduXzghGit62Du1mk42IO+yeOarbdZBx5xIOs7on9LO8C27gu0qIk=
Received: from SN4PR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:803:20::12) by SN1PR02MB3904.namprd02.prod.outlook.com
 (2603:10b6:802:27::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 14 Feb
 2020 13:21:11 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN4PR0201CA0050.outlook.office365.com
 (2603:10b6:803:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Fri, 14 Feb 2020 13:21:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Fri, 14 Feb 2020 13:21:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2au7-0001UY-5K; Fri, 14 Feb 2020 05:21:11 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j2au1-0006fS-U1; Fri, 14 Feb 2020 05:21:05 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01EDL5i3013702; 
 Fri, 14 Feb 2020 05:21:05 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j2au0-0006fP-PX; Fri, 14 Feb 2020 05:21:05 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 4FBD513C0374; Fri, 14 Feb 2020 18:46:58 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH 0/3] Fix number of priority bits in zynq gic
Date: Fri, 14 Feb 2020 18:46:49 +0530
Message-Id: <1581686212-9625-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39850400004)(396003)(376002)(199004)(189003)(426003)(4326008)(70586007)(8936002)(356004)(81156014)(8676002)(6666004)(316002)(42186006)(336012)(70206006)(2616005)(5660300002)(110136005)(6266002)(81166006)(186003)(478600001)(4744005)(2906002)(26005)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR02MB3904; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 847add65-cdc5-4a4d-7df5-08d7b150c298
X-MS-TrafficTypeDiagnostic: SN1PR02MB3904:
X-Microsoft-Antispam-PRVS: <SN1PR02MB390408240D4CA57FDCF58BABCA150@SN1PR02MB3904.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03137AC81E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49Qg4fF1s3yDnW97n15YDi8Cb5fCh47hRXMzOHPfz67yuEfvCoVtnMM95FMiUJJGmcXRW5PWV+aJsOFU+FW7REg4G/Cyr456O3K1R4X/qPt4iciq1fML3L4tx607dBlQ/PInESuvIU65hzAbD4fkMStCmSYKIhCPgD/CGnGFNgdzkBCaP79soDadtcg2CDBTt511xHMB4UrAbRjyigPf0wiJ7gQ3ImUO0fnA+tW5sC0w016FYQpkD/StlPnSXnk0QU3supuNU96+5wbWv4cxanqXr7a7oORH+MblKCEZFiZa1qlPrz9LL9QsQTMBwckT5XS8H+mAoR1lVXcv8Ji7G7daaEK+8lQ4gQDLfns/e1k/HYvJHF36y6ZMQJ2rsE5RBB0POUTJnYEbHxQgaaYXX4wHO96vDvkAgSJ9D04N3FB7BVVlpUxl9vyL21U08YeW
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 13:21:11.5367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847add65-cdc5-4a4d-7df5-08d7b150c298
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3904
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.94.55
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

This patch series implements the mask for un-implemented priority bits
in arm-gic. Which will return the expected number of priority bits on
read.

Sai Pavan Boddu (3):
  arm_gic: Mask the un-supported priority bits
  cpu/a9mpcore: Add num priority bits property
  arm/xilinx_zynq: Set number of priority bits

 hw/arm/xilinx_zynq.c             | 1 +
 hw/cpu/a9mpcore.c                | 2 ++
 hw/intc/arm_gic.c                | 9 ++++++---
 hw/intc/arm_gic_common.c         | 1 +
 include/hw/cpu/a9mpcore.h        | 1 +
 include/hw/intc/arm_gic_common.h | 1 +
 6 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.7.4


