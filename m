Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A9CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEF820659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUX+xMb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEF820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp9w-00059l-1a
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp1G-0000L3-U9
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:46 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp1G-0000Pm-2f
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:46 -0400
Received: by mail-lf1-x142.google.com with SMTP id a4so13216011lfh.12
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=meiIJB+AmHAaVbmDxwspWHGXDAbXPn2CTH6+8Q6LmGo=;
 b=UUX+xMb+WjTpq2rox4Uwhqj0wU/+TPER4WkU94BFtnKaTtjIhYY4aULHOPJA4jhgRi
 AM+Fk49MPW4QgTagWVrMo3o1rruOvm7uSAvpwoYPhvNwxlGkKFq4rGbNpTLKw/f5p/zK
 0d5ZPm08+3XJeVwDCDZTji1yTH5omV6H6sI8hkXoie+KL2lScoZx+86/+FZPxxAQMlv9
 BWIaanBgtY8yKnV9yRF1bvyoWFup+zY0mlmija+o8hExxUB0IOUDcdbR73phAKdSnmF3
 KklY+1ozNoE7VDiYFt9AcdOyk7u7OalpG/qq5YIWRH0t0xfmaUY5n3rvEn+IAi27PxC1
 YhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=meiIJB+AmHAaVbmDxwspWHGXDAbXPn2CTH6+8Q6LmGo=;
 b=VV/MtEoToe8HLvYbMTFNBOpGJoj0cyZyoRHsRH2neOBX0CX9bg0noMC/DtcIEH0APy
 ylUrj4LimjmMHrzIkzp2vUAwUT9Jo+nfKPE1SUAyf3ExU5OYDoVsfPQYl7jpMW4CzQRZ
 0S70x7iMrwYls7CbGM9QHQXYqPbBUFNUq0/NYNl4YbNbQDATVPzYvPUhk2kJSY4Qa+hQ
 meaBIVg4i6tPwa/Ywy3XKjht2NW+mYhA1Ju7ajYxQCgZ9GPqJBp/6t/IEyLcEGZOj+Fc
 Wq3JqKZ0aodPxEmi0RFudctx6A6xGi3a8f5NiG3C1xriiAkVfY3/6KoJ8/S17mI3SBaO
 LX7w==
X-Gm-Message-State: AOAM533qpKhCAAmCQ9ze9IY1oSHbCrtGbKjTFLrUzzd7NxQ94cPqNrD2
 SRHuFdNBqWVMfzRw67Ahz6H2+ELYCqw=
X-Google-Smtp-Source: ABdhPJzAa8g8580Ui7AYC23aEZ/m8ItTMGapRtIfbTQkBAmzNEdIvLSmN9zxdOtdnaNsDBgcp4Dp6A==
X-Received: by 2002:a19:7004:: with SMTP id h4mr16561533lfc.148.1589367224331; 
 Wed, 13 May 2020 03:53:44 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id z64sm15749417lfa.50.2020.05.13.03.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:53:43 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] target/mips: fpu: Demacro NMSUB.<D|S|PS>
Date: Wed, 13 May 2020 12:53:04 +0200
Message-Id: <20200513105307.22638-10-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
References: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
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
 target/mips/fpu_helper.c | 44 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index d4c065f281..927bac24ac 100644
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
2.20.1


