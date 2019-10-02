Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3D6C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F9720679
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F9720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcvO-0005WN-Ug
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFcrG-00018H-KZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFcrE-00009A-70
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39278)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFcrD-000086-VW
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C12138AC6F5;
 Wed,  2 Oct 2019 11:31:46 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C449360605;
 Wed,  2 Oct 2019 11:31:29 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/10] hw/i386/pc: rename functions shared with non-PC
 machines
Date: Wed,  2 Oct 2019 13:30:55 +0200
Message-Id: <20191002113103.45023-3-slp@redhat.com>
In-Reply-To: <20191002113103.45023-1-slp@redhat.com>
References: <20191002113103.45023-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 02 Oct 2019 11:31:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

load_linux                 -> x86_load_linux
pc_new_cpu                 -> x86_new_cpu
pc_cpus_init               -> x86_cpus_init
pc_cpu_index_to_props      -> x86_cpu_index_to_props
pc_get_default_cpu_node_id -> x86_get_default_cpu_node_id
pc_possible_cpu_arch_ids   -> x86_possible_cpu_arch_ids
old_pc_system_rom_init     -> x86_system_rom_init

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/i386/pc.c         | 28 ++++++++++++++--------------
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 hw/i386/pc_sysfw.c   |  6 +++---
 include/hw/i386/pc.h |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bcda50efcc..029bc23e7c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1019,8 +1019,8 @@ static bool load_elfboot(const char *kernel_filenam=
e,
     return true;
 }
=20
-static void load_linux(PCMachineState *pcms,
-                       FWCfgState *fw_cfg)
+static void x86_load_linux(PCMachineState *pcms,
+                           FWCfgState *fw_cfg)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
@@ -1374,7 +1374,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, i=
nt level)
     }
 }
=20
-static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **er=
rp)
+static void x86_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **e=
rrp)
 {
     Object *cpu =3D NULL;
     Error *local_err =3D NULL;
@@ -1490,14 +1490,14 @@ void pc_hot_add_cpu(MachineState *ms, const int64=
_t id, Error **errp)
         return;
     }
=20
-    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
+    x86_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 }
=20
-void pc_cpus_init(PCMachineState *pcms)
+void x86_cpus_init(PCMachineState *pcms)
 {
     int i;
     const CPUArchIdList *possible_cpus;
@@ -1518,7 +1518,7 @@ void pc_cpus_init(PCMachineState *pcms)
                                                      ms->smp.max_cpus - =
1) + 1;
     possible_cpus =3D mc->possible_cpu_arch_ids(ms);
     for (i =3D 0; i < ms->smp.cpus; i++) {
-        pc_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+        x86_new_cpu(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
=20
@@ -1621,7 +1621,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     rom_set_fw(fw_cfg);
=20
-    load_linux(pcms, fw_cfg);
+    x86_load_linux(pcms, fw_cfg);
     for (i =3D 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -1756,7 +1756,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
=20
     if (linux_boot) {
-        load_linux(pcms, fw_cfg);
+        x86_load_linux(pcms, fw_cfg);
     }
=20
     for (i =3D 0; i < nb_option_roms; i++) {
@@ -2678,7 +2678,7 @@ static void pc_machine_wakeup(MachineState *machine=
)
 }
=20
 static CpuInstanceProperties
-pc_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
     const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(ms)=
;
@@ -2687,7 +2687,7 @@ pc_cpu_index_to_props(MachineState *ms, unsigned cp=
u_index)
     return possible_cpus->cpus[cpu_index].props;
 }
=20
-static int64_t pc_get_default_cpu_node_id(const MachineState *ms, int id=
x)
+static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int i=
dx)
 {
    X86CPUTopoInfo topo;
    PCMachineState *pcms =3D PC_MACHINE(ms);
@@ -2699,7 +2699,7 @@ static int64_t pc_get_default_cpu_node_id(const Mac=
hineState *ms, int idx)
    return topo.pkg_id % ms->numa_state->num_nodes;
 }
=20
-static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
+static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
     PCMachineState *pcms =3D PC_MACHINE(ms);
     int i;
@@ -2801,9 +2801,9 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotplug_handler;
     mc->hotplug_allowed =3D pc_hotplug_allowed;
-    mc->cpu_index_to_instance_props =3D pc_cpu_index_to_props;
-    mc->get_default_cpu_node_id =3D pc_get_default_cpu_node_id;
-    mc->possible_cpu_arch_ids =3D pc_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props =3D x86_cpu_index_to_props;
+    mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
+    mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
     mc->auto_enable_numa_with_memhp =3D true;
     mc->has_hotpluggable_cpus =3D true;
     mc->default_boot_order =3D "cad";
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6824b72124..de09e076cd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -152,7 +152,7 @@ static void pc_init1(MachineState *machine,
         }
     }
=20
-    pc_cpus_init(pcms);
+    x86_cpus_init(pcms);
=20
     if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f314..894989b64e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -179,7 +179,7 @@ static void pc_q35_init(MachineState *machine)
         xen_hvm_init(pcms, &ram_memory);
     }
=20
-    pc_cpus_init(pcms);
+    x86_cpus_init(pcms);
=20
     kvmclock_create();
=20
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index a9983f0bfb..1ee254b15e 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -211,7 +211,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
     }
 }
=20
-static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_=
ram_fw)
+static void x86_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram=
_fw)
 {
     char *filename;
     MemoryRegion *bios, *isa_bios;
@@ -272,7 +272,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
=20
     if (!pcmc->pci_enabled) {
-        old_pc_system_rom_init(rom_memory, true);
+        x86_system_rom_init(rom_memory, true);
         return;
     }
=20
@@ -293,7 +293,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
=20
     if (!pflash_blk[0]) {
         /* Machine property pflash0 not set, use ROM mode */
-        old_pc_system_rom_init(rom_memory, false);
+        x86_system_rom_init(rom_memory, false);
     } else {
         if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
             /*
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6df4f4b6fb..d12f42e9e5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -195,7 +195,7 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcms);
 void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
=20
-void pc_cpus_init(PCMachineState *pcms);
+void x86_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
 void pc_smp_parse(MachineState *ms, QemuOpts *opts);
=20
--=20
2.21.0


