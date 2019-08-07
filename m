Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8DC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A2F21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAMd6s8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A2F21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvN2w-0004eR-Bq
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41740)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2H-0003Wl-KS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hvN2G-0006b2-Ho
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hvN2G-0006aP-A2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:35:28 -0400
Received: by mail-wm1-x332.google.com with SMTP id 207so301521wma.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=17S8+srOfxdrNTILDf4H97ECt1wzvAyOrkiP+8O9a4E=;
 b=uAMd6s8zvT8O9YKfO0CKczpOpo5SW8ErgsFw6sLovdNkx6b0uzfJ8vVKt+hJIowx0X
 7ff5MuTW2MyeOOGnas5STSIKgzv565qTUhpRsqDKHOhVM5M6WHFFxofxWyUJuaFPxgCz
 ZFlRFAitu8PdhugYNkfIQV8YbQ2MHC2nhnDeDR9x4i+EcsP19i9O7hIc9TFpY5uKp8/I
 09hjxTjWCYS2I48f9PFJ0LGIiBeT/EdmDGWy1q17ufbZty8G5vjfQqwQSvYubXPr0ZqO
 dPv+6LU6o/qklpqyHWNPqUH7jaB+XFK18PDaBq3XGBD0rMVsGu/ZnEKJ8gWHa4UEDliR
 JQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=17S8+srOfxdrNTILDf4H97ECt1wzvAyOrkiP+8O9a4E=;
 b=qhLvZR8iX6wxyxtRbL50Jfrp9EVBwKDihzzDe2NEIXgOX8TCQPmFOdCL7vSMQIbyxU
 CkOOmaOWW19rFach5CZbu22zzJGioVCoARmMu8TCBxql7QqdUpIhTxHe26Vw6iJuwG4/
 nSA3E4mWXOnJ0JGPIVxh3lQWxZ4dnTHlYyXELd8senBwQkwJMgtmrVmqucLQKohzDZ1X
 htaaN2RrG9gCO/b6hTu7jMIPciGLut15fgADQ0OdAe9ZY2Ozc6MP20Ol8HqfmcUQ9Sse
 0lbDB2Og9P5KhHoym+QwhJaBNMqy74QMoGUgyp/zUbzZ07jyn6dQyFPa2S+44poYnAHc
 Ilng==
X-Gm-Message-State: APjAAAUfeVRgqeomq9LDcxRaZYfhVJ4L69zqVb+H7IkSsj+O8qU5cDQ3
 jJoP4IhVfqe7hu2a+GMN1dAXWZIS
X-Google-Smtp-Source: APXvYqx4vw73+kgqNmdsYuZ6EtxyiELi5Wz5jc4HF2mlCixm1EWg+CBbwZm1HWifG/8TOeL94eWkXQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr245534wmo.151.1565188526825; 
 Wed, 07 Aug 2019 07:35:26 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id o4sm86004wmh.35.2019.08.07.07.35.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:35:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 16:35:21 +0200
Message-Id: <20190807143523.15917-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807143523.15917-1-pbonzini@redhat.com>
References: <20190807143523.15917-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH v2 1/3] tests/tcg: use EXTRA_CFLAGS everywhere
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For i386 specifically, this allows using the host GCC
to compile the i386 tests.  But, it should really be
done for all targets, unless we want to pass $(EXTRA_CFLAGS)
directly as part of $(CC).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 4 ++--
 tests/tcg/alpha/Makefile.softmmu-target   | 4 ++--
 tests/tcg/arm/Makefile.softmmu-target     | 2 +-
 tests/tcg/i386/Makefile.softmmu-target    | 4 ++--
 tests/tcg/minilib/Makefile.target         | 2 +-
 tests/tcg/xtensa/Makefile.softmmu-target  | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 2e560e4d08..4c4aaf61dd 100644
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
index 3c0f34cc69..09193a62d6 100644
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
index 49d48d8a1c..2deb06e6e4 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -18,7 +18,7 @@ CFLAGS+=-Wl,--build-id=none -x assembler-with-cpp
 LDFLAGS+=-nostdlib -N -static
 
 %: %.S %.ld
-	$(CC) $(CFLAGS) $(ASFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
+	$(CC) $(CFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
 
 # Specific Test Rules
 
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 0a4364868c..cee342017e 100644
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
index 3ed8077d0f..c821d2806a 100644
--- a/tests/tcg/minilib/Makefile.target
+++ b/tests/tcg/minilib/Makefile.target
@@ -18,4 +18,4 @@ MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
 .PRECIOUS: $(MINILIB_OBJS)
 
 %.o: $(SYSTEM_MINILIB_SRC)/%.c
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
index 8212d96b81..9530cac2ad 100644
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
2.21.0



