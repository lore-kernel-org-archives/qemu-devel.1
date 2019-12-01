Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E2C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998172146E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 23:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTrBDGpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998172146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibYzC-0006Fy-QE
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 18:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibYyM-0005C3-Kj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibYyJ-0002pR-Mj
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibYyJ-0002oy-BC
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 18:49:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id i4so2575670otr.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=1ScVH3x6r3eo7R+ETiJyC4kXcOs4fp/zSJ8E5k1XfBU=;
 b=VTrBDGpiQVlq6OPmRj0JgId7oJ737GUTxLzG4UleZVVG23PEJwirGf3ekwI20ZVURb
 Hit0W/B7L8mBbVuC8NBQ/+SOi6DksWVnQB2IjedOif/veVS40+Sh5N4Idh+V4XspfaTk
 M0rSw4lFrcMRbzkoLQDJ0i3Z9k+zizTrunyKP7nPrEtjxaProLVvjXUbDuE+Nd7sUbsC
 3fA8lAPyMHMBW9oMhFNmhHkaEqQRzqeKChn5AVvO2FUjP5QhcB14EFE5GNibFAnOenMo
 hANB4ras8UIJDxP4FH+oaZskR/g44zrh+LMwcyZkmRwr/kEIHUtZYhGaXCnjFIfrM5Z7
 yFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=1ScVH3x6r3eo7R+ETiJyC4kXcOs4fp/zSJ8E5k1XfBU=;
 b=Rst8y1Rukq7tHNMMkqxi8Z+bBhwN4Ve1OZ2ghGlqrf5m6cPGahjpkAqaGEb23iKO+7
 36uNAZ0un9nSzU5XmSNaGTT1lcA614Th2ZDenZcieF9b95s5z5lyHf3sy7UUFApAD2tO
 SH0kk16/dbGDZdI1yQ4G3bdXTyjrFHj6swE/SFgvT1u+Bu9PYkAwbo5MHKZbT39A8GoF
 5LJjhU85VN77eGK2FAectmwM3kqjnxOMq9Ny7fxXy10WXBRl8qPvzv5PRLe6LkiDbPTd
 5LtC1fiftlt6Y33WpsvLRjN2eoQT2EwdBGZ7PoW8itWNP2tmn1kYSuqcl6+GemsFpKzs
 1tMw==
X-Gm-Message-State: APjAAAVteS8iWbRERc1zGFsIBM0iW6oSDePirVM/hF5G2MuXXUv4nhA5
 tbos+iaRHbJIHYWkK3+epZ0v1g7ZcqG1vrInEVE=
X-Google-Smtp-Source: APXvYqySdu5T2d3xZjSh905a/oHY481rnAi3Gw7SSDYP3PdBqW+m3J0nlea6sk0/9Sh7qBDOARm4LOLpkCktveNxjYU=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr20127257ote.341.1575244186261; 
 Sun, 01 Dec 2019 15:49:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 15:49:45
 -0800 (PST)
