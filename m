Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFEDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980072064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bn7F/n+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980072064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshkE-0006aj-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjE-0004uR-DS
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjB-000460-PJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id w3so32851995wmi.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HL9K/pMjzPXAmNS2D71Rv36Uwa+37eOIvWsGiIveaTM=;
 b=bn7F/n+RC+3vjGtfga5E/wUrB7ZdFkKtxGBMsxeKTXCCxX/Suztg+CYQqYM9qv6H1O
 XbIS7zUO86MW5U9lIuLNm0R3HgzHunus4C/stzHvxcR6eB3aexCB6PQAIG9/N/xNiu7D
 XIlKshrmZfCmMmGoGbSmckVADf9gJLx1RwOIMMyxGVmaqvQozQro6ARcceNAizUGOS2b
 rSmiQTveAdACg9GiaZWNq2uGL/ycX/Sm06FQzg7e427RwLTHG48wS/jaENby/GhrVzTU
 Iour9hc+LpVe0kd3QPYcJHoZuV53jhmwy9W9p/QUGUYYqnm3DZAe7fmP2WGF8pm+4JQf
 mwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HL9K/pMjzPXAmNS2D71Rv36Uwa+37eOIvWsGiIveaTM=;
 b=S9IlmeGrtMdHHDQW9T0en0MmSEtsC5Ei8dfNLYtnUvosqqqIDdNdaLZG7xKvkyVzNK
 ef4QOzQsKZPaOVZ5OFLxsZ5/a8XN6v8/p0AkjVJWCEXfDAUGvnnL9mv/LSH4mE0uQ05U
 7kjVVZVL1bOc3KMvXEvzBEkdTKHa6XfMHvmrX2/mdtJBcUQ8ta2IuTDsumpZASQsOZ/o
 JSxfNaikrrBbEUsu5R6rJ9FtWv7QXN4UY6dAk0MKQbGXoj3zn14V0xCLOwmMXfvcX8Za
 MtwmxNMFj7haC9+Ch3nQYvwhSoCl3/3Io4PgFU9e1dy+P1vzHW+FogHPWEeHi2umGYQp
 jdVQ==
X-Gm-Message-State: AOAM533XZmmtCbzDHtxKbbwr/FQoRS4sa0Me1e1NgpyRphsfcYallxCz
 F5zZf9k70RJVzmanfJ/8xl67Xw==
X-Google-Smtp-Source: ABdhPJyXZ8ZrZYaW+PFAhwLBQt4BI5pV/GCbdPJ78RGUN2Egujzrefbedmy9qbY/rieYbo0IAsrUpw==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr2593000wme.187.1594105755793; 
 Tue, 07 Jul 2020 00:09:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm2257659wme.31.2020.07.07.00.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 20C921FF9E;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/41] tests/docker: change tag naming scheme of our images
Date: Tue,  7 Jul 2020 08:08:32 +0100
Message-Id: <20200707070858.6622-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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

Message-Id: <20200701135652.1366-18-alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 2cce7b568905..81905727d14c 100644
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
index 3e3617816ec6..e23b4af20ea6 100644
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
index e630aae10897..cc6f76caa602 100755
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
index 74bcabfdb12b..10fe30df0dd1 100644
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
index 5d8904192519..870109ef6afe 100644
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
index 957f0bc2e79b..8fdfd6a6b046 100644
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
index 09ca0a1ba797..166e24df138c 100644
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
index a44e76d94211..53a9012beb8a 100644
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
index e3794a61c959..b7b1a3585f8d 100644
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
index e163b8b95699..25d76188337f 100644
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
index 5c68b2d3304a..3d6c65a3efcf 100644
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
index 25edc80e9a3d..fcb10e353475 100644
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
index 08a8e1c29cca..26c154014db2 100644
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
index 1a79505d696a..09c2ba584e51 100644
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
index 453b53ef72c8..c990b683b7a1 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -4,7 +4,7 @@
 # This docker target builds on the debian Stretch base image.
 #
 
-FROM qemu:debian10
+FROM qemu/debian10
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 3b6e975c686d..0e5dd42d3c4b 100644
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
index 89dd4fbf8708..07e1789650b7 100644
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
index 4bf88ab02dd0..8efe68874ed6 100644
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
index cd386f01d93c..1146a06be625 100644
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
index 5e2d6ddb6004..2bbff19772a3 100644
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
index 43fe59836f25..9f2ab51eb09a 100644
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
index 9d7663764e4d..fd3af8957596 100644
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
index 31fd34f120b2..f4bb9b561cfa 100644
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
index 4a0f7706a39a..769d95c77bb2 100644
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
index d16d6431bc8b..b045e821b910 100644
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
index b0bc960445b7..2fc9cfcbc663 100644
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
index 62ff1cecf2d2..ae2c222a6f08 100644
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
index 9c23aeaa2a64..f8ad4c47be69 100644
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


