Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B93EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA42217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eUVM8nN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA42217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqG7-00021R-NQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqi-0005b1-WF
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-00078J-Nj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqe-0006qu-4Q
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so3355670wrs.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8XTuXWq+xToiDvDobeS2vNcXere9quLdtk1afgwMbsw=;
 b=eUVM8nN6O/n9aKdS3bQfPIk2EUYVBkSwKKk+0eUD9ncmNkyjrkOl9EqQkQdvQcNika
 h4wZCvr0t20q9czaW07g3V7pE4zajKot9qW3N5J7oJBlWo0fWdz3sNe4EzGlCvr7rQa9
 2qn8BmW79OrGf0NKnGKeYzSuVFM0BJSbrrZKm4fuLD2a28t5D8dxSA7k3MjOPj/uNIrq
 x4lY14vVitaFllD4HyhrFQW7I+uJPo7PjY7hcJJ++jedSMj67CWWbHj/ajKcDt69RSSQ
 IvEtWK7FqhawC/2LdSWBr2iiXY+MypOUCYfGMBWo+Z91ozh2XouWt+kQOcfmkOpR27yG
 ALyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8XTuXWq+xToiDvDobeS2vNcXere9quLdtk1afgwMbsw=;
 b=dsWKwQQpym+QwKTCCq3KH+jaCcaMwUB/Et7nBUzfYtUTJOPwLCc4inNsNGfuEZZw+O
 QXRnbBqHjZTeVp0HXp2rDMK5yY9yvbiBAT3YHKf/d+oo+Fu49PwSQR6tW/19tO128XOq
 AyyQIKHU0u2KiBNgeP7q3Slgc/nbClO662lSGmoFIxmZ/6kUuMtYPLBu4rQblhzlf5z0
 uvlwDt37+KVhY5ywAknYaVEXlvbPZQHd5MWltN1bK0/Kh+hchYlXNaoVg3bMbgcgd21R
 Zes5miJHWUKIPJxJ4lPzXd0BleEomGTjxrxLxf143jPx8/vdjcmSpSugna8WrWLS1z6C
 lWkg==
X-Gm-Message-State: APjAAAXPKs750O+xGluvx1Kv3pljrry+YPhlAxmgXlsfhFsUKwCIgAP3
 KUq3tRhSQTGfOGwFpRmQY+A/q7ppNdo=
X-Google-Smtp-Source: APXvYqxQnb+GMlSOfJaxv7q8G0FO0bNsheabfgos+iNcRgSwxgtwQD3J6/3B5Kr+Kd+sRTBlP7sHsw==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr43467409wrw.345.1560532718017; 
 Fri, 14 Jun 2019 10:18:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x11sm5694362wmg.23.2019.06.14.10.18.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:33 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02CBF1FF8F;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:38 +0100
Message-Id: <20190614171200.21078-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v3 28/50] target/sh4: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

There is a small wrinkle with the gUSA instruction. The translator
effectively treats a (known) gUSA sequence as a single instruction.
For the purposes of the plugin we end up with a long multi-instruction
qemu_plugin_insn.

If the known sequence isn't detected we shall never run this
translation anyway.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5a7d8c4535..922785e225 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1917,7 +1917,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 
     /* Read all of the insns for the region.  */
     for (i = 0; i < max_insns; ++i) {
-        insns[i] = cpu_lduw_code(env, pc + i * 2);
+        insns[i] = translator_lduw(env, pc + i * 2);
     }
 
     ld_adr = ld_dst = ld_mop = -1;
@@ -2332,7 +2332,7 @@ static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 #endif
 
-    ctx->opcode = cpu_lduw_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_lduw(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next += 2;
 }
-- 
2.20.1


