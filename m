Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF53CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D9D20776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoSAFj7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D9D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhsI-0003CR-Aj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoj-0003bS-Iu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:33 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoh-00030b-Vr
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id u20so954807pfn.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vkqjR+0dFjJx/RqSJg4ZuU6Fj06xiA2ZZSaXxPiNFoU=;
 b=JoSAFj7h/TcBC+QPk7eGl93Qqn79bJodTyFVU8QyWiKEeEiTkR6Zuwor5kqF7Pvqpt
 jEUFLyHIQwEFUSj6aOQi0QLeoDIYhlPAj9H/qfCt0Dw17iJwQDC4//VWZPtZJIHeihzz
 emLNPzforafvinCVoxfpq3qDrbpaXzEhzR6DrYupBk+v815j07a8RluYi1UjJ/Xrcev4
 gU5/CJUIbTg2HYHBAu7hvKq2uw40+hjBWGqzrSxVl/Y34xdEGUNpagqPS6Q42ZcZvJQe
 NMKX/LNKiHpuLxJBmONit+5q7vfwpotyhWlsrg61nUsfIQJa0lxVXbrXWN/xu8pJo6jp
 TE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vkqjR+0dFjJx/RqSJg4ZuU6Fj06xiA2ZZSaXxPiNFoU=;
 b=KiMwoEskkwvzXhBfCuGw0OJnnXJQZ5YE61s2aG2IPhKfJTxXqK5JopHEzYd3Qm73VD
 7H+O88+GK9g2JbGbJhlfXnOD6T5Fhz5JGxc4ho6XsaCt7IwQN/3B46XDCamfFU1Jyz42
 MwD/TNJwpBXi/Ko3pS2MysstzrvNteeF1asa1cD1kkLbPToM+me4Hey9D1V9BHWQooh8
 QmkQDjaUO/O1vf9o0cDYeghzUIWw68WukWJG3r6W+HJWDq+Ar04lfp+rGHBQUvy4aekl
 +hGi4abUz8YSJoPZF+iDrzrvvPSPmHZHuEcTHFE/50OL6YgzvGMi8OOT97/OIpQVFv/J
 H2Zg==
X-Gm-Message-State: AOAM533EaR5T45O6IkCBaiudjDeZDnwYstjEv2ODk+XAyBaSsJvJKKck
 ATbvZGHpdxL9CLV+VzPMOr21KZGJYhUXBw==
X-Google-Smtp-Source: ABdhPJygVTUTpTseFw/AC/EruBh/kS2xgy+nku7TwS9KS+PIJE6CsAeqE3V6fvypHEVZEpCb4eOokA==
X-Received: by 2002:a63:516:: with SMTP id 22mr1812863pgf.316.1598634330292;
 Fri, 28 Aug 2020 10:05:30 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/16] crypto/nettle: Fix xts_encrypt arguments
Date: Fri, 28 Aug 2020 10:05:11 -0700
Message-Id: <20200828170523.418603-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fourth argument to xts_encrypt should be the decrypt
callback; we were accidentally passing encrypt twice.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-nettle.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 256931a823..0404cfc6da 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -632,7 +632,7 @@ qcrypto_nettle_cipher_encrypt(QCryptoCipher *cipher,
     case QCRYPTO_CIPHER_MODE_XTS:
 #ifdef CONFIG_QEMU_PRIVATE_XTS
         xts_encrypt(ctx->ctx, ctx->ctx_tweak,
-                    ctx->alg_encrypt_wrapper, ctx->alg_encrypt_wrapper,
+                    ctx->alg_encrypt_wrapper, ctx->alg_decrypt_wrapper,
                     ctx->iv, len, out, in);
 #else
         xts_encrypt_message(ctx->ctx, ctx->ctx_tweak,
-- 
2.25.1


