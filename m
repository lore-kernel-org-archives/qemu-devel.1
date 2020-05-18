Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94275C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EF62075F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWPufKfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EF62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jam6w-00085n-38
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5o-0006GR-K7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:32 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:33747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jam5n-0002HA-P4
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:10:32 -0400
Received: by mail-lf1-x142.google.com with SMTP id z22so9237799lfd.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JGfw2GTf7AKSuMq7zTbg0UDU4aheCMwNjjypN/fhxrQ=;
 b=fWPufKfDJ3XVw2N2M4OV3fHdQczwI5OqDEiguZsNOdX3Ox5Z3xu+2bm/1+PE77y/DG
 d7e42utYVeQpkNHIUxngbKYbi4LR+KqdVj1ibVjNVWLo4RP96TkQm/PN4Bkg4fKV0V9q
 XSoRwmubSSfxJwNJBPuSbQzmh/GsSO5OlIt21kYgV2ICyDhKdGdlXJ7vQEtYH9m0613l
 TrxCVIeDnLy3cRCY7ON4/CXCqEVGkQp/VnfKNSYVr6gQwIyL39wmBh1JOL4gT6YcSclV
 OXgb+0apnNQY40EDVHbBYwhx5rGP+eMfHyHLuzABK6Cbem7LhIntLrSf5+FUJvqq7lpQ
 FA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JGfw2GTf7AKSuMq7zTbg0UDU4aheCMwNjjypN/fhxrQ=;
 b=GfRkYQvqVh04OeLwjfXlxcZtk6khxJ79T4vGwkoyVpGme5gYjwV6wBdow8Z/CBuTaI
 g3xK06+eWYT/YZTshHpxP4BENHYTsT/HVMLtnDia8evxRnKgK6d0OlsCwbg97UEB7aR2
 bzcUreXa2t1Zd89TfB0Nju+nE84xN5V+sJdnK0uTcyBEA5i8LQ0V9tHtq6i/Bdmkd2Ek
 P43ej1y9DwWZb9wBzEjIc18ZTjl7otm7XZSBCa5FlvTXCKuZXtt2nIR+KJKZ+AHKUnwL
 SzO3bSN3Fy+HFyVEBAa2MxwzaBfyPzvh2OGqlbJjFd0BUmWDRTLm+wFOd4PY99nBaNCP
 vuNQ==
X-Gm-Message-State: AOAM530VimXPsmvXelXfAASjmt+mGCkY/w7ynfS7BHToymEL/2w1Mc5s
 M+dlut8ss6nGu/SFAf/KAym3bGI9/hM=
X-Google-Smtp-Source: ABdhPJxVHG2OOrwxUAVPvt/fxXpGINVtYeE4IyJBk/4RKE04FL4LNpg8/QSS8E9CHB5CJRsHv3DJmA==
X-Received: by 2002:ac2:560f:: with SMTP id v15mr7667385lfd.160.1589832630040; 
 Mon, 18 May 2020 13:10:30 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id c78sm8700591lfd.63.2020.05.18.13.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 13:10:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 06/21] target/mips: fpu: Demacro MADD.<D|S|PS>
Date: Mon, 18 May 2020 22:09:05 +0200
Message-Id: <20200518200920.17344-7-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index a3a39681f8..c070081cbc 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1495,12 +1495,51 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
     update_fcr31(env, GETPC());                                      \
     return ((uint64_t)fsth0 << 32) | fst0;                           \
 }
-FLOAT_FMA(madd, 0)
 FLOAT_FMA(msub, float_muladd_negate_c)
 FLOAT_FMA(nmadd, float_muladd_negate_result)
 FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
 
+uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
+                             uint64_t fst1, uint64_t fst2)
+{
+    fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint32_t helper_float_madd_s(CPUMIPSState *env, uint32_t fst0,
+                             uint32_t fst1, uint32_t fst2)
+{
+    fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint64_t helper_float_madd_ps(CPUMIPSState *env, uint64_t fdt0,
+                              uint64_t fdt1, uint64_t fdt2)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fsth2 = fdt2 >> 32;
+
+    fstl0 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
+    fstl0 = float32_add(fstl0, fstl2, &env->active_fpu.fp_status);
+    fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    fsth0 = float32_add(fsth0, fsth2, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth0 << 32) | fstl0;
+}
+
+
 #define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
 uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
                                          uint ## bits ## _t fs,         \
-- 
2.20.1


