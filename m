Received: from eggs.gnu.org ([208.118.235.92]:48038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWaA-0001zM-CX
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWa3-0002yG-Mk
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:18 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51641 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWa3-0002PB-DJ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:11 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:23:06 +0100
Message-Id: <1545920586-17815-27-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 26/26] disas: nanoMIPS: Add a note on
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
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add "nanoMIPS32 Instruction Set Technical Reference Manual" as
a reference.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index ea902f9..fa3beb6 100644
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
