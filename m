Received: from eggs.gnu.org ([2001:4830:134:3::10]:51711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG47z-0002ns-3O
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dG47w-0003ox-GC
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dG47w-0003om-AZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FBF580E79
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 13:57:31 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 May 2017 17:56:26 +0400
Message-Id: <20170531135709.345-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170531135709.345-1-marcandre.lureau@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/45] qapi: Document visit_type_any()
 issues with keyval input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

It's already documented in keyval.c (commit 0ee9ae7), but visitor.h
can use a note, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1495471335-23707-3-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index b0e233df76..4721c39ae3 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -607,6 +607,10 @@ void visit_type_number(Visitor *v, const char *name,=
 double *obj,
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.  *@obj must be non-NULL
  * for output visitors.
+ *
+ * Note that some kinds of input can't express arbitrary QObject.
+ * E.g. the visitor returned by qobject_input_visitor_new_keyval()
+ * can't create numbers or booleans, only strings.
  */
 void visit_type_any(Visitor *v, const char *name, QObject **obj, Error *=
*errp);
=20
--=20
2.13.0.91.g00982b8dd
