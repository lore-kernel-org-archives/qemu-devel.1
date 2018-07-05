Received: from eggs.gnu.org ([2001:4830:134:3::10]:57583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6sr-0008Ox-CT
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fb6sn-0007Ve-UK
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fb6sn-0007VF-N4
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:13:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id c13-v6so1451837wrt.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 09:13:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  5 Jul 2018 17:03:23 +0100
Message-Id: <20180705160329.30386-15-alex.bennee@linaro.org>
In-Reply-To: <20180705160329.30386-1-alex.bennee@linaro.org>
References: <20180705160329.30386-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 14/20] docker: Clean the MXE base image
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

Using the duplicated same package is confusing.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.17.1
