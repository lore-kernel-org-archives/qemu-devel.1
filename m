Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D389C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E457E20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E457E20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is1E5-0002AE-NL
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1is1D2-0001iT-9Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1is1Cy-0002Ho-1H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:13:00 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38282
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1is1Cx-0002H6-Qt
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 04:12:55 -0500
Received: from host86-191-119-91.range86-191.btcentralplus.com
 ([86.191.119.91] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1is1Cu-0005l3-8J; Thu, 16 Jan 2020 09:12:54 +0000
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-74-git-send-email-imammedo@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <09d4677e-60b7-f88c-30ed-eb6ffcad5c1f@ilande.co.uk>
Date: Thu, 16 Jan 2020 09:12:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-74-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.191.119.91
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 73/86] sparc:sun4m: use memdev for RAM
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: No (on mail.default.ilande.uk0.bigv.io); Unknown failure
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41c9:1:41f::167
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
Cc: atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/01/2020 15:07, Igor Mammedov wrote:

> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Patch moves ram size check into sun4m_hw_init() and drops
> ram_init() moving remainder to sun4m_hw_init() as well,
> as it was the only place that called it.
> 
> Also it rewrites impl. of RamDevice a little bit, which
> could serve as an example of frontend device for RAM backend.
> (Caveats are:
>   1. it doesn't check for memdev backend being mapped
>      since it's been  usurped by generic machine to handle
>      majority of machines which don't have RAM frontend device
>   2. it still lacks 'addr' property and still has hardcoded
>      sysbus_mmio_map() in board init. If done right, board should
>      set 'addr' property and bus/machine plug handler should map
>      it during device realize time.
> )
> Further improvements were left as exercise for the future,
> since frontends are out scope of RAM conversion to memdev.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: mark.cave-ayland@ilande.co.uk
> CC: atar4qemu@gmail.com
> ---
>  hw/sparc/sun4m.c | 73 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 2aaa5bf..834ad2a 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -777,63 +777,42 @@ static const TypeInfo prom_info = {
>  
>  typedef struct RamDevice {
>      SysBusDevice parent_obj;
> -
> -    MemoryRegion ram;
> -    uint64_t size;
> +    HostMemoryBackend *memdev;
>  } RamDevice;
>  
>  /* System RAM */
>  static void ram_realize(DeviceState *dev, Error **errp)
>  {
>      RamDevice *d = SUN4M_RAM(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    MemoryRegion *ram = host_memory_backend_get_memory(d->memdev);
>  
> -    memory_region_allocate_system_memory(&d->ram, OBJECT(d), "sun4m.ram",
> -                                         d->size);
> -    sysbus_init_mmio(sbd, &d->ram);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), ram);
>  }
>  
> -static void ram_init(hwaddr addr, ram_addr_t RAM_size,
> -                     uint64_t max_mem)
> +static void ram_initfn(Object *obj)
>  {
> -    DeviceState *dev;
> -    SysBusDevice *s;
> -    RamDevice *d;
> -
> -    /* allocate RAM */
> -    if ((uint64_t)RAM_size > max_mem) {
> -        error_report("Too much memory for this machine: %" PRId64 ","
> -                     " maximum %" PRId64,
> -                     RAM_size / MiB, max_mem / MiB);
> -        exit(1);
> -    }
> -    dev = qdev_create(NULL, "memory");
> -    s = SYS_BUS_DEVICE(dev);
> -
> -    d = SUN4M_RAM(dev);
> -    d->size = RAM_size;
> -    qdev_init_nofail(dev);
> -
> -    sysbus_mmio_map(s, 0, addr);
> +    RamDevice *d = SUN4M_RAM(obj);
> +    object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
> +                             (Object **)&d->memdev,
> +                             object_property_allow_set_link,
> +                             OBJ_PROP_LINK_STRONG, &error_abort);
> +    object_property_set_description(obj, "memdev", "Set RAM backend"
> +                                    "Valid value is ID of a hostmem backend",
> +                                     &error_abort);
>  }
>  
> -static Property ram_properties[] = {
> -    DEFINE_PROP_UINT64("size", RamDevice, size, 0),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void ram_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = ram_realize;
> -    dc->props = ram_properties;
>  }
>  
>  static const TypeInfo ram_info = {
>      .name          = TYPE_SUN4M_MEMORY,
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(RamDevice),
> +    .instance_init = ram_initfn,
>      .class_init    = ram_class_init,
>  };
>  
> @@ -880,6 +859,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      unsigned int smp_cpus = machine->smp.cpus;
>      unsigned int max_cpus = machine->smp.max_cpus;
>  
> +    if (machine->ram_size > hwdef->max_mem) {
> +        error_report("Too much memory for this machine: %" PRId64 ","
> +                     " maximum %" PRId64,
> +                     machine->ram_size / MiB, hwdef->max_mem / MiB);
> +        exit(1);
> +    }
> +
>      /* init CPUs */
>      for(i = 0; i < smp_cpus; i++) {
>          cpu_devinit(machine->cpu_type, i, hwdef->slavio_base, &cpu_irqs[i]);
> @@ -888,9 +874,13 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>      for (i = smp_cpus; i < MAX_CPUS; i++)
>          cpu_irqs[i] = qemu_allocate_irqs(dummy_cpu_set_irq, NULL, MAX_PILS);
>  
> +    /* Create and map RAM frontend */
> +    dev = qdev_create(NULL, "memory");
> +    object_property_set_link(OBJECT(dev), OBJECT(machine->ram_memdev),
> +                             "memdev", &error_fatal);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
>  
> -    /* set up devices */
> -    ram_init(0, machine->ram_size, hwdef->max_mem);
>      /* models without ECC don't trap when missing ram is accessed */
>      if (!hwdef->ecc_base) {
>          empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
> @@ -1078,7 +1068,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
>  
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
> -    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_DEPTH, graphic_depth);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_WIDTH, graphic_width);
> @@ -1415,6 +1405,7 @@ static void ss5_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss5_type = {
> @@ -1434,6 +1425,7 @@ static void ss10_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss10_type = {
> @@ -1453,6 +1445,7 @@ static void ss600mp_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss600mp_type = {
> @@ -1472,6 +1465,7 @@ static void ss20_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-SuperSparc-II");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss20_type = {
> @@ -1490,6 +1484,7 @@ static void voyager_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo voyager_type = {
> @@ -1508,6 +1503,7 @@ static void ss_lx_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss_lx_type = {
> @@ -1526,6 +1522,7 @@ static void ss4_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo ss4_type = {
> @@ -1544,6 +1541,7 @@ static void scls_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo scls_type = {
> @@ -1562,6 +1560,7 @@ static void sbook_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "c";
>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-MicroSparc-I");
>      mc->default_display = "tcx";
> +    mc->default_ram_id = "sun4m.ram";
>  }
>  
>  static const TypeInfo sbook_type = {

As you say it's a little bit more complicated here, however it looks sensible to me.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

