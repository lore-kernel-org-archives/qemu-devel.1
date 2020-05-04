Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DADC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71EE206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlgXE82f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71EE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYjL-0006RO-04
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jVYT1-000404-U0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:36:55 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:39366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jVYT0-00023o-CI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:36:55 -0400
Received: by mail-io1-xd41.google.com with SMTP id w4so11712503ioc.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z7DhdbVuTWBeX+O4IPd0jTsuX2yd4sCb6clmYEE1/2Y=;
 b=nlgXE82f7j9kP+WX8XVKFvYdi+Bei6QtLD/bGWYqOs5xa2gOK2qYedOb4kwpYNNIWe
 UjDj+GHbPtqITCCjqm8/YBHYjrP1wksZ6GA3Uh9xNyaKVUWMRxC4gfMq1P5ja5YtOKFy
 oP9DpIlltRjra1LN6yaHicfgA5DA0HVDMwnpy8qUGoHTW5gWkVloupdNQWY6aTh5R3YD
 lZwrapJiwQQFv4wsMcY2GNByeymiyohY6ki6OJE/RZahpahMhdZiepk3j1YSb2x8XiQu
 5vzehZR+PV6Lpwj/uVoxEAM6bDqRyJKUF7GAxWlOGqFCAAM3D6AxRCirX/4gK6/ZatvO
 wMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z7DhdbVuTWBeX+O4IPd0jTsuX2yd4sCb6clmYEE1/2Y=;
 b=a8hUJuuSp51VbkvPjlvBg6MRZ+wNEAJU0FoEPPpJPy9MsunvTTH6MAnfesS0g+xbL4
 yhD+eh4ZqTkJx94t6IBcgsFMEORENyVExVh6EUpfgis3Z/NNLmJt7FZQb5SjvwwcP18a
 1Nx0yL/0RL2EEI20Vtc+tNPXfpetokz3GDKQAMtfitbFGd6Y021AXMoNHeofpckPxwYu
 K5hVBtX1+itaFq2i8MW40ugSK7R+CLFz5eSfjJgbh8c4pFBrnjWzTXawQeFIDbbnO/V0
 swc3zHjRvx5T0TthTNAFyLo+LG4Lx/OYvTvyml0BA/GDP2EZs7pZ8BQa29oIXiEG1d29
 nJ9Q==
X-Gm-Message-State: AGi0PubfBFFpn4jHNEZJmM5LYybZY+Wn2VO6Pj1iABCU4dl9Cd8NdrF6
 bCB9oE+PeIJmxnPqG16kbFtrV7PBGkBzw0wiCdA=
X-Google-Smtp-Source: APiQypI/2x+ooVsvfmTtWvfpWFQmLFmEX7KN3UuIFQbZR1+rjq/Nb+KNsXHA+PPOQK++HABjNmHkTp/zrsL9NPwFC9s=
X-Received: by 2002:a5e:d918:: with SMTP id n24mr14699845iop.28.1588588612306; 
 Mon, 04 May 2020 03:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200429030409.9406-1-gorbak25@gmail.com>
 <20200429030409.9406-3-gorbak25@gmail.com>
In-Reply-To: <20200429030409.9406-3-gorbak25@gmail.com>
From: Paul Durrant <xadimgnik@gmail.com>
Date: Mon, 4 May 2020 11:36:41 +0100
Message-ID: <CAAgS=SmOQqJco70uK5Ept=ex5nf6WsB2YO0EAnC7S=3ocnJ=6Q@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] Improve legacy vbios handling
To: Grzegorz Uriasz <gorbak25@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=xadimgnik@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Artur Puzio <artur@puzio.waw.pl>,
 Stefano Stabellini <sstabellini@kernel.org>, jakub@bartmin.ski,
 marmarek@invisiblethingslab.com, Anthony Perard <anthony.perard@citrix.com>,
 Jakub Nowak <j.nowak26@student.uw.edu.pl>,
 Xen-devel <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Grzegorz Uriasz <gorbak25@gmail.com>
