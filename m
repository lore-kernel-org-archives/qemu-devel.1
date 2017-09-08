Received: from eggs.gnu.org ([2001:4830:134:3::10]:58994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGeI-0002LL-T6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe8-0003Oq-8V
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:57 +1000
Message-Id: <20170908103558.31632-40-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 39/40] ppc: remove non implemented cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Remove cpu models that aren't implemented and are not
compiled/tested since they are under TODO ifdef
which isn't defined in sources.

If someone really needs a removed model he/she should add
as regular one with corresponding implementation.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.c | 455 ------------------------------------------------
 1 file changed, 455 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 64629fc39f..9626d6b7c4 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -19,11 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/* A lot of PowerPC definition have been included here.
- * Most of them are not usable for now but have been kept
- * inside "#if defined(TODO) ... #endif" statements to make tests easier.
- */
-
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu-models.h"
@@ -79,10 +74,6 @@
                 "PowerPC 401A1")
     POWERPC_DEF("401b2",         CPU_POWERPC_401B2,                  401x2,
                 "PowerPC 401B2")
-#if defined(TODO)
-    POWERPC_DEF("401b3",         CPU_POWERPC_401B3,                  401x3,
-                "PowerPC 401B3")
-#endif
     POWERPC_DEF("401c2",         CPU_POWERPC_401C2,                  401x2,
                 "PowerPC 401C2")
     POWERPC_DEF("401d2",         CPU_POWERPC_401D2,                  401x2,
@@ -95,18 +86,10 @@
     POWERPC_DEF("401g2",         CPU_POWERPC_401G2,                  401x2,
                 "PowerPC 401G2")
     /* PowerPC 401 microcontrollers                                          */
-#if defined(TODO)
-    POWERPC_DEF("401gf",         CPU_POWERPC_401GF,                  401,
-                "PowerPC 401GF")
-#endif
     POWERPC_DEF("iop480",        CPU_POWERPC_IOP480,                 IOP480,
                 "IOP480 (401 microcontroller)")
     POWERPC_DEF("cobra",         CPU_POWERPC_COBRA,                  401,
                 "IBM Processor for Network Resources")
-#if defined(TODO)
-    POWERPC_DEF("xipchip",       CPU_POWERPC_XIPCHIP,                401,
-                NULL)
-#endif
     /* PowerPC 403 family                                                    */
     /* PowerPC 403 microcontrollers                                          */
     POWERPC_DEF("403ga",         CPU_POWERPC_403GA,                  403,
@@ -117,64 +100,12 @@
                 "PowerPC 403 GC")
     POWERPC_DEF("403gcx",        CPU_POWERPC_403GCX,                 403GCX,
                 "PowerPC 403 GCX")
-#if defined(TODO)
-    POWERPC_DEF("403gp",         CPU_POWERPC_403GP,                  403,
-                "PowerPC 403 GP")
-#endif
     /* PowerPC 405 family                                                    */
     /* PowerPC 405 cores                                                     */
-#if defined(TODO)
-    POWERPC_DEF("405a3",         CPU_POWERPC_405A3,                  405,
-                "PowerPC 405 A3")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405a4",         CPU_POWERPC_405A4,                  405,
-                "PowerPC 405 A4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405b3",         CPU_POWERPC_405B3,                  405,
-                "PowerPC 405 B3")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405b4",         CPU_POWERPC_405B4,                  405,
-                "PowerPC 405 B4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405c3",         CPU_POWERPC_405C3,                  405,
-                "PowerPC 405 C3")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405c4",         CPU_POWERPC_405C4,                  405,
-                "PowerPC 405 C4")
-#endif
     POWERPC_DEF("405d2",         CPU_POWERPC_405D2,                  405,
                 "PowerPC 405 D2")
-#if defined(TODO)
-    POWERPC_DEF("405d3",         CPU_POWERPC_405D3,                  405,
-                "PowerPC 405 D3")
-#endif
     POWERPC_DEF("405d4",         CPU_POWERPC_405D4,                  405,
                 "PowerPC 405 D4")
