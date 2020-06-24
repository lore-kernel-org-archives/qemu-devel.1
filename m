Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34162C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31402076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyyFrqkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31402076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6F9-0007yt-7J
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61c-0005NH-3M
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo61Z-0003Yc-Pu
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:05:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so2441419wmi.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2kkJsCsmjZ6u2MwSGAsWWjkvARamWfB9kpoiOtV7oLc=;
 b=hyyFrqkwGkLUP6+PLih+TsKY3F1hRXCmQnL3uNwg+PEUaF6E3v9AjGMEkY9lZPtp2a
 8Gdw9waGFQfkVBvOMxd9ruWCt88vlCIMcUnSkcheK0weGnBzp8ZVQJvwphKInmH1eGTa
 19vXG7TrgTbRcsuuETPhHYqXad+A1N+eIRnTH8h6UzD+ZYDK9TyDjuj8TjLIt2HEUHup
 1l/QWIoD86xLuP9WF7cj02bXwiVzPNClhwDFFUDY3ETJ5xiwVq2G8f2XgxI0bwTsUxDk
 l1oiPnoEmt5t7QnhS9VijNQSdNe0RJ0DGm7pOfM4cJzmwc1Nygch87UGKZI0Z01pm9Ya
 vgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2kkJsCsmjZ6u2MwSGAsWWjkvARamWfB9kpoiOtV7oLc=;
 b=DjGQn6wZtB2zcP9LDkiyHTJB+vsQGz2D0HcAv18a+n05iTdJkcm+h6zyip0FxSIwsV
 r6M+SLITKUjwnGtfzoD3Tq+kSvxQtK6ZMbP3Mplb0daRfFeyWyMykPVzfptUmjTo93r+
 RU9wCbATrWlSHfWjOPjpEvUOaf0UxzDskhEgZ3J8NgtbVjR/ygICV8vkges73UHa2qT2
 YmpEdX4ajIwKDLNPHxFLrNcsdELpa/3BJehjIQLFtjzKx6b7xwaCl9LUIy48cKA8FY3G
 R+IHlTkGoiv3SnfLJ3LCh9CAUbnzkjCVOLUIzqEkC8kTfNFANdOkm6rvvqiygBRpExIQ
 ryDw==
X-Gm-Message-State: AOAM533ASOKrWcaiZT7sayQLylrgZO9Om/t/414/A2yDNCnjDCkcCtOs
 Nxa1PjSwA5yxb3CNpKpmszRqDg==
X-Google-Smtp-Source: ABdhPJwRBBTtjZgt0tLwhGppgBW+fPaGwhlUnFB9SHuqwSWt0XJB9tnKM5KWlSvQOZg+QkHHb8s/2Q==
X-Received: by 2002:a7b:c926:: with SMTP id h6mr27226435wml.184.1593007511369; 
 Wed, 24 Jun 2020 07:05:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r1sm18997755wrt.73.2020.06.24.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:05:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 707F51FFAA;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 21/25] tests/docker: add --registry support to tooling
Date: Wed, 24 Jun 2020 15:04:42 +0100
Message-Id: <20200624140446.15380-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

This allows us to point the tools towards a registry from which they
can grab pre-built layers instead of doing everything from scratch
each time. To enable this we need to be using the DOCKER_BUILDKIT
engine.

[AJB: note registry.gitlab.com/stsquad/qemu is for my testing, the
final version will see DOCKER_REGISTRY default to registry.gitlab.com/qemu-project/qemu]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include |  3 +++
 tests/docker/docker.py        | 25 +++++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7bac1a67e3e..4c5ebc6197f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -13,6 +13,7 @@ DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.doc
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
+DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),registry.gitlab.com/stsquad/qemu)
 
 DOCKER_TESTS := $(notdir $(shell \
 	find $(SRC_PATH)/tests/docker/ -name 'test-*' -type f))
@@ -57,6 +58,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build -t qemu/$* -f $< \
 		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
+		$(if $(DOCKER_REGISTRY),--registry $(DOCKER_REGISTRY)) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
@@ -213,6 +215,7 @@ endif
 	@echo '                         Include extra files in image.'
 	@echo '    ENGINE=auto/docker/podman'
 	@echo '                         Specify which container engine to run.'
+	@echo '    REGISTRY=url         Cache builds from registry (default:$(DOCKER_REGISTRY))'
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index cc6f76caa60..09dedbf83f9 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -221,6 +221,8 @@ class Docker(object):
     """ Running Docker commands """
     def __init__(self):
         self._command = _guess_engine_command()
+        if "docker" in self._command:
+            os.environ["DOCKER_BUILDKIT"] = "1"
         self._instance = None
         atexit.register(self._kill_instances)
         signal.signal(signal.SIGTERM, self._kill_instances)
@@ -289,10 +291,16 @@ class Docker(object):
         return labels.get("com.qemu.dockerfile-checksum", "")
 
     def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None, extra_files_cksum=[]):
+                    quiet=True, user=False, argv=None, registry=None,
+                    extra_files_cksum=[]):
         if argv is None:
             argv = []
 
+        if registry is not None:
+            dockerfile = dockerfile.replace("FROM qemu/",
+                                            "FROM %s/qemu/" %
+                                            (registry))
+
         tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
                                              encoding='utf-8',
                                              dir=docker_dir, suffix=".docker")
@@ -313,8 +321,14 @@ class Docker(object):
 
         tmp_df.flush()
 
-        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv +
-                       [docker_dir],
+        build_args = ["build", "-t", tag, "-f", tmp_df.name]
+        if registry is not None:
+            cache = "%s/%s" % (registry, tag)
+            build_args += ["--cache-from", cache]
+        build_args += argv
+        build_args += [docker_dir]
+
+        self._do_check(build_args,
                        quiet=quiet)
 
     def update_image(self, tag, tarball, quiet=True):
@@ -403,6 +417,8 @@ class BuildCommand(SubCommand):
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
+        parser.add_argument("--registry", "-r",
+                            help="cache from docker registry")
         parser.add_argument("-t", dest="tag",
                             help="Image Tag")
         parser.add_argument("-f", dest="dockerfile",
@@ -458,7 +474,8 @@ class BuildCommand(SubCommand):
                      for k, v in os.environ.items()
                      if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, user=args.user, argv=argv,
+                            quiet=args.quiet, user=args.user,
+                            argv=argv, registry=args.registry,
                             extra_files_cksum=cksum)
 
             rmtree(docker_dir)
-- 
2.20.1


