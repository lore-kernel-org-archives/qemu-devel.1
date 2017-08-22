Received: from eggs.gnu.org ([2001:4830:134:3::10]:54798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hn-0006f0-O9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dk9Hk-000649-4k
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dk9Hj-00063T-VF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:32:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F15566146A
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:23:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 15:22:03 +0200
Message-Id: <20170822132255.23945-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/54] qdict: add qdict_put_null() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qdict.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 363e431106..a35bed9f16 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -60,6 +60,8 @@ void qdict_destroy_obj(QObject *obj);
         qdict_put(qdict, key, qbool_from_bool(value))
 #define qdict_put_str(qdict, key, value) \
         qdict_put(qdict, key, qstring_from_str(value))
+#define qdict_put_null(qdict, key) \
+        qdict_put(qdict, key, qnull())
=20
 /* High level helpers */
 double qdict_get_double(const QDict *qdict, const char *key);
--=20
2.14.1.146.gd35faa819
