Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC964C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E93F2086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leTqu8/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E93F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39452 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQPup-00059Z-IS
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 01:23:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQPty-0004qr-Gc
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQPtx-0004gS-CO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:22:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:45078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxP-0003Sy-Pj
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id a5so7254651pls.12
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=oB7VP5ATUZChOLMjOlpdWPN1IctJhwYBQQIlaCDVjkw=;
	b=leTqu8/DI8MzpUWoAYnCi1Qr4rR0BtDqbXChthla/WcLLjap3YjbdF7QbYqfwoH8mf
	OCpU21DvuZ4xwPpdaQ/828EJApuw5wCc24hYWqBVyGt7CzTIs1j+aexFQw1mi7zSzrrJ
	WrkBSpMNrEtXHbKRVwZvxHJ/QpvKSJazzGrMd9yTHNUQMaA6e+5oc1/3C63NaGY99z6s
	Gy1zHDznTt+2ZUwE6s047lMidadP5Ub1DEMwK/hFLfzmXIk14YEYhRlXTtHXqVsh6lML
	gBKZjeEIfbL4tc3yiwk6WiSJtcqkJShKrdLrwa2giPTtetY6W8S4DAfowveoF3cjXMZV
	U+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=oB7VP5ATUZChOLMjOlpdWPN1IctJhwYBQQIlaCDVjkw=;
	b=LmNfyC63gaR117mb/xxd1goLICmA92PJE/zLK+/Oo9hqir8nRjq3oL9gp4XFeQl0u/
	GGm/jAwIcRPIu5eB4wfdmEhwnTZ9C6gXlIkHiJEuerdLMWsBxxYCrS5+HX8vwbJ89t55
	5/2uGYLEvew2Ly+itK+KO7y9fZB76zrmk7BSptfRorMQyyEiIcbLrxmSrw6WDOl6w/Lj
	iCn/F8mUw4TpYLGK2uElCHZSDPEh/T4vHQ83vuYb3SQNORiZH7ua9lgbXa4/gpRxxyXF
	8+9TxLnOQ4tNRa5kWD0PnfhaJPKYLHDDwmagKjhddJH4D49OP+cqjQmxrl9xPw2S5o6Y
	4vgg==
X-Gm-Message-State: APjAAAUPxFz/G+80Q8T4uZwu1IpzSe4+RI7bOhe57a+6ProCuA6gkRWb
	ZLdwBk1orz1wFPRdju1dU3pmip0iqak=
X-Google-Smtp-Source: APXvYqwDQhebWUDaVLM/bY2S9m8bNX2yc9Lj/TMZ5v9ekYGQuugEPq6EKvE9zy/bYNE0MEfenAzV7w==
X-Received: by 2002:a17:902:e785:: with SMTP id
	cp5mr15743115plb.167.1557792369502; 
	Mon, 13 May 2019 17:06:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:29 -0700
Message-Id: <20190514000540.4313-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PULL 20/31] tcg: Add support for integer absolute
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


