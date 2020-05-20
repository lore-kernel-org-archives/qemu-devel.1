Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85657C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AAE20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imZ/76FX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AAE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPZ3-0006cM-Dv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM3-00005X-KW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:55 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM0-0001r9-M7
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:55 -0400
Received: by mail-ej1-x641.google.com with SMTP id s21so3982450ejd.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m1zXruZIXUvjwU/PTNcJ1tB+FSG/kUrku9mORQV4WDg=;
 b=imZ/76FXo4Z2H8/YMebPsY+A0NMizgUxrPiOhyiNbD9fBYI8jii/L0REdHqGRLU6Hf
 nq6p3ILZ2kHqkIXt/tE+Z0ShrhxwfXMJrdWSRNAvJK5JHFZYu0vMR+4s8hZSnwiNAKfG
 vRQKev+segCqVigpQEk0ZkVseSJyb8oKveNnRhUa/YJ2WrUhFBJJEjB3zqw6aN7Lq5Jr
 8JXfNdJgjkm1JQKTqPN8PjSCJ4T1CdzXk0q8wzVtEf36jUzN7PEmVYv+mSt59EgH48Nt
 8vhugxz171mKrKRf3b677s5YoEwp4AigMChit8eOho7SFn5aoqwFg5WHg6piMSFPDRSD
 FXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m1zXruZIXUvjwU/PTNcJ1tB+FSG/kUrku9mORQV4WDg=;
 b=iMDlu1EINDZ49Rxy0z+CPcIwVxIx5+qZm4Q6XQjdFC3XgkTJH28P771k6IBe+kBo53
 P+EVVaE6+aw13+2+tFKkBXZBtgcMtAt/Mnf50RtAWnsELqozmyMhtUiz0OGgJxcuQYzb
 aZVPrVEZW6veXyPu/KYj+VRp/+AFP/y+gCIsD1qtSH+7OqiKUIQqBTR2ii9bN0MOm3Ze
 5sX0NYV8tQRT2qssw25WQja+8+aRRxQKH46qatf0Q9hCKjMyDJMXt3UalN2b7dNjjCOH
 CRRLMKhi2LOv/VU6/5/A0BtkQuA32PqaoLjTnBpprEtMcusyrgCFhgekTotUm/fN9XkJ
 1Ocg==
X-Gm-Message-State: AOAM531EJtOxy2nLG5WEcsABM/c+S6FjKjUD27fJ7KBDHbdw+9LKR8RN
 oX4+hqDDsyfWdPfMbvKpYlpP5A==
X-Google-Smtp-Source: ABdhPJyOdFI+XiTPAElhc7UlbLNCcw0vH+mtjxAGfUQW5MqVSQpy/3zeUrbio5v1cnDPYnRWPSMNMA==
X-Received: by 2002:a17:906:aad8:: with SMTP id
 kt24mr4127743ejb.54.1589983547251; 
 Wed, 20 May 2020 07:05:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t16sm1927404edy.20.2020.05.20.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7C61D1FF8F;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/15] travis.yml: Use clang++ in the Clang tests
Date: Wed, 20 May 2020 15:05:29 +0100
Message-Id: <20200520140541.30256-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
---
 .travis.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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


