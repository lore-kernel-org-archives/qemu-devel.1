Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5504BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEFC208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 23:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qxrIOWde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEFC208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnsIe-0000W5-2l
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 19:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsHB-0006jZ-0Z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:24:25 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com
 ([40.107.93.60]:6206 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1jnsH7-0004br-Aa
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 19:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyTPtpqpf/6BGIboR0gxTcUYWo/la4JEdPXk4drKQheOQvrT4Uyxkn9C0R/TzxAqsvwkJayjfou3OKJjQ//JE6crSFLQycKn1ulbD9rocDl8XobCUd16OWE5SgxBNPm7yaOjydYaqgaoeaPWpQL/fSocWcPXJdl3QA95LbsXriQB1cwMRQHqcXxeyPy1/WYNHA4bnFjf66M8xI8/bvq0vKDMtcDySQO+iifO4YVFkRpQyqioXqZxM0VBorErFgKyOaLv8AIaRTnXeJxOySpKb94VVEle5ZMiJcXOAziRRaRe4HmXxbrqLJkwuwl3WI2MEghYvUASF4PHn/2No9XO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bICFzSz4m7cu/z5CH0C3NThfkcj6qLrpTwGYf8zL+c=;
 b=QfR6eZ7y5WlWqtXwNh08KbkOqwroBA9FGg1ujJPWPsZ2Ta8YODu4DGXmVVqlNnE7rtIhENWFaCFckOMXoupEoirNILCcFIeLFTOofmi3A/+XesvK9GtFx8Sgkz+Fc8Ut6FzlW+2roO1hBWUqr50Gvy7AuXw57XzYnooR3UUw09BNXoWRLsZfOELiaLQDJ9Rl7ODaN7sNEpWAQ3tXwQ/g7eSdRsrdynnELZkQGz0cLms/ELh6bxVoXhWeCJJ+hhEWkoI7EfqBBlEZWibU1OQUgyx8p85Un5F79j15QLyopxEthz0ib9yDx4+cAJ/dOushnfIqKeqh6uGUJzD7Jmpy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bICFzSz4m7cu/z5CH0C3NThfkcj6qLrpTwGYf8zL+c=;
 b=qxrIOWdeOWVmUM0UGBo53LXRzSJXV5Zlbm3p86/kYhxp6mWbr5JsYtSBG1R4OXGslTABPmHoHIG+79+n0XnYeoIaPglsvnccbzW4wvH2R0U1FM02jVPSYtlaiajOD+F996WjAr6OBbbAlTDBUrAsPzIiEEOikIJ9v0UasU9Lr0I=
Received: from SN4PR0601CA0016.namprd06.prod.outlook.com
 (2603:10b6:803:2f::26) by SN6PR02MB4096.namprd02.prod.outlook.com
 (2603:10b6:805:2b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 23:24:17 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::d8) by SN4PR0601CA0016.outlook.office365.com
 (2603:10b6:803:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 23:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 23:24:17
 +0000
Received: from [149.199.38.66] (port=36397 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsFr-00009z-PP; Tue, 23 Jun 2020 16:23:03 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsH2-0008DN-SY; Tue, 23 Jun 2020 16:24:16 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05NNOAP7019173; 
 Tue, 23 Jun 2020 16:24:10 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jnsGw-00084e-8v; Tue, 23 Jun 2020 16:24:10 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] tests/qtest: Introduce tests for Xilinx ZynqMP CAN
 controller
Date: Tue, 23 Jun 2020 16:23:35 -0700
Message-Id: <1592954616-65393-4-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
References: <1592954616-65393-1-git-send-email-fnu.vikram@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(39850400004)(346002)(376002)(136003)(396003)(46966005)(6916009)(6666004)(478600001)(316002)(2906002)(5660300002)(7696005)(336012)(81166007)(356005)(82740400003)(70586007)(83380400001)(47076004)(30864003)(70206006)(82310400002)(2616005)(54906003)(4326008)(8676002)(186003)(26005)(36756003)(426003)(8936002)(9786002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38c6c3a2-678a-44f7-1c12-08d817cc8c8d
X-MS-TrafficTypeDiagnostic: SN6PR02MB4096:
X-Microsoft-Antispam-PRVS: <SN6PR02MB409666336C2CD411FA166C94BC940@SN6PR02MB4096.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XU/4CTw2uEcofmAl65MwjQKjIxbgPI+i2dTf+CzyAD6SXNQJO32CwmovpzgqsdN70SUP/s/A7eO6w/MIjcGaw64f8nKqdbQslYMr9HoZZDDbAp5bwZ5plK5u2e3ZPZjs965eXGD6/Xu0YXjBZR0JHH/nJpEJOZkWyRlRyTZLy91Ig8ZTjc+J4ONSEtOC5Tik98wpBlShL9WQCujymqD/mS1FIVdY2kLxsiF48DKGaTmli1aG+aNJBPOIcbypwIyxIChGY/sqpLPD4i052Ox92BYxn77jhvhxpXJemhxrMTbmBggtgYtUeFCl9z/1WNJBIhxY2X1juDpaON1OpEuCn9wdEWyuYZaHTssxBItD6BrRwCF0wDVwWQEwxAsTT8cGSaGgUxSRQWF0qY27UrGYEQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 23:24:17.1690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c6c3a2-678a-44f7-1c12-08d817cc8c8d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4096
Received-SPF: pass client-ip=40.107.93.60; envelope-from=fnuv@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 19:24:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, francisco.iglesias@xilinx.com,
 Thomas Huth <thuth@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QTests perform five tests on the Xilinx ZynqMP CAN controller:
    Tests the CAN controller in loopback, sleep and snoop mode.
    Tests filtering of incoming CAN messages.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 tests/qtest/Makefile.include |   2 +
 tests/qtest/xlnx-can-test.c  | 367 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 369 insertions(+)
 create mode 100644 tests/qtest/xlnx-can-test.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 98af2c2..1f21f8f 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -136,6 +136,7 @@ check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-swtpm-test
 check-qtest-aarch64-y += numa-test
 check-qtest-aarch64-y += boot-serial-test
 check-qtest-aarch64-y += migration-test
+check-qtest-aarch64-y += xlnx-can-test
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
 ifneq ($(ARCH),arm)
@@ -266,6 +267,7 @@ tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
 	tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
 tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sector.o $(libqos-obj-y)
 tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
+tests/qtest/xlnx-can-test$(EXESUF): tests/qtest/xlnx-can-test.o
 tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
 tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-obj-y)
 tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
diff --git a/tests/qtest/xlnx-can-test.c b/tests/qtest/xlnx-can-test.c
new file mode 100644
index 0000000..54af876
--- /dev/null
+++ b/tests/qtest/xlnx-can-test.c
@@ -0,0 +1,367 @@
+/*
+ * QTests for the Xilinx ZynqMP CAN controller.
+ *
+ * Copyright (c) 2020 Xilinx Inc.
+ *
+ * Written-by: Vikram Garhwal<fnu.vikram@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* Xlnx-CAN base address. */
+#define CAN0_BASE_ADDR          0xFF060000
+#define CAN1_BASE_ADDR          0xFF070000
+
+/* Register address in Xlnx-CAN. */
+#define R_SRR_OFFSET            0x00
+#define R_MSR_OFFSET            0x04
+#define R_SR_OFFSET             0x18
+#define R_ISR_OFFSET            0x1C
+#define R_ICR_OFFSET            0x24
+#define R_TXID_OFFSET           0x30
+#define R_TXDLC_OFFSET          0x34
+#define R_TXDATA1_OFFSET        0x38
+#define R_TXDATA2_OFFSET        0x3C
+#define R_RXID_OFFSET           0x50
+#define R_RXDLC_OFFSET          0x54
+#define R_RXDATA1_OFFSET        0x58
+#define R_RXDATA2_OFFSET        0x5C
+#define R_AFR                   0x60
+#define R_AFMR1                 0x64
+#define R_AFIR1                 0x68
+#define R_AFMR2                 0x6C
+#define R_AFIR2                 0x70
+#define R_AFMR3                 0x74
+#define R_AFIR3                 0x78
+#define R_AFMR4                 0x7C
+#define R_AFIR4                 0x80
+
+/* CAN modes. */
+#define CONFIG_MODE             0x00
+#define NORMAL_MODE             0x00
+#define LOOPBACK_MODE           0x02
+#define SNOOP_MODE              0x04
+#define SLEEP_MODE              0x01
+#define ENABLE_CAN              (1 << 1)
+#define STATUS_NORMAL_MODE      (1 << 3)
+#define STATUS_LOOPBACK_MODE    (1 << 1)
+#define STATUS_SNOOP_MODE       (1 << 12)
+#define STATUS_SLEEP_MODE       (1 << 2)
+#define ISR_TXOK                (1 << 1)
+#define ISR_RXOK                (1 << 4)
+
+static void match_rx_tx_data(uint32_t *buf_tx, uint32_t *buf_rx,
+                             uint8_t can_timestamp)
+{
+    uint16_t size = 0;
+    uint8_t len = 4;
+
+    while (size < len) {
+        if (R_RXID_OFFSET + 4 * size == R_RXDLC_OFFSET)  {
+            g_assert_cmpint(buf_rx[size], ==, buf_tx[size] + can_timestamp);
+        } else {
+            g_assert_cmpint(buf_rx[size], ==, buf_tx[size]);
+        }
+
+        size++;
+    }
+}
+
+static void read_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_rx)
+{
+    uint32_t int_status;
+
+    /* Read the interrupt on CAN rx. */
+    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_RXOK;
+
+    g_assert_cmpint(int_status, ==, ISR_RXOK);
+
+    /* Read the RX register data for CAN. */
+    buf_rx[0] = qtest_readl(qts, can_base_addr + R_RXID_OFFSET);
+    buf_rx[1] = qtest_readl(qts, can_base_addr + R_RXDLC_OFFSET);
+    buf_rx[2] = qtest_readl(qts, can_base_addr + R_RXDATA1_OFFSET);
+    buf_rx[3] = qtest_readl(qts, can_base_addr + R_RXDATA2_OFFSET);
+
+    /* Clear the RX interrupt. */
+    qtest_writel(qts, CAN1_BASE_ADDR + R_ICR_OFFSET, ISR_RXOK);
+}
+
+static void send_data(QTestState *qts, uint64_t can_base_addr, uint32_t *buf_tx)
+{
+    uint32_t int_status;
+
+    /* Write the TX register data for CAN. */
+    qtest_writel(qts, can_base_addr + R_TXID_OFFSET, buf_tx[0]);
+    qtest_writel(qts, can_base_addr + R_TXDLC_OFFSET, buf_tx[1]);
+    qtest_writel(qts, can_base_addr + R_TXDATA1_OFFSET, buf_tx[2]);
+    qtest_writel(qts, can_base_addr + R_TXDATA2_OFFSET, buf_tx[3]);
+
+    /* Read the interrupt on CAN for tx. */
+    int_status = qtest_readl(qts, can_base_addr + R_ISR_OFFSET) & ISR_TXOK;
+
+    g_assert_cmpint(int_status, ==, ISR_TXOK);
+
+    /* Clear the interrupt for tx. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_ICR_OFFSET, ISR_TXOK);
+}
+
+/*
+ * This test will be transferring data from CAN0 and CAN1 through canbus. CAN0
+ * initiate the data transfer to can-bus, CAN1 receives the data. Test compares
+ * the data sent from CAN0 with received on CAN1.
+ */
+static void test_can_bus(void)
+{
+    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };
+    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+    uint8_t can_timestamp = 0;
+
+    QTestState *qts = qtest_init("-m 4G -machine xlnx-zcu102"
+                " -object can-bus,id=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus0"
+                );
+
+    /* Configure the CAN0 and CAN1. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+
+    /* Check here if CAN0 and CAN1 are in normal mode. */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    send_data(qts, CAN0_BASE_ADDR, buf_tx);
+
+    can_timestamp += 1;
+
+    read_data(qts, CAN1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
+
+    qtest_quit(qts);
+}
+
+/*
+ * This test is performing loopback mode on CAN0 and CAN1. Data sent from TX of
+ * each CAN0 and CAN1 are compared with RX register data for respective CAN.
+ */
+static void test_can_loopback(void)
+{
+    uint32_t buf_tx[4] = { 0xFF, 0x80000000, 0x12345678, 0x87654321 };
+    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+
+    QTestState *qts = qtest_init("-machine xlnx-zcu102"
+                " -object can-bus,id=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus0"
+                );
+
+    /* Configure the CAN0 in loopback mode. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+
+    /* Check here if CAN0 is set in loopback mode. */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+
+    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
+
+    send_data(qts, CAN0_BASE_ADDR, buf_tx);
+    read_data(qts, CAN0_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, 0);
+
+    /* Configure the CAN1 in loopback mode. */
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, LOOPBACK_MODE);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+
+    /* Check here if CAN1 is set in loopback mode. */
+    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
+
+    g_assert_cmpint(status, ==, STATUS_LOOPBACK_MODE);
+
+    send_data(qts, CAN1_BASE_ADDR, buf_tx);
+    read_data(qts, CAN1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, 0);
+
+    qtest_quit(qts);
+}
+
+/*
+ * Enable filters for CAN1. This will filter incoming messages with ID. In this
+ * test message will pass through filter 2.
+ */
+static void test_can_filter(void)
+{
+    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
+    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+    uint8_t can_timestamp = 0;
+
+    QTestState *qts = qtest_init("-m 4G -machine xlnx-zcu102"
+                " -object can-bus,id=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus0"
+                );
+
+    /* Configure the CAN0 and CAN1. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+
+    /* Check here if CAN0 and CAN1 are in normal mode. */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    /* Set filter for CAN1 for incoming messages. */
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0x0);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR1, 0xF7);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR1, 0x121F);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR2, 0x5431);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR2, 0x14);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR3, 0x1234);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR3, 0x5431);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFMR4, 0xFFF);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFIR4, 0x1234);
+
+    qtest_writel(qts, CAN1_BASE_ADDR + R_AFR, 0xF);
+
+    send_data(qts, CAN0_BASE_ADDR, buf_tx);
+
+    can_timestamp += 1;
+
+    read_data(qts, CAN1_BASE_ADDR, buf_rx);
+    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
+
+    qtest_quit(qts);
+}
+
+/* Testing sleep mode on CAN0 while CAN1 is in normal mode. */
+static void test_can_sleepmode(void)
+{
+    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
+    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+    uint8_t can_timestamp = 0;
+
+    QTestState *qts = qtest_init("-m 4G -machine xlnx-zcu102"
+                " -object can-bus,id=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus0"
+                );
+
+    /* Configure the CAN0. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SLEEP_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+
+    /* Check here if CAN0 is in SNOOP mode and CAN1 in normal mode. */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_SLEEP_MODE);
+
+    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    send_data(qts, CAN1_BASE_ADDR, buf_tx);
+
+    /*
+     * Once CAN1 sends data on can-bus. CAN0 should exit sleep mode.
+     * Check the CAN0 status now. It should exit the sleep mode and receive the
+     * incoming data.
+     */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    can_timestamp += 1;
+
+    read_data(qts, CAN0_BASE_ADDR, buf_rx);
+
+    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
+
+    qtest_quit(qts);
+}
+
+/* Testing Snoop mode on CAN0 while CAN1 is in normal mode. */
+static void test_can_snoopmode(void)
+{
+    uint32_t buf_tx[4] = { 0x14, 0x80000000, 0x12345678, 0x87654321 };
+    uint32_t buf_rx[4] = { 0x00, 0x00, 0x00, 0x00 };
+    uint32_t status = 0;
+    uint8_t can_timestamp = 0;
+
+    QTestState *qts = qtest_init("-m 4G -machine xlnx-zcu102"
+                " -object can-bus,id=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus0,value=canbus0"
+                " -global driver=xlnx.zynqmp-can,property=canbus1,value=canbus0"
+                );
+
+    /* Configure the CAN0. */
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, CONFIG_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_MSR_OFFSET, SNOOP_MODE);
+    qtest_writel(qts, CAN0_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+
+    qtest_writel(qts, CAN1_BASE_ADDR + R_SRR_OFFSET, ENABLE_CAN);
+    qtest_writel(qts, CAN1_BASE_ADDR + R_MSR_OFFSET, NORMAL_MODE);
+
+    /* Check here if CAN0 is in SNOOP mode and CAN1 in normal mode. */
+    status = qtest_readl(qts, CAN0_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_SNOOP_MODE);
+
+    status = qtest_readl(qts, CAN1_BASE_ADDR + R_SR_OFFSET);
+    g_assert_cmpint(status, ==, STATUS_NORMAL_MODE);
+
+    send_data(qts, CAN1_BASE_ADDR, buf_tx);
+
+    can_timestamp += 1;
+
+    read_data(qts, CAN0_BASE_ADDR, buf_rx);
+
+    match_rx_tx_data(buf_tx, buf_rx, can_timestamp);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/net/can/can_bus", test_can_bus);
+    qtest_add_func("/net/can/can_loopback", test_can_loopback);
+    qtest_add_func("/net/can/can_filter", test_can_filter);
+    qtest_add_func("/net/can/can_test_snoopmode", test_can_snoopmode);
+    qtest_add_func("/net/can/can_test_sleepmode", test_can_sleepmode);
+
+    return g_test_run();
+}
-- 
2.7.4


