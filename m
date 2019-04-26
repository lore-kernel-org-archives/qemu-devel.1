Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED0C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB00208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="HIK6FZYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB00208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49292 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3iv-0005Sd-48
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:29:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gs-00044A-MP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gq-0000uy-Ph
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:10 -0400
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f]:54601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3go-0000tA-Rw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:08 -0400
Received: by mail-it1-x12f.google.com with SMTP id a190so6784397ite.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=x1D1gW1VeXrG3BnPtsTgjJU8dXr+PKiPI7BfP3fK3eY=;
	b=HIK6FZYZBhVvUqz7zcJgc8LWkuMw1hM1lLZ+eoxUw3c0OxYAlB6jBhBMB4PYKeavd7
	VjwKwfIdKdUwmHQEbxlYqpPp8FTxI858l6+bXoP94tcrA6ma1Bm8LoQbw6wdbbl2I2nd
	e9D9bC8zIm8c3T6UuW+SZcuyMmfHl//GYvBjme45z86dzAdrmVB53fcKSvW8sMszY88K
	5NxSwfoFNxrgwAcdgYZ2cVypsRCK7FywdB371D5DCE5kUqoN9aYVrtusmACsU2Ou/+PS
	ipuO4DSvzHJ6WOZ9UCK1z3Sb6Awlh8TpdyXFkvzEVqEXoZqDzJzO+uQgiW/PosOGfqa7
	RbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=x1D1gW1VeXrG3BnPtsTgjJU8dXr+PKiPI7BfP3fK3eY=;
	b=Iys5KtTRfUNyIbOCcFR7XgZ9Bbqz9zhHSKvL3dAfbJrfMc9xnJkQ9sPand2IJ/SA4P
	xma0zJlRVjbkhjzbyeBlbE2wXHEjRssIbwXaXTj11JoTxx5DH7MuS7/1hmQ7tcWt7WYc
	Q5o1/y8oK/L3FDqpT/c2hNpu6oInJyXt4rgwaAqM/tktdMeiHaKFzRuDQPruPgi7mT14
	m9o9Ep8hjAioyaUIDIY4u091PPTF874sZT2b63ioAd6i5LEn/L7rMAp9emRzfa7rOkHI
	JcJU8QHsBhq/XCfcr3XI50ItTUwcwv4J1k9btus7dPmnbqE01g65KHayJ3IRf3VgWYhX
	+BiA==
X-Gm-Message-State: APjAAAXJw45u1OiD2JgxnWil2JTtYzUpb9Bh4W7EmPn82PGl2DBtKqZo
	w6yzSPMkp5xkzvm5q3Nia019ciYVK+kEOA==
X-Google-Smtp-Source: APXvYqzTQTk8JRvh4S3b0Mfj4DRjUrqww1w9rpA/MHbTPpRSY1UAbVLHp1pQDQkSgzpljqlOcSWStQ==
X-Received: by 2002:a24:3288:: with SMTP id j130mr9427591ita.104.1556296024559;
	Fri, 26 Apr 2019 09:27:04 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:04 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:15 -0400
Message-Id: <20190426162624.55977-2-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::12f
Subject: [Qemu-devel] [PATCH v4 01/10] block/pflash_cfi02: Add test for
 supported commands
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426162615.4uoUuj3BmZ35-v2le3kghCNS396odb-49yt2ik2Gxac@z>

Test the AMD command set for parallel flash chips. This test uses an
ARM musicpal board with a pflash drive to test the following list of
currently-supported commands.
- Autoselect
- CFI
- Sector erase
- Chip erase
- Program
- Unlock bypass
- Reset

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 225 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tests/pflash-cfi02-test.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 36fc73fef5..dbdb2c0082 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -263,6 +263,7 @@ check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
 check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/hexloader-test$(EXESUF)
+check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
 
 check-qtest-aarch64-y = tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
@@ -773,6 +774,7 @@ tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
 tests/rtc-test$(EXESUF): tests/rtc-test.o
 tests/m48t59-test$(EXESUF): tests/m48t59-test.o
 tests/hexloader-test$(EXESUF): tests/hexloader-test.o
+tests/pflash-cfi02$(EXESUF): tests/pflash-cfi02-test.o
 tests/endianness-test$(EXESUF): tests/endianness-test.o
 tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
 tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
