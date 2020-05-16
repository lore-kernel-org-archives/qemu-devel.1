Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D74EC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E219206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1LxGlMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E219206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja13f-0004Oa-Iu
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0te-0003b4-Ok
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:50 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0td-0008SF-S4
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:50 -0400
Received: by mail-lj1-x243.google.com with SMTP id e25so5570851ljg.5
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bFeqPWm2QsPGoTt7fEQgUrf7uzCq2N6hwh31edqpp1E=;
 b=X1LxGlMjyO6sEyhdw6SIS8Zm+yQlYqxpOXPwlQWh5Q4oiELu00S8cKbjTkLI0n7ZdB
 K3v8XSqBBRsdT/gVGKpJcurqJEDBOWpEqipmR9jXEdg7lh17TiipiEU/ftLcuz18b7x6
 iDXscfk4BzYhkx1ghOl2R+sxnLjYcAQBvbGDzGUlcYKvT7mwyHl50Y2jYG3Qb49zj4cC
 f+88CxsEn8Uyh4ZNIlpj+bYXBlPA09ha0hp2XgetjhOmnHKjwPW8dz99vndfiOKoScBw
 PABKY7Nha2x0L0eF4xTjm9XyoKAXNx4Nwo0M7T5pBgI7HwqCi0ou7PH8yrXnpINw+3BS
 05YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bFeqPWm2QsPGoTt7fEQgUrf7uzCq2N6hwh31edqpp1E=;
 b=H6kv+M8TgR4pNPRQGWWKQVZcaisoVN3h3fYyUIQ51gaAUut+RRZY6gIMBNAUsfInya
 2ONZlXU34wDGFXbzi77b7q02PVm6olcz6qf2hOVzg5bOqA/YbxrvKOM1M4cjvIKJoM7/
 JsOQEPajtBqswviLGzPx0gpf/Bby7WGM7WeRl/QWlm9iUXoa2WcQYbXwfQTYdnxVw18R
 dY2K7jYgUR/q6kXLrWEhEoXbiEZByJ4aDFC0o6T6S2Chadh62tVC0wUZ0owalmZs6IpI
 kBCHm3JdoTJGV4owvlgy/idFKOGyx/WOk02vWfezHNLY5RgClzcsViYezm+BzVo1D1fF
 /tsQ==
X-Gm-Message-State: AOAM531tfl6WT+eRXfiDdDzhDAuWHEMtlzAKRnjkGYMDS4zmKVIBN+4W
 2u2nSJB9vT7pUlIkSfGJsYgsw5BCVhc=
X-Google-Smtp-Source: ABdhPJxslnjkthASH1+w0PhYVQGnKVrNUy9pDhb1S39TGxdiE04emVBs73mWzuddP9rbS40LnUr3KQ==
X-Received: by 2002:a2e:8807:: with SMTP id x7mr5711113ljh.173.1589651208280; 
 Sat, 16 May 2020 10:46:48 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:47 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/18] target/mips: fpu: Name better paired-single variables
Date: Sat, 16 May 2020 19:45:45 +0200
Message-Id: <20200516174548.7631-16-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x243.google.com
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

Use consistently 'l' and 'h' for low and high halves.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56ba49104e..dbb8ca5692 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1059,14 +1059,14 @@ uint32_t helper_float_recip1_s(CPUMIPSState *env, uint32_t fst0)
 
 uint64_t helper_float_recip1_ps(CPUMIPSState *env, uint64_t fdt0)
 {
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
-                       &env->active_fpu.fp_status);
+    fstl2 = float32_div(float32_one, fdt0 & 0XFFFFFFFF,
+                        &env->active_fpu.fp_status);
     fsth2 = float32_div(float32_one, fdt0 >> 32, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rsqrt1_d(CPUMIPSState *env, uint64_t fdt0)
@@ -1091,15 +1091,15 @@ uint32_t helper_float_rsqrt1_s(CPUMIPSState *env, uint32_t fst0)
 
 uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
 {
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
+    fstl2 = float32_sqrt(fdt0 & 0XFFFFFFFF, &env->active_fpu.fp_status);
     fsth2 = float32_sqrt(fdt0 >> 32, &env->active_fpu.fp_status);
-    fst2 = float32_div(float32_one, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_div(float32_one, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_div(float32_one, fsth2, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
@@ -1367,19 +1367,19 @@ uint32_t helper_float_recip2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 
 uint64_t helper_float_recip2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
     uint32_t fsth2 = fdt2 >> 32;
 
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_sub(fst2, float32_one,
+    fstl2 = float32_chs(float32_sub(fstl2, float32_one,
                                        &env->active_fpu.fp_status));
     fsth2 = float32_chs(float32_sub(fsth2, float32_one,
                                        &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_rsqrt2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
@@ -1404,51 +1404,51 @@ uint32_t helper_float_rsqrt2_s(CPUMIPSState *env, uint32_t fst0, uint32_t fst2)
 
 uint64_t helper_float_rsqrt2_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst2 = fdt2 & 0XFFFFFFFF;
+    uint32_t fstl2 = fdt2 & 0XFFFFFFFF;
     uint32_t fsth2 = fdt2 >> 32;
 
-    fst2 = float32_mul(fst0, fst2, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fstl2, &env->active_fpu.fp_status);
     fsth2 = float32_mul(fsth0, fsth2, &env->active_fpu.fp_status);
-    fst2 = float32_sub(fst2, float32_one, &env->active_fpu.fp_status);
+    fstl2 = float32_sub(fstl2, float32_one, &env->active_fpu.fp_status);
     fsth2 = float32_sub(fsth2, float32_one, &env->active_fpu.fp_status);
-    fst2 = float32_chs(float32_div(fst2, FLOAT_TWO32,
+    fstl2 = float32_chs(float32_div(fstl2, FLOAT_TWO32,
                                        &env->active_fpu.fp_status));
     fsth2 = float32_chs(float32_div(fsth2, FLOAT_TWO32,
                                        &env->active_fpu.fp_status));
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_addr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
     uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_add(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_add(fst1, fsth1, &env->active_fpu.fp_status);
+    fstl2 = float32_add(fstl0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_add(fstl1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
 {
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
     uint32_t fsth0 = fdt0 >> 32;
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
     uint32_t fsth1 = fdt1 >> 32;
-    uint32_t fst2;
+    uint32_t fstl2;
     uint32_t fsth2;
 
-    fst2 = float32_mul(fst0, fsth0, &env->active_fpu.fp_status);
-    fsth2 = float32_mul(fst1, fsth1, &env->active_fpu.fp_status);
+    fstl2 = float32_mul(fstl0, fsth0, &env->active_fpu.fp_status);
+    fsth2 = float32_mul(fstl1, fsth1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
-    return ((uint64_t)fsth2 << 32) | fst2;
+    return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
 #define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-- 
2.20.1


