Received: from eggs.gnu.org ([2001:4830:134:3::10]:40073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl6-0002EE-38
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl5-0006Ok-EF
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:16 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl5-0006OV-AW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:15 -0400
Received: by mail-oi0-x242.google.com with SMTP id w138so13111417oiw.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:19 -0300
Message-Id: <20170602185630.5059-14-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 13/24] docker: add extra libs to s390x
 target to extend codebase coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 3a687feda0..cfc354ce5d 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -20,3 +20,13 @@ RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:s390x \
+        libbz2-dev:s390x \
+        liblzo2-dev:s390x \
+        libncursesw5-dev:s390x \
+        libnfs-dev:s390x \
+        librdmacm-dev:s390x \
+        libsnappy-dev:s390x
-- 
2.11.0