new file mode 100644
index 0000000000..40af1bb523
--- /dev/null
+++ b/tests/pflash-cfi02-test.c
@@ -0,0 +1,225 @@
+/*
+ * QTest testcase for parallel flash with AMD command set
+ *
+ * Copyright (c) 2019 Stephen Checkoway
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * To test the pflash_cfi02 device, we run QEMU with the musicpal machine with
+ * a pflash drive. This enables us to test some flash configurations, but not
+ * all. In particular, we're limited to a 16-bit wide flash device.
+ */
+
+#define MP_FLASH_SIZE_MAX (32 * 1024 * 1024)
+#define BASE_ADDR (0x100000000ULL - MP_FLASH_SIZE_MAX)
+
+#define FLASH_WIDTH 2
+#define CFI_ADDR (FLASH_WIDTH * 0x55)
+#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
+#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
+
+#define CFI_CMD 0x98
+#define UNLOCK0_CMD 0xAA
+#define UNLOCK1_CMD 0x55
+#define AUTOSELECT_CMD 0x90
+#define RESET_CMD 0xF0
+#define PROGRAM_CMD 0xA0
+#define SECTOR_ERASE_CMD 0x30
+#define CHIP_ERASE_CMD 0x10
+#define UNLOCK_BYPASS_CMD 0x20
+#define UNLOCK_BYPASS_RESET_CMD 0x00
+
+static char image_path[] = "/tmp/qtest.XXXXXX";
+
+static inline void flash_write(uint64_t byte_addr, uint16_t data)
+{
+    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
+}
+
+static inline uint16_t flash_read(uint64_t byte_addr)
+{
+    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
+}
+
+static void unlock(void)
+{
+    flash_write(UNLOCK0_ADDR, UNLOCK0_CMD);
+    flash_write(UNLOCK1_ADDR, UNLOCK1_CMD);
+}
+
+static void reset(void)
+{
+    flash_write(0, RESET_CMD);
+}
+
+static void sector_erase(uint64_t byte_addr)
+{
+    unlock();
+    flash_write(UNLOCK0_ADDR, 0x80);
+    unlock();
+    flash_write(byte_addr, SECTOR_ERASE_CMD);
+}
+
+static void wait_for_completion(uint64_t byte_addr)
+{
+    /* If DQ6 is toggling, step the clock and ensure the toggle stops. */
+    if ((flash_read(byte_addr) & 0x40) ^ (flash_read(byte_addr) & 0x40)) {
+        /* Wait for erase or program to finish. */
+        clock_step_next();
+        /* Ensure that DQ6 has stopped toggling. */
+        g_assert_cmpint(flash_read(byte_addr), ==, flash_read(byte_addr));
+    }
+}
+
+static void bypass_program(uint64_t byte_addr, uint16_t data)
+{
+    flash_write(UNLOCK0_ADDR, PROGRAM_CMD);
+    flash_write(byte_addr, data);
+    /*
+     * Data isn't valid until DQ6 stops toggling. We don't model this as
+     * writes are immediate, but if this changes in the future, we can wait
+     * until the program is complete.
+     */
+    wait_for_completion(byte_addr);
+}
+
+static void program(uint64_t byte_addr, uint16_t data)
+{
+    unlock();
+    bypass_program(byte_addr, data);
+}
+
+static void chip_erase(void)
+{
+    unlock();
+    flash_write(UNLOCK0_ADDR, 0x80);
+    unlock();
+    flash_write(UNLOCK0_ADDR, SECTOR_ERASE_CMD);
+}
+
+static void test_flash(void)
+{
+    global_qtest = qtest_initf("-M musicpal,accel=qtest "
+                               "-drive if=pflash,file=%s,format=raw,copy-on-read",
+                               image_path);
+    /* Check the IDs. */
+    unlock();
+    flash_write(UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), ==, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), ==, 0x236D);
+    reset();
+
+    /* Check the erase blocks. */
+    flash_write(CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x10), ==, 'Q');
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x11), ==, 'R');
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x12), ==, 'Y');
+    /* Num erase regions. */
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x2C), >=, 1);
+    uint32_t nb_sectors = flash_read(FLASH_WIDTH * 0x2D) +
+                          (flash_read(FLASH_WIDTH * 0x2E) << 8) + 1;
+    uint32_t sector_len = (flash_read(FLASH_WIDTH * 0x2F) << 8) +
+                          (flash_read(FLASH_WIDTH * 0x30) << 16);
+    reset();
+
+    /* Erase and program sector. */
+    for (uint32_t i = 0; i < nb_sectors; ++i) {
+        uint64_t byte_addr = i * sector_len;
+        sector_erase(byte_addr);
+        /* Read toggle. */
+        uint16_t status0 = flash_read(byte_addr);
+        /* DQ7 is 0 during an erase. */
+        g_assert_cmpint(status0 & 0x80, ==, 0);
+        uint16_t status1 = flash_read(byte_addr);
+        /* DQ6 toggles during an erase. */
+        g_assert_cmpint(status0 & 0x40, !=, status1 & 0x40);
+        /* Wait for erase to complete. */
+        clock_step_next();
+        /* Ensure DQ6 has stopped toggling. */
+        g_assert_cmpint(flash_read(byte_addr), ==, flash_read(byte_addr));
+        /* Now the data should be valid. */
+        g_assert_cmpint(flash_read(byte_addr), ==, 0xFFFF);
+
+        /* Program a bit pattern. */
+        program(byte_addr, 0x5555);
+        g_assert_cmpint(flash_read(byte_addr), ==, 0x5555);
+        program(byte_addr, 0xAA55);
+        g_assert_cmpint(flash_read(byte_addr), ==, 0x0055);
+    }
+
+    /* Erase the chip. */
+    chip_erase();
+    /* Read toggle. */
+    uint16_t status0 = flash_read(0);
+    /* DQ7 is 0 during an erase. */
+    g_assert_cmpint(status0 & 0x80, ==, 0);
+    uint16_t status1 = flash_read(0);
+    /* DQ6 toggles during an erase. */
+    g_assert_cmpint(status0 & 0x40, !=, status1 & 0x40);
+    /* Wait for erase to complete. */
+    clock_step_next();
+    /* Ensure DQ6 has stopped toggling. */
+    g_assert_cmpint(flash_read(0), ==, flash_read(0));
+    /* Now the data should be valid. */
+    g_assert_cmpint(flash_read(0), ==, 0xFFFF);
+
+    /* Unlock bypass */
+    unlock();
+    flash_write(UNLOCK0_ADDR, UNLOCK_BYPASS_CMD);
+    bypass_program(0, 0x0123);
+    bypass_program(2, 0x4567);
+    bypass_program(4, 0x89AB);
+    /*
+     * Test that bypass programming, unlike normal programming can use any
+     * address for the PROGRAM_CMD.
+     */
+    flash_write(6, PROGRAM_CMD);
+    flash_write(6, 0xCDEF);
+    wait_for_completion(6);
+    flash_write(0, UNLOCK_BYPASS_RESET_CMD);
+    bypass_program(8, 0x55AA); /* Should fail. */
+    g_assert_cmpint(flash_read(0), ==, 0x0123);
+    g_assert_cmpint(flash_read(2), ==, 0x4567);
+    g_assert_cmpint(flash_read(4), ==, 0x89AB);
+    g_assert_cmpint(flash_read(6), ==, 0xCDEF);
+    g_assert_cmpint(flash_read(8), ==, 0xFFFF);
+
+    qtest_quit(global_qtest);
+}
+
+static void cleanup(void *opaque)
+{
+    unlink(image_path);
+}
+
+int main(int argc, char **argv)
+{
+    int fd = mkstemp(image_path);
+    if (fd == -1) {
+        g_printerr("Failed to create temporary file %s: %s\n", image_path,
+                   strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+    if (ftruncate(fd, 8 * 1024 * 1024) < 0) {
+        int error_code = errno;
+        close(fd);
+        unlink(image_path);
+        g_printerr("Failed to truncate file %s to 8 MB: %s\n", image_path,
+                   strerror(error_code));
+        exit(EXIT_FAILURE);
+    }
+    close(fd);
+
+    qtest_add_abrt_handler(cleanup, NULL);
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("pflash-cfi02", test_flash);
+    int result = g_test_run();
+    cleanup(NULL);
+    return result;
+}
-- 
2.20.1 (Apple Git-117)


