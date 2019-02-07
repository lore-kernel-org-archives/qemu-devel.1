Received: from eggs.gnu.org ([209.51.188.92]:40869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYe-0000C1-8I
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYc-0007OV-5S
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYY-0007Cu-9z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:37:52 -0500
Received: by mail-wr1-x432.google.com with SMTP id v16so910780wrn.11
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:47 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:29 +0000
Message-Id: <20190207183744.5054-2-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 01/16] .cirrus.yml: basic compile and test
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
Cc: qemu-arm@nongnu.org, Ed Maste <emaste@freebsd.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
index 9a76845581..eecfafad56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2475,6 +2475,14 @@ W: https://travis-ci.org/qemu/qemu
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
2.20.1
