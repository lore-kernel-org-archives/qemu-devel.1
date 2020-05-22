Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6781EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3699620663
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNnTHiJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3699620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAOv-00034J-Ap
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKR-00034W-Ey
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKN-0006C8-I1
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:23 -0400
Received: by mail-pl1-x643.google.com with SMTP id t16so4573652plo.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NlGChhLZQ6hBueDHSr0fX6nm53bsIvTSR/1CZBu8arw=;
 b=SNnTHiJrh7h6kmmRMdC+zZ3FcVmcCHvealLhuc03ZGBoWQ9hXLe61Yllg7bGP1rDtH
 Y5lfhnk0j69r894CtvLaSfilMLKANdKtZGov5zouD69y3wlZmwngzkMwvjrvXnuL71dO
 UlFM9aE16W1TA3gjp/xITOE1bHO+bFB08FAMNHMJVw5Oh9NliiOKmiYelN6lfMmWXc0t
 iKqbnBrvoKxIOT2qsvc3vBOcuT2Ja5X6EsGssFiJxlyv2P4d024j4b0P8tUA8UEMvz91
 3AntaeBny7NUh8p8EBg/7E+HtJgHG3xe3jJcaF7kHWZoF5SGvMTTh63pFHZjJy8neblA
 3zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NlGChhLZQ6hBueDHSr0fX6nm53bsIvTSR/1CZBu8arw=;
 b=QKZ6WNYUkJi3BfMieoLhNlv1dOktGwCqqvcA4CQAvaRjn6374TAd0tk6BBGA8G1Ubc
 MC9zEsF7FccnTng/BSC7cMYd3jxFVeii+4qv8icyCnn1l6bW/6mGSQzPl4UNaTYqS59U
 Qi3q/aQ7z/iHOCWWnpowNbBDwUrMbyhZW7GLkla///X72yRn9OZGbdXf3DiK06mD5SL7
 2ySBWp7y6oEnBTsDlz6zdCmT+27vFTEHSKemzH2hHyzi88/lEQ7Zj/gULlki0QeAOxQh
 y5b6qGNQ5Dn9oH7kfWFdC3IMDMF8/a8zjdS8bKBJxGUYDKCOga4hldyIrg4wA0dlmwdo
 /SPw==
X-Gm-Message-State: AOAM5314jBnpDPCMqmpL5CCiFK5+h3na14cAFe6ruPkLvM+VwQZQsR4e
 lClrA8YBZiVYs1MNr6Xx6YrZFGyXm1p05w==
X-Google-Smtp-Source: ABdhPJz4JdkAA7HN8RgeAICBf9nxoyHtWS7Qh00d5hv4GKS6NVTN9upFWXH6Me3LpchM4st2HUnY0Q==
X-Received: by 2002:a17:902:6ac3:: with SMTP id
 i3mr16038139plt.261.1590164116683; 
 Fri, 22 May 2020 09:15:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:16 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/19] tests/docker: Added docker build support for TSan.
Date: Fri, 22 May 2020 12:07:45 -0400
Message-Id: <20200522160755.886-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: Fam Zheng <fam@euphon.net>, robert.foley@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added a new docker for ubuntu 20.04.
This docker has support for Thread Sanitizer
including one patch we need in one of the header files.
https://github.com/llvm/llvm-project/commit/a72dc86cd

This command will build with tsan enabled:
make docker-test-build-ubuntu2004 V=1 TSAN=1

Also added the TSAN suppresion file to disable certain
cases of TSAN warnings.

Cc: Fam Zheng <fam@euphon.net>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/docker/Makefile.include              |  2 +
 tests/docker/common.rc                     | 19 +++++++
 tests/docker/dockerfiles/ubuntu2004.docker | 65 ++++++++++++++++++++++
 tests/tsan/suppressions.tsan               | 14 +++++
 4 files changed, 100 insertions(+)
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100644 tests/tsan/suppressions.tsan

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 43a8678688..e029e54b42 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -202,6 +202,7 @@ endif
 	@echo '                         (default is 1)'
 	@echo '    DEBUG=1              Stop and drop to shell in the created container'
 	@echo '                         before running the command.'
+	@echo '    TSAN=1               Enable use of tsan during the build/test.'
 	@echo '    NETWORK=1            Enable virtual network interface with default backend.'
 	@echo '    NETWORK=$$BACKEND     Enable virtual network interface with $$BACKEND.'
 	@echo '    NOUSER               Define to disable adding current user to containers passwd.'
