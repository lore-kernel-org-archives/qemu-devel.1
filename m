Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91320C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED8520737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grq8xbAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED8520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihL5-0007ls-FJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7K-00065L-5B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:40896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7J-00018Q-7A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id h5so22030649wrc.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qhXQDfigvQAa5am0DFMzGb3Q9KjScPlDz0AhwwxSsDE=;
 b=Grq8xbAlQmRzrxdYNVlLC79CJ2QymURg/GDDKKUi/Hhf+P18DPsdrUXvjx2DhlIJ69
 MrmaPtAXgNc2VEdw/v2N2fwfCLj/FsrcnBr3QQBRPVsniWtrIP96/tnCKWv0zMShysuX
 FErWDZqgujf97bEaHNlY1zxAfnyIvozd5evo/ccx4DR/ECCpnlqUofxJayEFkS41BslT
 rLJdad1tQxODvTO8lltzh7AnbgccaBwVvOPXIzhEZgQ+qbyrRA3rzrZWe9ZDmRzqLZ/V
 VTPz69ON/zN7HUxlC89noIzr/5NX0PVkubDZ861NuPVT8Vp/D72QuZkahhgD0F01SFH4
 gYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qhXQDfigvQAa5am0DFMzGb3Q9KjScPlDz0AhwwxSsDE=;
 b=fjsGerFw6JYVHNL2eY74x25fTMJcZnuls9l/YkSEn7nSjm1vhhfEAZTFM2fJLVNkB2
 UotEICGrs7VOB/sb2vO3adDafNJJBgsuK9ituFZnniYAUxP17xFJ9VtsiFTXzVdGegH1
 yjs1RuRBgVZqVGxaexAhNBioQcxlRogegwax3YrZ0EzU39q+qgWh1FgEtJptjmmPuKEd
 DckU4CrE8eya+Nbp4PoUvFIVZnH7OM52NI45An8FUxSzoj6YyL7PQigVJWGfEPcpAoV+
 AnpNmUyzKB+VhkPO9aLn9NlHzVIGPy7+EGuDCuJRLUCIpaw9nuuvLwDkgB8s+MsKzkPk
 nY5g==
X-Gm-Message-State: AOAM533IMmaejPkO5XpbyNau0Id/7sam72DrB3FGsR5/Q5K7l58CP6Nj
 j9A08nwZHr23lasJ/30gbFYVZ27m
X-Google-Smtp-Source: ABdhPJz9KDTGMVDqSFcwK4O0ysmRZ2fIwcUOsb7gVcYez9abpOGHn8DdNQjR/3YRlISpBba2L0CiyA==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr5314151wrm.262.1591720127725; 
 Tue, 09 Jun 2020 09:28:47 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:47 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 11/20] target/mips: fpu: Demacro NMSUB.<D|S|PS>
Date: Tue,  9 Jun 2020 18:28:29 +0200
Message-Id: <1591720118-7378-12-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-10-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index d4c065f..927bac2 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1495,7 +1495,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
     update_fcr31(env, GETPC());                                      \
     return ((uint64_t)fsth0 << 32) | fst0;                           \
 }
-FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
 
 uint64_t helper_float_madd_d(CPUMIPSState *env, uint64_t fst0,
@@ -1619,6 +1618,49 @@ uint64_t helper_float_nmadd_ps(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
+uint64_t helper_float_nmsub_d(CPUMIPSState *env, uint64_t fst0,
+                             uint64_t fst1, uint64_t fst2)
+{
+    fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float64_sub(fst0, fst2, &env->active_fpu.fp_status);
+    fst0 = float64_chs(fst0);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint32_t helper_float_nmsub_s(CPUMIPSState *env, uint32_t fst0,
+                             uint32_t fst1, uint32_t fst2)
+{
+    fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float32_sub(fst0, fst2, &env->active_fpu.fp_status);
+    fst0 = float32_chs(fst0);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint64_t helper_float_nmsub_ps(CPUMIPSState *env, uint64_t fdt0,
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
+    fstl0 = float32_sub(fstl0, fstl2, &env->active_fpu.fp_status);
+    fstl0 = float32_chs(fstl0);
+    fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    fsth0 = float32_sub(fsth0, fsth2, &env->active_fpu.fp_status);
+    fsth0 = float32_chs(fsth0);
+
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth0 << 32) | fstl0;
+}
+
 
 #define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
 uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-- 
2.7.4


