Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77S-0002M4-6S
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG77O-0000dI-V4
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG77O-0000d0-Od
	for qemu-devel@nongnu.org; Wed, 31 May 2017 13:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C632C04B316
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-98.ams2.redhat.com
	[10.36.116.98])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E5794D94
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 17:09:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 31 May 2017 19:09:05 +0200
Message-Id: <1496250547-20701-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1496250547-20701-1-git-send-email-armbru@redhat.com>
References: <1496250547-20701-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] qapi: Document visit_type_any() issues with
 keyval input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It's already documented in keyval.c (commit 0ee9ae7), but visitor.h
can use a note, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1495471335-23707-3-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/visitor.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index b0e233d..4721c39 100644
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
2.7.4
