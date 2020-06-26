Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B386AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 832D720836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq7GKvjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832D720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot3N-0001Y9-Nu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0J-0003ya-66
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0H-0005At-Ak
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so9646049wme.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wmP5rJyYoOCoZ0LFVlYt2bUhEVWWIR3nI4aOboxhEsg=;
 b=Cq7GKvjG1iP9m15jaJRRqzkrMyzlGoO9JP9BD9RFFbt1k8sPa3WMGpTLg5vqJ/MDQe
 x34zGbVeky6/ncqBgBiOf5lXtnm6KPzyGEGy6B11YsVKR4peucryaPgVwjLjAm97R8kg
 tUbRkypLYOlpKYlnSUm+zr6lnnPGRb1FuNlhtxXdLNnh20K6nZ5hL1fFeKhoWEwBs5Y6
 QEMN+8Aa/l2t8tPeqWgWgkBVCvHFqR+ugIUQrI4MNoqQbz0DzhWDw5vRkBiLipku3RWV
 Yt6UYY019ZqP4Vy2IbzE0Sf+tDo9nWPyKHeYHInYU5d4MUCvEnBQd2A3nEutNqwBJlNC
 xmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wmP5rJyYoOCoZ0LFVlYt2bUhEVWWIR3nI4aOboxhEsg=;
 b=SHxb0mjI+V3dWD/LgOpqMKLe83onnveTSx6rVGDjCIM6N1dKyvOCcY1MpxE9qCxLRI
 SF44VzHdKiVujSnwwFuSek69BMSHdE5sEROw3KyizwCPqd4JTJZBVIrFXgu5enBvI1A2
 SyTfx/uNZ0KKXI3LbucabvIEw/gqIzhhUH6iYjtIxjfaTZNTMqpWZkOXmqmYlE042pKw
 XXnw9L/jOUCbXR+4/PEHTj5MCrn809tc1dt4ScuGN2QWiRschG7PGQg2gNL1igj49DaP
 JucgOp/R/9usGVOmMOIQFeK9X/eunyox1MNuJaWXx/xcardQq3B/8XvKbn0VTM7CpG3p
 UCtw==
X-Gm-Message-State: AOAM533mH0NgYtGIb/Glv+gaUFJvZ/nMEe4Czr9DlrvVIYd0WlT6x9Wk
 qNEkNgINj5UIXPddd7YQ8v9dZA==
X-Google-Smtp-Source: ABdhPJyHSj2zSJ8wI4Usj/VwG+B3hnAbYiue9gA/3FjBGMvMKj5o4dym3GWX3AhWxWK2Fqd5zwgbvg==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr5005421wmk.171.1593195787882; 
 Fri, 26 Jun 2020 11:23:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e17sm2311444wrr.88.2020.06.26.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:59 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B26D1FF8C;
 Fri, 26 Jun 2020 19:14:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 22/30] tests/docker: add --registry support to tooling
Date: Fri, 26 Jun 2020 19:13:49 +0100
Message-Id: <20200626181357.26211-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
v2
  - add a pull stage to pull images from the registry
  - enable BUILDKIT and BUILDKIT_INLINE_CACHE
  - don't invoke BUILDKIT on Travis
---
 tests/docker/Makefile.include |  3 +++
 tests/docker/docker.py        | 37 +++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 6d6ced1e463..8139e8467d4 100644
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
index cc6f76caa60..a31ac287150 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -221,6 +221,13 @@ class Docker(object):
     """ Running Docker commands """
     def __init__(self):
         self._command = _guess_engine_command()
+
+        if "docker" in self._command and "TRAVIS" not in os.environ:
+            os.environ["DOCKER_BUILDKIT"] = "1"
+            self._buildkit = True
+        else:
+            self._buildkit = False
+
         self._instance = None
         atexit.register(self._kill_instances)
         signal.signal(signal.SIGTERM, self._kill_instances)
@@ -289,10 +296,20 @@ class Docker(object):
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
+            # see if we can fetch a cache copy, may fail...
+            pull_args = ["pull", "%s/%s" % (registry, tag)]
+            self._do(pull_args, quiet=quiet)
+
+
         tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
                                              encoding='utf-8',
                                              dir=docker_dir, suffix=".docker")
@@ -313,8 +330,17 @@ class Docker(object):
 
         tmp_df.flush()
 
-        self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv +
-                       [docker_dir],
+        build_args = ["build", "-t", tag, "-f", tmp_df.name]
+        if self._buildkit:
+            build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
+
+        if registry is not None:
+            cache = "%s/%s" % (registry, tag)
+            build_args += ["--cache-from", cache]
+        build_args += argv
+        build_args += [docker_dir]
+
+        self._do_check(build_args,
                        quiet=quiet)
 
     def update_image(self, tag, tarball, quiet=True):
@@ -403,6 +429,8 @@ class BuildCommand(SubCommand):
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
+        parser.add_argument("--registry", "-r",
+                            help="cache from docker registry")
         parser.add_argument("-t", dest="tag",
                             help="Image Tag")
         parser.add_argument("-f", dest="dockerfile",
@@ -458,7 +486,8 @@ class BuildCommand(SubCommand):
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


