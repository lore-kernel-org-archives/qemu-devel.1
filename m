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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB358C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFF220643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AegdSD6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF220643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJVY-0007j3-ML
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPv-00074j-Rm
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:15 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPv-0007M2-1q
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id u6so4788461ljl.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=AegdSD6h4NHebCXtKoA+IMWpxgEo1qYpUJ13fWkHVWcGU85VufLxXMembIhBqNDqdS
 LsIUjkNWcvgxUXMuygzqEM7pCOyDNECtoFuNGoiukNtkmyQM5WMChNKcdc42GC4K9m/G
 fj1xjuAbcIYI8O2izvsAAFKDOxkTFAKF35gtK6haRURIRmfLZe4z+IhqJAEsxtsWqckk
 L3QV9VoQKNeuG/xhnqblJjg6fxwZQRoX4mF1Dz6nGk1M4P0a9u6x/VCtabRozZb6+PCP
 b6UyQKRkPU4rYRT3TKTSu9ZKK0vhiyOvDpX6wPCAJamvJKyy60B6OXtY0AmcEA+xrCPo
 +Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=f9qENzTabckxcl/lGsFADX9Sf/LEmIHmwzDCrcCGVWtMqBq5fTvawkLLNJwyXJBbSz
 3bf/MPN3YWCjtr3fG040R7CdJhcLIpM8bKaE4GjTlzydvCV+rTFEbgvgDxj+gbM3/s8A
 XqDhgCOz46hH4tGMCGK4ITXfbKH9iWIp1wetp+FvJ1Ek+tURn+GiFz3HjtY3fldTqmxD
 8CAd3+4yt06SBuV7Tiyjf21heHDV4uSXgFIM+PAMAcvUoaAFum4HDA2/qZ3pM279iBoR
 gMTEipO1gnz9245BCSkMBArj2RwNfETsgW2gEG/0xQUBCuqQni5m6MlCmRSxkK+NHGDx
 TTxA==
X-Gm-Message-State: AOAM531Mm3zcygjCrS2ngMzPrTyDYWKU8PFsq7seauvG8QZ55xr8jUya
 PuUMafG3ZUlrRAA7KhFRBn8Ey09eApQ=
X-Google-Smtp-Source: ABdhPJyVnWuXKVNWBjRRQymv3C54oHI5bvG25DbaVOh+sqrhdJ4ssAxC0WrIrG3hrGfP8laDModdog==
X-Received: by 2002:a2e:a209:: with SMTP id h9mr3974986ljm.39.1589484073289;
 Thu, 14 May 2020 12:21:13 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:12 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/17] target/mips: fpu: Remove now unused macro FLOAT_BINOP
Date: Thu, 14 May 2020 21:20:35 +0200
Message-Id: <20200514192047.5297-6-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x244.google.com
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

After demacroing <ADD|SUB|MUL|DIV>.<D|S|PS>, this macro is not
needed anymore.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 2759c9989d..a3a39681f8 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1170,45 +1170,6 @@ FLOAT_CLASS(class_d, 64)
 #undef FLOAT_CLASS
 
 /* binary operations */
-#define FLOAT_BINOP(name)                                          \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
-                                     uint64_t fdt0, uint64_t fdt1) \
-{                                                                  \
-    uint64_t dt2;                                                  \
-                                                                   \
-    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return dt2;                                                    \
-}                                                                  \
-                                                                   \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
-                                     uint32_t fst0, uint32_t fst1) \
-{                                                                  \
-    uint32_t wt2;                                                  \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return wt2;                                                    \
-}                                                                  \
-                                                                   \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
-                                      uint64_t fdt0,               \
-                                      uint64_t fdt1)               \
-{                                                                  \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                             \
-    uint32_t fsth0 = fdt0 >> 32;                                   \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                             \
-    uint32_t fsth1 = fdt1 >> 32;                                   \
-    uint32_t wt2;                                                  \
-    uint32_t wth2;                                                 \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
-    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
-    update_fcr31(env, GETPC());                                    \
-    return ((uint64_t)wth2 << 32) | wt2;                           \
-}
-
-#undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
                             uint64_t fdt0, uint64_t fdt1)
-- 
2.20.1


