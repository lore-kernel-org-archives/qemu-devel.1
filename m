Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FBC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F378C20671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m11vrFTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F378C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja0wg-0000WW-7N
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tS-00031S-OJ
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tR-0008Mw-VX
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:38 -0400
Received: by mail-lf1-x142.google.com with SMTP id a9so4491356lfb.8
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NfiyJnH8f+NZGQdRmwsMGxjYlt1H1kJMr2qydSKKkTI=;
 b=m11vrFTyF3Rag2/bhIJJDa/sH3MTxr1GdspRCvcwYOzxNKR7hTiaqGhR5fxXpaasZl
 87ommVzeC0cuVEKj0/JiEbftDaMnj/dLFT54EvXp+9k8aq5bjIHfaraP5dNg4wFal0Mv
 YUuBELopYP71ebAun0Mygvj2LDTnIdmHC2ct6V1/MdFsfRhYlZeEzbE7Kwlzco9bO1PB
 Kx58bBObtTPvl0P+7L5/tE25baxHq90Gpdz1ICq6mOOK9CW22yIMS+RjPSLydzCjUyZJ
 4b1/7Ii+yAsIeyQTFfgToVFHphcRIZQC4qfqddtusMCQRWucMhNcJ0C0Ow0zFap49rLC
 A5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NfiyJnH8f+NZGQdRmwsMGxjYlt1H1kJMr2qydSKKkTI=;
 b=AwrJtkhAvEPCIo0VpIlT+9mIPArc7LlspboKdmEIOpNUAy/sCUCL4mGXRX4PxRzn/y
 bB70jiTf6lty2PKE7y8rLw/WNKDyvDFa7mOSgvqsN5c6SkWm0IebQJ1Wo1JhWbtwplEq
 Imao+yQzwySNDJXXQKv+8pBa/hif0O8hrcVYRtxMB8L8SRTTUs4Luo76HWdQHH/LT/Od
 SCzJ+1+QmEJQRKXAlXFtHDGrM77yW+3qK8ZITsame64G8CWCf9KRTfYc+cyJRexGAzXX
 x0vhv83dAd9jAEY3ODzb8G2dC/PoINyui5fqvZm+m9IZGxxDzhKUjTbiQXHujkqNnz0g
 6I6A==
X-Gm-Message-State: AOAM531p0hc7NzeIx9NCklWNNTs3VbW/69tQ8jjtsplwFbLNTnJjtMQO
 lHOuA9RIGngCYKmQWr7GzdUyqgjZv9w=
X-Google-Smtp-Source: ABdhPJwM0D4XgQAIzDj8YF1W5yvIeu1yFAR2MKnW/Ix7lF384+TbGRcqNDF1T/FHrnqryd2zBBSXCA==
X-Received: by 2002:a19:70d:: with SMTP id 13mr6242954lfh.60.1589651196347;
 Sat, 16 May 2020 10:46:36 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:35 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/18] target/mips: fpu: Demacro MADD.<D|S|PS>
Date: Sat, 16 May 2020 19:45:36 +0200
Message-Id: <20200516174548.7631-7-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
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


