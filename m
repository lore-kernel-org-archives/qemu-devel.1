Received: from eggs.gnu.org ([2001:4830:134:3::10]:56804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryN0-0004Jz-Oh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0000VO-99
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:18 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:38 +1000
Message-Id: <20180821043343.7514-22-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/26] qemu-doc: mark ppc/prep machine as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

40p machine type should be used instead.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 qemu-deprecated.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 67b721156f..87212b62f2 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -195,6 +195,12 @@ support page sizes < 4096 any longer.
 These machine types are very old and likely can not be used for live mig=
ration
 from old QEMU versions anymore. A newer machine type should be used inst=
ead.
=20
+@subsection prep (PowerPC) (since 3.1)
+
+This machine type uses an unmaintained firmware, broken in lots of ways,
+and unable to start post-2004 operating systems. 40p machine type should=
 be
+used instead.
+
 @section Device options
=20
 @subsection Block device options
--=20
2.17.1
