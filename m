Received: from eggs.gnu.org ([2001:4830:134:3::10]:52520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4i-0007Ix-SN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4f-00048g-QD
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:16 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:41148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa4f-00048D-Ky
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:13 -0400
Received: by mail-qk0-x229.google.com with SMTP id d22-v6so3349140qkc.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:38 -0300
Message-Id: <20180628164643.9668-4-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] docker: Clean the MXE base image
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

Using the duplicated same package is confusing.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
It would be even better to figure out what I wanted to do with this command
and add a comment in the Dockerfile :)

I think the original idea was to share the packages common to both gw32/gw64
images in this intermediate common image.

 tests/docker/dockerfiles/debian8-mxe.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian8-mxe.docker
index 9b8e577b03..2df4cc8c5c 100644
--- a/tests/docker/dockerfiles/debian8-mxe.docker
+++ b/tests/docker/dockerfiles/debian8-mxe.docker
@@ -14,6 +14,6 @@ RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         libpython2.7-stdlib \
-        $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
+        $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
 
 ENV PATH $PATH:/usr/lib/mxe/usr/bin/ 
-- 
2.18.0
