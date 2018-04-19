Received: from eggs.gnu.org ([2001:4830:134:3::10]:52725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANP-0004fo-Kl
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANO-00065G-N5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:31 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANO-00064l-FL
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:30 -0400
Received: by mail-wr0-x243.google.com with SMTP id d19-v6so14540934wre.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:30 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:57 +0100
Message-Id: <20180419135901.30035-40-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v2 39/43] softfloat: do not include glib headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

From: "Emilio G. Cota" <cota@braap.org>

To ease the cross-compilation of softfloat.o.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 70e0c40a1c..a2a5d4ea33 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -82,6 +82,7 @@ this code that are retained.
 /* softfloat (and in particular the code in softfloat-specialize.h) is
  * target-dependent and needs the TARGET_* macros.
  */
+#define QEMU_NO_GLIB
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 #include "fpu/softfloat.h"
@@ -105,6 +106,9 @@ this code that are retained.
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.h"
 
+/* glib headers are not included due to QEMU_NO_GLIB */
+#define g_assert_not_reached() assert(false)
+
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the half-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
-- 
2.17.0
