Received: from eggs.gnu.org ([209.51.188.92]:39900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <emaste@freebsd.org>) id 1gjTfe-00009A-F8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <emaste@freebsd.org>) id 1gjTfd-0006wV-5l
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:42:42 -0500
Received: from mx2.freebsd.org ([8.8.178.116]:26604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <emaste@freebsd.org>) id 1gjTfc-0006sn-VF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:42:41 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "mx1.freebsd.org",
	Issuer "Let's Encrypt Authority X3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id D2E3796E4D
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 18:42:32 +0000 (UTC)
	(envelope-from emaste@freebsd.org)
From: Ed Maste <emaste@freefall.freebsd.org>
Date: Tue, 15 Jan 2019 18:42:29 +0000
Message-Id: <20190115184229.73688-1-emaste@freefall.freebsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] .cirrus.yml: basic compile and test for FreeBSD
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

Cirrus-CI (https://cirrus-ci.org) is a hosted CI service which supports
several platforms, including FreeBSD.  Later on we could build for other
hosts in Cirrus-CI, but I'm starting with only FreeBSD as it is not
supported by other CI services.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 .cirrus.yml     | 16 ++++++++++++++++
 create mode 100644 .cirrus.yml

diff --git a/.cirrus.yml b/.cirrus.yml
new file mode 100644
index 0000000000..ff4bf75ad1
--- /dev/null
+++ b/.cirrus.yml
@@ -0,0 +1,16 @@
+freebsd_12_task:
+  freebsd_instance:
+    image: freebsd-12-0-release-amd64
+    cpu: 8
+    memory: 24G
+  env:
+    CIRRUS_CLONE_DEPTH: 1
+  install_script: pkg install -y
+    bison curl cyrus-sasl fontconfig freetype2 git glib gmake gnutls
+    nettle perl5 pixman pkgconf png usbredir
+  script:
+    - mkdir build
+    - cd build
+    - ../configure || { cat config.log; exit 1; }
+    - gmake -j8
+    - gmake -j8 check
--=20
2.20.1
