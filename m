Received: from eggs.gnu.org ([2001:4830:134:3::10]:59553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS333-0003EN-2g
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS331-0006Mo-MH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS331-0006MT-GD
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:43 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A162564C5
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:43 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:17 +0100
Message-Id: <20170113144135.5150-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 03/21] qapi: make TODOs named-sections
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

Have the TODO in the TAG: format, so they will stand out in the
generated documentation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 4 ++--
 qapi/introspect.json | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index bcbf72bf59..c18a59fefc 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2314,7 +2314,7 @@
 #                     "mac": "52:54:00:12:34:56" } }
 # <- { "return": {} }
 #
-# TODO This command effectively bypasses QAPI completely due to its
+# TODO: This command effectively bypasses QAPI completely due to its
 # "additional arguments" business.  It shouldn't have been added to
 # the schema in this form.  It should be qapified properly, or
 # replaced by a properly qapified command.
@@ -2515,7 +2515,7 @@
 #
 # Additional arguments depend on the type.
 #
-# TODO This command effectively bypasses QAPI completely due to its
+# TODO: This command effectively bypasses QAPI completely due to its
 # "additional arguments" business.  It shouldn't have been added to
 # the schema in this form.  It should be qapified properly, or
 # replaced by a properly qapified command.
diff --git a/qapi/introspect.json b/qapi/introspect.json
index fd4dc84196..464097a235 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -258,7 +258,7 @@
 #
 # @ret-type: the name of the command's result type.
 #
-# TODO @success-response (currently irrelevant, because it's QGA, not QM=
P)
+# TODO: @success-response (currently irrelevant, because it's QGA, not Q=
MP)
 #
 # Since: 2.5
 ##
--=20
2.11.0
