Received: from eggs.gnu.org ([209.51.188.92]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlN-0005YB-8r
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlL-0002y8-91
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:53:00 +1100
Message-Id: <20190226045304.25618-47-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 46/50] ppc/xive: xive does not have a POWER7
 interrupt model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Patch "target/ppc: Add POWER9 external interrupt model" should have
removed the section covering PPC_FLAGS_INPUT_POWER7.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190219142530.17807-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 425aa97ef9..daa7badc84 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -481,9 +481,6 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
=20
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
-    case PPC_FLAGS_INPUT_POWER7:
-        tctx->output =3D env->irq_inputs[POWER7_INPUT_INT];
-        break;
     case PPC_FLAGS_INPUT_POWER9:
         tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
--=20
2.20.1
