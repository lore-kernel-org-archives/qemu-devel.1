Received: from eggs.gnu.org ([2001:4830:134:3::10]:42604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBX-0000cU-SE
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffWBU-0001i9-RB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:02:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffWBU-0001h9-Jy
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 16:02:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id b15-v6so2385919wrv.10
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 13:02:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:50 +0100
Message-Id: <20180717195553.9111-16-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 15/18] docker: add commentary to
 debian-bootstrap.docker
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

This is just a note that later versions of debootstrap don't
technically need this hack.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-bootstrap.docker | 1 +
 1 file changed, 1 insertion(+)

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
