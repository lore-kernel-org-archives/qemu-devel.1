Received: from eggs.gnu.org ([2001:4830:134:3::10]:50100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0iU-0007rA-1Q
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fv0iR-0000E8-SZ
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:41:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fv0iR-0000CH-4i
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 09:40:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 742D6738F1
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 13:40:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 29 Aug 2018 15:40:35 +0200
Message-Id: <20180829134043.31706-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180829134043.31706-1-marcandre.lureau@redhat.com>
References: <20180829134043.31706-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 02/10] qmp: constify qmp_is_oob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/dispatch.h | 2 +-
 qapi/qmp-dispatch.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
index 4e2e749faf..68a528a9aa 100644
--- a/include/qapi/qmp/dispatch.h
+++ b/include/qapi/qmp/dispatch.h
@@ -50,7 +50,7 @@ bool qmp_has_success_response(const QmpCommand *cmd);
 QDict *qmp_error_response(Error *err);
 QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
                     bool allow_oob);
-bool qmp_is_oob(QDict *dict);
+bool qmp_is_oob(const QDict *dict);
=20
 typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
=20
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index d8da1a62de..1d922e04f7 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -155,7 +155,7 @@ QDict *qmp_error_response(Error *err)
 /*
  * Does @qdict look like a command to be run out-of-band?
  */
-bool qmp_is_oob(QDict *dict)
+bool qmp_is_oob(const QDict *dict)
 {
     return qdict_haskey(dict, "exec-oob")
         && !qdict_haskey(dict, "execute");
--=20
2.19.0.rc0.48.gb9dfa238d5
