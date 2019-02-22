Received: from eggs.gnu.org ([209.51.188.92]:41780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xo-0006hX-6H
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7XW-0007UG-PC
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gx7XW-00079M-6K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:54:42 -0500
Received: by mail-wr1-x432.google.com with SMTP id r5so1640945wrg.9
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:54:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 09:54:17 +0000
Message-Id: <20190222095421.28938-6-alex.bennee@linaro.org>
In-Reply-To: <20190222095421.28938-1-alex.bennee@linaro.org>
References: <20190222095421.28938-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/9] tests/docker: squash initial update and
 install step for debian9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 154ae2a455..5f23a35404 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -13,8 +13,8 @@ FROM debian:stretch-slim
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
 
 # Install common build utilities
-RUN apt update
-RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bison \
-- 
2.20.1
