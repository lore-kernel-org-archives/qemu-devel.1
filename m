Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEFC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A638B208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKxpzDN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A638B208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQNTi-0007aT-Ei
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 22:47:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQNSq-0007A8-If
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQNSo-0003KU-K2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 22:46:48 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQLzV-0005RB-Ua
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:12:26 -0400
Received: by mail-pl1-x643.google.com with SMTP id b3so7336778plr.7
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=UNTNcU8NTc7XelmI6QIbWOMz3/5RDKMpurk3x3KqTCI=;
	b=wKxpzDN5p9sW1US72yyS6VBUq0hOrHMBsdWkSAl75jp4y9t6QJy1TkdOJhPNC3VxVu
	SZXL+fNFxpJCoK+3PEBvJDRhsX+vhPHNUGaMg9Bu/205GdQc99u/AOOQN7kcYSfrKZ7Y
	Q6oNuLFhmLnPcXFjxH/UtFhMLFpQRutVbdob0J/fQ3GfYLVfGoUqPHuyccaUpkJTTewr
	mQv6AdIOM10nnXMDBYID5xL/rmu4gOX1JppvzRycx1ik9pu3SIEt/Zvc0GK+GVLPO4du
	U/iZw+18Sn3quedC2fGT6BWKtB9PRZou/AW9uM6NP0Ks7oNROeuMxcOoQuExnaicW+Ev
	FgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=UNTNcU8NTc7XelmI6QIbWOMz3/5RDKMpurk3x3KqTCI=;
	b=OtLJpfb/8w+/gvhKU4wXry1AssqSXwRoLF7OpnJcK6BcyMEcSd8TSMOn/Fd2fMcXz7
	w7fLg3Ii5qdGfrp81tD+whgIWHsvpj0AtLYPAAFnG99V1iPLCPoNLyz+JHACTMNWzl4h
	wXopc8k4Zs3mJvp82V3FFxLNfeD5fN1/TgyG2Jq0m6r1tYEHIrAsmfj9goqqRnOf37x4
	EDrD1VUiFpFgC8NG+poIa+wy88ge4uI3oVfqvXoBqraPlONtpv66fk8i8qiPXg4HFPZz
	7CHmL/ldI8/Q//9nQmme81DZl1+P/S0/cjPMWppyKqW4mFjJAlZYYihYpHmLW85KUVOh
	VXlQ==
X-Gm-Message-State: APjAAAUzELRmUx6fL+NLUVIDrlzge9A4I6f+3WxeSKzrgKjsnCNCnJLy
	8IYY2YZdNX2egySzrjkFEzIFtjBscTI=
X-Google-Smtp-Source: APXvYqx+Mdr/wkp8ot7Hb7rPuxslVTZLzrcL/pBqgS8A48OgLz0cg1j1T2nJjekKJRAF3vYER6bDhg==
X-Received: by 2002:a17:902:54f:: with SMTP id
	73mr35148246plf.140.1557796293841; 
	Mon, 13 May 2019 18:11:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	b67sm20029147pfb.150.2019.05.13.18.11.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 18:11:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 18:11:28 -0700
Message-Id: <20190514011129.11330-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514011129.11330-1-richard.henderson@linaro.org>
References: <20190514011129.11330-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Use extract2 for EXTR
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is, after all, how we implement extract2 in tcg/aarch64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 9dcc5ff3a3..c4bee74ce5 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4114,25 +4114,27 @@ static void disas_extract(DisasContext *s, uint32_t insn)
             } else {
                 tcg_gen_ext32u_i64(tcg_rd, cpu_reg(s, rm));
             }
-        } else if (rm == rn) { /* ROR */
-            tcg_rm = cpu_reg(s, rm);
-            if (sf) {
-                tcg_gen_rotri_i64(tcg_rd, tcg_rm, imm);
-            } else {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                tcg_gen_extrl_i64_i32(tmp, tcg_rm);
-                tcg_gen_rotri_i32(tmp, tmp, imm);
-                tcg_gen_extu_i32_i64(tcg_rd, tmp);
-                tcg_temp_free_i32(tmp);
-            }
         } else {
-            tcg_rm = read_cpu_reg(s, rm, sf);
-            tcg_rn = read_cpu_reg(s, rn, sf);
-            tcg_gen_shri_i64(tcg_rm, tcg_rm, imm);
-            tcg_gen_shli_i64(tcg_rn, tcg_rn, bitsize - imm);
-            tcg_gen_or_i64(tcg_rd, tcg_rm, tcg_rn);
-            if (!sf) {
-                tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
+            tcg_rm = cpu_reg(s, rm);
+            tcg_rn = cpu_reg(s, rn);
+
+            if (sf) {
+                /* Specialization to ROR happens in EXTRACT2.  */
+                tcg_gen_extract2_i64(tcg_rd, tcg_rm, tcg_rn, imm);
+            } else {
+                TCGv_i32 t0 = tcg_temp_new_i32();
+
+                tcg_gen_extrl_i64_i32(t0, tcg_rm);
+                if (rm == rn) {
+                    tcg_gen_rotri_i32(t0, t0, imm);
+                } else {
+                    TCGv_i32 t1 = tcg_temp_new_i32();
+                    tcg_gen_extrl_i64_i32(t1, tcg_rn);
+                    tcg_gen_extract2_i32(t0, t0, t1, imm);
+                    tcg_temp_free_i32(t1);
+                }
+                tcg_gen_extu_i32_i64(tcg_rd, t0);
+                tcg_temp_free_i32(t0);
             }
         }
     }
-- 
2.17.1


