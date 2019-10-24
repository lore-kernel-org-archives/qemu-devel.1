Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61791CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AECD205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqpXAxEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AECD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeNx-00079A-ST
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiw-0007mu-1C
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdit-0007is-GZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdir-0007hO-PM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id v3so2078072wmh.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Asy+EBJ1/DDN/7vzodpurF+OtN2EzDDhF7AXA5N1ZU=;
 b=KqpXAxEm7FMlXeqQ7esGju6LSVeHa78VE6YIJ9h/PEo7gXgObC/LtqALuVCTCeVkvl
 lApQF5n1W2mCQXm7L6kAS3zqxFONRQtuLlJFm9MB6/06Xog8hGRwlpDav6vkWRsBORlY
 hkPUP90YiIh+ikvdVcSGBDantabrAsk1eWhKJa9Ap+vni6cgjbxC+OCxcAz40n4PviNc
 pDXSflpoJyu2CZPjJUiGb3UCPj/XkfecAfckq/agJYCnyaMU3nT0dUwMXX7m4/oySU9k
 IbDaQpoKGz0tcVTO+x9NrJTq+pUT78scSyGWkmYh1w/9Bn/QpKAb+9ynet2B/xfPV/K6
 wXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9Asy+EBJ1/DDN/7vzodpurF+OtN2EzDDhF7AXA5N1ZU=;
 b=V03N/kuFxPQA1ijxoFhJN3H0gad7B5cSEM8TBlSSnsjc8TI/TaTixd/LONEaQBi43T
 nQrAy1w3wVeI2WRQzbB0ktAc05RtNbFEv7EkvbiBSyTR5DSe4hHais0MFTOqzgDl2lzd
 tFcn90OWw3RTwSfrFKWsavlWV7h+SBL1PD8rNGxVOoPZFac2wvAMcWIMnTO0I95WxDLK
 K80Raqy96EswKwNGlEWmVvaUgt7izEfPe6JfIdD1CVrFqVpRumzjR4CjY3MIfDYHD63v
 afUtR7wGkNB8xycknhItGhvyZLt4is6HpqZqbb7C6aaRYStnqUwXBotD7dJZsnryfka3
 bTVA==
X-Gm-Message-State: APjAAAX61NHHcuQN0wkfw2UFIeTyIwxd+E/KEfkvCD3GEw+U2vhznHRd
 ycUytgBBn+wny1IfUgJLLC+77C6j
X-Google-Smtp-Source: APXvYqyFZy3ZxxlDbhW5MvHqmghTkfOvqVwAxSEWgrV3L/n7+wFYQaS1JZKugaI7qCyWP6HRWBFz7g==
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr4817182wme.71.1571925854459; 
 Thu, 24 Oct 2019 07:04:14 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/39] hw/i386: make x86.c independent from PCMachineState
Date: Thu, 24 Oct 2019 16:03:31 +0200
Message-Id: <1571925835-31930-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

As a last step into splitting PCMachineState and deriving
X86MachineState from it, make the functions previously extracted from
pc.c to x86.c independent from PCMachineState, using X86MachineState
instead.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c          | 14 +++++++++-----
 hw/i386/pc_piix.c     |  2 +-
 hw/i386/pc_q35.c      |  2 +-
 hw/i386/x86.c         | 53 +++++++++++++++++++++++----------------------------
 include/hw/i386/x86.h | 13 +++++++++----
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e6ad1f1..a8888dd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -983,8 +983,8 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(ms);
-    int64_t apic_id = x86_cpu_apic_id_from_index(pcms, id);
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    int64_t apic_id = x86_cpu_apic_id_from_index(x86ms, id);
     Error *local_err = NULL;
 
     if (id < 0) {
@@ -999,7 +999,8 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
         return;
     }
 
-    x86_cpu_new(PC_MACHINE(ms), apic_id, &local_err);
+
+    x86_cpu_new(X86_MACHINE(ms), apic_id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -1100,6 +1101,7 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
@@ -1108,7 +1110,8 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(pcms, fw_cfg);
+    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
+                   pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -1244,7 +1247,8 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(pcms, fw_cfg);
+        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
+                       pcmc->pvh_enabled, pcmc->linuxboot_dma_enabled);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0afa8fe..a86317c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -154,7 +154,7 @@ static void pc_init1(MachineState *machine,
         }
     }
 
-    x86_cpus_init(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     if (kvm_enabled() && pcmc->kvmclock_enabled) {
         kvmclock_create();
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 374ac6c..75c8caf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -181,7 +181,7 @@ static void pc_q35_init(MachineState *machine)
         xen_hvm_init(pcms, &ram_memory);
     }
 
-    x86_cpus_init(pcms);
+    x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     kvmclock_create();
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index de4fed0..fd84b23 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -36,7 +36,6 @@
 #include "sysemu/sysemu.h"
 
 #include "hw/i386/x86.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
@@ -61,11 +60,10 @@ static size_t pvh_start_addr;
  * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
  * all CPUs up to max_cpus.
  */
-uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index)
 {
-    MachineState *ms = MACHINE(pcms);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    MachineState *ms = MACHINE(x86ms);
     X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     uint32_t correct_id;
     static bool warned;
@@ -84,14 +82,14 @@ uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
     }
 }
 
