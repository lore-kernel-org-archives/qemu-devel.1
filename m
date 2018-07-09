Received: from eggs.gnu.org ([2001:4830:134:3::10]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXye-0000lT-Ib
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyc-0005Uy-44
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyb-0005UY-Ty
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id c13-v6so11370430wrt.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:09 +0100
Message-Id: <20180709152117.21585-3-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 02/10] docker: debian-tricore add git
 tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As we check out we need git installed before we start. We would have
had this based on the heavier qemu:debian9 image but we only use plain
debian:9 here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian-tricore-cross.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 898b8dd511..5ba3ca88a7 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -11,6 +11,9 @@ FROM debian:9
 
 MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
 
+RUN apt-get update && \
+    DEBIAN_FRONTEND=noninteractive apt-get install -yy git
+
 RUN git clone --single-branch \
         https://github.com/bkoppelmann/tricore-binutils.git \
         /usr/src/binutils && \
-- 
2.17.1
