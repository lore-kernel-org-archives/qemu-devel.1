Received: from eggs.gnu.org ([2001:4830:134:3::10]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZe-0005u2-Po
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZd-00027E-I2
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZd-00026q-Dg
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id m84so6736001qki.5
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:26:58 -0300
Message-Id: <20170809202712.6951-3-f4bug@amsat.org>
In-Reply-To: <20170809202712.6951-1-f4bug@amsat.org>
References: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 02/16] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Peter Maydell <peter.maydell@linaro.org>

Update the travis list of library packages to install so that
our build tests cover more of our code base.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[PMD: added more dependencies:
 glusterfs-common, libbz2-dev, libncursesw5-dev, libnfs-dev]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index b9cafe3d40..c8fecb584a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,30 +9,43 @@ addons:
   apt:
     packages:
       # Build dependencies
+      - glusterfs-common
       - libaio-dev
       - libattr1-dev
+      - libbluetooth-dev
       - libbrlapi-dev
+      - libbz2-dev
+      - libcap-dev
       - libcap-ng-dev
       - libgnutls-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
+      - liblzo2-dev
       - libnfs-dev
       - libncurses5-dev
+      - libncursesw5-dev
+      - libnfs-dev
       - libnss3-dev
       - libpixman-1-dev
       - libpng12-dev
       - librados-dev
+      - librdmacm-dev
       - libsdl1.2-dev
       - libseccomp-dev
+      - libsnappy-dev
       - libspice-protocol-dev
       - libspice-server-dev
       - libssh2-1-dev
       - liburcu-dev
       - libusb-1.0-0-dev
+      - libvde-dev
       - libvte-2.90-dev
+      - libxen-dev
+      - nettle-dev
       - sparse
       - uuid-dev
+      - xfslibs-dev
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
 # to prevent IRC notifications from forks. This was created using:
@@ -168,30 +181,43 @@ matrix:
             - gcc-5
             - g++-5
             # Build dependencies
+            - glusterfs-common
             - libaio-dev
             - libattr1-dev
+            - libbluetooth-dev
             - libbrlapi-dev
+            - libbz2-dev
+            - libcap-dev
             - libcap-ng-dev
             - libgnutls-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
+            - liblzo2-dev
             - libnfs-dev
             - libncurses5-dev
+            - libncursesw5-dev
+            - libnfs-dev
             - libnss3-dev
             - libpixman-1-dev
             - libpng12-dev
             - librados-dev
+            - librdmacm-dev
             - libsdl1.2-dev
             - libseccomp-dev
+            - libsnappy-dev
             - libspice-protocol-dev
             - libspice-server-dev
             - libssh2-1-dev
             - liburcu-dev
             - libusb-1.0-0-dev
+            - libvde-dev
             - libvte-2.90-dev
+            - libxen-dev
+            - nettle-dev
             - sparse
             - uuid-dev
+            - xfslibs-dev
       language: generic
       compiler: none
       env:
-- 
2.13.3
