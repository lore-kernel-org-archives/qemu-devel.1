Received: from eggs.gnu.org ([209.51.188.92]:36315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheXh-0004Qv-5T
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheXg-000173-BK
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheXg-000162-5T
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so12374249wrx.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:54:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:14 +0000
Message-Id: <20190110174516.21586-18-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v1 17/19] travis: bump to Xenial baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Travis is slowly catching up. Move to Xenial based images for our
current builds. These are now all proper VMs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

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
