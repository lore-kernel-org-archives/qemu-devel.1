Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78003C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39A120643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tl9Hi6mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39A120643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJYB-0003V1-TU
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ2-0007EH-8b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:23 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ0-0007NB-AM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:21 -0400
Received: by mail-lf1-x144.google.com with SMTP id r17so3609535lff.9
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aVn12E0T5JzktEFTA5pyhzwavRrRDjMRjIN9w81ZdKk=;
 b=tl9Hi6mf778TAqeSsdAKXYNamu1nAC8Kn1C2pUFnQKEYM4czS4B6GBFruUUMYEBhPu
 pv5/ZwUXx7256KRB0XJSLF1MNCRVogjXWIOKr0eC9hb/Z3MCs5Xk9KUVn731+QnlnAuk
 VMztOjNw6T7Ip4Idw9QXOM8VmddDpcCZhBcWdSFZ5m+nRpMQX0vJ3rnp7FToXlBi5gBr
 IAATqfvHZCrwoAh8AbngeUcVo8XIuIhaqKG0PIQG2Rk+Peh19zIuzz2glchHnnj+QHUV
 eGofILOyp3zhvitUWCa5K/oCJ4Ifpf8pvJF5hChS6cPlLT5Ma3Tn0tmlSE2tsOomy9wi
 VzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aVn12E0T5JzktEFTA5pyhzwavRrRDjMRjIN9w81ZdKk=;
 b=loYPUMNXApYe32lJzL+uSwl+PrSEG1oDk7AGtrx5OS9suwpySijcNoAezfpynTQSSV
 lsDjCOS05zZ+BnMnB956bSKSEWCE/Ku1GRdH6mgyOsKHuyav0845deatwQ1XoBTaCE1C
 qR68yZ6euBFKc+La/Rxm1vAwo3fgy8RCgteQa44FxHsKR4vvEqaRpkrIDeJk0w/9j7Ol
 KjvEFKUf5rfuR0oT9OyPEYsACxH22nnFXXxePTP2uPemNHc5GkbLpDVFVnL3/1fovZIL
 QIcdctwVbHHhLJAbU/1UiNY9xyFCUJAj8hr9q9HQfx3eOJ10CvrhB8gtf5hRwU9nDSwE
 E0EA==
X-Gm-Message-State: AOAM531p1Q4a8YIXWSvDVARXOZ/hrMRQcJRh+HqWEp+2Vhrjtde+CgEw
 WR2ab9zXI4iNOukGmquQdh7kppvfck0=
X-Google-Smtp-Source: ABdhPJznrysVB5Lyi0EJfBrlaUeLP9zyvkL0QMJFD23trgqzn8V6829fJSnhRTwWCaseYCj1qK2/KA==
X-Received: by 2002:ac2:4c14:: with SMTP id t20mr4316979lfq.24.1589484078554; 
 Thu, 14 May 2020 12:21:18 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:18 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/17] target/mips: fpu: Demacro NMADD.<D|S|PS>
Date: Thu, 14 May 2020 21:20:38 +0200
Message-Id: <20200514192047.5297-9-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e37fc4075d..d4c065f281 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1495,7 +1495,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,             \
     update_fcr31(env, GETPC());                                      \
     return ((uint64_t)fsth0 << 32) | fst0;                           \
 }
-FLOAT_FMA(nmadd, float_muladd_negate_result)
 FLOAT_FMA(nmsub, float_muladd_negate_result | float_muladd_negate_c)
 #undef FLOAT_FMA
 
@@ -1577,6 +1576,49 @@ uint64_t helper_float_msub_ps(CPUMIPSState *env, uint64_t fdt0,
     return ((uint64_t)fsth0 << 32) | fstl0;
 }
 
+uint64_t helper_float_nmadd_d(CPUMIPSState *env, uint64_t fst0,
+                             uint64_t fst1, uint64_t fst2)
+{
+    fst0 = float64_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float64_add(fst0, fst2, &env->active_fpu.fp_status);
+    fst0 = float64_chs(fst0);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint32_t helper_float_nmadd_s(CPUMIPSState *env, uint32_t fst0,
+                             uint32_t fst1, uint32_t fst2)
+{
+    fst0 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    fst0 = float32_add(fst0, fst2, &env->active_fpu.fp_status);
+    fst0 = float32_chs(fst0);
+
+    update_fcr31(env, GETPC());
+    return fst0;
+}
+
+uint64_t helper_float_nmadd_ps(CPUMIPSState *env, uint64_t fdt0,
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
+    fstl0 = float32_chs(fstl0);
+    fsth0 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    fsth0 = float32_add(fsth0, fsth2, &env->active_fpu.fp_status);
+    fsth0 = float32_chs(fsth0);
+
+    update_fcr31(env, GETPC());
+    return ((uint64_t)fsth0 << 32) | fstl0;
+}
+
 
 #define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
 uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-- 
2.20.1


