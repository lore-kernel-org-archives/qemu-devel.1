Received: from eggs.gnu.org ([2001:4830:134:3::10]:49758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estwG-0007Bx-14
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1estwA-00050I-7L
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1estwA-0004qr-2z
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:30:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 418B2406365C
	for <qemu-devel@nongnu.org>; Mon,  5 Mar 2018 17:30:00 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  5 Mar 2018 18:29:48 +0100
Message-Id: <20180305172951.2150-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180305172951.2150-1-marcandre.lureau@redhat.com>
References: <20180305172951.2150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] qapi2texi: minor python code simplification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/doc.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index 0ea68bf813..79d11bbe9b 100644
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
=20
--=20
2.16.2.346.g9779355e34