In-Reply-To: <1574687098-26689-6-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-6-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Dec 2019 00:49:45 +0100
Message-ID: <CAL1e-=h5VnPTBUDJXHWbg+7_XeHa9v7U20kw3F_Vq4+7i=PpZw@mail.gmail.com>
Subject: Re: [PATCH 5/5] mips: fulong 2e: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000281c4e0598ad1e95"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000281c4e0598ad1e95
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in files:
>     hw/mips/mips_fulong2e.c
>     hw/isa/vt82c686.c
>     hw/pci-host/bonito.c
>     include/hw/isa/vt82c686.h
>
> These mips Fulong 2E machine files were edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  hw/isa/vt82c686.c    | 23 ++++++++++----------
>  hw/pci-host/bonito.c | 60 +++++++++++++++++++++++++++++-
> ----------------------
>  2 files changed, 45 insertions(+), 38 deletions(-)
>
>
Excellent!

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
> index 616f67f..f828708 100644
> --- a/hw/isa/vt82c686.c
> +++ b/hw/isa/vt82c686.c
> @@ -27,7 +27,7 @@
>  #include "qemu/timer.h"
>  #include "exec/address-spaces.h"
>
> -//#define DEBUG_VT82C686B
> +/* #define DEBUG_VT82C686B */
>
>  #ifdef DEBUG_VT82C686B
>  #define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__,
> ##__VA_ARGS__)
> @@ -35,8 +35,7 @@
>  #define DPRINTF(fmt, ...)
>  #endif
>
> -typedef struct SuperIOConfig
> -{
> +typedef struct SuperIOConfig {
>      uint8_t config[0x100];
>      uint8_t index;
>      uint8_t data;
> @@ -102,7 +101,7 @@ static uint64_t superio_ioport_readb(void *opaque,
> hwaddr addr, unsigned size)
>      SuperIOConfig *superio_conf = opaque;
>
>      DPRINTF("superio_ioport_readb  address 0x%x\n", addr);
> -    return (superio_conf->config[superio_conf->index]);
> +    return superio_conf->config[superio_conf->index];
>  }
>
>  static const MemoryRegionOps superio_ops = {
> @@ -143,7 +142,7 @@ static void vt82c686b_isa_reset(DeviceState *dev)
>  }
>
>  /* write config pci function0 registers. PCI-ISA bridge */
> -static void vt82c686b_write_config(PCIDevice * d, uint32_t address,
> +static void vt82c686b_write_config(PCIDevice *d, uint32_t address,
>                                     uint32_t val, int len)
>  {
>      VT82C686BState *vt686 = VT82C686B_DEVICE(d);
> @@ -365,7 +364,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error
> **errp)
>      pci_set_long(pci_conf + 0x48, 0x00000001);
>
>      /* SMB ports:0xeee0~0xeeef */
> -    s->smb_io_base =((s->smb_io_base & 0xfff0) + 0x0);
> +    s->smb_io_base = ((s->smb_io_base & 0xfff0) + 0x0);
>      pci_conf[0x90] = s->smb_io_base | 1;
>      pci_conf[0x91] = s->smb_io_base >> 8;
>      pci_conf[0xd2] = 0x90;
> @@ -462,16 +461,18 @@ static void vt82c686b_realize(PCIDevice *d, Error
> **errp)
>
>      wmask = d->wmask;
>      for (i = 0x00; i < 0xff; i++) {
> -       if (i<=0x03 || (i>=0x08 && i<=0x3f)) {
> -           wmask[i] = 0x00;
> -       }
> +        if (i <= 0x03 || (i >= 0x08 && i <= 0x3f)) {
> +            wmask[i] = 0x00;
> +        }
>      }
>
>      memory_region_init_io(&vt82c->superio, OBJECT(d), &superio_ops,
>                            &vt82c->superio_conf, "superio", 2);
>      memory_region_set_enabled(&vt82c->superio, false);
> -    /* The floppy also uses 0x3f0 and 0x3f1.
> -     * But we do not emulate a floppy, so just set it here. */
> +    /*
> +     * The floppy also uses 0x3f0 and 0x3f1.
> +     * But we do not emulate a floppy, so just set it here.
> +     */
>      memory_region_add_subregion(isa_bus->address_space_io, 0x3f0,
>                                  &vt82c->superio);
>  }
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index ceee463..4692d41 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -14,7 +14,8 @@
>   * fulong 2e mini pc has a bonito north bridge.
>   */
>
> -/* what is the meaning of devfn in qemu and IDSEL in bonito northbridge?
> +/*
> + * what is the meaning of devfn in qemu and IDSEL in bonito northbridge?
>   *
>   * devfn   pci_slot<<3  + funno
>   * one pci bus can have 32 devices and each device can have 8 functions.
> @@ -49,7 +50,7 @@
>  #include "sysemu/runstate.h"
>  #include "exec/address-spaces.h"
>
> -//#define DEBUG_BONITO
> +/* #define DEBUG_BONITO */
>
>  #ifdef DEBUG_BONITO
>  #define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__,
> ##__VA_ARGS__)
> @@ -60,45 +61,45 @@
>  /* from linux soure code. include/asm-mips/mips-boards/bonito64.h*/
>  #define BONITO_BOOT_BASE        0x1fc00000
>  #define BONITO_BOOT_SIZE        0x00100000
> -#define BONITO_BOOT_TOP         (BONITO_BOOT_BASE+BONITO_BOOT_SIZE-1)
> +#define BONITO_BOOT_TOP         (BONITO_BOOT_BASE + BONITO_BOOT_SIZE - 1)
>  #define BONITO_FLASH_BASE       0x1c000000
>  #define BONITO_FLASH_SIZE       0x03000000
> -#define BONITO_FLASH_TOP        (BONITO_FLASH_BASE+BONITO_FLASH_SIZE-1)
> +#define BONITO_FLASH_TOP        (BONITO_FLASH_BASE + BONITO_FLASH_SIZE -
> 1)
>  #define BONITO_SOCKET_BASE      0x1f800000
>  #define BONITO_SOCKET_SIZE      0x00400000
> -#define BONITO_SOCKET_TOP       (BONITO_SOCKET_BASE+BONITO_SOCKET_SIZE-1)
> +#define BONITO_SOCKET_TOP       (BONITO_SOCKET_BASE + BONITO_SOCKET_SIZE
> - 1)
>  #define BONITO_REG_BASE         0x1fe00000
>  #define BONITO_REG_SIZE         0x00040000
> -#define BONITO_REG_TOP          (BONITO_REG_BASE+BONITO_REG_SIZE-1)
> +#define BONITO_REG_TOP          (BONITO_REG_BASE + BONITO_REG_SIZE - 1)
>  #define BONITO_DEV_BASE         0x1ff00000
>  #define BONITO_DEV_SIZE         0x00100000
> -#define BONITO_DEV_TOP          (BONITO_DEV_BASE+BONITO_DEV_SIZE-1)
> +#define BONITO_DEV_TOP          (BONITO_DEV_BASE + BONITO_DEV_SIZE - 1)
>  #define BONITO_PCILO_BASE       0x10000000
>  #define BONITO_PCILO_BASE_VA    0xb0000000
>  #define BONITO_PCILO_SIZE       0x0c000000
> -#define BONITO_PCILO_TOP        (BONITO_PCILO_BASE+BONITO_PCILO_SIZE-1)
> +#define BONITO_PCILO_TOP        (BONITO_PCILO_BASE + BONITO_PCILO_SIZE -
> 1)
>  #define BONITO_PCILO0_BASE      0x10000000
>  #define BONITO_PCILO1_BASE      0x14000000
>  #define BONITO_PCILO2_BASE      0x18000000
>  #define BONITO_PCIHI_BASE       0x20000000
>  #define BONITO_PCIHI_SIZE       0x20000000
> -#define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE+BONITO_PCIHI_SIZE-1)
> +#define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE -
> 1)
>  #define BONITO_PCIIO_BASE       0x1fd00000
>  #define BONITO_PCIIO_BASE_VA    0xbfd00000
>  #define BONITO_PCIIO_SIZE       0x00010000
> -#define BONITO_PCIIO_TOP        (BONITO_PCIIO_BASE+BONITO_PCIIO_SIZE-1)
> +#define BONITO_PCIIO_TOP        (BONITO_PCIIO_BASE + BONITO_PCIIO_SIZE -
> 1)
>  #define BONITO_PCICFG_BASE      0x1fe80000
>  #define BONITO_PCICFG_SIZE      0x00080000
> -#define BONITO_PCICFG_TOP       (BONITO_PCICFG_BASE+BONITO_PCICFG_SIZE-1)
> +#define BONITO_PCICFG_TOP       (BONITO_PCICFG_BASE + BONITO_PCICFG_SIZE
> - 1)
>
>
>  #define BONITO_PCICONFIGBASE    0x00
>  #define BONITO_REGBASE          0x100
>
> -#define BONITO_PCICONFIG_BASE   (BONITO_PCICONFIGBASE+BONITO_REG_BASE)
> +#define BONITO_PCICONFIG_BASE   (BONITO_PCICONFIGBASE + BONITO_REG_BASE)
>  #define BONITO_PCICONFIG_SIZE   (0x100)
>
> -#define BONITO_INTERNAL_REG_BASE  (BONITO_REGBASE+BONITO_REG_BASE)
> +#define BONITO_INTERNAL_REG_BASE  (BONITO_REGBASE + BONITO_REG_BASE)
>  #define BONITO_INTERNAL_REG_SIZE  (0x70)
>
>  #define BONITO_SPCICONFIG_BASE  (BONITO_PCICFG_BASE)
> @@ -111,7 +112,7 @@
>
>  #define BONITO_BONPONCFG        (0x00 >> 2)      /* 0x100 */
>  #define BONITO_BONGENCFG_OFFSET 0x4
> -#define BONITO_BONGENCFG        (BONITO_BONGENCFG_OFFSET>>2)   /*0x104 */
> +#define BONITO_BONGENCFG        (BONITO_BONGENCFG_OFFSET >> 2)   /*0x104
> */
>
>  /* 2. IO & IDE configuration */
>  #define BONITO_IODEVCFG         (0x08 >> 2)      /* 0x108 */
> @@ -177,15 +178,15 @@
>  /* idsel BIT = pci slot number +12 */
>  #define PCI_SLOT_BASE              12
>  #define PCI_IDSEL_VIA686B_BIT      (17)
> -#define PCI_IDSEL_VIA686B          (1<<PCI_IDSEL_VIA686B_BIT)
> +#define PCI_IDSEL_VIA686B          (1 << PCI_IDSEL_VIA686B_BIT)
>
> -#define PCI_ADDR(busno,devno,funno,regno)  \
> -    ((((busno)<<16)&0xff0000) + (((devno)<<11)&0xf800) +
> (((funno)<<8)&0x700) + (regno))
> +#define PCI_ADDR(busno , devno , funno , regno)  \
> +    ((((busno) << 16) & 0xff0000) + (((devno) << 11) & 0xf800) + \
> +    (((funno) << 8) & 0x700) + (regno))
>
>  typedef struct BonitoState BonitoState;
>
> -typedef struct PCIBonitoState
> -{
> +typedef struct PCIBonitoState {
>      PCIDevice dev;
>
>      BonitoState *pcihost;
> @@ -239,7 +240,8 @@ static void bonito_writel(void *opaque, hwaddr addr,
>
>      saddr = addr >> 2;
>
> -    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n", addr,
> val, saddr);
> +    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n",
> +            addr, val, saddr);
>      switch (saddr) {
>      case BONITO_BONPONCFG:
>      case BONITO_IODEVCFG:
> @@ -363,7 +365,7 @@ static uint64_t bonito_ldma_readl(void *opaque, hwaddr
> addr,
>          return 0;
>      }
>
> -    val = ((uint32_t *)(&s->bonldma))[addr/sizeof(uint32_t)];
> +    val = ((uint32_t *)(&s->bonldma))[addr / sizeof(uint32_t)];
>
>      return val;
>  }
> @@ -377,7 +379,7 @@ static void bonito_ldma_writel(void *opaque, hwaddr
> addr,
>          return;
>      }
>
> -    ((uint32_t *)(&s->bonldma))[addr/sizeof(uint32_t)] = val &
> 0xffffffff;
> +    ((uint32_t *)(&s->bonldma))[addr / sizeof(uint32_t)] = val &
> 0xffffffff;
>  }
>
>  static const MemoryRegionOps bonito_ldma_ops = {
> @@ -400,7 +402,7 @@ static uint64_t bonito_cop_readl(void *opaque, hwaddr
> addr,
>          return 0;
>      }
>
> -    val = ((uint32_t *)(&s->boncop))[addr/sizeof(uint32_t)];
> +    val = ((uint32_t *)(&s->boncop))[addr / sizeof(uint32_t)];
>
>      return val;
>  }
> @@ -414,7 +416,7 @@ static void bonito_cop_writel(void *opaque, hwaddr
> addr,
>          return;
>      }
>
> -    ((uint32_t *)(&s->boncop))[addr/sizeof(uint32_t)] = val & 0xffffffff;
> +    ((uint32_t *)(&s->boncop))[addr / sizeof(uint32_t)] = val &
> 0xffffffff;
>  }
>
>  static const MemoryRegionOps bonito_cop_ops = {
> @@ -446,7 +448,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque,
> hwaddr addr)
>      cfgaddr = addr & 0xffff;
>      cfgaddr |= (s->regs[BONITO_PCIMAP_CFG] & 0xffff) << 16;
>
> -    idsel = (cfgaddr & BONITO_PCICONF_IDSEL_MASK) >>
> BONITO_PCICONF_IDSEL_OFFSET;
> +    idsel = (cfgaddr & BONITO_PCICONF_IDSEL_MASK) >>
> +             BONITO_PCICONF_IDSEL_OFFSET;
>      devno = ctz32(idsel);
>      funno = (cfgaddr & BONITO_PCICONF_FUN_MASK) >>
> BONITO_PCICONF_FUN_OFFSET;
>      regno = (cfgaddr & BONITO_PCICONF_REG_MASK) >>
> BONITO_PCICONF_REG_OFFSET;
> @@ -550,7 +553,7 @@ static void pci_bonito_set_irq(void *opaque, int
> irq_num, int level)
>  }
>
>  /* map the original irq (0~3) to bonito irq (16~47, but 16~31 are unused)
> */
> -static int pci_bonito_map_irq(PCIDevice * pci_dev, int irq_num)
> +static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)
>  {
>      int slot;
>
> @@ -618,7 +621,10 @@ static void bonito_realize(PCIDevice *dev, Error
> **errp)
>      SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
>      PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
>
> -    /* Bonito North Bridge, built on FPGA, VENDOR_ID/DEVICE_ID are
> "undefined" */
> +    /*
> +     * Bonito North Bridge, built on FPGA,
> +     * VENDOR_ID/DEVICE_ID are "undefined"
> +     */
>      pci_config_set_prog_interface(dev->config, 0x00);
>
>      /* set the north bridge register mapping */
> --
> 2.7.4
>
>
>

--000000000000281c4e0598ad1e95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:Fi=
lip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The script <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> located in scripts folder was<br>
used to detect all errors and warrnings in files:<br>
=C2=A0 =C2=A0 hw/mips/mips_fulong2e.c<br>
=C2=A0 =C2=A0 hw/isa/vt82c686.c<br>
=C2=A0 =C2=A0 hw/pci-host/bonito.c<br>
=C2=A0 =C2=A0 include/hw/isa/vt82c686.h<br>
<br>
These mips Fulong 2E machine files were edited and<br>
all the errors and warrings generated by the <a href=3D"http://checkpatch.p=
l" target=3D"_blank">checkpatch.pl</a><br>
script were corrected and then the script was<br>
ran again to make sure there are no more errors and warnings.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/vt82c686.c=C2=A0 =C2=A0 | 23 ++++++++++----------<br>
=C2=A0hw/pci-host/bonito.c | 60 +++++++++++++++++++++++++++++-<wbr>--------=
--------------<br>
=C2=A02 files changed, 45 insertions(+), 38 deletions(-)<br>
<br></blockquote><div><br></div><div>Excellent!</div><div><br></div><div><s=
pan style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000839233=
4px">Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"mailto:amarkovi=
c@wavecomp.com" target=3D"_blank" style=3D"font-size:14px;line-height:22.12=
00008392334px">amarkovic@wavecomp.com</a><span style=3D"color:rgb(34,34,34)=
;font-size:14px;line-height:22.1200008392334px">&gt;</span><br></div><div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c<br>
index 616f67f..f828708 100644<br>
--- a/hw/isa/vt82c686.c<br>
+++ b/hw/isa/vt82c686.c<br>
@@ -27,7 +27,7 @@<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
<br>
-//#define DEBUG_VT82C686B<br>
+/* #define DEBUG_VT82C686B */<br>
<br>
=C2=A0#ifdef DEBUG_VT82C686B<br>
=C2=A0#define DPRINTF(fmt, ...) fprintf(stderr, &quot;%s: &quot; fmt, __fun=
c__, ##__VA_ARGS__)<br>
@@ -35,8 +35,7 @@<br>
=C2=A0#define DPRINTF(fmt, ...)<br>
=C2=A0#endif<br>
<br>
-typedef struct SuperIOConfig<br>
-{<br>
+typedef struct SuperIOConfig {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t config[0x100];<br>
=C2=A0 =C2=A0 =C2=A0uint8_t index;<br>
=C2=A0 =C2=A0 =C2=A0uint8_t data;<br>
@@ -102,7 +101,7 @@ static uint64_t superio_ioport_readb(void *opaque, hwad=
dr addr, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0SuperIOConfig *superio_conf =3D opaque;<br>
<br>
=C2=A0 =C2=A0 =C2=A0DPRINTF(&quot;superio_ioport_readb=C2=A0 address 0x%x\n=
&quot;, addr);<br>
-=C2=A0 =C2=A0 return (superio_conf-&gt;config[superio_<wbr>conf-&gt;index]=
);<br>
+=C2=A0 =C2=A0 return superio_conf-&gt;config[superio_<wbr>conf-&gt;index];=
<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps superio_ops =3D {<br>
@@ -143,7 +142,7 @@ static void vt82c686b_isa_reset(<wbr>DeviceState *dev)<=
br>
=C2=A0}<br>
<br>
=C2=A0/* write config pci function0 registers. PCI-ISA bridge */<br>
-static void vt82c686b_write_config(<wbr>PCIDevice * d, uint32_t address,<b=
r>
+static void vt82c686b_write_config(<wbr>PCIDevice *d, uint32_t address,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t val, int len)=
<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VT82C686BState *vt686 =3D VT82C686B_DEVICE(d);<br>
@@ -365,7 +364,7 @@ static void vt82c686b_pm_realize(PCIDevice *dev, Error =
**errp)<br>
=C2=A0 =C2=A0 =C2=A0pci_set_long(pci_conf + 0x48, 0x00000001);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SMB ports:0xeee0~0xeeef */<br>
-=C2=A0 =C2=A0 s-&gt;smb_io_base =3D((s-&gt;smb_io_base &amp; 0xfff0) + 0x0=
);<br>
+=C2=A0 =C2=A0 s-&gt;smb_io_base =3D ((s-&gt;smb_io_base &amp; 0xfff0) + 0x=
0);<br>
=C2=A0 =C2=A0 =C2=A0pci_conf[0x90] =3D s-&gt;smb_io_base | 1;<br>
=C2=A0 =C2=A0 =C2=A0pci_conf[0x91] =3D s-&gt;smb_io_base &gt;&gt; 8;<br>
=C2=A0 =C2=A0 =C2=A0pci_conf[0xd2] =3D 0x90;<br>
@@ -462,16 +461,18 @@ static void vt82c686b_realize(PCIDevice *d, Error **e=
rrp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0wmask =3D d-&gt;wmask;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0x00; i &lt; 0xff; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i&lt;=3D0x03 || (i&gt;=3D0x08 &amp;&amp; i&=
lt;=3D0x3f)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wmask[i] =3D 0x00;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &lt;=3D 0x03 || (i &gt;=3D 0x08 &amp;&am=
p; i &lt;=3D 0x3f)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wmask[i] =3D 0x00;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;vt82c-&gt;<wbr>superio, OBJE=
CT(d), &amp;superio_ops,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;vt82c-&gt;superio_conf, &quot;superio&quot;, 2=
);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_set_enabled(&amp;<wbr>vt82c-&gt;superio, =
false);<br>
-=C2=A0 =C2=A0 /* The floppy also uses 0x3f0 and 0x3f1.<br>
-=C2=A0 =C2=A0 =C2=A0* But we do not emulate a floppy, so just set it here.=
 */<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The floppy also uses 0x3f0 and 0x3f1.<br>
+=C2=A0 =C2=A0 =C2=A0* But we do not emulate a floppy, so just set it here.=
<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>isa_bus-&gt;address_sp=
ace_io, 0x3f0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;vt82c-&gt;superio);<br>
=C2=A0}<br>
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c<br>
index ceee463..4692d41 100644<br>
--- a/hw/pci-host/bonito.c<br>
+++ b/hw/pci-host/bonito.c<br>
@@ -14,7 +14,8 @@<br>
=C2=A0 * fulong 2e mini pc has a bonito north bridge.<br>
=C2=A0 */<br>
<br>
-/* what is the meaning of devfn in qemu and IDSEL in bonito northbridge?<b=
r>
+/*<br>
+ * what is the meaning of devfn in qemu and IDSEL in bonito northbridge?<b=
r>
=C2=A0 *<br>
=C2=A0 * devfn=C2=A0 =C2=A0pci_slot&lt;&lt;3=C2=A0 + funno<br>
=C2=A0 * one pci bus can have 32 devices and each device can have 8 functio=
ns.<br>
@@ -49,7 +50,7 @@<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;exec/address-spaces.h&quot;<br>
<br>
-//#define DEBUG_BONITO<br>
+/* #define DEBUG_BONITO */<br>
<br>
=C2=A0#ifdef DEBUG_BONITO<br>
=C2=A0#define DPRINTF(fmt, ...) fprintf(stderr, &quot;%s: &quot; fmt, __fun=
c__, ##__VA_ARGS__)<br>
@@ -60,45 +61,45 @@<br>
=C2=A0/* from linux soure code. include/asm-mips/mips-boards/<wbr>bonito64.=
h*/<br>
=C2=A0#define BONITO_BOOT_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1fc00000<br>
=C2=A0#define BONITO_BOOT_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00100000<br>
-#define BONITO_BOOT_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_BOOT_BASE=
+BONITO_BOOT_<wbr>SIZE-1)<br>
+#define BONITO_BOOT_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_BOOT_BASE=
 + BONITO_BOOT_SIZE - 1)<br>
=C2=A0#define BONITO_FLASH_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x1c000000<br>
=C2=A0#define BONITO_FLASH_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x03000000<br>
-#define BONITO_FLASH_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_FLASH_BASE+BON=
ITO_<wbr>FLASH_SIZE-1)<br>
+#define BONITO_FLASH_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_FLASH_BASE + B=
ONITO_FLASH_SIZE - 1)<br>
=C2=A0#define BONITO_SOCKET_BASE=C2=A0 =C2=A0 =C2=A0 0x1f800000<br>
=C2=A0#define BONITO_SOCKET_SIZE=C2=A0 =C2=A0 =C2=A0 0x00400000<br>
-#define BONITO_SOCKET_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_SOCKET_BASE+BO=
NITO_<wbr>SOCKET_SIZE-1)<br>
+#define BONITO_SOCKET_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_SOCKET_BASE + =
BONITO_SOCKET_SIZE - 1)<br>
=C2=A0#define BONITO_REG_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1fe00000<b=
r>
=C2=A0#define BONITO_REG_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00040000<b=
r>
-#define BONITO_REG_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_REG_BASE+=
BONITO_REG_<wbr>SIZE-1)<br>
+#define BONITO_REG_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_REG_BASE =
+ BONITO_REG_SIZE - 1)<br>
=C2=A0#define BONITO_DEV_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1ff00000<b=
r>
=C2=A0#define BONITO_DEV_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00100000<b=
r>
-#define BONITO_DEV_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_DEV_BASE+=
BONITO_DEV_<wbr>SIZE-1)<br>
+#define BONITO_DEV_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_DEV_BASE =
+ BONITO_DEV_SIZE - 1)<br>
=C2=A0#define BONITO_PCILO_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x10000000<br>
=C2=A0#define BONITO_PCILO_BASE_VA=C2=A0 =C2=A0 0xb0000000<br>
=C2=A0#define BONITO_PCILO_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x0c000000<br>
-#define BONITO_PCILO_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCILO_BASE+BON=
ITO_<wbr>PCILO_SIZE-1)<br>
+#define BONITO_PCILO_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCILO_BASE + B=
ONITO_PCILO_SIZE - 1)<br>
=C2=A0#define BONITO_PCILO0_BASE=C2=A0 =C2=A0 =C2=A0 0x10000000<br>
=C2=A0#define BONITO_PCILO1_BASE=C2=A0 =C2=A0 =C2=A0 0x14000000<br>
=C2=A0#define BONITO_PCILO2_BASE=C2=A0 =C2=A0 =C2=A0 0x18000000<br>
=C2=A0#define BONITO_PCIHI_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x20000000<br>
=C2=A0#define BONITO_PCIHI_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x20000000<br>
-#define BONITO_PCIHI_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCIHI_BASE+BON=
ITO_<wbr>PCIHI_SIZE-1)<br>
+#define BONITO_PCIHI_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCIHI_BASE + B=
ONITO_PCIHI_SIZE - 1)<br>
=C2=A0#define BONITO_PCIIO_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x1fd00000<br>
=C2=A0#define BONITO_PCIIO_BASE_VA=C2=A0 =C2=A0 0xbfd00000<br>
=C2=A0#define BONITO_PCIIO_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x00010000<br>
-#define BONITO_PCIIO_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCIIO_BASE+BON=
ITO_<wbr>PCIIO_SIZE-1)<br>
+#define BONITO_PCIIO_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_PCIIO_BASE + B=
ONITO_PCIIO_SIZE - 1)<br>
=C2=A0#define BONITO_PCICFG_BASE=C2=A0 =C2=A0 =C2=A0 0x1fe80000<br>
=C2=A0#define BONITO_PCICFG_SIZE=C2=A0 =C2=A0 =C2=A0 0x00080000<br>
-#define BONITO_PCICFG_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_PCICFG_BASE+BO=
NITO_<wbr>PCICFG_SIZE-1)<br>
+#define BONITO_PCICFG_TOP=C2=A0 =C2=A0 =C2=A0 =C2=A0(BONITO_PCICFG_BASE + =
BONITO_PCICFG_SIZE - 1)<br>
<br>
<br>
=C2=A0#define BONITO_PCICONFIGBASE=C2=A0 =C2=A0 0x00<br>
=C2=A0#define BONITO_REGBASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x100<br>
<br>
-#define BONITO_PCICONFIG_BASE=C2=A0 =C2=A0(BONITO_PCICONFIGBASE+BONITO_<wb=
r>REG_BASE)<br>
+#define BONITO_PCICONFIG_BASE=C2=A0 =C2=A0(BONITO_PCICONFIGBASE + BONITO_R=
EG_BASE)<br>
=C2=A0#define BONITO_PCICONFIG_SIZE=C2=A0 =C2=A0(0x100)<br>
<br>
-#define BONITO_INTERNAL_REG_BASE=C2=A0 (BONITO_REGBASE+BONITO_REG_<wbr>BAS=
E)<br>
+#define BONITO_INTERNAL_REG_BASE=C2=A0 (BONITO_REGBASE + BONITO_REG_BASE)<=
br>
=C2=A0#define BONITO_INTERNAL_REG_SIZE=C2=A0 (0x70)<br>
<br>
=C2=A0#define BONITO_SPCICONFIG_BASE=C2=A0 (BONITO_PCICFG_BASE)<br>
@@ -111,7 +112,7 @@<br>
<br>
=C2=A0#define BONITO_BONPONCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x00 &gt;&gt; 2)=
=C2=A0 =C2=A0 =C2=A0 /* 0x100 */<br>
=C2=A0#define BONITO_BONGENCFG_OFFSET 0x4<br>
-#define BONITO_BONGENCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_BONGENCFG_OFFS=
ET&gt;&gt;2)=C2=A0 =C2=A0/*0x104 */<br>
+#define BONITO_BONGENCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 (BONITO_BONGENCFG_OFFS=
ET &gt;&gt; 2)=C2=A0 =C2=A0/*0x104 */<br>
<br>
=C2=A0/* 2. IO &amp; IDE configuration */<br>
=C2=A0#define BONITO_IODEVCFG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x08 &gt;&g=
t; 2)=C2=A0 =C2=A0 =C2=A0 /* 0x108 */<br>
@@ -177,15 +178,15 @@<br>
=C2=A0/* idsel BIT =3D pci slot number +12 */<br>
=C2=A0#define PCI_SLOT_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 12<br>
=C2=A0#define PCI_IDSEL_VIA686B_BIT=C2=A0 =C2=A0 =C2=A0 (17)<br>
-#define PCI_IDSEL_VIA686B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;PCI_=
IDSEL_VIA686B_BIT)<br>
+#define PCI_IDSEL_VIA686B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; PC=
I_IDSEL_VIA686B_BIT)<br>
<br>
-#define PCI_ADDR(busno,devno,funno,<wbr>regno)=C2=A0 \<br>
-=C2=A0 =C2=A0 ((((busno)&lt;&lt;16)&amp;0xff0000) + (((devno)&lt;&lt;11)&a=
mp;0xf800) + (((funno)&lt;&lt;8)&amp;0x700) + (regno))<br>
+#define PCI_ADDR(busno , devno , funno , regno)=C2=A0 \<br>
+=C2=A0 =C2=A0 ((((busno) &lt;&lt; 16) &amp; 0xff0000) + (((devno) &lt;&lt;=
 11) &amp; 0xf800) + \<br>
+=C2=A0 =C2=A0 (((funno) &lt;&lt; 8) &amp; 0x700) + (regno))<br>
<br>
=C2=A0typedef struct BonitoState BonitoState;<br>
<br>
-typedef struct PCIBonitoState<br>
-{<br>
+typedef struct PCIBonitoState {<br>
=C2=A0 =C2=A0 =C2=A0PCIDevice dev;<br>
<br>
=C2=A0 =C2=A0 =C2=A0BonitoState *pcihost;<br>
@@ -239,7 +240,8 @@ static void bonito_writel(void *opaque, hwaddr addr,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0saddr =3D addr &gt;&gt; 2;<br>
<br>
-=C2=A0 =C2=A0 DPRINTF(&quot;bonito_writel &quot;TARGET_FMT_plx&quot; val %=
x saddr %x\n&quot;, addr, val, saddr);<br>
+=C2=A0 =C2=A0 DPRINTF(&quot;bonito_writel &quot;TARGET_FMT_plx&quot; val %=
x saddr %x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr, val, saddr);<br>
=C2=A0 =C2=A0 =C2=A0switch (saddr) {<br>
=C2=A0 =C2=A0 =C2=A0case BONITO_BONPONCFG:<br>
=C2=A0 =C2=A0 =C2=A0case BONITO_IODEVCFG:<br>
@@ -363,7 +365,7 @@ static uint64_t bonito_ldma_readl(void *opaque, hwaddr =
addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 val =3D ((uint32_t *)(&amp;s-&gt;bonldma))[addr/sizeof(<wbr>=
uint32_t)];<br>
+=C2=A0 =C2=A0 val =3D ((uint32_t *)(&amp;s-&gt;bonldma))[addr / sizeof(uin=
t32_t)];<br>
<br>
=C2=A0 =C2=A0 =C2=A0return val;<br>
=C2=A0}<br>
@@ -377,7 +379,7 @@ static void bonito_ldma_writel(void *opaque, hwaddr add=
r,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ((uint32_t *)(&amp;s-&gt;bonldma))[addr/sizeof(<wbr>uint32_t=
)] =3D val &amp; 0xffffffff;<br>
+=C2=A0 =C2=A0 ((uint32_t *)(&amp;s-&gt;bonldma))[addr / sizeof(uint32_t)] =
=3D val &amp; 0xffffffff;<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps bonito_ldma_ops =3D {<br>
@@ -400,7 +402,7 @@ static uint64_t bonito_cop_readl(void *opaque, hwaddr a=
ddr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 val =3D ((uint32_t *)(&amp;s-&gt;boncop))[addr/sizeof(<wbr>u=
int32_t)];<br>
+=C2=A0 =C2=A0 val =3D ((uint32_t *)(&amp;s-&gt;boncop))[addr / sizeof(uint=
32_t)];<br>
<br>
=C2=A0 =C2=A0 =C2=A0return val;<br>
=C2=A0}<br>
@@ -414,7 +416,7 @@ static void bonito_cop_writel(void *opaque, hwaddr addr=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 ((uint32_t *)(&amp;s-&gt;boncop))[addr/sizeof(<wbr>uint32_t)=
] =3D val &amp; 0xffffffff;<br>
+=C2=A0 =C2=A0 ((uint32_t *)(&amp;s-&gt;boncop))[addr / sizeof(uint32_t)] =
=3D val &amp; 0xffffffff;<br>
=C2=A0}<br>
<br>
=C2=A0static const MemoryRegionOps bonito_cop_ops =3D {<br>
@@ -446,7 +448,8 @@ static uint32_t bonito_sbridge_pciaddr(void *opaque, hw=
addr addr)<br>
=C2=A0 =C2=A0 =C2=A0cfgaddr =3D addr &amp; 0xffff;<br>
=C2=A0 =C2=A0 =C2=A0cfgaddr |=3D (s-&gt;regs[BONITO_PCIMAP_CFG] &amp; 0xfff=
f) &lt;&lt; 16;<br>
<br>
-=C2=A0 =C2=A0 idsel =3D (cfgaddr &amp; BONITO_PCICONF_IDSEL_MASK) &gt;&gt;=
 BONITO_PCICONF_IDSEL_OFFSET;<br>
+=C2=A0 =C2=A0 idsel =3D (cfgaddr &amp; BONITO_PCICONF_IDSEL_MASK) &gt;&gt;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BONITO_PCICONF_IDSEL_OFFSE=
T;<br>
=C2=A0 =C2=A0 =C2=A0devno =3D ctz32(idsel);<br>
=C2=A0 =C2=A0 =C2=A0funno =3D (cfgaddr &amp; BONITO_PCICONF_FUN_MASK) &gt;&=
gt; BONITO_PCICONF_FUN_OFFSET;<br>
=C2=A0 =C2=A0 =C2=A0regno =3D (cfgaddr &amp; BONITO_PCICONF_REG_MASK) &gt;&=
gt; BONITO_PCICONF_REG_OFFSET;<br>
@@ -550,7 +553,7 @@ static void pci_bonito_set_irq(void *opaque, int irq_nu=
m, int level)<br>
=C2=A0}<br>
<br>
=C2=A0/* map the original irq (0~3) to bonito irq (16~47, but 16~31 are unu=
sed) */<br>
-static int pci_bonito_map_irq(PCIDevice * pci_dev, int irq_num)<br>
+static int pci_bonito_map_irq(PCIDevice *pci_dev, int irq_num)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int slot;<br>
<br>
@@ -618,7 +621,10 @@ static void bonito_realize(PCIDevice *dev, Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice *sysbus =3D SYS_BUS_DEVICE(s-&gt;pcihost);=
<br>
=C2=A0 =C2=A0 =C2=A0PCIHostState *phb =3D PCI_HOST_BRIDGE(s-&gt;pcihost);<b=
r>
<br>
-=C2=A0 =C2=A0 /* Bonito North Bridge, built on FPGA, VENDOR_ID/DEVICE_ID a=
re &quot;undefined&quot; */<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Bonito North Bridge, built on FPGA,<br>
+=C2=A0 =C2=A0 =C2=A0* VENDOR_ID/DEVICE_ID are &quot;undefined&quot;<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0pci_config_set_prog_interface(<wbr>dev-&gt;config, 0x00=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set the north bridge register mapping */<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--000000000000281c4e0598ad1e95--

