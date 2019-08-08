Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC20C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69BC2173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AI5BNglK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69BC2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvp0J-0000Wr-1t
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 16:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59877)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozT-00078q-Gv
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvozS-0001Ju-KW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvozS-0001JR-Dp
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 16:26:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id d1so11820218pgp.4
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RskjHA12b+UCLX2htP8k3zX7fIXUBDlXhLLJAVERdC0=;
 b=AI5BNglKzJ2nl0bwk9cg0D/RBrxrCsZPjYtJwwhMbI6xLE29xO9oKjooujma6sBJDH
 x2TUbnqhBThgU9jAt4HatoRJLmXHeXgo5yIkfDaPdIm1Vsq7X7zMIunrC2IIgbBR93Fr
 wOilkONR8MFHcXpVSAGnr4kaG2RBJbv+DQMQeh79a66RbhJZG5UrT0LX//EMqTqlXAwD
 fbkfNYZd8LKN5OlCz1UJzA8gX+uF0PyEG06FvnJJRaLm25VVk73Y70SR0bYd6LjBTr2k
 nu9JHSO92ppTRl3J5IT74hgWQR1bcMKiX5V+FP/7jwhtSD3BEsAZ3i9l7uQa8KL1FQ8B
 SKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RskjHA12b+UCLX2htP8k3zX7fIXUBDlXhLLJAVERdC0=;
 b=GvrjGOMiwmXHfs+6dHXhZjJGT0er3Dw1vzLYR/hVGffPfOf0jqNMjWoNMbvU/OHunI
 clDnmD8ULjylD7BbmuKCl0AEbxjllx34JusHG8iIsqsh998vilVjV1Bm1kclCcM3ExBK
 lbAN3prS3T1SoXjopHr+S22GTqTlV4kpu+1IxOL8VwoBCDpcREbKqX7zDkdzaqOgi/8b
 de3qFZRnht+2XFV1PiAUoT0BYlItmacQWrLY/DDwAqoqS8YeFgf2OD5ruOkkWMkT57GO
 SqjFubg/5scBmBS3zZ1OYg+DQpbljSJOeoBueyH+1l+HseLGdPp+8aLMFFtXrWON+Wy3
 4Vpw==
X-Gm-Message-State: APjAAAV6/bXTzeE6S7SHjYaoauf5eSTLjZP342i5T6edmUx8WK99HNi5
 xsGLDHQ/IaDYZ925PYjRWmY93GXUTQA=
X-Google-Smtp-Source: APXvYqx3IbAmTAUljRT3n2vxLgD+LJf7v1V+KLJeb9XaYVru7wLRBwWXMuzN9B5pdU089+acRCaAJg==
X-Received: by 2002:a17:90a:9bc5:: with SMTP id
 b5mr5853080pjw.109.1565295985125; 
 Thu, 08 Aug 2019 13:26:25 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id v12sm2850146pjk.13.2019.08.08.13.26.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 13:26:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 13:26:14 -0700
Message-Id: <20190808202616.13782-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808202616.13782-1-richard.henderson@linaro.org>
References: <20190808202616.13782-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 5/7] target/arm: Use tcg_gen_rotri_i32 for
 gen_swap_half
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rotate is the more compact and obvious way to swap 16-bit
elements of a 32-bit word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b40f163bab..ddc54e77e4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -459,11 +459,7 @@ static TCGv_i64 gen_muls_i64_i32(TCGv_i32 a, TCGv_i32 b)
 /* Swap low and high halfwords.  */
 static void gen_swap_half(TCGv_i32 var)
 {
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_shri_i32(tmp, var, 16);
-    tcg_gen_shli_i32(var, var, 16);
-    tcg_gen_or_i32(var, var, tmp);
-    tcg_temp_free_i32(tmp);
+    tcg_gen_rotri_i32(var, var, 16);
 }
 
 /* Dual 16-bit add.  Result placed in t0 and t1 is marked as dead.
-- 
2.17.1


