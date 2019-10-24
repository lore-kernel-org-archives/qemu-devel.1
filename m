Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6719CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6283A2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA5u/6FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6283A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNefa-00037T-Vy
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj1-0007wh-8k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdir-0007hs-Q3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdip-0007h6-L7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:17 -0400
Received: by mail-wr1-x42d.google.com with SMTP id t16so21105381wrr.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4LTyVRPQ+zt580ZSqWNKH9OF4awre/LXCD66B7P5FJc=;
 b=CA5u/6FMpt2nzlRAL1qhXx6Fj7MGM5+kcd4nd3efzXan4s0FYr1PkuZFluNf20umWe
 X49R5JnbYP1YRcUCTugNQ3W/7QG4dewRW6KMGUyKEsZLM6Z29A32A/j+oBmMBPFY64IX
 hVXEtTbpdHtETCCj/Gz8PJ9DCD/ossEtWk+I1T8Xcr+Nd+nb2nGGp8cHMO9ZqMJ8dGRz
 DgwzkTQ0aFA1gtcPavnhwNfhKWRCnQ5WhFdGf47TlKE+6wAyfWkCjWHMk20k8IDCjD7c
 4sG2vKJMwZyfftMnndALbNddzBZvsYR9/Af4QxFZ3D36BDmuS05T0yt0sEp5SECLHZrX
 lDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4LTyVRPQ+zt580ZSqWNKH9OF4awre/LXCD66B7P5FJc=;
 b=DNl9vNo/tE5YHfX0bFHAXtuVx8EpYIZrIddpPji1yTF4CbR2LnkQrlZxV4u9/8X2+V
 717b7yBka/ZPuFOR/rCn934/UPEEG85AuZd58Z0GhaPe6FPzDWRgau36X0sGoZN7VdMr
 2FbSi6e8ZadQx5dAVO7Y7YPeqE953Jzw86wixEyDV1jvLcmdc96bNg14ccpc9DT77KzN
 d3BbnLa+bTlQjsW7BBo8ysJ+VqP7AW3RfvyxzT5P2LGr/lgCroc7kHKMqb4UKHUBTFS3
 Ta9GTqD1SZcqyyN38bai6MX9Iw7L4TUHy898g27LyikpOBaDrhfEPOfWyBDIQdJc5YVU
 ol9g==
X-Gm-Message-State: APjAAAWGxwdwzeGO+YYPOXJgpQzTxzLHuUp7mi70c3UMbzA+6O/zW+u7
 xJtOpXU30KJNXSMSeTbITrB5qpP2
X-Google-Smtp-Source: APXvYqyCwYt1b1ZzeSE9HXBwLwhniXh4L1NhNlAEzvn6AAADd01PNrd9R18Q2RC4h29zfDGGunsc/A==
X-Received: by 2002:adf:a48c:: with SMTP id g12mr3828171wrb.212.1571925852793; 
 Thu, 24 Oct 2019 07:04:12 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/39] hw/i386/pc: move shared x86 functions to x86.c and
 export them
Date: Thu, 24 Oct 2019 16:03:29 +0200
Message-Id: <1571925835-31930-14-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Move x86 functions that will be shared between PC and non-PC machine
types to x86.c, along with their helpers.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/Makefile.objs |   1 +
 hw/i386/pc.c          | 587 +-----------------------------------------
 hw/i386/pc_piix.c     |   1 +
 hw/i386/pc_q35.c      |   1 +
 hw/i386/pc_sysfw.c    |  56 +---
 hw/i386/x86.c         | 690 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h  |   1 -
 include/hw/i386/x86.h |  35 +++
 8 files changed, 730 insertions(+), 642 deletions(-)
 create mode 100644 hw/i386/x86.c
 create mode 100644 include/hw/i386/x86.h

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index d3374e0..7ed80a4 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_KVM) += kvm/
 obj-y += e820_memory_layout.o multiboot.o
+obj-y += x86.o
 obj-y += pc.o
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 903bc05..4a1bc95 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/char/parallel.h"
@@ -103,9 +104,6 @@
 
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
-/* Physical Address of PVH entry point read from kernel ELF NOTE */
-static size_t pvh_start_addr;
-
 GlobalProperty pc_compat_4_1[] = {};
 const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 
@@ -867,481 +865,6 @@ static void handle_a20_line_change(void *opaque, int irq, int level)
     x86_cpu_set_a20(cpu, level);
 }
 
