Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E189C35643
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7F4207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mWlKCGvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7F4207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j532q-000263-V8
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 02:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j531R-0000w8-Cx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j531P-0001AD-NX
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 02:46:52 -0500
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com
 ([40.107.243.47]:30816 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>)
 id 1j531P-00014N-EN; Fri, 21 Feb 2020 02:46:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qc5Abza1yDsWY3ZqtAoPxE6z8P5Y7ijTmVKHK2ZPV7XZjR2s5M52ySJBDMslrb8AcJwDXYokqbBepkjbFq28ujCPGBdALsK26Q5OcQhhVGyl9Xgi1RZqnIP3ffechzqSo65eWFL8EiyDRvUNZWJQA/ttpNrmczU2j/b4HNJ4WppZg1t7Hz9KbqVDMv6nrGvy1q7+VtyUUZSFTxuuvbO2eyreS6B4JGg6lKhZuNQdpQcIQnLvqkkD/X8bbdG85fRCjNrCeK7QiKYEF0wjbJyiBpLwnTuXpGLv0yGSyKUcXfHxCWCYx58IGWLIdgo+hLyjMiXAgEciQF/1F4njq+ysIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctg6ylU4WJvlXSjMYkgx6eFanXH84h/3L2dU/wS1b6U=;
 b=J5iIFXXJ3gd/iigCL5OwTuAl4NtS6trGAeyVa4jBha4F6W9tQr2PsYbiB0P3t9SPzSUzY/uxywIiWK0Cj4BkAYZJ4PBk8xGRQZXhWL0fT8LWZCwFgmjnNbiyGb4gptUItBvJJdv4xAK4IvCBbWxwknwwEFOW5hdZ9seqE+VAlQl6MtdDUglkMCOtJuE0k20cqGZwqF+bYYU3FhjBs1BwRfIWy+zfo3go1jk/WLnKMv14YO+2WKZw17GIlchS3DRH2SaNp13raqTFO7AtS/6/M1v+4aXSBKsobsYPOrCXL0yF3a7HP3XkJXV2pMlpBLzxlNhsvHu6ak42vdbc7W0k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=suse.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctg6ylU4WJvlXSjMYkgx6eFanXH84h/3L2dU/wS1b6U=;
 b=mWlKCGvMH61L572etutKMqU8hwk13FqyyfyI0YenmpebvI2Y3uDlpCSZLWL63z4SnjE8rWcVdQUNX1pi2Di4KX3WhdGTkEDf8bEW1Exj4RSAdHfgQVOh4YGcy49TNFekz9Ue7xW+gTnvq/HXrSffYMF7nGkxTvjTXYEX/H2LGz0=
Received: from BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28)
 by CH2PR02MB7045.namprd02.prod.outlook.com (2603:10b6:610:8b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 07:46:48 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BL0PR02CA0051.outlook.office365.com
 (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 07:46:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Fri, 21 Feb 2020 07:46:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j531K-0002CK-V9; Thu, 20 Feb 2020 23:46:46 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1j531F-0006Cg-S7; Thu, 20 Feb 2020 23:46:41 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01L7kfvl017851; 
 Thu, 20 Feb 2020 23:46:41 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1j531E-0006CW-QP; Thu, 20 Feb 2020 23:46:41 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 801DE13C0FD3; Fri, 21 Feb 2020 13:12:16 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anthony Liguori <anthony@codemonkey.ws>, afaerber@suse.de
Subject: [PATCH v2 2/3] cpu/a9mpcore: Set number of GIC priority bits to 5
Date: Fri, 21 Feb 2020 13:12:06 +0530
Message-Id: <1582270927-2568-3-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1582270927-2568-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(136003)(189003)(199004)(2616005)(4744005)(336012)(186003)(110136005)(81156014)(26005)(4326008)(5660300002)(2906002)(81166006)(42186006)(316002)(8676002)(8936002)(426003)(70206006)(70586007)(6266002)(6666004)(356004)(36756003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR02MB7045; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb82471-59c8-478b-c97d-08d7b6a23450
X-MS-TrafficTypeDiagnostic: CH2PR02MB7045:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7045193BA792FC8927C46915CA120@CH2PR02MB7045.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-Forefront-PRVS: 0320B28BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjkcSiGdRB6vtKdoXfMH5k9nV1su3D6M/JzaqWGe/Z44e8xgkySyohMjqBrss0RFWmzJ298k+9W2PYnzAbzUruJTB++QXbuRB8S/3OcK4ZKOtSvjzhoB6qguISyztYjz/thN8omlV9wzA2uMbFhB4fACYGIZGHI4YeBbcJqd/NqKV3GdDp8zv8aqF2g6V78LQi7qEqUWy4Zp9O20i4QZu5WaWq8pMmRAfNKL+asBxdJ2cYjwDDlWxmv3viz4Gxg5UPnwenhSzuUdXQnsGHeI1y/SLMpqHs81NZKHYXdNjS2ELY+3XJ7mM25wLMkKeybvX317xjbQ16dl8uCILEOdoB5K3BJ0SGRqBg4Bjrqxhh9r1Rwg+jIIzdleBG9gm4OR4gF8328c3DFX0pTyz12Vwz3mQkSVJCciqLHLOOIbp/2vU7M0X7vK1vWjNvfIgZO4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 07:46:47.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb82471-59c8-478b-c97d-08d7b6a23450
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7045
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.47
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

All A9 CPUs have a GIC with 5 bits of priority.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/cpu/a9mpcore.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 1f8bc8a..b4f6a7e 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -16,6 +16,8 @@
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 
+#define A9_GIC_NUM_PRIORITY_BITS    5
+
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
 {
     A9MPPrivState *s = (A9MPPrivState *)opaque;
@@ -68,6 +70,8 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&s->gic);
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
+    qdev_prop_set_uint32(gicdev, "num-priority-bits",
+                         A9_GIC_NUM_PRIORITY_BITS);
 
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
-- 
2.7.4


