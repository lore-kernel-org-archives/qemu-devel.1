Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJi-0006Eq-EE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJc-0000gi-FQ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKiJc-0008Q9-1D
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Nov 2018 11:15:28 +0000
Message-Id: <20181108111531.30671-6-stefanha@redhat.com>
In-Reply-To: <20181108111531.30671-1-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 5/8] git: use HTTPS git URLs for repo.or.cz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS    | 14 +++++++-------
 pc-bios/README |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 391c8460b8..5fb757edd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1464,7 +1464,7 @@ F: tests/qemu-iotests/
 F: util/qemu-progress.c
 F: qobject/block-qdict.c
 F: tests/check-block-qdict.c
-T: git git://repo.or.cz/qemu/kevin.git block
+T: git https://repo.or.cz/qemu/kevin.git block
=20
 Block I/O path
 M: Stefan Hajnoczi <stefanha@redhat.com>
@@ -1511,7 +1511,7 @@ F: blockdev.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
-T: git git://repo.or.cz/qemu/armbru.git block-next
+T: git https://repo.or.cz/qemu/armbru.git block-next
=20
 Dirty Bitmaps
 M: Fam Zheng <famz@redhat.com>
@@ -1706,14 +1706,14 @@ F: tests/test-visitor-serialization.c
 F: scripts/qapi-gen.py
 F: scripts/qapi/*
 F: docs/devel/qapi*
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qapi/*.json
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QObject
 M: Markus Armbruster <armbru@redhat.com>
@@ -1727,7 +1727,7 @@ F: tests/check-qnum.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
 F: tests/check-qstring.c
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
@@ -1759,7 +1759,7 @@ F: docs/devel/*qmp-*
 F: scripts/qmp/
 F: tests/qmp-test.c
 F: tests/qmp-cmd-test.c
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
=20
 qtest
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -2073,7 +2073,7 @@ F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
 F: docs/interop/nbd.txt
-T: git git://repo.or.cz/qemu/ericb.git nbd
+T: git https://repo.or.cz/qemu/ericb.git nbd
=20
 NFS
 M: Jeff Cody <jcody@redhat.com>
diff --git a/pc-bios/README b/pc-bios/README
index b572e9eb00..8f98c07a74 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -5,7 +5,7 @@
   project (http://www.nongnu.org/vgabios/).
=20
 - The PowerPC Open Hack'Ware Open Firmware Compatible BIOS is
-  available at http://repo.or.cz/w/openhackware.git.
+  available at https://repo.or.cz/openhackware.git.
=20
 - OpenBIOS (http://www.openbios.org/) is a free (GPL v2) portable
   firmware implementation. The goal is to implement a 100% IEEE
--=20
2.19.1
