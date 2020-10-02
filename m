Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A717B206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNsiI6A2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A717B206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJTa-0004BE-PL
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNH-0006uO-0m
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007ck-9W
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id z4so1450212wrr.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FdZVboiRsX0vwAb55bJ/MQ8ltmQwJ2NTTvZnOTUpUYc=;
 b=jNsiI6A2XhH2a2c9Dxy3v8bNCATZSXWLouRDx+BUlHHgCER61+1ToOzJb0PgQWourX
 3YvUhDo/NhiH/wnxlxsKQ6MRnCC/jDraV6UDeODwZ6ycQgtih0mSmDGNFJXbXiAVA16Z
 F3fxb+sBGTneXLK4z3aIcWWEaz8O1a0FK183cVGuB2SKkjoPDF9SoEFlFuNsrxk1A3wV
 Iy0M1c2Mrgwh8M8GzZDGniIHth1M20TmG4F7B4R8FqXQJOz/5nJboJQd+X1UP1x4GLwR
 K/K0zGKDob17rqMrA3mcw+KAyPN0AC1rPEYblxeU79g/zQicLbodiAAnT6erELF5a/I+
 lOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FdZVboiRsX0vwAb55bJ/MQ8ltmQwJ2NTTvZnOTUpUYc=;
 b=flo2bOq2bqJdMUeO+pAyqtYoUhLcXhjQxERo2yamoo/J0RS1BA6wmL7ebsW9OXNR37
 ecUgVsdTYsteIyhHhoVbTkl4nRMABSXe5k6YPPmUlTZ4HQrxYVmWI/lTtGU2cuuJj5uZ
 ft8HqwLlFnMYbLi64A1OVVmU9ayuibcWG1539/0kSHngDSfBHHSFs4A0oE0nk5VaRqg6
 FZa8I2qdv+6Equ0BthPWDxFONopFOzwaXAepMHSsOCub3axqEqWH1/H/dk2vZgF+u3ie
 o2Gxm52XOLtEl/T0Fc9VKxilU01Pu4EmROVrCXaOr4Q6Kz8YWMTOb6p6ip7oNsVKjP1z
 53Tg==
X-Gm-Message-State: AOAM533f8T3af7OH4vRUDfOrLFQ89syEvdEHJXFLKlfnYYG6GAWs1faK
 ueIzewMw8uqCYlffaScC/rDICw==
X-Google-Smtp-Source: ABdhPJxwJ07QI3oja8/RwKOF12OJak5t3ILAxRC9CURtP1+sfrXPHp5eLT1G1nLxLOJbJRTKMpM7EA==
X-Received: by 2002:adf:f106:: with SMTP id r6mr2622378wro.106.1601638619647; 
 Fri, 02 Oct 2020 04:36:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u127sm1627800wmu.48.2020.10.02.04.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AC8531FF96;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 08/14] tests/docker: Update the tricore container to debian 10
Date: Fri,  2 Oct 2020 12:36:39 +0100
Message-Id: <20201002113645.17693-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We do not support Debian 9 anymore, thus update the Tricore container
to Debian 10 now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200921174320.46062-4-thuth@redhat.com>
Message-Id: <20200925154027.12672-12-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 6769eef0ff..089cea7c14 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -210,7 +210,7 @@ sparc64-debian-cross-container:
 tricore-debian-cross-container:
   <<: *container_job_definition
   stage: containers-layer2
-  needs: ['amd64-debian9-container']
+  needs: ['amd64-debian10-container']
   variables:
     NAME: debian-tricore-cross
 
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 75704268ff..02ec92830b 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -137,7 +137,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
-docker-image-debian-tricore-cross: docker-image-debian9
+docker-image-debian-tricore-cross: docker-image-debian10
 docker-image-debian-all-test-cross: docker-image-debian10
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 769d95c77b..985925134c 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,7 +7,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM qemu/debian9
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
-- 
2.20.1


