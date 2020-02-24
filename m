Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F9C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10D2020836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 09:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rmbwwPF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D2020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6AIb-0002Be-2u
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 04:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j6AHk-0000nl-1d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j6AHi-0007vP-Eg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 04:44:19 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com
 ([40.107.243.62]:31329 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j6AHi-0007ui-7g; Mon, 24 Feb 2020 04:44:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLxs0caObnpFjrWGrjDzq2NhgI4nBUZYo2Yu+7ALFHX36ffx/DlYPpVgXyeALVl+tQFZPOPfvm+SXps9+lItjmR3gcNNAFkumUMO++r0eG0WwfO0E3wqxX2DtyhPeEXUJVjBCKa/wsjgCdTaq9UGkE/fo/uUBOWPBX/Ncm9q3kyhVSRyKWMeCY7MV0574ljO596UlR4ZIK85D4zxa+lmx1VzeBsZlr6diBoDYlKNpcXKWQ7aQnv758LW4k9Pzu8ShB2Zy4Vj6KQJJV9CvL9txaWlN0lS9voATUOiyw2mRa0qQwxa4O5W5MhUMe5gTyrJ64wErklR203VMEp7sQOSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeJEVjKWO/jNJirmwLkXhPwi+7Yc7k0EXII8qutiQoU=;
 b=kedjdWDaQ1BxE4Q2P3zEnMeBW1ObJPhsfk1eX//50W7XlK0qUdMQt425+AaqqKzlbxX4+7HdAqzlSOmBzWA1nhQfyj5oNXJRexmR7x5/ct75gthyfxKw9CAij9F8SCYIPy7DgNR8YEfVlXd0V4Fe0Ec1Ly7+pbINnJlLASKXGlbETqQdjMsyGfKZY/in9EPg7sSLqoQoxKBPov2uy0RQvE1GmvJEjscW8M/pnGH/DRwq8yKfSdeXj4TyMKRcz8Nn/bUEMzx035pI6sc2m/bBum+lZN3RafxguiFfO2G0yvrBKMFfKiL+SItUs2BTkmRTTTOqT/xaV2MpLxbyBUvDyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeJEVjKWO/jNJirmwLkXhPwi+7Yc7k0EXII8qutiQoU=;
 b=rmbwwPF+J4VDZfz6OwRD+bsHXWPYylHdoBbF8bJJ5e4SYQ0JIz/08ntTTNt5t+OJdMqX5CU/ILYENf3PuGky2RtgS52bjZqvxtuk71dCUISSdmAtZcdoYyxH2unSO/tM53/UkafZ+8PP2KidrwqLD+hHVYtuq2WNBT8fhIDTiTk=
Received: from DM6PR02CA0108.namprd02.prod.outlook.com (2603:10b6:5:1f4::49)
 by MWHPR02MB3392.namprd02.prod.outlook.com (2603:10b6:301:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 09:44:15 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by DM6PR02CA0108.outlook.office365.com
 (2603:10b6:5:1f4::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 09:44:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Mon, 24 Feb 2020 09:44:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHe-0003mr-4H; Mon, 24 Feb 2020 01:44:14 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j6AHZ-0008PL-1I; Mon, 24 Feb 2020 01:44:09 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01O9i8Qt029113; 
 Mon, 24 Feb 2020 01:44:08 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j6AHX-0008PF-S7; Mon, 24 Feb 2020 01:44:08 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 774E813C0374; Mon, 24 Feb 2020 15:09:35 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v3 0/3] Fix number of priority bits for arm boards
Date: Mon, 24 Feb 2020 15:09:21 +0530
Message-Id: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(336012)(81166006)(186003)(42186006)(5660300002)(426003)(2906002)(8676002)(8936002)(316002)(81156014)(4326008)(110136005)(26005)(356004)(478600001)(6266002)(70586007)(70206006)(2616005)(6666004)(36756003)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR02MB3392; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7dbeba8-f025-49e0-b0ba-08d7b90e1c1c
X-MS-TrafficTypeDiagnostic: MWHPR02MB3392:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3392B8B07AB5E0309DED7238CAEC0@MWHPR02MB3392.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 032334F434
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVangZooHEYKRvFmRQIeOUe94Ocol2G5ScVFfrtiCP6UhkP5EcasiXD7rNyoz+5XRw/nSwJ6sAwTe3pFd8sQL/HW9J40WHkpDhGBNX/5XaTYUxKYeFtyds2/8+2xgDKR5zRCHiXjIt+Fbmw52WWRf9+2wY3N/cpWEgetejfzkdhcKQz0BEt++eGxmIilm3W82PoxHZX5+3i7Pf0o7uk/xTRSUJFgEFmtPq79cdnvyT+qKvShQmJdM9dXd2oUqIdx3TEzC6MF2VVwetGMclakIiLlijs6ENMFIWbbHu/0Y6CSCIebvbNWUc7WrDaGNp3zVF6FCTAgzzeRRLMkARWPfcIGh4wDWZg1+C6ErzXaklDWu8DGuPhNHc4BI/mudBEVOStVBmjhzfmUQIlwotfgDslO5l2uLW5vqy06ndUbxKTUKWAaPe5WgNfekKmGtf4j
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 09:44:14.6796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dbeba8-f025-49e0-b0ba-08d7b90e1c1c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3392
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.62
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

This patch series implements the mask for unimplemented priority bits in
arm-gic. Which will return the expected number of priority bits on read.

Changes for V2:
    Followed gicv3 code for defining mask for unimplemented bits
    Hardcoded num priority bits for A9 and ARM11MPCore boards
Changes for V3:
    Fixed the code as suggested in V1.
    Implemented checks for max and min priority bits.

Sai Pavan Boddu (3):
  arm_gic: Mask the un-supported priority bits
  cpu/a9mpcore: Set number of GIC priority bits to 5
  cpu/arm11mpcore: Set number of GIC priority bits to 4

 hw/cpu/a9mpcore.c                |  4 ++++
 hw/cpu/arm11mpcore.c             |  5 +++++
 hw/intc/arm_gic.c                | 33 +++++++++++++++++++++++++++++++--
 hw/intc/arm_gic_common.c         |  1 +
 include/hw/intc/arm_gic.h        |  2 ++
 include/hw/intc/arm_gic_common.h |  1 +
 6 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.7.4


