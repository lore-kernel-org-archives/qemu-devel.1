Received: from eggs.gnu.org ([2001:4830:134:3::10]:44844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISp-0004a9-Qx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISp-0004Yi-0v
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:15 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISo-0004YN-QK
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:14 -0400
Received: by mail-wr0-x236.google.com with SMTP id q10-v6so1383187wrd.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:38 +0100
Message-Id: <20180703101444.23778-15-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/20] docker: Clean the MXE base image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
