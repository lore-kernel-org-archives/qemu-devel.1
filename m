Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFF2C2BBC7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:17:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA7E20857
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9hQChXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA7E20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNCGN-0008Eo-QX
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCED-0005VN-4n
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCEB-0005cX-RY
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCEB-0005c2-LQ; Sat, 11 Apr 2020 05:15:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id i10so4704774wrv.10;
 Sat, 11 Apr 2020 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VNJuqR9RvHlYF2029BwTSqDJA9AO9s7mV7e8lqyUNrg=;
 b=G9hQChXI9BfNwiSIf36B507V4ZB8zQt1Ids3Vbgp/n+IerhmalO4v0/eakNVEbQfCs
 wluzVcUaj/YOlL/M2ckM+betC/Fdt0QYY4OMogyr78F2sW+T5pAEudnF99hvhmqBpuO8
 AnvPy1GAbF72gqoxSl4svAPdv3I04Jbm4Zobv4yogkk1HpRr5GBD4OIi5Wt9w+YAmmBc
 cmlxTsqLPLvgTV/tSjxVSbubAjBmYkU96DJQgdYwQG1wUkEIfgPDu8Xxcc56lYvH8NN8
 jiiVUIuKjOh7PvVxh4VvfBGcixvP3nvONmeLVQ6jDNOlqihC93KDSrU9q4W58Jb4Xksm
 QuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VNJuqR9RvHlYF2029BwTSqDJA9AO9s7mV7e8lqyUNrg=;
 b=eyyBl8UKbk6b+rL+F/yT0nfBDLO4miCTH22QD4MDyCpt9Iod0cgDd+EYLo3VMb0na1
 Vj9vt3bPCjIqmSbF8P59p+0S6Tjl+jLoFcKJBF0hB1vBMp38jM4ect5HE5hLw4w5S0dc
 KJyaZxhM2t9e6fCDTZIlfx+zl033l5FnDnoKg4qj3qQ5uOwSEHLEkvNpzfDCLMOcv8zC
 0lENxdyO7/sbomgXjzVg4IOlJMv0jmU50oIC/TnKTf3t8L/RLqG+pOAfthXA9rh+Umye
 +XyjinpqL/+O/d+XCGXJRHAyR2PUT6/BxRKoWks8n1M35GCpohjFz5jq9GI8/n1eAF8V
 MJGQ==
X-Gm-Message-State: AGi0Puayf8YDdvMQ3GXhmSR5s7X7dhzV9JEw12Pnz84l7jDE0lN/PCDi
 XLQqOHF+BxN7IIqtP00h7dX8oZdjrvM=
X-Google-Smtp-Source: APiQypJLn4aCqT41mBnZdRgvns5KYN96zGwimprMWbltkBOB+VC6xkNCEStlkYNY9XtwcQYhaFp7xQ==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr8819643wro.197.1586596502238; 
 Sat, 11 Apr 2020 02:15:02 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f83sm6073301wmf.42.2020.04.11.02.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 02:15:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-5.0 2/2] qtest: Test the Drawing Engine of the SM501
 companion
Date: Sat, 11 Apr 2020 11:14:53 +0200
Message-Id: <20200411091453.30371-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200411091453.30371-1-f4bug@amsat.org>
References: <20200411091453.30371-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Run some PCI commands to call the COPY_AREA() macro in
sm501_2d_operation(), and verify that there is no more
overflow as reported in BZ#1786026 [*].

The SM501 is used by the R2D-PLUS and aCube Sam460ex
machines, but since it is a PCI card and we already have
an easy way to test PCI daughter cards on the sPAPR
machine, test it there.

[*] https://bugzilla.redhat.com/show_bug.cgi?id=1786026
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/sm501-test.c     | 106 +++++++++++++++++++++++++++++++++++
 tests/qtest/Makefile.include |   2 +
 2 files changed, 108 insertions(+)
 create mode 100644 tests/qtest/sm501-test.c

