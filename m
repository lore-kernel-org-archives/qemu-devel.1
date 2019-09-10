Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB2B20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asDMx+rv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB2B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bxM-0008JP-GC
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkl-0003Mb-6f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkj-0006KK-Qj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:32985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkj-0006Ir-9Z
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:57 -0400
Received: by mail-wr1-x435.google.com with SMTP id u16so18412070wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PUVyEpIm8xDvUjx6imvtRp1EhVGxflCktIw84etrgf0=;
 b=asDMx+rvf67LLEacPQF3cMJeUBogR6PQcI1iVWdneklvW0OcrX+/9Cy4YUIucVkphp
 DDwjhcHo0umI+5HvWq/KzFooRL1JclR8Vb6HMNJ7PT+eEfq3zTzwrGmdCxnXo7jai0LJ
 Dexq+FWbcFfWosT5ERXKao/HPkTBxdFtSczWlhERi+Su4hxinD8FCgXHMon1duMUJFO2
 E9g40jL07/fxYVehj2ttT6kayOUn+naC0MEUAf5EH/clHvRKeuPWOJFVmpTEyDue22Q2
 Gg/ADBot+Wf3M2Y8Z1klSF2+1TcvaKqqTfa7nMVKwgQ8J8hRwH/AQY3CCd/pUS4h3JUV
 DL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PUVyEpIm8xDvUjx6imvtRp1EhVGxflCktIw84etrgf0=;
 b=cKhyZFGnP0f7VwEimPII7nm0aBHsliN19iw3M8ScsTrQkHZ8T2/kV1St7MIQYW0fPc
 2M9vnm1mu5lebXtDblQvi3zFUKlFpyd9hg1kNgxcG8BFZyB/loMWDNcHQzVA2LrNUXH9
 NnfAOMz2V/quW++uWpBVYm5rKVY69vtRgSy1csZ2jNCOun4zRWBvNmuKC4HLeAhLbU8H
 aBXKZycn7OSijH7+r0iId+vBqZcjCEq/KxaRYEru01aN5W+rARMLyKYgJcxDp7fRu7Hx
 tRrCIuKGAy5/zWWpg2YxWijr9Fmlno1L8Jya0BFHm1q66+Ha+Rg8zNHFLEEeaTir7uu8
 w1fA==
X-Gm-Message-State: APjAAAUl+92JiNGfNNM9XGmVkhmPri0q84P+wgNqbx2lvg2S+37hgxAT
 x1areup5ZbS+ca4JCQIKsdD1vA==
X-Google-Smtp-Source: APXvYqzWDBpUaz+gV7Iv3UGmcuWbeSw69omo9hJM8xW1cfOftQZNiMAiECz0mTKpEAvXp128Z3Y6Tg==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr25080280wrv.248.1568105036125; 
 Tue, 10 Sep 2019 01:43:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o19sm23334877wro.50.2019.09.10.01.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 17E9D1FF96;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:11 +0100
Message-Id: <20190910084349.28817-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 07/45] tests/tcg: use EXTRA_CFLAGS everywhere
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

For i386 specifically, this allows using the host GCC
to compile the i386 tests.  But, it should really be
done for all targets, unless we want to pass $(EXTRA_CFLAGS)
directly as part of $(CC).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20190807143523.15917-2-pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 2e560e4d08e..4c4aaf61dd3 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -22,11 +22,11 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
diff --git a/tests/tcg/alpha/Makefile.softmmu-target b/tests/tcg/alpha/Makefile.softmmu-target
index 3c0f34cc692..09193a62d68 100644
--- a/tests/tcg/alpha/Makefile.softmmu-target
+++ b/tests/tcg/alpha/Makefile.softmmu-target
@@ -22,11 +22,11 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) -x assembler-with-cpp -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=0
 
diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makefile.softmmu-target
index 49d48d8a1c3..2deb06e6e46 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -18,7 +18,7 @@ CFLAGS+=-Wl,--build-id=none -x assembler-with-cpp
 LDFLAGS+=-nostdlib -N -static
 
 %: %.S %.ld
-	$(CC) $(CFLAGS) $(ASFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
+	$(CC) $(CFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
 
 # Specific Test Rules
 
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 0a4364868ce..cee342017e5 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -32,11 +32,11 @@ TESTS+=$(MULTIARCH_TESTS)
 .PRECIOUS: $(CRT_OBJS)
 
 %.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 # Build and link the tests
 %: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
diff --git a/tests/tcg/minilib/Makefile.target b/tests/tcg/minilib/Makefile.target
index 3ed8077d0f9..c821d2806a9 100644
--- a/tests/tcg/minilib/Makefile.target
+++ b/tests/tcg/minilib/Makefile.target
@@ -18,4 +18,4 @@ MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
 .PRECIOUS: $(MINILIB_OBJS)
 
 %.o: $(SYSTEM_MINILIB_SRC)/%.c
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
index 8212d96b81d..9530cac2ad9 100644
--- a/tests/tcg/xtensa/Makefile.softmmu-target
+++ b/tests/tcg/xtensa/Makefile.softmmu-target
@@ -34,9 +34,9 @@ $(XTENSA_USABLE_TESTS): linker.ld macros.inc $(CRT) Makefile.softmmu-target
 
 # special rule for common blobs
 %.o: %.S
-	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) -c $< -o $@
+	$(CC) $(XTENSA_INC) $($*_ASFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
 
 %: %.S
-	$(CC) $(XTENSA_INC) $(ASFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
+	$(CC) $(XTENSA_INC) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(NOSTDFLAGS) $(CRT)
 
 endif
-- 
2.20.1


