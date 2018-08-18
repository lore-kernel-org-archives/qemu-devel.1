Received: from eggs.gnu.org ([2001:4830:134:3::10]:48182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRI-0008VZ-Qg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRH-00007D-Q7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:04 -0400
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:36582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fqqRH-00006x-Lq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 21:54:03 -0400
Received: by mail-vk0-x22f.google.com with SMTP id y9-v6so4076035vky.3
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 18:54:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 17 Aug 2018 22:53:44 -0300
Message-Id: <20180818015344.797-5-f4bug@amsat.org>
In-Reply-To: <20180818015344.797-1-f4bug@amsat.org>
References: <20180818015344.797-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] docker: Sort CentOS packages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

As recommended in https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#sort-multi-line-arguments

  "This helps to avoid duplication of packages and make the
  list much easier to update."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/centos7.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 83462b7205..0a04bfbed8 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -18,10 +18,10 @@ ENV PACKAGES \
     libfdt-devel \
     librdmacm-devel \
     lzo-devel \
-    nettle-devel \
     make \
     mesa-libEGL-devel \
     mesa-libgbm-devel \
+    nettle-devel \
     pixman-devel \
     SDL-devel \
     spice-glib-devel \
-- 
2.18.0
