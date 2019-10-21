Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEA3CA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC99E2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="N9eyPD/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC99E2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYu8-0003J4-QZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iMYrz-0001xT-5l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iMYry-00069W-2J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:41:15 -0400
Received: from mail-eopbgr720089.outbound.protection.outlook.com
 ([40.107.72.89]:20474 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iMYrx-00069J-Bf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:41:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJzgN5FltzpTfxnJFuX3duEO2OMQ9vUZZ+bT7mD0tgziGJZaHrhOZUbYX4JzCwXNaLLQ/Tw7qACvAsVD/c26s5wjJWnbZHR9JjTybGo0k8eOuRJEgC22W9WII5ys/+0A3gphZxTKFxDcfePpAaYlKkXQNMl2Y0lTpKo4L5PEua3+rk8xsvyijonwx7GcsKxsL0hBXlXxxW1YC2ekGvBX1vfTs9ZNy+UhGdQLNjr4/RJtT7saXex0RwR0Qg2ih6JorXyLQUXrmsQL8qL3eYoc58wMAr16URBfMZqOR9YQOQtQRqAXCQOxFzU8oluBx/Vm3COMzcQTi8eSNVh9J8lWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7LWbaTD9X7XOzbOy1SF5VfdO1yzAZWfk9kG7dyo/3g=;
 b=Qe/NcD/eIfb3vrAg2uN+R77CttOYsxLEZ8g3PN6d21k6Z4fkQSJGGUuz4pfUoAKtXCoi8RMUsVTSK8wy1u80IfK902tHHBJLu7bafhxYeCbo30IsJRy4HziP6air4Q5bZxQgdZgfKoayh5mZKdOIRqGUcv7Rwbl/qK7yQrX3zF7oM7bHVA40kcGtlaPEdFon6L+DJbLF85og/Rk3HjeQMGznX0Jv2x7p+D2CyAgO4J6YIU0antUaNruoKJuhJuGgZx7zLcft0Sqq0QWyE17xpWyxKRYXA8mrYRk64Ld5zu61NB4TM87w6aiJ8A1U9OM4TnJ0wUGFcFHywaIcxoCn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7LWbaTD9X7XOzbOy1SF5VfdO1yzAZWfk9kG7dyo/3g=;
 b=N9eyPD/n4wGcM9KS2v/h1+hCac0qS9TJI+fLR2hJqF7V6/OPRP6KMWX0zljRuiqFnpWOZUgAdJVJxLWscdykQSQ7oz7j4TGftOfOYZD52v9g10WkVB+NwPUqg2MblhOPJxSu4MSLKFT88oFjIBhLcuVa+D1tf2r3TY34+0RycyA=
Received: from MWHPR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:301:74::33) by BYAPR02MB4790.namprd02.prod.outlook.com
 (2603:10b6:a03:4e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Mon, 21 Oct
 2019 14:41:10 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by MWHPR0201CA0020.outlook.office365.com
 (2603:10b6:301:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 14:41:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Mon, 21 Oct 2019 14:41:09 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iMYrs-0006QX-W8; Mon, 21 Oct 2019 07:41:09 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <sai.pavan.boddu@xilinx.com>)
 id 1iMYrn-0006YF-UR; Mon, 21 Oct 2019 07:41:03 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9LEf3Yo024255; 
 Mon, 21 Oct 2019 07:41:03 -0700
Received: from [10.140.6.35] (helo=xhdsaipava40.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <saipava@xhdsaipava40.xilinx.com>)
 id 1iMYrm-0006Xi-Rt; Mon, 21 Oct 2019 07:41:03 -0700
Received: by xhdsaipava40.xilinx.com (Postfix, from userid 14131)
 id A733913C2174; Mon, 21 Oct 2019 20:11:53 +0530 (IST)
From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
To: Alistair Francis <alistair@alistair23.me>
Subject: [QEMU][PATCH v4] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
Date: Mon, 21 Oct 2019 20:11:51 +0530
Message-Id: <1571668911-8312-1-git-send-email-sai.pavan.boddu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(106002)(305945005)(316002)(8676002)(50226002)(48376002)(70206006)(14444005)(16586007)(42186006)(51416003)(54906003)(8936002)(81156014)(81166006)(103686004)(70586007)(478600001)(50466002)(336012)(26005)(47776003)(4326008)(426003)(486006)(2906002)(2616005)(36756003)(15650500001)(126002)(356004)(186003)(6266002)(6916009)(476003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4790; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; A:1; MX:1; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7a0c567-5bce-4b2f-5f27-08d75634b6a6
X-MS-TrafficTypeDiagnostic: BYAPR02MB4790:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4790C1DD66542800047A3FC3CA690@BYAPR02MB4790.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEpBeenGnLNjrdnZrUar/piI/6fU+kIxoA4ro0Sh4sjEgip5OfiH67Oo6OPpjLpvGK3AxkarN7VAAUtuwrI9A9DDyBzCBorffhu2yEh6F2mpOpt1wcDJ8Q/hllqATVg1tu/7oYj4VCeQA1wXY3vrMpKf4usYpRV+i6aqYgvuSuvwvyh8gxAF1dog3hxiAEjR0rz0xSNo7X6+Xy1cUJV5pEG3KDlGchM6gN7JWGOBRDUM9aW2PQc0T2JrnKYcD8hbgEG0FLwZUtkfTF3yLHu/wfzt15NKHeYXqkuOQSo5+zSZL3m3cGMu1MfF84U6DWJ8C3yiNlIJXqgKu5GqAE9yCatKS/Vf0wIupBAtqJyflzVALBgv77X8NQwR+NC+TKfQvAgPBLShOC+6FJ3qOfGJrCNvTfF97o03H513PzBZqeOqM04XnZQnAQemEKdlU8jo
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:41:09.6537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a0c567-5bce-4b2f-5f27-08d75634b6a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4790
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.89
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

A few of the register writes need not update the spi bus state, so just
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
Changes for V4:
	Move the register list to existing switch case above.

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


