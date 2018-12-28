Received: from eggs.gnu.org ([208.118.235.92]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcpBs-0008Aa-J5
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 05:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcosu-0007m7-2w
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:56:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49723 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoPO-0003KA-Js
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:22 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:44 +0100
Message-Id: <1545989148-13582-38-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/41] disas: nanoMIPS: Add a note on
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add "nanoMIPS32 Instruction Set Technical Reference Manual" as
a reference.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index d6632bb..17f4c22 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -20,6 +20,13 @@
  *
  */
=20
+/*
+ *  Documentation used while implementing this component:
+ *
+ *  [1] "MIPS=C2=AE Architecture Base: nanoMIPS32(tm) Instruction Set Te=
chnical
+ *      Reference Manual", Revision 01.01, April 27, 2018
+ */
+
 extern "C" {
 #include "qemu/osdep.h"
 #include "disas/bfd.h"
--=20
2.7.4
