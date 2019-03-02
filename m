Received: from eggs.gnu.org ([209.51.188.92]:38540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0DHF-0004DC-2o
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0DHE-0005WY-By
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 17:38:41 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Sat,  2 Mar 2019 23:38:24 +0100
Message-Id: <20190302223825.11192-2-philmd@redhat.com>
In-Reply-To: <20190302223825.11192-1-philmd@redhat.com>
References: <20190302223825.11192-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] util/error: Remove an unnecessary NULL
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This NULL check was required while introduced in 680d16dcb79f.
Later refactor added a NULL check in error_setv(), so this check
is now redundant.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
2.20.1
