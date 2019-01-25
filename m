Received: from eggs.gnu.org ([209.51.188.92]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn224-0003VR-Bb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn221-0000gH-RU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn21x-0000Wk-PO
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:00:26 -0500
Received: by mail-wm1-x32b.google.com with SMTP id y185so4875289wmd.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:00:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:04 +0000
Message-Id: <20190125140017.6092-2-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/14] .cirrus.yml: basic compile and test
 for FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>

From: Ed Maste <emaste@freebsd.org>

Signed-off-by: Ed Maste <emaste@freebsd.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .cirrus.yml | 16 ++++++++++++++++
 MAINTAINERS |  8 ++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..303fe720d6
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,16 @@
+freebsd_12_task:
+  freebsd_instance:
+    image: freebsd-12-0-release-amd64
+    cpu: 8
+    memory: 8G
+  env:
+    CIRRUS_CLONE_DEPTH: 1
+  install_script: pkg install -y
+    bison curl cyrus-sasl git glib gmake gnutls
+    nettle perl5 pixman pkgconf png usbredir
+  script:
+    - mkdir build
+    - cd build
+    - ../configure || { cat config.log; exit 1; }
+    - gmake -j8
+    - gmake -j8 V=1 check
diff --git a/MAINTAINERS b/MAINTAINERS
index fd3d4de3fa..2ddfb86bb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2483,6 +2483,14 @@ W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
 
+FreeBSD Hosted Continuous Integration
+M: Ed Maste <emaste@freebsd.org>
+M: Li-Wen Hsu <lwhsu@freebsd.org>
+L: qemu-devel@nongnu.org
+S: Maintained
+F: .cirrus.yml
+W: https://cirrus-ci.com/github/qemu/qemu
+
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
-- 
2.17.1
