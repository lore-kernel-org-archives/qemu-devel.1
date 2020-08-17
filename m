Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C73C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB732054F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZz8f4n2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB732054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hvS-0003w4-IR
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqs-0002BN-Bi
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7hqo-00054M-RT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 12:19:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id r15so5658937wrp.13
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ObJNJE/1Ce4anWxkpsO1TM66WWuyMS9eIMcj33K+RL0=;
 b=NZz8f4n2WNcCIEUeLAFpFJ2qj5veUi76cE+hvQl3c1EQkiuEfdwM2EQDY3UAenbTzs
 DJY90Bhktu66WxdQ0Nwlmg+EaZUqT5Qdnqmz3WJ1ovVsgs222d4RCNGU7u3jiX6qNuKq
 T91LAjskDMo1/3ysP7Tad8NR1fiHOL0OAYbgF7WU6Zee6xH1hUgOXkcR9agsq+yRuvrh
 pwQ7j0ricqAPs/2BV2oBaDeS2i17LqYl8ybnwo764jjhRVXnvH5NOzoRbGhLmQ/FzWMD
 0KxAj3diF/U1maOCYZ09i2nTMB7vupXOYWu4ZrowuNPfgjfwk1dTvsoKzCw4LwQsbd/l
 ThuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ObJNJE/1Ce4anWxkpsO1TM66WWuyMS9eIMcj33K+RL0=;
 b=Q3LdzknU2Hie5xb3rHbkfoDeP4VvTIsH2ZcKJv2VYeoTTo5Xug6mGkgyBKFitfqde5
 pJjIKErQ5CH+FoiQocEYO0L51A/E1Xxytus/CcJ/5JaZiOtZn/rXNdhc9QzjeLnJzTcs
 Dj/x63BXUYCqLy0tTuU1gqXHZZgDdSVcP/LXRpSLRomHJm7cRCJLJFwKWv3vzB9e7yXb
 VXSdsMpGJnlB+dNomG6r67F8iRVbWehL5GwtxHZ09WQV9GcB3XjJ4zOjkd7Mq7VWch1N
 yPpLFbkVlWfhjl1Xg1jhZ6Zd43qmL9I9sUmSW37DGaysh3frhpEDeLiT9TJSEVX/YD+8
 PpBA==
X-Gm-Message-State: AOAM530nKe9sLl/Oip24o68dvimS51/AezWkq/+J4Lff0F0qzzuUiu+y
 KnLe5qIcOjehd6M45ClpqCl9N+46A6g=
X-Google-Smtp-Source: ABdhPJzNyhSHNxrR9lz1MYElSPqQzbnxH71HC1fzxDgPou8xJCzbjOF24ed4HJh46hOvK7xdr7m+kw==
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr17692877wrn.340.1597681147041; 
 Mon, 17 Aug 2020 09:19:07 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r3sm29535472wro.1.2020.08.17.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 09:19:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 7/9] tests/qtest: Add generic MMIO tests
Date: Mon, 17 Aug 2020 18:18:51 +0200
Message-Id: <20200817161853.593247-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
References: <20200817161853.593247-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add generic MMIO tests (which don't need any particular knowledge
about the architecture) and can be run without any CPU (using the
'none' machine).

Start testing the interleaved memory accesses.

Cross-endianess is not tested (host and target must have the same
endianess).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qtest/mmio-test.c      | 146 +++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |   1 +
 tests/qtest/Makefile.include |   1 +
 3 files changed, 148 insertions(+)
 create mode 100644 tests/qtest/mmio-test.c

