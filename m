Received: from eggs.gnu.org ([209.51.188.92]:56129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0ku8-0007De-35
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0ku7-0002px-7d
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:33:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h0ku7-0002p8-1c
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:33:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  4 Mar 2019 11:32:56 +0100
Message-Id: <1551695576-13205-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous integration
 task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

cirrus-ci.com also has the possibility to run CI tasks on macOS.
Since most of the QEMU developers do not have access to macOS yet,
let's add a CI pipeline for this operating system here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 You can see an example here: https://cirrus-ci.com/task/5099494325616640

 .cirrus.yml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 303fe72..e3d375b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -14,3 +14,15 @@ freebsd_12_task:
     - ../configure || { cat config.log; exit 1; }
     - gmake -j8
     - gmake -j8 V=1 check
+
+macos_task:
+  osx_instance:
+    image: high-sierra-base
+  env:
+    CIRRUS_CLONE_DEPTH: 1
+  install_script:
+    - brew install pkg-config glib pixman make sdl2
+  script:
+    - ./configure || { cat config.log; exit 1; }
+    - gmake -j$(sysctl -n hw.ncpu)
+    - gmake check -j$(sysctl -n hw.ncpu)
-- 
1.8.3.1
