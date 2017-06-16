Received: from eggs.gnu.org ([2001:4830:134:3::10]:55547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsy-0004LX-CE
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsv-0002kh-G7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:12 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:34434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dLtsv-0002kZ-Bg
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 12:14:09 -0400
Received: by mail-yw0-x244.google.com with SMTP id w143so2837302yww.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 09:14:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 16 Jun 2017 13:13:30 -0300
Message-Id: <20170616161334.7492-8-f4bug@amsat.org>
In-Reply-To: <20170616161334.7492-1-f4bug@amsat.org>
References: <20170616161334.7492-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/11] travis: install more library dependencies
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

From: Peter Maydell <peter.maydell@linaro.org>

Update the travis list of library packages to install so that
our build tests cover more of our code base.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .travis.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 69a960b714..4889c192c2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,28 +11,37 @@ addons:
       # Build dependencies
       - libaio-dev
       - libattr1-dev
+      - libbluetooth-dev
       - libbrlapi-dev
+      - libcap-dev
       - libcap-ng-dev
       - libgnutls-dev
       - libgtk-3-dev
       - libiscsi-dev
       - liblttng-ust-dev
+      - liblzo2-dev
       - libnfs-dev
       - libncurses5-dev
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
@@ -164,28 +173,37 @@ matrix:
             # Build dependencies
             - libaio-dev
             - libattr1-dev
+            - libbluetooth-dev
             - libbrlapi-dev
+            - libcap-dev
             - libcap-ng-dev
             - libgnutls-dev
             - libgtk-3-dev
             - libiscsi-dev
             - liblttng-ust-dev
+            - liblzo2-dev
             - libnfs-dev
             - libncurses5-dev
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
2.11.0
