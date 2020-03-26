Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32B5C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733F520714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlWEKjN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733F520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYYi-0008Nb-KC
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKH-0006kr-Dq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKG-0001Yv-AF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:01 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a]:35308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKG-0001Yb-6B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:00 -0400
Received: by mail-qk1-x72a.google.com with SMTP id k13so8204710qki.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=xlWEKjN8U6gUtcJFuizFSftU7WxSsbrTQYUnA6l6OKqREbnavggItUTsECTpAwx0HF
 +ywJyPL4LvlCCe/Wwyd6HcEHKV/1N4SrA0oiZDY18gMOZhPE3qqR1X9ImybUUHo0nlNw
 BbqQee46nK/gPpcNBUopsJTeP1xZYdx322b15ESj8StM9e6zcnQ2an9cyDFnMsgIrqZL
 Hk7jiwYn2Gr0Q9oPC8gncAk6d42UpZsaIYFU/cuXoVqQHp6c6bsswHPZ5LNZo18xaN/z
 NVVqLTaUxCZUpfGw0b+0o6/S3qWm0iBl68h06M7836rZeZhgxGVx6YQ0nbt6jLgOPo/I
 8WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B03XAH5wL6d9wQMcetAjOEJJOmedJjFZih4s04YDqvs=;
 b=rz5x4UwYIy4aAAm9UpGd4dlIC6fftQCaFXDgjRr/sGlwSUAjNp9wcTOM2owCpszAzT
 VUEzKt1lrlW4kDAv975vHjMUvjwJhIdtOYdimpDFxhzmlJVt+8JE5PkA6YsH3UwOWnEA
 klBegSeH6W2BqSwHeZdhN908Pn4bz0wmAsBjVOeKIMdzFbY0GjHbbI6m9EbwlnSN7M94
 kuDUVhtOc9ZHGIaF2RmXWqhM8oY+9Rai3gbPN9RXdLvkrMzkg4+Ofhi+uBbiFV/30Slm
 g76UILEC3yot9AC3LXPtjA8Sxw7ou9sHRHv6QRgkei6MX2www4CTfbFSVVvSBbVTGeGv
 HBNw==
X-Gm-Message-State: ANhLgQ3GOrDG9TmLhxzVy7Jg+bTi0EgxSSjsyZqk6lSEKuTPyYKkbklE
 1eVX/2JvCyiPc8OkmgAGcRd0QCIAe51uTg==
X-Google-Smtp-Source: ADFU+vu+Ur9DgYnoS7SAY9mRhY08dzEOl7U2aTj2Ut1dMZJi8ePDIpEru/Xk0mYdAMVI6zyblDZLYA==
X-Received: by 2002:a37:b4c1:: with SMTP id
 d184mr10453998qkf.452.1585251479100; 
 Thu, 26 Mar 2020 12:37:59 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:58 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 20/74] sh4: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:02 -0400
Message-Id: <20200326193156.4322-21-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72a
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 "Emilio G. Cota" <cota@braap.org>, peter.puhov@linaro.org,
 alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/sh4/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 14c3db0f48..d338bbe871 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -90,7 +90,7 @@ void helper_sleep(CPUSH4State *env)
 {
     CPUState *cs = env_cpu(env);
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     env->in_sleep = 1;
     raise_exception(env, EXCP_HLT, 0);
 }
-- 
2.17.1


