Received: from eggs.gnu.org ([2001:4830:134:3::10]:43472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYvw-0005NV-Ec
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gIYmh-0000J3-Vy
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:42:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gIYmf-0000G0-TX
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:42:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  2 Nov 2018 12:42:20 +0000
Message-Id: <20181102124220.26558-6-stefanha@redhat.com>
In-Reply-To: <20181102124220.26558-1-stefanha@redhat.com>
References: <20181102124220.26558-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] git: use HTTPS git URLs for repo.or.cz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, Daniel Berrange <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

repo.or.cz supports git smart HTTPS.  Use it in preference to git:// or
http:// since it's more secure.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS    | 14 +++++++-------
 pc-bios/README |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cca097c49..a0576aa68a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1455,7 +1455,7 @@ F: tests/qemu-iotests/
 F: util/qemu-progress.c
 F: qobject/block-qdict.c
 F: tests/check-block-qdict.c
-T: git git://repo.or.cz/qemu/kevin.git block
+T: git https://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
 M: Stefan Hajnoczi <stefanha@redhat.com>
@@ -1502,7 +1502,7 @@ F: blockdev.c
 F: block/qapi.c
 F: qapi/block*.json
 F: qapi/transaction.json
-T: git git://repo.or.cz/qemu/armbru.git block-next
+T: git https://repo.or.cz/qemu/armbru.git block-next
 
 Dirty Bitmaps
 M: Fam Zheng <famz@redhat.com>
@@ -1697,14 +1697,14 @@ F: tests/test-visitor-serialization.c
 F: scripts/qapi-gen.py
 F: scripts/qapi/*
 F: docs/devel/qapi*
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QAPI Schema
 M: Eric Blake <eblake@redhat.com>
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qapi/*.json
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QObject
 M: Markus Armbruster <armbru@redhat.com>
@@ -1718,7 +1718,7 @@ F: tests/check-qnum.c
 F: tests/check-qjson.c
 F: tests/check-qlist.c
 F: tests/check-qstring.c
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QEMU Guest Agent
 M: Michael Roth <mdroth@linux.vnet.ibm.com>
@@ -1750,7 +1750,7 @@ F: docs/devel/*qmp-*
 F: scripts/qmp/
 F: tests/qmp-test.c
 F: tests/qmp-cmd-test.c
-T: git git://repo.or.cz/qemu/armbru.git qapi-next
+T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
 M: Paolo Bonzini <pbonzini@redhat.com>
@@ -2065,7 +2065,7 @@ F: include/block/nbd*
 F: qemu-nbd.*
 F: blockdev-nbd.c
 F: docs/interop/nbd.txt
-T: git git://repo.or.cz/qemu/ericb.git nbd
+T: git https://repo.or.cz/qemu/ericb.git nbd
 
 NFS
 M: Jeff Cody <jcody@redhat.com>
diff --git a/pc-bios/README b/pc-bios/README
index b572e9eb00..3f91912a18 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -5,7 +5,7 @@
   project (http://www.nongnu.org/vgabios/).
 
 - The PowerPC Open Hack'Ware Open Firmware Compatible BIOS is
-  available at http://repo.or.cz/w/openhackware.git.
+  available at https://repo.or.cz/w/openhackware.git.
 
 - OpenBIOS (http://www.openbios.org/) is a free (GPL v2) portable
   firmware implementation. The goal is to implement a 100% IEEE
-- 
2.17.2
