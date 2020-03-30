Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2E9C2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00D020786
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A5v7+2Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00D020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIw2L-0004dr-5b
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jIw1W-00048i-OL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1jIw1R-0003eT-2m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:08:18 -0400
Received: from m12-15.163.com ([220.181.12.15]:51624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liq3ea@163.com>) id 1jIw1O-0003TK-RA
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=stO3J/KMOFYfQQJVoI
 sdSLk7ULyKnQE/lroD5QxL4sg=; b=A5v7+2UeDsKibyfF2u2TKb/vd+8a/xoLhC
 pleyrbkrrQjhkHPMefFAF9keCYeFyF5Vj7U1M7ekwTcMEf2v1QKk1sgfZV+jxRoq
 W9D/kQIpW31LCVpZsHpr4/8HC5lU2qVrJWD1njfo4VP9NO/iNbS7x0hBz5i2xOJy
 YF4UMrDy4=
Received: from localhost.localdomain (unknown [183.159.74.161])
 by smtp11 (Coremail) with SMTP id D8CowAAnbmqUB4JefFAUBw--.32567S4;
 Mon, 30 Mar 2020 22:52:05 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v2] qtest: add tulip test case
Date: Mon, 30 Mar 2020 07:52:01 -0700
Message-Id: <20200330145201.32534-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAAnbmqUB4JefFAUBw--.32567S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF15CrWDZrW7uF1fCrWxWFg_yoW7tF1DpF
 yDA3ZI9r48JF13Xrn7C3W2yF15Ga9a93W7CFW7uF18urZxX3srKan7Kr9FvFsY9FWkXr15
 Cw18tFn3GF1DtF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCJmUUUUUU=
X-Originating-IP: [183.159.74.161]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoRb2bVQHJQ6w6gAAsO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.15
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tulip networking card emulation has an OOB issue in
'tulip_copy_tx_buffers' when the guest provide malformed descriptor.
This test will trigger a ASAN heap overflow crash. To trigger this
issue we can construct the data as following:

1. construct a 'tulip_descriptor'. Its control is set to
'0x7ff | 0x7ff << 11', this will make the 'tulip_copy_tx_buffers's
'len1' and 'len2' to 0x7ff(2047). So 'len1+len2' will overflow
'TULIPState's 'tx_frame' field. This descriptor's 'buf_addr1' and
'buf_addr2' should set to a guest address.

2. write this descriptor to tulip device's CSR4 register. This will
set the 'TULIPState's 'current_tx_desc' field.

3. write 'CSR6_ST' to tulip device's CSR6 register. This will trigger
'tulip_xmit_list_update' and finally calls 'tulip_copy_tx_buffers'.

Following shows the backtrack of crash:

==31781==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x628000007cd0 at pc 0x7fe03c5a077a bp 0x7fff05b46770 sp 0x7fff05b45f18
WRITE of size 2047 at 0x628000007cd0 thread T0
    #0 0x7fe03c5a0779  (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x79779)
    #1 0x5575fb6daa6a in flatview_read_continue /home/test/qemu/exec.c:3194
    #2 0x5575fb6daccb in flatview_read /home/test/qemu/exec.c:3227
    #3 0x5575fb6dae66 in address_space_read_full /home/test/qemu/exec.c:3240
    #4 0x5575fb6db0cb in address_space_rw /home/test/qemu/exec.c:3268
    #5 0x5575fbdfd460 in dma_memory_rw_relaxed /home/test/qemu/include/sysemu/dma.h:87
    #6 0x5575fbdfd4b5 in dma_memory_rw /home/test/qemu/include/sysemu/dma.h:110
    #7 0x5575fbdfd866 in pci_dma_rw /home/test/qemu/include/hw/pci/pci.h:787
    #8 0x5575fbdfd8a3 in pci_dma_read /home/test/qemu/include/hw/pci/pci.h:794
    #9 0x5575fbe02761 in tulip_copy_tx_buffers hw/net/tulip.c:585
    #10 0x5575fbe0366b in tulip_xmit_list_update hw/net/tulip.c:678
    #11 0x5575fbe04073 in tulip_write hw/net/tulip.c:783

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:

