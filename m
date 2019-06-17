Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8DDC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3895A20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqfnA1wX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3895A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctZ8-0006YV-Av
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46710)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiM-0003d9-5A
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiK-000865-Du
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiK-00085b-4S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so10238944wrs.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fkduvo7H+Mb+0yWACJmN2aG39JYYGYZGB+AH2iBoI9s=;
 b=gqfnA1wXEwHvrRazD9KQ+9to4Wm6zrRNiXhrC/Jz2WMevG04QlXivMnJAkGRtjfMte
 s8VkQWs4Ufc6zMD7fp5YkVWsEwHIklNlf/3NZR+05EtAVqagcrFC6SypfbnL4JZu6VVj
 QOLAWdXCWDNWEirTd71JjHDEI3D/DG0UdUT2SliiJLNaLPEB+vdOZoBZMmyVnj4ktS25
 t/TH2JvJFekO229GmE9ecFF7eHavF+EIjTKvTyI8P1v9BPoj/hSuunE1I6aOBULZ3XO8
 oLBb6dIZOuiiUHvk37Ty+JyLW2KMWd1p+QLYkLvbWLoaA/1gvaKn0a8V6uaD1sTZ5mOF
 zrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fkduvo7H+Mb+0yWACJmN2aG39JYYGYZGB+AH2iBoI9s=;
 b=NfAEP8J9m0WmPGW0OjpLkLvEheiwFRQDJoy7HYSpSom1onOgH2Liu3qD1ph69qD4Qf
 50HaUCfaPwTJfr0z61AZnsn5G+bm2RY03F3hKPX/J5cpWHlt8d/D+B32Xnn3jGtHKnKT
 nJ8Ag+tPJ0BVr2UpUBL+bDfJqRz0JaGoEy0FYZQC/MaA/bwGh4b71Z6ue5M7qxQnTcam
 2Ad0XbAtAp8QaMaDLqdM5mRgt/GYHw5JQcxJDtBvD56v3i92P5qe/3sl7lncBWrD9UCa
 gCuFHhgIQfpa3BU8Zsrwf6hrO4S/oyWudVYqshKFol0CgLccekqpfH9mChoHrjues5Cb
 4Ldw==
X-Gm-Message-State: APjAAAUDpxFV8wNyrskHbATjXPwUzahh8fhYmYTMiTEzIasKUxziu5Y8
 85pT/0pcGCOYAUD1x5nxIfrn22ReSuFQqQ==
X-Google-Smtp-Source: APXvYqwMOpvEDHH6NLptifP9lffWHQw1boz2qI1ut98LBa+/mZ1bkRo83Zh0YFKAh48qXfmiVLAyUw==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr55508121wrw.345.1560782067009; 
 Mon, 17 Jun 2019 07:34:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:59 +0100
Message-Id: <20190617143412.5734-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 11/24] target/arm: Move vfp_expand_imm() to
 translate.[ch]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to use vfp_expand_imm() in the AArch32 VFP decode;
move it from the a64-only header/source file to the
AArch32 one (which is always compiled even for AArch64).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-2-peter.maydell@linaro.org
---
 target/arm/translate-a64.h     |  1 -
 target/arm/translate.h         |  7 +++++++
 target/arm/translate-a64.c     | 32 --------------------------------
 target/arm/translate-vfp.inc.c | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 9569bc5963d..9ab40872d85 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -39,7 +39,6 @@ void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v);
 TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
-uint64_t vfp_expand_imm(int size, uint8_t imm8);
 bool sve_access_check(DisasContext *s);
 
 /* We should have at some point before trying to access an FP register
diff --git a/target/arm/translate.h b/target/arm/translate.h
index dc06dce7675..bc1617809da 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -237,6 +237,13 @@ static inline void gen_ss_advance(DisasContext *s)
     }
 }
 
+/*
+ * Given a VFP floating point constant encoded into an 8 bit immediate in an
+ * instruction, expand it to the actual constant value of the specified
+ * size, as per the VFPExpandImm() pseudocode in the Arm ARM.
+ */
+uint64_t vfp_expand_imm(int size, uint8_t imm8);
+
 /* Vector operations shared between ARM and AArch64.  */
 extern const GVecGen3 mla_op[4];
 extern const GVecGen3 mls_op[4];
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ae739f65756..97f4164fbbc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6380,38 +6380,6 @@ static void disas_fp_3src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* The imm8 encodes the sign bit, enough bits to represent an exponent in
- * the range 01....1xx to 10....0xx, and the most significant 4 bits of
- * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
- */
-uint64_t vfp_expand_imm(int size, uint8_t imm8)
-{
-    uint64_t imm;
-
-    switch (size) {
-    case MO_64:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
-            extract32(imm8, 0, 6);
-        imm <<= 48;
-        break;
-    case MO_32:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
-            (extract32(imm8, 0, 6) << 3);
-        imm <<= 16;
-        break;
-    case MO_16:
-        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
-            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
-            (extract32(imm8, 0, 6) << 6);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    return imm;
-}
-
 /* Floating point immediate
  *   31  30  29 28       24 23  22  21 20        13 12   10 9    5 4    0
  * +---+---+---+-----------+------+---+------------+-------+------+------+
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 709fc65374d..a66084f6e36 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -30,6 +30,39 @@
 #include "decode-vfp.inc.c"
 #include "decode-vfp-uncond.inc.c"
 
+/*
+ * The imm8 encodes the sign bit, enough bits to represent an exponent in
+ * the range 01....1xx to 10....0xx, and the most significant 4 bits of
+ * the mantissa; see VFPExpandImm() in the v8 ARM ARM.
+ */
+uint64_t vfp_expand_imm(int size, uint8_t imm8)
+{
+    uint64_t imm;
+
+    switch (size) {
+    case MO_64:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3fc0 : 0x4000) |
+            extract32(imm8, 0, 6);
+        imm <<= 48;
+        break;
+    case MO_32:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3e00 : 0x4000) |
+            (extract32(imm8, 0, 6) << 3);
+        imm <<= 16;
+        break;
+    case MO_16:
+        imm = (extract32(imm8, 7, 1) ? 0x8000 : 0) |
+            (extract32(imm8, 6, 1) ? 0x3000 : 0x4000) |
+            (extract32(imm8, 0, 6) << 6);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return imm;
+}
+
 /*
  * Return the offset of a 16-bit half of the specified VFP single-precision
  * register. If top is true, returns the top 16 bits; otherwise the bottom
-- 
2.20.1


