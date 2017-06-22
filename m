Received: from eggs.gnu.org ([2001:4830:134:3::10]:56119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsrj-0005cw-SE
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsri-0004ga-Su
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:07 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dNsri-0004gV-PN
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 23:33:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so589074qtg.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 20:33:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 22 Jun 2017 00:32:14 -0300
Message-Id: <20170622033231.19344-5-f4bug@amsat.org>
In-Reply-To: <20170622033231.19344-1-f4bug@amsat.org>
References: <20170622033231.19344-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/21] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

so more codebase is built

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 53d8e79bf5..0220f7472e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,10 +9,12 @@ addons:
   apt:
     packages:
       # Build dependencies
+      - glusterfs-common
       - libaio-dev
       - libattr1-dev
       - libbluetooth-dev
       - libbrlapi-dev
+      - libbz2-dev
       - libcap-dev
       - libcap-ng-dev
       - libgnutls-dev
@@ -22,6 +24,8 @@ addons:
       - liblzo2-dev
       - libnfs-dev
       - libncurses5-dev
+      - libncursesw5-dev
+      - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
       - libpng12-dev
@@ -169,10 +173,12 @@ matrix:
             - gcc-5
             - g++-5
             # Build dependencies
+            - glusterfs-common
             - libaio-dev
             - libattr1-dev
             - libbluetooth-dev
             - libbrlapi-dev
+            - libbz2-dev
             - libcap-dev
             - libcap-ng-dev
             - libgnutls-dev
@@ -182,6 +188,8 @@ matrix:
             - liblzo2-dev
             - libnfs-dev
             - libncurses5-dev
+            - libncursesw5-dev
+            - libnfs-dev
             - libnss3-dev
             - libpixman-1-dev
             - libpng12-dev
-- 
2.11.0
