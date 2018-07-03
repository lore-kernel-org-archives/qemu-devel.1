Received: from eggs.gnu.org ([2001:4830:134:3::10]:44925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISy-0004jh-5I
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISs-0004aN-Dp
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:24 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISs-0004a9-5t
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:18 -0400
Received: by mail-wm0-x22a.google.com with SMTP id z6-v6so10061847wma.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:40 +0100
Message-Id: <20180703101444.23778-17-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/20] docker: drop QEMU build-dep from bootstrap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
