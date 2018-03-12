Received: from eggs.gnu.org ([2001:4830:134:3::10]:45197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0000fe-3Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJS-0005wZ-00
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJR-0005wB-RU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C7C3401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:35 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:35:52 -0500
Message-Id: <20180312183628.394722-2-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/36] qapi2texi: minor python code
 simplification
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
Message-Id: <20180305172951.2150-2-marcandre.lureau@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/doc.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 0ea68bf8134..79d11bbe9b5 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -134,10 +134,9 @@ def texi_enum_value(value):
 def texi_member(member, suffix=3D''):
     """Format a table of members item for an object type member"""
     typ =3D member.type.doc_type()
-    return '@item @code{%s%s%s}%s%s\n' % (
-        member.name,
-        ': ' if typ else '',
-        typ if typ else '',
+    membertype =3D ': ' + typ if typ else ''
+    return '@item @code{%s%s}%s%s\n' % (
+        member.name, membertype,
         ' (optional)' if member.optional else '',
         suffix)

--=20
2.14.3