Add detail descriptor construction to trigger the crash.
Use CSR6_ST to replace the magic value.

 tests/qtest/Makefile.include |  1 +
 tests/qtest/tulip-test.c     | 91 ++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/qtest/tulip-test.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 10a28de8a3..9e5a51d033 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -217,6 +217,7 @@ qos-test-obj-y += tests/qtest/es1370-test.o
 qos-test-obj-y += tests/qtest/ipoctal232-test.o
 qos-test-obj-y += tests/qtest/megasas-test.o
 qos-test-obj-y += tests/qtest/ne2000-test.o
+qos-test-obj-y += tests/qtest/tulip-test.o
 qos-test-obj-y += tests/qtest/nvme-test.o
 qos-test-obj-y += tests/qtest/pca9552-test.o
 qos-test-obj-y += tests/qtest/pci-test.o
diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c
new file mode 100644
index 0000000000..2fb6c4d5a7
--- /dev/null
+++ b/tests/qtest/tulip-test.c
@@ -0,0 +1,91 @@
+/*
+ * QTest testcase for DEC/Intel Tulip 21143
+ *
+ * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
+#include "qemu/bitops.h"
+#include "hw/net/tulip.h"
+
+typedef struct QTulip_pci QTulip_pci;
+
+struct QTulip_pci {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *tulip_pci_get_driver(void *obj, const char *interface)
+{
+    QTulip_pci *tulip_pci = obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &tulip_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in tulip_pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void *tulip_pci_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
+{
+    QTulip_pci *tulip_pci = g_new0(QTulip_pci, 1);
+    QPCIBus *bus = pci_bus;
+
+    qpci_device_init(&tulip_pci->dev, bus, addr);
+    tulip_pci->obj.get_driver = tulip_pci_get_driver;
+
+    return &tulip_pci->obj;
+}
+
+static void tulip_large_tx(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QTulip_pci *tulip_pci = obj;
+    QPCIDevice *dev = &tulip_pci->dev;
+    QPCIBar bar;
+    struct tulip_descriptor context;
+    char guest_data[4096];
+    uint64_t context_pa;
+    uint64_t guest_pa;
+
+    qpci_device_enable(dev);
+    bar = qpci_iomap(dev, 0, NULL);
+    context_pa = guest_alloc(alloc, sizeof(context));
+    guest_pa = guest_alloc(alloc, 4096);
+    memset(guest_data, 'A', sizeof(guest_data));
+    context.status = TDES0_OWN;
+    context.control = TDES1_BUF2_SIZE_MASK << TDES1_BUF2_SIZE_SHIFT |
+                      TDES1_BUF1_SIZE_MASK << TDES1_BUF1_SIZE_SHIFT;
+    context.buf_addr2 = guest_pa;
+    context.buf_addr1 = guest_pa;
+
+    qtest_memwrite(dev->bus->qts, context_pa, &context, sizeof(context));
+    qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_data));
+    qpci_io_writel(dev, bar, 0x20, context_pa);
+    qpci_io_writel(dev, bar, 0x30, CSR6_ST);
+    guest_free(alloc, context_pa);
+    guest_free(alloc, guest_pa);
+}
+
+static void tulip_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts = {
+        .extra_device_opts = "addr=04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
+
+    qos_node_create_driver("tulip", tulip_pci_create);
+    qos_node_consumes("tulip", "pci-bus", &opts);
+    qos_node_produces("tulip", "pci-device");
+
+    qos_add_test("tulip_large_tx", "tulip", tulip_large_tx, NULL);
+}
+
+libqos_init(tulip_register_nodes);
-- 
2.17.1