@@ -239,6 +240,7 @@ docker-run: docker-qemu-src
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
+	                $(if $(TSAN),,-e TSAN=$(TSAN))		        \
 			$(if $(NOUSER),,				\
 				-e CCACHE_DIR=/var/tmp/ccache 		\
 				-v $(DOCKER_CCACHE_DIR):/var/tmp/ccache:z \
diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 02cd67a8c5..5df93c6326 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -27,6 +27,25 @@ requires()
 
 configure_qemu()
 {
+    if test -z "$TSAN"; then
+        requires clang tsan
+        echo "Including TSan Support"
+        tsan_log_dir="/tmp/qemu-test/build/tsan"
+        mkdir -p $tsan_log_dir > /dev/null || true
+        EXTRA_CONFIGURE_OPTS="${EXTRA_CONFIGURE_OPTS} --enable-tsan \
+                             --cc=clang-10 --cxx=clang++-10 \
+                             --disable-werror --extra-cflags=-O0"
+        # detect deadlocks is false currently simply because
+        # TSan crashes immediately with deadlock detecter enabled.
+        # We have maxed out the history size to get the best chance of finding
+        # warnings during testing.
+        # Note, to get tsan to fail on warning, use exitcode=66 below.
+        tsan_opts="suppressions=/tmp/qemu-test/src/tests/tsan/suppressions.tsan\
+                   detect_deadlocks=false history_size=7\
+                   halt_on_error=0 exitcode=0 verbose=5\
+                   log_path=$tsan_log_dir/tsan_warnings.txt"
+        export TSAN_OPTIONS="$tsan_opts"
+    fi
     config_opts="--enable-werror \
                  ${TARGET_LIST:+--target-list=${TARGET_LIST}} \
                  --prefix=$INSTALL_DIR \
diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/dockerfiles/ubuntu2004.docker
new file mode 100644
index 0000000000..6050ce7e8a
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu2004.docker
@@ -0,0 +1,65 @@
+FROM ubuntu:20.04
+ENV PACKAGES flex bison \
+    ccache \
+    clang-10\
+    gcc \
+    gettext \
+    git \
+    glusterfs-common \
+    libaio-dev \
+    libattr1-dev \
+    libbrlapi-dev \
+    libbz2-dev \
+    libcacard-dev \
+    libcap-ng-dev \
+    libcurl4-gnutls-dev \
+    libdrm-dev \
+    libepoxy-dev \
+    libfdt-dev \
+    libgbm-dev \
+    libgtk-3-dev \
+    libibverbs-dev \
+    libiscsi-dev \
+    libjemalloc-dev \
+    libjpeg-turbo8-dev \
+    liblzo2-dev \
+    libncurses5-dev \
+    libncursesw5-dev \
+    libnfs-dev \
+    libnss3-dev \
+    libnuma-dev \
+    libpixman-1-dev \
+    librados-dev \
+    librbd-dev \
+    librdmacm-dev \
+    libsasl2-dev \
+    libsdl2-dev \
+    libseccomp-dev \
+    libsnappy-dev \
+    libspice-protocol-dev \
+    libspice-server-dev \
+    libssh-dev \
+    libusb-1.0-0-dev \
+    libusbredirhost-dev \
+    libvdeplug-dev \
+    libvte-2.91-dev \
+    libxen-dev \
+    libzstd-dev \
+    make \
+    python3-yaml \
+    python3-sphinx \
+    sparse \
+    texinfo \
+    xfslibs-dev\
+    vim
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
+RUN dpkg -l $PACKAGES | sort > /packages.txt
+ENV FEATURES clang tsan pyyaml sdl2
+
+# https://bugs.launchpad.net/qemu/+bug/1838763
+ENV QEMU_CONFIGURE_OPTS --disable-libssh
+
+# Apply patch https://reviews.llvm.org/D75820
+# This is required for TSan in clang-10 to compile with QEMU.
+RUN sed -i 's/^const/static const/g' /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
diff --git a/tests/tsan/suppressions.tsan b/tests/tsan/suppressions.tsan
new file mode 100644
index 0000000000..975b0c2934
--- /dev/null
+++ b/tests/tsan/suppressions.tsan
@@ -0,0 +1,14 @@
+# TSan reports a double lock on RECURSIVE mutexes.
+mutex:aio_context_acquire
+mutex:pthread_mutex_lock
+
+# TSan reports a race betwen pthread_mutex_init() and
+# pthread_mutex_lock()
+race:pthread_mutex_init
+race:pthread_mutex_lock
+
+# TSan is unhappy about these load and store operations.
+race:bswap.h
+race:store_helper
+race:load_helper
+race:tb_set_jmp_target
-- 
2.17.1


