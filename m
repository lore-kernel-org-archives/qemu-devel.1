Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095C8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9106205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QMoy0VXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9106205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58071 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOmUd-0003or-TB
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:06:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmOB-00073m-Pd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hOmO9-0004v7-NE
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hOmO9-0004uF-Ce
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:59:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id a12so4062276wrn.4
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=U0zDg1s6WI9XoLsKBZxlXIwIvYOHnfoQr+jPvoURE9E=;
	b=QMoy0VXgAW10XOFqmXNO8YWD9Fuw5MWdP4RI6leQTc9tpE0AHVMBlF2ObVEFmjDIkj
	QL3TLQH/Men11d4prvE87uYiYpsBZ8l8EIgJcDj84BxY1qgwhsk+2AB08T+nLgHjQn/R
	dRpU5/1qgQIjY7d4LK2k9+UkAi1hiG62WNCgjylqoYH5Ck3L0Yt9jbagDmdDYwRRD+r1
	GvNSQ3cwk2ki1ipgF+gl4Usik2BxW1zoxIyilm7++oPA85v8PyNBYzuImtOVA+JVuM7y
	Xky5zuKr5qxNd6UCALymA88BmIHJvNEU0eJjYPJz64n9lNZsyG4NMwfoE+kx9dzoMAMk
	3hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=U0zDg1s6WI9XoLsKBZxlXIwIvYOHnfoQr+jPvoURE9E=;
	b=PmLxUspSwaIR1X1aqbQsEcFp3IXnDBw/5TejHNWrTU1LBoriGPJTTbQ04H9OJjs1Zu
	qPolQPg7nuiAvg6H/GmnfF/LRr8j09yoDH12S1cjv2QTBlTOxftar1m10JXBHMNGNzlH
	nXFfBpxL6ZOlePY3kWrs2G1j0jhPuBYFExdiLzvk8/Th5uPoRxTRnW6sanq8lCBVBKmn
	xAOMLbSgDsH1F0YDqB8quJ9qlAzaj/BhgcXR4MftsdSrJdAIESIjlXJ87ClBbGHJSAG4
	f95V/hgWTRKRoyGAprP4nIgo7ArGqttHwBF0Mot8kqUXHADRrf/alBEkOhjNt8PEmjTF
	zAxg==
X-Gm-Message-State: APjAAAX8LozDH14u8dyOZcx2wSs0a/iaG0hI4qwRoWmAZ40i174pjbSN
	1CBO2OLWBk7VI+nAB01MvzzpCHEWXgM=
X-Google-Smtp-Source: APXvYqx9uCrRSr/9ONVB7fazXPnUKq7qPJ2TPqxvHSJQE2780kYQAkJzXo3WJq6jMkybPQZ+B5KrVw==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr3947326wrp.242.1557421160137; 
	Thu, 09 May 2019 09:59:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a21sm3042252wmm.8.2019.05.09.09.59.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 May 2019 09:59:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DC36F1FF9A;
	Thu,  9 May 2019 17:59:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 17:58:58 +0100
Message-Id: <20190509165912.10512-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190509165912.10512-1-alex.bennee@linaro.org>
References: <20190509165912.10512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v1 10/23] tests/tcg/multiarch: expand system
 memory test to cover more
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Expand the memory test to cover move of the softmmu code. Specifically
we:

  - improve commentary
  - add some helpers (for later BE support)
  - reduce boiler plate into helpers
  - add signed reads at various sizes/offsets

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target |   2 +
 tests/tcg/i386/Makefile.softmmu-target    |   2 +
 tests/tcg/multiarch/system/memory.c       | 346 +++++++++++++++++-----
 3 files changed, 278 insertions(+), 72 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index cdb836f7e1e..63d82f1bf41 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -28,5 +28,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
