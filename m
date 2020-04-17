Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D71C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C6820780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="HtxDiKQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C6820780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPVnJ-0003Hh-HF
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 14:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1jPVlA-0001bT-Lz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1jPVl8-0002ai-8H
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:40 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47]:20859 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1jPVl7-0002Yl-UH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 14:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9TVDu5KGGXB5oFv7fLN8d3W859HjWs9Nm5/Aiq8ahQ/r4ztAe9kJdUGdF5+qGZDt+8sqhV4QuQk/Maj4a7UTCWyxc4Ou4Iq2j/1m0yk6WE74GZcgNr07aIjTFwFWKZcMQ/ch3T4kWIxlHjZRxYWhb0XsjdAee5siVPHvs9DyvCSfGgwRyZwanXC2VPR8PESHe79UBUGrCeDzVZcep3qkB68KgM3/esw11GsvpXadkXtMOnnB02RZnHPALbLRQzh5MRW5MQcim4B7a9s0J4VxUXX7eOfyKWCpWUDYkSkNCSU6rh/hWUumKLE+XC7aaKQYOLKIa1ea9tcCntejpdR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZR1+LdfXy6+Pf5p4bgXiHCZ2yeiKHMSVQGYzwxMNzU=;
 b=bD7OWpH4V8lkIdWzsFXsTs3g2cahehZ2klpJHr37Nv5XFilrj3JtRiexFOWONOfuJDnsXIsasnQvSxn3nGDifvDPhY0fVXIWLOZfwDVgh1aT4ULz8fPCl30gYzux6A7WSO3KuhzJ7akyy34RiZzlfM3bDHk1M9NtGNopKO32O3zrlfnjJmCKWJBhpcG0NwD9xM9LRmcZcQ7vaW9wqA9Zm+qtq6n6wJbmidaRyoIe/UjZfrefFfGJj7xl+sEA0568WLNOpBPYOYfX0isfy74HCV3BWk6XsrXaFAAFCdY0HpxT0MUoAhc6ytxc73bi5IUpVT6YEgNtFflTeJO1r4q2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZR1+LdfXy6+Pf5p4bgXiHCZ2yeiKHMSVQGYzwxMNzU=;
 b=HtxDiKQIwzde1veCnx+M814+4yfHHxZ2cT4qWK4nRyPi8Rus3Dgu5VJs/iLXUFXMRqZaigWDHqsJ0OOpfCSj6NNne0zPpqSjV7n9ZSBovV9S8yHoEZvbVq96JuIjGaqBs8CoPcY0ZADvaB4N0/ezRUrZ/DVykOa+eTriqe4Tejw=
