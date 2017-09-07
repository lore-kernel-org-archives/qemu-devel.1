Received: from eggs.gnu.org ([2001:4830:134:3::10]:57328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dprvL-0007et-OO
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dprvG-0005Ok-W8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dprvG-0005Nu-PJ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:12:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:11:58 +0800
Message-Id: <20170907081158.4063-3-famz@redhat.com>
In-Reply-To: <20170907081158.4063-1-famz@redhat.com>
References: <20170907081158.4063-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] docker: Enable features explicitly in
 test-full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Also avoid "set -e".

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-full | 80 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/tests/docker/test-full b/tests/docker/test-full
index 05f0d491d1..bd095ad91b 100755
--- a/tests/docker/test-full
+++ b/tests/docker/test-full
@@ -1,8 +1,8 @@
-#!/bin/bash -e
+#!/bin/bash
 #
-# Compile all the targets.
+# Compile all the targets with as many features enabled as possible
 #
-# Copyright (c) 2016 Red Hat Inc.
+# Copyright 2016, 2017 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
@@ -15,5 +15,75 @@
 
 cd "$BUILD_DIR"
 
-build_qemu
-make check $MAKEFLAGS
+build_qemu \
+    --enable-attr \
+    --enable-bluez \
+    --enable-brlapi \
+    --enable-bsd-user \
+    --enable-bzip2 \
+    --enable-cap-ng \
+    --enable-coroutine-pool \
+    --enable-crypto-afalg \
+    --enable-curl \
+    --enable-curses \
+    --enable-debug \
+    --enable-debug-info \
+    --enable-debug-tcg \
+    --enable-docs \
+    --enable-fdt \
+    --enable-gcrypt \
+    --enable-glusterfs \
+    --enable-gnutls \
+    --enable-gprof \
+    --enable-gtk \
+    --enable-guest-agent \
+    --enable-jemalloc \
+    --enable-kvm \
+    --enable-libiscsi \
+    --enable-libnfs \
+    --enable-libssh2 \
+    --enable-libusb \
+    --enable-linux-aio \
+    --enable-linux-user \
+    --enable-live-block-migration \
+    --enable-lzo \
+    --enable-modules \
+    --enable-numa \
+    --enable-opengl \
+    --enable-pie \
+    --enable-profiler \
+    --enable-qom-cast-debug \
+    --enable-rbd \
+    --enable-rdma \
+    --enable-replication \
+    --enable-sdl \
+    --enable-seccomp \
+    --enable-smartcard \
+    --enable-snappy \
+    --enable-spice \
+    --enable-stack-protector \
+    --enable-system \
+    --enable-tcg \
+    --enable-tcg-interpreter \
+    --enable-tools \
+    --enable-tpm \
+    --enable-trace-backend=ftrace \
+    --enable-usb-redir \
+    --enable-user \
+    --enable-vde \
+    --enable-vhost-net \
+    --enable-vhost-scsi \
+    --enable-vhost-user \
+    --enable-vhost-vsock \
+    --enable-virtfs \
+    --enable-vnc \
+    --enable-vnc-jpeg \
+    --enable-vnc-png \
+    --enable-vnc-sasl \
+    --enable-vte \
+    --enable-werror \
+    --enable-xen \
+    --enable-xen-pci-passthrough \
+    --enable-xen-pv-domain-build \
+    --enable-xfsctl \
+&& make check $MAKEFLAGS
-- 
2.13.5
