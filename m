Received: from eggs.gnu.org ([209.51.188.92]:44698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <emaste@freebsd.org>) id 1gm13e-0003WC-U0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <emaste@freebsd.org>) id 1gm13d-0004Ph-BE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:58 -0500
Received: from mx2.freebsd.org ([8.8.178.116]:51454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <emaste@freebsd.org>) id 1gm13d-00048J-1F
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:45:57 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "mx1.freebsd.org",
	Issuer "Let's Encrypt Authority X3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 8389E8F634
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 17:26:00 +0000 (UTC)
	(envelope-from emaste@freebsd.org)
From: emaste@freebsd.org
Date: Tue, 22 Jan 2019 17:25:58 +0000
Message-Id: <20190122172558.15096-1-emaste@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>

From: Ed Maste <emaste@freebsd.org>

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
Changes since v3:
- 8G instead of 24G
- remove V=3D1 from build (but leave on "gmake check")

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
+    - gmake -j8 V=3D1 check
diff --git a/MAINTAINERS b/MAINTAINERS
index af339b86db..f9da8c9cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2483,6 +2483,14 @@ W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
=20
+FreeBSD Hosted Continuous Integration
+M: Ed Maste <emaste@freebsd.org>
+M: Li-Wen Hsu <lwhsu@freebsd.org>
+L: qemu-devel@nongnu.org
+S: Maintained
+F: .cirrus.yml
+W: https://cirrus-ci.com/github/qemu/qemu
+
 Guest Test Compilation Support
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
--=20
2.20.1
