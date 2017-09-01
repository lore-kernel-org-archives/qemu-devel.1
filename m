Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0000Fv-Ow
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUh-0007Kb-V5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUh-0007Jn-PI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C973E7EA9D
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 969DCC4532
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:41 +0200
Message-Id: <20170901125611.29295-18-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/47] qapi-schema: Introspection doc is in the
 wrong section, fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Bug: introspection documentation is in section "Tracing commands".

Cause: sub-schema qapi/introspect.json lacks a section header, and
therefore goes into whatever section precedes its include.

Fix: add a section header.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1503602048-12268-3-git-send-email-armbru@redhat.com>
---
 qapi/introspect.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qapi/introspect.json b/qapi/introspect.json
index cf77ff0669..5b3e6e9d78 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,7 +1,5 @@
 # -*- Mode: Python -*-
 #
-# QAPI/QMP introspection
-#
 # Copyright (C) 2015 Red Hat, Inc.
 #
 # Authors:
@@ -11,6 +9,10 @@
 # See the COPYING file in the top-level directory.
=20
 ##
+# =3D QMP introspection
+##
+
+##
 # @query-qmp-schema:
 #
 # Command query-qmp-schema exposes the QMP wire ABI as an array of
--=20
2.13.5
