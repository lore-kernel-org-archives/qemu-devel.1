Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87142C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B5320651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyK0s8yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B5320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzh3h-0006dz-0m
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-000388-Jz
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007Ev-GH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-00078z-40
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id 10so1417067wmp.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pi/XqrnfMiLeFfpwnlhapinsYiJtjMGos/NUkaXTXfM=;
 b=gyK0s8yMv8f7e+7lQs3KG5jmUm3mg+adIq23BuHWL3O+YbXwaUAgLfmlbABL3ggtAb
 WQhT41BhVL5zgdP/fHJV1OoQ2BOY59PMsM5DZ3V0ZruUkh31kKxQBfHntG1LMrVTO6Z1
 0gO1SypeL9q5trzFnXcHaq5z2v8BiwOdfiV7GX3CDs95LKclw7jmH+U7SUSl8DDXG5BE
 tbWcZh8Bd4krBvgKCSIIh7REO+XAFL4XxaMGARlsss7WwDNByfQQDxasH6xX6H2/89Ea
 00GMb5dqJdzH5QTu3/rKjtMA6Af8Lf3EZ2cDOkXxBnO7H9swGppjIsulb+G+BU3MsLL5
 E7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pi/XqrnfMiLeFfpwnlhapinsYiJtjMGos/NUkaXTXfM=;
 b=Wn8ZfIa3qB1AioiuFHOtU9DYN+d8qjQueTGfQ6Hw47VpMAb/mqgeOmELFT5YuJ1FxH
 w946awbzVbCOLovzwC6zhhtdGfbep4W5XaMeWnsK2WsxKoTXeJaWv2OYRzMSEzOHCziP
 F830Wh8rG5IQlDk/wXmdbIMKpJU2Vo9zBWvoW31z9Q3iYQrNHrfHc1C4eg6TMND2jshi
 ZSDg89Iznew+HJABhvbAMnvFJtgjAuE8u7qw0G/JR9eKtY6j6MJXEfec8vryWJ167NVr
 TO/O0BrbzTKwb7x6wcs5CX2DC2G0Jovc6+foDP1RfKwAuvW/9KVK6BnkjpQNw94kDp+W
 8BuQ==
X-Gm-Message-State: APjAAAXuCi5WTnMiWjNvE7hNPd+j9vp9jXzUYyX6KFYkT75b8OmDanI0
 5RGcQcftvE6tDhel+Kxj0/rxhg==
X-Google-Smtp-Source: APXvYqxr7v6JJUev4QeNlA0HguSJMvWEZlsTGZdJqP5tox3TcWX5DIDYheqkZZgNwkb60e5mkykedA==
X-Received: by 2002:a05:600c:2056:: with SMTP id
 p22mr19887390wmg.155.1566217034386; 
 Mon, 19 Aug 2019 05:17:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d17sm16430724wrm.52.2019.08.19.05.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 704F91FF93;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:03 +0100
Message-Id: <20190819121709.31597-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 06/12] fpu: remove the LIT64 macro
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the rest of the code has been cleaned up we can remove this.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3ff3fa52245..d9333eb65b8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -82,8 +82,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_H
 #define SOFTFLOAT_H
 
-#define LIT64( a ) a##LL
-
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point ordering relations
 *----------------------------------------------------------------------------*/
-- 
2.20.1


