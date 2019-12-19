Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80957C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4600B24650
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVau0Z5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4600B24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtaV-0000Qd-UU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNV-0006xW-O1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNU-00014M-AH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34156)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNT-0000zS-VD
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:56 -0500
Received: by mail-wr1-x42f.google.com with SMTP id t2so5504069wrr.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=in0oC21NDNK40en2dSlsiyVxI60+V0LERywCr1z/Gwc=;
 b=sVau0Z5Vq5xOq0XZV132kxd5OtLfww/BWQu8tUX8W1ifnPZqtyPwufyfGDqFxJdmCq
 sGo5VKxoFypJcCLAm6Rw+/RP+4VAq9VfS9VsbBQHbrSlXji32xra9WbBAwR/KjJWNWgL
 ABDpJnaLmChU2u0SmMSybzzF6miwLgvLc5jK/w9O3lN27zEgMPUJ/npxDKCRGkLKS9da
 9f1kUAmlvSMhmhaCxB2SglHBLlSyio5U/AqyWWLkoiZeHjtgy6sCs1Pg+1N3eJI5CKZ3
 8rvdNhRTP64jfLPXX1gp8EiTQ39uBI44iSckVDxjvgnSiLZLnndt1hQZCN2KA3RMz2Y8
 U7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=in0oC21NDNK40en2dSlsiyVxI60+V0LERywCr1z/Gwc=;
 b=aI5YVCm+cGxwKdfbvRNw043IfKb/Txc5YTgGFiP67LIaZfRk30w/pFf5+K1kJHu8pF
 Wu4ZF3lPUr+Oof6IS6R+22d9/vJ9MF8p9JUoMuaGRI9Wih4C+GJONW7FVZ96HvUsbITq
 zZC4QasfRnViHumSqoeFdG+2/hOVGqOiFnGLsUFcqIRqJKaRnWQA76YGeN+CjoPtHwDm
 hSmLtTVElYMvHgQNr24kmFnVrJF+upz63Zb4IRJLu7L3zrc/J+9Jc0rBROSPky+ujKp1
 2JAL47k8cohpFFM7aGm2+Ysv0aEPJggNByg39OP8w7gNbptnq7u1FgRXEz5ReE4mbub8
 tmWQ==
X-Gm-Message-State: APjAAAVjQreYQCIj9bV100htrVPTQwa5v1KrZNC/iWXSBHbIzjxVlknH
 1aJ9OfiZLXDYtxwQ0FKm4CdAew==
X-Google-Smtp-Source: APXvYqy2KNpqCDjNJqW7PmXDfnMCUvpXTDSKAsJEIT08heCn0+CMltcU5Q+ZKg38fUfQZ14BK4yzxQ==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr8601969wrn.155.1576752594921; 
 Thu, 19 Dec 2019 02:49:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j12sm6375968wrw.54.2019.12.19.02.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:51 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3095D1FFA6;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 18/25] travis.yml: Remove the redundant
 clang-with-MAIN_SOFTMMU_TARGETS entry
Date: Thu, 19 Dec 2019 10:49:27 +0000
Message-Id: <20191219104934.866-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We test clang with the MAIN_SOFTMMU_TARGETS twice, once without
sanitizers and once with sanitizers enabled. That's somewhat redundant
since if compilation and tests succeeded with sanitizers enabled, it
should also work fine without sanitizers. Thus remove the clang entry
without sanitizers to speed up the CI testing a little bit.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191119092147.4260-1-thuth@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index d673ee219e7..376b7d6dfa8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -180,12 +180,6 @@ matrix:
       compiler: clang
 
 
-    - env:
-        - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
-      compiler: clang
-
-
     - env:
         - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
-- 
2.20.1


