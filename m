Received: from eggs.gnu.org ([209.51.188.92]:54718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGU-0005zN-Cp
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGQ-0001K3-Fi
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGP-0001G4-NZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:58 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mUp6103300
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:54 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2axy0bm4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:54 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:52 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:16 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-12-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/27] ppc/pnv: fix logging primitives using Ox
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_lpc.c | 10 +++++-----
 hw/ppc/pnv_psi.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 172a915cfc55..9b18ce55e391 100644
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
index 44bc0cbf58cb..c872be0b9c0d 100644
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
