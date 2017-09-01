Received: from eggs.gnu.org ([2001:4830:134:3::10]:51416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1J-0006bG-Ro
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1I-0001en-V2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1I-0001e0-Ot
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B979561492
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:21 +0200
Message-Id: <20170901153758.8628-11-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 10/47] qlit: make qlit_equal_qobject() take
 const arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170825105913.4060-8-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qlit.h | 2 +-
 qobject/qlit.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 35aabbdc9f..fc1a2d845d 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -44,6 +44,6 @@ struct QLitDictEntry {
 #define QLIT_QLIST(val) \
     { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
=20
-bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
+bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs);
=20
 #endif /* QLIT_H */
diff --git a/qobject/qlit.c b/qobject/qlit.c
index a2975bef3f..ae2787ef35 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -41,7 +41,7 @@ static void compare_helper(QObject *obj, void *opaque)
         qlit_equal_qobject(&helper->objs[helper->index++], obj);
 }
=20
-bool qlit_equal_qobject(QLitObject *lhs, QObject *rhs)
+bool qlit_equal_qobject(const QLitObject *lhs, const QObject *rhs)
 {
     int64_t val;
=20
--=20
2.13.5
