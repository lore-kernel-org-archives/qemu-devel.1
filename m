Received: from eggs.gnu.org ([208.118.235.92]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyinD-0005wO-Iq
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyijo-0008TI-2i
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fyijn-0008Oa-Pv
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 15:17:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  8 Sep 2018 15:17:34 -0400
Message-Id: <20180908191735.22861-2-cota@braap.org>
In-Reply-To: <20180908191735.22861-1-cota@braap.org>
References: <20180908191735.22861-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 1/2] gitmodules: add berkeley's softfloat +
 testfloat version 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

These are BSD-licensed so we can add them as submodules.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 .gitmodules                   | 6 ++++++
 tests/fp/berkeley-softfloat-3 | 1 +
 tests/fp/berkeley-testfloat-3 | 1 +
 3 files changed, 8 insertions(+)
 create mode 160000 tests/fp/berkeley-softfloat-3
 create mode 160000 tests/fp/berkeley-testfloat-3

diff --git a/.gitmodules b/.gitmodules
index d108478e0a..165c7c5286 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,9 @@
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
 	url = git://git.qemu.org/u-boot-sam460ex.git
+[submodule "tests/fp/testfloat"]
+	path = tests/fp/berkeley-testfloat-3
+	url = git://github.com/ucb-bar/berkeley-testfloat-3
+[submodule "tests/fp/berkeley-softfloat-3"]
+	path = tests/fp/berkeley-softfloat-3
+	url = git://github.com/ucb-bar/berkeley-softfloat-3
diff --git a/tests/fp/berkeley-softfloat-3 b/tests/fp/berkeley-softfloat-3
new file mode 160000
index 0000000000..b64af41c32
--- /dev/null
+++ b/tests/fp/berkeley-softfloat-3
@@ -0,0 +1 @@
+Subproject commit b64af41c3276f97f0e181920400ee056b9c88037
diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
new file mode 160000
index 0000000000..06b20075dd
--- /dev/null
+++ b/tests/fp/berkeley-testfloat-3
@@ -0,0 +1 @@
+Subproject commit 06b20075dd3c1a5d0dd007a93643282832221612
-- 
2.17.1
