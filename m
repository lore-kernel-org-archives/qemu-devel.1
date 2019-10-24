Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336BCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1860205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGNv6wHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1860205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgRJ-0003n2-NU
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxw-0007do-E2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxu-0000rY-CE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:00 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxu-0000rM-63
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id 6so2365001wmf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hoD3aqwz/kF2U/X48pwyEPkA/UK/DENbEy2Cn4bAuH4=;
 b=GGNv6wHwfTL1QGLGhWzRJa+KjstPTyhmRqBkFGLxoGio2SZHiN+Ztf4zEC30C4/opi
 XguljHlgb6lOVuAbcNAlVhrx+kSzMwAQZSW7epW7HYOzZ9WwUnDSlxuCxKFlLjF/262V
 9qnL579UohCTn2F0xQ/SHaDgOt5B6VxpnKHwSTIkd5C0jh6WMezd0HTiHHht0D5pF1JV
 BstneN31cXQliFkknfvmuoeBeSp31nwo7u2j0B7GQbynyhGqTrkwkkRw/wrnaLnA0Yor
 XBqSZnblJQNPnJiod6g7UcUIcuKmJ8ZNSfnYkP8DRnbG/uJ5dPHYWK0+rMC0JPelaCU8
 B+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hoD3aqwz/kF2U/X48pwyEPkA/UK/DENbEy2Cn4bAuH4=;
 b=spCCN0zFHiN1W+fjTcvYD+/Rx+FRy24c4knoZEWRHX+Hohg7adxwVb0PtlYPADPevL
 tzSp+0tOtgX5ELVlelgp1FkUTrMc79t7deL+5kqsYGQJFIoDA+gAEd7sFNr4+z65F0Ie
 hO0hAMKnPVivHaoZWB9QgjRO4QOO06N6q0Mq2PIeXAx4FfmvMjEzJKwF7/CfoS3d5CoI
 ARyeEM8IFHo3lBpzzewoEQLlgfz+/6S+LMKEf3s5C1qzmIjWdutcUAyKsUMorZb9jl9l
 5jfSaBXhb+Lj74FY/Oun0KPyQLkVYf+rlyvPWgtgHjJtmVc69LGbPGR/oQu6sewqQAXj
 vidA==
X-Gm-Message-State: APjAAAWp18pNk594J1rKDEmb4XFkhbZR9yZvHrNPPkgThI0SV5ZX/SC2
 PJCHBpKLFuTdArfGls7Tj/ak+zEeMKo=
X-Google-Smtp-Source: APXvYqxbUr4ZBsvf/NW23DQ44ke+h+5zFD+f+JK5Bn7KuztJ6w/jzLbaYVgbvzcRBiw7yywIih5vuQ==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr5626959wmc.121.1571934477039; 
 Thu, 24 Oct 2019 09:27:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/51] linux-user/aarch64: Rebuild hflags for
 TARGET_WORDS_BIGENDIAN
Date: Thu, 24 Oct 2019 17:26:57 +0100
Message-Id: <20191024162724.31675-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-23-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 1295fa85313..31c845a70d4 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -173,6 +173,7 @@ void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
     for (i = 1; i < 4; ++i) {
         env->cp15.sctlr_el[i] |= SCTLR_EE;
     }
+    arm_rebuild_hflags(env);
 #endif
 
     if (cpu_isar_feature(aa64_pauth, cpu)) {
-- 
2.20.1


