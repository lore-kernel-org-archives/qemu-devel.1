Received: from eggs.gnu.org ([2001:4830:134:3::10]:45917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvD-000609-9e
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvA-0002td-43
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:23 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:14:51 +0300
Message-Id: <f7c922ed3d8e3cb54febbdc594ce9f4400e0d290.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/22] HACKING: document preference for g_new
 instead of g_malloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-trivial@nongnu.org, David Hildenbrand <david@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

This patch documents the preference for g_new instead of g_malloc. The
reasons were adapted from commit b45c03f585ea9bb1af76c73e82195418c294919d=
.

Discussion in QEMU's mailing list:
  http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg03238.html

Cc: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 HACKING | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/HACKING b/HACKING
index 4125c97d8d..0fc3e0fc04 100644
--- a/HACKING
+++ b/HACKING
@@ -118,6 +118,15 @@ Please note that g_malloc will exit on allocation fa=
ilure, so there
 is no need to test for failure (as you would have to with malloc).
 Calling g_malloc with a zero size is valid and will return NULL.
=20
+Prefer g_new(T, n) instead of g_malloc(sizeof(T) * n) for the following
+reasons:
+
+  a. It catches multiplication overflowing size_t;
+  b. It returns T * instead of void *, letting compiler catch more type
+     errors.
+
+Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, though.
+
 Memory allocated by qemu_memalign or qemu_blockalign must be freed with
 qemu_vfree, since breaking this will cause problems on Win32.
=20
--=20
2.11.0
