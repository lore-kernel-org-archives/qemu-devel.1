Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4F120707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbuoFN1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCRQ-0004Xl-Gm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPJ-0001KG-4f; Tue, 16 Jun 2020 10:17:45 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPH-0006YQ-9s; Tue, 16 Jun 2020 10:17:44 -0400
Received: by mail-oi1-x243.google.com with SMTP id s21so19366190oic.9;
 Tue, 16 Jun 2020 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XQOJlPGQ6/E7BIZHDBdbimPTDRMBKClj3mjFCEM9x3c=;
 b=JbuoFN1gVXWf+br6Uc/L3SZNh8B1OwQ4aYv4vi21ZI0DbR9PfUeR5f2EhriRle3ptV
 OYzU/Y1aggCnJDk5LNYurZNrlnOvzRiCLNG5a8KpQu7PuFPAKnTVsR4efE63mTiIOXKp
 w/mQclmZrUEXUedUT7x0KHKthmU4RFrhEKZ4d8AoLHKbtxgStopnxI9JggTiDQqRlW1j
 EPgUYXj2zFlALGbvCsdGu3tvjAhtXg2rfFXJIe1KnmHICr2Cs+Uq9ncKKes3Q8tA0G1x
 4q23GCX4Fr1eZFOmTQSXW5L/8hBA+elStkZpSXclzImNTebzuAl4t5F32RFpuJcXDoHT
 wJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=XQOJlPGQ6/E7BIZHDBdbimPTDRMBKClj3mjFCEM9x3c=;
 b=Qci2fGtWOSXIusR/Xp1U2HgDOa0vwPFCN2+jJL3S1pUE3n+K5GovAK2SPzDvhh1aDN
 ZEbSi/XHiYcXzeSA9HeGTlBFVAnF/YHQi8Kk/Q+IwRcnCjlJxJYq708QT5pDx+ClkCf1
 R27TyrzN52rZQsWbK/6urYFpz6zHwvAA+Xm9yiT3BdmrX2bBDPfNdCR3+KyuSTAV/7ih
 aR/RpOwJIP+FGAT/dD8U4aFx6muGXOb54lvpTxck06CRDZ5TQsXqNmhUmmbW6KHI535T
 RuusegVSBc/xuanWpjQXLFwe/AufXeq6YjzapLIvZnsq0DG7v6S7FXOL8oe2whdQ2Dxc
 rqIQ==
X-Gm-Message-State: AOAM53265tpwd73++AQ9bTi/oYjT5u7dFCZaIPUKBPsIo/aGjwQklC8U
 suutOpkTKHyJBefip+IlHrHKQla+
X-Google-Smtp-Source: ABdhPJw85TIqx40Rf62pn5Y1w3MbZ6BdcbPcWclfMqDmdRv3CRGPRrSN99zQmWepBLHeBxVF/Grjrw==
X-Received: by 2002:aca:c494:: with SMTP id u142mr3474436oif.113.1592317060608; 
 Tue, 16 Jun 2020 07:17:40 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id u62sm4206760oib.47.2020.06.16.07.17.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:17:39 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/78] tests/ide-test: Create a single unit-test covering more
 PRDT cases
Date: Tue, 16 Jun 2020 09:14:43 -0500
Message-Id: <20200616141547.24664-15-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Alexander Popov <alex.popov@linux.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Popov <alex.popov@linux.com>

Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
Currently this bug is not reproduced by the unit tests.

Let's improve the ide-test to cover more PRDT cases including one
that causes this particular qemu crash.

The test is developed according to the Programming Interface for
Bus Master IDE Controller (Revision 1.0 5/16/94).

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Message-id: 20191223175117.508990-3-alex.popov@linux.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 59805ae92dfe4f67105e36b539d567caec4f8304)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/ide-test.c | 174 ++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 100 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 0277e7d5a9..5cfd97f915 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -445,104 +445,81 @@ static void test_bmdma_trim(void)
     test_bmdma_teardown(qts);
 }
 
-static void test_bmdma_short_prdt(void)
-{
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x10 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
-
-static void test_bmdma_one_sector_short_prdt(void)
-{
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    /* Read 2 sectors but only give 1 sector in PRDT */
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x200 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 2,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
-
-static void test_bmdma_long_prdt(void)
+/*
+ * This test is developed according to the Programming Interface for
+ * Bus Master IDE Controller (Revision 1.0 5/16/94)
+ */
+static void test_bmdma_various_prdts(void)
 {
-    QTestState *qts;
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
-    uint8_t status;
-
-    PrdtEntry prdt[] = {
-        {
-            .addr = 0,
-            .size = cpu_to_le32(0x1000 | PRDT_EOT),
-        },
-    };
-
-    qts = test_bmdma_setup();
-
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, BM_STS_ACTIVE | BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+    int sectors = 0;
+    uint32_t size = 0;
+
+    for (sectors = 1; sectors <= 256; sectors *= 2) {
+        QTestState *qts = NULL;
+        QPCIDevice *dev = NULL;
+        QPCIBar bmdma_bar, ide_bar;
+
+        qts = test_bmdma_setup();
+        dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+        for (size = 0; size < 65536; size += 256) {
+            uint32_t req_size = sectors * 512;
+            uint32_t prd_size = size & 0xfffe; /* bit 0 is always set to 0 */
+            uint8_t ret = 0;
+            uint8_t req_status = 0;
+            uint8_t abort_req_status = 0;
+            PrdtEntry prdt[] = {
+                {
+                    .addr = 0,
+                    .size = cpu_to_le32(size | PRDT_EOT),
+                },
+            };
+
+            /* A value of zero in PRD size indicates 64K */
+            if (prd_size == 0) {
+                prd_size = 65536;
+            }
+
+            /*
+             * 1. If PRDs specified a smaller size than the IDE transfer
+             * size, then the Interrupt and Active bits in the Controller
+             * status register are not set (Error Condition).
+             *
+             * 2. If the size of the physical memory regions was equal to
+             * the IDE device transfer size, the Interrupt bit in the
+             * Controller status register is set to 1, Active bit is set to 0.
+             *
+             * 3. If PRDs specified a larger size than the IDE transfer size,
+             * the Interrupt and Active bits in the Controller status register
+             * are both set to 1.
+             */
+            if (prd_size < req_size) {
+                req_status = 0;
+                abort_req_status = 0;
+            } else if (prd_size == req_size) {
+                req_status = BM_STS_INTR;
+                abort_req_status = BM_STS_INTR;
+            } else {
+                req_status = BM_STS_ACTIVE | BM_STS_INTR;
+                abort_req_status = BM_STS_INTR;
+            }
+
+            /* Test the request */
+            ret = send_dma_request(qts, CMD_READ_DMA, 0, sectors,
+                                   prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, ==, req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+
+            /* Now test aborting the same request */
+            ret = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0,
+                                   sectors, prdt, ARRAY_SIZE(prdt), NULL);
+            g_assert_cmphex(ret, ==, abort_req_status);
+            assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+        }
 
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
+        free_pci_device(dev);
+        test_bmdma_teardown(qts);
+    }
 }
 
 static void test_bmdma_no_busmaster(void)
@@ -1066,10 +1043,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
     qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
-    qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
-    qtest_add_func("/ide/bmdma/one_sector_short_prdt",
-                   test_bmdma_one_sector_short_prdt);
-    qtest_add_func("/ide/bmdma/long_prdt", test_bmdma_long_prdt);
+    qtest_add_func("/ide/bmdma/various_prdts", test_bmdma_various_prdts);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
 
     qtest_add_func("/ide/flush", test_flush);
-- 
2.17.1


