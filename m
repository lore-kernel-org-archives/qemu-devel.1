Received: from eggs.gnu.org ([2001:4830:134:3::10]:46631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0T-0007cC-8E
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0S-0003De-FF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:33 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0S-0003D4-8t
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:32 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w4so22831617wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:50 +0100
Message-Id: <20170718104513.23947-10-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/32] docker: optimize debian9 base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 6b6bf41421..056e5389cc 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -18,11 +18,12 @@ RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
-        binutils-multiarch \
         build-essential \
         ca-certificates \
-        clang \
         flex \
         git \
         pkg-config \
-        python-minimal
+        psmisc \
+        python \
+        texinfo \
+        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)
-- 
2.13.0
