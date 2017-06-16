Received: from eggs.gnu.org ([2001:4830:134:3::10]:55592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtt3-0004Ta-E3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsx-0002lA-RB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:17 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsx-0002l6-Mn
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so11252024qtg.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:31 -0300
Message-Id: <20170616161334.7492-9-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/11] travis: install more library dependencies
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
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 4889c192c2..4c0f7f444e 100644
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
@@ -171,10 +175,12 @@ matrix:
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
@@ -184,6 +190,8 @@ matrix:
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
