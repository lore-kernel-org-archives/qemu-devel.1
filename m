Received: from eggs.gnu.org ([2001:4830:134:3::10]:46545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmYZ-0003gl-79
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmYV-0005Xz-1b
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:55:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmYU-0005Xj-IC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:55:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8650B5D697
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 18:55:29 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:55:06 +0100
Message-Id: <20171106185506.20334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] memory: remove unused
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This was never used since its introduction in commit
196ea13104f8 ("memory: Add global-locking property to memory
regions").

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/exec/memory.h | 12 ------------
 memory.c              |  5 -----
 2 files changed, 17 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042f87..a4cabdf44c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1240,18 +1240,6 @@ void memory_region_set_flush_coalesced(MemoryRegio=
n *mr);
  */
 void memory_region_clear_flush_coalesced(MemoryRegion *mr);
=20
-/**
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
 /**
  * memory_region_clear_global_locking: Declares that access processing d=
oes
  *                                     not depend on the QEMU global loc=
k.
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
2.15.0.rc0.40.gaefcc5f6f
