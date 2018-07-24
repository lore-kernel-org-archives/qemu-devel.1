Received: from eggs.gnu.org ([2001:4830:134:3::10]:34063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1n-0007Q8-3b
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhv1m-0000l6-DD
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhv1m-0000kv-59
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:58:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id t6-v6so3676144wrn.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:58:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:06 +0100
Message-Id: <20180724105109.8392-15-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/17] docker: add commentary to
 debian-bootstrap.docker
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

This is just a note that later versions of debootstrap don't
technically need this hack.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
index 14212b9cf4..e13c26a7ed 100644
--- a/tests/docker/dockerfiles/debian-bootstrap.docker
+++ b/tests/docker/dockerfiles/debian-bootstrap.docker
@@ -9,6 +9,7 @@ FROM scratch
 ADD . /
 
 # Patch all mounts as docker already has stuff set up
+# (this is not needed for later debootstraps but is harmless atm)
 RUN sed -i 's/in_target mount/echo not for docker in_target mount/g' /debootstrap/functions
 
 # Run stage 2
-- 
2.17.1
