Received: from eggs.gnu.org ([2001:4830:134:3::10]:56957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQV-0006YH-9G
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dEeQS-00060l-5i
	for qemu-devel@nongnu.org; Sat, 27 May 2017 12:18:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 27 May 2017 13:17:43 -0300
Message-Id: <20170527161755.7761-13-f4bug@amsat.org>
In-Reply-To: <20170527161755.7761-1-f4bug@amsat.org>
References: <20170527161755.7761-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 12/24] docker: add extra libs to arm64
 target to extend codebase coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-arm64-cross.docker | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index f3db7f4f55..45b891d57a 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -16,3 +16,14 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
 
 # Specify the cross prefix for this image (see tests/docker/common.rc)
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=aarch64-linux-gnu-
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        glusterfs-common:arm64 \
+        libbz2-dev:arm64 \
+        liblzo2-dev:arm64 \
+        libncursesw5-dev:arm64 \
+        libnfs-dev:arm64 \
+        librdmacm-dev:arm64 \
+        libsnappy-dev:arm64 \
+        libxen-dev:arm64
-- 
2.11.0
