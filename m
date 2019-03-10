Received: from eggs.gnu.org ([209.51.188.92]:42995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001LI-1f
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toS-0001YI-Vy
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:33 +1100
Message-Id: <20190310082703.1245-31-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/60] ppc/pnv: fix logging primitives using Ox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-12-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c | 10 +++++-----
 hw/ppc/pnv_psi.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 172a915cfc..9b18ce55e3 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -294,7 +294,7 @@ static uint64_t lpc_hc_read(void *opaque, hwaddr addr=
, unsigned size)
         val =3D  lpc->lpc_hc_error_addr;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: 0x%"
                       HWADDR_PRIx "\n", addr);
     }
     return val;
@@ -332,7 +332,7 @@ static void lpc_hc_write(void *opaque, hwaddr addr, u=
int64_t val,
     case LPC_HC_ERROR_ADDRESS:
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "LPC HC Unimplemented register: 0x%"
                       HWADDR_PRIx "\n", addr);
     }
 }
@@ -370,7 +370,7 @@ static uint64_t opb_master_read(void *opaque, hwaddr =
addr, unsigned size)
         val =3D lpc->opb_irq_input;
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OPB MASTER Unimplemented register: Ox%=
"
+        qemu_log_mask(LOG_UNIMP, "OPBM: read on unimplemented register: =
0x%"
                       HWADDR_PRIx "\n", addr);
     }
=20
@@ -399,8 +399,8 @@ static void opb_master_write(void *opaque, hwaddr add=
r,
         /* Read only */
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OPB MASTER Unimplemented register: Ox%=
"
-                      HWADDR_PRIx "\n", addr);
+        qemu_log_mask(LOG_UNIMP, "OPBM: write on unimplemented register:=
 0x%"
+                      HWADDR_PRIx " val=3D0x%08"PRIx64"\n", addr, val);
     }
 }
=20
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 44bc0cbf58..c872be0b9c 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -323,7 +323,7 @@ static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_=
t offset, bool mmio)
         val =3D psi->regs[offset];
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "PSI: read at Ox%" PRIx32 "\n", offset)=
;
+        qemu_log_mask(LOG_UNIMP, "PSI: read at 0x%" PRIx32 "\n", offset)=
;
     }
     return val;
 }
@@ -382,7 +382,7 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t o=
ffset, uint64_t val,
         pnv_psi_set_irsn(psi, val);
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "PSI: write at Ox%" PRIx32 "\n", offset=
);
+        qemu_log_mask(LOG_UNIMP, "PSI: write at 0x%" PRIx32 "\n", offset=
);
     }
 }
=20
--=20
2.20.1
