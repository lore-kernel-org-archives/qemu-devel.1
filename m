Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D0AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB612073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UiNetkCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB612073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdHc-0003WW-Rq
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iVdGg-0002yh-IG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iVdGf-0000nA-8x
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:12:14 -0500
Received: from mail-eopbgr770071.outbound.protection.outlook.com
 ([40.107.77.71]:18247 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iVdGe-0000mT-Tg
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:12:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSLGhr/nMoBHD3rNRaui9vPaNqAFAhQAQAT1MDqr2+/IOQkXj4ggto+ApYWJePJzdJUOD5zk3glfix6Km3qV07H96ehaYM9Fi5c5R1VurdByHbDyqaJMpNV97zAlFSg1aSEqUMSrnuP6SQNDdk/0ntfhC5Ojh3s6doE3aQaVRTXxEgbN5E5bO7y26ocqptw0RypL7lDmaNNNEIQwUui8mR/2EqV3xlbBERXbCXUgFpOxO4qOFS32rca/GTmUVUrb541o2Cq3/xSuXLRSK3XgOjYCWh1XPlg16KNYFi07r9uQI6W3h4c3uiMTgjJ9+TDmEgzX2ZBqwAWSYv9rU8d1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcSZkfT9zFhI6xBnIIwN4kAqDvnvCGqp1GMg90KEGOQ=;
 b=FVI46ucPZzRN8V6Yv5iO4NTAldHWIpXfJCuMHE/3INJCAZHmElpjQXq4cxDi+Znx3NJrCM681mEjKp/sBKXXHq8zZXkUjcz82n5tKeez1IyQzS/0fwtzXsEY4Y13cuhWLjyiV9s4ePLGhB1X046xHKWIukrkN+oDh752Dg7Ys1WqmOmtS8ED2prx0r9DMExpEDta0BbUx23DxkIrPpvRp+KATaMpqzMcui+nv8faRNLFgwWTJ4C3NCtahitgMDwiqmRn9cOCpzLNJLoOj9aSUCp0HXqQOurDwzhQgq15AqpcLMDgB0Fk3+ReH+RyinPGyiE8xfhaDi3BYaOYWm6ShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=wdc.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcSZkfT9zFhI6xBnIIwN4kAqDvnvCGqp1GMg90KEGOQ=;
 b=UiNetkCOHCBqnwH72G4mMRD5Qig9oaJ5lUevKYK1sfwRozFoSUK/fCq+cRwHED5ctrC3ue8OqPavO2Nv7HMWBP0UZlb1jMVkeR5r+pbdQbedAIE4nMselloJ62mxhozOtZlfdVKviqQUm736pq8mIzJSG9QDecqlHy95Z539ziw=
Received: from SN4PR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:803:2e::29) by BN6PR02MB2467.namprd02.prod.outlook.com
 (2603:10b6:404:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Fri, 15 Nov
 2019 15:12:10 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by SN4PR0201CA0043.outlook.office365.com
 (2603:10b6:803:2e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Fri, 15 Nov 2019 15:12:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 15:12:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iVdGb-0006tE-7R; Fri, 15 Nov 2019 07:12:09 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iVdGW-00023y-3G; Fri, 15 Nov 2019 07:12:04 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAFFC3eZ023876; 
 Fri, 15 Nov 2019 07:12:03 -0800
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iVdGU-00023d-V0; Fri, 15 Nov 2019 07:12:03 -0800
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id D4B8B13C1F8A; Fri, 15 Nov 2019 20:41:49 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: [PATCH v6] ssi: xilinx_spips: Skip spi bus update for a few register
 writes
Date: Fri, 15 Nov 2019 20:41:45 +0530
Message-Id: <1573830705-14579-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(199004)(189003)(6666004)(14444005)(47776003)(2906002)(356004)(126002)(486006)(103686004)(106002)(70586007)(70206006)(476003)(6266002)(426003)(336012)(4326008)(305945005)(2616005)(5660300002)(15650500001)(478600001)(51416003)(81166006)(81156014)(8936002)(8676002)(110136005)(16586007)(42186006)(316002)(186003)(50466002)(48376002)(50226002)(36756003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR02MB2467; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a2caad-1b6c-436b-c280-08d769de2f9c
X-MS-TrafficTypeDiagnostic: BN6PR02MB2467:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24679A62CEA994F6D5800D70CA700@BN6PR02MB2467.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFQQNV60ZuR0z9LrRphPQb40iA+kRMXG93HmQtJ2uZl/kcu8u6dGd3z3f/Z4z3MrmeckIdZL0qDmnvBxkwFrra2aAMZfEqK59eoOqc13jASGZdzjQR7UUlo0NTVF6y4m6QCEShEG/6rwheBzYgDt1wCKNBGsdAItovuawbneyxMv254oVeOGjMMBFvzmsuZFEyicUUes6lIcHqC6c4ZKEvbkdiLpw3J3sIMftIAVu+VjZ7zXNfaLHxqWWKo52kNAShItRNWTLHgDirybZKtqxpUEx2RxSURsIkIuNTGo9mQf2+/KHMlpLRddMcHAFxavyaEmm8D1f5YFqWl1tKasgfJZqy3dC7RQ9nGLiBmGnG3LmxiwF87F0pO4whLAxDcSTQg3vcXe3CoNe4GtwlOsmrfGqt7SEgWQlOFqD1hmexJESuyeKg4r+UJwSxc96ELy
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 15:12:09.6951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a2caad-1b6c-436b-c280-08d769de2f9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2467
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.71
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A few configuration register writes need not update the spi bus state, so just
return after the register write.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---

Changes for V2:
	Just skip update of spips cs and fifos
	Update commit message accordingly
Changes for V4:
	Avoid checking for zynqmp qspi
	Skip spi bus update for few of the registers Changes for V4:
	Move the register list to existing switch case above.
Changes for V5:
	Fixed Commit message.
Changes for V6:
	Fixed commit message. Added Review tags.

Note: Resending this as it got filtered for first two attempts.


 hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a309c71..0d6c2e1 100644
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
@@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
 {
     int mask = ~0;
     XilinxSPIPS *s = opaque;
+    bool try_flush = true;
 
     DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
     addr >>= 2;
@@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
         tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
                       s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
         goto no_reg_update;
+    /* Skip SPI bus update for below registers writes */
+    case R_GPIO:
+    case R_LPBK_DLY_ADJ:
+    case R_IOU_TAPDLY_BYPASS:
+    case R_DUMMY_CYCLE_EN:
+    case R_ECO:
+        try_flush = false;
+        break;
     }
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_check_flush(s);
-    xilinx_spips_update_cs_lines(s);
-    xilinx_spips_update_ixr(s);
+    if (try_flush) {
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_check_flush(s);
+        xilinx_spips_update_cs_lines(s);
+        xilinx_spips_update_ixr(s);
+    }
 }
 
 static const MemoryRegionOps spips_ops = {
-- 
2.7.4


