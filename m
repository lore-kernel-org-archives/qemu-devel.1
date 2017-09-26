Received: from eggs.gnu.org ([2001:4830:134:3::10]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwq2U-0005qY-B9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwq2R-0007Wv-5B
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:42 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:46507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dwq2Q-0007WT-Sq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:36:39 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m72so8024400wmc.1
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:36:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Sep 2017 14:36:22 +0100
Message-Id: <20170926133622.14991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] tests/docker/run: don't source /etc/profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>

The usual behaviour of /etc/profile is to set the default PATH for
users. This runs into problems when we have updated PATH in our
dockerfile e.g. to access a cross-compiler in a non-standard
location. It shouldn't be needed anyway as we inherit the env from the
image when it was setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/run | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/docker/run b/tests/docker/run
index c8f940de15..b87f8ef03c 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -18,7 +18,6 @@ fi
 BASE="$(dirname $(readlink -e $0))"
 
 # Prepare the environment
-. /etc/profile
 export PATH=/usr/lib/ccache:$PATH
 
 if test -n "$J"; then
-- 
2.14.1
