Received: from eggs.gnu.org ([2001:4830:134:3::10]:53790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZL-00013R-7J
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZJ-0004DB-4N
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:35 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUlZJ-0004CQ-0c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 23:10:33 -0400
Received: by mail-qk0-x243.google.com with SMTP id v143so15375756qkb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 20:10:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 00:09:50 -0300
Message-Id: <20170711031000.24844-9-f4bug@amsat.org>
In-Reply-To: <20170711031000.24844-1-f4bug@amsat.org>
References: <20170711031000.24844-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 08/18] docker: enable virgl to extend code
 coverage on amd64
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
---
 tests/docker/dockerfiles/debian-amd64-cross.docker | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 9d10a886df..88b1b3f4e3 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -16,3 +16,12 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         librdmacm-dev \
         libsnappy-dev \
         libvte-dev
+
+# virgl
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt-get install -y --no-install-recommends \
+        libegl1-mesa-dev \
+        libepoxy-dev \
+        libgbm-dev
+RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virglrenderer
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
-- 
2.13.2
