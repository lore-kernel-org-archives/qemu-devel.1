Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD37C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DAB22224
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Cfg6aZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DAB22224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFd1q-0005cf-Ov
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczF-00022w-T2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:37 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1kFczC-0001Kz-76
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:44:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id c8so15835457edv.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rV7pkNnDVb3Fup7JTagH3DCirUP2eQXNJHpnCF2Ra8o=;
 b=j/Cfg6aZoeKaHhPoybZFxbOzBFlIxBQMzg/XoY3Ay7W1G8j8lYOZyP9Q5z9v9Fzaek
 OQg0HHlU+tQc/PsjHWeRJUdCi2JsZey/GpFZiMewpfcgDW/CgKAIke2pg6bmcqmsFqEK
 cB+152BaztCFu50wmg19WY99/D1z5W8YokjuCwHCZxWJsj/8oxHptjQhMHtuUWfRQCAO
 0vx+aDwkqptk6OIIoR/96PS3Coz5Y/ASt2IDNIwxxVQV5TAZfhk6q1k6lqy07H2JPVYi
 6BsCmQK4W7fAbJRzTYraVeNlYPj6jr44ec82fLArii1ljPtN88Dcv5212Zi8wd2ZcYNx
 Ousw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rV7pkNnDVb3Fup7JTagH3DCirUP2eQXNJHpnCF2Ra8o=;
 b=hWHrZhzoQ96EvTQGwNwd/MGqGMJJNgJMzyU5hHsyhyJrOowLtInGyNhvm2VzurU28s
 EEjkc0JWr+lvF3ykDHqxqNfWL/h9hr7VrnBg48YnFrO2oAVss53kAgK392BCwIMtuBH8
 bgpA1kKi/XBon43ypO7E5azO4SnI6iHm0BUfQuzS+no/CFsVN9MhWI4QTYWez65ZGXMK
 WxvgKazDpdpdY6j58H6FzCmcx0iA9/iu2AZ4VgVitY57kLQRhp9SbuY54j6j5Odu/tNr
 EAAlB2lSZqZosykTAX9vXVlv4bqnBDjKztBoJeQRr39Ou2JFQNuAZXNdU8dsgeC5g5OR
 PvnQ==
X-Gm-Message-State: AOAM533+x4N6YDi2ogdz5/V55PbUP+9+t4ZzsZIlYrzxVS5j8+it/H6D
 Vb1V+BFzbDluZn71yl0zCJjcfw3P1mc=
X-Google-Smtp-Source: ABdhPJywMA03Ckn8idHv0ZeQi3Gc4qKc4kGsScIsmlheuI6UyT0ieIjZFdmPmiullCWJsWn/JHR4yA==
X-Received: by 2002:aa7:dcd9:: with SMTP id w25mr25601345edu.280.1599569072810; 
 Tue, 08 Sep 2020 05:44:32 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u23sm4396604ejc.108.2020.09.08.05.44.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Sep 2020 05:44:32 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
Date: Tue,  8 Sep 2020 14:44:26 +0200
Message-Id: <1599569068-9855-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1599569068-9855-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove function definitions via macros to achieve better code clarity.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 63 +++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index f89213947f..98313951cb 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1666,25 +1666,54 @@ uint64_t helper_float_nmsub_ps(CPUMIPSState *env, uint64_t fdt0,
 }
 
 
-#define FLOAT_FMADDSUB(name, bits, muladd_arg)                          \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,             \
-                                         uint ## bits ## _t fs,         \
-                                         uint ## bits ## _t ft,         \
-                                         uint ## bits ## _t fd)         \
-{                                                                       \
-    uint ## bits ## _t fdret;                                           \
-                                                                        \
-    fdret = float ## bits ## _muladd(fs, ft, fd, muladd_arg,            \
-                                     &env->active_fpu.fp_status);       \
-    update_fcr31(env, GETPC());                                         \
-    return fdret;                                                       \
+uint32_t helper_float_maddf_s(CPUMIPSState *env, uint32_t fs,
+                              uint32_t ft, uint32_t fd)
+{
+    uint32_t fdret;
+
+    fdret = float32_muladd(fs, ft, fd, 0,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_maddf_d(CPUMIPSState *env, uint64_t fs,
+                              uint64_t ft, uint64_t fd)
+{
+    uint64_t fdret;
+
+    fdret = float64_muladd(fs, ft, fd, 0,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_msubf_s(CPUMIPSState *env, uint32_t fs,
+                              uint32_t ft, uint32_t fd)
+{
+    uint32_t fdret;
+
+    fdret = float32_muladd(fs, ft, fd, float_muladd_negate_product,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint64_t helper_float_msubf_d(CPUMIPSState *env, uint64_t fs,
+                              uint64_t ft, uint64_t fd)
+{
+    uint64_t fdret;
+
+    fdret = float64_muladd(fs, ft, fd, float_muladd_negate_product,
+                           &env->active_fpu.fp_status);
+
+    update_fcr31(env, GETPC());
+    return fdret;
 }
 
-FLOAT_FMADDSUB(maddf_s, 32, 0)
-FLOAT_FMADDSUB(maddf_d, 64, 0)
-FLOAT_FMADDSUB(msubf_s, 32, float_muladd_negate_product)
-FLOAT_FMADDSUB(msubf_d, 64, float_muladd_negate_product)
-#undef FLOAT_FMADDSUB
 
 /* compare operations */
 #define FOP_COND_D(op, cond)                                   \
-- 
2.20.1


