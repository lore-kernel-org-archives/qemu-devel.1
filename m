Received: from eggs.gnu.org ([2001:4830:134:3::10]:54270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jm-0003uf-9H
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6jk-0003cc-QC
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:10 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6jk-0003cG-I7
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:37:08 -0400
Received: by mail-pf0-x242.google.com with SMTP id e9so16092818pfi.4
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:37:08 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:10 +1200
Message-Id: <1525563325-62963-6-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/20] RISC-V: Remove unused class definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

Removes a whole lot of unnecessary boilerplate code. Machines
don't need to be objects. The expansion of the SOC object model
for the RISC-V machines will happen in the future as SiFive
plans to add their FE310 and FU540 SOCs to QEMU. However, it
seems that this present boilerplate is complete unnecessary.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv_hart.c       |  6 ------
 hw/riscv/sifive_e.c         | 25 -------------------------
 hw/riscv/sifive_u.c         | 25 -------------------------
 hw/riscv/spike.c            | 20 --------------------
 hw/riscv/virt.c             | 25 -------------------------
 include/hw/riscv/sifive_e.h |  5 -----
 include/hw/riscv/sifive_u.h |  5 -----
 include/hw/riscv/spike.h    |  7 -------
 include/hw/riscv/virt.h     |  5 -----
 9 files changed, 123 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 14e3c186fea7..75ba7ed579bd 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -68,16 +68,10 @@ static void riscv_harts_class_init(ObjectClass *klass, void *data)
     dc->realize = riscv_harts_realize;
 }
 
-static void riscv_harts_init(Object *obj)
-{
-    /* RISCVHartArrayState *s = SIFIVE_COREPLEX(obj); */
-}
-
 static const TypeInfo riscv_harts_info = {
     .name          = TYPE_RISCV_HART_ARRAY,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RISCVHartArrayState),
-    .instance_init = riscv_harts_init,
     .class_init    = riscv_harts_class_init,
 };
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 3e523a073469..22dc526713c2 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -194,24 +194,6 @@ static void riscv_sifive_e_init(MachineState *machine)
     }
 }
 
-static int riscv_sifive_e_sysbus_device_init(SysBusDevice *sysbusdev)
-{
-    return 0;
-}
-
-static void riscv_sifive_e_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-    k->init = riscv_sifive_e_sysbus_device_init;
-}
-
-static const TypeInfo riscv_sifive_e_device = {
-    .name          = TYPE_SIFIVE_E,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SiFiveEState),
-    .class_init    = riscv_sifive_e_class_init,
-};
-
 static void riscv_sifive_e_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
@@ -220,10 +202,3 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-
-static void riscv_sifive_e_register_types(void)
-{
-    type_register_static(&riscv_sifive_e_device);
-}
-
-type_init(riscv_sifive_e_register_types);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index adc6c2266275..5bb495ab9a6c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -301,31 +301,6 @@ static void riscv_sifive_u_init(MachineState *machine)
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
 }
 
-static int riscv_sifive_u_sysbus_device_init(SysBusDevice *sysbusdev)
-{
-    return 0;
-}
-
-static void riscv_sifive_u_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-    k->init = riscv_sifive_u_sysbus_device_init;
-}
-
-static const TypeInfo riscv_sifive_u_device = {
-    .name          = TYPE_SIFIVE_U,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SiFiveUState),
-    .class_init    = riscv_sifive_u_class_init,
-};
-
-static void riscv_sifive_u_register_types(void)
-{
-    type_register_static(&riscv_sifive_u_device);
-}
-
-type_init(riscv_sifive_u_register_types);
-
 static void riscv_sifive_u_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with SiFive U SDK";
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index cf7f9bcc3950..44eab94e17ef 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -334,18 +334,6 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
 }
 
-static const TypeInfo spike_v_1_09_1_device = {
-    .name          = TYPE_RISCV_SPIKE_V1_09_1_BOARD,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SpikeState),
-};
-
-static const TypeInfo spike_v_1_10_0_device = {
-    .name          = TYPE_RISCV_SPIKE_V1_10_0_BOARD,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SpikeState),
-};
-
 static void spike_v1_09_1_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board (Privileged ISA v1.9.1)";
@@ -363,11 +351,3 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
 DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
-
-static void riscv_spike_board_register_types(void)
-{
-    type_register_static(&spike_v_1_09_1_device);
-    type_register_static(&spike_v_1_10_0_device);
-}
-
-type_init(riscv_spike_board_register_types);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c2aa795981d2..88b9ad509315 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -382,24 +382,6 @@ static void riscv_virt_board_init(MachineState *machine)
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 }
 
-static int riscv_virt_board_sysbus_device_init(SysBusDevice *sysbusdev)
-{
-    return 0;
-}
-
-static void riscv_virt_board_class_init(ObjectClass *klass, void *data)
-{
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
-    k->init = riscv_virt_board_sysbus_device_init;
-}
-
-static const TypeInfo riscv_virt_board_device = {
-    .name          = TYPE_RISCV_VIRT_BOARD,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(RISCVVirtState),
-    .class_init    = riscv_virt_board_class_init,
-};
-
 static void riscv_virt_board_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
@@ -408,10 +390,3 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
-
-static void riscv_virt_board_register_types(void)
-{
-    type_register_static(&riscv_virt_board_device);
-}
-
-type_init(riscv_virt_board_register_types);
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 0aebc576c1d5..12ad6d2ebb2b 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,11 +19,6 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
-#define TYPE_SIFIVE_E "riscv.sifive_e"
-
-#define SIFIVE_E(obj) \
-    OBJECT_CHECK(SiFiveEState, (obj), TYPE_SIFIVE_E)
-
 typedef struct SiFiveEState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index be38aa09da20..94a390566e59 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,11 +19,6 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
-#define TYPE_SIFIVE_U "riscv.sifive_u"
-
-#define SIFIVE_U(obj) \
-    OBJECT_CHECK(SiFiveUState, (obj), TYPE_SIFIVE_U)
-
 typedef struct SiFiveUState {
     /*< private >*/
     SysBusDevice parent_obj;
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index d85a64e33d86..8410430614b7 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -19,12 +19,6 @@
 #ifndef HW_SPIKE_H
 #define HW_SPIKE_H
 
-#define TYPE_RISCV_SPIKE_V1_09_1_BOARD "riscv.spike_v1_9_1"
-#define TYPE_RISCV_SPIKE_V1_10_0_BOARD "riscv.spike_v1_10"
-
-#define SPIKE(obj) \
-    OBJECT_CHECK(SpikeState, (obj), TYPE_RISCV_SPIKE_BOARD)
-
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -35,7 +29,6 @@ typedef struct {
     int fdt_size;
 } SpikeState;
 
-
 enum {
     SPIKE_MROM,
     SPIKE_CLINT,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 655e85ddbd3c..b91a4125dd61 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -19,10 +19,6 @@
 #ifndef HW_VIRT_H
 #define HW_VIRT_H
 
-#define TYPE_RISCV_VIRT_BOARD "riscv.virt"
-#define VIRT(obj) \
-    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
-
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -45,7 +41,6 @@ enum {
     VIRT_DRAM
 };
 
-
 enum {
     UART0_IRQ = 10,
     VIRTIO_IRQ = 1, /* 1 to 8 */
-- 
2.7.0