-#if defined(TODO)
-    POWERPC_DEF("405d5",         CPU_POWERPC_405D5,                  405,
-                "PowerPC 405 D5")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405e4",         CPU_POWERPC_405E4,                  405,
-                "PowerPC 405 E4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405f4",         CPU_POWERPC_405F4,                  405,
-                "PowerPC 405 F4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405f5",         CPU_POWERPC_405F5,                  405,
-                "PowerPC 405 F5")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405f6",         CPU_POWERPC_405F6,                  405,
-                "PowerPC 405 F6")
-#endif
     /* PowerPC 405 microcontrollers                                          */
     POWERPC_DEF("405cra",        CPU_POWERPC_405CRa,                 405,
                 "PowerPC 405 CRa")
@@ -184,16 +115,8 @@
                 "PowerPC 405 CRc")
     POWERPC_DEF("405ep",         CPU_POWERPC_405EP,                  405,
                 "PowerPC 405 EP")
-#if defined(TODO)
-    POWERPC_DEF("405exr",        CPU_POWERPC_405EXr,                 405,
-                "PowerPC 405 EXr")
-#endif
     POWERPC_DEF("405ez",         CPU_POWERPC_405EZ,                  405,
                 "PowerPC 405 EZ")
-#if defined(TODO)
-    POWERPC_DEF("405fx",         CPU_POWERPC_405FX,                  405,
-                "PowerPC 405 FX")
-#endif
     POWERPC_DEF("405gpa",        CPU_POWERPC_405GPa,                 405,
                 "PowerPC 405 GPa")
     POWERPC_DEF("405gpb",        CPU_POWERPC_405GPb,                 405,
@@ -204,28 +127,8 @@
                 "PowerPC 405 GPd")
     POWERPC_DEF("405gpr",        CPU_POWERPC_405GPR,                 405,
                 "PowerPC 405 GPR")
-#if defined(TODO)
-    POWERPC_DEF("405h",          CPU_POWERPC_405H,                   405,
-                "PowerPC 405 H")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405l",          CPU_POWERPC_405L,                   405,
-                "PowerPC 405 L")
-#endif
     POWERPC_DEF("405lp",         CPU_POWERPC_405LP,                  405,
                 "PowerPC 405 LP")
-#if defined(TODO)
-    POWERPC_DEF("405pm",         CPU_POWERPC_405PM,                  405,
-                "PowerPC 405 PM")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405ps",         CPU_POWERPC_405PS,                  405,
-                "PowerPC 405 PS")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("405s",          CPU_POWERPC_405S,                   405,
-                "PowerPC 405 S")
-#endif
     POWERPC_DEF("npe405h",       CPU_POWERPC_NPE405H,                405,
                 "Npe405 H")
     POWERPC_DEF("npe405h2",      CPU_POWERPC_NPE405H2,               405,
@@ -234,113 +137,29 @@
                 "Npe405 L")
     POWERPC_DEF("npe4gs3",       CPU_POWERPC_NPE4GS3,                405,
                 "Npe4GS3")
-#if defined(TODO)
-    POWERPC_DEF("npcxx1",        CPU_POWERPC_NPCxx1,                 405,
-                NULL)
-#endif
-#if defined(TODO)
-    POWERPC_DEF("npr161",        CPU_POWERPC_NPR161,                 405,
-                NULL)
-#endif
-#if defined(TODO)
-    POWERPC_DEF("lc77700",       CPU_POWERPC_LC77700,                405,
-                "PowerPC LC77700 (Sanyo)")
-#endif
     /* PowerPC 401/403/405 based set-top-box microcontrollers                */
-#if defined(TODO)
-    POWERPC_DEF("stb01000",      CPU_POWERPC_STB01000,               401x2,
-                "STB010000")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("stb01010",      CPU_POWERPC_STB01010,               401x2,
-                "STB01010")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("stb0210",       CPU_POWERPC_STB0210,                401x3,
-                "STB0210")
-#endif
     POWERPC_DEF("stb03",         CPU_POWERPC_STB03,                  405,
                 "STB03xx")
