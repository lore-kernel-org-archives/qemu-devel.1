Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B193C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79DA205C9
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHGqsA5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79DA205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTPf-0004k0-Gz
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJS-00080X-IB
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJQ-0002PC-8o
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:18 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJQ-0002Kq-1m
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id m3so15099505wmi.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ug14YFPy3179DBpFnitGGwEDkAdMlyFwdmS9EGL4AQg=;
 b=XHGqsA5qLxdUqxvyz+n/3JXyJX5jy+N19EchYEolGeKmObYE4rYCNVwwUG4ag7up5x
 ZUcbEgWajDDldjSdPkukjtnvHtHRSDnWp2rPkbaycFLEqJbpF79rG6M+YROA/hLqg5Tk
 xaqkfpyef3lcBRLTRevclCYuLJRK8Ab+w8G4ABRqyhP0UvcMc00hoiMlv2An3g8QKOgr
 py1JaR5a4mj+UmCp8gm5l0Kqafy+ihS5COW5xH6mou0PdugV2tWCmI85jYdVVUOq0DX9
 i8gMJEJisZ/qun4bvLXMOr3GmiGJfR6a72gIFXGzjUs/pTcbMwTEM1u70XI91h3ORvYs
 XDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Ug14YFPy3179DBpFnitGGwEDkAdMlyFwdmS9EGL4AQg=;
 b=s4Oty4ImfW3P4iMNIcSwAQpywDeVEA+gRRcti7sG/Qcqwz8odDzSyWHCPik4cK+ODt
 /kQ1Wsl9VrjkVBGCuxXEWgKyfrxSojflWizK63EybObAqEn4AYHAUt2uhxRXb9enH0UF
 563Unkp660SrHmEYLmQNGgSQfN11g2+I/FRlGgBa8+Dy/AJdcLjTB+Ct7SgE0+iaG+1j
 nCj95FKEo623R+MpF/r7aAfkAOuflGozKxv+YTqkf4OgazR9vRCSn65nE5q49OSD9WhC
 25nfrT5hVspn5ZZq17JsXOV2nhuEmjh3aGuWURNZWpcyab6HJgbiz3dFM0fVu+1SzUGU
 3l7Q==
X-Gm-Message-State: ANhLgQ3VJlO7gnv6srHKV9wl7JJcIhgtXZYo4taJjGWy+PVOtlZbGd10
 OnsvC8KbFHozKalJvyKvoSEh+z4N
X-Google-Smtp-Source: ADFU+vuZ1io9VatcbAukfLLY6weTBd5fDEpIlefL5cx+rrStmW7RMgAUobdnXahyIO+9MATGMI5JoA==
X-Received: by 2002:a7b:c10c:: with SMTP id w12mr19670573wmi.162.1584278894748; 
 Sun, 15 Mar 2020 06:28:14 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/13] hw/registerfields.h: Add 8bit and 16bit register macros
Date: Sun, 15 Mar 2020 14:27:57 +0100
Message-Id: <20200315132810.7022-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Some RX peripheral using 8bit and 16bit registers.
Added 8bit and 16bit APIs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-4-ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
2.21.1


