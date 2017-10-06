Received: from eggs.gnu.org ([2001:4830:134:3::10]:42711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRK-0001DO-KC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cRJ-00076L-7Q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:53:58 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:53 -0300
Message-Id: <20171006235023.11952-59-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 58/88] ppc4xx: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added more changes in hw/ppc/ppc405_uc.c and hw/ppc/ppc4xx_devs.c]
---
 hw/ppc/ppc405_boards.c |  4 ++--
 hw/ppc/ppc405_uc.c     | 24 ++++++++++++------------
 hw/ppc/ppc440_bamboo.c |  2 +-
 hw/ppc/ppc4xx_devs.c   |  6 +++---
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e92db2c66a..a812985baa 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -169,7 +169,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, uint32_t base)
     ref405ep_fpga_t *fpga;
     MemoryRegion *fpga_memory = g_new(MemoryRegion, 1);
 
-    fpga = g_malloc0(sizeof(ref405ep_fpga_t));
+    fpga = g_new0(ref405ep_fpga_t, 1);
     memory_region_init_io(fpga_memory, NULL, &ref405ep_fpga_ops, fpga,
                           "fpga", 0x00000100);
     memory_region_add_subregion(sysmem, base, fpga_memory);
@@ -472,7 +472,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uint32_t base)
     taihu_cpld_t *cpld;
     MemoryRegion *cpld_memory = g_new(MemoryRegion, 1);
 
