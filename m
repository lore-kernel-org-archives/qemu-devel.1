Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E852DC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B618620757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lxziooey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaOK-0003zI-Sm
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI1-0000eM-1p
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHz-00017q-Nz
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:40 -0400
Received: by mail-wr1-x433.google.com with SMTP id g13so20679228wrb.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=r8WeYE67ChhiW5m6qJC3n2A7tJXvKOPChfTDBZgi+DQ=;
 b=LxziooeyW85YyUsmeNuNNaT5iy7PO2a6yQLQUNyfwvYSwEyJPc97n4kb+FPF0YJ0Ib
 CgNXhF7+WV/LY4/jN4P0R5uQf+Du1WVDSNovqXWN3nCC8Hkdutz+Vwxx2NABhow74GBt
 u3W4szqbwU0sau+aoYwly7/h2KgJLJWWZ3LN3rbufUDOiAJ9xf7BDiSGRcUfpR49l55I
 tR6P7rokAP/HYNMqA4hzL4s7vSfNzd+hxpyA9iw9lbDiDCuL5MeFlSTAnamNOCRAdear
 tEzYWDDHv8CqInrxURxi6VJqopYgOkMMZ37wbzMYXzaA3VsAcNoHxxJNW/ySX7AyYo/b
 FoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8WeYE67ChhiW5m6qJC3n2A7tJXvKOPChfTDBZgi+DQ=;
 b=UK4og4BrIFc5ToDI5gJd64QUzvscWdsRKAwPiqyvih0CWw8kKWlXEiP89MWokY3qB6
 UUhybv6yofA9nROEyU7S8Z7KZoTbv0UAC4ZC+VydSfvJgpK/rmZ0jzdCH2AX1FDuGbGw
 41g521b4lhZMHfUyHDYFaPU6OTpOCI6cBWwhUtq38bwsM82KDWcS83/dpZr8HaqYnpah
 v7f1b2mtINJ8yA+KvL/tESRrkuOCOx1vP1jA7sn4S6Ly32TxX4nWQrlNX+vVJc3V2FUc
 HBbf0O6hsziWgyfHmHngCXXovmvjBF/Mmh+pj6oOYxwjhzq6D/F5vBrDFjYSYxi+a7sZ
 IY2Q==
X-Gm-Message-State: AGi0PuYZxh/JFLv1xQJFAmv1Ud5+/1TUEEFWLsz7LhFYWs/l7wiAn8lY
 zTf2dtgLnEScXmsgBTuOg4q1Zh2X93wRZw==
X-Google-Smtp-Source: APiQypKmsZ5cX3jOxG1fBs0BScpoWOYv/3sjifNtjlkXECcxXzEyMZI6ErZsCvcXsVSiMuiKEkzafA==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr18585180wrc.214.1588595618087; 
 Mon, 04 May 2020 05:33:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/39] target/arm: Convert VCADD (vector) to decodetree
Date: Mon,  4 May 2020 13:32:54 +0100
Message-Id: <20200504123309.3808-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Convert the VCADD (vector) insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-6-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |  3 +++
 target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 11 +---------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index d1d707a56d5..ed65dae1809 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -36,3 +36,6 @@
 
 VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0baae1338a3..28011e88d9e 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -67,3 +67,40 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
+{
+    int opr_sz;
+    TCGv_ptr fpst;
+    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+
+    if (!dc_isar_feature(aa32_vcma, s)
+        || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz, a->rot,
+                       fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ae6799c6ae0..993bead82ff 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,16 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfea00f10) == 0xfc800800) {
-        /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
-        int size = extract32(insn, 20, 1);
-        data = extract32(insn, 24, 1); /* rot */
-        if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
-            return 1;
-        }
-        fn_gvec_ptr = size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
-    } else if ((insn & 0xfeb00f00) == 0xfc200d00) {
+    if ((insn & 0xfeb00f00) == 0xfc200d00) {
         /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
         bool u = extract32(insn, 4, 1);
         if (!dc_isar_feature(aa32_dp, s)) {
-- 
2.20.1


