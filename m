Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE7FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF102082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dOxv4NW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF102082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2rL-0007rq-9u
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 06:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iL2qJ-0007Sk-UV
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iL2qG-0004hA-Qu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:17:15 -0400
Received: from mail-eopbgr710067.outbound.protection.outlook.com
 ([40.107.71.67]:19776 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iL2qG-0004fy-G6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 06:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiocStVjvu9TfTr3HHay+iHUl/yl/fNlmwysUI+PDPYkczjzB9HYpbSrCIpqmi+bLOG8IHnfOihdFtErcNkar6TuLzMXQEonp2AFrYAhy6Dvwa8fJrFnBXpX9dOdGXLMeEVHL/VOYIAsG1+lCWZhvbBxfi/3jnss+hNy8CcI5mNCMLqWkIATwT3G3Cplk7CrSGy4ojON9c0toUmJjZxP3llrJ7Y8xq3wC5Al6u+xPi9MVS5U7WJGRVCTijVOTqb414APcHypBmBGbyn5cxGTxxt3ScWMCRHN6q0agtEBvrHaIP/rYB06yM8Qw489YL30NhrOKuTfvsPeif9HY2m9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhVUCO+uFpVCnvm5LrZO3HOZkuHgWoGzytwH0WzfeWE=;
 b=hsyxR6jb+X+VTT7IsFkhlMIS9x8g6HZHEB1342dQ4XDsxSSnmvrclUczn3OCBjiVGNrWUWYjI3mGDaL9RyMwxP2vAz9grQuq3vYcf+bKgkfddOE7G09+1ePeMku5VwenaEKsdleuIDQJ0a/L+1P0Ml5uVJ3ZGWFvK+syLQA2GFs5DDpwMofTWV2EBYiJHx85kbwgDvOXfu7Uy8jFZRe0SHPZccP+gNcmipqjPcLckS7/SUi0d7FM489nYahkzs7rBaw8KszfZv2PwU8eDgyche9OiH/Aez/a1n45bK1uQDqYksL6oyAiA4+yja639t7nQ6ndGiP90NfT6bd87n05UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=alistair23.me smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhVUCO+uFpVCnvm5LrZO3HOZkuHgWoGzytwH0WzfeWE=;
 b=dOxv4NW7XeMyml2Ro/eh48wmU7/5jULUqWbpP8KJShyRlXcDX2Mz/ieZ4wb1FNttP0KAzk+RLck1mvHVTB+8y4O87bx9R/H2Sv1OKMrACLfnwzAzsTgzNAi90KcJjppwEKWm4z8yy/H87p8YZb62DHf0+n0lUGasqXEmLha9YkA=
Received: from MWHPR02CA0025.namprd02.prod.outlook.com (2603:10b6:301:60::14)
 by SN1PR02MB3677.namprd02.prod.outlook.com (2603:10b6:802:2d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Thu, 17 Oct
 2019 10:17:09 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by MWHPR02CA0025.outlook.office365.com
 (2603:10b6:301:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Thu, 17 Oct 2019 10:17:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; alistair23.me; dkim=none (message not signed)
 header.d=none;alistair23.me; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Thu, 17 Oct 2019 10:17:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iL2qB-00057m-SJ; Thu, 17 Oct 2019 03:17:07 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iL2q6-0007BS-OD; Thu, 17 Oct 2019 03:17:02 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iL2q5-00079h-VS; Thu, 17 Oct 2019 03:17:02 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id 8DD3C13C017A; Thu, 17 Oct 2019 15:48:03 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair@alistair23.me>
Subject: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fifo
 releated to spips in gqspi
Date: Thu, 17 Oct 2019 15:47:54 +0530
Message-Id: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(48376002)(14444005)(186003)(70586007)(50226002)(81156014)(81166006)(8676002)(478600001)(47776003)(6266002)(36756003)(70206006)(8936002)(316002)(51416003)(305945005)(4326008)(486006)(6916009)(6666004)(5660300002)(50466002)(356004)(26005)(103686004)(476003)(2906002)(126002)(426003)(42186006)(106002)(336012)(2616005)(15650500001)(16586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR02MB3677; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 433cb79d-83b8-4c4d-680b-08d752eb2ad9
X-MS-TrafficTypeDiagnostic: SN1PR02MB3677:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3677D01CBEE5C4065F49D032CA6D0@SN1PR02MB3677.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-Forefront-PRVS: 01930B2BA8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQTY1To18SYh9wR4qYMjDS15t6qy67gbDndnR2dnl2NUWnYotEHawe1Iot/JSc3K6XCiQFfvXEH0JKeCKR4Su8K63Cb7gvTqwLLAzuo4L2N6Uwtr1q3M1p71nI+y66XeBaf4EhjdBncI3qBHW+qJ2Ju18ixQe01Cu3JHOems+C96BSE5GyMg2l9wZJZTuMPK+9QyE553+4tki3h7YfqIVTxS+Ajnwgs0jClu7I6t3EC8+OqWCXQOnRr29M0d5bih3+Y9+/bFI+i4/uLRFBeB30a/816MBkKri3ig8qps+cASUpfbzG3VNKjMnxzg2eIAwQHT60UGJ4u563nVTWCyRLx3GVnLlrgwMy5iRTF0K+Nmlm52VQ4KL4GPdSwyyuz+oNxhvQGGsQ4XiczCB45WpYKBIhGROaLGcC5fMybDcLs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2019 10:17:08.4146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433cb79d-83b8-4c4d-680b-08d752eb2ad9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3677
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.67
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
Cc: edgar.iglesias@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GQSPI handles chip selects and fifos in a different way compared to
spips. So skip update of cs and fifos related to spips in gqspi mode.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
Changes for V2:
    Just skip update of spips cs and fifos
    Update commit message accordingly

 hw/ssi/xilinx_spips.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c71..27154b0 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1022,6 +1022,13 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
+    /* In GQSPI mode skip update of CS and fifo's related to spips */
+    if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {
+        XlnxZynqMPQSPIPS *ss = XLNX_ZYNQMP_QSPIPS(s);
+        if (ARRAY_FIELD_EX32(ss->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
+            return;
+        }
+    }
     xilinx_spips_update_cs_lines(s);
     xilinx_spips_check_flush(s);
     xilinx_spips_update_cs_lines(s);
-- 
2.7.4


