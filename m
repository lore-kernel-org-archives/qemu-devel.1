Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C95C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5166208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 22:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qWhA/yZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5166208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHwj0-0006AV-UK
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 18:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHwfD-00023R-K8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:09:31 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com
 ([40.107.92.41]:30816 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kHwfB-0000bG-Kp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 18:09:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy95rqLUDeBJGKC+3Hio239+uBtkz82ipA+ddA/YWArpo31KbST/LWvm5q4m9kN63Rei3Mf6nkKcy6iCRasiFgx3HEFgmAXJLYjUN9n1A6BjAiZ+R8a00VhNCPF6ND7QiHmzRIHUjtrX2d8VDcL3+lsHylcjjdOnPSH3Z2AIG0mBhYissPlMDMC5LiKTr2jlutrB1dNmwRREpKOPY89OOXmIS8GGehwCRhZR8UQ+G69OCuTqpFZ8V0k4b7yGQUk4DTD1Yo/IfAHOdu3U+8waVEQ/+P0MZ1Uhlp6YNFP+mufO6bkKi7LhAP06ywwvihf1+eLL1C0ib7TxV6WZwozK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4PNk8X1Y6UouQFxlXBjBuJd7p/B5lfjCLCLCsGHQYM=;
 b=QeYRqwJIBS3iS24TeBXRiJ4UgqdeavOi/RsZ5mQjxcq5jLs/bXH0USpevrUlp0aGSUC7M+wNQbclP6HG41w59nAoQnXYxi6Pd+BScVFAEqzZ7H6ovxViDvxsElmpdMWghfJIhKsUSYxaMm39F3j2to0wYmXb5jm1RtmmQSAUdczTXu/yaFuPKNQPGZA9c1tFJRdm3sFr+50wwraGsOSV+DemLH5Ky6eWiBjQ8skk6Z6wwXvUHdc5FzBA2R0mSOWtHG1x+YmMd2bvMmyrN7tEx014Tf+CLMLw6qCNyD0xy1FOyXQOhJq0SJkxBgTUAMyTbWU5i31EKHfmPJAB+WwWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4PNk8X1Y6UouQFxlXBjBuJd7p/B5lfjCLCLCsGHQYM=;
 b=qWhA/yZnP1Z5DXMVEH/1dmEHQM1vSk1yPc0i2xSyMvbjyHEatorQ3/pBSjZebesSrvzEpl+rUQZ9HtTDhciwKw+IDJtv4d6L+afB3i/yfZjbrjyAj3EjqP0cPg8QC9u/ro6G9UI6vNhX9eiW/hXXkCBZua/vaD5NPjouKNo/uqg=
Received: from CY4PR18CA0025.namprd18.prod.outlook.com (2603:10b6:903:9a::11)
 by DM5PR0201MB3478.namprd02.prod.outlook.com (2603:10b6:4:76::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 22:09:28 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:9a:cafe::b2) by CY4PR18CA0025.outlook.office365.com
 (2603:10b6:903:9a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 22:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 22:09:27
 +0000
Received: from [149.199.38.66] (port=48402 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHwf4-0003rr-VJ; Mon, 14 Sep 2020 15:09:22 -0700
Received: from [127.0.0.1] (helo=localhost)
 by smtp.xilinx.com with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHwf9-0006oW-9x; Mon, 14 Sep 2020 15:09:27 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08EM9IcT016843; 
 Mon, 14 Sep 2020 15:09:18 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1kHwez-0006b8-UB; Mon, 14 Sep 2020 15:09:17 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/4] MAINTAINERS: Add maintainer entry for Xilinx ZynqMP
 CAN controller
Date: Mon, 14 Sep 2020 15:08:44 -0700
Message-Id: <1600121324-31337-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600121324-31337-1-git-send-email-fnu.vikram@xilinx.com>
References: <1600121324-31337-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8af008e2-c20b-4dae-f647-08d858fad90e
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3478:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB34784456C5218DAC126D68ECBC230@DM5PR0201MB3478.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Of7ZErmDB2e3zdOyzf7MkA1a3GSBbLRCgmcADzvRQx9eYkZvj6onoLSUe3irVQUlaPWprZddemiroBoS6lbYYUFixN5D7r6ZCIbN9rWJ5tsqPicY5MWSLGXPdnhWLkWsOaHsYysfx5A22buVC91ARuJAU146MPROAD5WqfzNPLyIgt+QOJovYdIYt2WTQi7vunxDtOp2T4XGbHPIC8b7goJBTberR/wtMOpNRKyLGIe17IqTfGmQi9HJoJSXnxPtNjK6ijFoOPBGfn3gSq0PHNAYTlSsXTvWy9Sl22IWazvRU8y2IMQziN55UPgJGOSiyxg7fsHdZ6b0+KKntvaZyCkOREjzKjuFOccs67UqAV/Gkii95F9a6RPJkpR6v6htY6hL+FGsjCKk5+F8Ew8kSw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(346002)(39860400002)(376002)(136003)(396003)(46966005)(5660300002)(356005)(82310400003)(478600001)(4744005)(6916009)(82740400003)(81166007)(8936002)(8676002)(47076004)(9786002)(70206006)(6666004)(7696005)(186003)(426003)(26005)(2906002)(336012)(36756003)(316002)(70586007)(107886003)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 22:09:27.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af008e2-c20b-4dae-f647-08d858fad90e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3478
Received-SPF: pass client-ip=40.107.92.41; envelope-from=fnuv@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 18:09:28
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
Cc: francisco.iglesias@xilinx.com, Vikram Garhwal <fnu.vikram@xilinx.com>,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad..3ed61d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1557,6 +1557,14 @@ F: hw/net/opencores_eth.c
 
 Devices
 -------
+Xilinx CAN
+M: Vikram Garhwal <fnu.vikram@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+S: Maintained
+F: hw/net/can/xlnx-*
+F: include/hw/net/xlnx-*
+F: tests/qtest/xlnx-can-test*
+
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
 S: Maintained
-- 
2.7.4


