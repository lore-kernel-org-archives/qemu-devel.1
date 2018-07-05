Received: from eggs.gnu.org ([2001:4830:134:3::10]:57577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6sr-0008Oe-5P
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6sm-0007Up-DR
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:29 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:55786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6sm-0007UJ-5z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:24 -0400
Received: by mail-wm0-x232.google.com with SMTP id v16-v6so12172069wmv.5
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:13:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:25 +0100
Message-Id: <20180705160329.30386-17-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 16/20] docker: drop QEMU build-dep from
 bootstrap
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

This is best done with any child images that actually need it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/dockerfiles/debian-bootstrap.docker b/tests/docker/dockerfiles/debian-bootstrap.docker
index 3a9125e497..14212b9cf4 100644
--- a/tests/docker/dockerfiles/debian-bootstrap.docker
+++ b/tests/docker/dockerfiles/debian-bootstrap.docker
@@ -17,5 +17,3 @@ RUN /debootstrap/debootstrap --second-stage
 # At this point we can install additional packages if we want
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
-RUN apt-get update
-RUN apt-get -y build-dep qemu
-- 
2.17.1
