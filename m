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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155AFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC87E20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsT/y826"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC87E20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihSU-00022s-R4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7S-0006MJ-7h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:46213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7N-00019D-Ox
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id x6so21962091wrm.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VcvK8/pVmCVF8v3SRJSD6aLnpQpjp2swimadybR8LKc=;
 b=tsT/y8263qvR9zeJXXMOEbeyy+DHY2dL316zbmbZu/rfSJrQrYxR3iQWcOhRup+MdI
 nmFkeIPW5m/SAXUwsyHlapTDvW8KeUd51Rmrk1uichmqhfbOQZwFdupBqyq3ikFJVIxN
 150qZP8hjfYwQ1XPlIr8dxTYeyQNNLBPXgF2zbqhJRHuh+Y8ZRn3u7ln2iyuF2+S4hf/
 QCeQk5hbsxuWFMk99rjlk/7pyQH7esUALXrgXVmuIZeeIH1L9gm9dNH1kG7bM509BidA
 6nDJE1uckuiiUL+rDlkJ7YFesikO83F9qgGxFZ7U8jZfwp+e3m8XpTxYrfAGBULIxFw1
 Q0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VcvK8/pVmCVF8v3SRJSD6aLnpQpjp2swimadybR8LKc=;
 b=iOrgRZcURvpwcSJhggkAtZRWhgU5fXxYS0Y3UOkQ+GENZo4DrJBHDgiCv47vorCThA
 /3jOcqMCeZ9Sqka2Nd2ij15q6bhQZYaEsYyzyOWZHMssZQ4/7BgA47zUcWDmVfHT1MUq
 o85SPZrcoXnwwpoPg9Th9IaH9n5CBcIWNC6Wgf+zRWJgzMo/jz/4ACiZVazA5ViYKoM/
 nFHgibqCSS0b7B/PJeBbIIyDvuI6HySg5rxkJnplptnzeAaxQLRE7JI2pJWBktaGND1E
 AikQo5a/PEyN9VHtE7rCciwuCBOhhcQGvOz7gR1meHYrW3HZMY8d1npI7NrjROTvLS+K
 i89A==
X-Gm-Message-State: AOAM532K0DltArf/A0D8j8GgFJhx1NXxE14Y+BB0wnJ/eig2+BhK5T41
 S/kuq9EvyeUU+8OXKU5xNW0Phg6x
X-Google-Smtp-Source: ABdhPJyxvtjrAK1orfFXBo+ot+2tekyBVN+k+jZbS4E+m7Xxv14PmpYWb1I34XetemFfo2KI/xhNFQ==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr5553653wrp.398.1591720132190; 
 Tue, 09 Jun 2020 09:28:52 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:51 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 17/20] target/mips: fpu: Name better paired-single variables
Date: Tue,  9 Jun 2020 18:28:35 +0200
Message-Id: <1591720118-7378-18-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01,
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

Use consistently 'l' and 'h' for low and high halves.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-16-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 62 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56ba491..dbb8ca5 100644
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
2.7.4


