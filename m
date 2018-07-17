Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4q-000324-0p
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4l-0004ag-0g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:04 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:54172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4k-0004Zz-Q5
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:55:58 -0400
Received: by mail-wm0-x22d.google.com with SMTP id s9-v6so535518wmh.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:55:58 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:38 +0100
Message-Id: <20180717195553.9111-4-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 03/18] docker: par down
 QEMU_CONFIGURE_OPTS in debian-tricore-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This image isn't going to build anything significant as it is just
intended for building test cases. In case it does end up getting
inadvertently included in a build lets aim for the minimal possible
product.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-tricore-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
