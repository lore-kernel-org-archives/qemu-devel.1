Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D7EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB636207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlZqqqm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB636207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdZM-0005bJ-6S
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL6-0005Mk-9C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdL3-0006ry-EB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id h5so23978899wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FuCHGM7iRPlVOeoJ1tjdyPktkHWpC0K3uPbBotufS80=;
 b=MlZqqqm9G6O9sqstXhGYxF/OkJndDqcWI//lBY5GYZ5bDUD88A1bXIMjJHdEhRR/zY
 tZ6mnZ5GuYKDdQ8wjagb4Gzrr+nV04IckwXIO3KXxKBWlAwlrOEmUW78G0uh8AJfx0cO
 Wwa7VanNuR7m9tLHV5sLm0mM71pTDdDYtdylD2UuQqra/b2lnTV3pPpQ55+B9SpCD5x4
 3hmqwGNYgBHr8nT+7yMfhPB+heRUm9ofDti+z3A6iKDc5ZNMtfz1Co+lAOAobEAWbEYR
 XM+ImJWQqZITaJ9e3R83KGmgaJ0ME07wjoPou1HHvMKYpym2NUi+Zhp7AyLhP3IbYKn7
 gMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FuCHGM7iRPlVOeoJ1tjdyPktkHWpC0K3uPbBotufS80=;
 b=ah9Er5Q26XEULEvhohNA4ZzHukBi9JiDJdjK+YgvHFYXZnjYgYmMSrxrDIxKAtm2B5
 tQ5K0L/OBhm5OEJdhX5flZD5PSAIZOv40egKiZ4Ked9o7V6xAxEHVA9aSCX3dU9txKjR
 l8C7vpxgrAGnjNKdHezBVCrBCirvOdl2TmbTPP5uHKrMvozc9xpvgIxtGBV3CcSVeqwG
 cnr96/7qvi7ImEqQ9MFPechrZnS8EmzAF2oVu4rjNEvrLBIU53htBLNxueVx0GjSOPbo
 3/h09XzgXi8bfhFuqbtpZ+5eCdKf3CLM7lHxQaXe0iAtYc4OyIj1EbQ+mAcQ/TZInczj
 TnwQ==
X-Gm-Message-State: AOAM530KQ/4VDyqA8D3/Yldq2k16CVnQt6bjO0QbWK3SbmSC4xBcPGcW
 LIeNuiJbz6/QLoSmK2rDBsvYug==
X-Google-Smtp-Source: ABdhPJwroKDqIL6VY/Tc4zRXtX5w0KvviCFBF/YjvGf6wf9WFRuZfpRlXnYtA/5FqgWV2PrPxAHgMg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr26575847wro.163.1593612227606; 
 Wed, 01 Jul 2020 07:03:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 65sm7992176wma.48.2020.07.01.07.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B06ED1FFA5;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 17/40] tests/docker: change tag naming scheme of our images
Date: Wed,  1 Jul 2020 14:56:29 +0100
Message-Id: <20200701135652.1366-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v2
  - fix RUN invocation as well
  - don't include :latest tag for debian-arm64-cross (implied)
v4
  - fix up check and compile cases as well
  - also tweak shippable references
---
 .shippable.yml                                         |  4 ++--
 tests/docker/Makefile.include                          | 10 +++++-----
 tests/docker/docker.py                                 |  2 +-
 tests/docker/dockerfiles/debian-alpha-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-amd64.docker           |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker     |  2 +-
 .../docker/dockerfiles/debian-arm64-test-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-armel-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-hppa-cross.docker      |  2 +-
 tests/docker/dockerfiles/debian-m68k-cross.docker      |  2 +-
 tests/docker/dockerfiles/debian-mips-cross.docker      |  2 +-
 tests/docker/dockerfiles/debian-mips64-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-mips64el-cross.docker  |  2 +-
 tests/docker/dockerfiles/debian-mipsel-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-powerpc-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-ppc64-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-riscv64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-sh4-cross.docker       |  2 +-
 tests/docker/dockerfiles/debian-sparc64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-tricore-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-win32-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian-win64-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian9-mxe.docker            |  2 +-
 tests/tcg/Makefile.qemu                                |  4 ++--
 28 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 2cce7b56890..81905727d14 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -29,8 +29,8 @@ build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
   pre_ci_boot:
-    image_name: qemu
-    image_tag: ${IMAGE}
+    image_name: qemu/${IMAGE}
+    image_tag: latest
     pull: false
     options: "-e HOME=/root"
   ci:
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 3e3617816ec..e23b4af20ea 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -50,12 +50,12 @@ docker-image: ${DOCKER_TARGETS}
 ifdef SKIP_DOCKER_BUILD
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command, \
-		$(DOCKER_SCRIPT) check --quiet qemu:$* $<, \
+		$(DOCKER_SCRIPT) check --quiet qemu/$* $<, \
 		"CHECK", "$*")
 else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
-		$(DOCKER_SCRIPT) build -t qemu:$* -f $< \
+		$(DOCKER_SCRIPT) build -t qemu/$* -f $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
@@ -75,14 +75,14 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_ARCH=$(DEB_ARCH)					\
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
-			$(DOCKER_SCRIPT) build qemu:debian-$* $< 		\
+			$(DOCKER_SCRIPT) build qemu/debian-$* $< 		\
 			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
 			"BUILD","binfmt debian-$* (debootstrapped)"),		\
 		$(call quiet-command,						\
-			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $< || 	\
+			$(DOCKER_SCRIPT) check --quiet qemu/debian-$* $< || 	\
 			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
 			"CHECK", "debian-$* exists"))
 
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
 
diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
index 9c23aeaa2a6..f8ad4c47be6 100644
--- a/tests/tcg/Makefile.qemu
+++ b/tests/tcg/Makefile.qemu
@@ -47,7 +47,7 @@ ifneq ($(DOCKER_IMAGE),)
 
 DOCKER_COMPILE_CMD="$(DOCKER_SCRIPT) cc \
 		--cc $(DOCKER_CROSS_CC_GUEST) \
-		-i qemu:$(DOCKER_IMAGE) \
+		-i qemu/$(DOCKER_IMAGE) \
 		-s $(SRC_PATH) -- "
 
 .PHONY: docker-build-guest-tests
@@ -57,7 +57,7 @@ docker-build-guest-tests: docker-image-$(DOCKER_IMAGE)
 	   $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC=$(DOCKER_COMPILE_CMD) \
 			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=y \
 			EXTRA_CFLAGS="$(CROSS_CC_GUEST_CFLAGS)"), \
-	"BUILD","$(TARGET) guest-tests with docker qemu:$(DOCKER_IMAGE)")
+	"BUILD","$(TARGET) guest-tests with docker qemu/$(DOCKER_IMAGE)")
 
 GUEST_BUILD=docker-build-guest-tests
 
-- 
2.20.1


