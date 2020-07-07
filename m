Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91DF2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsCfuK56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91DF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi1o-0007OZ-0r
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxs-0001VM-5X
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxq-0006g7-2W
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id o11so44048423wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i8mLxxoVe+bccZ+lmxE5XmxcSbQk6bfwvCsechC4WCI=;
 b=SsCfuK56XDpHfsz/Ud4PuNLGmwoPpo5rs4KP1O07QUtotxAHkDantf/MV8qVPYvfF+
 ZOFvRpUnLbfNrQHq0baGtjVMCSd0PaPiPBzMMO6Jlw3kvAz7AX1iCFhC5A5TMonf/ZoL
 Pby1/DKTaqb5FN80PQlqF32zSyCfZs0ezh8LApJR385syce4lD2EsyLR9OEanPWS3Wh3
 uVmOdON71H9fdaBdfZeI8n5eRTI5Fw5Zy/ZviUEhjb1SyrsA8w+4M3CGF4XPZrhJeAdX
 X1OnmNpdHAqTjA1xvFQlqutdHNqrxwmofxEmxKodrDilMek0uw7RLjgebWGKxb9k8jrj
 53Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i8mLxxoVe+bccZ+lmxE5XmxcSbQk6bfwvCsechC4WCI=;
 b=K0IDLEzxNO1brBExDwK4tOA7E3Lxerq8SmYSom7U3ZMnM42E0oJzxAy7d0RiF6yIzL
 yBCcVpN/uDNIU7VtxX3jr7S0O+H4AV+0G0jXXOokTqrQQuY3/Qrkxk3Lub0ZzJxipura
 g15uN9TL+xIZI2hTh6EZ70amoDLVTxULdeMbQeUSDohzqsErb3zdUHepHa5QV0jglDuT
 9ZrLm3UlQGKIL7pWIkMKH7oN2HH3LONtK81Mzj6E1CCFk+5MabvH4oMXxusNdnECqS/s
 xX2Q6JwFvy/Df1HFRC/A/wtRwqJy2wcWRpxypN/vle+X7IYGKO7j/ZW0S7wmuAXb/WkS
 9ZEQ==
X-Gm-Message-State: AOAM53063aYUqCgyE/oFweKSZkVZv09bAIZV8fg/w77c/b7ojqBE1vyQ
 fD7hii01ZGc4whAXkyMfpD4UPA==
X-Google-Smtp-Source: ABdhPJwKt99sQUbdtz1HBAVmxMtnDNZFiEFejKECzluvX6cuilc+75Bz6mJqhUIFUqlwMRX/eNDaSg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr16959655wrv.328.1594106664628; 
 Tue, 07 Jul 2020 00:24:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm2281208wmk.9.2020.07.07.00.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:24:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C16F01FFAB;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 22/41] tests/docker: add --registry support to tooling
Date: Tue,  7 Jul 2020 08:08:39 +0100
Message-Id: <20200707070858.6622-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows us to point the tools towards a registry from which they
can grab pre-built layers instead of doing everything from scratch
each time. To enable this we need to be using the DOCKER_BUILDKIT
engine.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200701135652.1366-25-alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e23b4af20ea6..a26177abc258 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -13,6 +13,7 @@ DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.doc
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
+DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),registry.gitlab.com/qemu-project/qemu)
 
 DOCKER_TESTS := $(notdir $(shell \
 	find $(SRC_PATH)/tests/docker/ -name 'test-*' -type f))
@@ -56,7 +57,9 @@ else
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	$(call quiet-command,\
 		$(DOCKER_SCRIPT) build -t qemu/$* -f $< \
-		$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) \
+		$(if $V,,--quiet) \
+		$(if $(NOCACHE),--no-cache, \
+			$(if $(DOCKER_REGISTRY),--registry $(DOCKER_REGISTRY))) \
 		$(if $(NOUSER),,--add-current-user) \
 		$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))\
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
@@ -213,6 +216,7 @@ endif
 	@echo '                         Include extra files in image.'
 	@echo '    ENGINE=auto/docker/podman'
 	@echo '                         Specify which container engine to run.'
+	@echo '    REGISTRY=url         Cache builds from registry (default:$(DOCKER_REGISTRY))'
 
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index cc6f76caa602..9684f07bdebe 100755
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
@@ -289,10 +296,24 @@ class Docker(object):
         return labels.get("com.qemu.dockerfile-checksum", "")
 
     def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None, extra_files_cksum=[]):
+                    quiet=True, user=False, argv=None, registry=None,
+                    extra_files_cksum=[]):
         if argv is None:
             argv = []
 
+        # pre-calculate the docker checksum before any
+        # substitutions we make for caching
+        checksum = _text_checksum(_dockerfile_preprocess(dockerfile))
+
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
@@ -306,15 +327,23 @@ class Docker(object):
                          (uname, uid, uname))
 
         tmp_df.write("\n")
-        tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
-                     _text_checksum(_dockerfile_preprocess(dockerfile)))
+        tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" % (checksum))
         for f, c in extra_files_cksum:
             tmp_df.write("LABEL com.qemu.%s-checksum=%s" % (f, c))
 
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
@@ -403,6 +432,8 @@ class BuildCommand(SubCommand):
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
+        parser.add_argument("--registry", "-r",
+                            help="cache from docker registry")
         parser.add_argument("-t", dest="tag",
                             help="Image Tag")
         parser.add_argument("-f", dest="dockerfile",
@@ -458,7 +489,8 @@ class BuildCommand(SubCommand):
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