Received: from DM6PR14CA0072.namprd14.prod.outlook.com (2603:10b6:5:18f::49)
 by DM5PR02MB2586.namprd02.prod.outlook.com (2603:10b6:3:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 18:30:35 +0000
Received: from CY1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::ac) by DM6PR14CA0072.outlook.office365.com
 (2603:10b6:5:18f::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Fri, 17 Apr 2020 18:30:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT028.mail.protection.outlook.com (10.152.75.132) with Microsoft SMTP
 Server id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 18:30:34
 +0000
Received: from [149.199.38.66] (port=36816 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVkG-0007KT-NL; Fri, 17 Apr 2020 11:29:44 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVl4-0006R2-GG; Fri, 17 Apr 2020 11:30:34 -0700
Received: from [172.19.2.115] (helo=xsjfnuv50.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <fnu.vikram@xilinx.com>)
 id 1jPVl0-00055H-KE; Fri, 17 Apr 2020 11:30:30 -0700
From: Vikram Garhwal <fnu.vikram@xilinx.com>
To: qemu-devel@nongnu.org
Subject: [[PATCH v2 4/4] hw/net/can: Introduce QTEST for Xlnx CAN controller
Date: Fri, 17 Apr 2020 11:29:29 -0700
Message-Id: <1587148169-173268-5-git-send-email-fnu.vikram@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
References: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(7696005)(70206006)(70586007)(26005)(8676002)(81156014)(8936002)(30864003)(5660300002)(478600001)(2906002)(4326008)(54906003)(9786002)(2616005)(186003)(36756003)(81166007)(47076004)(316002)(426003)(336012)(356005)(6916009)(82740400003);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5cfe251-7276-4cf6-4a89-08d7e2fd6b1a
X-MS-TrafficTypeDiagnostic: DM5PR02MB2586:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2586A30D6528AF1586B9CA73BCD90@DM5PR02MB2586.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJbBh6bMB12gkK+khRIHcOSt19Z3GQkH9hUnx6NKH0irlVHy4WMmHrYSuJl/694ty6G9+FqHG38WTA5eANhUBGBqhi1KUnEhUpibvXuFrjMCqdlmWeLX6EqtcaC6jbmQuzV57EmbKBjy6P996MaUAXv8oc74N/a/h4CWUEB3NvrUSFlkY86SWQpBQNzqOTBmUU44fqjgw4MoYTxUhZf34bPL+2t3noTW2AjAejoKoCPCEbOirPrg4pL/VqRmBsSCMWxOnTug+nkC70Y+iLe5Yz8oMe354eD0eTBv+5FoTDWQyYE00F0WfJ5RPIN3fLMG+Ddzz4b+uyuWClH0Zy17t+KOGmshGq5kcZvunSMBI4r1cqmp8HB4oceaCuE3+r7vw/rSmNhCPr0mZcqKyMLjlFwc4gsFBqWf9p/+tfgjzaJl906nULe4yX8ZoRvJwbJAKRgXXRi5h9sMdH3YdPHyFZ+bThDLpaFr5jBLlPQknWmiWn1PV5UH3sH56+jDs1yrZMiPk3exl4SxfTnV3TcLdQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 18:30:34.7622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cfe251-7276-4cf6-4a89-08d7e2fd6b1a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2586
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.47
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vikram Garhwal <fnu.vikram@xilinx.com>, jasowang@redhat.com,
 francisco.iglesias@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qtest performs five tests on Xlnx-CAN controller:
	It checks communication between CAN0 and CAN1 via can-bus.
	Tests CAN in loopback, sleep and snoop mode.
	Tests CAN filtering for incoming messages.

Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 tests/qtest/Makefile.include |   1 +
 tests/qtest/xlnx-can-test.c  | 367 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 368 insertions(+)
 create mode 100644 tests/qtest/xlnx-can-test.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d..369234a 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -136,6 +136,7 @@ check-qtest-aarch64-$(CONFIG_TPM_TIS_SYSBUS) += tpm-tis-device-swtpm-test
 check-qtest-aarch64-y += numa-test
 check-qtest-aarch64-y += boot-serial-test
 check-qtest-aarch64-y += migration-test
+check-qtest-aarch64-y += xlnx-can-test
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
 ifneq ($(ARCH),arm)
diff --git a/tests/qtest/xlnx-can-test.c b/tests/qtest/xlnx-can-test.c
new file mode 100644
index 0000000..c9e2efc
--- /dev/null
+++ b/tests/qtest/xlnx-can-test.c
@@ -0,0 +1,367 @@
+/*
+ *  Xilinx CAN qtest.
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
+    uint32_t buf_tx[4] = {0xFF, 0x80000000, 0x12345678, 0x87654321};
+    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};
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
+    uint32_t buf_tx[4] = {0xFF, 0x80000000, 0x12345678, 0x87654321};
+    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};
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
+    uint32_t buf_tx[4] = {0x14, 0x80000000, 0x12345678, 0x87654321};
+    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};
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
+    uint32_t buf_tx[4] = {0x14, 0x80000000, 0x12345678, 0x87654321};
+    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};
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
+    uint32_t buf_tx[4] = {0x14, 0x80000000, 0x12345678, 0x87654321};
+    uint32_t buf_rx[4] = {0x00, 0x00, 0x00, 0x00};
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