-#if defined(TODO)
-    POWERPC_DEF("stb043",        CPU_POWERPC_STB043,                 405,
-                "STB043x")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("stb045",        CPU_POWERPC_STB045,                 405,
-                "STB045x")
-#endif
     POWERPC_DEF("stb04",         CPU_POWERPC_STB04,                  405,
                 "STB04xx")
     POWERPC_DEF("stb25",         CPU_POWERPC_STB25,                  405,
                 "STB25xx")
-#if defined(TODO)
-    POWERPC_DEF("stb130",        CPU_POWERPC_STB130,                 405,
-                "STB130")
-#endif
     /* Xilinx PowerPC 405 cores                                              */
     POWERPC_DEF("x2vp4",         CPU_POWERPC_X2VP4,                  405,
                 NULL)
     POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
                 NULL)
-#if defined(TODO)
-    POWERPC_DEF("zl10310",       CPU_POWERPC_ZL10310,                405,
-                "Zarlink ZL10310")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("zl10311",       CPU_POWERPC_ZL10311,                405,
-                "Zarlink ZL10311")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("zl10320",       CPU_POWERPC_ZL10320,                405,
-                "Zarlink ZL10320")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("zl10321",       CPU_POWERPC_ZL10321,                405,
-                "Zarlink ZL10321")
-#endif
     /* PowerPC 440 family                                                    */
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
                 "Generic PowerPC 440")
 #endif
     /* PowerPC 440 cores                                                     */
-#if defined(TODO)
-    POWERPC_DEF("440a4",         CPU_POWERPC_440A4,                  440x4,
-                "PowerPC 440 A4")
-#endif
     POWERPC_DEF("440-xilinx",    CPU_POWERPC_440_XILINX,             440x5,
                 "PowerPC 440 Xilinx 5")
 
     POWERPC_DEF("440-xilinx-w-dfpu",    CPU_POWERPC_440_XILINX, 440x5wDFPU,
                 "PowerPC 440 Xilinx 5 With a Double Prec. FPU")
-#if defined(TODO)
-    POWERPC_DEF("440a5",         CPU_POWERPC_440A5,                  440x5,
-                "PowerPC 440 A5")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440b4",         CPU_POWERPC_440B4,                  440x4,
-                "PowerPC 440 B4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440g4",         CPU_POWERPC_440G4,                  440x4,
-                "PowerPC 440 G4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440f5",         CPU_POWERPC_440F5,                  440x5,
-                "PowerPC 440 F5")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440g5",         CPU_POWERPC_440G5,                  440x5,
-                "PowerPC 440 G5")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440h4",         CPU_POWERPC_440H4,                  440x4,
-                "PowerPC 440H4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("440h6",         CPU_POWERPC_440H6,                  440Gx5,
-                "PowerPC 440H6")
-#endif
     /* PowerPC 440 microcontrollers                                          */
     POWERPC_DEF("440epa",        CPU_POWERPC_440EPa,                 440EP,
                 "PowerPC 440 EPa")
@@ -380,10 +199,6 @@
     POWERPC_DEF("440gxf",        CPU_POWERPC_440GXf,                 440EP,
                 "PowerPC 440 GXf")
 #endif
-#if defined(TODO)
-    POWERPC_DEF("440s",          CPU_POWERPC_440S,                   440,
-                "PowerPC 440 S")
-#endif
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440sp",         CPU_POWERPC_440SP,                  440EP,
                 "PowerPC 440 SP")
@@ -396,20 +211,6 @@
     POWERPC_DEF("440spe",        CPU_POWERPC_440SPE,                 440EP,
                 "PowerPC 440 SPE")
 #endif
-    /* PowerPC 460 family                                                    */
-#if defined(TODO)
-    POWERPC_DEF("464",           CPU_POWERPC_464,                    460,
-                "Generic PowerPC 464")
-#endif
-    /* PowerPC 464 microcontrollers                                          */
-#if defined(TODO)
-    POWERPC_DEF("464h90",        CPU_POWERPC_464H90,                 460,
-                "PowerPC 464H90")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("464h90f",       CPU_POWERPC_464H90F,                460F,
-                "PowerPC 464H90F")
-#endif
     /* Freescale embedded PowerPC cores                                      */
     /* MPC5xx family (aka RCPU)                                              */
 #if defined(TODO_USER_ONLY)
