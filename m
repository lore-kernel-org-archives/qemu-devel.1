Received: from eggs.gnu.org ([209.51.188.92]:37520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0007ft-Vo
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gj3tJ-0001Gb-9c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gj3tJ-0001El-21
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:11:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so23253275wrs.10
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 07:11:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 14 Jan 2019 15:01:25 +0000
Message-Id: <20190114150129.1013-18-alex.bennee@linaro.org>
In-Reply-To: <20190114150129.1013-1-alex.bennee@linaro.org>
References: <20190114150129.1013-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/21] travis: bump to Xenial baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Travis is slowly catching up. Move to Xenial based images for our
current builds. These are now all proper VMs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 79da3a495a..93fd0164a0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,8 +1,8 @@
-
-dist: trusty
+# The current Travis default is a VM based 16.04 Xenial on GCE
+# Additional builds with specific requirements for a full VM need to
+# be added as additional matrix: entries later on
+dist: xenial
 language: c
-python:
-  - "2.6"
 compiler:
   - gcc
 cache: ccache
@@ -34,7 +34,7 @@ addons:
       - libssh2-1-dev
       - liburcu-dev
       - libusb-1.0-0-dev
-      - libvte-2.90-dev
+      - libvte-2.91-dev
       - sparse
       - uuid-dev
       - gcovr
@@ -193,9 +193,7 @@ matrix:
         apt:
           packages:
             - python3-pip
-            - python3.4-venv
-
-
+            - python3.5-venv
     # Using newer GCC with sanitizers
     - addons:
         apt:
@@ -229,7 +227,7 @@ matrix:
             - libssh2-1-dev
             - liburcu-dev
             - libusb-1.0-0-dev
-            - libvte-2.90-dev
+            - libvte-2.91-dev
             - sparse
             - uuid-dev
       language: generic
-- 
2.17.1
