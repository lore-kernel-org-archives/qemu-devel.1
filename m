Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB6C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFAC20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M19aeNKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFAC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmx2-0005Q9-Qn
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmno-0001Zu-5K
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnm-0003hv-Eg
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so6609849wrq.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ixr+1nbJukvy2COfOoRzV+WTmXwjG84YPtvZ7E/7AI0=;
 b=M19aeNKO/uroBwIY39BuP9GQV3DwHoBEGX5ArebTHGgr/T8YMKFeo0ucZNeWD6t90x
 XfEkqsX2JQSXJXM3ZyVwT/PfHnPzoxS8p83DmnXm/Bpw+6L0ce+nmQEVgfgaUvtE7pLF
 0nOyLDp2JALNrbkBsgCybprMRrurcCyskwGA2yEy3Hw+VXoZUCHZ0C5dIfByeg7Vek6N
 o0Neb4k9MA9d4vM+FsrMjLlW3Mj6LnQVGGW3n5Ao9fQYd2DwN4cfPmMgcVZGvUvDgbdn
 k850hMGSZuA+2CCxzMRMi1rZJy9qNfhsliZK6lvGjSupQ64K6u5DjdxK2dtPSWNNAxSK
 GrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ixr+1nbJukvy2COfOoRzV+WTmXwjG84YPtvZ7E/7AI0=;
 b=CxsUHpyFVNFcfDwxT+Z6to0BDPyPohuIobp5f5YEGzPxGnsYpN0nM/ClmzGixHlMa2
 pdsuPPFZDpQhS014P8rIN3eOXXreZECZ9/5hRzvMObdhVONPy1OiHo5jduQyZMSA4VEs
 Gy/DVS8fLcnab6jMvHWfkNilQ5sPsjJAVimjgdwrw2TWpiHCR8hlPKlcHZ6Iy6BmjoOY
 xGUuO59d26AXDKIJku7pYnp89nQrWfwR6r84ToBfIsk1EBbJy0R6XWOPtfaancG1pP3C
 2gheiE741mSExdLKX16NY5ufVxkYIpSjQ8IqZyVyK4GAofRPtgJwoczOHPlP8zr3ZfoV
 jUjQ==
X-Gm-Message-State: AOAM533nHe5howhMjEa6fbGvMvOPMQAIC9QurpeGakO/6LZ3RJqwmiVH
 O+clPZUGUrRUc+Allfp8TJrcsCoLTVg=
X-Google-Smtp-Source: ABdhPJwehpEamaBiHfGnLBIyOv5QOZYErEvZXca3Ijw6DyX132g7ZsetO2VcUjfx2+LfLh4UF02mpA==
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr10331941wrg.298.1602943394108; 
 Sat, 17 Oct 2020 07:03:14 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id h16sm9232144wre.87.2020.10.17.07.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/44] target/mips: Demacro helpers for M<ADD|SUB>F.<D|S>
Date: Sat, 17 Oct 2020 16:02:05 +0200
Message-Id: <20201017140243.1078718-7-f4bug@amsat.org>
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
Message-Id: <1602103041-32017-3-git-send-email-aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/fpu_helper.c | 63 +++++++++++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index f851723f22d..b3c715494a9 100644
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
2.26.2


