Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C7C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD58206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+e2eqhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD58206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMo1s-0005MF-W2
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:20:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncB-0008AS-Up
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncA-0004fT-NT
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:39 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:35225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMncA-0004eD-HR
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:38 -0400
Received: by mail-pg1-x535.google.com with SMTP id h1so3773918pgs.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NPRvgVGg8Y/3Ni/kBR6Hw8ovXKBKiDD4+leXLS3F/ik=;
	b=s+e2eqhqoWFjN4GHsgb6iu8vwzW+7SyY9q+HQqR797OfaLYlUr97oEXpCt3pgPyuJv
	MS8y2DMNZP2swCrQo1ldLhGUHQX09Esdl2i0a0Cp3Lx2Nb/Iy9xiIjl4bLGTIBkF0LA0
	JerpszpXPXYCvsihY3Ipbpe+tCWrP21hHav1x9dmpWDwcN/MYKk0OpjrpmN9i9RZQyWF
	H4f1YJK5Am1NTqKfy6Sm9wUYbjs0bvEeC4j7HZ6p9gsbQ6WWFpuTHIizUeoWkAFSlgA8
	8qkGJpKWG5kckd+SJ6asEqJFnk2VmqRTrWaBecPeJYWoEhCH8b5jHXD/VCzTmJOMVmBP
	whyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NPRvgVGg8Y/3Ni/kBR6Hw8ovXKBKiDD4+leXLS3F/ik=;
	b=iGde8qHm3+/GP73xIqFg6f7sQuc9pQ0g0pRMGIwI8j7TgEBqENs9Yz4fQwc7OrzPsQ
	Xz2qpKAB6wxqBt0j8YPnBwtepJiQeH/x619AGbbGTDoJQV/CxPPIG7KFwvPVks3sS0Yd
	XrTmJ1tZpUlb5VVmb+VwBYRyb9mf/WvEDDRZOncA4b///Avx8skTBW90ZeRhKr5nv6x2
	Gv5c06cxERcY44Z7+9WJzyhkU+WHVkWZgAkrlS1tz4QXFvrzLqzDhQjcx4ZfpzMQ1xOT
	uUPvVWlvJjZDjYZTp5p2Z7IO21GC53ZnzaAN2RjsNXHGz0FOTwzhJT6Q8dKpnk4qlP0+
	HkIA==
X-Gm-Message-State: APjAAAXP4krSkYFZspJYjdPHrEuHPjDdsejJVLYoOzjXXBksYDZSl5Ij
	MyCF2bBgSt3HAWnRJmkdzIN8lhO2kIQ=
X-Google-Smtp-Source: APXvYqxasUHwAZVJUxWnNP153unhgDwqQ9blCy61DHhnoDesTrq4o8eeAXA0xub3qMomaebvVRF/EQ==
X-Received: by 2002:a62:160b:: with SMTP id 11mr15874744pfw.88.1556949217269; 
	Fri, 03 May 2019 22:53:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:58 -0700
Message-Id: <20190504055300.18426-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: [Qemu-devel] [PATCH v3 29/31] target/tricore: Use tcg_gen_abs_tl
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
Cc: alex.bennee@linaro.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055258.0zMAueOdluIWOSw8T7cEEoYGYFEQwx6fPDgR5cIJsGE@z>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20190423102145.14812-3-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 8f6416144e..06c4485e55 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2415,11 +2415,7 @@ gen_msubadr32s_h(TCGv ret, TCGv r1, TCGv r2, TCGv r3, uint32_t n, uint32_t mode)
 
 static inline void gen_abs(TCGv ret, TCGv r1)
 {
-    TCGv temp = tcg_temp_new();
-    TCGv t0 = tcg_const_i32(0);
-
-    tcg_gen_neg_tl(temp, r1);
-    tcg_gen_movcond_tl(TCG_COND_GE, ret, r1, t0, r1, temp);
+    tcg_gen_abs_tl(ret, r1);
     /* overflow can only happen, if r1 = 0x80000000 */
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_PSW_V, r1, 0x80000000);
     tcg_gen_shli_tl(cpu_PSW_V, cpu_PSW_V, 31);
@@ -2430,9 +2426,6 @@ static inline void gen_abs(TCGv ret, TCGv r1)
     tcg_gen_xor_tl(cpu_PSW_AV, ret, cpu_PSW_AV);
     /* calc SAV bit */
     tcg_gen_or_tl(cpu_PSW_SAV, cpu_PSW_SAV, cpu_PSW_AV);
-
-    tcg_temp_free(temp);
-    tcg_temp_free(t0);
 }
 
 static inline void gen_absdif(TCGv ret, TCGv r1, TCGv r2)
@@ -6617,13 +6610,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
@@ -6655,13 +6643,8 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
         tcg_gen_movi_tl(cpu_PSW_AV, 0);
         if (!tricore_feature(env, TRICORE_FEATURE_131)) {
             /* overflow = (abs(D[r3+1]) >= abs(D[r2])) */
-            tcg_gen_neg_tl(temp, temp3);
-            /* use cpu_PSW_AV to compare against 0 */
-            tcg_gen_movcond_tl(TCG_COND_LT, temp, temp3, cpu_PSW_AV,
-                               temp, temp3);
-            tcg_gen_neg_tl(temp2, cpu_gpr_d[r2]);
-            tcg_gen_movcond_tl(TCG_COND_LT, temp2, cpu_gpr_d[r2], cpu_PSW_AV,
-                               temp2, cpu_gpr_d[r2]);
+            tcg_gen_abs_tl(temp, temp3);
+            tcg_gen_abs_tl(temp2, cpu_gpr_d[r2]);
             tcg_gen_setcond_tl(TCG_COND_GE, cpu_PSW_V, temp, temp2);
         } else {
             /* overflow = (D[b] == 0) */
-- 
2.17.1


