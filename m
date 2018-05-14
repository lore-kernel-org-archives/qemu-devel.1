Received: from eggs.gnu.org ([2001:4830:134:3::10]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIHpb-00009f-SR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIHpX-0007HU-0p
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:19 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fIHpW-0007Fu-NO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:04:14 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 14 May 2018 20:05:06 +0200
Message-Id: <20180514180506.17388-2-laurent@vivier.eu>
In-Reply-To: <20180514180506.17388-1-laurent@vivier.eu>
References: <20180514180506.17388-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/1] m68k: fix floatx80_mod() (Coverity
 CID1390568)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Update the variable checked by the loop condition (expDiff).
Backport the update from Previous.

Fixes: 591596b77a ("target/m68k: add fmod/frem")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20180508203937.16796-1-laurent@vivier.eu>
---
 target/m68k/softfloat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index e41b07d042..d093997219 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -103,6 +103,7 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
         mul64To128(bSig, qTemp, &term0, &term1);
         sub128(aSig0, aSig1, term0, term1, &aSig0, &aSig1);
         shortShift128Left(aSig0, aSig1, 62, &aSig0, &aSig1);
+        expDiff -= 62;
     }
     expDiff += 64;
     if (0 < expDiff) {
-- 
2.14.3