@@ -447,10 +248,6 @@
     POWERPC_DEF("g2legp3",       CPU_POWERPC_G2LEgp3,                G2LE,
                 "PowerPC G2LE GP3 core")
     /* PowerPC G2 microcontrollers                                           */
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5121", "MPC5121",
-                    CPU_POWERPC_MPC5121,      POWERPC_SVR_5121,      G2LE)
-#endif
     POWERPC_DEF_SVR("mpc5200_v10", "MPC5200 v1.0",
                     CPU_POWERPC_MPC5200_v10,  POWERPC_SVR_5200_v10,  G2LE)
     POWERPC_DEF_SVR("mpc5200_v11", "MPC5200 v1.1",
@@ -462,115 +259,10 @@
     POWERPC_DEF_SVR("mpc5200b_v21", "MPC5200B v2.1",
                     CPU_POWERPC_MPC5200B_v21, POWERPC_SVR_5200B_v21, G2LE)
     /* e200 family                                                           */
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc55xx", "Generic MPC55xx core",
-                    CPU_POWERPC_MPC55xx,      POWERPC_SVR_55xx,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF("e200z0",        CPU_POWERPC_e200z0,                 e200,
-                "PowerPC e200z0 core")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("e200z1",        CPU_POWERPC_e200z1,                 e200,
-                "PowerPC e200z1 core")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("e200z3",        CPU_POWERPC_e200z3,                 e200,
-                "PowerPC e200z3 core")
-#endif
     POWERPC_DEF("e200z5",        CPU_POWERPC_e200z5,                 e200,
                 "PowerPC e200z5 core")
     POWERPC_DEF("e200z6",        CPU_POWERPC_e200z6,                 e200,
                 "PowerPC e200z6 core")
-    /* PowerPC e200 microcontrollers                                         */
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514e", "MPC5514E",
-                    CPU_POWERPC_MPC5514E,     POWERPC_SVR_5514E,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514e_v0", "MPC5514E v0",
-                    CPU_POWERPC_MPC5514E_v0,  POWERPC_SVR_5514E_v0,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514e_v1", "MPC5514E v1",
-                    CPU_POWERPC_MPC5514E_v1,  POWERPC_SVR_5514E_v1,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514g", "MPC5514G",
-                    CPU_POWERPC_MPC5514G,     POWERPC_SVR_5514G,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514g_v0", "MPC5514G v0",
-                    CPU_POWERPC_MPC5514G_v0,  POWERPC_SVR_5514G_v0,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5514g_v1", "MPC5514G v1",
-                    CPU_POWERPC_MPC5514G_v1,  POWERPC_SVR_5514G_v1,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5515s", "MPC5515S",
-                    CPU_POWERPC_MPC5515S,     POWERPC_SVR_5515S,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516e", "MPC5516E",
-                    CPU_POWERPC_MPC5516E,     POWERPC_SVR_5516E,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516e_v0", "MPC5516E v0",
-                    CPU_POWERPC_MPC5516E_v0,  POWERPC_SVR_5516E_v0,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516e_v1", "MPC5516E v1",
-                    CPU_POWERPC_MPC5516E_v1,  POWERPC_SVR_5516E_v1,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516g", "MPC5516G",
-                    CPU_POWERPC_MPC5516G,     POWERPC_SVR_5516G,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516g_v0", "MPC5516G v0",
-                    CPU_POWERPC_MPC5516G_v0,  POWERPC_SVR_5516G_v0,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516g_v1", "MPC5516G v1",
-                    CPU_POWERPC_MPC5516G_v1,  POWERPC_SVR_5516G_v1,  e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5516s", "MPC5516S",
-                    CPU_POWERPC_MPC5516S,     POWERPC_SVR_5516S,     e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5533", "MPC5533",
-                    CPU_POWERPC_MPC5533,      POWERPC_SVR_5533,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5534", "MPC5534",
-                    CPU_POWERPC_MPC5534,      POWERPC_SVR_5534,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5553", "MPC5553",
-                    CPU_POWERPC_MPC5553,      POWERPC_SVR_5553,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5554", "MPC5554",
-                    CPU_POWERPC_MPC5554,      POWERPC_SVR_5554,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5561", "MPC5561",
-                    CPU_POWERPC_MPC5561,      POWERPC_SVR_5561,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5565", "MPC5565",
-                    CPU_POWERPC_MPC5565,      POWERPC_SVR_5565,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5566", "MPC5566",
-                    CPU_POWERPC_MPC5566,      POWERPC_SVR_5566,      e200)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc5567", "MPC5567",
-                    CPU_POWERPC_MPC5567,      POWERPC_SVR_5567,      e200)
-#endif
     /* e300 family                                                           */
     POWERPC_DEF("e300c1",        CPU_POWERPC_e300c1,                 e300,
                 "PowerPC e300c1 core")
