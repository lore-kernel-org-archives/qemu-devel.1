Received: from eggs.gnu.org ([2001:4830:134:3::10]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrl0-000236-2z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkz-0006JK-89
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:10 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dGrkz-0006In-3n
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 14:57:09 -0400
Received: by mail-oi0-x244.google.com with SMTP id f206so3399522oig.2
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 11:57:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Jun 2017 15:56:14 -0300
Message-Id: <20170602185630.5059-9-f4bug@amsat.org>
In-Reply-To: <20170602185630.5059-1-f4bug@amsat.org>
References: <20170602185630.5059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 08/24] docker: use eatmydata,
 install common build packages in base image
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

The common build packages are: build-essential clang git bison flex

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/debian.docker | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index e5a10a5875..c62c87f205 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -11,7 +11,11 @@ FROM debian:stable-slim
 
 # Setup some basic tools we need
 RUN apt update
-RUN apt install -yy aptitude ca-certificates curl
+RUN DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata
+RUN DEBIAN_FRONTEND=noninteractive \
+    eatmydata apt install -y --no-install-recommends \
+        aptitude ca-certificates curl \
+        build-essential clang git bison flex
 
 # Install common build utilities
 RUN apt update
-- 
2.11.0
