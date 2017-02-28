Received: from eggs.gnu.org ([2001:4830:134:3::10]:47526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpX-0006EU-Px
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibpU-0000Or-OC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 02:04:15 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:45 +0300
Message-Id: <d000b477f2693dbca97cd8ea751c2e0b71890662.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
References: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] softfloat: Use correct type in
 float64_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

In float64_to_uint64_round_to_zero() a typo meant that we were
taking the uint64_t return value from float64_to_uint64() and
putting it into an int64_t variable before returning it as
uint64_t again. Use uint64_t instead of pointlessly casting it
back and forth to int64_t.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 485a006..7af14e2 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7492,7 +7492,7 @@ uint64_t float64_to_uint64_round_to_zero(float64 a,=
 float_status *status)
 {
     signed char current_rounding_mode =3D status->float_rounding_mode;
     set_float_rounding_mode(float_round_to_zero, status);
-    int64_t v =3D float64_to_uint64(a, status);
+    uint64_t v =3D float64_to_uint64(a, status);
     set_float_rounding_mode(current_rounding_mode, status);
     return v;
 }
--=20
2.1.4
