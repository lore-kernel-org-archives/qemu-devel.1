Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577D8C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C93206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kP2zDC8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C93206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45976 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYji-0000sI-D4
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:26:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhH-0007Mj-DE
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYYhG-0008RJ-0t
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYYhF-0008ON-Pe
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:23:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id n4so17088806wrs.3
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=rgBvXlBNWOdKdXf6eUYyvBxYKbwloU7UKvzHljRF0GU=;
	b=kP2zDC8FAHOIZ3KFQtxk4US8fuYGuxYs8OBDx3Sa1g2pD5/C6XAaCm9FtYwqPuGca+
	QVQSYUWmfY1lCh2fdJG0PLLcyyxDuVZQ2xueGM0Qfw9iVm9fgjk4QjJZ+fQoRVW8x7rS
	JiebdhrFIjmBGSBDIGoGm2ydL575jxXbBI6Tz3XWUqW9Us2DniOD1Fk4vgEB9yvoPAFG
	DiG8Gq09WkJ1Jm3w55FKtqRAxUA8jiMqaNzYMXoxtYRwp9txv3G3rffD3VglndayBKFL
	dZiSkNzbhyWKjVNotKyaRLKmQi0FDqYUQxSscjm2jpurHeVgtAU7uB0aX/FuhovMaFJL
	sdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=rgBvXlBNWOdKdXf6eUYyvBxYKbwloU7UKvzHljRF0GU=;
	b=N9XfMCbpnpT281B1HbipWM2pVOe5zktcgpU1vyTKfoZldUn2TUtbsEsgtl0AUralvQ
	8qnP3HS6b1Okm7XlKh/9xDq23i/h3wZy5s/bnt7apQ66PATDIEU4jD5FCfXlfrBmF9Fz
	uu2S0cqIlUNJJn+HsQAe/gZkBzXid3oSr3mbFGAqUctUfMuFWdmksiuAw3DvKovqf7Xu
	wKBwxJB19pV/Dax9m1TJtOZ7kGvCPN6cl/ptYIrViNxkOlw2Qa82w+CryEdXvgBZE9zp
	0fzxGwtS7AIkVOZ6JsNKgSZezTc51QmcxFELVovqsGKQ/Ld0zw2ehsZAWF5S0qDYImkN
	VUWg==
X-Gm-Message-State: APjAAAU0gncs8I2dXYH2j2fO05YhO2vGV4a0Iw/xBnessb4Gn4lUrTiI
	hRLJ7p+y+7c98vfIyBcRBp1RxA==
X-Google-Smtp-Source: APXvYqzFgjekIQ895yxEMzdRMYtGAnXpCUar2MotWFKkusL9akKJN/h3fvQF/tm8W4uiRF5KKWEYgg==
X-Received: by 2002:a05:6000:100a:: with SMTP id
	a10mr25150382wrx.323.1559751808802; 
	Wed, 05 Jun 2019 09:23:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	l18sm18893090wrv.38.2019.06.05.09.23.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 09:23:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BA9781FF8F;
	Wed,  5 Jun 2019 17:23:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 17:23:24 +0100
Message-Id: <20190605162326.13896-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605162326.13896-1-alex.bennee@linaro.org>
References: <20190605162326.13896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 2/4] tests/tcg: better detect truncated reads
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we've truncated a wider read we can detect the condition earlier by
looking at the number of zeros we've read. So we don't trip up on
cases where we have written zeros to the start of the buffer we also
ensure we only start each offset read from the right address.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/multiarch/system/memory.c | 36 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/multiarch/system/memory.c b/tests/tcg/multiarch/system/memory.c
index dc1d8a98ff..d124502d73 100644
--- a/tests/tcg/multiarch/system/memory.c
+++ b/tests/tcg/multiarch/system/memory.c
@@ -208,6 +208,7 @@ static bool read_test_data_u32(int offset)
 
     for (i = 0; i < max; i++) {
         uint8_t b1, b2, b3, b4;
+        int zeros = 0;
         word = *ptr++;
 
         b1 = word >> 24 & 0xff;
@@ -215,6 +216,16 @@ static bool read_test_data_u32(int offset)
         b3 = word >> 8 & 0xff;
         b4 = word & 0xff;
 
+        zeros += (b1 == 0 ? 1 : 0);
+        zeros += (b2 == 0 ? 1 : 0);
+        zeros += (b3 == 0 ? 1 : 0);
+        zeros += (b4 == 0 ? 1 : 0);
+        if (zeros > 1) {
+            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d",
+                      ptr - 1, b1, b2, b3, b4);
+            return false;
+        }
+
         if ((b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0)) {
@@ -238,6 +249,7 @@ static bool read_test_data_u64(int offset)
 
     for (i = 0; i < max; i++) {
         uint8_t b1, b2, b3, b4, b5, b6, b7, b8;
+        int zeros = 0;
         word = *ptr++;
 
         b1 = ((uint64_t) (word >> 56)) & 0xff;
@@ -249,6 +261,20 @@ static bool read_test_data_u64(int offset)
         b7 = (word >> 8)  & 0xff;
         b8 = (word >> 0)  & 0xff;
 
+        zeros += (b1 == 0 ? 1 : 0);
+        zeros += (b2 == 0 ? 1 : 0);
+        zeros += (b3 == 0 ? 1 : 0);
+        zeros += (b4 == 0 ? 1 : 0);
+        zeros += (b5 == 0 ? 1 : 0);
+        zeros += (b6 == 0 ? 1 : 0);
+        zeros += (b7 == 0 ? 1 : 0);
+        zeros += (b8 == 0 ? 1 : 0);
+        if (zeros > 1) {
+            ml_printf("Error @ %p, more zeros than expected: %d, %d, %d, %d, %d, %d, %d, %d",
+                      ptr - 1, b1, b2, b3, b4, b5, b6, b7, b8);
+            return false;
+        }
+
         if ((b1 < b2 && b1 != 0) ||
             (b2 < b3 && b2 != 0) ||
             (b3 < b4 && b3 != 0) ||
@@ -272,7 +298,7 @@ read_ufn read_ufns[] = { read_test_data_u16,
                          read_test_data_u32,
                          read_test_data_u64 };
 
-bool do_unsigned_reads(void)
+bool do_unsigned_reads(int start_off)
 {
     int i;
     bool ok = true;
@@ -280,11 +306,11 @@ bool do_unsigned_reads(void)
     for (i = 0; i < ARRAY_SIZE(read_ufns) && ok; i++) {
 #if CHECK_UNALIGNED
         int off;
-        for (off = 0; off < 8 && ok; off++) {
+        for (off = start_off; off < 8 && ok; off++) {
             ok = read_ufns[i](off);
         }
 #else
-        ok = read_ufns[i](0);
+        ok = read_ufns[i](start_off);
 #endif
     }
 
@@ -298,11 +324,11 @@ static bool do_unsigned_test(init_ufn fn)
     int i;
     for (i = 0; i < 8 && ok; i++) {
         fn(i);
-        ok = do_unsigned_reads();
+        ok = do_unsigned_reads(i);
     }
 #else
     fn(0);
-    return do_unsigned_reads();
+    return do_unsigned_reads(0);
 #endif
 }
 
-- 
2.20.1


