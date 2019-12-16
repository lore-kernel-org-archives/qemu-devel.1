Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09363C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7788206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 18:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7788206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igux6-0006aY-Qj
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 13:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iguvi-0005JY-19
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iguvf-0007Hm-Je
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 13:17:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1iguvc-00079q-Bv; Mon, 16 Dec 2019 13:17:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so7876297lja.2;
 Mon, 16 Dec 2019 10:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cRQSqHQGTq1xqFL6YEmD0K61DluElQx/VnVceQaR8S0=;
 b=SoXUs5eVee8bMrPaqmScL9ZxK2Qt8YB9jDB04MRAOjs2zKloOkWHAyckEf0BpLY8Gl
 KU51C8MI/feVSJPK+4SEOa39w3mCY580+qbFaOlih6lPDkjcJSn3qSwq9vLw/LDyH87o
 uMwRJdipM/n4GDruihunCRQumhItxNqP98oAQ0piHO+6zSyk7N2tLkXkDtl7tAX/F/J6
 91CF6Z5weFoHbwokA+FXmUXHjHNh7dkjxriamIKuMVCyC1hMZJ2YmGbbflvHkYO3iSR1
 hyCDzoxauhHxyn2T5irn+2X3XzEkrg7ic8H45+2q9kvikGTIB0OAPHr/ZpTPs0UZq+o4
 sjcA==
X-Gm-Message-State: APjAAAVMbJOEGwAkvXAGolgKMFL5BDwyG4lNHf4ZCcbKzdYH8eDSBeGO
 +dNcRsSWWg/9hXovPkQOtVQ=
X-Google-Smtp-Source: APXvYqxyW4PHVI0E/rzgZXbxG4VXOIMKkmAXHRJx1ZeDMCieNbb7qgmcUr65x54o3u9kDADphduQXg==
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr293717ljg.93.1576520226663;
 Mon, 16 Dec 2019 10:17:06 -0800 (PST)
Received: from localhost.localdomain ([213.87.130.66])
 by smtp.gmail.com with ESMTPSA id j10sm10961857ljc.76.2019.12.16.10.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 10:17:05 -0800 (PST)
From: Alexander Popov <alex.popov@linux.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 pmatouse@redhat.com, sstabellini@kernel.org, mdroth@linux.vnet.ibm.com,
 pjp@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Alexander Popov <alex.popov@linux.com>
Subject: [PATCH v2 1/2] tests/ide-test: Create a single unit-test covering
 more PRDT cases
Date: Mon, 16 Dec 2019 21:14:04 +0300
Message-Id: <20191216181405.462292-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.195
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fuzzing the Linux kernel with syzkaller allowed to find how to crash qemu
using a special SCSI_IOCTL_SEND_COMMAND. It hits the assertion in
ide_dma_cb() introduced in the commit a718978ed58a in July 2015.
Currently this bug is not reproduced by the unit tests.

Let's improve the ide-test to cover more PRDT cases including one
that causes this particular qemu crash.

The test is developed according to the Programming Interface for
Bus Master IDE Controller (Revision 1.0 5/16/94).

Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 tests/ide-test.c | 137 +++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 76 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 0277e7d5a9..f042d8a700 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -445,7 +445,8 @@ static void test_bmdma_trim(void)
     test_bmdma_teardown(qts);
 }
 
-static void test_bmdma_short_prdt(void)
+static void test_bmdma_prdt(uint32_t prdt_size, int nb_sectors,
+                            uint8_t req_status, uint8_t abort_req_status)
 {
     QTestState *qts;
     QPCIDevice *dev;
@@ -455,94 +456,81 @@ static void test_bmdma_short_prdt(void)
     PrdtEntry prdt[] = {
         {
             .addr = 0,
-            .size = cpu_to_le32(0x10 | PRDT_EOT),
+            .size = cpu_to_le32(prdt_size | PRDT_EOT),
         },
     };
 
     qts = test_bmdma_setup();
-
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
 
-    /* Normal request */
-    status = send_dma_request(qts, CMD_READ_DMA, 0, 1,
+    /* Test the request */
+    status = send_dma_request(qts, CMD_READ_DMA, 0, nb_sectors,
                               prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
+    g_assert_cmphex(status, ==, req_status);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
 
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, 0);
+    /* Now test aborting the same request */
+    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0,
+                              nb_sectors, prdt, ARRAY_SIZE(prdt), NULL);
+    g_assert_cmphex(status, ==, abort_req_status);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
-}
 
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
     free_pci_device(dev);
     test_bmdma_teardown(qts);
 }
 
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
+    uint32_t size = 0;
+    uint32_t prd_size = 0;
+    int req_sectors = 0;
+    uint32_t req_size = 0;
+    uint8_t s1 = 0, s2 = 0;
+
+    for (size = 0; size < 65536; size += 256) {
+        /*
+         * Two bytes specify the count of the region in bytes.
+         * The bit 0 is always set to 0.
+         * A value of zero in these two bytes indicates 64K.
+         */
+        prd_size = size & 0xfffe;
+        if (prd_size == 0) {
+            prd_size = 65536;
+        }
 
-    /* Abort the request before it completes */
-    status = send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
-                              prdt, ARRAY_SIZE(prdt), NULL);
-    g_assert_cmphex(status, ==, BM_STS_INTR);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
-    free_pci_device(dev);
-    test_bmdma_teardown(qts);
+        for (req_sectors = 1; req_sectors <= 256; req_sectors *= 2) {
+            req_size = req_sectors * 512;
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
+                s1 = 0;
+                s2 = 0;
+            } else if (prd_size == req_size) {
+                s1 = BM_STS_INTR;
+                s2 = BM_STS_INTR;
+            } else {
+                s1 = BM_STS_ACTIVE | BM_STS_INTR;
+                s2 = BM_STS_INTR;
+            }
+            test_bmdma_prdt(size, req_sectors, s1, s2);
+        }
+    }
 }
 
 static void test_bmdma_no_busmaster(void)
@@ -1066,10 +1054,7 @@ int main(int argc, char **argv)
 
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
2.23.0


