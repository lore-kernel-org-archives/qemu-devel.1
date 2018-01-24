Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1eeH9C-00037m-RC
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agx@sigxcpu.org>) id 1eeH98-0008DR-2R
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 04:15:10 -0500
Date: Wed, 24 Jan 2018 10:14:56 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Message-ID: <39441aea4e2d05cc505ed3a373e81d3869eb994a.1516785202.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] linux-user: Fix register used for 6th syscall
 argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Unbreaks the testcase from

    http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
 linux-user/host/aarch64/safe-syscall.inc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/host=
/aarch64/safe-syscall.inc.S
index 58a2329b37..e4fbc31454 100644
--- a/linux-user/host/aarch64/safe-syscall.inc.S
+++ b/linux-user/host/aarch64/safe-syscall.inc.S
@@ -36,7 +36,7 @@ safe_syscall_base:
 	 *               and return the result in x0
 	 * and the syscall instruction needs
 	 *               x8 =3D=3D syscall number
-	 *               x0 ... x7 =3D=3D syscall arguments
+	 *               x0 ... x5 =3D=3D syscall arguments
 	 *               and returns the result in x0
 	 * Shuffle everything around appropriately.
 	 */
@@ -47,7 +47,7 @@ safe_syscall_base:
 	mov	x2, x4
 	mov	x3, x5
 	mov	x4, x6
-	mov	x6, x7
+	mov	x5, x7
 	ldr	x7, [sp]
=20
 	/* This next sequence of code works in conjunction with the
--=20
2.15.1