+memory: CFLAGS+=-DCHECK_UNALIGNED
+
 # Running
 QEMU_OPTS+=-M virt -cpu max -display none -semihosting-config enable=on,target=native,chardev=output -kernel
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index c31bbbf39a7..a0d8adf12cd 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -42,5 +42,7 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
+memory: CFLAGS+=-DCHECK_UNALIGNED
+
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index a7a0a8e9784..ccd1a9db7f5 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -5,18 +5,29 @@
  * behave across normal and unaligned accesses across several pages.
  * We are not replicating memory tests for stuck bits and other
  * hardware level failures but looking for issues with different size
- * accesses when:
-
+ * accesses when access is:
  *
+ *   - unaligned at various sizes (if -DCHECK_UNALIGNED set)
+ *   - spanning a (softmmu) page
+ *   - sign extension when loading
  */
 
 #include <inttypes.h>
+#include <stdbool.h>
 #include <minilib.h>
 
-#define TEST_SIZE (4096 * 4)  /* 4 pages */
+#define PAGE_SIZE 4096             /* nominal 4k "pages" */
+#define TEST_SIZE (PAGE_SIZE * 4)  /* 4 pages */
+
+#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])))
 
+__attribute__((aligned(PAGE_SIZE)))
 static uint8_t test_data[TEST_SIZE];
 
+typedef void (*init_ufn) (int offset);
+typedef bool (*read_ufn) (int offset);
+typedef bool (*read_sfn) (int offset, bool nf);
+
 static void pdot(int count)
 {
     if (count % 128 == 0) {
@@ -24,17 +35,26 @@ static void pdot(int count)
     }
 }
 
+/*
+ * Helper macros for shift/extract so we can keep our endian handling
+ * in one place.
+ */
+#define BYTE_SHIFT(b, pos) ((uint64_t)b << (pos * 8))
+#define BYTE_EXTRACT(b, pos) ((b >> (pos * 8)) & 0xff)
 
 /*
- * Fill the data with ascending value bytes. As x86 is a LE machine we
- * write in ascending order and then read and high byte should either
- * be zero or higher than the lower bytes.
+ * Fill the data with ascending value bytes.
+ *
+ * Currently we only support Little Endian machines so write in
+ * ascending address order. When we read higher address bytes should
+ * either be zero or higher than the lower bytes.
  */
 
