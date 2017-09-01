Received: from eggs.gnu.org ([2001:4830:134:3::10]:53947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0000HI-Nu
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007Mc-Kv
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007LV-8W
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 33722C03BD73
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 010C1C4529
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:55 +0200
Message-Id: <20170901125611.29295-32-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/47] qapi-schema: Improve section headings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The generated QEMU QMP reference is now structured as follows:

    1.1 Introduction
    1.2 Stability Considerations
    1.3 Common data types
    1.4 Socket data types
    1.5 VM run state
    1.6 Cryptography
    1.7 Block devices
    1.7.1 Block core (VM unrelated)
    1.7.2 QAPI block definitions (vm unrelated)
    1.8 Character devices
    1.9 Net devices
    1.10 Rocker switch device
    1.11 TPM (trusted platform module) devices
    1.12 Remote desktop
    1.12.1 Spice
    1.12.2 VNC
    1.13 Input
    1.14 Migration
    1.15 Transactions
    1.16 Tracing
    1.17 QMP introspection
    1.18 Miscellanea

Section "1.18 Miscellanea" is still too big: it documents 134 symbols.
Section "1.7.1 Block core (VM unrelated)" is also rather big: 128
symbols.  All the others are of reasonable size.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-17-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 2 +-
 qapi/block-core.json | 2 +-
 qapi/block.json      | 5 ++---
 qapi/common.json     | 2 +-
 qapi/crypto.json     | 2 +-
 qapi/trace.json      | 2 +-
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 7a393ec3e9..f3af2cb851 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -94,7 +94,7 @@
 { 'include': 'qapi/introspect.json' }
=20
 ##
-# =3D QMP commands
+# =3D Miscellanea
 ##
=20
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f4caa5c21b..28abb9e6cf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,7 +1,7 @@
 # -*- Mode: Python -*-
=20
 ##
-# =3D=3D QAPI block core definitions (vm unrelated)
+# =3D=3D Block core (VM unrelated)
 ##
=20
 { 'include': 'common.json' }
diff --git a/qapi/block.json b/qapi/block.json
index 8ce335739f..f093fa3f27 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,14 +1,13 @@
 # -*- Mode: Python -*-
=20
 ##
-# =3D QAPI block definitions
+# =3D Block devices
 ##
=20
-# QAPI block core definitions
 { 'include': 'block-core.json' }
=20
 ##
-# =3D=3D QAPI block definitions (vm unrelated)
+# =3D=3D Additional block stuff (VM related)
 ##
=20
 ##
diff --git a/qapi/common.json b/qapi/common.json
index 0c67e4acf5..6eb01821ef 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,7 +1,7 @@
 # -*- Mode: Python -*-
=20
 ##
-# =3D QAPI common definitions
+# =3D Common data types
 ##
=20
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 6b6fde367a..288bc056ef 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -2,7 +2,7 @@
 #
=20
 ##
-# =3D QAPI crypto definitions
+# =3D Cryptography
 ##
=20
 ##
diff --git a/qapi/trace.json b/qapi/trace.json
index de6588d9f7..799b254a18 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -6,7 +6,7 @@
 # See the COPYING file in the top-level directory.
=20
 ##
-# =3D Tracing commands
+# =3D Tracing
 ##
=20
 ##
--=20
2.13.5
