Received: from eggs.gnu.org ([2001:4830:134:3::10]:36681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzF-00009H-RZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzF-0006vE-4I
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:37 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qzF-0006v7-08
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:37 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so12127371qka.1
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:18:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:48 -0300
Message-Id: <20170508221759.15616-11-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/21] docker: add extra libs to s390x
 target to extend codebase coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-s390x-cross.docker | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 3a687feda0..119b152971 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -20,3 +20,9 @@ RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=s390x-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
+    glusterfs-common:s390x \
+    libncursesw5-dev:s390x libnfs-dev:s390x \
+    libbz2-dev:s390x liblzo2-dev:s390x \
+    libsnappy-dev:s390x librdmacm-dev:s390x
-- 
2.11.0