-/*
- * Calculates initial APIC ID for a specific CPU index
- *
- * Currently we need to be able to calculate the APIC ID from the CPU index
- * alone (without requiring a CPU object), as the QEMU<->Seabios interfaces have
- * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
- * all CPUs up to max_cpus.
- */
-static uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
-                                           unsigned int cpu_index)
-{
-    MachineState *ms = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    uint32_t correct_id;
-    static bool warned;
-
-    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
-                                         ms->smp.threads, cpu_index);
-    if (pcmc->compat_apic_id_mode) {
-        if (cpu_index != correct_id && !warned && !qtest_enabled()) {
-            error_report("APIC IDs set in compatibility mode, "
-                         "CPU topology won't match the configuration");
-            warned = true;
-        }
-        return cpu_index;
-    } else {
-        return correct_id;
-    }
-}
-
-static long get_file_size(FILE *f)
-{
-    long where, size;
-
-    /* XXX: on Unix systems, using fstat() probably makes more sense */
-
-    where = ftell(f);
-    fseek(f, 0, SEEK_END);
-    size = ftell(f);
-    fseek(f, where, SEEK_SET);
-
-    return size;
-}
-
-struct setup_data {
-    uint64_t next;
-    uint32_t type;
-    uint32_t len;
-    uint8_t data[0];
-} __attribute__((packed));
-
-
-/*
- * The entry point into the kernel for PVH boot is different from
- * the native entry point.  The PVH entry is defined by the x86/HVM
- * direct boot ABI and is available in an ELFNOTE in the kernel binary.
- *
- * This function is passed to load_elf() when it is called from
- * load_elfboot() which then additionally checks for an ELF Note of
- * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
- * parse the PVH entry address from the ELF Note.
- *
- * Due to trickery in elf_opts.h, load_elf() is actually available as
- * load_elf32() or load_elf64() and this routine needs to be able
- * to deal with being called as 32 or 64 bit.
- *
- * The address of the PVH entry point is saved to the 'pvh_start_addr'
- * global variable.  (although the entry point is 32-bit, the kernel
- * binary can be either 32-bit or 64-bit).
- */
-static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
-{
-    size_t *elf_note_data_addr;
-
-    /* Check if ELF Note header passed in is valid */
-    if (arg1 == NULL) {
-        return 0;
-    }
-
-    if (is64) {
-        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
-        uint64_t nhdr_size64 = sizeof(struct elf64_note);
-        uint64_t phdr_align = *(uint64_t *)arg2;
-        uint64_t nhdr_namesz = nhdr64->n_namesz;
-
-        elf_note_data_addr =
-            ((void *)nhdr64) + nhdr_size64 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-    } else {
-        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
-        uint32_t nhdr_size32 = sizeof(struct elf32_note);
-        uint32_t phdr_align = *(uint32_t *)arg2;
-        uint32_t nhdr_namesz = nhdr32->n_namesz;
-
-        elf_note_data_addr =
-            ((void *)nhdr32) + nhdr_size32 +
-            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-    }
-
-    pvh_start_addr = *elf_note_data_addr;
-
-    return pvh_start_addr;
-}
-
-static bool load_elfboot(const char *kernel_filename,
-                   int kernel_file_size,
-                   uint8_t *header,
-                   size_t pvh_xen_start_addr,
-                   FWCfgState *fw_cfg)
-{
-    uint32_t flags = 0;
-    uint32_t mh_load_addr = 0;
-    uint32_t elf_kernel_size = 0;
-    uint64_t elf_entry;
-    uint64_t elf_low, elf_high;
-    int kernel_size;
-
-    if (ldl_p(header) != 0x464c457f) {
-        return false; /* no elfboot */
-    }
-
-    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
-    flags = elf_is64 ?
-        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
-
-    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
-        error_report("elfboot unsupported flags = %x", flags);
-        exit(1);
-    }
-
-    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
-    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
-                           NULL, &elf_note_type, &elf_entry,
-                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
-                           0, 0);
-
-    if (kernel_size < 0) {
-        error_report("Error while loading elf kernel");
-        exit(1);
-    }
-    mh_load_addr = elf_low;
-    elf_kernel_size = elf_high - elf_low;
-
-    if (pvh_start_addr == 0) {
-        error_report("Error loading uncompressed kernel without PVH ELF Note");
-        exit(1);
-    }
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
-
-    return true;
-}
-
-static void x86_load_linux(PCMachineState *pcms,
-                           FWCfgState *fw_cfg)
-{
-    uint16_t protocol;
-    int setup_size, kernel_size, cmdline_size;
-    int dtb_size, setup_data_offset;
-    uint32_t initrd_max;
-    uint8_t header[8192], *setup, *kernel;
-    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
-    FILE *f;
-    char *vmode;
-    MachineState *machine = MACHINE(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-    struct setup_data *setup_data;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *initrd_filename = machine->initrd_filename;
-    const char *dtb_filename = machine->dtb;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-
-    /* Align to 16 bytes as a paranoia measure */
-    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
-
-    /* load the kernel header */
-    f = fopen(kernel_filename, "rb");
-    if (!f) {
-        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
-                kernel_filename, strerror(errno));
-        exit(1);
-    }
-
-    kernel_size = get_file_size(f);
-    if (!kernel_size ||
-        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
-        MIN(ARRAY_SIZE(header), kernel_size)) {
-        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
-                kernel_filename, strerror(errno));
-        exit(1);
-    }
-
-    /* kernel protocol version */
-    if (ldl_p(header + 0x202) == 0x53726448) {
-        protocol = lduw_p(header + 0x206);
-    } else {
-        /*
-         * This could be a multiboot kernel. If it is, let's stop treating it
-         * like a Linux kernel.
-         * Note: some multiboot images could be in the ELF format (the same of
-         * PVH), so we try multiboot first since we check the multiboot magic
-         * header before to load it.
-         */
-        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
-                           kernel_cmdline, kernel_size, header)) {
-            return;
-        }
-        /*
-         * Check if the file is an uncompressed kernel file (ELF) and load it,
-         * saving the PVH entry point used by the x86/HVM direct boot ABI.
-         * If load_elfboot() is successful, populate the fw_cfg info.
-         */
-        if (pcmc->pvh_enabled &&
-            load_elfboot(kernel_filename, kernel_size,
-                         header, pvh_start_addr, fw_cfg)) {
-            fclose(f);
-
-            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
-                strlen(kernel_cmdline) + 1);
-            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
-
-            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
-            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
-                             header, sizeof(header));
-
-            /* load initrd */
-            if (initrd_filename) {
-                GMappedFile *mapped_file;
-                gsize initrd_size;
-                gchar *initrd_data;
-                GError *gerr = NULL;
-
-                mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
-                if (!mapped_file) {
-                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
-                            initrd_filename, gerr->message);
-                    exit(1);
-                }
-                pcms->initrd_mapped_file = mapped_file;
-
-                initrd_data = g_mapped_file_get_contents(mapped_file);
-                initrd_size = g_mapped_file_get_length(mapped_file);
-                initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
-                if (initrd_size >= initrd_max) {
-                    fprintf(stderr, "qemu: initrd is too large, cannot support."
-                            "(max: %"PRIu32", need %"PRId64")\n",
-                            initrd_max, (uint64_t)initrd_size);
-                    exit(1);
-                }
-
-                initrd_addr = (initrd_max - initrd_size) & ~4095;
-
-                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
-                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
-                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
-                                 initrd_size);
-            }
-
-            option_rom[nb_option_roms].bootindex = 0;
-            option_rom[nb_option_roms].name = "pvh.bin";
-            nb_option_roms++;
-
-            return;
-        }
-        protocol = 0;
-    }
-
-    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
-        /* Low kernel */
-        real_addr    = 0x90000;
-        cmdline_addr = 0x9a000 - cmdline_size;
-        prot_addr    = 0x10000;
-    } else if (protocol < 0x202) {
-        /* High but ancient kernel */
-        real_addr    = 0x90000;
-        cmdline_addr = 0x9a000 - cmdline_size;
-        prot_addr    = 0x100000;
-    } else {
-        /* High and recent kernel */
-        real_addr    = 0x10000;
-        cmdline_addr = 0x20000;
-        prot_addr    = 0x100000;
-    }
-
-    /* highest address for loading the initrd */
-    if (protocol >= 0x20c &&
-        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
-        /*
-         * Linux has supported initrd up to 4 GB for a very long time (2007,
-         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
-         * though it only sets initrd_max to 2 GB to "work around bootloader
-         * bugs". Luckily, QEMU firmware(which does something like bootloader)
-         * has supported this.
-         *
-         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
-         * be loaded into any address.
-         *
-         * In addition, initrd_max is uint32_t simply because QEMU doesn't
-         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
-         * field).
-         *
-         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
-         */
-        initrd_max = UINT32_MAX;
-    } else if (protocol >= 0x203) {
-        initrd_max = ldl_p(header + 0x22c);
-    } else {
-        initrd_max = 0x37ffffff;
-    }
-
-    if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
-        initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
-    }
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
-    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
-
-    if (protocol >= 0x202) {
-        stl_p(header + 0x228, cmdline_addr);
-    } else {
-        stw_p(header + 0x20, 0xA33F);
-        stw_p(header + 0x22, cmdline_addr - real_addr);
-    }
-
-    /* handle vga= parameter */
-    vmode = strstr(kernel_cmdline, "vga=");
-    if (vmode) {
-        unsigned int video_mode;
-        int ret;
-        /* skip "vga=" */
-        vmode += 4;
-        if (!strncmp(vmode, "normal", 6)) {
-            video_mode = 0xffff;
-        } else if (!strncmp(vmode, "ext", 3)) {
-            video_mode = 0xfffe;
-        } else if (!strncmp(vmode, "ask", 3)) {
-            video_mode = 0xfffd;
-        } else {
-            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
-            if (ret != 0) {
-                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
-                        strerror(-ret));
-                exit(1);
-            }
-        }
-        stw_p(header + 0x1fa, video_mode);
-    }
-
-    /* loader type */
-    /*
-     * High nybble = B reserved for QEMU; low nybble is revision number.
-     * If this code is substantially changed, you may want to consider
-     * incrementing the revision.
-     */
-    if (protocol >= 0x200) {
-        header[0x210] = 0xB0;
-    }
-    /* heap */
-    if (protocol >= 0x201) {
-        header[0x211] |= 0x80; /* CAN_USE_HEAP */
-        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
-    }
-
-    /* load initrd */
-    if (initrd_filename) {
-        GMappedFile *mapped_file;
-        gsize initrd_size;
-        gchar *initrd_data;
-        GError *gerr = NULL;
-
-        if (protocol < 0x200) {
-            fprintf(stderr, "qemu: linux kernel too old to load a ram disk\n");
-            exit(1);
-        }
-
-        mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
-        if (!mapped_file) {
-            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
-                    initrd_filename, gerr->message);
-            exit(1);
-        }
-        pcms->initrd_mapped_file = mapped_file;
-
-        initrd_data = g_mapped_file_get_contents(mapped_file);
-        initrd_size = g_mapped_file_get_length(mapped_file);
-        if (initrd_size >= initrd_max) {
-            fprintf(stderr, "qemu: initrd is too large, cannot support."
-                    "(max: %"PRIu32", need %"PRId64")\n",
-                    initrd_max, (uint64_t)initrd_size);
-            exit(1);
-        }
-
-        initrd_addr = (initrd_max - initrd_size) & ~4095;
-
-        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
-        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
-        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
-
-        stl_p(header + 0x218, initrd_addr);
-        stl_p(header + 0x21c, initrd_size);
-    }
-
-    /* load kernel and setup */
-    setup_size = header[0x1f1];
-    if (setup_size == 0) {
-        setup_size = 4;
-    }
-    setup_size = (setup_size + 1) * 512;
-    if (setup_size > kernel_size) {
-        fprintf(stderr, "qemu: invalid kernel header\n");
-        exit(1);
-    }
-    kernel_size -= setup_size;
-
-    setup  = g_malloc(setup_size);
-    kernel = g_malloc(kernel_size);
-    fseek(f, 0, SEEK_SET);
-    if (fread(setup, 1, setup_size, f) != setup_size) {
-        fprintf(stderr, "fread() failed\n");
-        exit(1);
-    }
-    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
-        fprintf(stderr, "fread() failed\n");
-        exit(1);
-    }
-    fclose(f);
-
-    /* append dtb to kernel */
-    if (dtb_filename) {
-        if (protocol < 0x209) {
-            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
-            exit(1);
-        }
-
-        dtb_size = get_image_size(dtb_filename);
-        if (dtb_size <= 0) {
-            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
-                    dtb_filename, strerror(errno));
-            exit(1);
-        }
-
-        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
-        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
-        kernel = g_realloc(kernel, kernel_size);
-
-        stq_p(header + 0x250, prot_addr + setup_data_offset);
-
-        setup_data = (struct setup_data *)(kernel + setup_data_offset);
-        setup_data->next = 0;
-        setup_data->type = cpu_to_le32(SETUP_DTB);
-        setup_data->len = cpu_to_le32(dtb_size);
-
-        load_image_size(dtb_filename, setup_data->data, dtb_size);
-    }
-
-    memcpy(setup, header, MIN(sizeof(header), setup_size));
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
-
-    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
-    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
-
-    option_rom[nb_option_roms].bootindex = 0;
-    option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
-        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
-    }
-    nb_option_roms++;
-}
-
 #define NE2000_NB_MAX 6
 
 static const int ne2000_io[NE2000_NB_MAX] = { 0x300, 0x320, 0x340, 0x360,
@@ -1378,24 +901,6 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }
 
