Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13242C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B525520759
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvv0fb6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B525520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqDN-0000hP-Nx
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpq1-0002sS-0r
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:33559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLppz-0007dC-C1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:40:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id e11so2152525wme.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X7bddl+nfV1LEnfasUkpHrBmJA8Qf82YzRcmiRjcnEs=;
 b=Fvv0fb6QVcj+/2IYYwI2Tqv7vEMUecaGZYgEjmZgE0MopFbf+D5ZRTwcDF2W+8B/Mm
 SQiB5YujpQ/Cqqhri4/jJH2puoFFdfie5AtOqjJI85NOSdJee8Vicewin6iTJ0Jv6WFs
 +Bupkim+rc2QldbJpPMYo7zARPgP5AWZgHKMK2upApcJjWhFi1cWcuEfnAbbE3kW2YRN
 //VwJaGnZK2ZNiDHntABn4rpbwFVd9+sy/rqPzsVrrPrQDliOr9djz3l8XyZytGvnphk
 Cc/IlNtxBGXYzVo4HNgdBN4nYuUmeHzEXpmACoaES/fCPwcsEZlMsGIta0QSQCtKUXL5
 miaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X7bddl+nfV1LEnfasUkpHrBmJA8Qf82YzRcmiRjcnEs=;
 b=ruqyshyV/KYFlD80LOO9DKrArwzpPGeGvIHyf3CCoMcFfTHTxIoF3PmrFAHVyAw+ch
 eHz+QG1BhbyQyE/esumJafwZkztrZpKE+fIhuTkk6OtbupKIueuFCzIYpcpXSsc10W5X
 JE2Bdv1lgMXID3HD4iyGRexHrtzMHgjsWjYCfMRjq6sMFOy4m2HNaivrtWRkNFkGJgoA
 aRlfpokH4+WmwSXEKS6UScRvld5Z9WGRPLKcgZBSsw996CyJlCaQ4/vQwkqON4cGNl6v
 2wXCalVwNzPVctLMAow9I+gDHRmKl+RdIaBR5esrwdiyPpcTl6HwKMT4xoy0swmgdClQ
 APsw==
X-Gm-Message-State: AOAM531rctNDnAURoto3s9FsoDXnnYDoBlA/dMfC7k3KiDNsICLJbnFv
 qJBHj2h69bxsSYLhBC16TlQpxg==
X-Google-Smtp-Source: ABdhPJxHsVtqjERGlj5OZEyi3Iu0MdVdm+94pbD6Uro6koH8k7XQn9Fli34wJj6tjFRACQ4CXXmuiQ==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr3728495wmj.24.1601048438811;
 Fri, 25 Sep 2020 08:40:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 9sm3189318wmf.7.2020.09.25.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:40:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB4941FF91;
 Fri, 25 Sep 2020 16:40:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/15] travis.yml: Drop the default softmmu builds
Date: Fri, 25 Sep 2020 16:40:17 +0100
Message-Id: <20200925154027.12672-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The total runtime of all Travis jobs is very long and we are testing
all softmmu targets in the gitlab-CI already - so we can speed up the
Travis testing a little bit by not testing the softmmu targets here
anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200918103430.297167-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c75221dca3e7..1fc49b07464d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -123,20 +123,6 @@ jobs:
         - CONFIG="--disable-system --static"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
-
-    # we split the system builds as it takes a while to build them all
-    - name: "GCC (main-softmmu)"
-      env:
-        - CONFIG="--disable-user --target-list=${MAIN_SOFTMMU_TARGETS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
-
-    - name: "GCC (other-softmmu)"
-      env:
-       - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-
-
     # Just build tools and run minimal unit and softfloat checks
     - name: "GCC check-unit and check-softfloat"
       env:
-- 
2.20.1