-static void init_test_data_u8(void)
+static void init_test_data_u8(int unused_offset)
 {
     uint8_t count = 0, *ptr = &test_data[0];
     int i;
+    (void)(unused_offset);
 
     ml_printf("Filling test area with u8:");
     for (i = 0; i < TEST_SIZE; i++) {
@@ -44,62 +64,112 @@ static void init_test_data_u8(void)
     ml_printf("done\n");
 }
 
+/*
+ * Full the data with alternating positive and negative bytes. This
+ * should mean for reads larger than a byte all subsequent reads will
+ * stay either negative or positive. We never write 0.
+ */
+
+static inline uint8_t get_byte(int index, bool neg)
+{
+    return neg ? (0xff << (index % 7)) : (0xff >> ((index % 6) + 1));
+}
+
+static void init_test_data_s8(bool neg_first)
+{
+    uint8_t top, bottom, *ptr = &test_data[0];
+    int i;
+
+    ml_printf("Filling test area with s8 pairs (%s):",
+              neg_first ? "neg first" : "pos first");
+    for (i = 0; i < TEST_SIZE / 2; i++) {
+        *ptr++ = get_byte(i, neg_first);
+        *ptr++ = get_byte(i, !neg_first);
+        pdot(i);
+    }
+    ml_printf("done\n");
+}
+
+/*
+ * Zero the first few bytes of the test data in preparation for
+ * new offset values.
+ */
+static void reset_start_data(int offset)
+{
+    uint32_t *ptr = (uint32_t *) &test_data[0];
+    int i;
+    for (i = 0; i < offset; i++) {
+        *ptr++ = 0;
+    }
+}
+
 static void init_test_data_u16(int offset)
 {
     uint8_t count = 0;
-    uint16_t word, *ptr = (uint16_t *) &test_data[0];
+    uint16_t word, *ptr = (uint16_t *) &test_data[offset];
     const int max = (TEST_SIZE - offset) / sizeof(word);
     int i;
 
-    ml_printf("Filling test area with u16 (offset %d):", offset);
+    ml_printf("Filling test area with u16 (offset %d, %p):", offset, ptr);
 
-    /* Leading zeros */
-    for (i = 0; i < offset; i++) {
-        *ptr = 0;
-    }
+    reset_start_data(offset);
 
-    ptr = (uint16_t *) &test_data[offset];
     for (i = 0; i < max; i++) {
-        uint8_t high, low;
-        low = count++;
-        high = count++;
-        word = (high << 8) | low;
+        uint8_t low = count++, high = count++;
+        word = BYTE_SHIFT(high, 1) | BYTE_SHIFT(low, 0);
         *ptr++ = word;
         pdot(i);
     }
-    ml_printf("done\n");
+    ml_printf("done @ %p\n", ptr);
 }
 
 static void init_test_data_u32(int offset)
 {
     uint8_t count = 0;
-    uint32_t word, *ptr = (uint32_t *) &test_data[0];
+    uint32_t word, *ptr = (uint32_t *) &test_data[offset];
     const int max = (TEST_SIZE - offset) / sizeof(word);
     int i;
 
-    ml_printf("Filling test area with u32 (offset %d):", offset);
+    ml_printf("Filling test area with u32 (offset %d, %p):", offset, ptr);
 
-    /* Leading zeros */
-    for (i = 0; i < offset; i++) {
-        *ptr = 0;
-    }
+    reset_start_data(offset);
 
-    ptr = (uint32_t *) &test_data[offset];
     for (i = 0; i < max; i++) {
-        uint8_t b1, b2, b3, b4;
-        b4 = count++;
-        b3 = count++;
-        b2 = count++;
-        b1 = count++;
-        word = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
+        uint8_t b4 = count++, b3 = count++;
+        uint8_t b2 = count++, b1 = count++;
+        word = BYTE_SHIFT(b1, 3) | BYTE_SHIFT(b2, 2) | BYTE_SHIFT(b3, 1) | b4;
         *ptr++ = word;
         pdot(i);
     }
-    ml_printf("done\n");
+    ml_printf("done @ %p\n", ptr);
 }
 
+static void init_test_data_u64(int offset)
+{
+    uint8_t count = 0;
+    uint64_t word, *ptr = (uint64_t *) &test_data[offset];
+    const int max = (TEST_SIZE - offset) / sizeof(word);
+    int i;
+
+    ml_printf("Filling test area with u64 (offset %d, %p):", offset, ptr);
+
+    reset_start_data(offset);
 
-static int read_test_data_u16(int offset)
+    for (i = 0; i < max; i++) {
+        uint8_t b8 = count++, b7 = count++;
+        uint8_t b6 = count++, b5 = count++;
+        uint8_t b4 = count++, b3 = count++;
+        uint8_t b2 = count++, b1 = count++;
+        word = BYTE_SHIFT(b1, 7) | BYTE_SHIFT(b2, 6) | BYTE_SHIFT(b3, 5) |
+               BYTE_SHIFT(b4, 4) | BYTE_SHIFT(b5, 3) | BYTE_SHIFT(b6, 2) |
+               BYTE_SHIFT(b7, 1) | b8;
+        *ptr++ = word;
+        pdot(i);
+    }
+    ml_printf("done @ %p\n", ptr);
+}
+
+static bool read_test_data_u16(int offset)
 {
     uint16_t word, *ptr = (uint16_t *)&test_data[offset];
     int i;
@@ -114,17 +184,17 @@ static int read_test_data_u16(int offset)
         low = word & 0xff;
         if (high < low && high != 0) {
             ml_printf("Error %d < %d\n", high, low);
-            return 1;
+            return false;
         } else {
             pdot(i);
         }
 
     }
-    ml_printf("done\n");
-    return 0;
+    ml_printf("done @ %p\n", ptr);
+    return true;
 }
 
