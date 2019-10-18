Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDE7CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B83222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JDfoS8AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B83222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOFw-0004ts-4T
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iLOFE-0004TC-0f
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iLOFC-0003Ui-GG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:08:23 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com
 ([40.107.70.64]:64609 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iLOFC-0003U5-3X
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:08:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFg5hQsWpgk1534n1OjQIwxEQjyLWDhvFJEJZcZMHkOasGgUbF97++E2DCWh4Get3IaowGW2V3338OCZvxVkXm4zbk7+xocUDvW4qN5OYfHUc/rLJcuJie93M2k8ATkfgMHZ66A4s9a4/yqOY6yw3I9jEmP2onf8axjfnpwKJi6/eGur63LQndfzaxK1NbihE2Jl2c1mr5/yZwYkzDiJBhERmeta7PiKnQn5wI8bWU03Thh/M5nOty6ouB9GykjsWvcNIIysxUGIr957CncLUF217bn8mwajovN04IW29FnafZ+MxRb2c4hDBrIhfn/aimFYfyuumsVrmkW+KdbtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V/WtIo7vDt1fSByUP+AcQNDAjqdZDlxV3dPBZ+mBOo=;
 b=RzmhZoBokuEk7f6H34FxFNridGQP/QikJ2GtO2cs6vsAyXPAWWeGLuHxoplb1r+3byy45EX8z8hWegilFjJZtSgSxWuSkbRGHh/E8qHVGHZFFZdR9iQ5LA9Vt4gzuq9CM2GLuaZptALC7w+ucjo8UawCnz/4HSpHnldImsgG9CQ3e6lcqCzxo2M3OzCB10zRkabTDhTTwYgdoKyY1YQp5LHnWa2YGW3uk8cpTlapbHJpJC9uhAcxIg66SOxqiA/QjqRXE/HHzRmyWSq+lefx44R7FMtW1pqbOblOKbXopo9ZbzwPeXsJjKjk6Ks0hdctQPTr84BZsyNFZZrx2qZtmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=alistair23.me smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2V/WtIo7vDt1fSByUP+AcQNDAjqdZDlxV3dPBZ+mBOo=;
 b=JDfoS8AWeNSl5GO3eld3zOVC3VuKO+yLCPR6u8sM+ItUuA0CGQ7xG9b+K0EeF6BviKDDwDRiJ0v9raGRDEQyQzpiC9DeKRkCnOOwXPfpUEfQMyKfEM2DrN4yj4Qg0ttoaUfl8Xt563WkXRw45YpigzHVDOp5f7Eo4jgeWI9t4Ds=
Received: from MWHPR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:301:74::25) by DM6PR02MB5483.namprd02.prod.outlook.com
 (2603:10b6:5:7a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Fri, 18 Oct
 2019 09:08:19 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR0201CA0012.outlook.office365.com
 (2603:10b6:301:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Fri, 18 Oct 2019 09:08:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; alistair23.me; dkim=none (message not signed)
 header.d=none;alistair23.me; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Fri, 18 Oct 2019 09:08:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iLOF8-0004ER-AX; Fri, 18 Oct 2019 02:08:18 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iLOF2-0003TF-NM; Fri, 18 Oct 2019 02:08:12 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iLOF2-0003T3-0g; Fri, 18 Oct 2019 02:08:12 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A6BC713C1372; Fri, 18 Oct 2019 14:39:11 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3] ssi: xilinx_spips: Skip spi bus update for few register
 writes
Date: Fri, 18 Oct 2019 14:39:04 +0530
Message-Id: <1571389744-11740-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(54906003)(16586007)(42186006)(2906002)(70586007)(316002)(14444005)(47776003)(305945005)(486006)(476003)(5660300002)(106002)(15650500001)(2616005)(50466002)(126002)(26005)(81166006)(6916009)(81156014)(50226002)(8676002)(336012)(6666004)(478600001)(8936002)(36756003)(103686004)(4326008)(48376002)(356004)(426003)(6266002)(70206006)(51416003)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB5483; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6e32476-49a1-48da-50f3-08d753aab7cd
X-MS-TrafficTypeDiagnostic: DM6PR02MB5483:
X-Microsoft-Antispam-PRVS: <DM6PR02MB548304A72AAB9879E0E6EFDDCA6C0@DM6PR02MB5483.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-Forefront-PRVS: 01949FE337
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCWCgis/eS3gJQj3fcE7UXMF3xl2qmbcEhnEBwnUj/s0XjcDQhnl711L9OpOPZdoj5ARZEQtDsHwD05UffnMcVySlR0nud8iW8SkfMdFeeLT31TEfe5V+7l5CEdgtHo0bt0QWYBVRRKQUEpbwxjlFcZ9YVbTndpO/F0FVgEi4VGPo4lMvYe9elKLlG36vdif9okSTpmyP6/qP3jS2l0Aj4XYpH2S0tOBGvxULMQS3L3Dn3+peim4a/Ba1tEOwiqXN7nkZF6KCGuoSzd0YY1tUWOajNo8Gz2zXFfk9WFUiipjd8UEAv8V0X8Y0gX9F11ne1kvFGmtTWwKvo21loIITSYfwPOAycoFQY5BCocAChmNWh+pfDPd6wuFRvroA3HzrESxjNcgfOMTRjaIMVJFOrKJSp+DZcu3MHKpQkcfOVE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2019 09:08:18.8035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e32476-49a1-48da-50f3-08d753aab7cd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5483
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.64
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
 qemu-devel@nongnu.org, Francisco Iglesias <frasse.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few of the register writes need not update the spi bus state, so just
return after reg write. Added few more dummy register offsets which need
the same behaviour.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
---
Changes for V2:
	Just skip update of spips cs and fifos
	Update commit message accordingly
Changes for V3:
	Avoid checking for zynqmp qspi
	Skip spi bus update for few of the registers

 hw/ssi/xilinx_spips.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c71..c23de47 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -109,6 +109,7 @@
 #define R_GPIO              (0x30 / 4)
 #define R_LPBK_DLY_ADJ      (0x38 / 4)
 #define R_LPBK_DLY_ADJ_RESET (0x33)
+#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
 #define R_TXD1              (0x80 / 4)
 #define R_TXD2              (0x84 / 4)
 #define R_TXD3              (0x88 / 4)
@@ -139,6 +140,8 @@
 #define R_LQSPI_STS         (0xA4 / 4)
 #define LQSPI_STS_WR_RECVD      (1 << 1)
 
+#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
+#define R_ECO               (0xF8 / 4)
 #define R_MOD_ID            (0xFC / 4)
 
 #define R_GQSPI_SELECT          (0x144 / 4)
@@ -1022,6 +1025,15 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
+    /* Skip SPI bus update for below registers writes */
+    switch (addr) {
+    case R_GPIO:
+    case R_LPBK_DLY_ADJ:
+    case R_IOU_TAPDLY_BYPASS:
+    case R_DUMMY_CYCLE_EN:
+    case R_ECO:
+        return;
+    }
     xilinx_spips_update_cs_lines(s);
     xilinx_spips_check_flush(s);
     xilinx_spips_update_cs_lines(s);
-- 
2.7.4


