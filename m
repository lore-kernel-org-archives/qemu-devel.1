Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35212C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F22072C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhacguUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F22072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmpl-0003OF-RR
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnp-0001bB-Ob
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmno-0003iD-2V
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id y12so6582632wrp.6
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jY48quu39mm1u3JApFpvCc/7FiIrv2aGLcqgOkgLbGg=;
 b=ZhacguUpP+Nx8LAhX7k4GOyeVU4RU3lQ4DpqaohGGxPTRjqvnywlFeTfUud251GiUg
 UUeCvUUADvFXv6m4r030MdBCpFLQrMN41LS4nsSdMuQYoQqZ8FAGvwPO0HKr2u7W8xg4
 0mjLATh0HZais2oek2s0uQSzZihCdrnlNrfYqmhPzXZfwZ5lMFP41VyTCxhMhJ4ZYEAU
 orc83nkMKa53fXVCJn6rtvULFRwSyDqJ0tKv2i3CBLdGD+JieBx+89w6Nn4wB++k1xPL
 UZ0CrwZw71YoLk+S+VQ+Nc9VoOjLF8rKjQ3w801+HvD4GTcDa18ADFEGsv7nnUoqLX+V
 GL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jY48quu39mm1u3JApFpvCc/7FiIrv2aGLcqgOkgLbGg=;
 b=KTCRC/CIqgv2XspWh+vj5YmsZOaUbgqkz9KHhUAz7ReZIg/OMPA6g2xahvYOvfg0ke
 xsXZRlRGgqZbYGjWQwFrtzEJ0xC0bTxyb1TsQxER7i+t9hxrAydQZ3ch0rcECLUbfxFs
 oaO+5ok7bD9Xt9cvHXlDuwJ+KBIlaHwZXdLpnuNMT/zyiLAMUlAnIVw+Ch+0G0wIjz94
 nyMLO9wEZdmMRAvpp3EuPeu3xwslU087axafSmma2vkqWbnod6qZaVhigux7vso7qyIZ
 OYfNit1rdAeRiqLL/Osuvx4NUTV8HB9gCKajxoVc/qXoWq7ZUwMy1QmZSRPitTQZQTwZ
 004Q==
X-Gm-Message-State: AOAM532tft7bhLW4zbwvwIIi7rwfrJihj5kbMp/fZckJs64UzFdh6fQJ
 6nZaieQxO1o8Ck+gLEw0iRlyfu/EG8E=
X-Google-Smtp-Source: ABdhPJyWM6lOpe7Rz+5/BmKrWycAGw2EpLvtnXuipQQ1Q5omcXSMgSKqDrsmby2/qnj7jcrs8kH7Bw==
X-Received: by 2002:adf:e881:: with SMTP id d1mr10234268wrm.395.1602943398662; 
 Sat, 17 Oct 2020 07:03:18 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id s1sm7324631wmh.22.2020.10.17.07.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/44] target/mips: Demacro helpers for
 <MAX|MAXA|MIN|MINA>.<D|S>
Date: Sat, 17 Oct 2020 16:02:06 +0200
Message-Id: <20201017140243.1078718-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1602103041-32017-4-git-send-email-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/fpu_helper.c | 98 ++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 20 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index b3c715494a9..6cc956c023d 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1475,29 +1475,87 @@ uint64_t helper_float_mulr_ps(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt1)
     return ((uint64_t)fsth2 << 32) | fstl2;
 }
 
-#define FLOAT_MINMAX(name, bits, minmaxfunc)                            \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _ ## minmaxfunc(fs, ft,                    \
-                                           &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
+
+uint32_t helper_float_max_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
 }
 
-FLOAT_MINMAX(max_s, 32, maxnum)
-FLOAT_MINMAX(max_d, 64, maxnum)
-FLOAT_MINMAX(maxa_s, 32, maxnummag)
-FLOAT_MINMAX(maxa_d, 64, maxnummag)
+uint64_t helper_float_max_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_maxa_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_maxa_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_maxnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_min_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_min_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnum(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_mina_s(CPUMIPSState *env, uint32_t fs, uint32_t ft)
+{
+    uint32_t fdret;
+
+    fdret = float32_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_mina_d(CPUMIPSState *env, uint64_t fs, uint64_t ft)
+{
+    uint64_t fdret;
+
+    fdret = float64_minnummag(fs, ft, &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
 
-FLOAT_MINMAX(min_s, 32, minnum)
-FLOAT_MINMAX(min_d, 64, minnum)
-FLOAT_MINMAX(mina_s, 32, minnummag)
-FLOAT_MINMAX(mina_d, 64, minnummag)
-#undef FLOAT_MINMAX
 
 /* ternary operations */
 
-- 
2.26.2


