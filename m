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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3666C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9262B20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StbEnki/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9262B20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJTp-0004WV-PD
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPs-0006wB-Lb
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:12 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPr-0007LP-Ts
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:12 -0400
Received: by mail-lf1-x142.google.com with SMTP id d22so3598752lfm.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hp/YCDbUF4k/Qi0Hzps0dHG39YUDYzBviudtOCIRUBo=;
 b=StbEnki/2GOjq9nvsS7cq8wXZziZKJAUoxrvnctGAUpz4kooTNrVcQnoTwh24C2mND
 eSmhZMyyzGtBLvjDhikGrTwShGwrdRakYT7KZQtdcxp4wJlAgZ7wQ/4km0Xi2V/UNjl9
 axFJzp3hCGGLBFOKAUaoFVvueEJ6qGpxaOLuajSX3dGi+HhncuMcVxbZghJExBdOX335
 DJ/yv5Qc5YRv3mqX5LL0Kgz89CS3OuW33j+0JtcTgTVA/UY5o+QclaW1PFCd6mfEuB70
 qBVpgJoRiH4ohD3H9F0iFYaoNdJavpzZ50G9mWlO2zNeeXG48MNtU0F9KYi/XDtda0YS
 NK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hp/YCDbUF4k/Qi0Hzps0dHG39YUDYzBviudtOCIRUBo=;
 b=KOHqVvmConNHjP5Ny7J1jRuOvc/xU6Mgep1jH2nJEhuUG3FkPSIS/4JyyfZdBfIs0j
 rmTiNEW64snvQ25e/D6zXpM+Zi+ya/h6RHhszv1u1uJpYafu2i84sgYbenbrO5tcISQP
 7YNkEUeHyvKmLX8E1eDuzV8xP8XKJTXmv08SLADqQndU+5R8L7dT1VFt+GSjUqIGtvCB
 XT1LLoai/wbQGxXqWGLeSOpAAaMMCOrmZbCxV/7nMNsJL/2pf+3Jqrmr0q4JKoFuDLTv
 QBP3Kb9fGQKCmTg4W7Fk8pQAViRnT1JjcPhSeszpw5gpA9C0zci5ckgIkbS02Fqqh7vt
 iImw==
X-Gm-Message-State: AOAM531Wkpf3kHfWYRPBCtOqoCMxWlVlk2Kxylp3U/4+bzey3xBbJ+hd
 cTLnN3HjLRTLfXDXXpmi/+0Dsk2NN4c=
X-Google-Smtp-Source: ABdhPJxs3LXUiiooKtP6ioasHI83qU9QfpuymqOZGzNBtBQ6AMWHUyZTtujDL1qya0JAOgjWD5H7Yg==
X-Received: by 2002:ac2:5f5b:: with SMTP id 27mr4229075lfz.120.1589484070143; 
 Thu, 14 May 2020 12:21:10 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:09 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/17] target/mips: fpu: Demacro MUL.<D|S|PS>
Date: Thu, 14 May 2020 21:20:33 +0200
Message-Id: <20200514192047.5297-4-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
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
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 715a872cae..449e945166 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
@@ -1284,6 +1283,42 @@ uint64_t helper_float_sub_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_mul_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_mul(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_mul_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_mul_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