-static void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
-{
-    Object *cpu = NULL;
-    Error *local_err = NULL;
-    CPUX86State *env = NULL;
-
-    cpu = object_new(MACHINE(pcms)->cpu_type);
-
-    env = &X86_CPU(cpu)->env;
-    env->nr_dies = pcms->smp_dies;
-
-    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
-    object_property_set_bool(cpu, true, "realized", &local_err);
-
-    object_unref(cpu);
-    error_propagate(errp, local_err);
-}
-
 /*
  * This function is very similar to smp_parse()
  * in hw/core/machine.c but includes CPU die support.
@@ -1501,32 +1006,6 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
     }
 }
 
-void x86_cpus_init(PCMachineState *pcms)
-{
-    int i;
-    const CPUArchIdList *possible_cpus;
-    MachineState *ms = MACHINE(pcms);
-    MachineClass *mc = MACHINE_GET_CLASS(pcms);
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
-
-    x86_cpu_set_default_version(pcmc->default_cpu_version);
-
-    /*
-     * Calculates the limit to CPU APIC ID values
-     *
-     * Limit for the APIC ID value, so that all
-     * CPU APIC IDs are < pcms->apic_id_limit.
-     *
-     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
-     */
-    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
-                                                     ms->smp.max_cpus - 1) + 1;
-    possible_cpus = mc->possible_cpu_arch_ids(ms);
-    for (i = 0; i < ms->smp.cpus; i++) {
-        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
-    }
-}
-
 static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
 {
     if (cpus_count > 0xff) {
@@ -2685,70 +2164,6 @@ static void pc_machine_wakeup(MachineState *machine)
     cpu_synchronize_all_post_reset();
 }
 
-static CpuInstanceProperties
-x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
-
-    assert(cpu_index < possible_cpus->len);
-    return possible_cpus->cpus[cpu_index].props;
-}
-
-static int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
-{
-   X86CPUTopoInfo topo;
-   PCMachineState *pcms = PC_MACHINE(ms);
-
-   assert(idx < ms->possible_cpus->len);
-   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
-                            pcms->smp_dies, ms->smp.cores,
-                            ms->smp.threads, &topo);
-   return topo.pkg_id % ms->numa_state->num_nodes;
-}
-
-static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
-{
-    PCMachineState *pcms = PC_MACHINE(ms);
-    int i;
-    unsigned int max_cpus = ms->smp.max_cpus;
-
-    if (ms->possible_cpus) {
-        /*
-         * make sure that max_cpus hasn't changed since the first use, i.e.
-         * -smp hasn't been parsed after it
-         */
-        assert(ms->possible_cpus->len == max_cpus);
-        return ms->possible_cpus;
-    }
-
-    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                                  sizeof(CPUArchId) * max_cpus);
-    ms->possible_cpus->len = max_cpus;
-    for (i = 0; i < ms->possible_cpus->len; i++) {
-        X86CPUTopoInfo topo;
-
-        ms->possible_cpus->cpus[i].type = ms->cpu_type;
-        ms->possible_cpus->cpus[i].vcpus_count = 1;
-        ms->possible_cpus->cpus[i].arch_id =
-            x86_cpu_apic_id_from_index(pcms, i);
-        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
-                                 pcms->smp_dies, ms->smp.cores,
-                                 ms->smp.threads, &topo);
-        ms->possible_cpus->cpus[i].props.has_socket_id = true;
-        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
-        if (pcms->smp_dies > 1) {
-            ms->possible_cpus->cpus[i].props.has_die_id = true;
-            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
-        }
-        ms->possible_cpus->cpus[i].props.has_core_id = true;
-        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
-        ms->possible_cpus->cpus[i].props.has_thread_id = true;
-        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
-    }
-    return ms->possible_cpus;
-}
-
 static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     /* cpu index isn't used */
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index de09e07..1396451 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,6 +27,7 @@
 
 #include "qemu/units.h"
 #include "hw/loader.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/display/ramfb.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 894989b..8920bd8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -41,6 +41,7 @@
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/ich9.h"
 #include "hw/i386/amd_iommu.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 28cb1f6..f5f3f46 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/sysbus.h"
