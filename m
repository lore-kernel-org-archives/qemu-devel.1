Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19458C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:45:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D93D1207ED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUUR/juA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93D1207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGPO-0000X0-6v
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHy-00040d-B0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:54 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGHx-000410-37
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:37:53 -0400
Received: by mail-pg1-x541.google.com with SMTP id n23so5483253pgb.12
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AXPq7Uy8g5ifp8uMXZd1qJX2wag4BCDXppVYNXcf0Dw=;
 b=fUUR/juA87kUvzkHOXidkERsoZztFGGDQkhWhPKRV96NnsT1KWLuW7SB88q4l8ESuS
 Wshv1Dsy3x8ozU0I3fSn927FlGcc6CdgUbhY4zZrQQiglAxtJPbg+5RiASX4w2/6gbvc
 d0n3ErHBBHBvQUNTjoVRRsU60K8SHrnds1WR9eVY5VNT0/Q345Ra7zTEtE9dVQRzWPHG
 GIfKg4eRDwE3UHyDUrbrD6yk9XyG5OdTTmZJeUceP7vkJpCwd2r1XhzE5eHqUmgnJdhn
 nMuFtdyJQvfB83yDSJOslDY/lSXSp5sE7ZzI8Hj/8BXghikh6eux9Y9DjyduwlSLpwP7
 k5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AXPq7Uy8g5ifp8uMXZd1qJX2wag4BCDXppVYNXcf0Dw=;
 b=XAAWASD84R2utapT2l/g5R3EW+FsXvAOkr94HPMLfgZeW1sQJxYIcM+DAWQvnNlpLs
 ZBBER60f0IHDB2wW0cCdJoXtkWJo/VvMKx7QOz7TZ2u3a4vy/3N2OouLSGAR6slmjOa5
 eTiLa0NhbgmWokpBGWjmg7C4She1I1upyrIwZpQ/E9PpXJyqwX/YWbCAod7H5wH2hl7w
 fTCvwJGI30HJzbHx8IZ/4mbf/DGKS/n7MSFr9wfCa2jW6LJdv443BD9OxNF/Z+GpYIgF
 XPcvrh+ole3NMbAnIcN41pe120UShL78944shjO2G2Sv6sh3vR5FpwABq8fx/1blB+9s
 Lf9A==
X-Gm-Message-State: AOAM5330cXVjx3rQkowyQmIlRBTI8rIaYKqxjIs6x+IBziDmikq46gyU
 kZHxvEOur+sfhdP+ooyjXPF3CyQlLthJUw==
X-Google-Smtp-Source: ABdhPJyGCuCwwNwHK978hztXGXybTaUfoyjA0JOCR9swtv/cKQ1QVZRWX9spz1l17gix52GSvGYJqQ==
X-Received: by 2002:a65:568d:: with SMTP id v13mr10411924pgs.436.1591378671434; 
 Fri, 05 Jun 2020 10:37:51 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/13] tests/docker: Added docker build support for TSan.
Date: Fri,  5 Jun 2020 13:34:18 -0400
Message-Id: <20200605173422.1490-10-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x541.google.com
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
make docker-test-tsan-ubuntu2004 

Also added the TSAN suppresion file to disable certain
cases of TSAN warnings.

Cc: Fam Zheng <fam@euphon.net>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/docker/dockerfiles/ubuntu2004.docker | 65 ++++++++++++++++++++++
 tests/docker/test-tsan                     | 44 +++++++++++++++
 tests/tsan/blacklist.tsan                  | 10 ++++
 tests/tsan/suppressions.tsan               | 14 +++++
 4 files changed, 133 insertions(+)
 create mode 100644 tests/docker/dockerfiles/ubuntu2004.docker
 create mode 100755 tests/docker/test-tsan
 create mode 100644 tests/tsan/blacklist.tsan
 create mode 100644 tests/tsan/suppressions.tsan

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
diff --git a/tests/docker/test-tsan b/tests/docker/test-tsan
new file mode 100755
index 0000000000..eb40ac45b7
--- /dev/null
+++ b/tests/docker/test-tsan
@@ -0,0 +1,44 @@
+#!/bin/bash -e
+#
+# This test will use TSan as part of a build and a make check.
+#
+# Copyright (c) 2020 Linaro
+# Copyright (c) 2016 Red Hat Inc.
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#  Originally based on test-quick from Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+. common.rc
+
+setup_tsan()
+{
+    requires clang tsan
+    tsan_log_dir="/tmp/qemu-test/build/tsan"
+    mkdir -p $tsan_log_dir > /dev/null || true
+    EXTRA_CONFIGURE_OPTS="${EXTRA_CONFIGURE_OPTS} --enable-tsan \
+                          --cc=clang-10 --cxx=clang++-10 \
+                          --disable-werror --extra-cflags=-O0"
+    # detect deadlocks is false currently simply because
+    # TSan crashes immediately with deadlock detector enabled.
+    # We have maxed out the history size to get the best chance of finding
+    # warnings during testing.
+    # Note, to get TSan to fail on warning, use exitcode=66 below.
+    tsan_opts="suppressions=/tmp/qemu-test/src/tests/tsan/suppressions.tsan\
+               detect_deadlocks=false history_size=7\
+               halt_on_error=0 exitcode=0 verbose=5\
+               log_path=$tsan_log_dir/tsan_warning"
+    export TSAN_OPTIONS="$tsan_opts"
+}
+
+cd "$BUILD_DIR"
+
+TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
+setup_tsan
+build_qemu
+check_qemu
+install_qemu
diff --git a/tests/tsan/blacklist.tsan b/tests/tsan/blacklist.tsan
new file mode 100644
index 0000000000..75e444f5dc
--- /dev/null
+++ b/tests/tsan/blacklist.tsan
@@ -0,0 +1,10 @@
+# This is an example blacklist.
+# To enable use of the blacklist add this to configure:
+# "--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/blacklist.tsan"
+# The eventual goal would be to fix these warnings.
+
+# TSan is not happy about setting/getting of dirty bits,
+# for example, cpu_physical_memory_set_dirty_range,
+# and cpu_physical_memory_get_dirty.
+src:bitops.c
+src:bitmap.c
diff --git a/tests/tsan/suppressions.tsan b/tests/tsan/suppressions.tsan
new file mode 100644
index 0000000000..73414b9ebd
--- /dev/null
+++ b/tests/tsan/suppressions.tsan
@@ -0,0 +1,14 @@
+# This is the set of runtime suppressions of TSan warnings.
+# The goal would be to have here only items we do not
+# plan to fix, and to explain why for each item.
+
+# TSan reports a double lock on RECURSIVE mutexes.
+# Since the recursive lock is intentional, we choose to ignore it.
+mutex:aio_context_acquire
+mutex:pthread_mutex_lock
+
+# TSan reports a race betwen pthread_mutex_init() and
+# pthread_mutex_lock().  Since this is outside of QEMU,
+# we choose to ignore it.
+race:pthread_mutex_init
+race:pthread_mutex_lock
-- 
2.17.1


