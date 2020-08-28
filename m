Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6928C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762132075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxubAn0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762132075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjNr-0004EE-HI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCo-0002lY-TX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCl-00061Q-4V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id t14so114789wmi.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=X35NeqBctB9mslvjbHDeW7p7u1Isiz5hswfcsubx4hw=;
 b=SxubAn0tbMmA12D/zBBdAmu9w7RlgU52vVlzcNRfnIDs9WtNjzh5wX+LKzfe743KkE
 EB5emIOOGzgl48MHyIAfRhaTz+kLXD70MA89FrOJX4uO3KhKzYPt5MNu0pCQumdRE4H0
 g0Ix0yNLa6GyG00X9GcGMPX5+1qAiEEldnVuRY/dc0vVi0URikF9x0RfWGwliHgDqYgy
 F0TTxrHfCP8aqbJYKn7Px4WSEKYyG224Rlw+rpKo6pvxLzdyKyI5iUrlwETsxmokdeHQ
 2lyyJqhJJVepC62QwjfvrqZxIuFDJWGgn0UsB/6wmM9iB9vBX/X8VHK1k7LGFoh0CuN6
 Ezjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X35NeqBctB9mslvjbHDeW7p7u1Isiz5hswfcsubx4hw=;
 b=Av8h1Fp87prmWjphxjKjGi3840vun4tkI2Hf529r3ZYN6unua/hudS2sUbWVkcUWA+
 2HLHS55UDXvbX9heOZ78zWhY+swKvhsr9Uqun+CK1Qg4lN25QSxvi0gShqQ8p/kpynlG
 H5sTbTgi6pUd+liOik2+LjIM1VtFhGGQb6F9TQdKDtwMD/ERzhXNneD+pXM5fh4Sa3+i
 bhGFWFihucTBeY+hCR4cSvvQDBFSeaKxtJ+J+qDlae8qOkPnqiWJOC/stn4KjUFAdBfp
 vNfnYUGh/NJafBpMPALIwnGK6kzdPJJQMTNLn0C4Ls/O5mpFVwUMtL62u7vmg0oavX2Z
 pDaA==
X-Gm-Message-State: AOAM533PQJy+3wilOSlfDCodWh6AAJxezW/vjDCRC91NS9HxzbDvnBt0
 VqMIU2ceNHMjCYTOyqNzeAUSIw==
X-Google-Smtp-Source: ABdhPJwni1cj4H+rqAEyat8m7Yi4D5+2E8M7g3pvbhkw6+TP5xqIdJqrYqyYkEb8HzynlHb835h5ww==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr41505wmg.92.1598639665695;
 Fri, 28 Aug 2020 11:34:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 24/45] target/arm: Implement fp16 for Neon VRECPE,
 VRSQRTE using gvec
Date: Fri, 28 Aug 2020 19:33:33 +0100
Message-Id: <20200828183354.27913-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

We already have gvec helpers for floating point VRECPE and
VRQSRTE, so convert the Neon decoder to use them and
add the fp16 support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.c.inc | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 9d0959517fa..872f093a1fc 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3857,13 +3857,38 @@ static bool do_2misc_fp(DisasContext *s, arg_2misc *a,
         return do_2misc_fp(s, a, FUNC);                         \
     }
 
-DO_2MISC_FP(VRECPE_F, gen_helper_recpe_f32)
-DO_2MISC_FP(VRSQRTE_F, gen_helper_rsqrte_f32)
 DO_2MISC_FP(VCVT_FS, gen_helper_vfp_sitos)
 DO_2MISC_FP(VCVT_FU, gen_helper_vfp_uitos)
 DO_2MISC_FP(VCVT_SF, gen_helper_vfp_tosizs)
 DO_2MISC_FP(VCVT_UF, gen_helper_vfp_touizs)
 
+#define DO_2MISC_FP_VEC(INSN, HFUNC, SFUNC)                             \
+    static void gen_##INSN(unsigned vece, uint32_t rd_ofs,              \
+                           uint32_t rm_ofs,                             \
+                           uint32_t oprsz, uint32_t maxsz)              \
+    {                                                                   \
+        static gen_helper_gvec_2_ptr * const fns[4] = {                 \
+            NULL, HFUNC, SFUNC, NULL,                                   \
+        };                                                              \
+        TCGv_ptr fpst;                                                  \
+        fpst = fpstatus_ptr(vece == 1 ? FPST_STD_F16 : FPST_STD);       \
+        tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, oprsz, maxsz, 0,       \
+                           fns[vece]);                                  \
+        tcg_temp_free_ptr(fpst);                                        \
+    }                                                                   \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)             \
+    {                                                                   \
+        if (a->size == 0 ||                                             \
+            (a->size == 1 && !dc_isar_feature(aa32_fp16_arith, s)))     \
+        {                                                               \
+            return false;                                               \
+        }                                                               \
+        return do_2misc_vec(s, a, gen_##INSN);                          \
+    }
+
+DO_2MISC_FP_VEC(VRECPE_F, gen_helper_gvec_frecpe_h, gen_helper_gvec_frecpe_s)
+DO_2MISC_FP_VEC(VRSQRTE_F, gen_helper_gvec_frsqrte_h, gen_helper_gvec_frsqrte_s)
+
 static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
 {
     if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
-- 
2.20.1


