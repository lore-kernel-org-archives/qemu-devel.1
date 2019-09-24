Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429B6C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A72020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4GaNm6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A72020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrz6-0004pD-93
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvy-0002XF-Ut
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrvw-0004TD-2i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38055)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvq-0004Ru-6Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so3630374wrx.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/xkUA4er3qxVvIJWrvA6CYF5PpbAnHAJvGVcHOa9aSM=;
 b=c4GaNm6tcl2yLcAnJxhd2m1u+F8q148fzdagCmY0QNv4feVIUw9QcEBpUrSAHA6hsU
 0afwlRrj/xlKo+23JzAo04SGeSz/yS1j8EVeqTmM2L0HF8itXCAVS4Qx4Q6UE1w3zzf3
 TEmgi+pXzreq0B4QKI8ZxCkOLZC3n/g7Rrh8nkAukEQJst80z5wtkiLm+EcNlUwLz3vw
 wPygkyjxBUWoJoxlYeHZbt2DUdJaBxLn5q1nRyrdiiXbPP1/eYeFpSOejQ/hEu2en3AQ
 sQAJWEgiLWHC09L4n2LARNCuMHu+m1Zp78Xoec3KgKGcxmAb0LFKzjrzdjAZCnyZjy3Z
 StZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/xkUA4er3qxVvIJWrvA6CYF5PpbAnHAJvGVcHOa9aSM=;
 b=VqOnPTxdqyRaudarkM0ELWc+LlAMY4mhoCYm6bsZ84DXXktKmRDoGABnhEbsrhZBWj
 0cM+w8m1h5NdED8tW6hv4xAIgc9F6LwRwuJjVt5K3XH/QeWjVxfBe9PmvTCnU6bNVyhp
 3eicuFVL43lsLXaGjZK/thmcoXg36ayGOgC0hVT80aEuNcKjrxUQgYhwCMGhgCP5zGAu
 ruIDlVMuE9mfDdW6PdLikG8GMcUlfB0ckr+uVdXLlwaqnOu0bWV/RULLCvnhuZPLgJFZ
 4DK57wNpTeWusvKOLMA9bJ0J7030TAk9S2aN04tLJ3v+KHMi+cKnd9D5t7sI8UIJWTf3
 PvSg==
X-Gm-Message-State: APjAAAVuQCKlXNqCUqBZHBIr0XADafnrb9zAjpYqoNDidlD7yQvZgCdH
 yf9sb13kvqaVJm8YCyluQoEiQw==
X-Google-Smtp-Source: APXvYqyEmJ/JHHYvtpw3KjuSmIurkmGOQ6vwmRyWIMJhBTvXjVgFJL+OMFZtSN+u2wUmuOeUeFMfkg==
X-Received: by 2002:adf:9cc7:: with SMTP id h7mr4696640wre.193.1569358868771; 
 Tue, 24 Sep 2019 14:01:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y5sm1434588wma.14.2019.09.24.14.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:07 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E2A41FF8F;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 02/33] target/alpha: Fix SWCR_MAP_UMZ
Date: Tue, 24 Sep 2019 22:00:35 +0100
Message-Id: <20190924210106.27117-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We were setting the wrong bit.  The fp_status.flush_to_zero
setting is overwritten by either the constant 1 or the value
of fpcr_flush_to_zero depending on bits within an fp insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-3-richard.henderson@linaro.org>
---
 target/alpha/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 6c1703682e0..10602fb3394 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -71,7 +71,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
         env->fp_status.flush_inputs_to_zero = 1;
     }
     if (env->swcr & SWCR_MAP_UMZ) {
-        env->fp_status.flush_to_zero = 1;
+        env->fpcr_flush_to_zero = 1;
     }
     env->fpcr_exc_enable &= ~(alpha_ieee_swcr_to_fpcr(env->swcr) >> 32);
 #endif
-- 
2.20.1


