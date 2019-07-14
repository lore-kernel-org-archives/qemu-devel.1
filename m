Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661CEC73C66
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3794F20820
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO8ROLXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3794F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcRa-0007AJ-Ny
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60303)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR4-0005TY-ER
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR3-0006M8-9z
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR3-0006Ld-3t
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id n9so14202034wru.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QWcqefmxLRbmEUfSEqDtCzXI1bFjI9WN8pfzB0Jzwck=;
 b=yO8ROLXJyDL9A3nECDL4t13PvlssQCtGuq0AZBc8cK2TxiTHdE6FcIugdsxGumIdZq
 vD8r3BnSrk+8KZ10H/OYgWPHYjv2e/vk/pf7ciCyP6dkaxeappvffvQX6S9o3uiiGD2c
 v3qGaesrOoaA8OPOW1sde5O+snZNOtxe5SuqdsUAuvpvYPjb629vd4+bVwOZPwbrxkzP
 HAXk7mqtEkZhGz0iUutmniKhNf8mwd52WjaNzWbAszn/713VS6LEoRXQBp8jTQjr5ySj
 whR9bO+Gkcg2ChsOhGRlGAocd3s6n0+sC8KsS33Z27I4h6C9Yx9Y9ilZxeFBCCzZ7uWK
 NKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QWcqefmxLRbmEUfSEqDtCzXI1bFjI9WN8pfzB0Jzwck=;
 b=YyrIUENhFGf/KFBCrxWBGxlkFEBHKbTexFLvEsQMkyU9TIXRgDNdRW7Nf+Pvb4yhu7
 14B8YqZkpZ/imri41JP4paoRsaBKOfryrPIe/xsM0IK/cw1a/qrZf84cl3pgVvDeB30t
 Z5BJoJutfdbq09KddMDAKg4hSLILUgIiQVzlJYlhBhkpONkCof1E1R9qJaykJo7g4iE3
 ArFv6MVDvCKfCoqm7YZkkWcxntNQyVHEN6HDN3O7apnOEguhrjixB2VOJU2CC5WK4UnS
 8Jdod7UAbj/S6zXZKL2GkAL8cSaKX8OfI2/Tdj5P2nEf7ZBdn2RjEMHs5oBNE8nvmfpg
 MWEw==
X-Gm-Message-State: APjAAAXhPoWyXI/U0WwGK+yEYF0myas1b7LPgFzqgDanholFTvFRtY+8
 4Q1Ii60++HjQ8xwSA98RZiEEeHH7iI+4GA==
X-Google-Smtp-Source: APXvYqwvdGELyTyAG0oVhLZBpo8EkfBnclsGMJ2FxNLHXBb+8kJ9j8K4YjXeytX2KygMZSXOw8QlGg==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr21875470wrr.5.1563102771773;
 Sun, 14 Jul 2019 04:12:51 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:43 +0000
Message-Id: <20190714111249.13859-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
References: <20190714111249.13859-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL for-4.1 1/7] tcg: Fix constant folding of
 INDEX_op_extract2_i32
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On a 64-bit host, discard any replications of the 32-bit
sign bit when performing the shift and merge.

Fixes: https://bugs.launchpad.net/bugs/1834496
Tested-by: Christophe Lyon <christophe.lyon@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d7c71a6085..d2424de4af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1213,8 +1213,8 @@ void tcg_optimize(TCGContext *s)
                 if (opc == INDEX_op_extract2_i64) {
                     tmp = (v1 >> op->args[3]) | (v2 << (64 - op->args[3]));
                 } else {
-                    tmp = (v1 >> op->args[3]) | (v2 << (32 - op->args[3]));
-                    tmp = (int32_t)tmp;
+                    tmp = (int32_t)(((uint32_t)v1 >> op->args[3]) |
+                                    ((uint32_t)v2 << (32 - op->args[3])));
                 }
                 tcg_opt_gen_movi(s, op, op->args[0], tmp);
                 break;
-- 
2.17.1


