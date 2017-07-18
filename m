Received: from eggs.gnu.org ([2001:4830:134:3::10]:48556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ78-000545-TH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ78-0006M0-6n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:27 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ78-0006Lc-0A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:26 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 12so23470433wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:13 +0100
Message-Id: <20170718104513.23947-33-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/32] docker: install clang since Shippable
 setup_ve() verify it is available
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
index 056e5389cc..a4509950e6 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -20,6 +20,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         bison \
         build-essential \
         ca-certificates \
+        clang \
         flex \
         git \
         pkg-config \
-- 
2.13.0