+#include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
@@ -38,8 +39,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 
-#define BIOS_FILENAME "bios.bin"
-
 /*
  * We don't have a theoretically justifiable exact lower bound on the base
  * address of any flash mapping. In practice, the IO-APIC MMIO range is
@@ -211,59 +210,6 @@ static void pc_system_flash_map(PCMachineState *pcms,
     }
 }
 
-static void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
-{
-    char *filename;
-    MemoryRegion *bios, *isa_bios;
-    int bios_size, isa_bios_size;
-    int ret;
-
-    /* BIOS load */
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (filename) {
-        bios_size = get_image_size(filename);
-    } else {
-        bios_size = -1;
-    }
-    if (bios_size <= 0 ||
-        (bios_size % 65536) != 0) {
-        goto bios_error;
-    }
-    bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(bios, true);
-    }
-    ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
-    if (ret != 0) {
-    bios_error:
-        fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
-        exit(1);
-    }
-    g_free(filename);
-
-    /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        isa_bios,
-                                        1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
-    }
-
-    /* map all the bios at the top of memory */
-    memory_region_add_subregion(rom_memory,
-                                (uint32_t)(-bios_size),
-                                bios);
-}
-
 void pc_system_firmware_init(PCMachineState *pcms,
                              MemoryRegion *rom_memory)
 {
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
new file mode 100644
index 0000000..71fb093
--- /dev/null
+++ b/hw/i386/x86.c
@@ -0,0 +1,690 @@
+/*
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qapi-visit-common.h"
+#include "qapi/visitor.h"
+#include "sysemu/qtest.h"
+#include "sysemu/numa.h"
+#include "sysemu/replay.h"
+#include "sysemu/sysemu.h"
+
+#include "hw/i386/x86.h"
+#include "hw/i386/pc.h"
+#include "target/i386/cpu.h"
+#include "hw/i386/topology.h"
+#include "hw/i386/fw_cfg.h"
+
+#include "hw/acpi/cpu_hotplug.h"
+#include "hw/nmi.h"
+#include "hw/loader.h"
+#include "multiboot.h"
+#include "elf.h"
+#include "standard-headers/asm-x86/bootparam.h"
+
+#define BIOS_FILENAME "bios.bin"
+
+/* Physical Address of PVH entry point read from kernel ELF NOTE */
+static size_t pvh_start_addr;
+
+/*
+ * Calculates initial APIC ID for a specific CPU index
+ *
+ * Currently we need to be able to calculate the APIC ID from the CPU index
+ * alone (without requiring a CPU object), as the QEMU<->Seabios interfaces have
+ * no concept of "CPU index", and the NUMA tables on fw_cfg need the APIC ID of
+ * all CPUs up to max_cpus.
+ */
+uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+                                    unsigned int cpu_index)
+{
+    MachineState *ms = MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    uint32_t correct_id;
+    static bool warned;
+
+    correct_id = x86_apicid_from_cpu_idx(pcms->smp_dies, ms->smp.cores,
+                                         ms->smp.threads, cpu_index);
+    if (pcmc->compat_apic_id_mode) {
+        if (cpu_index != correct_id && !warned && !qtest_enabled()) {
+            error_report("APIC IDs set in compatibility mode, "
+                         "CPU topology won't match the configuration");
+            warned = true;
+        }
+        return cpu_index;
+    } else {
+        return correct_id;
+    }
+}
+
+void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp)
+{
+    Object *cpu = NULL;
+    Error *local_err = NULL;
+    CPUX86State *env = NULL;
+
+    cpu = object_new(MACHINE(pcms)->cpu_type);
+
+    env = &X86_CPU(cpu)->env;
+    env->nr_dies = pcms->smp_dies;
+
+    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
+    object_property_set_bool(cpu, true, "realized", &local_err);
+
+    object_unref(cpu);
+    error_propagate(errp, local_err);
+}
+
+void x86_cpus_init(PCMachineState *pcms)
+{
+    int i;
+    const CPUArchIdList *possible_cpus;
+    MachineState *ms = MACHINE(pcms);
+    MachineClass *mc = MACHINE_GET_CLASS(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(mc);
+
+    x86_cpu_set_default_version(pcmc->default_cpu_version);
+
+    /*
+     * Calculates the limit to CPU APIC ID values
+     *
+     * Limit for the APIC ID value, so that all
+     * CPU APIC IDs are < pcms->apic_id_limit.
+     *
+     * This is used for FW_CFG_MAX_CPUS. See comments on fw_cfg_arch_create().
+     */
+    pcms->apic_id_limit = x86_cpu_apic_id_from_index(pcms,
+                                                     ms->smp.max_cpus - 1) + 1;
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    for (i = 0; i < ms->smp.cpus; i++) {
+        x86_cpu_new(pcms, possible_cpus->cpus[i].arch_id, &error_fatal);
+    }
+}
+
+CpuInstanceProperties
+x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+   X86CPUTopoInfo topo;
+   PCMachineState *pcms = PC_MACHINE(ms);
+
+   assert(idx < ms->possible_cpus->len);
+   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
+                            pcms->smp_dies, ms->smp.cores,
+                            ms->smp.threads, &topo);
+   return topo.pkg_id % ms->numa_state->num_nodes;
+}
+
+const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
+{
+    PCMachineState *pcms = PC_MACHINE(ms);
+    int i;
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    if (ms->possible_cpus) {
+        /*
+         * make sure that max_cpus hasn't changed since the first use, i.e.
+         * -smp hasn't been parsed after it
+         */
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (i = 0; i < ms->possible_cpus->len; i++) {
+        X86CPUTopoInfo topo;
+
+        ms->possible_cpus->cpus[i].type = ms->cpu_type;
+        ms->possible_cpus->cpus[i].vcpus_count = 1;
+        ms->possible_cpus->cpus[i].arch_id =
+            x86_cpu_apic_id_from_index(pcms, i);
+        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
+                                 pcms->smp_dies, ms->smp.cores,
+                                 ms->smp.threads, &topo);
+        ms->possible_cpus->cpus[i].props.has_socket_id = true;
+        ms->possible_cpus->cpus[i].props.socket_id = topo.pkg_id;
+        if (pcms->smp_dies > 1) {
+            ms->possible_cpus->cpus[i].props.has_die_id = true;
+            ms->possible_cpus->cpus[i].props.die_id = topo.die_id;
+        }
+        ms->possible_cpus->cpus[i].props.has_core_id = true;
+        ms->possible_cpus->cpus[i].props.core_id = topo.core_id;
+        ms->possible_cpus->cpus[i].props.has_thread_id = true;
+        ms->possible_cpus->cpus[i].props.thread_id = topo.smt_id;
+    }
+    return ms->possible_cpus;
+}
+
+static long get_file_size(FILE *f)
+{
+    long where, size;
+
+    /* XXX: on Unix systems, using fstat() probably makes more sense */
+
+    where = ftell(f);
+    fseek(f, 0, SEEK_END);
+    size = ftell(f);
+    fseek(f, where, SEEK_SET);
+
+    return size;
+}
+
+struct setup_data {
+    uint64_t next;
+    uint32_t type;
+    uint32_t len;
+    uint8_t data[0];
+} __attribute__((packed));
+
+
+/*
+ * The entry point into the kernel for PVH boot is different from
+ * the native entry point.  The PVH entry is defined by the x86/HVM
+ * direct boot ABI and is available in an ELFNOTE in the kernel binary.
+ *
+ * This function is passed to load_elf() when it is called from
+ * load_elfboot() which then additionally checks for an ELF Note of
+ * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
+ * parse the PVH entry address from the ELF Note.
+ *
+ * Due to trickery in elf_opts.h, load_elf() is actually available as
+ * load_elf32() or load_elf64() and this routine needs to be able
+ * to deal with being called as 32 or 64 bit.
+ *
+ * The address of the PVH entry point is saved to the 'pvh_start_addr'
+ * global variable.  (although the entry point is 32-bit, the kernel
+ * binary can be either 32-bit or 64-bit).
+ */
+static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
+{
+    size_t *elf_note_data_addr;
+
+    /* Check if ELF Note header passed in is valid */
+    if (arg1 == NULL) {
+        return 0;
+    }
+
+    if (is64) {
+        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
+        uint64_t nhdr_size64 = sizeof(struct elf64_note);
+        uint64_t phdr_align = *(uint64_t *)arg2;
+        uint64_t nhdr_namesz = nhdr64->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr64) + nhdr_size64 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    } else {
+        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
+        uint32_t nhdr_size32 = sizeof(struct elf32_note);
+        uint32_t phdr_align = *(uint32_t *)arg2;
+        uint32_t nhdr_namesz = nhdr32->n_namesz;
+
+        elf_note_data_addr =
+            ((void *)nhdr32) + nhdr_size32 +
+            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
+    }
+
+    pvh_start_addr = *elf_note_data_addr;
+
+    return pvh_start_addr;
+}
+
+static bool load_elfboot(const char *kernel_filename,
+                         int kernel_file_size,
+                         uint8_t *header,
+                         size_t pvh_xen_start_addr,
+                         FWCfgState *fw_cfg)
+{
+    uint32_t flags = 0;
+    uint32_t mh_load_addr = 0;
+    uint32_t elf_kernel_size = 0;
+    uint64_t elf_entry;
+    uint64_t elf_low, elf_high;
+    int kernel_size;
+
+    if (ldl_p(header) != 0x464c457f) {
+        return false; /* no elfboot */
+    }
+
+    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
+    flags = elf_is64 ?
+        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
+
+    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
+        error_report("elfboot unsupported flags = %x", flags);
+        exit(1);
+    }
+
+    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
+    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
+                           NULL, &elf_note_type, &elf_entry,
+                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                           0, 0);
+
+    if (kernel_size < 0) {
+        error_report("Error while loading elf kernel");
+        exit(1);
+    }
+    mh_load_addr = elf_low;
+    elf_kernel_size = elf_high - elf_low;
+
+    if (pvh_start_addr == 0) {
+        error_report("Error loading uncompressed kernel without PVH ELF Note");
+        exit(1);
+    }
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
+
+    return true;
+}
+
+void x86_load_linux(PCMachineState *pcms,
+                    FWCfgState *fw_cfg)
+{
+    uint16_t protocol;
+    int setup_size, kernel_size, cmdline_size;
+    int dtb_size, setup_data_offset;
+    uint32_t initrd_max;
+    uint8_t header[8192], *setup, *kernel;
+    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
+    FILE *f;
+    char *vmode;
+    MachineState *machine = MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    struct setup_data *setup_data;
+    const char *kernel_filename = machine->kernel_filename;
+    const char *initrd_filename = machine->initrd_filename;
+    const char *dtb_filename = machine->dtb;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+
+    /* Align to 16 bytes as a paranoia measure */
+    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
+
+    /* load the kernel header */
+    f = fopen(kernel_filename, "rb");
+    if (!f) {
+        fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
+                kernel_filename, strerror(errno));
+        exit(1);
+    }
+
+    kernel_size = get_file_size(f);
+    if (!kernel_size ||
+        fread(header, 1, MIN(ARRAY_SIZE(header), kernel_size), f) !=
+        MIN(ARRAY_SIZE(header), kernel_size)) {
+        fprintf(stderr, "qemu: could not load kernel '%s': %s\n",
+                kernel_filename, strerror(errno));
+        exit(1);
+    }
+
+    /* kernel protocol version */
+    if (ldl_p(header + 0x202) == 0x53726448) {
+        protocol = lduw_p(header + 0x206);
+    } else {
+        /*
+         * This could be a multiboot kernel. If it is, let's stop treating it
+         * like a Linux kernel.
+         * Note: some multiboot images could be in the ELF format (the same of
+         * PVH), so we try multiboot first since we check the multiboot magic
+         * header before to load it.
+         */
+        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
+                           kernel_cmdline, kernel_size, header)) {
+            return;
+        }
+        /*
+         * Check if the file is an uncompressed kernel file (ELF) and load it,
+         * saving the PVH entry point used by the x86/HVM direct boot ABI.
+         * If load_elfboot() is successful, populate the fw_cfg info.
+         */
+        if (pcmc->pvh_enabled &&
+            load_elfboot(kernel_filename, kernel_size,
+                         header, pvh_start_addr, fw_cfg)) {
+            fclose(f);
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
+                strlen(kernel_cmdline) + 1);
+            fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+
+            fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
+            fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
+                             header, sizeof(header));
+
+            /* load initrd */
+            if (initrd_filename) {
+                GMappedFile *mapped_file;
+                gsize initrd_size;
+                gchar *initrd_data;
+                GError *gerr = NULL;
+
+                mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+                if (!mapped_file) {
+                    fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+                            initrd_filename, gerr->message);
+                    exit(1);
+                }
+                pcms->initrd_mapped_file = mapped_file;
+
+                initrd_data = g_mapped_file_get_contents(mapped_file);
+                initrd_size = g_mapped_file_get_length(mapped_file);
+                initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+                if (initrd_size >= initrd_max) {
+                    fprintf(stderr, "qemu: initrd is too large, cannot support."
+                            "(max: %"PRIu32", need %"PRId64")\n",
+                            initrd_max, (uint64_t)initrd_size);
+                    exit(1);
+                }
+
+                initrd_addr = (initrd_max - initrd_size) & ~4095;
+
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
+                fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+                fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
+                                 initrd_size);
+            }
+
+            option_rom[nb_option_roms].bootindex = 0;
+            option_rom[nb_option_roms].name = "pvh.bin";
+            nb_option_roms++;
+
+            return;
+        }
+        protocol = 0;
+    }
+
+    if (protocol < 0x200 || !(header[0x211] & 0x01)) {
+        /* Low kernel */
+        real_addr    = 0x90000;
+        cmdline_addr = 0x9a000 - cmdline_size;
+        prot_addr    = 0x10000;
+    } else if (protocol < 0x202) {
+        /* High but ancient kernel */
+        real_addr    = 0x90000;
+        cmdline_addr = 0x9a000 - cmdline_size;
+        prot_addr    = 0x100000;
+    } else {
+        /* High and recent kernel */
+        real_addr    = 0x10000;
+        cmdline_addr = 0x20000;
+        prot_addr    = 0x100000;
+    }
+
+    /* highest address for loading the initrd */
+    if (protocol >= 0x20c &&
+        lduw_p(header + 0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
+        /*
+         * Linux has supported initrd up to 4 GB for a very long time (2007,
+         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
+         * though it only sets initrd_max to 2 GB to "work around bootloader
+         * bugs". Luckily, QEMU firmware(which does something like bootloader)
+         * has supported this.
+         *
+         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
+         * be loaded into any address.
+         *
+         * In addition, initrd_max is uint32_t simply because QEMU doesn't
+         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
+         * field).
+         *
+         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
+         */
+        initrd_max = UINT32_MAX;
+    } else if (protocol >= 0x203) {
+        initrd_max = ldl_p(header + 0x22c);
+    } else {
+        initrd_max = 0x37ffffff;
+    }
+
+    if (initrd_max >= pcms->below_4g_mem_size - pcmc->acpi_data_size) {
+        initrd_max = pcms->below_4g_mem_size - pcmc->acpi_data_size - 1;
+    }
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
+    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
+
+    if (protocol >= 0x202) {
+        stl_p(header + 0x228, cmdline_addr);
+    } else {
+        stw_p(header + 0x20, 0xA33F);
+        stw_p(header + 0x22, cmdline_addr - real_addr);
+    }
+
+    /* handle vga= parameter */
+    vmode = strstr(kernel_cmdline, "vga=");
+    if (vmode) {
+        unsigned int video_mode;
+        int ret;
+        /* skip "vga=" */
+        vmode += 4;
+        if (!strncmp(vmode, "normal", 6)) {
+            video_mode = 0xffff;
+        } else if (!strncmp(vmode, "ext", 3)) {
+            video_mode = 0xfffe;
+        } else if (!strncmp(vmode, "ask", 3)) {
+            video_mode = 0xfffd;
+        } else {
+            ret = qemu_strtoui(vmode, NULL, 0, &video_mode);
+            if (ret != 0) {
+                fprintf(stderr, "qemu: can't parse 'vga' parameter: %s\n",
+                        strerror(-ret));
+                exit(1);
+            }
+        }
+        stw_p(header + 0x1fa, video_mode);
+    }
+
+    /* loader type */
+    /*
+     * High nybble = B reserved for QEMU; low nybble is revision number.
+     * If this code is substantially changed, you may want to consider
+     * incrementing the revision.
+     */
+    if (protocol >= 0x200) {
+        header[0x210] = 0xB0;
+    }
+    /* heap */
+    if (protocol >= 0x201) {
+        header[0x211] |= 0x80; /* CAN_USE_HEAP */
+        stw_p(header + 0x224, cmdline_addr - real_addr - 0x200);
+    }
+
+    /* load initrd */
+    if (initrd_filename) {
+        GMappedFile *mapped_file;
+        gsize initrd_size;
+        gchar *initrd_data;
+        GError *gerr = NULL;
+
+        if (protocol < 0x200) {
+            fprintf(stderr, "qemu: linux kernel too old to load a ram disk\n");
+            exit(1);
+        }
+
+        mapped_file = g_mapped_file_new(initrd_filename, false, &gerr);
+        if (!mapped_file) {
+            fprintf(stderr, "qemu: error reading initrd %s: %s\n",
+                    initrd_filename, gerr->message);
+            exit(1);
+        }
+        pcms->initrd_mapped_file = mapped_file;
+
+        initrd_data = g_mapped_file_get_contents(mapped_file);
+        initrd_size = g_mapped_file_get_length(mapped_file);
+        if (initrd_size >= initrd_max) {
+            fprintf(stderr, "qemu: initrd is too large, cannot support."
+                    "(max: %"PRIu32", need %"PRId64")\n",
+                    initrd_max, (uint64_t)initrd_size);
+            exit(1);
+        }
+
+        initrd_addr = (initrd_max - initrd_size) & ~4095;
+
+        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
+        fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
+
+        stl_p(header + 0x218, initrd_addr);
+        stl_p(header + 0x21c, initrd_size);
+    }
+
+    /* load kernel and setup */
+    setup_size = header[0x1f1];
+    if (setup_size == 0) {
+        setup_size = 4;
+    }
+    setup_size = (setup_size + 1) * 512;
+    if (setup_size > kernel_size) {
+        fprintf(stderr, "qemu: invalid kernel header\n");
+        exit(1);
+    }
+    kernel_size -= setup_size;
+
+    setup  = g_malloc(setup_size);
+    kernel = g_malloc(kernel_size);
+    fseek(f, 0, SEEK_SET);
+    if (fread(setup, 1, setup_size, f) != setup_size) {
+        fprintf(stderr, "fread() failed\n");
+        exit(1);
+    }
+    if (fread(kernel, 1, kernel_size, f) != kernel_size) {
+        fprintf(stderr, "fread() failed\n");
+        exit(1);
+    }
+    fclose(f);
+
+    /* append dtb to kernel */
+    if (dtb_filename) {
+        if (protocol < 0x209) {
+            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
+            exit(1);
+        }
+
+        dtb_size = get_image_size(dtb_filename);
+        if (dtb_size <= 0) {
+            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
+                    dtb_filename, strerror(errno));
+            exit(1);
+        }
+
+        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
+        kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
+        kernel = g_realloc(kernel, kernel_size);
+
+        stq_p(header + 0x250, prot_addr + setup_data_offset);
+
+        setup_data = (struct setup_data *)(kernel + setup_data_offset);
+        setup_data->next = 0;
+        setup_data->type = cpu_to_le32(SETUP_DTB);
+        setup_data->len = cpu_to_le32(dtb_size);
+
+        load_image_size(dtb_filename, setup_data->data, dtb_size);
+    }
+
+    memcpy(setup, header, MIN(sizeof(header), setup_size));
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
+
+    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
+    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
+    fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
+
+    option_rom[nb_option_roms].bootindex = 0;
+    option_rom[nb_option_roms].name = "linuxboot.bin";
+    if (pcmc->linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
+    }
+    nb_option_roms++;
+}
+
+void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
+{
+    char *filename;
+    MemoryRegion *bios, *isa_bios;
+    int bios_size, isa_bios_size;
+    int ret;
+
+    /* BIOS load */
+    if (bios_name == NULL) {
+        bios_name = BIOS_FILENAME;
+    }
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+    if (filename) {
+        bios_size = get_image_size(filename);
+    } else {
+        bios_size = -1;
+    }
+    if (bios_size <= 0 ||
+        (bios_size % 65536) != 0) {
+        goto bios_error;
+    }
+    bios = g_malloc(sizeof(*bios));
+    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    if (!isapc_ram_fw) {
+        memory_region_set_readonly(bios, true);
+    }
+    ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
+    if (ret != 0) {
+    bios_error:
+        fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
+        exit(1);
+    }
+    g_free(filename);
+
+    /* map the last 128KB of the BIOS in ISA space */
+    isa_bios_size = MIN(bios_size, 128 * KiB);
+    isa_bios = g_malloc(sizeof(*isa_bios));
+    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                             bios_size - isa_bios_size, isa_bios_size);
+    memory_region_add_subregion_overlap(rom_memory,
+                                        0x100000 - isa_bios_size,
+                                        isa_bios,
+                                        1);
+    if (!isapc_ram_fw) {
+        memory_region_set_readonly(isa_bios, true);
+    }
+
+    /* map all the bios at the top of memory */
+    memory_region_add_subregion(rom_memory,
+                                (uint32_t)(-bios_size),
+                                bios);
+}
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7082b06..f135ae8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -198,7 +198,6 @@ bool pc_machine_is_smm_enabled(PCMachineState *pcms);
 void pc_register_ferr_irq(qemu_irq irq);
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
-void x86_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
 void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
new file mode 100644
index 0000000..71e2b69
--- /dev/null
+++ b/include/hw/i386/x86.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_I386_X86_H
+#define HW_I386_X86_H
+
+#include "hw/boards.h"
+
+uint32_t x86_cpu_apic_id_from_index(PCMachineState *pcms,
+                                    unsigned int cpu_index);
+void x86_cpu_new(PCMachineState *pcms, int64_t apic_id, Error **errp);
+void x86_cpus_init(PCMachineState *pcms);
+CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
+                                             unsigned cpu_index);
+int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
+const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
+
+void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
+
+void x86_load_linux(PCMachineState *x86ms, FWCfgState *fw_cfg);
+
+#endif
-- 
1.8.3.1



