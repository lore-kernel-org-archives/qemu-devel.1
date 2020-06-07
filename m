Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D2C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613AA2073B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoRxhKj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613AA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1KO-0000m8-Io
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FZ-0003rL-W6
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FZ-0004lS-2t
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id j10so15151079wrw.8
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bNpt1BpofhtYBwm3Tfw6OCLr57L4XWG7RV5bc+pnr5I=;
 b=WoRxhKj1la6EmuJFDiP6QGW2iMPzSVMizSWYO+nfCLTkAQo7npK56Th8mAwpGzJ0ga
 iE4CJfYRo7fKuKCqutvJw7MBkVu0ai8uOrkd/H46rhKgFfo2RgRuXklc6u1uge2Z7ki8
 6i3JhjlPQQ4POsBxbBezmaVcsiNAwcmnr/rS0AP9KSYBxYRHVI7Elj0h91ydzrhQ+H85
 YSKIqLN8WAX04Vrk7ObPCAIdTBPzJcJf1bLU0G/DGHmNd3iGsGJxtN9Fx18IwmPxhHt4
 9ktGTuYtDkHX6W2PXOMLSavZ+gpkRHGuQivFhTv/wAguiwpQmkfv2n7+acBVTfgctw/3
 pZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bNpt1BpofhtYBwm3Tfw6OCLr57L4XWG7RV5bc+pnr5I=;
 b=d4kgnJRa6FRq32UNsFiqpZVtfSV82C+HYjuTqbxls1oyDDzMzrtUx3SGTM/IZtO0ID
 tuJqbwxXhW79YkkQQGf88txLOOaLQTkao+kqAgLkzYrYqwq4kVwsgo828bODfwrqwimB
 PD9H2Ch/RpKOue1ZFoGfNprvI3YYiwg1H/xyT3ChbeV94N0hkbQ7i0jl9wFULlxfn1Go
 Mo8718UfH4R7pr0yEO9w7yXz6CkcUpT8nqPjMJBSR/Geu8piY7rk+Lfl4PdyL0nbEdM5
 U6p7XIZP56C+HP09nhYcoSKPamrg7RVagCLzD0bFKWUwExjvgOSWIpZuLd/Qr6zzaNnP
 i3Vw==
X-Gm-Message-State: AOAM532UUp6YltkXb7x8u+BG1QTvBcK89jAD9zEZdcYevQtno9V+LmMj
 olj3k4EGVTBTyxkinWnHX3PWfmz3
X-Google-Smtp-Source: ABdhPJzIJrx72CLYkKoN0W2xflJi4fHhFMU7O8pZnDFAbY8XGcS3oxUf2qdFIIK7SlFptHNJWNCKXA==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr19485005wrs.209.1591559191620; 
 Sun, 07 Jun 2020 12:46:31 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:31 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 07/21] target/mips: fpu: Remove now unused macro FLOAT_BINOP
Date: Sun,  7 Jun 2020 21:46:11 +0200
Message-Id: <1591559185-31287-8-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42e.google.com
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

After demacroing <ADD|SUB|MUL|DIV>.<D|S|PS>, this macro is not
needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-6-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 2759c99..a3a3968 100644
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
2.7.4


