Received: from eggs.gnu.org ([2001:4830:134:3::10]:42392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVIml-00083d-7y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVImh-0001tN-9G
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:15:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVImh-0001rc-3J
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:15:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6858B7AE81
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 16:15:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 17:14:47 +0100
Message-Id: <20181207161447.31314-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] util/error: Remove an unnecessary NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

This NULL check was required while introduced in 680d16dcb79f.
Later refactor added a NULL check in error_setv(), so this check
is now redundant.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 util/error.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/util/error.c b/util/error.c
index b5ccbd8eac..934a78e1b1 100644
--- a/util/error.c
+++ b/util/error.c
@@ -103,10 +103,6 @@ void error_setg_errno_internal(Error **errp,
     va_list ap;
     int saved_errno =3D errno;
=20
-    if (errp =3D=3D NULL) {
-        return;
-    }
-
     va_start(ap, fmt);
     error_setv(errp, src, line, func, ERROR_CLASS_GENERIC_ERROR, fmt, ap=
,
                os_errno !=3D 0 ? strerror(os_errno) : NULL);
--=20
2.17.2
