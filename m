Received: from eggs.gnu.org ([2001:4830:134:3::10]:50641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2M-0006lg-Jb
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRq2L-0001sy-Mm
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRq2L-0001sV-Do
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 20:52:41 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 21 Dec 2017 09:52:33 +0800
Message-Id: <20171221015234.9912-2-famz@redhat.com>
In-Reply-To: <20171221015234.9912-1-famz@redhat.com>
References: <20171221015234.9912-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] Revert "docker: Enable features explicitly
 in test-full"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This reverts commit 5e8a7fe673ca5949bd51939ee36faaf3b1320de8.

It's hard to get all images to have all these packages, the usual
"FEATURES" and "require" mechanism doesn't scale with so many features.
With that change, the test basically only works in ubuntu.

Until a better way comes up, leave the feature enabling to ./configure
detection.

But don't remove the "-e" removal.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20171018082002.9406-1-famz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-full | 79 +++-----------------------------------------------
 1 file changed, 4 insertions(+), 75 deletions(-)

diff --git a/tests/docker/test-full b/tests/docker/test-full
index 816d5a3eec..b4e42d25d7 100755
--- a/tests/docker/test-full
+++ b/tests/docker/test-full
@@ -1,8 +1,8 @@
 #!/bin/bash
 #
-# Compile all the targets with as many features enabled as possible
+# Compile all the targets.
 #
-# Copyright 2016, 2017 Red Hat Inc.
+# Copyright (c) 2016 Red Hat Inc.
 #
 # Authors:
 #  Fam Zheng <famz@redhat.com>
@@ -13,77 +13,6 @@
 
 . common.rc
 
-cd "$BUILD_DIR" || exit 1
+cd "$BUILD_DIR"
 
-build_qemu \
-    --enable-attr \
-    --enable-bluez \
-    --enable-brlapi \
-    --enable-bsd-user \
-    --enable-bzip2 \
-    --enable-cap-ng \
-    --enable-coroutine-pool \
-    --enable-crypto-afalg \
-    --enable-curl \
-    --enable-curses \
-    --enable-debug \
-    --enable-debug-info \
-    --enable-debug-tcg \
-    --enable-docs \
-    --enable-fdt \
-    --enable-gcrypt \
-    --enable-glusterfs \
-    --enable-gnutls \
-    --enable-gprof \
-    --enable-gtk \
-    --enable-guest-agent \
-    --enable-jemalloc \
-    --enable-kvm \
-    --enable-libiscsi \
-    --enable-libnfs \
-    --enable-libssh2 \
-    --enable-libusb \
-    --enable-linux-aio \
-    --enable-linux-user \
-    --enable-live-block-migration \
-    --enable-lzo \
-    --enable-modules \
-    --enable-numa \
-    --enable-opengl \
-    --enable-pie \
-    --enable-profiler \
-    --enable-qom-cast-debug \
-    --enable-rbd \
-    --enable-rdma \
-    --enable-replication \
-    --enable-sdl \
-    --enable-seccomp \
-    --enable-smartcard \
-    --enable-snappy \
-    --enable-spice \
-    --enable-stack-protector \
-    --enable-system \
-    --enable-tcg \
-    --enable-tcg-interpreter \
-    --enable-tools \
-    --enable-tpm \
-    --enable-trace-backend=ftrace \
-    --enable-usb-redir \
-    --enable-user \
-    --enable-vde \
-    --enable-vhost-net \
-    --enable-vhost-scsi \
-    --enable-vhost-user \
-    --enable-vhost-vsock \
-    --enable-virtfs \
-    --enable-vnc \
-    --enable-vnc-jpeg \
-    --enable-vnc-png \
-    --enable-vnc-sasl \
-    --enable-vte \
-    --enable-werror \
-    --enable-xen \
-    --enable-xen-pci-passthrough \
-    --enable-xen-pv-domain-build \
-    --enable-xfsctl \
-&& make check $MAKEFLAGS && install_qemu
+build_qemu && make check $MAKEFLAGS && install_qemu
-- 
2.14.3
