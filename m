Received: from eggs.gnu.org ([2001:4830:134:3::10]:53288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJer-0000Ga-S5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etJen-0002kK-V5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:58:01 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etJen-0002kC-Nn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:57:57 -0500
Received: by mail-pg0-x242.google.com with SMTP id e3so3826pga.6
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 12:57:57 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  7 Mar 2018 09:56:15 +1300
Message-Id: <1520369790-38306-6-git-send-email-mjc@sifive.com>
In-Reply-To: <1520369790-38306-1-git-send-email-mjc@sifive.com>
References: <1520369790-38306-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v1 07/22] RISC-V: Remove unused class
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

Removes a whole lot of unnecessary boilerplate code. Machines
don't need to be objects. The expansion of the SOC object model
for the RISC-V machines will happen in the future as SiFive
plans to add their FE310 and FU540 SOCs to QEMU. However, it
seems that this present boilerplate is complete unnecessary.

Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_e.c         | 25 -------------------------
 hw/riscv/sifive_u.c         | 25 -------------------------
 hw/riscv/spike.c            | 20 --------------------
 hw/riscv/virt.c             | 25 -------------------------
 include/hw/riscv/sifive_e.h |  9 ---------
 include/hw/riscv/sifive_u.h |  9 ---------
 include/hw/riscv/virt.h     |  9 ---------
 7 files changed, 122 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 09c9d49..4872b68 100644
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
index 25df16c..083043a 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -302,31 +302,6 @@ static void riscv_sifive_u_init(MachineState *machine)
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
index 74edf33..64e585e 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -336,18 +336,6 @@ static void spike_v1_09_1_board_init(MachineState *machine)
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
@@ -365,11 +353,3 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
 
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
index f1e3641..5913100 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -380,24 +380,6 @@ static void riscv_virt_board_init(MachineState *machine)
         serial_hds[0], DEVICE_LITTLE_ENDIAN);
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
@@ -406,10 +388,3 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
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
index 0aebc57..818fbdc 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,16 +19,7 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
-#define TYPE_SIFIVE_E "riscv.sifive_e"
-
-#define SIFIVE_E(obj) \
-    OBJECT_CHECK(SiFiveEState, (obj), TYPE_SIFIVE_E)
-
 typedef struct SiFiveEState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
 } SiFiveEState;
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index be38aa0..8ebd545 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,16 +19,7 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
-#define TYPE_SIFIVE_U "riscv.sifive_u"
-
-#define SIFIVE_U(obj) \
-    OBJECT_CHECK(SiFiveUState, (obj), TYPE_SIFIVE_U)
-
 typedef struct SiFiveUState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
     void *fdt;
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 655e85d..9588909 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -19,15 +19,7 @@
 #ifndef HW_VIRT_H
 #define HW_VIRT_H
 
-#define TYPE_RISCV_VIRT_BOARD "riscv.virt"
-#define VIRT(obj) \
-    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
-
 typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
     void *fdt;
@@ -45,7 +37,6 @@ enum {
     VIRT_DRAM
 };
 
-
 enum {
     UART0_IRQ = 10,
     VIRTIO_IRQ = 1, /* 1 to 8 */
-- 
2.7.0
