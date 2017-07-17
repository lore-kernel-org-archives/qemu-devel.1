Received: from eggs.gnu.org ([2001:4830:134:3::10]:36848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KU-0005uQ-RT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KU-00027g-13
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:58 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KT-00026e-RD
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: by mail-wr0-x22e.google.com with SMTP id a10so13054279wrd.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:57 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:31 +0100
Message-Id: <20170717144848.11793-7-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 06/23] docker: add pkg-config and
 python-minimal packages to debian base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian9.docker | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index c74f71283c..51c13939ff 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -22,4 +22,6 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         ca-certificates \
         clang \
         flex \
-        git
+        git \
+        pkg-config \
+        python-minimal
-- 
2.13.0
