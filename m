Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEBF207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqJr3GeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEBF207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxWP-0001DX-S6
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSS-0001lU-HK
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSQ-00087K-M0
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id u13so3350664wml.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jrUkHAApHhp6xANTyxUoK7alihevxNR/A5+KN9e47UQ=;
 b=uqJr3GeBau4h3aIY5NIeHOjiOc3unA0hnmD5veTwEuuG/w0EU0UpjfBOENDFyl1xb+
 jrN7KuHhTSuABTEhCyFg5kCl+MEdusFkuQI5tVTQsSGMhCW4NsubDN/V1Yiyv6gqgbZp
 xGR4slW0RP6TNcR5Hq4WuR1hRhgmVIz/2bmBUifcS15T2rKKDtGVHKG3ktn/DipB/Lg6
 mdsaPSIbZ7mc5hqWC69Mlr2H+ycbf1fAi9jZgFu+AY4CnW5biCpAR5zm173e7mvZzOx+
 lVIbnqBV9J0gmr1CVDZyYoJsIXY1gITo+rNEa6SHZbB2d6jSuIFyUeffmwVfQdU37yLg
 D6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jrUkHAApHhp6xANTyxUoK7alihevxNR/A5+KN9e47UQ=;
 b=LXe0v1Qs4CvOlnyu9ruPxs6HEYIccviMAQQvm6dMV/++flOaiGxuIYdCdf7wVyycpv
 Q6oyaNxZ4lNpSQoDBpa04IdZ2RAR3MJLJM5T9P65r4P3n0bMLQq/8N+rgwIGSKpJTx9k
 QCk6XH7MM5poCc/wN4p8IEbvy3v0Dl2XPeGbebrjZ6ppX8gHoAc8bRh3902K8YaX/qD7
 VhLH9QPlyWUfR3dk4rJO85NyT0vAkspn0yo64zutzXYQVysoxHYn7B7qgkM4+eYCHTmZ
 AKcui71MPrn7uJ6jrH6qkh1EkpViD3cWcWz/CZm3rSOih0wyizTAOeIrY+iVCY/1XkBH
 ukXw==
X-Gm-Message-State: AOAM530bfFFnS/LCqp4aKATkonsW3hULwi0qGONsrM3TOvyRoaeIy6qh
 5YSu+F17eHR1a2ScxjWg/Uyl/g==
X-Google-Smtp-Source: ABdhPJwpmROQj5Uk33IFFo8KdKUflXj0yd3Lop7lrVF5brXXq4Q4feo7GqZH/ZNc43MoLQyZ7T4f+w==
X-Received: by 2002:a05:600c:1146:: with SMTP id
 z6mr4554192wmz.179.1590591301136; 
 Wed, 27 May 2020 07:55:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z7sm3030126wrt.6.2020.05.27.07.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:54:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54D891FF8F;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/12] travis.yml: Use clang++ in the Clang tests
Date: Wed, 27 May 2020 15:54:46 +0100
Message-Id: <20200527145455.2550-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Our configure script does not look for clang++ automatically, so we
should use --cxx=clang++ to make sure that we test our C++ code with
Clang, too. And while we're at it, also use --host-cc=clang here
to avoid that we use the normal "cc" as host C compiler.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200518083316.25065-1-thuth@redhat.com>
Message-Id: <20200520140541.30256-4-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 1ec8a7b4657..564be50a3c1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -205,14 +205,15 @@ jobs:
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - name: "Clang (user)"
       env:
-        - CONFIG="--disable-system"
+        - CONFIG="--disable-system --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
     - name: "Clang (main-softmmu)"
       env:
-        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS}
+                  --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
@@ -222,7 +223,8 @@ jobs:
 
     - name: "Clang (other-softmmu)"
       env:
-        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}
+                  --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
-- 
2.20.1


