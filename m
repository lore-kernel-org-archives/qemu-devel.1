Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E9CC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1407A206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZN3z0+Wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1407A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnxX-0002Bx-9X
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:15:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc0-0007xE-GY
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbz-0004No-B4
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbz-0004NO-55
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id h1so3773762pgs.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oB7VP5ATUZChOLMjOlpdWPN1IctJhwYBQQIlaCDVjkw=;
	b=ZN3z0+Wx4Ckd7Bz+92mm0xR6ZEmC12+z4/YNmrctazoL3a90rBrP0Cd+qNl3CRl0bA
	FAeg9xS0Atv0zhsd4R4Yd8gEhbZt6qykz5yObK6GlhzpbCtN5cxZ2OishmX5UDGlm2CP
	d/eYVi1rbbTfaZ0l750kF/okdLqJjZflNUaikeXv6pRHLmgO9/RKffgZOqi2SJoVGPi2
	E5UDwmVhoLPthGkgAT0h+xy2ybEY17/pSqPa+ajSaoAQiZQHgd9k8RlhrnEKDU7tx+zU
	GFjxGxOLj0MWRcKZg0Jfamkr0ls8u8FfiFu5Ygc4DnmM6WyJ2myDULzsBNjIO86Tx0HV
	951Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oB7VP5ATUZChOLMjOlpdWPN1IctJhwYBQQIlaCDVjkw=;
	b=Nf8lQiL2umXwyDCgT+TRtEdV/qPGQxxMrR4AVHdFNhrTIsC38i2Y3unK66qtWUKH4S
	z6GKlqO6TuRrzOc04x5TELYldpCM8Mn6EVy6xBgNo3fXAooI1VSTvpF5ohUGVwXuyrkq
	fIOIyRRNcUkbEdnCZGA/t3hDK0RUgL0LUNo9SJKv9u/WZXwCqVsNgbjiioCPw1A1FIRz
	k9A1H4JVFSrrXEUI5vr8zirMr7Fuv/nCIodiQfS+k56lqKvwUz24sOyU+MYNadkFlPpp
	4mw63OZI7+yYyY5TQZ87n9R64H04hZcPwAHhbXIYBxktw8GT9tAMeZKhoIXRKZhv7dM7
	RZXg==
X-Gm-Message-State: APjAAAXo9XSGbQKTNQpHamhcl7VNvfuM5YIcGF+nd20VErhEmFY9cfUE
	/5m/8r5k02F1M9iIDAX8yWta/QL3i7g=
X-Google-Smtp-Source: APXvYqzWLetqo1I/alzsuBBa8zDNfOUEAf2LbjwEvVKFnP5kg/QG1eIFdcLIPfW/khiNpRq5D55GYQ==
X-Received: by 2002:a63:d016:: with SMTP id z22mr16343866pgf.116.1556949205972;
	Fri, 03 May 2019 22:53:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:49 -0700
Message-Id: <20190504055300.18426-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 20/31] tcg: Add support for integer absolute
 value
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055249.DDf1mBPj0yip9KnSrOykD8LKgez0RqA804w169YeeYk@z>

Remove a function of the same name from target/arm/.
Use a branchless implementation of abs gleaned from gcc.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h           |  5 +++++
 target/arm/translate.c | 10 ----------
 tcg/tcg-op.c           | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 472b73cb38..660fe205d0 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -335,6 +335,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 
 static inline void tcg_gen_discard_i32(TCGv_i32 arg)
 {
@@ -534,6 +535,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 
 #if TCG_TARGET_REG_BITS == 64
 static inline void tcg_gen_discard_i64(TCGv_i64 arg)
@@ -973,6 +975,7 @@ void tcg_gen_nor_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_eqv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
 void tcg_gen_ssadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_usadd_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sssub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
@@ -1019,6 +1022,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_addi_tl tcg_gen_addi_i64
 #define tcg_gen_sub_tl tcg_gen_sub_i64
 #define tcg_gen_neg_tl tcg_gen_neg_i64
+#define tcg_gen_abs_tl tcg_gen_abs_i64
 #define tcg_gen_subfi_tl tcg_gen_subfi_i64
 #define tcg_gen_subi_tl tcg_gen_subi_i64
 #define tcg_gen_and_tl tcg_gen_and_i64
@@ -1131,6 +1135,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_addi_tl tcg_gen_addi_i32
 #define tcg_gen_sub_tl tcg_gen_sub_i32
 #define tcg_gen_neg_tl tcg_gen_neg_i32
+#define tcg_gen_abs_tl tcg_gen_abs_i32
 #define tcg_gen_subfi_tl tcg_gen_subfi_i32
 #define tcg_gen_subi_tl tcg_gen_subi_i32
 #define tcg_gen_and_tl tcg_gen_and_i32
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 35bd426a3d..b25781554f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -604,16 +604,6 @@ static void gen_sar(TCGv_i32 dest, TCGv_i32 t0, TCGv_i32 t1)
     tcg_temp_free_i32(tmp1);
 }
 
-static void tcg_gen_abs_i32(TCGv_i32 dest, TCGv_i32 src)
-{
-    TCGv_i32 c0 = tcg_const_i32(0);
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_neg_i32(tmp, src);
-    tcg_gen_movcond_i32(TCG_COND_GT, dest, src, c0, src, tmp);
-    tcg_temp_free_i32(c0);
-    tcg_temp_free_i32(tmp);
-}
-
 static void shifter_out_im(TCGv_i32 var, int shift)
 {
     if (shift == 0) {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a00d1df37e..0ac291f1c4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1091,6 +1091,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_sari_i32(t, a, 31);
+    tcg_gen_xor_i32(ret, a, t);
+    tcg_gen_sub_i32(ret, ret, t);
+    tcg_temp_free_i32(t);
+}
+
 /* 64-bit ops */
 
 #if TCG_TARGET_REG_BITS == 32
@@ -2548,6 +2558,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
 }
 
+void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_sari_i64(t, a, 63);
+    tcg_gen_xor_i64(ret, a, t);
+    tcg_gen_sub_i64(ret, ret, t);
+    tcg_temp_free_i64(t);
+}
+
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.17.1