-    cpld = g_malloc0(sizeof(taihu_cpld_t));
+    cpld = g_new0(taihu_cpld_t, 1);
     memory_region_init_io(cpld_memory, NULL, &taihu_cpld_ops, cpld, "cpld", 0x100);
     memory_region_add_subregion(sysmem, base, cpld_memory);
     qemu_register_reset(&taihu_cpld_reset, cpld);
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 8e58065f5f..02ab2a24ff 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -181,7 +181,7 @@ void ppc4xx_plb_init(CPUPPCState *env)
 {
     ppc4xx_plb_t *plb;
 
-    plb = g_malloc0(sizeof(ppc4xx_plb_t));
+    plb = g_new0(ppc4xx_plb_t, 1);
     ppc_dcr_register(env, PLB3A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB4A0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
     ppc_dcr_register(env, PLB0_ACR, plb, &dcr_read_plb, &dcr_write_plb);
@@ -266,7 +266,7 @@ static void ppc4xx_pob_init(CPUPPCState *env)
 {
     ppc4xx_pob_t *pob;
 
-    pob = g_malloc0(sizeof(ppc4xx_pob_t));
+    pob = g_new0(ppc4xx_pob_t, 1);
     ppc_dcr_register(env, POB0_BEAR, pob, &dcr_read_pob, &dcr_write_pob);
     ppc_dcr_register(env, POB0_BESR0, pob, &dcr_read_pob, &dcr_write_pob);
     ppc_dcr_register(env, POB0_BESR1, pob, &dcr_read_pob, &dcr_write_pob);
@@ -397,7 +397,7 @@ static void ppc4xx_opba_init(hwaddr base)
 {
     ppc4xx_opba_t *opba;
 
-    opba = g_malloc0(sizeof(ppc4xx_opba_t));
+    opba = g_new0(ppc4xx_opba_t, 1);
 #ifdef DEBUG_OPBA
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
 #endif
@@ -595,7 +595,7 @@ void ppc405_ebc_init(CPUPPCState *env)
 {
     ppc4xx_ebc_t *ebc;
 
-    ebc = g_malloc0(sizeof(ppc4xx_ebc_t));
+    ebc = g_new0(ppc4xx_ebc_t, 1);
     qemu_register_reset(&ebc_reset, ebc);
     ppc_dcr_register(env, EBC0_CFGADDR,
                      ebc, &dcr_read_ebc, &dcr_write_ebc);
@@ -678,7 +678,7 @@ static void ppc405_dma_init(CPUPPCState *env, qemu_irq irqs[4])
 {
     ppc405_dma_t *dma;
 
-    dma = g_malloc0(sizeof(ppc405_dma_t));
+    dma = g_new0(ppc405_dma_t, 1);
     memcpy(dma->irqs, irqs, 4 * sizeof(qemu_irq));
     qemu_register_reset(&ppc405_dma_reset, dma);
     ppc_dcr_register(env, DMA0_CR0,
@@ -819,7 +819,7 @@ static void ppc405_gpio_init(hwaddr base)
 {
     ppc405_gpio_t *gpio;
 
-    gpio = g_malloc0(sizeof(ppc405_gpio_t));
+    gpio = g_new0(ppc405_gpio_t, 1);
 #ifdef DEBUG_GPIO
     printf("%s: offset " TARGET_FMT_plx "\n", __func__, base);
 #endif
@@ -981,7 +981,7 @@ static void ppc405_ocm_init(CPUPPCState *env)
 {
     ppc405_ocm_t *ocm;
 
-    ocm = g_malloc0(sizeof(ppc405_ocm_t));
+    ocm = g_new0(ppc405_ocm_t, 1);
     /* XXX: Size is 4096 or 0x04000000 */
     memory_region_init_ram(&ocm->isarc_ram, NULL, "ppc405.ocm", 4096,
                            &error_fatal);
@@ -1264,7 +1264,7 @@ static void ppc4xx_gpt_init(hwaddr base, qemu_irq irqs[5])
     ppc4xx_gpt_t *gpt;
     int i;
 
-    gpt = g_malloc0(sizeof(ppc4xx_gpt_t));
+    gpt = g_new0(ppc4xx_gpt_t, 1);
     for (i = 0; i < 5; i++) {
         gpt->irqs[i] = irqs[i];
     }
@@ -1590,7 +1590,7 @@ static void ppc405cr_cpc_init (CPUPPCState *env, clk_setup_t clk_setup[7],
 {
     ppc405cr_cpc_t *cpc;
 
-    cpc = g_malloc0(sizeof(ppc405cr_cpc_t));
+    cpc = g_new0(ppc405cr_cpc_t, 1);
     memcpy(cpc->clk_setup, clk_setup,
            PPC405CR_CLK_NB * sizeof(clk_setup_t));
     cpc->sysclk = sysclk;
@@ -1640,7 +1640,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
     /* OBP arbitrer */
     ppc4xx_opba_init(0xef600600);
     /* Universal interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =
@@ -1934,7 +1934,7 @@ static void ppc405ep_cpc_init (CPUPPCState *env, clk_setup_t clk_setup[8],
 {
     ppc405ep_cpc_t *cpc;
 
-    cpc = g_malloc0(sizeof(ppc405ep_cpc_t));
+    cpc = g_new0(ppc405ep_cpc_t, 1);
     memcpy(cpc->clk_setup, clk_setup,
            PPC405EP_CLK_NB * sizeof(clk_setup_t));
     cpc->jtagid = 0x20267049;
@@ -1997,7 +1997,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     /* Initialize timers */
     ppc_booke_timers_init(cpu, sysclk, 0);
     /* Universal interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] =
         ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] =
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index f92d47f28d..f55071abaf 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -200,7 +200,7 @@ static void bamboo_init(MachineState *machine)
     ppc_dcr_init(env, NULL, NULL);
 
     /* interrupt controller */
-    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
+    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
     irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
     irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
     pic = ppcuic_init(env, irqs, 0x0C0, 0, 1);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 6d7f7857fe..a5ea8f8a63 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -300,7 +300,7 @@ qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
     ppcuic_t *uic;
     int i;
 
-    uic = g_malloc0(sizeof(ppcuic_t));
+    uic = g_new0(ppcuic_t, 1);
     uic->dcr_base = dcr_base;
     uic->irqs = irqs;
     if (has_vr)
@@ -648,7 +648,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
 {
     ppc4xx_sdram_t *sdram;
 
-    sdram = g_malloc0(sizeof(ppc4xx_sdram_t));
+    sdram = g_new0(ppc4xx_sdram_t, 1);
     sdram->irq = irq;
     sdram->nbanks = nbanks;
     sdram->ram_memories = ram_memories;
@@ -911,7 +911,7 @@ void ppc4xx_mal_init(CPUPPCState *env, uint8_t txcnum, uint8_t rxcnum,
     int i;
 
     assert(txcnum <= 32 && rxcnum <= 32);
-    mal = g_malloc0(sizeof(*mal));
+    mal = g_new0(ppc4xx_mal_t, 1);
     mal->txcnum = txcnum;
     mal->rxcnum = rxcnum;
     mal->txctpr = g_new0(uint32_t, txcnum);
-- 
2.14.2
