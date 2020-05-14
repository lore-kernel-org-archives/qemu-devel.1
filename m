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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0564120643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFBtdEK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0564120643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJVx-0008Na-VO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPv-000740-KV
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:15 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJPt-0007Lj-By
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:15 -0400
Received: by mail-lf1-x142.google.com with SMTP id h26so3618084lfg.6
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=LFBtdEK10x1I7wKjZUxVKEioIqNKv4qGNNxAbxVeCpy88BQEfiObYBQKD0g7c251gF
 LvalcRQJvCogsJz2O+vf9pvPj6dgPvB+YZeNkCik8dELOONbwqzby061MQGtx1A6yJir
 caPijIEw4kDgaNHDpbIG2370E5sJhgVl5Q4BF9mm8699Y7/wZ5ufhUx1LbN/5fgu/BLl
 LSWQpxZ9JvAo+n4/0Khdqe9o45nj3I68hSy9k327taxwVGQ9G48XongSxmrPDKqGDETJ
 LoRAVVhBnN9uRR2Aj4A9RHQW9xarq190l4W5jVYlKXTxp/OWscb7RX8jbUfWoGpA3vWp
 o/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u+u2GTLpTwv9NrMPHkakKvWn/ABYNzXl/Rjh49VH7qg=;
 b=Jtz/wnvoN5BEYo1jHZoO5PfSR99ampMboPicdc5KGiDKPWdLipoqwFH3zhZLtIcxT6
 c//2YndsWJNGcWAc5sLX6xXzVPTtFh/vvQMCdK0OdlJkMxwzFrpbDfcc5hx815uAr8aT
 yWoA10CUAUhnz2R2Gs4cVzJyuX5pprOgdwnczuVnvzbuui5TCA/GKKfaBFlx/CLpLPIS
 eIO1y5F1f/ta/yaDPV6aILK9xanwh+SLiN6fvzQjumG8pXv16FzCEXpIKUsltdl+aAHt
 ml9ndaqW9aYcWQxCsApXAK7rbGXtkw9dlVvzBptLLW+xATFTagXO0y19UxeCtLhvvTvk
 lxUw==
X-Gm-Message-State: AOAM531aBG3JuWjI5JbDYGwpQMvLu9uafoh9nnQf2KED0Zhl22IcxPas
 4jW7vkL+SXC30+VBH/Gn4p5MxcM6Hb8=
X-Google-Smtp-Source: ABdhPJwnlB5dSQue6ZSsDWDxd+vtaRzZ7RfeKd43RHJlohRR0Tv5foxBtkSzdenfFe0iKNg6Q0uFYg==
X-Received: by 2002:a19:f00b:: with SMTP id p11mr4319044lfc.210.1589484071662; 
 Thu, 14 May 2020 12:21:11 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:11 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/17] target/mips: fpu: Demacro DIV.<D|S|PS>
Date: Thu, 14 May 2020 21:20:34 +0200
Message-Id: <20200514192047.5297-5-aleksandar.qemu.devel@gmail.com>
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
index 449e945166..2759c9989d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
@@ -1319,6 +1318,42 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_div_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_div(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_div_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_div(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_div_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_div(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_div(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


