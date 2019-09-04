Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D31C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19336208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY0znVtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19336208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cjG-0002yS-DL
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3u-0000tx-Ck
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5c3s-0003Sw-Rk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5c3s-0003SH-K4
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:39:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id n10so249370wmj.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zp2HTd9MlExt3qm/dUKdQzcVkIb7wY5T3E7kKCEGd2M=;
 b=XY0znVtUJ3AiLRz5SacDhW9wVilqHGBCl3Pr3DKz5biFCZyDPBmj+09OPgh0M+IHoM
 Gydh9rjzHTdHfVEMupaZhPmo7gWtdJTUN0gMPFcg0YDAvOoW05O4RZnVC6dM40Rk0wpD
 y3Oh0Gm1LkXkdcQ7YF9WDa675JLVTrYuWPDvowYMTeGoUatHrU53vfkN2CaHdhCV5fP0
 P2ksvOmYnvNBGQe5Cf15NIyFDLWhER51E99kk8yhQ+dsMOxEV7i3SYpaJQG6/HpvUieV
 a3R4eAWqZHVDe9SQkHIYv2E9ZqzF0O5h5NKFAk+DKuSlKYZs1UzuyBy/OWMUN3MI5m6c
 OjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zp2HTd9MlExt3qm/dUKdQzcVkIb7wY5T3E7kKCEGd2M=;
 b=CfrwO5IVrVfZ8ROi/nmJeMWrixDbATe7MOpyUnFd4+eWm+pNNZ5nKZ0GzqNmVkgFFt
 AUh/xkHYhuN6VWYoMKFqPEvEFcdgXolcT/SjXi5xyhyvIX/T52nIZPHSi9v3br6hR8Zo
 mH0pU1sbVMfla9IHfxt3fm2qfLltHg8TJzn1HdiQWTYQ7IyXitTdyfSY5uegqcFpDoyq
 98SIiMMHave6MQGJdKKI47fYGGZxpqUKKhdlZneci5nL6wJWTmLSXaGzjxGE0pJJv33Y
 ObxOc7cm6OnFfcFASpJBqi13wlQSwWeqvQGHCkyq2vEMtIX3B/bKVYIf8bfZD1VPxrcT
 synQ==
X-Gm-Message-State: APjAAAXeRuqzYuOJrAqelLoRJnBs+0M9LMbM1+a9Zj2VbVufsm2z9D/f
 HJRix1+2wHF49FZa0c22NBt19r/ADuA=
X-Google-Smtp-Source: APXvYqxpZrijrmHWwC+Xpw8QRjye7gYqsjYy/UTE9tyQKbsZSlyE+5HZ/JRhZoKpgEMuMo1xjCtpeQ==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr111917wmj.57.1567629567453; 
 Wed, 04 Sep 2019 13:39:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm23134875wrj.74.2019.09.04.13.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:39:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 620AA1FFAA;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:52 +0100
Message-Id: <20190904203013.9028-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
Subject: [Qemu-devel] [PATCH v1 21/42] tests/docker: drop debian-sid image
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Debian Sid was only ever a stop gap and thanks to the much better
cross compiler in the Buster release we don't need it any more. Send
it on its merry way.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include              |  2 +-
 tests/docker/dockerfiles/debian-sid.docker | 41 ----------------------
 2 files changed, 1 insertion(+), 42 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index b6c04059502..59fbebbe2e6 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -6,7 +6,7 @@ DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian-ports debian-sid debian-bootstrap
+DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian8-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/dockerfiles/debian-sid.docker
deleted file mode 100644
index 513459ca7f8..00000000000
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ /dev/null
@@ -1,41 +0,0 @@
-#
-# Debian Sid Base
-#
-# A number of our guests exist as ports only. We can either use the
-# ports repo or get everything from Sid. However Sid is a rolling
-# distro which may be broken at any particular time. If you are
-# unlucky and try and build your images while gcc is in the process of
-# being uploaded this can fail. Your only recourse is to try again in
-# a few hours when the repos have re-synced. Once built however you
-# won't be affected by repo changes unless the docker recipies are
-# updated and trigger a re-build.
-#
-
-# This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20181011-slim
-
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20181030"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=noninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        flex \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
-- 
2.20.1


