Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A9820836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaI3vD6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A9820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot6W-0006rH-I2
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0B-0003d6-4T
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot08-00054h-Hw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id 17so10233512wmo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7QeBZdYC9ESv3VbweN3wgD6BXczlT/siekZ5tWA8J1E=;
 b=vaI3vD6tuBxvcLEzXTfmrc2AJaEtHGuLPAtS4/zbacfG1NYP+ErhpahEIhwEE8vqYL
 AuXnxdzAnrrk538tzykmlNSX1o9fWhgBOwKTaz6Nk5iED+bSHA755th0HqQo4IUEBt/t
 JI/uqyV1TR3qEMD+vLbNXJ42ZaIf8sT7vX4f9CAkRwFPw8wEYqaNdYZxgyjC39NFYa8j
 F20mefjUdQcJkq7jECv/BB1eT78G5rO16jc87paeEHFihcourJdHxCFLL6T81hw1Ef5A
 ExjTnrxsOWrZpyGPtS6+Yjt1ULfsBEEYxMWvOiQhipNYt6sNwDsTcg6sMW1VrFlHXysv
 HRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7QeBZdYC9ESv3VbweN3wgD6BXczlT/siekZ5tWA8J1E=;
 b=Os7mAqEcnxykxhTnnvSX8gcnyviplWHsQXFgnUQlOZ1RNxySpCXnFtBbDD9GlT7pyL
 9xc1ZD+IHIrdR9O7PGf+GaGxucu/AlWizNplFHgFwYGPTRalSY2tqEtkR9kYX2ZLNap/
 dP7748LN/MbQk1lTrh1M1UtJqvpzIimO17+rqCbkGKkhuA+5szS6jrAb+cuOzVWrWkAz
 i4pVTBpJt+Zn2WLi47b5Z+BCWkCZHe27y/HSzZHUKhOU/EWdp719f5PA7eFgFIL5Bz5M
 YDWI8Lv83F0S/Y6h6fb3lrVVY21CDoiS8qAu6dMGPtriix3XojH42tDmOLbDj5qlLULs
 X5Tg==
X-Gm-Message-State: AOAM532v0GsRsYhoATPUP584Is+xIRdMoXDDJIzgCiKGuhUnJnRkeNqg
 AqNV2a9B/K1aenXLwj9sNIPxbe2FDU8=
X-Google-Smtp-Source: ABdhPJxU8HmdJUVbZnfnEkEr1LIgBH5HTJ3UXpxwM7tbMS6ZRpArom5GfAn4b0V55umtONmq6xu/wA==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr5048226wmj.161.1593195778728; 
 Fri, 26 Jun 2020 11:22:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 33sm31337760wri.16.2020.06.26.11.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13EFC1FF9D;
 Fri, 26 Jun 2020 19:14:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/30] tests/docker: change tag naming scheme of our images
Date: Fri, 26 Jun 2020 19:13:42 +0100
Message-Id: <20200626181357.26211-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've been misusing the tag naming scheme for some time by overloading
the post : section with the image type. Really it should be saved for
the revision of that particular build. Move the details to the other
side so we have:

  qemu/image-name

with the implied :latest version added by the tooling.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix RUN invocation as well
  - don't include :latest tag for debian-arm64-cross (implied)
---
 tests/docker/Makefile.include                           | 4 ++--
 tests/docker/docker.py                                  | 2 +-
 tests/docker/dockerfiles/debian-alpha-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-amd64.docker            | 2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-arm64-test-cross.docker | 2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-hppa-cross.docker       | 2 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker       | 2 +-
 tests/docker/dockerfiles/debian-mips-cross.docker       | 2 +-
 tests/docker/dockerfiles/debian-mips64-cross.docker     | 2 +-
 tests/docker/dockerfiles/debian-mips64el-cross.docker   | 2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker     | 2 +-
 tests/docker/dockerfiles/debian-powerpc-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-ppc64-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-riscv64-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-sh4-cross.docker        | 2 +-
 tests/docker/dockerfiles/debian-sparc64-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-tricore-cross.docker    | 2 +-
 tests/docker/dockerfiles/debian-win32-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian-win64-cross.docker      | 2 +-
 tests/docker/dockerfiles/debian9-mxe.docker             | 2 +-
 26 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3e3617816ec..6d6ced1e463 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -55,7 +55,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
-		$(DOCKER_SCRIPT) build -t qemu:$* -f $< \
+		$(DOCKER_SCRIPT) build -t qemu/$* -f $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
@@ -258,7 +258,7 @@ docker-run: docker-qemu-src
 docker-run-%: CMD = $(shell echo '$@' | sed -e 's/docker-run-\([^@]*\)@\(.*\)/\1/')
 docker-run-%: IMAGE = $(shell echo '$@' | sed -e 's/docker-run-\([^@]*\)@\(.*\)/\2/')
 docker-run-%:
