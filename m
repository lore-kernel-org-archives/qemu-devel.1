Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DCC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AE02084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AE02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmYw-0007Br-Rs
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:57:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmVK-0004Iq-CU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmVH-0002yu-HD
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hDmVA-0002wU-Ns; Tue, 09 Apr 2019 04:53:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81F3664D87;
	Tue,  9 Apr 2019 08:53:06 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4FF371A917;
	Tue,  9 Apr 2019 08:53:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 10:52:45 +0200
Message-Id: <20190409085245.31548-6-thuth@redhat.com>
In-Reply-To: <20190409085245.31548-1-thuth@redhat.com>
References: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 09 Apr 2019 08:53:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 5/5] tests/ide-test: Make test
 independent of global_qtest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409085245.TQoQWaSO5DWOB_MvswddRQ3sVOKU1jAyRiHrYX1mm2s@z>

Pass around the QTestState, so we do not need the problematic global_qtes=
t
variable (which causes trouble for tests that have multiple test states)
here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ide-test.c | 284 ++++++++++++++++++++++++++---------------------
 1 file changed, 159 insertions(+), 125 deletions(-)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index d863a99f7f..0277e7d5a9 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -36,7 +36,7 @@
 #include "hw/pci/pci_regs.h"
=20
 /* TODO actually test the results and get rid of this */
-#define qmp_discard_response(...) qobject_unref(qmp(__VA_ARGS__))
+#define qmp_discard_response(q, ...) qobject_unref(qtest_qmp(q, __VA_ARG=
S__))
=20
 #define TEST_IMAGE_SIZE 64 * 1024 * 1024
=20
@@ -125,38 +125,38 @@ static QGuestAllocator guest_malloc;
 static char tmp_path[] =3D "/tmp/qtest.XXXXXX";
 static char debug_path[] =3D "/tmp/qtest-blkdebug.XXXXXX";
=20
-static void ide_test_start(const char *cmdline_fmt, ...)
+static QTestState *ide_test_start(const char *cmdline_fmt, ...)
 {
+    QTestState *qts;
     va_list ap;
-    char *cmdline;
=20
     va_start(ap, cmdline_fmt);
-    cmdline =3D g_strdup_vprintf(cmdline_fmt, ap);
+    qts =3D qtest_vinitf(cmdline_fmt, ap);
     va_end(ap);
=20
-    qtest_start(cmdline);
-    pc_alloc_init(&guest_malloc, global_qtest, 0);
+    pc_alloc_init(&guest_malloc, qts, 0);
=20
-    g_free(cmdline);
+    return qts;
 }
=20
-static void ide_test_quit(void)
+static void ide_test_quit(QTestState *qts)
 {
     if (pcibus) {
         qpci_free_pc(pcibus);
         pcibus =3D NULL;
     }
     alloc_destroy(&guest_malloc);
-    qtest_end();
+    qtest_quit(qts);
 }
=20
-static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
+static QPCIDevice *get_pci_device(QTestState *qts, QPCIBar *bmdma_bar,
+                                  QPCIBar *ide_bar)
 {
     QPCIDevice *dev;
     uint16_t vendor_id, device_id;
=20
     if (!pcibus) {
-        pcibus =3D qpci_new_pc(global_qtest, NULL);
+        pcibus =3D qpci_new_pc(qts, NULL);
     }
=20
     /* Find PCI device and verify it's the right one */
@@ -198,8 +198,8 @@ static uint64_t trim_range_le(uint64_t sector, uint16=
_t count)
     return cpu_to_le64(((uint64_t)count << 48) + sector);
 }
