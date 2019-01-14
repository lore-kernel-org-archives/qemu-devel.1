Received: from eggs.gnu.org ([209.51.188.92]:35423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3kD-0006H7-3P
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3k9-0005J9-CY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3k9-0005GT-46
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:01:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id n190so9261102wmd.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:01:35 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:12 +0000
Message-Id: <20190114150129.1013-5-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/21] tests: update Fedora dockerfile to use
 Fedora 29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

Fedora 29 is the current newest release, so switch to using that
from the current Fedora 28.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 1d0e3dc4ec..69d4a7f5d7 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:28
+FROM fedora:29
 ENV PACKAGES \
     bc \
     bison \
@@ -82,7 +82,7 @@ ENV PACKAGES \
     tar \
     usbredir-devel \
     virglrenderer-devel \
-    vte3-devel \
+    vte291-devel \
     which \
     xen-devel \
     zlib-devel
-- 
2.17.1