@@ -581,46 +273,6 @@
     POWERPC_DEF("e300c4",        CPU_POWERPC_e300c4,                 e300,
                 "PowerPC e300c4 core")
     /* PowerPC e300 microcontrollers                                         */
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8313", "MPC8313",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8313,      e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8313e", "MPC8313E",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8313E,     e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8314", "MPC8314",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8314,      e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8314e", "MPC8314E",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8314E,     e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8315", "MPC8315",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8315,      e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8315e", "MPC8315E",
-                    CPU_POWERPC_MPC831x,      POWERPC_SVR_8315E,     e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8321", "MPC8321",
-                    CPU_POWERPC_MPC832x,      POWERPC_SVR_8321,      e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8321e", "MPC8321E",
-                    CPU_POWERPC_MPC832x,      POWERPC_SVR_8321E,     e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8323", "MPC8323",
-                    CPU_POWERPC_MPC832x,      POWERPC_SVR_8323,      e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8323e", "MPC8323E",
-                    CPU_POWERPC_MPC832x,      POWERPC_SVR_8323E,     e300)
-#endif
     POWERPC_DEF_SVR("mpc8343", "MPC8343",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8343,      e300)
     POWERPC_DEF_SVR("mpc8343a", "MPC8343A",
@@ -653,14 +305,6 @@
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349E,     e300)
     POWERPC_DEF_SVR("mpc8349ea", "MPC8349EA",
                     CPU_POWERPC_MPC834x,      POWERPC_SVR_8349EA,    e300)
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8358e", "MPC8358E",
-                    CPU_POWERPC_MPC835x,      POWERPC_SVR_8358E,     e300)
-#endif
-#if defined(TODO)
-    POWERPC_DEF_SVR("mpc8360e", "MPC8360E",
-                    CPU_POWERPC_MPC836x,      POWERPC_SVR_8360E,     e300)
-#endif
     POWERPC_DEF_SVR("mpc8377", "MPC8377",
                     CPU_POWERPC_MPC837x,      POWERPC_SVR_8377,      e300)
     POWERPC_DEF_SVR("mpc8377e", "MPC8377E",
@@ -857,10 +501,6 @@
                 "PowerPC 604e v2.4")
     POWERPC_DEF("604r",          CPU_POWERPC_604R,                   604E,
                 "PowerPC 604r (aka PIDA)")
-#if defined(TODO)
-    POWERPC_DEF("604ev",         CPU_POWERPC_604EV,                  604E,
-                "PowerPC 604ev")
-#endif
     /* PowerPC 7xx family                                                    */
     POWERPC_DEF("740_v1.0",      CPU_POWERPC_7x0_v10,                740,
                 "PowerPC 740 v1.0 (G3)")
@@ -998,12 +638,6 @@
                 "PowerPC 745 v2.8")
     POWERPC_DEF("755_v2.8",      CPU_POWERPC_7x5_v28,                755,
                 "PowerPC 755 v2.8")
-#if defined(TODO)
-    POWERPC_DEF("745p",          CPU_POWERPC_7x5P,                   745,
-                "PowerPC 745P (G3)")
-    POWERPC_DEF("755p",          CPU_POWERPC_7x5P,                   755,
-                "PowerPC 755P (G3)")
-#endif
     /* PowerPC 74xx family                                                   */
     POWERPC_DEF("7400_v1.0",     CPU_POWERPC_7400_v10,               7400,
                 "PowerPC 7400 v1.0 (G4)")