=20
-static int send_dma_request(int cmd, uint64_t sector, int nb_sectors,
-                            PrdtEntry *prdt, int prdt_entries,
+static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
+                            int nb_sectors, PrdtEntry *prdt, int prdt_en=
tries,
                             void(*post_exec)(QPCIDevice *dev, QPCIBar id=
e_bar,
                                              uint64_t sector, int nb_sec=
tors))
 {
@@ -211,7 +211,7 @@ static int send_dma_request(int cmd, uint64_t sector,=
 int nb_sectors,
     uint8_t status;
     int flags;
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     flags =3D cmd & ~0xff;
     cmd &=3D 0xff;
@@ -246,7 +246,7 @@ static int send_dma_request(int cmd, uint64_t sector,=
 int nb_sectors,
     /* Setup PRDT */
     len =3D sizeof(*prdt) * prdt_entries;
     guest_prdt =3D guest_alloc(&guest_malloc, len);
-    memwrite(guest_prdt, prdt, len);
+    qtest_memwrite(qts, guest_prdt, prdt, len);
     qpci_io_writel(dev, bmdma_bar, bmreg_prdt, guest_prdt);
=20
     /* ATA DMA command */
@@ -283,14 +283,15 @@ static int send_dma_request(int cmd, uint64_t secto=
r, int nb_sectors,
         status =3D qpci_io_readb(dev, bmdma_bar, bmreg_status);
     } while ((status & (BM_STS_ACTIVE | BM_STS_INTR)) =3D=3D BM_STS_ACTI=
VE);
=20
-    g_assert_cmpint(get_irq(IDE_PRIMARY_IRQ), =3D=3D, !!(status & BM_STS=
_INTR));
+    g_assert_cmpint(qtest_get_irq(qts, IDE_PRIMARY_IRQ), =3D=3D,
+                    !!(status & BM_STS_INTR));
=20
     /* Check IDE status code */
     assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), DRDY);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ)=
;
=20
     /* Reading the status register clears the IRQ */
