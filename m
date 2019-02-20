Received: from eggs.gnu.org ([209.51.188.92]:46130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfN-00051K-6b
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwVfM-000217-Dx
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:17 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwVfM-0001zh-6e
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:28:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id x7so7423857wmj.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:28:16 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Feb 2019 17:28:08 +0000
Message-Id: <20190220172811.10588-6-alex.bennee@linaro.org>
In-Reply-To: <20190220172811.10588-1-alex.bennee@linaro.org>
References: <20190220172811.10588-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/8] tests/docker: squash initial update and
 install step for docker9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian9.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
