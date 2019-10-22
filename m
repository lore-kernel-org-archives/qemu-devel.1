Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A462CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B512053B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmRf/RQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B512053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuIv-0004IX-I1
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGF-00022T-TO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGE-00017O-TT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGE-00016z-NL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id g24so8122191wmh.5
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Tszmi8yysvRuCxwYylX4mScv+Q4hFjeHGWVpSd5q8fA=;
 b=VmRf/RQnlFjM96sBtBuhhuo7eK2/nliOPO2lG0/lgEOZogm8B9k1WmE1mm2ZrKvhbI
 jxeFvOT31m1NFobO4qwvVYqaqyZ4ubiwSJrWmCfcrBQFzwQloEqgNnDGx7tI8SUtrjdw
 Ay2cQ8XEyMZ4ShfsvX1QwG7XX5+3HOfX9hFsyjkcp0ttSuR+NGg5ihVG+9kMR34STOTG
 o24PTgBxb6Chn7ZQE16mc/yatYXGuiK2eh5wZ2x8Azqh6hVWnhS0UPmJcGAVPD4TlXgv
 xC21xdZksFhjhdUBK19Tesc6Bb4Kn2twM+Sh9MIv9MBIFS5gfdSaWuHNkMI/U+MU/My2
 Idlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tszmi8yysvRuCxwYylX4mScv+Q4hFjeHGWVpSd5q8fA=;
 b=LF6eAGwg/X545HNSuhuHTzePHfyzFshrRP3icPc33lBqw+wV9h4I/GAIISP2uSUcsw
 tKunztF380TbI0iGlvMfiEftc8Q5brvR9xiB8SzCLy92mXsL9ab0Y30u54pUIlai2OZm
 HiEvTqIPvFCp/iFZrmWaWbcSPQDDaKDgKpBQXBr25oTYWBYfSzRiB1cMCiuvUm4+v6S5
 /ge9lJ5SlrzwR1PwIHsCeSFdC1yBcYRo13MQcqAyk5utLqYr3BKGKQ0TLWd1D4MSglLz
 pQixPmKqD4MeZxNctnMDwk/vYhABQkDdoSnfbyaIqfQOxXVCvYnE3mMeACDWavnbCAiD
 HpmA==
X-Gm-Message-State: APjAAAW+PvZrlrVXyad744ZmHD5HFeh0Zq8+CC9NxXvhjdpluu59BKsV
 PYCIrswYJAb7RTfXZKIES+vU8COhTaU=
X-Google-Smtp-Source: APXvYqw0z3noz3n7EcxZOdrB+ZZ0axTQdgtr9aKhgoRgFM0MlQcNq3OCWOzOW+y0mgLNGPLP4CrVFw==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr3149513wmc.60.1571751101014;
 Tue, 22 Oct 2019 06:31:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] target/arm: Fix sign-extension for SMLAL*
Date: Tue, 22 Oct 2019 14:30:54 +0100
Message-Id: <20191022133134.14487-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The 32-bit product should be sign-extended, not zero-extended.

Fixes: ea96b374641b
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20190912183058.17947-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 698c594e8ce..96340520ee2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8045,7 +8045,9 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
     case 2:
         tl = load_reg(s, a->ra);
         th = load_reg(s, a->rd);
-        t1 = tcg_const_i32(0);
+        /* Sign-extend the 32-bit product to 64 bits.  */
+        t1 = tcg_temp_new_i32();
+        tcg_gen_sari_i32(t1, t0, 31);
         tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-- 
2.20.1


