Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6945C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B182089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxbC8y+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B182089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRPD-0006G7-Px
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37246)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROH-0004uH-Nj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hsROG-0006fx-Af
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hsROG-0006fF-4P
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:38:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id x1so15695257wrr.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+0lmLbpK31lpr1scwil4wDPUGBPfI3X3nakGAquegRQ=;
 b=KxbC8y+WdU2D5v13TlP4vcC2TQyjL9YI2v06Xv2jfVy0IYwRaIo2x1NltJCnwtIW+5
 F6yqlK0DYYrFeHzd/cYR5n2VKe24Ep4oqcX+2jn8ynl8bG5cTgCQbYVepaO4v7lCgN+o
 77s69afHsBhKU8QMwp6talYyAX6PY9DJpKsVTPcYcimJmk7Jr6QP5F569vQTwHIXw5rS
 QxR7mX3H+uZ8iU3Wh7gUsV/4O87I9qYlZpWLBHkaJ7nJBG+FGkGWS3gela4fqLUXjK6q
 RlfbxbhVYKo4h4ySvIcruM+pDoBWDZfkQ1xn0jTJby3RG6JL2d7ZEq+y3xGT4y7jk0IQ
 i8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+0lmLbpK31lpr1scwil4wDPUGBPfI3X3nakGAquegRQ=;
 b=TbosmHY49cY70TNcEnQvA+BZsqUFrWO7G2p1JJPdwPkeUM/Z4+WI0bfGacTVba4ZDs
 K0vioR5DauOwXlFm9w17DHaM8VfzLnNGN1juFG/Ghily+YJCzoVi/71ZJwqg580+Ej5W
 w4zdfP9jYlOA4grFvVTnED9TSeE+QQVcUdHNH17l02qP4Yx9OgZmTHe4FZu1rbd0RfrJ
 d8jjCHgPLdQ0mBrHnmO40O752PYtEEE9zT0VXA8cQfYCF47uDjIvYnSEeWc9vh6v3V5+
 D1sfaTf7fby8NuoctlTrT9lwh3dj3wsRZNCIlzgNRVr2IfUbPGluLtqb70/5Wv6Qlx5+
 +yKw==
X-Gm-Message-State: APjAAAU8d+HIotv48YzWHHPUUbkDD49iuDNWrtLF2z0YWX9oaEwz9g9c
 2NPvJloXGpC2OOvcHz8AXdGsEhrT/5c=
X-Google-Smtp-Source: APXvYqxdw9pZ5Imy0Z/aYrgGPRscndouqFLf+vRj7EPtVl/+DjBEIGXmTb5fT1MgfMGqVUddPGQy6Q==
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr9869775wrx.17.1564490282649; 
 Tue, 30 Jul 2019 05:38:02 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id
 j6sm90847995wrx.46.2019.07.30.05.38.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 05:38:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 14:37:57 +0200
Message-Id: <20190730123759.21723-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730123759.21723-1-pbonzini@redhat.com>
References: <20190730123759.21723-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PATCH 1/3] tests/tcg: use EXTRA_CFLAGS everywhere
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
index 2e560e4..4c4aaf6 100644
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
index 3c0f34c..09193a6 100644
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
index 49d48d8..2deb06e 100644
--- a/tests/tcg/arm/Makefile.softmmu-target
+++ b/tests/tcg/arm/Makefile.softmmu-target
@@ -18,7 +18,7 @@ CFLAGS+=-Wl,--build-id=none -x assembler-with-cpp
 LDFLAGS+=-nostdlib -N -static
 
 %: %.S %.ld
-	$(CC) $(CFLAGS) $(ASFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
+	$(CC) $(CFLAGS) $(ASFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
 
 # Specific Test Rules
 
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index 0a43648..cee3420 100644
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
index 3ed8077..c821d28 100644
--- a/tests/tcg/minilib/Makefile.target
+++ b/tests/tcg/minilib/Makefile.target
@@ -18,4 +18,4 @@ MINILIB_INC=-isystem $(SYSTEM_MINILIB_SRC)
 .PRECIOUS: $(MINILIB_OBJS)
 
 %.o: $(SYSTEM_MINILIB_SRC)/%.c
-	$(CC) $(CFLAGS) -c $< -o $@
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -c $< -o $@
diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa/Makefile.softmmu-target
index 8212d96..9530cac 100644
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
1.8.3.1



