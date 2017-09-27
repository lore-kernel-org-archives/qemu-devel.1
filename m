Received: from eggs.gnu.org ([2001:4830:134:3::10]:56840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70U-0001a5-5R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70Q-0004AC-Si
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:09 +1000
Message-Id: <20170927074316.4454-20-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/26] ppc: remove all unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: John Snow <jsnow@redhat.com>

Remove *all* unused CPU definitions as indicated by compile-time
`#if 0` constructs.

Signed-off-by: John Snow <jsnow@redhat.com>
[dwg: Removed some additional now-useless comments]
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.h | 225 ------------------------------------------------
 1 file changed, 225 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 152365425d..25ef372d4c 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -44,184 +44,55 @@ enum {
     /* PowerPC 401 cores */
     CPU_POWERPC_401A1              = 0x00210000,
     CPU_POWERPC_401B2              = 0x00220000,
-#if 0
-    CPU_POWERPC_401B3              = xxx,
-#endif
     CPU_POWERPC_401C2              = 0x00230000,
     CPU_POWERPC_401D2              = 0x00240000,
     CPU_POWERPC_401E2              = 0x00250000,
     CPU_POWERPC_401F2              = 0x00260000,
     CPU_POWERPC_401G2              = 0x00270000,
     /* PowerPC 401 microcontrolers */
-#if 0
-    CPU_POWERPC_401GF              = xxx,
-#endif
 #define CPU_POWERPC_IOP480           CPU_POWERPC_401B2
     /* IBM Processor for Network Resources */
     CPU_POWERPC_COBRA              = 0x10100000, /* XXX: 405 ? */
-#if 0
-    CPU_POWERPC_XIPCHIP            = xxx,
-#endif
     /* PowerPC 403 family */
     /* PowerPC 403 microcontrollers */
     CPU_POWERPC_403GA              = 0x00200011,
     CPU_POWERPC_403GB              = 0x00200100,
     CPU_POWERPC_403GC              = 0x00200200,
     CPU_POWERPC_403GCX             = 0x00201400,
-#if 0
-    CPU_POWERPC_403GP              = xxx,
-#endif
     /* PowerPC 405 family */
     /* PowerPC 405 cores */
-#if 0
-    CPU_POWERPC_405A3              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405A4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405B3              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405B4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405C3              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405C4              = xxx,
-#endif
     CPU_POWERPC_405D2              = 0x20010000,
-#if 0
-    CPU_POWERPC_405D3              = xxx,
-#endif
     CPU_POWERPC_405D4              = 0x41810000,
-#if 0
-    CPU_POWERPC_405D5              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405E4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405F4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405F5              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405F6              = xxx,
-#endif
     /* PowerPC 405 microcontrolers */
     /* XXX: missing 0x200108a0 */
     CPU_POWERPC_405CRa             = 0x40110041,
     CPU_POWERPC_405CRb             = 0x401100C5,
     CPU_POWERPC_405CRc             = 0x40110145,
     CPU_POWERPC_405EP              = 0x51210950,
-#if 0
-    CPU_POWERPC_405EXr             = xxx,
-#endif
     CPU_POWERPC_405EZ              = 0x41511460, /* 0x51210950 ? */
-#if 0
-    CPU_POWERPC_405FX              = xxx,
-#endif
     CPU_POWERPC_405GPa             = 0x40110000,
     CPU_POWERPC_405GPb             = 0x40110040,
     CPU_POWERPC_405GPc             = 0x40110082,
     CPU_POWERPC_405GPd             = 0x401100C4,
     CPU_POWERPC_405GPR             = 0x50910951,
-#if 0
-    CPU_POWERPC_405H               = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405L               = xxx,
-#endif
     CPU_POWERPC_405LP              = 0x41F10000,
-#if 0
-    CPU_POWERPC_405PM              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405PS              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_405S               = xxx,
-#endif
     /* IBM network processors */
     CPU_POWERPC_NPE405H            = 0x414100C0,
     CPU_POWERPC_NPE405H2           = 0x41410140,
     CPU_POWERPC_NPE405L            = 0x416100C0,
     CPU_POWERPC_NPE4GS3            = 0x40B10000,
-#if 0
-    CPU_POWERPC_NPCxx1             = xxx,
-#endif
-#if 0
-    CPU_POWERPC_NPR161             = xxx,
-#endif
-#if 0
-    CPU_POWERPC_LC77700            = xxx,
-#endif
     /* IBM STBxxx (PowerPC 401/403/405 core based microcontrollers) */
-#if 0
-    CPU_POWERPC_STB01000           = xxx,
-#endif
-#if 0
-    CPU_POWERPC_STB01010           = xxx,
-#endif
-#if 0
-    CPU_POWERPC_STB0210            = xxx, /* 401B3 */
-#endif
     CPU_POWERPC_STB03              = 0x40310000, /* 0x40130000 ? */
-#if 0
-    CPU_POWERPC_STB043             = xxx,
-#endif
-#if 0
-    CPU_POWERPC_STB045             = xxx,
-#endif
     CPU_POWERPC_STB04              = 0x41810000,
     CPU_POWERPC_STB25              = 0x51510950,
-#if 0
-    CPU_POWERPC_STB130             = xxx,
-#endif
     /* Xilinx cores */
     CPU_POWERPC_X2VP4              = 0x20010820,
     CPU_POWERPC_X2VP20             = 0x20010860,
-#if 0
-    CPU_POWERPC_ZL10310            = xxx,
-#endif
-#if 0
-    CPU_POWERPC_ZL10311            = xxx,
-#endif
-#if 0
-    CPU_POWERPC_ZL10320            = xxx,
-#endif
-#if 0
-    CPU_POWERPC_ZL10321            = xxx,
-#endif
     /* PowerPC 440 family */
     /* Generic PowerPC 440 */
 #define CPU_POWERPC_440              CPU_POWERPC_440GXf
     /* PowerPC 440 cores */
-#if 0
-    CPU_POWERPC_440A4              = xxx,
-#endif
     CPU_POWERPC_440_XILINX         = 0x7ff21910,
-#if 0
-    CPU_POWERPC_440A5              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_440B4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_440F5              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_440G5              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_440H4              = xxx,
-#endif
-#if 0
-    CPU_POWERPC_440H6              = xxx,
-#endif
     /* PowerPC 440 microcontrolers */
     CPU_POWERPC_440EPa             = 0x42221850,
     CPU_POWERPC_440EPb             = 0x422218D3,
@@ -234,25 +105,10 @@ enum {
     CPU_POWERPC_440GXb             = 0x51B21851,
     CPU_POWERPC_440GXc             = 0x51B21892,
     CPU_POWERPC_440GXf             = 0x51B21894,
-#if 0
-    CPU_POWERPC_440S               = xxx,
-#endif
     CPU_POWERPC_440SP              = 0x53221850,
     CPU_POWERPC_440SP2             = 0x53221891,
     CPU_POWERPC_440SPE             = 0x53421890,
     CPU_POWERPC_460EXb             = 0x130218A4, /* called 460 but 440 core */
-    /* PowerPC 460 family */
-#if 0
-    /* Generic PowerPC 464 */
-#define CPU_POWERPC_464              CPU_POWERPC_464H90
-#endif
-    /* PowerPC 464 microcontrolers */
-#if 0
-    CPU_POWERPC_464H90             = xxx,
-#endif
-#if 0
-    CPU_POWERPC_464H90FP           = xxx,
-#endif
     /* Freescale embedded PowerPC cores */
     /* PowerPC MPC 5xx cores (aka RCPU) */
     CPU_POWERPC_MPC5xx             = 0x00020020,
@@ -281,15 +137,6 @@ enum {
 #define CPU_POWERPC_MPC5200B_v21     CPU_POWERPC_G2LEgp1
     /* e200 family */
     /* e200 cores */
-#if 0
-    CPU_POWERPC_e200z0             = xxx,
-#endif
-#if 0
-    CPU_POWERPC_e200z1             = xxx,
-#endif
-#if 0 /* ? */
-    CPU_POWERPC_e200z3             = 0x81120000,
-#endif
     CPU_POWERPC_e200z5             = 0x81000000,
     CPU_POWERPC_e200z6             = 0x81120000,
     /* e300 family */
@@ -407,9 +254,6 @@ enum {
     /* XXX: missing 0x000a0100 */
     /* XXX: missing 0x00093102 */
     CPU_POWERPC_604R               = 0x000a0101,
-#if 0
-    CPU_POWERPC_604EV              = xxx, /* XXX: same as 604R ? */
-#endif
     /* PowerPC 740/750 cores (aka G3) */
     /* XXX: missing 0x00084202 */
     CPU_POWERPC_7x0_v10            = 0x00080100,
@@ -464,9 +308,6 @@ enum {
     CPU_POWERPC_7x5_v26            = 0x00083206,
     CPU_POWERPC_7x5_v27            = 0x00083207,
     CPU_POWERPC_7x5_v28            = 0x00083208,
-#if 0
-    CPU_POWERPC_7x5P               = xxx,
-#endif
     /* PowerPC 74xx cores (aka G4) */
     /* XXX: missing 0x000C1101 */
     CPU_POWERPC_7400_v10           = 0x000C0100,
@@ -554,12 +395,6 @@ enum {
     /* XXX: should be POWER (RIOS), RSC3308, RSC4608,
      * POWER2 (RIOS2) & RSC2 (P2SC) here
      */
-#if 0
-    CPU_POWER                      = xxx, /* 0x20000 ? 0x30000 for RSC ? */
-#endif
-#if 0
-    CPU_POWER2                     = xxx, /* 0x40000 ? */
-#endif
     /* PA Semi core */
     CPU_POWERPC_PA6T               = 0x00900000,
 };
@@ -583,60 +418,6 @@ enum {
     POWERPC_SVR_5200B_v20          = 0x80110020,
     POWERPC_SVR_5200B_v21          = 0x80110021,
 #define POWERPC_SVR_55xx             POWERPC_SVR_5567
-#if 0
-    POWERPC_SVR_5533               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5534               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5553               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5554               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5561               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5565               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5566               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_5567               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8313               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8313E              = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8314               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8314E              = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8315               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8315E              = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8321               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8321E              = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8323               = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8323E              = xxx,
-#endif
     POWERPC_SVR_8343               = 0x80570010,
     POWERPC_SVR_8343A              = 0x80570030,
     POWERPC_SVR_8343E              = 0x80560010,
@@ -653,12 +434,6 @@ enum {
     POWERPC_SVR_8349A              = 0x80510030,
     POWERPC_SVR_8349E              = 0x80500010,
     POWERPC_SVR_8349EA             = 0x80500030,
-#if 0
-    POWERPC_SVR_8358E              = xxx,
-#endif
-#if 0
-    POWERPC_SVR_8360E              = xxx,
-#endif
 #define POWERPC_SVR_E500             0x40000000
     POWERPC_SVR_8377               = 0x80C70010 | POWERPC_SVR_E500,
     POWERPC_SVR_8377E              = 0x80C60010 | POWERPC_SVR_E500,
-- 
2.13.5
