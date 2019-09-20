Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E445C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2218C2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvkindPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2218C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBBIl-0007b0-2X
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGY-0005aV-DG
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBBGW-0004YH-SL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 01:15:34 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBBGW-0004YB-O3; Fri, 20 Sep 2019 01:15:32 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z2so2195951ybp.9;
 Thu, 19 Sep 2019 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d5e531PhtDMLIyEsC4i6HC0w4jdHjK/dko3/isXiQ1c=;
 b=BvkindPKYgOxGzvXfYlrIXE6uNDKAoj3nP4CGoUIhce63S2+i4z0nMKuJ9XeIWwRB3
 YlirZpfr8eJkH2tc+fRHYOn5wKWdgwzwJaP3YNMmO2xk1ni0hdT/XXV/zmqAjsUD5sg2
 OlInUtdzll9FTtudvCvxX5Mfd0E6eBTz1rAyuyQ6j/miC5dHQE10WKlmNQXcM2U3aPkm
 KHydI6K2oqvNah3WnS4FGfOZ/nFpYbCV1d3cBPGUU1tJAomA/iHejwAJjkFevr+a9t+5
 hfTe/7QkBbpLrQVikqJvWRhSGsmqi1x1b+wR6IiMjFn6r9/v9/RXjGpeYK0aRtTiETv0
 jODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d5e531PhtDMLIyEsC4i6HC0w4jdHjK/dko3/isXiQ1c=;
 b=GL9VbvZK59lTxuAXhcm1hH67x5y/VtAUjLdoT4FJ6Nx5CwlkBVfDYajKI6aG9SFkxi
 612WY9jMLt1Ozgi+c03XjnIkJ1dUQiNylHnjC7NR/B50CgI9Jxz8INI0DoHkjsOdEtbv
 tlc7v5cIq1pbwqVRpdoarroQCy1JSW0GNY9YOiyMMs1bLbDyiPhKu16uP8lpDEvTcGkp
 C/YllC1smBOrHbd/foLlpzBK7Pu5d3Xszghf3SBWjIt65HoNz3EsfneMfT+El2I76fia
 yrFx6o4vseM3RZE2JKwFAercwFrUWoC3NOnOH87MKtO0bpAkkLN1fnABTKmHU2VSVoml
 zyIA==
X-Gm-Message-State: APjAAAV1dgRe4Jn6tvlFGWpN4s+gvpTWY3lMyoMAxwJgzopSpLaO7DRz
 LfSeDc93I4WI28EiP5xyHT/dd2XETBxLCrnSdUxRBg==
X-Google-Smtp-Source: APXvYqyNDtsHN6A9qJqO6HgSfKXahUCjjfGqtQ45239foh3iLiweQ4d2vrl1u88V1+M/XVDJu8T2ieBu9IpBOosfGQg=
X-Received: by 2002:a25:374c:: with SMTP id e73mr9057407yba.154.1568956532245; 
 Thu, 19 Sep 2019 22:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
In-Reply-To: <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 20 Sep 2019 13:15:19 +0800
Message-ID: <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 6:36 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
> from the ARM Virt board and the implementation is based on the ARM Virt
> board. This allows users to specify flash files from the command line.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/Kconfig        |  1 +
>  hw/riscv/virt.c         | 81 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h |  3 ++
>  3 files changed, 85 insertions(+)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index fb19b2df3a..b12660b9f8 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -36,4 +36,5 @@ config RISCV_VIRT
>      select SERIAL
>      select VIRTIO_MMIO
>      select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
>      select SIFIVE
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d36f5625ec..ca002ecea7 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -26,6 +26,7 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> +#include "hw/qdev-properties.h"
>  #include "hw/char/serial.h"
>  #include "target/riscv/cpu.h"
>  #include "hw/riscv/riscv_hart.h"
> @@ -61,12 +62,72 @@ static const struct MemmapEntry {
>      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
>      [VIRT_UART0] =       { 0x10000000,         0x100 },
>      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
> +    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
>      [VIRT_DRAM] =        { 0x80000000,           0x0 },
>      [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
>      [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
>      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
>  };
>
> +#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
> +                                       const char *name,
> +                                       const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
> +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);

alias_prop_name is unused? ARM virt has 2 more calls in the same function here.

> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void virt_flash_create(RISCVVirtState *s)
> +{
> +    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
> +    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");

I don't think we should mirror what is used on ARM virt board to
create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
they need distinguish secure and non-secure. For sifive_u, only one is
enough.

> +}
> +
> +static void virt_flash_map1(PFlashCFI01 *flash,
> +                            hwaddr base, hwaddr size,
> +                            MemoryRegion *sysmem)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
> +    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
> +    qdev_init_nofail(dev);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> +                                                       0));
> +}
> +
> +static void virt_flash_map(RISCVVirtState *s,
> +                           MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
> +    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
> +
> +    virt_flash_map1(s->flash[0], flashbase, flashsize,
> +                    sysmem);
> +    virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
> +                    sysmem);
> +}
> +
>  static void create_pcie_irq_map(void *fdt, char *nodename,
>                                  uint32_t plic_phandle)
>  {
> @@ -121,6 +182,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>      char *nodename;
>      uint32_t plic_phandle, phandle = 1;
>      int i;
> +    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
> +    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
>
>      fdt = s->fdt = create_device_tree(&s->fdt_size);
>      if (!fdt) {
> @@ -316,6 +379,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>      g_free(nodename);
> +
> +    nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
> +    qemu_fdt_add_subnode(s->fdt, nodename);
> +    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize);
> +    qemu_fdt_setprop_cell(s->fdt, nodename, "bank-width", 4);
> +    g_free(nodename);
>  }
>
>
> @@ -496,6 +568,15 @@ static void riscv_virt_board_init(MachineState *machine)
>          0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
>          serial_hd(0), DEVICE_LITTLE_ENDIAN);
>
> +    virt_flash_create(s);
> +
> +    /* Map legacy -drive if=pflash to machine properties */
> +    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
> +        pflash_cfi01_legacy_drive(s->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
> +    }
> +    virt_flash_map(s, system_memory);
> +
>      g_free(plic_hart_config);
>  }
>
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 6e5fbe5d3b..2ca8bd3512 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -21,6 +21,7 @@
>
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/sysbus.h"
> +#include "hw/block/flash.h"
>
>  typedef struct {
>      /*< private >*/
> @@ -29,6 +30,7 @@ typedef struct {
>      /*< public >*/
>      RISCVHartArrayState soc;
>      DeviceState *plic;
> +    PFlashCFI01 *flash[2];
>      void *fdt;
>      int fdt_size;
>  } RISCVVirtState;
> @@ -41,6 +43,7 @@ enum {
>      VIRT_PLIC,
>      VIRT_UART0,
>      VIRT_VIRTIO,
> +    VIRT_FLASH,
>      VIRT_DRAM,
>      VIRT_PCIE_MMIO,
>      VIRT_PCIE_PIO,
> --

Regards,
Bin