-	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu:$(IMAGE)
+	@$(MAKE) docker-run TEST=$(CMD) IMAGE=qemu/$(IMAGE)
 
 docker-clean:
 	$(call quiet-command, $(DOCKER_SCRIPT) clean)
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e630aae1089..cc6f76caa60 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -204,7 +204,7 @@ def _dockerfile_preprocess(df):
     for l in df.splitlines():
         if len(l.strip()) == 0 or l.startswith("#"):
             continue
-        from_pref = "FROM qemu:"
+        from_pref = "FROM qemu/"
         if l.startswith(from_pref):
             # TODO: Alternatively we could replace this line with "FROM $ID"
             # where $ID is the image's hex id obtained with
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
index 74bcabfdb12..10fe30df0dd 100644
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 5d890419251..870109ef6af 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -4,7 +4,7 @@
 # This docker target is used on non-x86_64 machines which need the
 # x86_64 cross compilers installed.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 MAINTAINER Alex Bennée <alex.bennee@linaro.org>
 
 # Add the foreign architecture we want and install dependencies
diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index 957f0bc2e79..8fdfd6a6b04 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image. Further
 # libraries which are not widely available are installed by hand.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 RUN apt update && \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 09ca0a1ba79..166e24df138 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
diff --git a/tests/docker/dockerfiles/debian-arm64-test-cross.docker b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
index a44e76d9421..53a9012beb8 100644
--- a/tests/docker/dockerfiles/debian-arm64-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-test-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Bullseye base image.
 #
-FROM qemu:debian11
+FROM qemu/debian11
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture arm64
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index e3794a61c95..b7b1a3585f8 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
 # Add the foreign architecture we want and install dependencies
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index e163b8b9569..25d76188337 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture armhf
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles/debian-hppa-cross.docker
index 5c68b2d3304..3d6c65a3efc 100644
--- a/tests/docker/dockerfiles/debian-hppa-cross.docker
+++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-m68k-cross.docker b/tests/docker/dockerfiles/debian-m68k-cross.docker
index 25edc80e9a3..fcb10e35347 100644
--- a/tests/docker/dockerfiles/debian-m68k-cross.docker
+++ b/tests/docker/dockerfiles/debian-m68k-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-mips-cross.docker b/tests/docker/dockerfiles/debian-mips-cross.docker
index 08a8e1c29cc..26c154014db 100644
--- a/tests/docker/dockerfiles/debian-mips-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-mips64-cross.docker b/tests/docker/dockerfiles/debian-mips64-cross.docker
index 1a79505d696..09c2ba584e5 100644
--- a/tests/docker/dockerfiles/debian-mips64-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 453b53ef72c..c990b683b7a 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image.
 #
 
-FROM qemu:debian10
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 3b6e975c686..0e5dd42d3c4 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
index 89dd4fbf870..07e1789650b 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/docker/dockerfiles/debian-ppc64-cross.docker
index 4bf88ab02dd..8efe68874ed 100644
--- a/tests/docker/dockerfiles/debian-ppc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
@@ -2,7 +2,7 @@
 # Docker ppc64 cross-compiler target
 #
 # This docker target builds on the debian Buster base image.
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index cd386f01d93..1146a06be62 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 # Add the foreign architecture we want and install dependencies
 RUN dpkg --add-architecture ppc64el && \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 5e2d6ddb600..2bbff19772a 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 43fe59836f2..9f2ab51eb09 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 # Add the s390x architecture
 RUN dpkg --add-architecture s390x
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
index 9d7663764e4..fd3af895759 100644
--- a/tests/docker/dockerfiles/debian-sh4-cross.docker
+++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-sparc64-cross.docker b/tests/docker/dockerfiles/debian-sparc64-cross.docker
index 31fd34f120b..f4bb9b561cf 100644
--- a/tests/docker/dockerfiles/debian-sparc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-sparc64-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian10
+FROM qemu/debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 4a0f7706a39..769d95c77bb 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -7,7 +7,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM qemu:debian9
+FROM qemu/debian9
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index d16d6431bc8..b045e821b91 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian9-mxe
+FROM qemu/debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index b0bc960445b..2fc9cfcbc66 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch MXE base image.
 #
-FROM qemu:debian9-mxe
+FROM qemu/debian9-mxe
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian9-mxe.docker b/tests/docker/dockerfiles/debian9-mxe.docker
index 62ff1cecf2d..ae2c222a6f0 100644
--- a/tests/docker/dockerfiles/debian9-mxe.docker
+++ b/tests/docker/dockerfiles/debian9-mxe.docker
@@ -3,7 +3,7 @@
 #
 # This docker target builds on the debian Stretch base image.
 #
-FROM qemu:debian9
+FROM qemu/debian9
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
-- 
2.20.1


