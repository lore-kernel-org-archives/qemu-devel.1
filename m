Received: from eggs.gnu.org ([2001:4830:134:3::10]:34017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRo-00014j-Ae
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRn-0005EA-G8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:08 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRn-0005E1-C8
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:07 -0400
Received: by mail-qt0-x244.google.com with SMTP id 19so731859qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:44 -0300
Message-Id: <20170718003159.10200-17-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/31] docker: enable nettle to extend code
 coverage on arm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-arm64-cross.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6ed12a3f6e..877d863475 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -24,3 +24,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         librdmacm-dev:arm64 \
         libsnappy-dev:arm64 \
         libxen-dev:arm64
+
+# nettle
+ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS --enable-nettle
-- 
2.13.2
