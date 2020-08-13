Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:30:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BECA20756
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQZaLeAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BECA20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63wc-0003U5-Dp
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sC-0004nu-Lh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:48 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:55952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sA-0008Vy-Vz
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id 2so2105330pjx.5
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P2SPKTHOjMFQdCqB2vtTra0ygHn5FhW2ETtwYwPvoTs=;
 b=fQZaLeAn4s323lW+P0S9LxRYeHFUfLXgtPg3qlHyHBQhbY5uC8TJSb3/cuFzgrMV3X
 BkV2FpdQtfcPW5+5v8SavMtFIbQ4ViQ7OobgNV3xf9LXXG6tvdxf3p+18MS76C87yOxh
 nDA23txSM0XaZJivpkQAk1WJ7+tI0siNJLLJIpXianuDTvFB8JVhVxH39YE+uNJQEuqW
 ukoH+DEG01eZyqN+1PuAzOZLl/WVBEsVfkuaiSRo2RPcxfTDnQCT/jk9jDynD9/KWOwU
 N9mBHSZekRjCChHTcgJ/jQZy8UjpjpEUY9Gk5mDdZc1fya5AtJUnYi1lrL7Xquyzvgna
 7jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P2SPKTHOjMFQdCqB2vtTra0ygHn5FhW2ETtwYwPvoTs=;
 b=aO8sFfDIFuo2pmDpZgFleK4qSusPCPetSkfYh6fNXj34cqTmutnsNquWLA4VS1HSZB
 /aAIDTpcE+P86Ny+n8x64GlgAYFve5+fC7l1B6bN8bXHdcNM5axiy37TjhbDRpjHCZuX
 A4nKWBS6vK7Z1TQNBe7cNScWdEDsO1r4nxPXQGUFBc7IbT6OiEH3s6R4ghZttiObT6ys
 sI9+hQ8vbDBV7xWDn20Wcws+0nD0vqC/YU1SxMtKXwQoDrcupX3Ocim5AYwrz+i32XWu
 gk9IYlLL82xQ8j3SIO128Uf2CWpH6WknwMr3/PiqAIAw8yow3zr1HevvpJ9PsSaNN4ZD
 cYvw==
X-Gm-Message-State: AOAM532kuKEiBssLhzRwo/MFNSrsYTVPGO0yh3OHBfJVO094ki6QRp5u
 SNow8EcQOfLxi5KPFTj2vNClI7M7tJw=
X-Google-Smtp-Source: ABdhPJysmZ59JehnO4QDXa+EvZVpCELkWLPapgrKfrzdRO1yI4ufOZ0kLp1jdLKYwgXJe6Bh5uj0Ug==
X-Received: by 2002:a17:90a:6807:: with SMTP id
 p7mr3090799pjj.42.1597289145330; 
 Wed, 12 Aug 2020 20:25:45 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/17] crypto: Rename cipher include files to .inc.c
Date: Wed, 12 Aug 2020 20:25:24 -0700
Message-Id: <20200813032537.2888593-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

QEMU standard procedure for included c files is to use *.inc.c.
E.g. there are a different set of checks that are applied.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/{cipher-builtin.c => cipher-builtin.inc.c} | 0
 crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c}   | 0
 crypto/{cipher-nettle.c => cipher-nettle.inc.c}   | 0
 crypto/cipher.c                                   | 6 +++---
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename crypto/{cipher-builtin.c => cipher-builtin.inc.c} (100%)
 rename crypto/{cipher-gcrypt.c => cipher-gcrypt.inc.c} (100%)
 rename crypto/{cipher-nettle.c => cipher-nettle.inc.c} (100%)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.inc.c
similarity index 100%
rename from crypto/cipher-builtin.c
rename to crypto/cipher-builtin.inc.c
diff --git a/crypto/cipher-gcrypt.c b/crypto/cipher-gcrypt.inc.c
similarity index 100%
rename from crypto/cipher-gcrypt.c
rename to crypto/cipher-gcrypt.inc.c
diff --git a/crypto/cipher-nettle.c b/crypto/cipher-nettle.inc.c
similarity index 100%
rename from crypto/cipher-nettle.c
rename to crypto/cipher-nettle.inc.c
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 2722dc7d87..deae82c264 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -151,11 +151,11 @@ qcrypto_cipher_munge_des_rfb_key(const uint8_t *key,
 #endif /* CONFIG_GCRYPT || CONFIG_NETTLE */
 
 #ifdef CONFIG_GCRYPT
-#include "cipher-gcrypt.c"
+#include "cipher-gcrypt.inc.c"
 #elif defined CONFIG_NETTLE
-#include "cipher-nettle.c"
+#include "cipher-nettle.inc.c"
 #else
-#include "cipher-builtin.c"
+#include "cipher-builtin.inc.c"
 #endif
 
 QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgorithm alg,
-- 
2.25.1


