Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E19C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFFD206CD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 18:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KrA3tpJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFFD206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUwXP-00028J-Gd
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 14:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwSX-0000nZ-5O
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1jUwS4-0000Tw-J5
 for qemu-devel@nongnu.org; Sat, 02 May 2020 14:01:52 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com
 ([40.107.93.77]:64001 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jUwS4-0000QS-6d; Sat, 02 May 2020 14:01:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWQU6LCL/LJtKjvJSYuL+Dp9ZRZwsqsfZmThFNjC7IXnx94EkeEnQ199FoLqF5HpXdGxEuUpRlnsLrhwnUmRlPrrKa+yX4+kGzzSBVNRJyOeQ1Sri8fwck4aP/nCslkbohhQFnB265jQbOapW569TKNvvtehDU+1JyflWaD+psu9HZyi+BS8frYh0rkVemwblU9jrcigtvog+mXgWRSZd40JsAmlvQuvnslVdDRyiYEmJanlnkNDu1Bz14MFHN3K7aI9QFdnIyNdqUA3S5BqXaOz4f4qDvUERjEbkPmoxUmJPVR3VD3Bz/ExclUfD5FyfJ8xu3k5LJuj3lEdopDilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4iLAruzG3f4R7NQpfESjz+UT95QD4XrITpVG0QA9UA=;
 b=G2zTHG+Y7k3qJwCeKHEEXlRaArUNl0z2N8Ody8Yuau3G6PfkEup+qx129SoR/6+hP9Ed1Gs7X4RREpV18rFWJuzXgHyvdiFr9pFw81uNutu2P/kdnc+t0F39iGdzSYDO5SebdREOnBEeq4y2wEbXHL3rQxJTIlhyUq/mwheQBCIPqWyfJJkybdtIruIPg9kpAgsw9vbkXdUOHOVSBoiZoCIqsyArJchuFMNm3zHFICAasWUlG0hqQ5LUx8M2jAns0fx5cosfamhEVzutzopp22Enzxb8uEwyDGGmev+GFbzmZVzarokQ6Wrjf/BfIpSexhovaH/H5FHH7Dzgir11eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4iLAruzG3f4R7NQpfESjz+UT95QD4XrITpVG0QA9UA=;
 b=KrA3tpJpvy6PEU9iFzViFttjtA7C9z8BNaUJO+mTuXXK8nK10ikFTbG7ij6F66+zXLSYc1FiJ6U8I3fg9IJE2NfcZ1wZJX2jP3T9njHAiRELbboYxASS0Q+sxYB+kocAsoe/vyd4LQhnN9GU129i/EcHxUOUuDg9uWILUUbKUVc=
Received: from SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) by MN2PR02MB6046.namprd02.prod.outlook.com
 (2603:10b6:208:1be::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 18:01:21 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::44) by SN4PR0401CA0023.outlook.office365.com
 (2603:10b6:803:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21 via Frontend
 Transport; Sat, 2 May 2020 18:01:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server id 15.20.2958.27 via Frontend Transport; Sat, 2 May 2020 18:01:20
 +0000
Received: from [149.199.38.66] (port=60350 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwRw-0004nj-VZ; Sat, 02 May 2020 11:01:16 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1jUwS0-0006xK-6u; Sat, 02 May 2020 11:01:20 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 042I1HI1010810; 
 Sat, 2 May 2020 11:01:17 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1jUwRw-0006vn-Tp; Sat, 02 May 2020 11:01:17 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id C473013C2192; Sat,  2 May 2020 23:23:39 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Tong Ho <tong.ho@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH 06/10] net: cadence_gem: Add support for jumbo frames
Date: Sat,  2 May 2020 23:23:10 +0530
Message-Id: <1588441994-21447-7-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(376002)(39850400004)(346002)(136003)(396003)(46966005)(47076004)(2616005)(110136005)(42186006)(4326008)(6266002)(336012)(82310400002)(316002)(8676002)(70206006)(8936002)(5660300002)(36756003)(82740400003)(6666004)(356005)(26005)(186003)(426003)(81166007)(2906002)(478600001)(70586007);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280bb1c8-0b85-4200-2b8e-08d7eec2d1b6
X-MS-TrafficTypeDiagnostic: MN2PR02MB6046:
X-Microsoft-Antispam-PRVS: <MN2PR02MB60468BE479961FFD770E9D6CCAA80@MN2PR02MB6046.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:68;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGWE93w57x+x2jCAziaikKGi+9Nyl5nlluHyZXFIPSj4vND1PEkN0XOFaRwnQSRtGVD7BwusWFwGpcUE4EFfMC2fyNbZKV2J+f+GrYRdQKlc9t4cwFxtiCtqp0PFs4R/ORp7WwxXkL/mXoN9/qaZ2g371qHE5fFjjQ++f9NyjyvPY4oC0ZgQRxyOJNh6iHVSgH90sYPwjOw5GLn9gQ1KJ+SrOl6fEGTOKF99huSYc4tA32zz5A+YJhgxnE81Yxf7wgXN2IgPNUQz/Dzx9aSPs1gfhPH5JnT6UDzbd1YK2FSNYJ3PBxosmBhFl6ZUenlBhbXDUPzKjoPaFJJtlWm3r5weZNF+TOV5zowZHwqZR87dy2kvw72qzeh13tFje1Ao0ajRIAyM81oiNp1cGwz3SYpBDavP+ir4K3Ys6IdOKkScRVhWI0aQ6Rop9f2j6dCXOWNw07zcm16bty1PiNPcDqURp7boXPVp7/USUfnuintA4hAu5utM65kgrZL+0uHACfgodoA93OQWsvcP1nYe+Q==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 18:01:20.5527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280bb1c8-0b85-4200-2b8e-08d7eec2d1b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6046
Received-SPF: pass client-ip=40.107.93.77; envelope-from=saipava@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 14:01:22
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.93.77
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

Jumbo frames of size 10240 bytes is added.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
 hw/net/cadence_gem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index cc9e735..75fdb00 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -313,6 +313,7 @@
 #define DESC_1_RX_EOF 0x00008000
 
 #define GEM_MODID_VALUE 0x00020118
+#define MAX_TX_FRAME_SIZE 10240
 
 static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
@@ -1142,7 +1143,7 @@ static void gem_transmit(CadenceGEMState *s)
 {
     uint32_t desc[DESC_MAX_NUM_WORDS];
     hwaddr packet_desc_addr;
-    uint8_t     tx_packet[2048];
+    uint8_t     tx_packet[MAX_TX_FRAME_SIZE];
     uint8_t     *p;
     unsigned    total_bytes;
     int q = 0;
@@ -1343,7 +1344,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
     s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
-    s->regs[GEM_DESCONF2] = 0x2ab13fff;
+    s->regs[GEM_DESCONF2] = 0x2ab12800;
     s->regs[GEM_DESCONF5] = 0x002f2045;
     s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
 
-- 
2.7.4


