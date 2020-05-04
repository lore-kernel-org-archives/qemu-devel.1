Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4FCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82E220757
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL9bvqa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82E220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaTe-0006u0-OH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI2-0000jQ-VM
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHy-00017d-NP
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id k1so20717046wrx.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=U1VGbGb5OGUA76fGkqiO2EtBFxkWpDuv98F+IatFsmo=;
 b=gL9bvqa5WgjKvzTXlIhaNvdgigpzz9fdXOM8TLp5pnwACgiax+N7X9h1D9ih3AByKC
 ulSZRSs2PUAc1bdjMci2nnG6NFOpSri24ZLH8/aFpLHP4CSP7lBDXGeQzJmGZZLu32o8
 JP7/2gsxcEGGBUw17Fs2oQke65S7eLm7RsWRZteUDfQrnZ3ocosFybZlXGZeFIKI6TOn
 BD2njpwlezomoTzKW9gNWIpT/siYwnbVyooJw+V7OANZ21zB5Q6fI4+XbbqvjBouO3kh
 Rc+RMzs3MhTBPf0HzyUYuWJIG13pc5DvF0dsP3Qv/iSBh5fiqr2Q3nlRIKdILkYmCjlJ
 0Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U1VGbGb5OGUA76fGkqiO2EtBFxkWpDuv98F+IatFsmo=;
 b=itc6navL+pMdWYZcjL3ZdpAcKBHQAMIbR4+hHaoFgt1IwEOm9XvAZ8fqncmDSS3UdF
 3Nt3i37C5fNT8B8R7RCiA4Gg+jJUETOBZKpMxvylXHJQJcskfOgpldIGGRTuiOcHhTyR
 L9Ax4bJQfRcjtoIl6VbmS+kfgxWxO/oVG23vygWe43Mz7uekeQQSSkiJ/uqH0zc3iXP9
 QSEX+40lGI2fpn9jkKcnCbA42282Uz6g35s3BpEPtxwKQmFFPrYktHrdnaUdzvO6mBhy
 cyC/Gg7NvRvcE10dqRa4Y1h+tmq9x/e3GOvuf0GDAyFY/rToHAGV+NY4DvpjpIpc1ve9
 sbUA==
X-Gm-Message-State: AGi0PuZ+AlaFtY+BSprj2Lb49VMCDfYjZab6vOf+MYynxLRKKaRcCMjg
 6/yEZuYziiwxNdzeOkA06oBWQQzadaZB3w==
X-Google-Smtp-Source: APiQypIXYcEB1za13LupqBvfwfxNgyo0lQHZ4fa9LRKpRpsyQ/U6vGdhgpNOgufUN3CTQ52TFgZ7VQ==
X-Received: by 2002:adf:9482:: with SMTP id 2mr18029013wrr.328.1588595617079; 
 Mon, 04 May 2020 05:33:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/39] target/arm: Convert VCMLA (vector) to decodetree
Date: Mon,  4 May 2020 13:32:53 +0100
Message-Id: <20200504123309.3808-24-peter.maydell@linaro.org>
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

Convert the VCMLA (vector) insns in the 3same extension group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-5-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   | 11 ++++++++++
 target/arm/translate-neon.inc.c | 37 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 11 +---------
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index 3aea7c5e188..d1d707a56d5 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -25,3 +25,14 @@
 # More specifically, this covers:
 # 2reg scalar ext: 0b1111_1110_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
 # 3same ext:       0b1111_110x_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
+
+# VFP/Neon register fields; same as vfp.decode
+%vm_dp  5:1 0:4
+%vm_sp  0:4 5:1
+%vn_dp  7:1 16:4
+%vn_sp  16:4 7:1
+%vd_dp  22:1 12:4
+%vd_sp  12:4 22:1
+
+VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a33e81ba3ab..0baae1338a3 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -30,3 +30,40 @@
 #include "decode-neon-dp.inc.c"
 #include "decode-neon-ls.inc.c"
 #include "decode-neon-shared.inc.c"
+
+static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
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
+    fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       fpst, opr_sz, opr_sz, a->rot,
+                       fn_gvec_ptr);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5a82a56e8ed..ae6799c6ae0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,16 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfe200f10) == 0xfc200800) {
-        /* VCMLA -- 1111 110R R.1S .... .... 1000 ...0 .... */
-        int size = extract32(insn, 20, 1);
-        data = extract32(insn, 23, 2); /* rot */
-        if (!dc_isar_feature(aa32_vcma, s)
-            || (!size && !dc_isar_feature(aa32_fp16_arith, s))) {
-            return 1;
-        }
-        fn_gvec_ptr = size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
-    } else if ((insn & 0xfea00f10) == 0xfc800800) {
+    if ((insn & 0xfea00f10) == 0xfc800800) {
         /* VCADD -- 1111 110R 1.0S .... .... 1000 ...0 .... */
         int size = extract32(insn, 20, 1);
         data = extract32(insn, 24, 1); /* rot */
-- 
2.20.1


