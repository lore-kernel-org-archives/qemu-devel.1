Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCF3269DD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjtHXRHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCF3269DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi0n-0008M4-TJ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:56:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhon-0007Tn-F3
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhom-0000L2-7y
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:37 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhom-0000JW-1z
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:36 -0400
Received: by mail-ot1-x343.google.com with SMTP id r10so9216927otd.4
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1XbDcSxPxIwShmL7ibaMkqeCI/KNLPvufrTgWj8SAo0=;
	b=DjtHXRHxrYfFzwevW4bKlMnGwULoonBQA7Vt6JPJzAc07Xy8fZ8YG0lT3EqL9cpDHn
	ZWQ5xV5RBPLTyuuN0buX9LQhI2QwVFkFxXFy59neaUwaqIn+f9QJxfdQwtnlUf2WPcfh
	/JrgqHhg4tgBhIpcGb5YsPDw0aUZ/3+CbgVNbgYDGu4OVVSBjZARvzD7Ss8V0a0hFObC
	Ljh2HBA0HbPZDe9TvSHZw/QJaBXBZmuB2V0U4Ir7dGzJ3BLiqaqg8HDDPNM3AynCr1kF
	FZkie+4SqFROIUFSn8qNZ8+NyAmTrLdH+R6YMtAUpa8IJCnTp8WODNVXvZgEs6Tqy3T7
	LsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1XbDcSxPxIwShmL7ibaMkqeCI/KNLPvufrTgWj8SAo0=;
	b=aPO3SCStj+GC2yCqSmMNJh3L/3cDowst7wZeYFKqhh4A1oBGYl+hPMhhKNTWzBoLGM
	W7LWWz8ZZnj8Hsm/wzqArrwRHqgigmhjy+xGHHMIJUHomTj9bBfk2xjV2XOpyLFhA6da
	62sKVAjyWoKfmtWpRg+82Rq42X/7DjybxpBHdu+mlM8UB3Zy0FEttGxgVuwXlwN5HFq+
	gWbz+GU9QNtl+ujDjhusyRce7J5rvgeR3kxa+dEmYMoxZBPHP3VEpnderRQkSBIpqBsQ
	4amsTjK7Cfyeq801cf+pi8FtQepXVPB9HP1PwywtIQH3opsvJweWasZAX5gUm4lqSt/o
	SMcQ==
X-Gm-Message-State: APjAAAXa20v3znTr3fq5gIBCyBH+KdW4CUDktbB0yg5Fd6Rxxvrd74wP
	Z/Eo1m90+F7BaYYSoqLXv3GgaaVYqZAn+w==
X-Google-Smtp-Source: APXvYqwqaaiFDBOXi1COP9v1gkAfA6VrZWmI/djIrASB0I+0p8WV3556C7KNnIjC0b5xQqQmLw3BIg==
X-Received: by 2002:a9d:6e0f:: with SMTP id e15mr2024004otr.0.1559310215125;
	Fri, 31 May 2019 06:43:35 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:02 -0500
Message-Id: <20190531134315.4109-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH v16 10/23] hw/registerfields.h: Add 8bit and
 16bit register macros
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Some RX peripheral using 8bit and 16bit registers.
Added 8bit and 16bit APIs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190516055244.95559-11-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 2659a58737..a0bb0654d6 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -22,6 +22,14 @@
     enum { A_ ## reg = (addr) };                                          \
     enum { R_ ## reg = (addr) / 4 };
 
+#define REG8(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) };
+
+#define REG16(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) / 2 };
+
 /* Define SHIFT, LENGTH and MASK constants for a field within a register */
 
 /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
@@ -34,6 +42,12 @@
                                         MAKE_64BIT_MASK(shift, length)};
 
 /* Extract a field from a register */
+#define FIELD_EX8(storage, reg, field)                                    \
+    extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,                \
+              R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX16(storage, reg, field)                                   \
+    extract16((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
+              R_ ## reg ## _ ## field ## _LENGTH)
 #define FIELD_EX32(storage, reg, field)                                   \
     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)
@@ -49,6 +63,22 @@
  * Assigning values larger then the target field will result in
  * compilation warnings.
  */
+#define FIELD_DP8(storage, reg, field, val) ({                            \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint8_t d;                                                            \
+    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
+#define FIELD_DP16(storage, reg, field, val) ({                           \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint16_t d;                                                           \
+    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
 #define FIELD_DP32(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
@@ -57,7 +87,7 @@
     d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
                   R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
     d; })
-#define FIELD_DP64(storage, reg, field, val) ({                           \
+#define FIELD_DP64(storage, reg, field, val) ({                         \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
     } v = { .v = val };                                                   \
-- 
2.17.1