> Sent: 29 April 2020 04:04
> To: qemu-devel@nongnu.org
> Cc: Grzegorz Uriasz <gorbak25@gmail.com>;
marmarek@invisiblethingslab.com; artur@puzio.waw.pl;
> jakub@bartmin.ski; j.nowak26@student.uw.edu.pl; Stefano Stabellini
<sstabellini@kernel.org>; Anthony
> Perard <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>;
xen-devel@lists.xenproject.org
> Subject: [PATCH v2 2/2] Improve legacy vbios handling
>
> The current method of getting the vbios is broken - it just isn't
working on any device I've tested -
> the reason
> for this is explained in the previous patch. The vbios is polymorphic
and getting a proper unmodified
> copy is
> often not possible without reverse engineering the firmware. We don't
need an unmodified copy for most
> purposes -
> an unmodified copy is only needed for initializing the bios framebuffer
and providing the bios with a
> corrupted
> copy of the rom won't do any damage as the bios will just ignore the
rom.
>
> After the i915 driver takes over the vbios is only needed for reading
some metadata/configuration
> stuff etc...
> I've tested that not having any kind of vbios in the guest actually
works fine but on older
> generations of IGD
> there are some slight hiccups. To maximize compatibility the best
approach is to just copy the results
> of the vbios
> execution directly to the guest. It turns out the vbios is always
present on an hardcoded memory range
> in a reserved
> memory range from real mode - all we need to do is to memcpy it into the
guest.
>
> The following patch does 2 things:
> 1) When pci_assign_dev_load_option_rom fails to read the vbios from
sysfs(this works only when the igd
> is not the
> boot gpu - this is unlikely to happen) it falls back to using /dev/mem
to copy the vbios directly to
> the guest.
> Using /dev/mem should be fine as there is more xen specific pci code
which also relies on /dev/mem.

Why bother with sysfs at all if it is unlikely to work?

