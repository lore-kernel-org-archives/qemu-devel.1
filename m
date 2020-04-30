Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D938C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A34C20836
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qKR+eVS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A34C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDpn-0001ll-Fg
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdz-0001QU-1R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdc-0000lu-51
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdb-0000jx-JZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id e26so2975224wmk.5
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=podrIWc2Sg2T1gwDLYmZIz4NN7yExiQdpITVed1EL5o=;
 b=qKR+eVS9xd2Xe8Sn0TeaNcVA+4Po3Fsa+mQrf26dtaUd3CLzCGPjR+VWhEDUplgYJ0
 Z/e2/Yvm2gP/kfONJa5Z41D4e8zEb0/Ah1jAUyAMESjxVzmmF7WIecZXcUddAPiAkFvJ
 mXHxze8CvoEvfEtCMLxo6/e3dGamfyNdTK1NR/3Ldw0X2USwMuUmOKX15Z7gIJRZswBu
 BTO8Us/719U7ZEIXl74w/RGZbDQUpJBAUVqywACKZ4Q1zA/UKlKWAzR85z3CuLlQSvus
 zW3DqsSPhZIfFP7GqmKeNbm5gRTHcSRidKZty7MXPPDazxqmUZcZB4kBJ485Igr/lx8I
 91kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=podrIWc2Sg2T1gwDLYmZIz4NN7yExiQdpITVed1EL5o=;
 b=mzjEfP/5o4SU3gDRpzAyY+ApYzsvK95E42Dr9p3MGdmdF6NO+roScZlh9S3pOV4oqH
 WwZlXRkU/8ZMFxzQEIP3NNHp8hLb6FOQtF04J7obeN1lIj+NuMgl6mrtwDwZRaFfBxl0
 QpxH0w7ksmfM4dEXmIk/07Q1ASfNvwvyQjBK/oABnM0dVDs8fuqDW7V8Par9SK096rtv
 G1V8cp8C67WODfCZQLCG1j2lNmVdZ8CxOYLKuqo4UHj7hJyfgEKRRA0R9kRe/iUaFA38
 XK7aKL3Xk8ErnI2cwTAY2OVLAZLgMdiT3+GBFZ7DZMroKEjhPPYROAy0/ERiHhhqDoQh
 cqnw==
X-Gm-Message-State: AGi0PuYSPPGlIg8hr4idiKDbmAK0tTF34OsBaobDjx+/ubvm0jZ7Kf5Y
 xOisSYkWATbxIHY2U9RfS8t99w==
X-Google-Smtp-Source: APiQypInHAV3/UGy/d6IIseaX5U7c3XI+bRT9fX304OSp8rTLtD86MsLFQ6+irtqMgg5Q7/qiWWcRw==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr4522363wmf.175.1588270218239; 
 Thu, 30 Apr 2020 11:10:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/36] target/arm: Convert V[US]DOT (scalar) to decodetree
Date: Thu, 30 Apr 2020 19:09:36 +0100
Message-Id: <20200430181003.21682-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430181003.21682-1-peter.maydell@linaro.org>
References: <20200430181003.21682-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the V[US]DOT (scalar) insns in the 2reg-scalar-ext group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 35 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 13 +-----------
 target/arm/neon-shared.decode   |  3 +++
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 92eccbf8236..7cc6ccb0697 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -207,3 +207,38 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
+{
+    gen_helper_gvec_3 *fn_gvec;
+    int opr_sz;
+    TCGv_ptr fpst;
+
+    if (!dc_isar_feature(aa32_dp, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vn) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    fn_gvec = a->u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
+    opr_sz = (1 + a->q) * 8;
+    fpst = get_fpstatus_ptr(1);
+    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->rm),
+                       opr_sz, opr_sz, a->index, fn_gvec);
+    tcg_temp_free_ptr(fpst);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b82e54b7b23..af2714292ea 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7049,18 +7049,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xffb00f00) == 0xfe200d00) {
-        /* V[US]DOT -- 1111 1110 0.10 .... .... 1101 .Q.U .... */
-        int u = extract32(insn, 4, 1);
-
-        if (!dc_isar_feature(aa32_dp, s)) {
-            return 1;
-        }
-        fn_gvec = u ? gen_helper_gvec_udot_idx_b : gen_helper_gvec_sdot_idx_b;
-        /* rm is just Vm, and index is M.  */
-        data = extract32(insn, 5, 1); /* index */
-        rm = extract32(insn, 0, 4);
-    } else if ((insn & 0xffa00f10) == 0xfe000810) {
+    if ((insn & 0xffa00f10) == 0xfe000810) {
         /* VFM[AS]L -- 1111 1110 0.0S .... .... 1000 .Q.1 .... */
         int is_s = extract32(insn, 20, 1);
         int vm20 = extract32(insn, 0, 3);
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index c11d755ed14..63a46c63c07 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -54,3 +54,6 @@ VCMLA_scalar   1111 1110 0 . rot:2 .... .... 1000 . q:1 index:1 0 vm:4 \
                vn=%vn_dp vd=%vd_dp size=0
 VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp size=1 index=0
+
+VDOT_scalar    1111 1110 0 . 10 .... .... 1101 . q:1 index:1 u:1 rm:4 \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