diff --git a/tests/qtest/mmio-test.c b/tests/qtest/mmio-test.c
new file mode 100644
index 0000000000..7a31eb8e9d
--- /dev/null
+++ b/tests/qtest/mmio-test.c
@@ -0,0 +1,146 @@
+/*
+ * QTest testcases for generic MMIO accesses
+ *
+ * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qemu/bswap.h"
+
+/* Must fit in arch address space */
+static const uint64_t base = 0x20000000ul;
+
+static bool is_cross_endian(QTestState *qts)
+{
+    bool te = qtest_big_endian(qts);
+#ifdef HOST_WORDS_BIGENDIAN
+    te = !te;
+#endif
+    return te;
+}
+
+static QTestState *create_interleaver_qtest(void)
+{
+    QTestState *qts;
+
+    qts = qtest_initf("-M none -device mmio-testdev,address=0x%" PRIx64, base);
+    if (is_cross_endian(qts)) {
+        g_test_skip("Skipping on cross-endian targets");
+        qtest_quit(qts);
+        return NULL;
+    }
+    return qts;
+}
+
+static void test_interleaver_rd32x8a(void)
+{
+    QTestState *qts = create_interleaver_qtest();
+
+    if (!qts) {
+        return;
+    }
+
+    /* write sram directly */
+    qtest_writeb(qts, base + 0x000, 0x10);
+    qtest_writeb(qts, base + 0x100, 0x32);
+    qtest_writeb(qts, base + 0x200, 0x54);
+    qtest_writeb(qts, base + 0x300, 0x76);
+    /* read via interleaver */
+    g_assert_cmphex(qtest_readl(qts, base + 0x13208000 + 0x00), ==, 0x76543210);
+    qtest_quit(qts);
+}
+
+static void test_interleaver_rd32x8b(void)
+{
+    QTestState *qts = create_interleaver_qtest();
+
+    if (!qts) {
+        return;
+    }
+
+    /* write sram directly */
+    qtest_writeb(qts, base + 0x003, 0x10);
+    qtest_writeb(qts, base + 0x103, 0x32);
+    qtest_writeb(qts, base + 0x203, 0x54);
+    qtest_writeb(qts, base + 0x303, 0x76);
+    /* read via interleaver */
+    g_assert_cmphex(qtest_readl(qts, base + 0x13208000 + 0x0c), ==, 0x76543210);
+    qtest_quit(qts);
+}
+
+static void test_interleaver_rd32x16(void)
+{
+    QTestState *qts = create_interleaver_qtest();
+
+    if (!qts) {
+        return;
+    }
+
+    /* write sram directly */
+    qtest_writew(qts, base + 0x002, 0x3210);
+    qtest_writew(qts, base + 0x102, 0x7654);
+    /* read via interleaver */
+    g_assert_cmphex(qtest_readl(qts, base + 0x13216000 + 0x04), ==, 0x76543210);
+    qtest_quit(qts);
+}
+
+static void test_interleaver_wr32x16(void)
+{
+    QTestState *qts = create_interleaver_qtest();
+
+    if (!qts) {
+        return;
+    }
+
+    /* write via interleaver */
+    qtest_writel(qts, base + 0x13216000 + 0x04, 0x76543210);
+    /* read sram directly */
+    g_assert_cmphex(qtest_readw(qts, base + 0x002), ==, 0x3210);
+    g_assert_cmphex(qtest_readw(qts, base + 0x102), ==, 0x7654);
+    qtest_quit(qts);
+}
+
+static void test_interleaver_wr64x8(void)
+{
+    QTestState *qts = create_interleaver_qtest();
+
+    if (!qts) {
+        return;
+    }
+
+    /* write via interleaver */
+    qtest_writeq(qts, base + 0x16408000 + 0x08, 0x9876543210);
+    /* read sram directly */
+    g_assert_cmphex(qtest_readb(qts, base + 0x001), ==, 0x10);
+    g_assert_cmphex(qtest_readb(qts, base + 0x101), ==, 0x32);
+    g_assert_cmphex(qtest_readb(qts, base + 0x401), ==, 0x98);
+    qtest_quit(qts);
+}
+
+static struct {
+    const char *name;
+    void (*test)(void);
+} tests[] = {
+    {"interleaver/rd32x8a", test_interleaver_rd32x8a},
+    {"interleaver/rd32x8b", test_interleaver_rd32x8b},
+    {"interleaver/rd32x16", test_interleaver_rd32x16},
+    {"interleaver/wr32x16", test_interleaver_wr32x16},
+    {"interleaver/wr64x8",  test_interleaver_wr64x8},
+};
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
+        g_autofree gchar *path = g_strdup_printf("mmio/%s",
+                                                 tests[i].name);
+        qtest_add_func(path, tests[i].test);
+    }
+
+    return g_test_run();
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index f75b8c984a..93efef1b87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1968,6 +1968,7 @@ F: include/hw/misc/interleaver.h
 F: hw/misc/interleaver.c
 F: hw/misc/mmio-testdev.c
 F: include/hw/misc/testdev.h
+F: tests/qtest/mmio-test.c
 
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index b0204e44f2..29dbeb5d05 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -9,6 +9,7 @@ check-qtest-generic-y += qmp-cmd-test
 check-qtest-generic-y += qom-test
 check-qtest-generic-$(CONFIG_MODULES) += modules-test
 check-qtest-generic-y += test-hmp
+check-qtest-generic-$(CONFIG_MMIO_TESTDEV) += mmio-test
 
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
 check-qtest-pci-$(CONFIG_VGA) += display-vga-test
-- 
2.26.2


