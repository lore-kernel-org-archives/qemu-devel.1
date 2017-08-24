Received: from eggs.gnu.org ([2001:4830:134:3::10]:58788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSl-0006xb-Sw
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dkpSh-000439-L4
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dkpSh-00042w-El
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:34:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76F01356CC
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 10:34:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 24 Aug 2017 12:33:40 +0200
Message-Id: <20170824103350.16400-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170824103350.16400-1-marcandre.lureau@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/14] qlit: remove needless type cast
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

And misc code style fix.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index f36bca4554..1e9696988a 100644
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
