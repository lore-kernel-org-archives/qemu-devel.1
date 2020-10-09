Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0444C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4755C221FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIkhuDHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4755C221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQthH-0008UX-9R
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQtg3-0007Zf-3E
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:47:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQtfx-0000Rf-IN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:47:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id j136so10104096wmj.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uWUs5XS37Km3EAJspIL0UZAFkTxAe4sbDHRIXZCWeRE=;
 b=bIkhuDHRKYvRui1SAZn4x4iLExMG29e8sy6s5imaclj9ZD34/1+FJADv5R6ZrAAj8p
 GfOxXzHZKX5XlZElwqfIfpcSd53uKUPkWOfjo4bOSnkVeabmxo8jTmJo495tbVOitX2C
 cGo04i4FaAxSGGx8truD2+55bzKVgRKG2CWa6O3zRDdPkY0lUXpgdcnoi7nfV8fkm2EN
 PmIRxI+3uMDlHb4ZgXzwi/9thYrVFYxWMjnCcH0MKwa9g+EUMBa4J6U9OOP7sIaBqRAo
 ko4IVKfdGZ6yz7x5kGN75wc8ABLs07YTXjxGKdF8UVq4awOLNXRNLp0zsinKJI1LTIfz
 IZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uWUs5XS37Km3EAJspIL0UZAFkTxAe4sbDHRIXZCWeRE=;
 b=C7J/VYQTUw/jRQr/bq/JrwczIR7Odq9GQnPmZslvlNVGx5A8nmivgZe8FVcAaUaMvn
 bCU54//HY3Hs2cRAvr6Dy0ZSkZ3b9O/fc54hOuvyPrtN9yxPgpA3Ng919TJSJ+iQ6iES
 bBlC+VUWczSVwHC4Mfl4RJi3gI+2h4Asdzxc/GuLFl6MXqSphh7Wph5oUFqe1JobfDOU
 S2hzbkyjSKZ95dJqwaaYwLo7cHQfV4QX0F/SZ2vlHSmA7M8Ah05JV/+7XMBZkTNCwUdb
 e7FepoyCKW/hxBN/OFV2dLxIgrPXqiI9iZegw2WzbxMUg7CD8nVuB5i7oEKMTTYuPDcm
 ITiw==
X-Gm-Message-State: AOAM530eqhFlTHS5lmb0HMODK2qp0vXrpofjUIFdLJ/48h5hQBaN5tza
 lWR6V4QrzUuyP6krhAw7bKkFUO0dl6tY6O3R
X-Google-Smtp-Source: ABdhPJyeCW/HOkMJdUvl5XFC/ruKrzSHTJAX/fJ0j1125x3+NQ/azRI80UI/FveLiVtTbvXVhOYNFw==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr14565273wmk.87.1602254835612; 
 Fri, 09 Oct 2020 07:47:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm11832373wmf.26.2020.10.09.07.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 07:47:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix SMLAD incorrect setting of Q bit
Date: Fri,  9 Oct 2020 15:47:12 +0100
Message-Id: <20201009144712.11187-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

The SMLAD instruction is supposed to:
 * signed multiply Rn[15:0] * Rm[15:0]
 * signed multiply Rn[31:16] * Rm[31:16]
 * perform a signed addition of the products and Ra
 * set Rd to the low 32 bits of the theoretical
   infinite-precision result
 * set the Q flag if the sign-extension of Rd
   would differ from the infinite-precision result
   (ie on overflow)

Our current implementation doesn't quite do this, though: it performs
an addition of the products setting Q on overflow, and then it adds
Ra, again possibly setting Q.  This sometimes incorrectly sets Q when
the architecturally mandated only-check-for-overflow-once algorithm
does not. For instance:
 r1 = 0x80008000; r2 = 0x80008000; r3 = 0xffffffff
 smlad r0, r1, r2, r3
This is (-32768 * -32768) + (-32768 * -32768) - 1

The products are both 0x4000_0000, so when added together as 32-bit
signed numbers they overflow (and QEMU sets Q), but because the
addition of Ra == -1 brings the total back down to 0x7fff_ffff
there is no overflow for the complete operation and setting Q is
incorrect.

Fix this edge case by resorting to 64-bit arithmetic for the
case where we need to add three values together.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 58 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d34c1d351a6..d8729e42c48 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7401,21 +7401,59 @@ static bool op_smlad(DisasContext *s, arg_rrrr *a, bool m_swap, bool sub)
     gen_smul_dual(t1, t2);
 
     if (sub) {
-        /* This subtraction cannot overflow. */
+        /*
+         * This subtraction cannot overflow, so we can do a simple
+         * 32-bit subtraction and then a possible 32-bit saturating
+         * addition of Ra.
+         */
         tcg_gen_sub_i32(t1, t1, t2);
+        tcg_temp_free_i32(t2);
+
+        if (a->ra != 15) {
+            t2 = load_reg(s, a->ra);
+            gen_helper_add_setq(t1, cpu_env, t1, t2);
+            tcg_temp_free_i32(t2);
+        }
+    } else if (a->ra == 15) {
+        /* Single saturation-checking addition */
+        gen_helper_add_setq(t1, cpu_env, t1, t2);
+        tcg_temp_free_i32(t2);
     } else {
         /*
-         * This addition cannot overflow 32 bits; however it may
-         * overflow considered as a signed operation, in which case
-         * we must set the Q flag.
+         * We need to add the products and Ra together and then
+         * determine whether the final result overflowed. Doing
+         * this as two separate add-and-check-overflow steps incorrectly
+         * sets Q for cases like (-32768 * -32768) + (-32768 * -32768) + -1.
+         * Do all the arithmetic at 64-bits and then check for overflow.
          */
-        gen_helper_add_setq(t1, cpu_env, t1, t2);
-    }
-    tcg_temp_free_i32(t2);
+        TCGv_i64 p64, q64;
+        TCGv_i32 t3, qf, one;
 
-    if (a->ra != 15) {
-        t2 = load_reg(s, a->ra);
-        gen_helper_add_setq(t1, cpu_env, t1, t2);
+        p64 = tcg_temp_new_i64();
+        q64 = tcg_temp_new_i64();
+        tcg_gen_ext_i32_i64(p64, t1);
+        tcg_gen_ext_i32_i64(q64, t2);
+        tcg_gen_add_i64(p64, p64, q64);
+        load_reg_var(s, t2, a->ra);
+        tcg_gen_ext_i32_i64(q64, t2);
+        tcg_gen_add_i64(p64, p64, q64);
+        tcg_temp_free_i64(q64);
+
+        tcg_gen_extr_i64_i32(t1, t2, p64);
+        tcg_temp_free_i64(p64);
+        /*
+         * t1 is the low half of the result which goes into Rd.
+         * We have overflow and must set Q if the high half (t2)
+         * is different from the sign-extension of t1.
+         */
+        t3 = tcg_temp_new_i32();
+        tcg_gen_sari_i32(t3, t1, 31);
+        qf = load_cpu_field(QF);
+        one = tcg_const_i32(1);
+        tcg_gen_movcond_i32(TCG_COND_NE, qf, t2, t3, one, qf);
+        store_cpu_field(qf, QF);
+        tcg_temp_free_i32(one);
+        tcg_temp_free_i32(t3);
         tcg_temp_free_i32(t2);
     }
     store_reg(s, a->rd, t1);
-- 
2.20.1


