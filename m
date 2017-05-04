Received: from eggs.gnu.org ([2001:4830:134:3::10]:56356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic2-000246-8M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008K1-8H
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ic0-0008In-14
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10E806199F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF6857D95C
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:59 +0200
Message-Id: <1493911445-19568-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/28] qapi: Document intended use of @name
 within alternate visits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493282486-28338-4-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/visitor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 1a1b620..b0e233d 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -63,8 +63,10 @@
  * The @name parameter of visit_type_FOO() describes the relation
  * between this QAPI value and its parent container.  When visiting
  * the root of a tree, @name is ignored; when visiting a member of an
- * object, @name is the key associated with the value; and when
- * visiting a member of a list, @name is NULL.
+ * object, @name is the key associated with the value; when visiting a
+ * member of a list, @name is NULL; and when visiting the member of an
+ * alternate, @name should equal the name used for visiting the
+ * alternate.
  *
  * The visit_type_FOO() functions expect a non-null @obj argument;
  * they allocate *@obj during input visits, leave it unchanged on
--=20
2.7.4
