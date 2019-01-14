Received: from eggs.gnu.org ([209.51.188.92]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kA-0006ER-61
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005J1-CD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k9-0005GH-20
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id n190so9261035wmd.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:35 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:11 +0000
Message-Id: <20190114150129.1013-4-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/21] tests: remove obsolete 'debian' dockerfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The 'debian' dockerfile was deprecated in favour of versioned
dockerfiles in July 2017. That is enough time for developers to
be warned about the rename.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
deleted file mode 100644
index fd32e71b79..0000000000
--- a/tests/docker/dockerfiles/debian.docker
+++ /dev/null
@@ -1,13 +0,0 @@
-# This template is deprecated and was previously based on Jessie on QEMU 2.9.
-# Now than Stretch is out, please use qemu:debian8 as base for Jessie,
-# and qemu:debian9 for Stretch.
-#
-FROM qemu:debian9
-
-MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
-
-RUN for n in $(seq 8); do echo; done && \
-    echo "\n\t\tThis image is deprecated." && echo && \
-    echo "\tUse 'FROM qemu:debian9' to use the stable Debian Stretch image" && \
-    echo "\tor 'FROM qemu:debian8' to use old Debian Jessie." && \
-    for n in $(seq 8); do echo; done
-- 
2.17.1