-    g_assert(!get_irq(IDE_PRIMARY_IRQ));
+    g_assert(!qtest_get_irq(qts, IDE_PRIMARY_IRQ));
=20
     /* Stop DMA transfer if still active */
     if (status & BM_STS_ACTIVE) {
@@ -302,42 +303,61 @@ static int send_dma_request(int cmd, uint64_t secto=
r, int nb_sectors,
     return status;
 }
=20
+static QTestState *test_bmdma_setup(void)
+{
+    QTestState *qts;
+
+    qts =3D ide_test_start(
+        "-drive file=3D%s,if=3Dide,cache=3Dwriteback,format=3Draw "
+        "-global ide-hd.serial=3D%s -global ide-hd.ver=3D%s",
+        tmp_path, "testdisk", "version");
+    qtest_irq_intercept_in(qts, "ioapic");
+
+    return qts;
+}
+
+static void test_bmdma_teardown(QTestState *qts)
+{
+    ide_test_quit(qts);
+}
+
 static void test_bmdma_simple_rw(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
     uint8_t *buf;
     uint8_t *cmpbuf;
     size_t len =3D 512;
-    uintptr_t guest_buf =3D guest_alloc(&guest_malloc, len);
+    uintptr_t guest_buf;
+    PrdtEntry prdt[1];
=20
-    PrdtEntry prdt[] =3D {
-        {
-            .addr =3D cpu_to_le32(guest_buf),
-            .size =3D cpu_to_le32(len | PRDT_EOT),
-        },
-    };
+    qts =3D test_bmdma_setup();
+
+    guest_buf  =3D guest_alloc(&guest_malloc, len);
+    prdt[0].addr =3D cpu_to_le32(guest_buf);
+    prdt[0].size =3D cpu_to_le32(len | PRDT_EOT);
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     buf =3D g_malloc(len);
     cmpbuf =3D g_malloc(len);
=20
     /* Write 0x55 pattern to sector 0 */
     memset(buf, 0x55, len);
-    memwrite(guest_buf, buf, len);
+    qtest_memwrite(qts, guest_buf, buf, len);
=20
-    status =3D send_dma_request(CMD_WRITE_DMA, 0, 1, prdt,
+    status =3D send_dma_request(qts, CMD_WRITE_DMA, 0, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
     /* Write 0xaa pattern to sector 1 */
     memset(buf, 0xaa, len);
-    memwrite(guest_buf, buf, len);
+    qtest_memwrite(qts, guest_buf, buf, len);
=20
-    status =3D send_dma_request(CMD_WRITE_DMA, 1, 1, prdt,
+    status =3D send_dma_request(qts, CMD_WRITE_DMA, 1, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
@@ -345,31 +365,35 @@ static void test_bmdma_simple_rw(void)
     /* Read and verify 0x55 pattern in sector 0 */
     memset(cmpbuf, 0x55, len);
=20
-    status =3D send_dma_request(CMD_READ_DMA, 0, 1, prdt, ARRAY_SIZE(prd=
t), NULL);
+    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1, prdt, ARRAY_SIZ=
E(prdt),
+                              NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
-    memread(guest_buf, buf, len);
+    qtest_memread(qts, guest_buf, buf, len);
     g_assert(memcmp(buf, cmpbuf, len) =3D=3D 0);
=20
     /* Read and verify 0xaa pattern in sector 1 */
     memset(cmpbuf, 0xaa, len);
=20
-    status =3D send_dma_request(CMD_READ_DMA, 1, 1, prdt, ARRAY_SIZE(prd=
t), NULL);
+    status =3D send_dma_request(qts, CMD_READ_DMA, 1, 1, prdt, ARRAY_SIZ=
E(prdt),
+                              NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
-    memread(guest_buf, buf, len);
+    qtest_memread(qts, guest_buf, buf, len);
     g_assert(memcmp(buf, cmpbuf, len) =3D=3D 0);
=20
-
     free_pci_device(dev);
     g_free(buf);
     g_free(cmpbuf);
+
+    test_bmdma_teardown(qts);
 }
=20
 static void test_bmdma_trim(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
@@ -380,16 +404,16 @@ static void test_bmdma_trim(void)
     const uint64_t bad_range =3D trim_range_le(TEST_IMAGE_SIZE / 512 - 1=
, 2);
     size_t len =3D 512;
     uint8_t *buf;
-    uintptr_t guest_buf =3D guest_alloc(&guest_malloc, len);
+    uintptr_t guest_buf;
+    PrdtEntry prdt[1];
=20
-    PrdtEntry prdt[] =3D {
-        {
-            .addr =3D cpu_to_le32(guest_buf),
-            .size =3D cpu_to_le32(len | PRDT_EOT),
-        },
-    };
+    qts =3D test_bmdma_setup();
+
+    guest_buf =3D guest_alloc(&guest_malloc, len);
+    prdt[0].addr =3D cpu_to_le32(guest_buf),
+    prdt[0].size =3D cpu_to_le32(len | PRDT_EOT),
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     buf =3D g_malloc(len);
=20
@@ -397,9 +421,9 @@ static void test_bmdma_trim(void)
     *((uint64_t *)buf) =3D trim_range[0];
     *((uint64_t *)buf + 1) =3D trim_range[1];
=20
-    memwrite(guest_buf, buf, 2 * sizeof(uint64_t));
+    qtest_memwrite(qts, guest_buf, buf, 2 * sizeof(uint64_t));
=20
-    status =3D send_dma_request(CMD_DSM, 0, 1, prdt,
+    status =3D send_dma_request(qts, CMD_DSM, 0, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
@@ -408,9 +432,9 @@ static void test_bmdma_trim(void)
     *((uint64_t *)buf) =3D trim_range[2];
     *((uint64_t *)buf + 1) =3D bad_range;
=20
-    memwrite(guest_buf, buf, 2 * sizeof(uint64_t));
+    qtest_memwrite(qts, guest_buf, buf, 2 * sizeof(uint64_t));
=20
-    status =3D send_dma_request(CMD_DSM, 0, 1, prdt,
+    status =3D send_dma_request(qts, CMD_DSM, 0, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), ERR);
@@ -418,10 +442,12 @@ static void test_bmdma_trim(void)
=20
     free_pci_device(dev);
     g_free(buf);
+    test_bmdma_teardown(qts);
 }
=20
 static void test_bmdma_short_prdt(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
@@ -433,24 +459,28 @@ static void test_bmdma_short_prdt(void)
         },
     };
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    qts =3D test_bmdma_setup();
+
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* Normal request */
-    status =3D send_dma_request(CMD_READ_DMA, 0, 1,
+    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
     /* Abort the request before it completes */
-    status =3D send_dma_request(CMD_READ_DMA | CMDF_ABORT, 0, 1,
+    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
     free_pci_device(dev);
+    test_bmdma_teardown(qts);
 }
=20
 static void test_bmdma_one_sector_short_prdt(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
@@ -463,24 +493,28 @@ static void test_bmdma_one_sector_short_prdt(void)
         },
     };
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    qts =3D test_bmdma_setup();
+
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* Normal request */
-    status =3D send_dma_request(CMD_READ_DMA, 0, 2,
+    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 2,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
     /* Abort the request before it completes */
-    status =3D send_dma_request(CMD_READ_DMA | CMDF_ABORT, 0, 2,
+    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 2,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, 0);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
     free_pci_device(dev);
+    test_bmdma_teardown(qts);
 }
=20
 static void test_bmdma_long_prdt(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
@@ -492,29 +526,35 @@ static void test_bmdma_long_prdt(void)
         },
     };
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    qts =3D test_bmdma_setup();
+
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* Normal request */
-    status =3D send_dma_request(CMD_READ_DMA, 0, 1,
+    status =3D send_dma_request(qts, CMD_READ_DMA, 0, 1,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
=20
     /* Abort the request before it completes */
-    status =3D send_dma_request(CMD_READ_DMA | CMDF_ABORT, 0, 1,
+    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_ABORT, 0, 1,
                               prdt, ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
     free_pci_device(dev);
+    test_bmdma_teardown(qts);
 }
=20
 static void test_bmdma_no_busmaster(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t status;
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    qts =3D test_bmdma_setup();
+
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* No PRDT_EOT, each entry addr 0/size 64k, and in theory qemu shoul=
dn't be
      * able to access it anyway because the Bus Master bit in the PCI co=
mmand
@@ -522,7 +562,7 @@ static void test_bmdma_no_busmaster(void)
      * good at confusing and occasionally crashing qemu. */
     PrdtEntry prdt[4096] =3D { };
=20
-    status =3D send_dma_request(CMD_READ_DMA | CMDF_NO_BM, 0, 512,
+    status =3D send_dma_request(qts, CMD_READ_DMA | CMDF_NO_BM, 0, 512,
                               prdt, ARRAY_SIZE(prdt), NULL);
=20
     /* Not entirely clear what the expected result is, but this is what =
we get
@@ -530,20 +570,7 @@ static void test_bmdma_no_busmaster(void)
     g_assert_cmphex(status, =3D=3D, BM_STS_ACTIVE | BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
     free_pci_device(dev);
-}
-
-static void test_bmdma_setup(void)
-{
-    ide_test_start(
-        "-drive file=3D%s,if=3Dide,cache=3Dwriteback,format=3Draw "
-        "-global ide-hd.serial=3D%s -global ide-hd.ver=3D%s",
-        tmp_path, "testdisk", "version");
-    qtest_irq_intercept_in(global_qtest, "ioapic");
-}
-
-static void test_bmdma_teardown(void)
-{
-    ide_test_quit();
+    test_bmdma_teardown(qts);
 }
=20
 static void string_cpu_to_be16(uint16_t *s, size_t bytes)
@@ -559,6 +586,7 @@ static void string_cpu_to_be16(uint16_t *s, size_t by=
tes)
=20
 static void test_identify(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
@@ -566,12 +594,12 @@ static void test_identify(void)
     int i;
     int ret;
=20
-    ide_test_start(
+    qts =3D ide_test_start(
         "-drive file=3D%s,if=3Dide,cache=3Dwriteback,format=3Draw "
         "-global ide-hd.serial=3D%s -global ide-hd.ver=3D%s",
         tmp_path, "testdisk", "version");
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* IDENTIFY command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -605,7 +633,7 @@ static void test_identify(void)
     /* Write cache enabled bit */
     assert_bit_set(buf[85], 0x20);
=20
-    ide_test_quit();
+    ide_test_quit(qts);
     free_pci_device(dev);
 }
=20
@@ -613,7 +641,7 @@ static void test_identify(void)
  * Write sector 1 with random data to make IDE storage dirty
  * Needed for flush tests so that flushes actually go though the block l=
ayer
  */
-static void make_dirty(uint8_t device)
+static void make_dirty(QTestState *qts, uint8_t device)
 {
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
@@ -622,7 +650,7 @@ static void make_dirty(uint8_t device)
     uintptr_t guest_buf;
     void* buf;
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     guest_buf =3D guest_alloc(&guest_malloc, len);
     buf =3D g_malloc(len);
@@ -630,7 +658,7 @@ static void make_dirty(uint8_t device)
     g_assert(guest_buf);
     g_assert(buf);
=20
-    memwrite(guest_buf, buf, len);
+    qtest_memwrite(qts, guest_buf, buf, len);
=20
     PrdtEntry prdt[] =3D {
         {
@@ -639,7 +667,7 @@ static void make_dirty(uint8_t device)
         },
     };
=20
-    status =3D send_dma_request(CMD_WRITE_DMA, 1, 1, prdt,
+    status =3D send_dma_request(qts, CMD_WRITE_DMA, 1, 1, prdt,
                               ARRAY_SIZE(prdt), NULL);
     g_assert_cmphex(status, =3D=3D, BM_STS_INTR);
     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
@@ -650,23 +678,24 @@ static void make_dirty(uint8_t device)
=20
 static void test_flush(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
=20
-    ide_test_start(
+    qts =3D ide_test_start(
         "-drive file=3Dblkdebug::%s,if=3Dide,cache=3Dwriteback,format=3D=
raw",
         tmp_path);
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qtest_irq_intercept_in(qts, "ioapic");
=20
     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
-    make_dirty(0);
+    make_dirty(qts, 0);
=20
     /* Delay the completion of the flush request until we explicitly do =
it */
-    g_free(hmp("qemu-io ide0-hd0 \"break flush_to_os A\""));
+    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"break flush_to_os A\""));
=20
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -678,7 +707,7 @@ static void test_flush(void)
     assert_bit_clear(data, DF | ERR | DRQ);
=20
     /* Complete the command */
-    g_free(hmp("qemu-io ide0-hd0 \"resume A\""));
+    g_free(qtest_hmp(qts, "qemu-io ide0-hd0 \"resume A\""));
=20
     /* Check registers */
     data =3D qpci_io_readb(dev, ide_bar, reg_device);
@@ -691,29 +720,30 @@ static void test_flush(void)
     assert_bit_set(data, DRDY);
     assert_bit_clear(data, BSY | DF | ERR | DRQ);
=20
-    ide_test_quit();
+    ide_test_quit(qts);
     free_pci_device(dev);
 }
=20
 static void test_retry_flush(const char *machine)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
=20
     prepare_blkdebug_script(debug_path, "flush_to_disk");
=20
-    ide_test_start(
+    qts =3D ide_test_start(
         "-drive file=3Dblkdebug:%s:%s,if=3Dide,cache=3Dwriteback,format=3D=
raw,"
         "rerror=3Dstop,werror=3Dstop",
         debug_path, tmp_path);
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qtest_irq_intercept_in(qts, "ioapic");
=20
     /* Dirty media so that CMD_FLUSH_CACHE will actually go to disk */
-    make_dirty(0);
+    make_dirty(qts, 0);
=20
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -724,10 +754,10 @@ static void test_retry_flush(const char *machine)
     assert_bit_set(data, BSY | DRDY);
     assert_bit_clear(data, DF | ERR | DRQ);
=20
-    qmp_eventwait("STOP");
+    qtest_qmp_eventwait(qts, "STOP");
=20
     /* Complete the command */
-    qmp_discard_response("{'execute':'cont' }");
+    qmp_discard_response(qts, "{'execute':'cont' }");
=20
     /* Check registers */
     data =3D qpci_io_readb(dev, ide_bar, reg_device);
@@ -740,18 +770,19 @@ static void test_retry_flush(const char *machine)
     assert_bit_set(data, DRDY);
     assert_bit_clear(data, BSY | DF | ERR | DRQ);
=20
-    ide_test_quit();
+    ide_test_quit(qts);
     free_pci_device(dev);
 }
=20
 static void test_flush_nodev(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
=20
-    ide_test_start("");
+    qts =3D ide_test_start("");
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* FLUSH CACHE command on device 0*/
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -760,16 +791,17 @@ static void test_flush_nodev(void)
     /* Just testing that qemu doesn't crash... */
=20
     free_pci_device(dev);
-    ide_test_quit();
+    ide_test_quit(qts);
 }
=20
 static void test_flush_empty_drive(void)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
=20
-    ide_test_start("-device ide-cd,bus=3Dide.0");
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    qts =3D ide_test_start("-device ide-cd,bus=3Dide.0");
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* FLUSH CACHE command on device 0 */
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -778,7 +810,7 @@ static void test_flush_empty_drive(void)
     /* Just testing that qemu doesn't crash... */
=20
     free_pci_device(dev);
-    ide_test_quit();
+    ide_test_quit(qts);
 }
=20
 static void test_pci_retry_flush(void)
@@ -823,21 +855,21 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, Q=
PCIBar ide_bar,
     }
 }
=20
-static void nsleep(int64_t nsecs)
+static void nsleep(QTestState *qts, int64_t nsecs)
 {
     const struct timespec val =3D { .tv_nsec =3D nsecs };
     nanosleep(&val, NULL);
-    clock_set(nsecs);
+    qtest_clock_set(qts, nsecs);
 }
=20
-static uint8_t ide_wait_clear(uint8_t flag)
+static uint8_t ide_wait_clear(QTestState *qts, uint8_t flag)
 {
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     uint8_t data;
     time_t st;
=20
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
=20
     /* Wait with a 5 second timeout */
     time(&st);
@@ -850,26 +882,26 @@ static uint8_t ide_wait_clear(uint8_t flag)
         if (difftime(time(NULL), st) > 5.0) {
             break;
         }
-        nsleep(400);
+        nsleep(qts, 400);
     }
     g_assert_not_reached();
 }
=20
-static void ide_wait_intr(int irq)
+static void ide_wait_intr(QTestState *qts, int irq)
 {
     time_t st;
     bool intr;
=20
     time(&st);
     while (true) {
-        intr =3D get_irq(irq);
+        intr =3D qtest_get_irq(qts, irq);
         if (intr) {
             return;
         }
         if (difftime(time(NULL), st) > 5.0) {
             break;
         }
-        nsleep(400);
+        nsleep(qts, 400);
     }
=20
     g_assert_not_reached();
@@ -877,6 +909,7 @@ static void ide_wait_intr(int irq)
=20
 static void cdrom_pio_impl(int nblocks)
 {
+    QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
     FILE *fh;
@@ -897,10 +930,11 @@ static void cdrom_pio_impl(int nblocks)
     g_assert_cmpint(ret, =3D=3D, patt_blocks);
     fclose(fh);
=20
-    ide_test_start("-drive if=3Dnone,file=3D%s,media=3Dcdrom,format=3Dra=
w,id=3Dsr0,index=3D0 "
-                   "-device ide-cd,drive=3Dsr0,bus=3Dide.0", tmp_path);
-    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qts =3D ide_test_start(
+            "-drive if=3Dnone,file=3D%s,media=3Dcdrom,format=3Draw,id=3D=
sr0,index=3D0 "
+            "-device ide-cd,drive=3Dsr0,bus=3Dide.0", tmp_path);
+    dev =3D get_pci_device(qts, &bmdma_bar, &ide_bar);
+    qtest_irq_intercept_in(qts, "ioapic");
=20
     /* PACKET command on device 0 */
     qpci_io_writeb(dev, ide_bar, reg_device, 0);
@@ -908,8 +942,8 @@ static void cdrom_pio_impl(int nblocks)
     qpci_io_writeb(dev, ide_bar, reg_lba_high, (BYTE_COUNT_LIMIT >> 8 & =
0xFF));
     qpci_io_writeb(dev, ide_bar, reg_command, CMD_PACKET);
     /* HP0: Check_Status_A State */
-    nsleep(400);
-    data =3D ide_wait_clear(BSY);
+    nsleep(qts, 400);
+    data =3D ide_wait_clear(qts, BSY);
     /* HP1: Send_Packet State */
     assert_bit_set(data, DRQ | DRDY);
     assert_bit_clear(data, ERR | DF | BSY);
@@ -930,10 +964,10 @@ static void cdrom_pio_impl(int nblocks)
         size_t rem =3D (rxsize / 2) - offset;
=20
         /* HP3: INTRQ_Wait */
-        ide_wait_intr(IDE_PRIMARY_IRQ);
+        ide_wait_intr(qts, IDE_PRIMARY_IRQ);
=20
         /* HP2: Check_Status_B (and clear IRQ) */
-        data =3D ide_wait_clear(BSY);
+        data =3D ide_wait_clear(qts, BSY);
         assert_bit_set(data, DRQ | DRDY);
         assert_bit_clear(data, ERR | DF | BSY);
=20
@@ -945,17 +979,17 @@ static void cdrom_pio_impl(int nblocks)
     }
=20
     /* Check for final completion IRQ */
-    ide_wait_intr(IDE_PRIMARY_IRQ);
+    ide_wait_intr(qts, IDE_PRIMARY_IRQ);
=20
     /* Sanity check final state */
-    data =3D ide_wait_clear(DRQ);
+    data =3D ide_wait_clear(qts, DRQ);
     assert_bit_set(data, DRDY);
     assert_bit_clear(data, DRQ | ERR | DF | BSY);
=20
     g_assert_cmpint(memcmp(pattern, rx, rxsize), =3D=3D, 0);
     g_free(pattern);
     g_free(rx);
-    test_bmdma_teardown();
+    test_bmdma_teardown(qts);
     free_pci_device(dev);
 }
=20
@@ -973,6 +1007,7 @@ static void test_cdrom_pio_large(void)
=20
 static void test_cdrom_dma(void)
 {
+    QTestState *qts;
     static const size_t len =3D ATAPI_BLOCK_SIZE;
     size_t ret;
     char *pattern =3D g_malloc(ATAPI_BLOCK_SIZE * 16);
@@ -981,9 +1016,10 @@ static void test_cdrom_dma(void)
     PrdtEntry prdt[1];
     FILE *fh;
=20
-    ide_test_start("-drive if=3Dnone,file=3D%s,media=3Dcdrom,format=3Dra=
w,id=3Dsr0,index=3D0 "
-                   "-device ide-cd,drive=3Dsr0,bus=3Dide.0", tmp_path);
-    qtest_irq_intercept_in(global_qtest, "ioapic");
+    qts =3D ide_test_start(
+            "-drive if=3Dnone,file=3D%s,media=3Dcdrom,format=3Draw,id=3D=
sr0,index=3D0 "
+            "-device ide-cd,drive=3Dsr0,bus=3Dide.0", tmp_path);
+    qtest_irq_intercept_in(qts, "ioapic");
=20
     guest_buf =3D guest_alloc(&guest_malloc, len);
     prdt[0].addr =3D cpu_to_le32(guest_buf);
@@ -995,15 +1031,15 @@ static void test_cdrom_dma(void)
     g_assert_cmpint(ret, =3D=3D, 16);
     fclose(fh);
=20
-    send_dma_request(CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read10);
+    send_dma_request(qts, CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read1=
0);
=20
     /* Read back data from guest memory into local qtest memory */
-    memread(guest_buf, rx, len);
+    qtest_memread(qts, guest_buf, rx, len);
     g_assert_cmpint(memcmp(pattern, rx, len), =3D=3D, 0);
=20
     g_free(pattern);
     g_free(rx);
-    test_bmdma_teardown();
+    test_bmdma_teardown(qts);
 }
=20
 int main(int argc, char **argv)
@@ -1028,7 +1064,6 @@ int main(int argc, char **argv)
=20
     qtest_add_func("/ide/identify", test_identify);
=20
-    qtest_add_func("/ide/bmdma/setup", test_bmdma_setup);
     qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
     qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
     qtest_add_func("/ide/bmdma/short_prdt", test_bmdma_short_prdt);
@@ -1036,7 +1071,6 @@ int main(int argc, char **argv)
                    test_bmdma_one_sector_short_prdt);
     qtest_add_func("/ide/bmdma/long_prdt", test_bmdma_long_prdt);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
-    qtest_add_func("/ide/bmdma/teardown", test_bmdma_teardown);
=20
     qtest_add_func("/ide/flush", test_flush);
     qtest_add_func("/ide/flush/nodev", test_flush_nodev);
--=20
2.21.0


