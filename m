Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF3420727
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChuO5K4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF3420727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZF9q-0000jE-K7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEki-0003eg-6L
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:24 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEke-0005zL-Qe
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id v12so4316390wrp.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jHDUHnWFXKGEIUTqu2NnFwNlVDUYSXsCftelUh+UFoI=;
 b=ChuO5K4tCd8zS5eIzRk+6NXrzZhVFAegMSLm69The7eZQA7nqIMgyPBibFFicSjkWh
 720218/vDOw9OAeKODdadRxaJgz+r6RlxEsWUA1An3FN3zoU24XdxFLEnIHsEW7615Vt
 HvsKAfDnblFWv2YAZwoVfmh+S5Bx3usFnRPp31WzLuWZ0rU0ldvtMJ2XB7h8WH+qGT6E
 jQ3u+JdcYWaYH/Bu3nnvCyemCfO7m8MC240sWLOKTO9K/lFxfGE6ky/MlZ0vfbYxhKDC
 Dj6lhtM1Fc64PQQFVFa3wE69gKoplbQgzGAXIzu8skg+cKCfroEApyf+ao7ehi+OWsUb
 Rnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jHDUHnWFXKGEIUTqu2NnFwNlVDUYSXsCftelUh+UFoI=;
 b=Xg7OdTO9dWn8HpEvBnetn5ZM0/jtukr8MHbIGrBLs/rteT3PwJ37pS3SWut/cR3k16
 e6iM4RofnrSjnolMhIxHekkpGLsl4wTWiIRN8natQnace3SlbRRb/Gjlzq1vY/8RSllg
 /1GkTe5xbWSL/1iq5QL34HREjse99OHYFSEr2CvU5WbbMX1sLEz0NRD2f26TWdCKknUy
 O3FyloxkVSFKvfNeG22r8tyLk3fxdVl7FOQVyFEXnkCCOVvmAQFfnYOAyYOYCVqPsqvj
 9oKvNz16c1A15kepmIyd2b4GD5SKhpDw/Q3CFcggHK03sEtJAeRvcPVwyKMMOCMGiSW1
 buyQ==
X-Gm-Message-State: AOAM530FSDtbEFOiXbJEwsUp1qJdDv3+Ml8mSxAt8oeqZyKOJvF09lpz
 +cOM1xghmBaJqvz+4u1HCzPoelJjZXnE9Q==
X-Google-Smtp-Source: ABdhPJx+UIo9pHBS2oR9TzntuS6QkCg0wfJwlDVS7LHdrcAT9upiYnIM9fVvX6r9PTT/la+UI4QBfw==
X-Received: by 2002:a5d:5189:: with SMTP id k9mr5667389wrv.3.1589466138765;
 Thu, 14 May 2020 07:22:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/45] target/arm: Convert Neon 3-reg-same VQRDMLAH/VQRDMLSH to
 decodetree
Date: Thu, 14 May 2020 15:21:22 +0100
Message-Id: <20200514142138.20875-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Convert the Neon VQRDMLAH and VQRDMLSH insns in the 3-reg-same group
to decodetree.  These don't use do_3same() because they want to
operate on VFP double registers, whose offsets are different from the
neon_reg_offset() calculations do_3same does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-2-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 15 +++++++++++++++
 target/arm/translate.c          | 14 ++------------
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 593f7fff03d..82503c582ef 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -97,3 +97,6 @@ VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
 
 VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
+
+VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
+VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 099491b16f3..661b5fc4cf2 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -671,3 +671,18 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
     }
     return do_3same(s, a, gen_VMUL_p_3s);
 }
+
+#define DO_VQRDMLAH(INSN, FUNC)                                         \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        if (!dc_isar_feature(aa32_rdm, s)) {                            \
+            return false;                                               \
+        }                                                               \
+        if (a->size != 1 && a->size != 2) {                             \
+            return false;                                               \
+        }                                                               \
+        return do_3same(s, a, FUNC);                                    \
+    }
+
+DO_VQRDMLAH(VQRDMLAH, gen_gvec_sqrdmlah_qc)
+DO_VQRDMLAH(VQRDMLSH, gen_gvec_sqrdmlsh_qc)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e3d37ef2e99..1f06cb5a87f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5450,12 +5450,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             if (!u) {
                 break;  /* VPADD */
             }
-            /* VQRDMLAH */
-            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
-                gen_gvec_sqrdmlah_qc(size, rd_ofs, rn_ofs, rm_ofs,
-                                     vec_size, vec_size);
-                return 0;
-            }
+            /* VQRDMLAH : handled by decodetree */
             return 1;
 
         case NEON_3R_VFM_VQRDMLSH:
@@ -5466,12 +5461,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 break;
             }
-            /* VQRDMLSH */
-            if (dc_isar_feature(aa32_rdm, s) && (size == 1 || size == 2)) {
-                gen_gvec_sqrdmlsh_qc(size, rd_ofs, rn_ofs, rm_ofs,
-                                     vec_size, vec_size);
-                return 0;
-            }
+            /* VQRDMLSH : handled by decodetree */
             return 1;
 
         case NEON_3R_VABD:
-- 
2.20.1


