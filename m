Received: from eggs.gnu.org ([2001:4830:134:3::10]:57362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg8-0006GG-6S
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQhg4-0004w4-CM
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 17:45:04 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:22 +0300
Message-Id: <cf01b9920e85fc433056d09a7675f1eafb83086e.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/61] hw/registerfields: add 64-bit
 extract/deposit macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/registerfields.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index ad9d7a82a3..f59e7f47bd 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -35,6 +35,9 @@
 #define FIELD_EX32(storage, reg, field)                                 =
  \
     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
               R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX64(storage, reg, field)                                 =
  \
+    extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
+              R_ ## reg ## _ ## field ## _LENGTH)
=20
 /* Extract a field from an array of registers */
 #define ARRAY_FIELD_EX32(regs, reg, field)                              =
  \
@@ -52,6 +55,14 @@
     d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
                   R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
     d; })
+#define FIELD_DP64(storage, reg, field, val) ({                         =
  \
+    struct {                                                            =
  \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
+    } v =3D { .v =3D val };                                             =
      \
+    uint64_t d;                                                         =
  \
+    d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
+    d; })
=20
 /* Deposit a field to array of registers.  */
 #define ARRAY_FIELD_DP32(regs, reg, field, val)                         =
  \
--=20
2.11.0