-static int read_test_data_u32(int offset)
+static bool read_test_data_u32(int offset)
 {
     uint32_t word, *ptr = (uint32_t *)&test_data[offset];
     int i;
@@ -145,16 +215,16 @@ static int read_test_data_u32(int offset)
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0)) {
             ml_printf("Error %d, %d, %d, %d", b1, b2, b3, b4);
-            return 2;
+            return false;
         } else {
             pdot(i);
         }
     }
-    ml_printf("done\n");
-    return 0;
+    ml_printf("done @ %p\n", ptr);
+    return true;
 }
 
-static int read_test_data_u64(int offset)
+static bool read_test_data_u64(int offset)
 {
     uint64_t word, *ptr = (uint64_t *)&test_data[offset];
     int i;
@@ -184,60 +254,192 @@ static int read_test_data_u64(int offset)
             (b7 < b8 && b7 != 0)) {
             ml_printf("Error %d, %d, %d, %d, %d, %d, %d, %d",
                       b1, b2, b3, b4, b5, b6, b7, b8);
-            return 2;
+            return false;
         } else {
             pdot(i);
         }
     }
-    ml_printf("done\n");
-    return 0;
+    ml_printf("done @ %p\n", ptr);
+    return true;
 }
 
 /* Read the test data and verify at various offsets */
