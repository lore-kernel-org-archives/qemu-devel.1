Received: from eggs.gnu.org ([209.51.188.92]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrd-0005bS-S8
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghfrc-0000TN-Uf
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 14:19:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 13:18:59 -0600
Message-Id: <20190110191901.5082-6-eblake@redhat.com>
In-Reply-To: <20190110191901.5082-1-eblake@redhat.com>
References: <20190110191901.5082-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/6] Revert "include: Add a comment to
 explain the origin of sizes' lookup table"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lbloch@janustech.com, armbru@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

This reverts commit 1240ac558d348f6c7a5752b1a57c1da58e4efe3e.

The table itself is about to be reverted, now that it has no clients.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/qemu/units.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/qemu/units.h b/include/qemu/units.h
index 1c959d182e8..68a77586504 100644
--- a/include/qemu/units.h
+++ b/include/qemu/units.h
@@ -17,24 +17,6 @@
 #define PiB     (INT64_C(1) << 50)
 #define EiB     (INT64_C(1) << 60)

-/*
- * The following lookup table is intended to be used when a literal stri=
ng of
- * the number of bytes is required (for example if it needs to be string=
ified).
- * It can also be used for generic shortcuts of power-of-two sizes.
- * This table is generated using the AWK script below:
- *
- *  BEGIN {
- *      suffix=3D"KMGTPE";
- *      for(i=3D10; i<64; i++) {
- *          val=3D2**i;
- *          s=3Dsubstr(suffix, int(i/10), 1);
- *          n=3D2**(i%10);
- *          pad=3D21-int(log(n)/log(10));
- *          printf("#define S_%d%siB %*d\n", n, s, pad, val);
- *      }
- *  }
- */
-
 #define S_1KiB                  1024
 #define S_2KiB                  2048
 #define S_4KiB                  4096
--=20
2.20.1
