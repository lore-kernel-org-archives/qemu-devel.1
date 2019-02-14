Received: from eggs.gnu.org ([209.51.188.92]:56518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMT-0003OW-2g
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guDMN-0003PO-Or
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guDMN-0002cC-64
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:31:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B93F781DE8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:30:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 10:30:36 +0100
Message-Id: <20190214093053.1400-2-armbru@redhat.com>
In-Reply-To: <20190214093053.1400-1-armbru@redhat.com>
References: <20190214093053.1400-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/18] qapi: Belatedly document modular code
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

We generate code for built-ins and sub-modules into separate files
since commit cdb6610ae42 and 252dc3105fc (v2.12.0).  Both commits
neglected to update documentation.  Do that now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 87183d3a09..b91bde647c 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1113,6 +1113,19 @@ Example:
=20
 [Uninteresting stuff omitted...]
=20
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-types-SUBMODULE.h
+SUBDIR/$(prefix)qapi-types-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+qapi-builtin-types.h - C types corresponding to built-in types
+
+qapi-builtin-types.c - Cleanup functions for the above C types
+
 =3D=3D=3D Code generated for visiting QAPI types =3D=3D=3D
=20
 These are the visitor functions used to walk through and convert
@@ -1244,6 +1257,19 @@ Example:
=20
 [Uninteresting stuff omitted...]
=20
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-visit-SUBMODULE.h
+SUBDIR/$(prefix)qapi-visit-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+qapi-builtin-visit.h - Visitor functions for built-in types
+
+qapi-builtin-visit.c - Declarations for these visitor functions
+
 =3D=3D=3D Code generated for commands =3D=3D=3D
=20
 These are the marshaling/dispatch functions for the commands defined
@@ -1342,6 +1368,12 @@ Example:
=20
 [Uninteresting stuff omitted...]
=20
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-commands-SUBMODULE.h
+SUBDIR/$(prefix)qapi-commands-SUBMODULE.c
+
 =3D=3D=3D Code generated for events =3D=3D=3D
=20
 This is the code related to events defined in the schema, providing
@@ -1402,6 +1434,12 @@ Example:
=20
 [Uninteresting stuff omitted...]
=20
+For a modular QAPI schema (see section Include directives), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into
+
+SUBDIR/$(prefix)qapi-events-SUBMODULE.h
+SUBDIR/$(prefix)qapi-events-SUBMODULE.c
+
 =3D=3D=3D Code generated for introspection =3D=3D=3D
=20
 The following files are created:
--=20
2.17.2
