Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A029CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C448721D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbPOaB9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448721D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5Yv-0001kG-3F
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Od-00081N-4N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Oc-000356-1J
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Ob-00034X-RV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id q13so3597332wrs.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5I5UoFas/oMecYMX9Nd86Bz4Y4H1FsmbDV1CnX/LR6E=;
 b=jbPOaB9lQAnUn+hE53bEItWJMmAe/WrLl5/Kho9boqdrWTYpRpFfzAlpOUGqpsy0ao
 1xpFe5VwhyLKr7C8HZnVF17aYUT60K7T2Zn0hdkI/gJjqAgMjPbIVG2wxH21U4YIKK25
 admdBqOlOxFgNAlDnJDuQoY02+903DV3Q5dW9EBemYgmKZIdXt4UDMyMB+Xic0FIfqeh
 P+/NaBWt/9jCNu2RS2Tyk+gYAvLJc3nnZa9A2cJMgf2vhGpFQf+rt18SUMhhDR41lddS
 Cy2gIpiQucAWLlx4ga48nsw/bzYRU94S/pCNe9MfrUQzsmMsEfmrhu4v8Wg71iNq3eQQ
 zAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5I5UoFas/oMecYMX9Nd86Bz4Y4H1FsmbDV1CnX/LR6E=;
 b=gMia2Z+uXbQhK/IIZxkKSFt4B1C6xofe0kCfNnOz7XGm89furq7KJteYvuQDSzc7en
 MyUi6EWP7kXmn7bHu7yMBXHekpyccfU7igboHSGak9s5QCqLpILGD4SV7VKHRhLseChK
 RfVGXe9+v4Ofod1oBq3agfmKj8/UTVhtyN6dTPQ4SqMj6QorKCmLEXg2jGzIY3uqGDBb
 AjZmFyYTKiEVj0B9IOwjXeriyFrXDazR4N2LKThxZ6Hgijmbpbq1uigAdjlhk0ZQu4Rg
 YdkXPhu19Px2cf7fo4SleAMcFAqS3gBJsWSgjzJ6HRCNcn/DsPEnB45S7ghmNeURPY70
 8jNw==
X-Gm-Message-State: APjAAAUbKcR7goUlR+nr7TrPUTU7nBesVlo/XBDQCcAAwwUzJaY/ivOk
 bePHmP/OZK8Z6f4/q2o/EeFFOQ==
X-Google-Smtp-Source: APXvYqz4mx2f/w0PM9IV2wb6nlQCvFfHFKWSqdsLFttMwSZ9KGKnBAOmXNNx+Guqo1fnICFsI1nnGA==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr4336482wrp.353.1572032232676; 
 Fri, 25 Oct 2019 12:37:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c6sm3059617wmc.9.2019.10.25.12.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9131C1FF8C;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 01/15] travis.yml: reduce scope of the --enable-debug build
Date: Fri, 25 Oct 2019 20:36:55 +0100
Message-Id: <20191025193709.28783-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding debug makes things run a bit slower so lets not hammer all the
targets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index d0b9e099b9c..7d90b87540f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -124,12 +124,13 @@ matrix:
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
+    # --enable-debug implies --enable-debug-tcg, also runs quite a bit slower
     - env:
-        - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+        - CONFIG="--enable-debug --target-list=${MAIN_SOFTMMU_TARGETS}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
-    # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
+    # TCG debug can be run just on its own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
-- 
2.20.1


