Received: from eggs.gnu.org ([2001:4830:134:3::10]:34806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SK-0005qO-4N
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SF-00005o-AL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:24 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5SF-00005O-3W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:19 -0500
Received: by mail-wm0-x244.google.com with SMTP id r196so4567073wmf.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:53 +0000
Message-Id: <20171107150558.22131-6-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 05/10] configure: allow repeated
 invocation of configure in build dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Otherwise a second configure run will totally miss out the setting of
BUILD_INC. I made the link -sf as it seemed the easier way around.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 1dc527b..c622a5e 100755
--- a/configure
+++ b/configure
@@ -176,10 +176,10 @@ fi
 
 # Are we in a separate build tree? If so, link the Makefile
 # so that 'make' works.
-if test ! -e Makefile; then
+if test ! -e Makefile || test -s Makefile; then
     echo "linking Makefile..."
     BUILD_INC="-I $(pwd)"
-    ln -s "${SRCDIR}/Makefile" .
+    ln -sf "${SRCDIR}/Makefile" .
 fi
 
 generate_config
-- 
2.14.2
