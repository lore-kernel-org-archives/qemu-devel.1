Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06491C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C684920644
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfs7P+1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C684920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTuhe-0004Bu-Va
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:52:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZz-0006CM-4A
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZt-0003CZ-Gv
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:45 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:39385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZr-00038v-LC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:41 -0400
Received: by mail-yw1-xc43.google.com with SMTP id w21so2786526ywd.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Wv0YAF1rZ6KrPU3tosAjlI/qAdfuoWauzAhliLX3BEs=;
	b=Sfs7P+1AxsKND4DQAlJwytdjXiqMzxGbiZcmdLnpm+Haqzc4uKX6sB5lerTw8VL0mR
	QiGXg8k/X6zsWUQs+8fHu8ohQcKRZqWd0lFzWl2kmKjJVJUSW4+T1eAXiQOjxznXlpc5
	QwQM1BcUmTvqyr3mJ4EtBbtBb+G+2KajREVH+WtbXBHKHTCm4frcFNsUjgrkqiq8h5zE
	4kiTSEl1UvgZF05MUpEDLJ3vGfBQNOBopxqJWH/Ng51TXSQdOi3ZSW1MadZABH6puxCV
	5dERXMooTC7QhcXdbXqj2WVncA5VkCNOT3d38Pv8NZYRPKl3xgM/l1ve8Nive41q2tVf
	7REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Wv0YAF1rZ6KrPU3tosAjlI/qAdfuoWauzAhliLX3BEs=;
	b=AGMV6TarX10v3sUZBgsGj0zvKfPTavzr1aTZnKkDc8RKDLiYgZFEG6vkpNCmArsikt
	l2RvEi2c7+KjsAPdNQeEuLvcdak2d3apjELKYX/6Qoj2h+76Nh0BN7hQYDv0J8feTFc8
	vXIDXY4tHALrRRTIuuLKlNoeZTZDKpuJfxFU4HEHtsKVjZ1m2E09LWMOr+kvMX34Wqnt
	5ESZsFJenTFEXjy1a9R+WR6aOQHkrmabuPXo37ZATJUXTL79MIUVplMfv+eXm5QqbYl9
	wyrdF/ynf6qEdXxl+t9725DbAd8Jn3DKZGwJGLt5xz/LPwFHUUffj0X6UIKxNjxcXsEQ
	QZcA==
X-Gm-Message-State: APjAAAXYkgbsw4nBqrWjjV9Uc+BdAkE/MT/Qx8sdE1luxPv5kqehDImD
	jJGPjhqN1I8N5Artrorm+JCCio16
X-Google-Smtp-Source: APXvYqxVah+fMA7SaNhiHbvkHANBwiv0gcpjsAkLQsS6K/fWvYhk7U3wUwA0f+vQP+qr7lpPuVFK5Q==
X-Received: by 2002:a81:b3c4:: with SMTP id
	r187mr19261194ywh.217.1558644278092; 
	Thu, 23 May 2019 13:44:38 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:37 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:05 -0400
Message-Id: <20190523204409.21068-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RISU v3 07/11] test_i386: change syntax from nasm to
 gas
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to drop dependency on NASM and build the test image
with GCC only. Adds support for x86_64, too.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 Makefile    |  3 +++
 test_i386.S | 41 +++++++++++++++++++++++++++++++++++++++++
 test_i386.s | 27 ---------------------------
 3 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 test_i386.S
 delete mode 100644 test_i386.s

diff --git a/Makefile b/Makefile
index b362dbe..6ab014a 100644
--- a/Makefile
+++ b/Makefile
@@ -49,6 +49,9 @@ $(PROG): $(OBJS)
 %_$(ARCH).elf: %_$(ARCH).s
 	$(AS) -o $@ $<
 
+%_$(ARCH).elf: %_$(ARCH).S
+	$(CC) $(CPPFLAGS) -o $@ -c $<
+
 clean:
 	rm -f $(PROG) $(OBJS) $(BINS)
 
diff --git a/test_i386.S b/test_i386.S
new file mode 100644
index 0000000..456b99c
--- /dev/null
+++ b/test_i386.S
@@ -0,0 +1,41 @@
+/*#############################################################################
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ *###########################################################################*/
+
+/* A trivial test image for x86 */
+
+/* Initialise the registers to avoid spurious mismatches */
+	xor	%eax, %eax
+	sahf				/* init eflags */
+
+	mov	$0x12345678, %eax
+	mov	$0x9abcdef0, %ebx
+	mov	$0x97361234, %ecx
+	mov	$0x84310284, %edx
+	mov	$0x83624173, %edi
+	mov	$0xfaebfaeb, %esi
+	mov	$0x84610123, %ebp
+
+#ifdef __x86_64__
+	movq	$0x123456789abcdef0, %r8
+	movq	$0xaaaabbbbccccdddd, %r9
+	movq	$0x1010101010101010, %r10
+	movq	$0x1111111111111111, %r11
+	movq	$0x1212121212121212, %r12
+	movq	$0x1313131313131313, %r13
+	movq	$0x1414141414141414, %r14
+	movq	$0x1515151515151515, %r15
+#endif
+
+/* do compare */
+	ud1	%eax, %eax
+
+/* exit test */
+	ud1	%ecx, %eax
diff --git a/test_i386.s b/test_i386.s
deleted file mode 100644
index a2140a0..0000000
--- a/test_i386.s
+++ /dev/null
@@ -1,27 +0,0 @@
-;###############################################################################
-;# Copyright (c) 2010 Linaro Limited
-;# All rights reserved. This program and the accompanying materials
-;# are made available under the terms of the Eclipse Public License v1.0
-;# which accompanies this distribution, and is available at
-;# http://www.eclipse.org/legal/epl-v10.html
-;#
-;# Contributors:
-;#     Peter Maydell (Linaro) - initial implementation
-;###############################################################################
-
-; A trivial test image for x86
-
-BITS 32
-; Initialise the registers to avoid spurious mismatches
-mov eax, 0x12345678
-mov ebx, 0x9abcdef0
-mov ecx, 0x97361234
-mov edx, 0x84310284
-mov edi, 0x83624173
-mov esi, 0xfaebfaeb
-mov ebp, 0x84610123
-; UD1 : do compare
-UD1
-
-; UD2 : exit test
-UD2
-- 
2.20.1


