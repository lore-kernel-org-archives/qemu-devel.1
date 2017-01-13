Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33E-0003Nu-9K
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33A-0006Sk-TE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS33A-0006SN-Kq
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:52 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3C9C64DA0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:23 +0100
Message-Id: <20170113144135.5150-10-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 09/21] qapi: add some sections in docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add some more section titles to organize the documentation we're going
to generate.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     |  4 ++++
 qapi/block-core.json |  6 ++++--
 qapi/block.json      | 10 ++++++++--
 qapi/common.json     |  6 ++++--
 qapi/crypto.json     |  5 ++++-
 qapi/event.json      |  6 ++++++
 qapi/rocker.json     |  4 ++++
 qapi/trace.json      |  3 +++
 8 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index c1af70057d..54c3e48ba9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -20,6 +20,10 @@
 # QAPI introspection
 { 'include': 'qapi/introspect.json' }
=20
+##
+# =3D QMP commands
+##
+
 ##
 # @qmp_capabilities:
 #
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fb5034c3a9..7f7f10bb49 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,6 +1,8 @@
 # -*- Mode: Python -*-
-#
-# QAPI block core definitions (vm unrelated)
+
+##
+# =3D=3D QAPI block core definitions (vm unrelated)
+##
=20
 # QAPI common definitions
 { 'include': 'common.json' }
diff --git a/qapi/block.json b/qapi/block.json
index 8e9f59019a..693e234779 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,10 +1,16 @@
 # -*- Mode: Python -*-
-#
-# QAPI block definitions (vm related)
+
+##
+# =3D QAPI block definitions
+##
=20
 # QAPI block core definitions
 { 'include': 'block-core.json' }
=20
+##
+# =3D=3D QAPI block definitions (vm unrelated)
+##
+
 ##
 # @BiosAtaTranslation:
 #
diff --git a/qapi/common.json b/qapi/common.json
index 624a8619c8..d93f159946 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,6 +1,8 @@
 # -*- Mode: Python -*-
-#
-# QAPI common definitions
+
+##
+# =3D QAPI common definitions
+##
=20
 ##
 # @QapiErrorClass:
diff --git a/qapi/crypto.json b/qapi/crypto.json
index f4fd93b813..93a04743ea 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,6 +1,9 @@
 # -*- Mode: Python -*-
 #
-# QAPI crypto definitions
+
+##
+# =3D QAPI crypto definitions
+##
=20
 ##
 # @QCryptoTLSCredsEndpoint:
diff --git a/qapi/event.json b/qapi/event.json
index c7689b211d..0cd4b79ad8 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -1,3 +1,9 @@
+# -*- Mode: Python -*-
+
+##
+# =3D Other events
+##
+
 ##
 # @SHUTDOWN:
 #
diff --git a/qapi/rocker.json b/qapi/rocker.json
index ace27760f1..1e511cd37a 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,3 +1,7 @@
+##
+# =3D Rocker switch device
+##
+
 ##
 # @RockerSwitch:
 #
diff --git a/qapi/trace.json b/qapi/trace.json
index 4fd39b7792..3ad7df7fdb 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -5,6 +5,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
 # See the COPYING file in the top-level directory.
=20
+##
+# =3D Tracing commands
+##
=20
 ##
 # @TraceEventState:
--=20
2.11.0
