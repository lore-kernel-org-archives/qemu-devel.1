Received: from eggs.gnu.org ([209.51.188.92]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kH-0006M6-QB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kE-0005Nt-2t
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:45 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3kD-0005Mi-TC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:42 -0500
Received: by mail-wr1-x430.google.com with SMTP id q18so23195065wrx.9
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:27 +0000
Message-Id: <20190114150129.1013-20-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/21] tests/docker: remove SID_AGE test hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Now we are using "named" snapshots of debian-sid we can rely on the
existing checksum mechanism for detecting changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 9467e9d088..7032c68895 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -98,19 +98,6 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
 
-# Debian SID images - we are tracking a rolling distro so we want to
-# force a re-build of the base image if we ever need to build one of
-# its children.
-ifndef SKIP_DOCKER_BUILD
-ifeq ($(HAVE_USER_DOCKER),y)
-SID_AGE=$(shell $(DOCKER_SCRIPT) check --checktype=age --olderthan=180 --quiet qemu:debian-sid)
-ifeq ($(SID_AGE),)
-else
-docker-image-debian-sid: NOCACHE=1
-endif
-endif
-endif
-
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
-- 
2.17.1
