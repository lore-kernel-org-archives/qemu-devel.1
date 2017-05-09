Received: from eggs.gnu.org ([2001:4830:134:3::10]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Ab-00085X-3q
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AV-0007Z6-HQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AV-0007Y2-By
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66F3E37E67
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3485A83DAC
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:38 +0200
Message-Id: <1494317205-2211-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 21/28] qobject-input-visitor: Document
 full_name_nth()
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
Message-Id: <1493282486-28338-3-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qobject-input-visitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 865e948..2530959 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -55,6 +55,17 @@ static QObjectInputVisitor *to_qiv(Visitor *v)
     return container_of(v, QObjectInputVisitor, visitor);
 }
=20
+/*
+ * Find the full name of something @qiv is currently visiting.
+ * @qiv is visiting something named @name in the stack of containers
+ * @qiv->stack.
+ * If @n is zero, return its full name.
+ * If @n is positive, return the full name of the @n-th container
+ * counting from the top.  The stack of containers must have at least
+ * @n elements.
+ * The returned string is valid until the next full_name_nth(@v) or
+ * destruction of @v.
+ */
 static const char *full_name_nth(QObjectInputVisitor *qiv, const char *n=
ame,
                                  int n)
 {
--=20
2.7.4
