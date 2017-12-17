Received: from eggs.gnu.org ([2001:4830:134:3::10]:54103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQkxL-0005UQ-Cd
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQkxH-0007du-9o
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:15:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:14 +0300
Message-Id: <e85e01a94c852cd0b160a88625447f7cabcffc86.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/61] memory: remove unused
 memory_region_set_global_locking()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This was never used since its introduction in commit
196ea13104f8 ("memory: Add global-locking property to memory
regions").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/exec/memory.h | 12 ------------
 memory.c              |  5 -----
 2 files changed, 17 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f87..a4cabdf44c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1241,18 +1241,6 @@ void memory_region_set_flush_coalesced(MemoryRegio=
n *mr);
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
=20
 /**
- * memory_region_set_global_locking: Declares the access processing requ=
ires
- *                                   QEMU's global lock.
- *
- * When this is invoked, accesses to the memory region will be processed=
 while
- * holding the global lock of QEMU. This is the default behavior of memo=
ry
- * regions.
- *
- * @mr: the memory region to be updated.
- */
-void memory_region_set_global_locking(MemoryRegion *mr);
-
-/**
  * memory_region_clear_global_locking: Declares that access processing d=
oes
  *                                     not depend on the QEMU global loc=
k.
  *
diff --git a/memory.c b/memory.c
index e26e5a3b1d..4b41fb837b 100644
--- a/memory.c
+++ b/memory.c
@@ -2189,11 +2189,6 @@ void memory_region_clear_flush_coalesced(MemoryReg=
ion *mr)
     }
 }
=20
-void memory_region_set_global_locking(MemoryRegion *mr)
-{
-    mr->global_locking =3D true;
-}
-
 void memory_region_clear_global_locking(MemoryRegion *mr)
 {
     mr->global_locking =3D false;
--=20
2.11.0
