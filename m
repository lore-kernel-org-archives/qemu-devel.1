Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6329D206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGRkdWv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63ul-00014J-MO
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sM-00058N-1p
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:58 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:33245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sJ-00009b-1B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:57 -0400
Received: by mail-pj1-x1033.google.com with SMTP id i92so3676272pje.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3RRutFcQg2BpL8FgLWbZKREr0UCat+CTMLpox4B8wnA=;
 b=YGRkdWv567UbOlcuN8Ax0gBxX7z6zG292NL68TSsoraHI94SqhfCnsszj58cBoKDYi
 4QpYQl9kQ/GCnhrmAXY3MacmhRxN3oJI/vfdKtaasjFLwFDuKdvHM4+3+11Q2J+SwrJH
 +wYla47O8pzTG76aBQ2ODdEWKRVuJxKDv1MG675CMFan+E8IjP3IgCBjNoiya8W4yUa1
 sAfgLltyN/ezDmiHuJ7zyJccSgAS1uAwd5WIBvOSqYR8ipsNwDjjG8ELmT//0efeORka
 bc+L8jO3xg3z8/UEIbfnIeUPILnLrQ9vosOSYoyaPbHjDzrRl/C2sNDEHqXVPs1w2+lx
 Aqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3RRutFcQg2BpL8FgLWbZKREr0UCat+CTMLpox4B8wnA=;
 b=dnq9uGJJE9gHoqwpXIgPhmvIRL0OJFwSZ2iyp4chJzuLmqWsSqV7PfJlpv3AOT1N2C
 7QOjMzi17WYxgmPS1ykcGos/KqxoI71Qh4hcTrtqTsF9vTZ70JRGSRPsYE0yTPQNwTbO
 7lXiG7gILH9kO4Z7/1GI6g3z1YcZhhWnczFLtLaa+hqz6T0HgQa8SFwYos01Y/b6stPr
 Q6n5AHANArwyqg1cAo8D7HDl7+F37fXN1dT9Tou1sqxDHvV1NNDTsO+AlOHo1lVnAq96
 NAKchxghQHwh79tgWraK1Bl1GDUK1jg7bB8t3Y/lY6TNOHhPuYFBNQHHaaV6xIaZD1Hv
 3I3g==
X-Gm-Message-State: AOAM533NdpTgPGMuWIkrUBiJ9tk3tvDRtQPkhc5mos4Vy+5ZQhf8tvtL
 tsWC74zk2qDGAnskulqRAdw0ftp1fEc=
X-Google-Smtp-Source: ABdhPJzm9zzyaiEwc7cf1kSMeLqDUeTZQu7vIJsb0QlxTFPVPVEfn8T0unQHeqZmGACWunOsbAUwzg==
X-Received: by 2002:a17:90b:384b:: with SMTP id
 nl11mr3029362pjb.91.1597289153374; 
 Wed, 12 Aug 2020 20:25:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/17] crypto: Constify cipher data tables
Date: Wed, 12 Aug 2020 20:25:30 -0700
Message-Id: <20200813032537.2888593-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 6e25f68f5c..2fe12a4fdc 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -25,7 +25,7 @@
 #include "cipherpriv.h"
 
 
-static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
+static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_128] = 16,
     [QCRYPTO_CIPHER_ALG_AES_192] = 24,
     [QCRYPTO_CIPHER_ALG_AES_256] = 32,
@@ -40,7 +40,7 @@ static size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
 };
 
-static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
+static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_AES_128] = 16,
     [QCRYPTO_CIPHER_ALG_AES_192] = 16,
     [QCRYPTO_CIPHER_ALG_AES_256] = 16,
@@ -55,7 +55,7 @@ static size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
     [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
 };
 
-static bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
+static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
     [QCRYPTO_CIPHER_MODE_ECB] = false,
     [QCRYPTO_CIPHER_MODE_CBC] = true,
     [QCRYPTO_CIPHER_MODE_XTS] = true,
-- 
2.25.1