diff --git a/tests/qtest/sm501-test.c b/tests/qtest/sm501-test.c
new file mode 100644
index 0000000000..79bf7c2c21
--- /dev/null
+++ b/tests/qtest/sm501-test.c
@@ -0,0 +1,106 @@
+/*
+ * QEMU test for the SM501 companion
+ *
+ * SPDX-FileCopyrightText: 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu-common.h"
+#include "libqtest.h"
+#include "libqos/libqos-spapr.h"
+#include "hw/pci/pci_ids.h"
+
+typedef struct {
+    QOSState *qs;
+    QPCIDevice *dev;
+    QPCIBar bar;
+} PciSm501State;
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    *((QPCIDevice **)data) = dev;
+}
+
+static void sm501_init(PciSm501State *s)
+{
+    uint64_t barsize;
+
+    s->dev = NULL;
+    qpci_device_foreach(s->qs->pcibus, PCI_VENDOR_ID_SILICON_MOTION,
+                        PCI_DEVICE_ID_SM501, save_fn, &s->dev);
+    g_assert(s->dev != NULL);
+
+    qpci_device_enable(s->dev);
+
+    /* BAR#0: VRAM, BAR#1: MMIO registers */
+    s->bar = qpci_iomap(s->dev, 1, &barsize);
+    g_assert_cmpuint(barsize, ==, 2 * MiB);
+}
+
+static void sm501_deinit(PciSm501State *s)
+{
+    g_free(s->dev);
+}
+
+static uint32_t sm501_read(PciSm501State *s, uint64_t off)
+{
+    uint32_t val;
+
+    s->dev->bus->memread(s->dev->bus, s->bar.addr + off, &val, sizeof(val));
+
+    return val;
+}
+
+static void sm501_write(PciSm501State *s, uint64_t off, uint32_t val)
+{
+    s->dev->bus->memwrite(s->dev->bus, s->bar.addr + off, &val, sizeof(val));
+}
+
+static void sm501_check_device_id(PciSm501State *s)
+{
+    g_assert_cmphex(sm501_read(s, 0x60) >> 16, ==, 0x501); /* DEVICEID reg */
+}
+
+/*
+ * Try to reproduce the heap overflow reported in
+ * https://bugzilla.redhat.com/show_bug.cgi?id=1786026
+ */
+static void test_sm501_2d_drawing_engine_op(void)
+{
+    PciSm501State s;
+
+    s.qs = qtest_spapr_boot("-machine pseries -device sm501");
+
+    sm501_init(&s);
+    sm501_check_device_id(&s);
+
+    /*
+     * Commands listed in BZ#1786026 to access
+     * COPY_AREA() in sm501_2d_operation().
+     */
+    sm501_write(&s, 0x100000,        0x0);  /* src: (x, y) = (0, 0) */
+    sm501_write(&s, 0x100004,        0x0);  /* dst: (x, y) = (0, 0) */
+    sm501_write(&s, 0x100008, 0x00100010);  /* dim: height = width = 16 */
+    sm501_write(&s, 0x100010, 0x00100010);  /* pitch: height = width = 16 */
+    sm501_write(&s, 0x10000c, 0xcc000088);  /* ctrl: op = copy area, RTL */
+
+    /* If the overflow occured, the next call will fail. */
+    sm501_check_device_id(&s);
+
+    sm501_deinit(&s);
+
+    qtest_shutdown(s.qs);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!strcmp(qtest_get_arch(), "ppc64")) {
+        qtest_add_func("spapr/sm501_2d_op", test_sm501_2d_drawing_engine_op);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 9e5a51d033..7ec894a7a9 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -109,6 +109,7 @@ check-qtest-ppc64-$(CONFIG_VGA) += display-vga-test
 check-qtest-ppc64-y += numa-test
 check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
 check-qtest-ppc64-y += cpu-plug-test
+check-qtest-ppc64-$(CONFIG_SM501) += sm501-test
 
 check-qtest-sh4-$(CONFIG_ISA_TESTDEV) = endianness-test
 
@@ -253,6 +254,7 @@ tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
 tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
 tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-obj-y)
 tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj-y)
+tests/qtest/sm501-test$(EXESUF): tests/qtest/sm501-test.o $(libqos-spapr-obj-y)
 tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
 tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
 tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
-- 
2.21.1


