Received: from eggs.gnu.org ([2001:4830:134:3::10]:46919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCL7-0007RD-38
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dlCL6-0004uj-A6
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dlCL6-0004uH-4R
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 06:59:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 067F47EA9A
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 10:59:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Aug 2017 12:59:03 +0200
Message-Id: <20170825105913.4060-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170825105913.4060-1-marcandre.lureau@redhat.com>
References: <20170825105913.4060-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/14] qlit: remove compound literals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

They are not considered constant expressions in C, producing an error
when compiling a const QLit.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index a4ad91321b..f1d6eed317 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -36,13 +36,13 @@ struct QLitDictEntry {
 };
=20
 #define QLIT_QNUM(val) \
-    (QLitObject){.type =3D QTYPE_QNUM, .value.qnum =3D (val)}
+    { .type =3D QTYPE_QNUM, .value.qnum =3D (val) }
 #define QLIT_QSTR(val) \
-    (QLitObject){.type =3D QTYPE_QSTRING, .value.qstr =3D (val)}
+    { .type =3D QTYPE_QSTRING, .value.qstr =3D (val) }
 #define QLIT_QDICT(val) \
-    (QLitObject){.type =3D QTYPE_QDICT, .value.qdict =3D (val)}
+    { .type =3D QTYPE_QDICT, .value.qdict =3D (val) }
 #define QLIT_QLIST(val) \
-    (QLitObject){.type =3D QTYPE_QLIST, .value.qlist =3D (val)}
+    { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
=20
 int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
=20
--=20
2.14.1.146.gd35faa819
