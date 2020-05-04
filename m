Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A2EC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7F92078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTuJsAHV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7F92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaPy-0008Er-Ju
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI1-0000gW-QS
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI0-000189-Ra
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id x17so20700895wrt.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SQF8sbnZa9j7ur7kcOkwe5x6BFFSO3tvg6vbMZe5jYc=;
 b=YTuJsAHVB2RhZWLpaheHetu4cai4cbgfiRxllfihAmDU0znorkgkVjOVOCLQKegVhl
 TMZVFU/Bp9EdGc2hwLsG+0UUixeCwSXIeBA+fuPXnD4zC3+IPMAgd9uc/Ie9FV4p7G5+
 XhEr1tQEaGMlBJKVjfX9KkGMzt2Pou9zO8PNwchyGkt/j4T0Mwf/tWzqCYNA+P78BhoL
 a5rFjR13xHGXC27Sefwdjwq9iAbKWAtPVGTEJEBvj6uJXe2k8a3K7fNP+tTgPSM+v9XB
 iJjbwyhVIbb9AE36MfEOEtB/nt9w+CgzMo1sH16sRvzz3991i/EqMGr7xNqEPKL8WZFH
 azxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SQF8sbnZa9j7ur7kcOkwe5x6BFFSO3tvg6vbMZe5jYc=;
 b=JR6bs5dFQ3yWfxgzTVa6+NYHjh4OylIiviHS2Pw4xwSZc3DYtw52TXCkS/lirWU86+
 mEDlOqzushhh3EGUFUSl/L1msar0RBIZqoTttNGJIdwwIB406FLp4T1vMp1kkmAxk+Br
 kNb5QWYh0rYAjeuE39y1VmHASBBWAgHIF1TUd97wtCJOvcezU3veu3XWgYEUw/RoKo5/
 +yVHQ2WrOfonPu/axjsDGubuRqtgONfO7tSZnteKtWoc3mhe3i1lzBmrlMD2+Tm9dAz6
 DhH5NiQ4ZjGyodHym/BDWsuvlvhB3rp47LekNAFV1Z6ikAI3H4ZNgvyKyec7Wzux4G+p
 sC5A==
X-Gm-Message-State: AGi0PuYbLy4M1ih9zzhNMgmQL3hlHBftjtjw3hD2jqrsAjU//XjPvlzU
 MmLoW7G5GViR33uFMhLx1P+6NKdvDPZzwA==
X-Google-Smtp-Source: APiQypIQRDeJWwY5mDySASO8vNkX6plmdEhruklKsY16CTGcEV3RdkT9yllj9HzFry1ULrFd2qGzBA==
X-Received: by 2002:a05:6000:110a:: with SMTP id
 z10mr18812580wrw.389.1588595619082; 
 Mon, 04 May 2020 05:33:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/39] target/arm: Convert V[US]DOT (vector) to decodetree
Date: Mon,  4 May 2020 13:32:55 +0100
Message-Id: <20200504123309.3808-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Convert the V[US]DOT (vector) insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-7-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |  4 ++++
 target/arm/translate-neon.inc.c | 32 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  9 +--------
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index ed65dae1809..c9c641905d3 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -39,3 +39,7 @@ VCMLA          1111 110 rot:2 . 1 size:1 .... .... 1000 . q:1 . 0 .... \
 
 VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+# VUDOT and VSDOT
+VDOT           1111 110 00 . 10 .... .... 1101 . q:1 . u:1 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 28011e88d9e..6537506c5b6 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -104,3 +104,35 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
+{
+    int opr_sz;
+    gen_helper_gvec_3 *fn_gvec;
+
+    if (!dc_isar_feature(aa32_dp, s)) {
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
+    fn_gvec = a->u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
+    tcg_gen_gvec_3_ool(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(1, a->vn),
+                       vfp_reg_offset(1, a->vm),
+                       opr_sz, opr_sz, 0, fn_gvec);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 993bead82ff..7d3aea8c98a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7048,14 +7048,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     bool is_long = false, q = extract32(insn, 6, 1);
     bool ptr_is_env = false;
 
-    if ((insn & 0xfeb00f00) == 0xfc200d00) {
-        /* V[US]DOT -- 1111 1100 0.10 .... .... 1101 .Q.U .... */
-        bool u = extract32(insn, 4, 1);
-        if (!dc_isar_feature(aa32_dp, s)) {
-            return 1;
-        }
-        fn_gvec = u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b;
-    } else if ((insn & 0xff300f10) == 0xfc200810) {
+    if ((insn & 0xff300f10) == 0xfc200810) {
         /* VFM[AS]L -- 1111 1100 S.10 .... .... 1000 .Q.1 .... */
         int is_s = extract32(insn, 23, 1);
         if (!dc_isar_feature(aa32_fhm, s)) {
-- 
2.20.1


