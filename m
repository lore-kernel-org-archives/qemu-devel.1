Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF48BC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AC32070D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT+amB51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AC32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3LY-0002Ul-Hv
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 06:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs3L6-00026C-Iw
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hs3L2-0005da-Ou
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:57:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hs3Kz-0005X4-3g
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:57:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so23625132otq.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Cfs2TZuhyKTrVo9IZXXPxXb8S7yahqqzpzd0eV3Sq/E=;
 b=rT+amB516GGUasmEYLRr5+zj+Aw7GfM1/37S25g66iPUVnZs3MBGEIo9yC25DRMIyN
 Au1hnO10o8Y5IiYZ0I5Fck8NSt7Q2EljrpFdeNLMD0HJDlIHSOtJj4g9k8+OozhfKPSe
 rCrmp8uEawfKT9LwrEGRKKigtteTgfZU2DL3rm6owoLRlt2Abmmq49eIlrPQSs9Ulnnv
 ZsP6IqBzsx04dW39nuMD1Jw1rIrU8YLHRMvTUX5T1cmKhvSpCy8mb8zzMUdmkp2Rk17w
 tsfUwxbxagTCpcy+IHyUK0UWk21t00bYmVacFY/9qIk6/SAk3nUaiZ+WXf1SDZZQmslo
 ZpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Cfs2TZuhyKTrVo9IZXXPxXb8S7yahqqzpzd0eV3Sq/E=;
 b=LPVD0Yx/TpvKleSRbsOawzhdIDivELrShJbZfet38usqK3pfFq8cBYH5tLZ/6ddF1t
 0r6KzpFmP1Wrg6FPM3bjLb2/ad+pqUUL5bkF0UeGFCFwrAGJyBd5RtCfKRPyKauUZx2c
 ps643xGp5gk0YWVJDdScNUiKkP1iMwO17vA94oaH3Deq7LRvyn6yMPTGqZbBTR6Jeo/u
 n5KADUAeyDq4krzzp5su/yK7LnopdDYmrvpPSmSOyJYPFV9oCf4ujvNbgxM2OA90/kiE
 3SRXhq+Z7UvvHfcImZK4qvcDPsoVbafLtQoqD8a59ECFDIqkEffi5W5oMPXggO+YYxgt
 ky9Q==
X-Gm-Message-State: APjAAAVvTEcbSzYtGi+l02Og2unIMw2ZCT8Xhz7/caz4kYMeMmkjbeRI
 Ax0ZV5ISzUcqrfY+IqkVbGPyrnWzYJ+LOr4p95R2/9a+PBo=
X-Google-Smtp-Source: APXvYqzp1AEv7Vf5WmVZs94yqenLolEbbQ/fOhTZQ3NGhQ27eU4zw3jgg9N8ULVSnmGBlCu2CYViwGEPgX76J1FkIXQ=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr58861206otr.295.1564397819420; 
 Mon, 29 Jul 2019 03:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190401063639.18341-1-ayan@wavecomp.com>
In-Reply-To: <20190401063639.18341-1-ayan@wavecomp.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 29 Jul 2019 12:56:48 +0200
Message-ID: <CAL1e-=gF-kOhGRqKZaOSZoXqhVAdU4zdKF0Fq=aVGo6Bs8fucQ@mail.gmail.com>
To: Archer Yan <ayan@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, 
 Aleksandar Rikalo <arikalo@wavecomp.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] Support load kernel(vmlinux)/dtb/initrd
 separately for Boston in QEMU.
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On Mon, Apr 1, 2019 at 11:26 AM Archer Yan <ayan@wavecomp.com> wrote:

> Currently boston in QEMU only supports boot with FIT format. Since ELF file
> can provide symbol infomation in debug, this patch enables Boston boot from
> vmlinux&dtb.
>
> Signed-off-by: Archer Yan <ayan@wavecomp.com>
> ---
>  hw/mips/boston.c | 224 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 201 insertions(+), 23 deletions(-)
>
>
Hi, Paul,

Note that we now have 2 proposals dealing with this topic: this one and

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05108.html

I think it would be cool to integrate this support in 4.2.

Yours,
Aleksandar





> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index e5bab3cadc..5910ffdc8a 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -39,6 +39,10 @@
>  #include "sysemu/device_tree.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/qtest.h"
> +#include "elf.h"
> +#include "sysemu/kvm.h"
> +#include "hw/mips/mips.h"
> +#include "qemu/option.h"
>
>  #include <libfdt.h>
>
> @@ -58,6 +62,11 @@ typedef struct {
>
>      hwaddr kernel_entry;
>      hwaddr fdt_base;
> +    long kernel_size;
> +
> +    uint64_t initrd_size;
> +    uint64_t initrd_start;
> +    uint64_t initrd_offset;
>  } BostonState;
>
>  enum boston_plat_reg {
> @@ -328,31 +337,59 @@ static void gen_firmware(uint32_t *p, hwaddr
> kernel_entry, hwaddr fdt_addr,
>      stl_p(p++, 0x03200009);                     /* jr   $25 */
>  }
>
> -static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
> -                                     const void *match_data, hwaddr
> *load_addr)
> +typedef uint64_t (*xlate_to_kseg0)(void *, uint64_t);
> +static xlate_to_kseg0 get_xlate_to_kseg0_fn(BostonState *s)
> +{
> +    /* Check where the kernel has been linked */
> +    if (s->kernel_entry & 0x80000000ll) {
> +        if (kvm_enabled()) {
> +            error_report("KVM guest kernels must be linked in useg. "
> +                         "Did you forget to enable CONFIG_KVM_GUEST?");
> +            return NULL;
> +        }
> +        return cpu_mips_phys_to_kseg0;
> +    } else {
> +        /* if kernel entry is in useg it is probably a KVM T&E kernel */
> +        mips_um_ksegs_enable();
> +        return cpu_mips_kvm_um_phys_to_kseg0;
> +    }
> +}
> +
> +/*Adapt fdt to insert initrd parameters*/
> +static int boston_initrd_fdt(BostonState *s, void *fdt)
>  {
> -    BostonState *s = BOSTON(opaque);
> -    MachineState *machine = s->mach;
>      const char *cmdline;
> +    char *args_str = NULL;
> +    MachineState *machine = s->mach;
> +    int initrd_args_len = 64;
>      int err;
> -    void *fdt;
> -    size_t fdt_sz, ram_low_sz, ram_high_sz;
> +    size_t ram_low_sz, ram_high_sz;
> +    uint64_t (*xlate_to_kseg0_fn) (void *opaque, uint64_t addr);
>
> -    fdt_sz = fdt_totalsize(fdt_orig) * 2;
> -    fdt = g_malloc0(fdt_sz);
> +    cmdline = (machine->kernel_cmdline && machine->kernel_cmdline[0])
> +            ? machine->kernel_cmdline : " ";
> +    xlate_to_kseg0_fn = get_xlate_to_kseg0_fn(s);
> +    if (NULL == xlate_to_kseg0_fn) {
> +        fprintf(stderr, "couldn't get xlate_to_kseg0\n");
> +        return -1;
> +    }
>
> -    err = fdt_open_into(fdt_orig, fdt, fdt_sz);
> -    if (err) {
> -        fprintf(stderr, "unable to open FDT\n");
> -        return NULL;
> +    s->initrd_start = xlate_to_kseg0_fn(NULL, s->initrd_offset);
> +
> +    if (s->initrd_size) {
> +        args_str = g_malloc(strlen(cmdline) + initrd_args_len);
> +        if (args_str != NULL) {
> +            sprintf((char *)args_str, "rd_start=0x%lx rd_size=0x%lx %s",
> +                    s->initrd_start, s->initrd_size, cmdline);
> +            cmdline = args_str;
> +        }
>      }
>
> -    cmdline = (machine->kernel_cmdline && machine->kernel_cmdline[0])
> -            ? machine->kernel_cmdline : " ";
>      err = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      if (err < 0) {
>          fprintf(stderr, "couldn't set /chosen/bootargs\n");
> -        return NULL;
> +        g_free(args_str);
> +        return -1;
>      }
>
>      ram_low_sz = MIN(256 * MiB, machine->ram_size);
> @@ -360,10 +397,41 @@ static const void *boston_fdt_filter(void *opaque,
> const void *fdt_orig,
>      qemu_fdt_setprop_sized_cells(fdt, "/memory@0", "reg",
>                                   1, 0x00000000, 1, ram_low_sz,
>                                   1, 0x90000000, 1, ram_high_sz);
> +    g_free(args_str);
> +    return 0;
> +}
>
> -    fdt = g_realloc(fdt, fdt_totalsize(fdt));
> -    qemu_fdt_dumpdtb(fdt, fdt_sz);
> +static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
> +                                     const void *match_data, hwaddr
> *load_addr)
> +{
> +    BostonState *s = BOSTON(opaque);
> +    MachineState *machine = s->mach;
> +    int err;
> +    void *fdt;
> +    int fdt_sz;
> +    if (machine->dtb) {
> +        /*Use QEMU cmd specified dtb*/
> +        fdt = load_device_tree(machine->dtb, &fdt_sz);
> +    } else {
> +        /*Use default dtb contained in FIT image*/
> +        fdt_sz = fdt_totalsize(fdt_orig) * 2;
> +        fdt = g_malloc0(fdt_sz);
> +
> +        err = fdt_open_into(fdt_orig, fdt, fdt_sz);
> +        if (err) {
> +            fprintf(stderr, "unable to open FDT\n");
> +            return NULL;
> +        }
> +
> +        fdt = g_realloc(fdt, fdt_totalsize(fdt));
> +    }
>
> +    err = boston_initrd_fdt(s, fdt);
> +    if (err) {
> +        return NULL;
> +    }
> +
> +    qemu_fdt_dumpdtb(fdt, fdt_sz);
>      s->fdt_base = *load_addr;
>
>      return fdt;
> @@ -391,6 +459,99 @@ static const struct fit_loader boston_fit_loader = {
>      .kernel_filter = boston_kernel_filter,
>  };
>
> +static int boston_load_dtb(BostonState *s)
> +{
> +    void *fdt = NULL;
> +    int size = 0;
> +    int err;
> +    MachineState *machine = s->mach;
> +    hwaddr load_addr;
> +    hwaddr kernel_end = 0xffffffff80100000 + s->kernel_size;
> +
> +    fdt = load_device_tree(machine->dtb, &size);
> +    if (!fdt) {
> +        fprintf(stderr, "Couldn't open dtb file %s\n", machine->dtb);
> +        return -1;
> +    }
> +    load_addr = ROUND_UP(kernel_end, 64 * KiB) + (10 * MiB);
> +    err = boston_initrd_fdt(s, fdt);
> +    if (err) {
> +        return -1;
> +    }
> +
> +    qemu_fdt_dumpdtb(fdt, size);
> +
> +    s->fdt_base = load_addr;
> +    load_addr = cpu_mips_kseg0_to_phys(s, load_addr);
> +    rom_add_blob_fixed("fdt@boston", fdt, size, load_addr);
> +
> +    return 0;
> +
> +}
> +
> +static int boston_load_initrd(BostonState *s)
> +{
> +    int64_t initrd_size = 0;
> +    ram_addr_t initrd_offset = 0;
> +    int ram_low_size;
> +    MachineState *machine = s->mach;
> +    ram_low_size = MIN(machine->ram_size, 256 * MiB);
> +    if (machine->initrd_filename) {
> +        initrd_size = get_image_size(machine->initrd_filename);
> +        if (initrd_size > 0) {
> +            /*
> +             * The kernel allocates the bootmap memory in the low memory
> after
> +             *  the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
> +             *  pages.
> +             */
> +            initrd_offset = (ram_low_size - initrd_size
> +                             - (128 * KiB)
> +                             - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
> +
> +            initrd_size = load_image_targphys(machine->initrd_filename,
> +                                              initrd_offset,
> +                                              ram_size - initrd_offset);
> +        }
> +        if (initrd_size == (target_ulong) -1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         machine->initrd_filename);
> +            return -1;
> +        }
> +    }
> +    s->initrd_offset = initrd_offset;
> +    s->initrd_size = initrd_size;
> +    return 0;
> +}
> +
> +static int boston_load_kernel(BostonState *s)
> +{
> +    int64_t kernel_entry, kernel_high;
> +    long kernel_size;
> +    int big_endian;
> +    MachineState *machine = s->mach;
> +
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    big_endian = 1;
> +#else
> +    big_endian = 0;
> +#endif
> +
> +    kernel_size = load_elf(machine->kernel_filename, NULL,
> +                           cpu_mips_kseg0_to_phys,  NULL,
> +                           (uint64_t *)&kernel_entry, NULL,
> +                           (uint64_t *)&kernel_high, big_endian, EM_MIPS,
> 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("could not load kernel '%s': %s",
> +                     machine->kernel_filename,
> +                     load_elf_strerror(kernel_size));
> +        return -1;
> +    }
> +
> +    s->kernel_entry = kernel_entry;
> +    s->kernel_size = kernel_size;
> +    return 0;
> +}
> +
>  static inline XilinxPCIEHost *
>  xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
>                   hwaddr cfg_base, uint64_t cfg_size,
> @@ -433,7 +594,7 @@ static void boston_mach_init(MachineState *machine)
>      PCIDevice *ahci;
>      DriveInfo *hd[6];
>      Chardev *chr;
> -    int fw_size, fit_err;
> +    int fw_size, load_err;
>      bool is_64b;
>
>      if ((machine->ram_size % GiB) ||
> @@ -533,12 +694,29 @@ static void boston_mach_init(MachineState *machine)
>              exit(1);
>          }
>      } else if (machine->kernel_filename) {
> -        fit_err = load_fit(&boston_fit_loader, machine->kernel_filename,
> s);
> -        if (fit_err) {
> -            error_printf("unable to load FIT image\n");
> -            exit(1);
> +        if (machine->initrd_filename) {
> +            load_err = boston_load_initrd(s);
> +            if (load_err) {
> +                error_printf("unable to separately load initrd image\n");
> +                exit(1);
> +            }
> +        }
> +        load_err = load_fit(&boston_fit_loader, machine->kernel_filename,
> s);
> +        if (load_err) {
> +            error_printf("unable to load FIT image, try load as ELF\n");
> +            load_err = boston_load_kernel(s);
> +            if (load_err) {
> +                error_printf("unable to separately load kernel image\n");
> +                exit(1);
> +            }
> +            if (machine->dtb) {
> +                load_err = boston_load_dtb(s);
> +                if (load_err) {
> +                    error_printf("unable to separately load dtb image\n");
> +                    exit(1);
> +                }
> +            }
>          }
> -
>          gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
>                       s->kernel_entry, s->fdt_base, is_64b);
>      } else if (!qtest_enabled()) {
> --
> 2.17.1
>
>
>