-void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
+
+void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
     Object *cpu = NULL;
     Error *local_err = NULL;
     CPUX86State *env = NULL;
-    X86MachineState *x86ms = X86_MACHINE(pcms);
 
-    cpu = object_new(MACHINE(pcms)->cpu_type);
+    cpu = object_new(MACHINE(x86ms)->cpu_type);
 
     env = &X86_CPU(cpu)->env;
     env->nr_dies = x86ms->smp_dies;
@@ -103,30 +101,28 @@ void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
     error_propagate(errp, local_err);
 }
 
-void x86_cpus_init(PCMachineState *pcms)
+void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
 {
     int i;
     const CPUArchIdList *possible_cpus;
-    MachineState *ms = MACHINE(pcms);
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    MachineState *ms = MACHINE(x86ms);
+    MachineClass *mc = MACHINE_GET_CLASS(x86ms);
 
-    x86_cpu_set_default_version(pcmc->default_cpu_version);
+    x86_cpu_set_default_version(default_cpu_version);
 
     /*
      * Calculates the limit to CPU APIC ID values
      *
      * Limit for the APIC ID value, so that all
-     * CPU APIC IDs are < pcms->apic_id_limit.
+     * CPU APIC IDs are < x86ms->apic_id_limit.
      *
      * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
      */
-    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
+    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
                                                       ms->smp.max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(ms);
     for (i = 0; i < ms->smp.cpus; i++) {
-        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+        x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -154,7 +150,6 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
 
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
 {
-    PCMachineState *pcms = PC_MACHINE(ms);
     X86MachineState *x86ms = X86_MACHINE(ms);
     int i;
     unsigned int max_cpus = ms->smp.max_cpus;
@@ -177,7 +172,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
         ms->possible_cpus->cpus[i].type = ms->cpu_type;
         ms->possible_cpus->cpus[i].vcpus_count = 1;
         ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(pcms, i);
+            x86_cpu_apic_id_from_index(x86ms, i);
         x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
                                  x86ms->smp_dies, ms->smp.cores,
                                  ms->smp.threads, &topo);
@@ -335,8 +330,11 @@ static bool load_elfboot(const char *kernel_filename,
     return true;
 }
 
-void x86_load_linux(PCMachineState *pcms,
-                    FWCfgState *fw_cfg)
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled,
+                    bool linuxboot_dma_enabled)
 {
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
@@ -346,9 +344,7 @@ void x86_load_linux(PCMachineState *pcms,
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
     FILE *f;
     char *vmode;
-    MachineState *machine = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    X86MachineState *x86ms = X86_MACHINE(pcms);
+    MachineState *machine = MACHINE(x86ms);
     struct setup_data *setup_data;
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
@@ -395,7 +391,7 @@ void x86_load_linux(PCMachineState *pcms,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (pcmc->pvh_enabled &&
+        if (pvh_enabled &&
             load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
@@ -425,8 +421,7 @@ void x86_load_linux(PCMachineState *pcms,
 
                 initrd_data = g_mapped_file_get_contents(mapped_file);
                 initrd_size = g_mapped_file_get_length(mapped_file);
-                initrd_max =
-                    x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+                initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
                 if (initrd_size >= initrd_max) {
                     fprintf(stderr, "qemu: initrd is too large, cannot support."
                             "(max: %"PRIu32", need %"PRId64")\n",
@@ -494,8 +489,8 @@ void x86_load_linux(PCMachineState *pcms,
         initrd_max = 0x37ffffff;
     }
 
-    if (initrd_max >= x86ms->below_4g_mem_size - pcmc->acpi_data_size) {
-        initrd_max = x86ms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+    if (initrd_max >= x86ms->below_4g_mem_size - acpi_data_size) {
+        initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
     }
 
     fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
@@ -652,7 +647,7 @@ void x86_load_linux(PCMachineState *pcms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d15713e..82d09fd 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -75,10 +75,11 @@ typedef struct {
 #define X86_MACHINE_CLASS(class) \
     OBJECT_CLASS_CHECK(X86MachineClass, class, TYPE_X86_MACHINE)
 
-uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
                                     unsigned int cpu_index);
-void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp);
-void x86_cpus_init(PCMachineState *pcms);
+
+void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error **errp);
+void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
 CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
                                              unsigned cpu_index);
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
@@ -86,6 +87,10 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
 
 void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
 
-void x86_load_linux(PCMachineState *pcms, FWCfgState *fw_cfg);
+void x86_load_linux(X86MachineState *x86ms,
+                    FWCfgState *fw_cfg,
+                    int acpi_data_size,
+                    bool pvh_enabled,
+                    bool linuxboot_dma_enabled);
 
 #endif
-- 
1.8.3.1



