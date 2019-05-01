Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C4C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B6220866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0mCOOGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36387 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLheJ-0000ht-PM
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:19:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRf-0006de-1s
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRb-00030j-Cz
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:14 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRZ-0002xi-Bc
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id j26so7869534pgl.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=yFRiQL+bz58cWGz6Ig2AM72yMnp/aPGg7D5yMyvGces=;
	b=b0mCOOGoVldLR9CZSwIEn9gACKL8H8NKGSMp0Qijtww4FOFR1XWnobJGn5tHM/YwbT
	kGnQ32Hzb5wXRyVffiQIE2jvZuenjyGjKsWHDt43SaqpthiAl2xgqx2UYkET7FUygtgS
	3kK2DM1mCnDe8THYeRJ/k0mTBDP647lM4FKKKuuXeHvND6IIPEBd34eel+9ho5FCa1yN
	NvYAO4cj2TcVi68tKvmnheWiTYRgnr6HZeT6pvBuSjylPGjunUlLvOTrfeqeeB1Ah2xQ
	FwypiQqrFNavZ1zvIhlmbEGP8I7Sdm2FVXMT5t5Eup6gUOxV+p8LWe+WM1Z8Zx2G1850
	s9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yFRiQL+bz58cWGz6Ig2AM72yMnp/aPGg7D5yMyvGces=;
	b=HEJqwLsN8JZRI9Aq6F0WnnyhR8whpO79KGRwS5PzBLQx8OzRlYa/MKTve1p7lYVaZP
	1N/COitZRbUa+eYmoG9DJmoq78/ZBmwCxJIsYovw9PPfHP+BJAUvmttieYKjKdKaSlVt
	LQydPyorJFiW6NikiYs2eXv6ZyP+1RyDkr3jz9Jj41GtRReeFpzW+mLGDNbcmnEbHMWM
	x5oOZpY8RA3NpGHtfOUBrCQo4g2Cg7V2H7fF5/58qn17GqGxLWhCWFZFo76PZU0FwY+W
	cjSaLeQtL8j/OQoBA6grWWH3lLUBYAk8DAZLtqZUd71btaVeN2uX1DElyX9nw2356r7c
	w+eQ==
X-Gm-Message-State: APjAAAW2Zmi1AN0ZoGhmZgKhOzJjEf9mAs0pNDcY3/QwEwOgk4qngWix
	101GhX8hEX4SPwQd/EkW0l4HKPExn+g=
X-Google-Smtp-Source: APXvYqxUbwNToGetE7dQtsslaz7LP9Wad33eywDVh/BjBRWizR5ZrrSHl9L9rLId33ADIBPuKLVEwQ==
X-Received: by 2002:a63:4f1c:: with SMTP id d28mr70620861pgb.144.1556687166937;
	Tue, 30 Apr 2019 22:06:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.05 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:26 -0700
Message-Id: <20190501050536.15580-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 19/29] tcg: Add support for integer absolute
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501050526.3fnxxgaW4Hq020Z8qegpxtHj3PNRlk9vi8CloMmLZis@z>

Remove a function of the same name from target/arm/.
Use a branchless implementation of abs gleaned from gcc.

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


