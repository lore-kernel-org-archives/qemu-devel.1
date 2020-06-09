Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D442CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F10320737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teVwhhcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F10320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihPx-0006hx-SN
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7N-0006CP-Fv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:53 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jih7M-000191-Lc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:28:53 -0400
Received: by mail-wr1-x431.google.com with SMTP id t18so22032738wru.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=JJdgGNmD+Xij1ICoEW9/1LslSZLxJsuLiu6yxyxEF/g=;
 b=teVwhhcT6SPy5MWelRl0HJ89uw6BuDYqzI5x/yc7s4sNc1jRsO9XXIVa6gWRDfSTql
 adOAF9Wp3M25dwiSr/SOgLj9VJ+o0fwoISY93OlWvtfawWoZ2ODW7Ry2nciMWyXsx45B
 JNuiMplLzzXod4pyh7So7AWalmwYL6ipRHAiq1IrLtWuqbmSljVKe+AADgpvhc0vIHht
 5vKU0aljQp2JbFcLJNuUL7XpyxwkZxD5Hn2VNEfOvBblGvnE9XB5wdApgebDKug4Q+ME
 zXNgcCrfX4ZqCHiaIi3yxFGUNuWJzjtdUKVLfH9Bb/m9SiTzKGChuLfndMq29qxtD/6E
 btTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=JJdgGNmD+Xij1ICoEW9/1LslSZLxJsuLiu6yxyxEF/g=;
 b=JcqVSQNEnvwmLSrzhbmUB2EkwjSwReZfxQViYKn/LSyjhTXgLX2jYtSkbsnY2IBo7D
 ou9X3hWM2waDaE+nSt9bfo2rD9WN2Pvo9hB3qMWp9bvf1FFJ7nEMAftRkZay21oNmlAE
 vtV2or+kcDDtQKxSYr7UlS5QxULA3vRPOHo1u4XtKWJW4KtX+K3esi6liWsrLj7vpyvN
 FKmdJj33bGjTL6q5pZdvUjtvJyHP72QKuqGJhBRZ00H0omtZWbtr3OQzTWwsxHXwQbFU
 ZlEyai6VY36vCdf3zeMnZ/YXm1kJ72rhs704DUpjaEi2wiFJizwCqCIipJTNjutw9wQT
 Wa2A==
X-Gm-Message-State: AOAM533GVJ0uR5/iUsQ+lWyipZ7/kkdV7Ck4xcoTHbFLsPE7MGAPlTvO
 R0VFamQP5TZwdC4BNSiGmio7cNyU
X-Google-Smtp-Source: ABdhPJw/eCqPIyFq7u6VFY+r7QtUPluE24wCua/J87yYwHX4NoIHbHJ1piWNpLzryn7bPA0c/cd0mA==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr5335643wrt.193.1591720131314; 
 Tue, 09 Jun 2020 09:28:51 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 23sm3643598wmo.18.2020.06.09.09.28.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jun 2020 09:28:50 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 16/20] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Tue,  9 Jun 2020 18:28:34 +0200
Message-Id: <1591720118-7378-17-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x431.google.com
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

After demacroing RINT.<D|S>, this macro is not needed anymore.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-15-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331..56ba491 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.7.4