@@ -1105,34 +739,8 @@
                 "PowerPC 7457A v1.2 (G4)")
     /* 64 bits PowerPC                                                       */
 #if defined (TARGET_PPC64)
-#if defined(TODO)
-    POWERPC_DEF("620",           CPU_POWERPC_620,                    620,
-                "PowerPC 620")
-    POWERPC_DEF("630",           CPU_POWERPC_630,                    630,
-                "PowerPC 630 (POWER3)")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("631",           CPU_POWERPC_631,                    631,
-                "PowerPC 631 (Power 3+)")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("power4",        CPU_POWERPC_POWER4,                 POWER4,
-                "POWER4")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("power4+",       CPU_POWERPC_POWER4P,                POWER4P,
-                "POWER4p")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("power5",        CPU_POWERPC_POWER5,                 POWER5,
-                "POWER5")
-#endif
     POWERPC_DEF("power5+_v2.1",  CPU_POWERPC_POWER5P_v21,            POWER5P,
                 "POWER5+ v2.1")
-#if defined(TODO)
-    POWERPC_DEF("power6",        CPU_POWERPC_POWER6,                 POWER6,
-                "POWER6")
-#endif
     POWERPC_DEF("power7_v2.3",   CPU_POWERPC_POWER7_v23,             POWER7,
                 "POWER7 v2.3")
     POWERPC_DEF("power7+_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
@@ -1163,66 +771,7 @@
                 "PowerPC 970MP v1.0")
     POWERPC_DEF("970mp_v1.1",    CPU_POWERPC_970MP_v11,              970,
                 "PowerPC 970MP v1.1")
-#if defined(TODO)
-    POWERPC_DEF("cell",          CPU_POWERPC_CELL,                   970,
-                "PowerPC Cell")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("cell_v1.0",     CPU_POWERPC_CELL_v10,               970,
-                "PowerPC Cell v1.0")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("cell_v2.0",     CPU_POWERPC_CELL_v20,               970,
-                "PowerPC Cell v2.0")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("cell_v3.0",     CPU_POWERPC_CELL_v30,               970,
-                "PowerPC Cell v3.0")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("cell_v3.1",     CPU_POWERPC_CELL_v31,               970,
-                "PowerPC Cell v3.1")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("cell_v3.2",     CPU_POWERPC_CELL_v32,               970,
-                "PowerPC Cell v3.2")
-#endif
-#if defined(TODO)
-    /* This one seems to support the whole POWER2 instruction set
-     * and the PowerPC 64 one.
-     */
-    /* What about A10 & A30 ? */
-    POWERPC_DEF("rs64",          CPU_POWERPC_RS64,                   RS64,
-                "RS64 (Apache/A35)")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("rs64-ii",       CPU_POWERPC_RS64II,                 RS64,
-                "RS64-II (NorthStar/A50)")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("rs64-iii",      CPU_POWERPC_RS64III,                RS64,
-                "RS64-III (Pulsar)")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("rs64-iv",       CPU_POWERPC_RS64IV,                 RS64,
-                "RS64-IV (IceStar/IStar/SStar)")
-#endif
 #endif /* defined (TARGET_PPC64) */
-    /* POWER                                                                 */
-#if defined(TODO)
-    POWERPC_DEF("power",         CPU_POWERPC_POWER,                  POWER,
-                "Original POWER")
-#endif
-#if defined(TODO)
-    POWERPC_DEF("power2",        CPU_POWERPC_POWER2,                 POWER,
-                "POWER2")
-#endif
-    /* PA semi cores                                                         */
-#if defined(TODO)
-    POWERPC_DEF("pa6t",          CPU_POWERPC_PA6T,                   PA6T,
-                "PA PA6T")
-#endif
-
 
 /***************************************************************************/
 /* PowerPC CPU aliases                                                     */
@@ -1386,10 +935,6 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "7457a", "7457a_v1.2" },
     { "apollo7pm", "7457a_v1.0" },
 #if defined(TARGET_PPC64)
-#if defined(TODO)
-    { "power3", "630" },
-    { "power3+", "631" },
-#endif
     { "power5+", "power5+_v2.1" },
     { "power5gs", "power5+_v2.1" },
     { "power7", "power7_v2.3" },
-- 
2.13.5
