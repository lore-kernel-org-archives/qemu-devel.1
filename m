Received: from eggs.gnu.org ([2001:4830:134:3::10]:37206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqils-0006aK-PU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqilk-0001je-Vx
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:06:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqilk-0001iR-Gk
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FAD39F733
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 542BA7EFF1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:05:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 17:05:39 +0100
Message-Id: <1490198748-4753-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490198748-4753-1-git-send-email-armbru@redhat.com>
References: <1490198748-4753-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 08/17] qapi: Drop unused QAPIDoc member
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unused since commit aa964b7 "qapi2texi: Convert to QAPISchemaVisitor"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490015515-25851-4-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e88c047..6c4d554 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -106,7 +106,6 @@ class QAPIDoc(object):
             self.name =3D name
             # the list of lines for this section
             self.content =3D []
-            self.optional =3D False
=20
         def append(self, line):
             self.content.append(line)
--=20
2.7.4