> 2) When dealing with IGD in the more generic code we skip the allocation
of the rom resource - the
> reason for this is to prevent
> a malicious guest from modifying the vbios in the host -> this is needed
as someone might try to pwn
> the i915 driver in the host by doing so
> (attach igd to guest, guest modifies vbios, the guest is terminated and
the idg is reattached to the
> host, i915 driver in the host uses data from the modified vbios).
> This is also needed to not overwrite the proper shadow copy made before.
>
> I've tested this patch and it works fine - the guest isn't complaining
about the missing vbios tables
> and the pci config
> space in the guest looks fine.
>
> Signed-off-by: Grzegorz Uriasz <gorbak25@gmail.com>
> ---
>  hw/xen/xen_pt.c          |  8 +++++--
>  hw/xen/xen_pt_graphics.c | 48 +++++++++++++++++++++++++++++++++++++---
>  hw/xen/xen_pt_load_rom.c |  2 +-
>  3 files changed, 52 insertions(+), 6 deletions(-)
>
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index b91082cb8b..ffc3559dd4 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -483,8 +483,12 @@ static int
xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
>                     i, r->size, r->base_addr, type);
>      }
>
> -    /* Register expansion ROM address */
> -    if (d->rom.base_addr && d->rom.size) {
> +    /*
> +     * Register expansion ROM address. If we are dealing with a ROM
> +     * shadow copy for legacy vga devices then don't bother to map it
> +     * as previous code creates a proper shadow copy
> +     */
> +    if (d->rom.base_addr && d->rom.size &&
!(is_igd_vga_passthrough(d))) {

You don't need the brackets around is_igd_vga_passthrough()

  Paul


>          uint32_t bar_data = 0;
>
>          /* Re-set BAR reported by OS, otherwise ROM can't be read. */
> diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
> index a3bc7e3921..fe0ef2685c 100644
> --- a/hw/xen/xen_pt_graphics.c
> +++ b/hw/xen/xen_pt_graphics.c
> @@ -129,7 +129,7 @@ int xen_pt_unregister_vga_regions(XenHostPCIDevice
*dev)
>      return 0;
>  }
>
> -static void *get_vgabios(XenPCIPassthroughState *s, int *size,
> +static void *get_sysfs_vgabios(XenPCIPassthroughState *s, int *size,
>                         XenHostPCIDevice *dev)
>  {
>      return pci_assign_dev_load_option_rom(&s->dev, size,
> @@ -137,6 +137,45 @@ static void *get_vgabios(XenPCIPassthroughState *s,
int *size,
>                                            dev->dev, dev->func);
>  }
>
> +static void xen_pt_direct_vbios_copy(XenPCIPassthroughState *s, Error
**errp)
> +{
> +    int fd = -1;
> +    void *guest_bios = NULL;
> +    void *host_vbios = NULL;
> +    /* This is always 32 pages in the real mode reserved region */
> +    int bios_size = 32 << XC_PAGE_SHIFT;
> +    int vbios_addr = 0xc0000;
> +
> +    fd = open("/dev/mem", O_RDONLY);
> +    if (fd == -1) {
> +        error_setg(errp, "Can't open /dev/mem: %s", strerror(errno));
> +        return;
> +    }
> +    host_vbios = mmap(NULL, bios_size,
> +            PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, fd, vbios_addr);
> +    close(fd);
> +
> +    if (host_vbios == MAP_FAILED) {
> +        error_setg(errp, "Failed to mmap host vbios: %s",
strerror(errno));
> +        return;
> +    }
> +
> +    memory_region_init_ram(&s->dev.rom, OBJECT(&s->dev),
> +            "legacy_vbios.rom", bios_size, &error_abort);
> +    guest_bios = memory_region_get_ram_ptr(&s->dev.rom);
> +    memcpy(guest_bios, host_vbios, bios_size);
> +
> +    if (munmap(host_vbios, bios_size) == -1) {
> +        XEN_PT_LOG(&s->dev, "Failed to unmap host vbios: %s\n",
strerror(errno));
> +    }
> +
> +    cpu_physical_memory_write(vbios_addr, guest_bios, bios_size);
> +    memory_region_set_address(&s->dev.rom, vbios_addr);
> +    pci_register_bar(&s->dev, PCI_ROM_SLOT,
PCI_BASE_ADDRESS_SPACE_MEMORY, &s->dev.rom);
> +    s->dev.has_rom = true;
> +    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
> +}
> +
>  /* Refer to Seabios. */
>  struct rom_header {
>      uint16_t signature;
> @@ -179,9 +218,11 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s,
XenHostPCIDevice *dev,
>          return;
>      }
>
> -    bios = get_vgabios(s, &bios_size, dev);
> +    bios = get_sysfs_vgabios(s, &bios_size, dev);
>      if (!bios) {
> -        error_setg(errp, "VGA: Can't get VBIOS");
> +        XEN_PT_LOG(&s->dev, "Unable to get host VBIOS from sysfs - "
> +                            "falling back to a direct copy of memory
ranges\n");
> +        xen_pt_direct_vbios_copy(s, errp);
>          return;
>      }
>
> @@ -223,6 +264,7 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s,
XenHostPCIDevice *dev,
>
>      /* Currently we fixed this address as a primary for legacy BIOS. */
>      cpu_physical_memory_write(0xc0000, bios, bios_size);
> +    XEN_PT_LOG(&s->dev, "Legacy VBIOS registered\n");
>  }
>
>  uint32_t igd_read_opregion(XenPCIPassthroughState *s)
> diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
> index 9f100dc159..8cd9aa84dc 100644
> --- a/hw/xen/xen_pt_load_rom.c
> +++ b/hw/xen/xen_pt_load_rom.c
> @@ -65,7 +65,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
>          goto close_rom;
>      }
>
> -    pci_register_bar(dev, PCI_ROM_SLOT, 0, &dev->rom);
> +    pci_register_bar(dev, PCI_ROM_SLOT, PCI_BASE_ADDRESS_SPACE_MEMORY,
&dev->rom);
>      dev->has_rom = true;
>      *size = st.st_size;
>  close_rom:
> --
> 2.26.1