-int do_reads(void)
+read_ufn read_ufns[] = { read_test_data_u16,
+                         read_test_data_u32,
+                         read_test_data_u64 };
+
+bool do_unsigned_reads(void)
 {
-    int r = 0;
-    int off = 0;
+    int i;
+    bool ok = true;
 
-    while (r == 0 && off < 8) {
-        r = read_test_data_u16(off);
-        r |= read_test_data_u32(off);
-        r |= read_test_data_u64(off);
-        off++;
+    for (i = 0; i < ARRAY_SIZE(read_ufns) && ok; i++) {
+#ifdef CHECK_UNALIGNED
+        int off;
+        for (off = 0; off < 8 && ok; off++) {
+            ok = read_ufns[i](off);
+        }
+#else
+        ok = read_ufns[i](0);
+#endif
     }
 
-    return r;
+    return ok;
 }
 
-int main(void)
+static bool do_unsigned_test(init_ufn fn)
 {
-    int i, r = 0;
+#ifdef CHECK_UNALIGNED
+    bool ok = true;
+    int i;
+    for (i = 0; i < 8 && ok; i++) {
+        fn(i);
+        ok = do_unsigned_reads();
+    }
+#else
+    fn(0);
+    return do_unsigned_reads();
+#endif
+}
+
+/*
+ * We need to ensure signed data is read into a larger data type to
+ * ensure that sign extension is working properly.
+ */
+
+static bool read_test_data_s8(int offset, bool neg_first)
+{
+    int8_t *ptr = (int8_t *)&test_data[offset];
+    int i;
+    const int max = (TEST_SIZE - offset) / 2;
+
+    ml_printf("Reading s8 pairs from %#lx (offset %d):", ptr, offset);
 
+    for (i = 0; i < max; i++) {
+        int16_t first, second;
+        bool ok;
+        first = *ptr++;
+        second = *ptr++;
 
-    init_test_data_u8();
-    r = do_reads();
-    if (r) {
-        return r;
+        if (neg_first && first < 0 && second > 0) {
+            pdot(i);
+        } else if (!neg_first && first > 0 && second < 0) {
+            pdot(i);
+        } else {
+            ml_printf("Error %d %c %d\n", first, neg_first ? '<' : '>', second);
+            return false;
+        }
     }
+    ml_printf("done @ %p\n", ptr);
+    return true;
+}
+
+static bool read_test_data_s16(int offset, bool neg_first)
+{
+    int16_t *ptr = (int16_t *)&test_data[offset];
+    int i;
+    const int max = (TEST_SIZE - offset) / (sizeof(*ptr));
 
-    for (i = 0; i < 8; i++) {
-        init_test_data_u16(i);
+    ml_printf("Reading s16 from %#lx (offset %d, %s):", ptr,
+              offset, neg_first ? "neg" : "pos");
 
-        r = do_reads();
-        if (r) {
-            return r;
+    for (i = 0; i < max; i++) {
+        int32_t data = *ptr++;
+
+        if (neg_first && data < 0) {
+            pdot(i);
+        } else if (data > 0) {
+            pdot(i);
+        } else {
+            ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
+            return false;
         }
     }
+    ml_printf("done @ %p\n", ptr);
+    return true;
+}
 
-    for (i = 0; i < 8; i++) {
-        init_test_data_u32(i);
+static bool read_test_data_s32(int offset, bool neg_first)
+{
+    int32_t *ptr = (int32_t *)&test_data[offset];
+    int i;
+    const int max = (TEST_SIZE - offset) / (sizeof(int32_t));
+
+    ml_printf("Reading s32 from %#lx (offset %d, %s):",
+              ptr, offset, neg_first ? "neg" : "pos");
 
-        r = do_reads();
-        if (r) {
-            return r;
+    for (i = 0; i < max; i++) {
+        int64_t data = *ptr++;
+
+        if (neg_first && data < 0) {
+            pdot(i);
+        } else if (data > 0) {
+            pdot(i);
+        } else {
+            ml_printf("Error %d %c 0\n", data, neg_first ? '<' : '>');
+            return false;
+        }
+    }
+    ml_printf("done @ %p\n", ptr);
+    return true;
+}
+
+/*
+ * Read the test data and verify at various offsets
+ *
+ * For everything except bytes all our reads should be either positive
+ * or negative depending on what offset we are reading from. Currently
+ * we only handle LE systems.
+ */
+read_sfn read_sfns[] = { read_test_data_s8,
+                         read_test_data_s16,
+                         read_test_data_s32 };
+
+bool do_signed_reads(bool neg_first)
+{
+    int i;
+    bool ok = true;
+
+    for (i = 0; i < ARRAY_SIZE(read_sfns) && ok; i++) {
+#ifdef CHECK_UNALIGNED
+        int off;
+        for (off = 0; off < 8 && ok; off++) {
+            bool nf = i == 0 ? neg_first ^ (off & 1) : !(neg_first ^ (off & 1));
+            ok = read_sfns[i](off, nf);
         }
+#else
+        ok = read_sfns[i](0, i == 0 ? neg_first : !neg_first);
+#endif
+    }
+
+    return ok;
+}
+
+init_ufn init_ufns[] = { init_test_data_u8,
+                         init_test_data_u16,
+                         init_test_data_u32,
+                         init_test_data_u64 };
+
+int main(void)
+{
+    int i;
+    bool ok = true;
+
+    /* Run through the unsigned tests first */
+    for (i = 0; i < ARRAY_SIZE(init_ufns) && ok; i++) {
+        ok = do_unsigned_test(init_ufns[i]);
+    }
+
+    if (ok) {
+        init_test_data_s8(false);
+        ok = do_signed_reads(false);
+    }
+
+    if (ok) {
+        init_test_data_s8(true);
+        ok = do_signed_reads(true);
     }
 
-    ml_printf("Test complete: %s\n", r == 0 ? "PASSED" : "FAILED");
-    return r;
+    ml_printf("Test complete: %s\n", ok ? "PASSED" : "FAILED");
+    return ok ? 0 : -1;
 }
-- 
2.20.1


