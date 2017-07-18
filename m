Received: from eggs.gnu.org ([2001:4830:134:3::10]:33754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRK-0000fI-MT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRJ-0004tu-PX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:38 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGRJ-0004th-LK
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:32:37 -0400
Received: by mail-qk0-x242.google.com with SMTP id a66so734460qkb.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:32:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:34 -0300
Message-Id: <20170718003159.10200-7-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/31] docker: add common packages to debian
 base
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
 tests/docker/dockerfiles/debian9.docker | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index c74f71283c..6b6bf41421 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -18,8 +18,11 @@ RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
+        binutils-multiarch \
         build-essential \
         ca-certificates \
         clang \
         flex \
-        git
+        git \
+        pkg-config \
+        python-minimal
-- 
2.13.2
