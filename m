Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYBnY-0003sw-Td
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYBnW-000891-9C
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:24 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYBnW-00088L-2j
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:47:22 -0400
Received: by mail-wr0-x22d.google.com with SMTP id f21so14586985wrf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 06:47:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 14:47:14 +0100
Message-Id: <20170720134716.13049-2-alex.bennee@linaro.org>
In-Reply-To: <20170720134716.13049-1-alex.bennee@linaro.org>
References: <20170720134716.13049-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 1/3] docker: ensure NOUSER for
 travis images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

While adding the current user is a useful default behaviour for
creating new images it is not appropriate for Travis which already has
a default user.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index aaab1a4208..d7dafdbd27 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -71,6 +71,7 @@ docker-image-debian-ppc64el-cross: docker-image-debian9
 docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian8-mxe
 docker-image-debian-win64-cross: docker-image-debian8-mxe
+docker-image-travis: NOUSER=1
 
 # Expand all the pre-requistes for each docker image and test combination
 $(foreach i,$(DOCKER_IMAGES), \
-- 
2.13.0
