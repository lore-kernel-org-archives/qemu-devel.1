Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D26C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221A02133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rb6LZ3/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221A02133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToJk-0007Z4-Aa
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:03:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHY-0006F5-UO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHX-0004U3-O2
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:20 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:37945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHX-0004Td-J5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:19 -0400
Received: by mail-vs1-xe41.google.com with SMTP id x184so3644978vsb.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1XbDcSxPxIwShmL7ibaMkqeCI/KNLPvufrTgWj8SAo0=;
	b=Rb6LZ3/InjNx0VUBhtU+aR5muID1Z76HVg+NbdhXgvskYPIoA+uVZsXH/GtDnx0c7R
	YqVWRvE3Yvv4S4YoHKMZzvfyGfHGpWdAQAb+w0RQIaH7M/1G+z6pCGzFYu0XgbwSawAj
	QwTr2/IcCLCWSMniu3Z6dPXvJYqAN+kilgo5RrouMGJugTfdxiF9P5MNmxOnn48wbDW4
	tgMf7hgdNT3rrmfOOQ3STkPWoTK7fKPVZJG06s1TMhPnQBqIRyCO+fWhcnjBBpNW5JoD
	X5Xvu2hjptqY+0rGQqyMJXWA8vicTRkIqQZRPyRw0pi44TMyW37CpyQRNtKe015piVw0
	CX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1XbDcSxPxIwShmL7ibaMkqeCI/KNLPvufrTgWj8SAo0=;
	b=BuxZkPI83oole06xLz/Jd3g0hDA5hEksmHngbW8vyIXFeNddXm6qDY9euwqVMOIZra
	aaPwIM1xWe8AEbcBrmAXprC+8c/3ufzDs1iAGB5IizfLExsVQujnx97oYwZ2Y8e8TOfp
	bpnubV5rRqKwSvyYpArreITk/GTWW4w14Pug2RrtTwSFXVBaD/IPBqLbxmVNBn0ZRhUx
	lWNGpNHYlFh4E8IhJvklWLOmmnLkSyUT+NBs37S3YT3r+nnZxQjYuNsRreiXmRXtL/xR
	jdArso2xphbq/qly8FRa/B/5QYLNQfgCRZySEVhs6IVo9CQzpcZB2x+ZTTCGi0J5urfI
	NGMw==
X-Gm-Message-State: APjAAAULbvpIlgKt89ROI/zW04BXTetKNtnteViGsOz7kYU1gE+5Rw1m
	C4eXaxSTmnCC14DMDxG/rrWYlU/NM/drvw==
X-Google-Smtp-Source: APXvYqy3SlbtmIwNT657LTANzCRacnbSC93jFYbL1KIZWLfHJr3huFwW5fB6D3KmS8Ahd4FLWcBqKA==
X-Received: by 2002:a67:f610:: with SMTP id k16mr40647114vso.85.1558620078507; 
	Thu, 23 May 2019 07:01:18 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.17
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:56 -0400
Message-Id: <20190523140059.18548-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
References: <20190523140059.18548-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e41
Subject: [Qemu-devel] [PULL 10/13] hw/registerfields.h: Add 8bit and 16bit
 register macros
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
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>
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


