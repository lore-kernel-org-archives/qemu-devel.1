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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A02DC2D0FC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB6DB206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4id1/Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6DB206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYp7l-0002Ry-Uz
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp1A-00006x-BY
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:40 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:32836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYp19-0000P7-Fq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 06:53:40 -0400
Received: by mail-lj1-x242.google.com with SMTP id w10so6530500ljo.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=h4id1/OeVI6MNgDuoP0u5zvDzcV3T+mq2+rogs4EwZbPpqZ6QSkH3sVywgBVRJrc85
 hAXEV1HcxEQkcJMxooCmiYpfQcDLVS3GJyKYbIAo+PtYmGluT1P/NiUG48z1MGT3Z2GR
 IiLS9Lo/kwYg6jH2rAakMGLAGvTboT8+zNdCaRYwm9mlJnWgdLpMHM0jhtp4kUywFXr7
 Lq+7O4WGvgXAscc39Lirr+lZUjAUUNqSZdf+xKAIegUoaUk9CxseFkiEz5sm19iwla3U
 L2TzIq6KDC4CSxxiBOuGYndNP7Z4IcGkxykKUuRaax/3J+DDvy7x+dQV5DqqsqeLdvbV
 pc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=VGCG2PNpXQm7tuxC66ZsNf9Aiu7WNTwrQQkWuM2Ksm0oZzpUjy595i8QViDfsdsb1I
 DbePSMLVLHc72dgzbXWeXqu3UCmV54O/YFwi0J0GUx2HNhkMXam6X5iVmElinM6VfS+l
 aZwsGoXVM1MuT8v/e2fZOa/NspOjT5az/1eJ0vbMz0sj3otHuyCcirCp4IW7UOo1dxY+
 BTcZywKBtQb07JaY18T/6oQJRjTw9jz3OP394f168erpr4pJDyJGDuHad+RsiobaTkZX
 RzBCySc9HrV9YoQdwlX2hZXtnCQqJ/8HpejymYGZteSobAQDrSHWgijoCIM0+JHteL03
 4vOw==
X-Gm-Message-State: AOAM5314tVURdbi6GUyHwZuZ5Ljx7yV+Jv5IyEhbvYs85XgIo+ZnCjDD
 58i97hhOZaliLWRcM8qRHKBgJ2eNjYo=
X-Google-Smtp-Source: ABdhPJzV80kCxw0TzEYpfN5ZOI7yUzzWB8b1PbvzT/N4F487bFCDN6nVwi1yBQcIzMGe5338XUxbpg==
X-Received: by 2002:a05:651c:549:: with SMTP id
 q9mr17221874ljp.236.1589367217751; 
 Wed, 13 May 2020 03:53:37 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id z64sm15749417lfa.50.2020.05.13.03.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 03:53:36 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] target/mips: fpu: Remove now unused macro FLOAT_BINOP
Date: Wed, 13 May 2020 12:53:00 +0200
Message-Id: <20200513105307.22638-6-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
References: <20200513105307.22638-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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


