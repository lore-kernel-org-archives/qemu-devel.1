Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC3DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623DA207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am0GqQmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623DA207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalfh-00041z-HM
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleO-0002LT-Rb
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:12 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaleO-0004QA-64
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:12 -0400
Received: by mail-lj1-x241.google.com with SMTP id g4so11170935ljl.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1AhGV+7mJrEa1yiq1Vvf+5dR9caCzTZ1pKzOlNaVE4o=;
 b=Am0GqQmiXWNN6juOUAlsKg6wkFIX/Cz8yyQC7zcsM7jJGkQjCdFp6dsac/7k2RqVu2
 fRP/UspaQLjeG1P47MiUgeT8DVIoh1S/2FrDF44HJJFXQ94610EK02qqix8l2s0v3t7f
 V4v64Qa6Y8uTHfx7pizDbOQjWbnDBfu20idOio5/S845/9igR0pJxJvTvIJQW9VfTuRm
 aGnNJyrqtrmEjCYx2sob5WutIiRx1Iq1slTn0JON1SvtYnMKx9c9iELdZMaQB51EFJQq
 5vOxknPAVnRAVTUDi+BMnvwfl8IRZ2PM601K+urgadYnF3hH3fHXQ7T4GqyT6S8/fqxT
 e5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1AhGV+7mJrEa1yiq1Vvf+5dR9caCzTZ1pKzOlNaVE4o=;
 b=Rt9NMbl5Bya9GZ3zH6DsT2MN4LsnWnHZkxQdv5mxfL1z4eLhdiBFivfY6wJP63ElIr
 oPhafC/1zWmGY1Mc+28VyJ/8bLbotfd4tONEcYcde5RD3K2smt45x071PvX7dSmxBhv/
 88swG8EoakLQihSSlzq+Op/lJF04H4dHgff2U2y90ZngpFQgGEZ/naPPrk8st2ZrSoN3
 Q61n2XfibpyycoVrcbb0TwGO0rOGzJmBJWrygOTTgNbwa6rapnLnQT7ChC2pOyzsieKz
 qAs3hRRWDc/Bg5SYUIZk/6IR/ltQDD/K7UJin4ZBpZ65cKKFLWAenBDm0LhkVD6PJnyV
 70Qw==
X-Gm-Message-State: AOAM533azGuRg2CuO+17xi16v8HHPZhg2JNAXTOg8KvOrXVrixmlyNTe
 SBRPscuswh2wu1g9N3JU3rtCR5eg5GQ=
X-Google-Smtp-Source: ABdhPJyUkkyqYn96t1hEHYf1CjK1UdA9UoqE2ohJT/0/TaprfcIGshgdpgB2WViB3rXqVDy8vWBp2Q==
X-Received: by 2002:a2e:980d:: with SMTP id a13mr11500891ljj.277.1589830930075; 
 Mon, 18 May 2020 12:42:10 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:09 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/22] target/mips: fpu: Demacro ADD.<D|S|PS>
Date: Mon, 18 May 2020 21:41:29 +0200
Message-Id: <20200518194149.16281-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 5287c86c61..984f3f4dfb 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,12 +1208,48 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(add)
 FLOAT_BINOP(sub)
 FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
+uint64_t helper_float_add_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_add(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_add_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_add_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_add(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_add(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
+
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
 {
-- 
2.20.1


