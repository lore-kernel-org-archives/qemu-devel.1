Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKo9f-0005zw-S1
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKo9f-0004v0-6L
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:54:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKo9e-0004uE-Uh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:54:55 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 16:54:48 +0100
Message-Id: <1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/3] travis: install more library dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Update the travis list of library packages to install so that
our build tests cover more of our code base.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .travis.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 27a2d9c..26dabb6 100644
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
@@ -162,28 +171,37 @@ matrix:
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
2.7.4
