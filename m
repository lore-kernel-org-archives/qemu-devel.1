Received: from eggs.gnu.org ([2001:4830:134:3::10]:60005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuU-0000rm-04
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuR-0006Q7-Ce
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuR-0006PY-4K
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id q10-v6so3663367wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:55 +0100
Message-Id: <20180724105109.8392-4-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/17] docker: par down QEMU_CONFIGURE_OPTS in
 debian-tricore-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This image isn't going to build anything significant as it is just
intended for building test cases. In case it does end up getting
inadvertently included in a build lets aim for the minimal possible
product.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 180ca646c8..4a0f7706a3 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -19,5 +19,5 @@ RUN git clone --single-branch \
     make && make install && \
     rm -rf /usr/src/binutils
 
-# Specify the cross prefix for this image (see tests/docker/common.rc)
-ENV QEMU_CONFIGURE_OPTS --cross-prefix=tricore-
+# This image isn't designed for building QEMU but building tests
+ENV QEMU_CONFIGURE_OPTS --disable-system --disable-user
-- 
2.17.1
