Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CDFC2D0E6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:04:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35DE20737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0y33Y34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35DE20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDC6-0008OF-U2
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHD93-0004V8-JH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHD92-0000HQ-1Y
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:01:01 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:41494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHD91-0000H6-Ta; Wed, 25 Mar 2020 17:00:59 -0400
Received: by mail-ua1-x942.google.com with SMTP id f9so1317646uaq.8;
 Wed, 25 Mar 2020 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XfhENZ6t3ct9uVkcrH1JI6JP+JcsPr1A0NwiLry1SUw=;
 b=p0y33Y342ud6TlvVe77z31QRkRWr24mWTFf3ssm7x6VAbAC2dOxfu6W1bRjFKJzv03
 PM63hqjU6/sfybRR+32qyNrRpWPmFDFmcZ9R6NrgGCgpqYYz8APuZh02Z/BmINb4ayYh
 pEvrOkzyQsQ3yo4X7zxBiRerV30lSmK2v2EtKAUC9q3cHff4pKReQdNnv60Dv68zSyWc
 uxIIhz+/uvROFIadeyOQby0CuxCCHXNV/iwKLEU6VDa6KPu3sRIJEE54e20EVHf168fS
 18G4s8KriKwUbtZsFBrNzyRGPpIGrx3A9C0tBQ4jvkZivsOPmVSBMvH5BvNmW8YRYcIs
 7eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XfhENZ6t3ct9uVkcrH1JI6JP+JcsPr1A0NwiLry1SUw=;
 b=Ju8sGmeV6VmziZLs0ztrX8D0V46chd7EGQhNOct7hqESeU9jrjU4Y5WhEMiQ7iylKS
 r52T2U8ZN2oXfU0S3SJdIgEKifCS/0HiL1MUXOi1E1v4Gh3l5gjDk63p+lBTxXEp/U8D
 jOzGXOumJ3Rywh/n7as82pCfIdUBjFy/5gbhI2hZaG1O3H1ce3tUJdgseGkFCGYgP4PD
 KD07iBC/pYuH6My++R0Xfj64CUln8Adrgva2Po/boh2oG+QWGUVD5lf5f8PmPowXG/0/
 JHVWZsAGZue1ku9I5TofAzoPySu/H6Fkmv4Qd8mLHpJ5mS3ZAKWvK1vx9zy9p+raNoXp
 HTWQ==
X-Gm-Message-State: ANhLgQ2xevjmmd02mdvo4U7io4TFJwSKV26OGpvT1Y3Pb1JvooKoLKxM
 KMcpJ2tQWpUanFZsSQY+yGQq8+AUjXlS4Yy9wyU=
X-Google-Smtp-Source: ADFU+vvAB6SXwiNWokn1a2pZIgtrO+wuTwlRnmsHViF++X0/EeVpng7OJb8qnxm4rpkYO0pCHeipik574ReEcZKDY+Q=
X-Received: by 2002:ab0:143:: with SMTP id 61mr4044978uak.85.1585170059328;
 Wed, 25 Mar 2020 14:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-13-f4bug@amsat.org>
In-Reply-To: <20200325191830.16553-13-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2020 13:52:59 -0700
Message-ID: <CAKmqyKO6vKwnVOnVOJDNqw7_n-iUh8LyvGww=6h8E-H4OGtyWw@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 12/12] hw/riscv/sifive_u: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 12:28 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Running the coccinelle script produced:
>
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/object_property_missing_error_propagate.=
cocci \
>     --keep-comments --smpl-spacing --dir hw
>
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_bool() hw/riscv/sifive_u.c:558:4]]
>   [[manual check required: error_propagate() might be missing in object_p=
roperty_set_bool() hw/riscv/sifive_u.c:561:4]]
>
> Add the missing error_propagate() after manual review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 56351c4faa..01e44018cd 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -473,113 +473,121 @@ static void riscv_sifive_u_machine_instance_init(=
Object *obj)
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      SiFiveUSoCState *s =3D RISCV_U_SOC(dev);
>      const struct MemmapEntry *memmap =3D sifive_u_memmap;
>      MemoryRegion *system_memory =3D get_system_memory();
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem =3D g_new(MemoryRegion, 1);
>      qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
>      char *plic_hart_config;
>      size_t plic_hart_config_len;
>      int i;
>      Error *err =3D NULL;
>      NICInfo *nd =3D &nd_table[0];
>
>      object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
>                               &error_abort);
>      object_property_set_bool(OBJECT(&s->u_cpus), true, "realized",
>                               &error_abort);
>      /*
>       * The cluster must be realized after the RISC-V hart array containe=
r,
>       * as the container's CPU object is only created on realize, and the
>       * CPU must exist and have been parented into the cluster before the
>       * cluster is realized.
>       */
>      object_property_set_bool(OBJECT(&s->e_cluster), true, "realized",
>                               &error_abort);
>      object_property_set_bool(OBJECT(&s->u_cluster), true, "realized",
>                               &error_abort);
>
>      /* boot rom */
>      memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
>                             memmap[SIFIVE_U_MROM].size, &error_fatal);
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].bas=
e,
>                                  mask_rom);
>
>      /*
>       * Add L2-LIM at reset size.
>       * This should be reduced in size as the L2 Cache Controller WayEnab=
le
>       * register is incremented. Unfortunately I don't see a nice (or any=
) way
>       * to handle reducing or blocking out the L2 LIM while still allowin=
g it
>       * be re returned to all enabled after a reset. For the time being, =
just
>       * leave it enabled all the time. This won't break anything, but wil=
l be
>       * too generous to misbehaving guests.
>       */
>      memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
>                             memmap[SIFIVE_U_L2LIM].size, &error_fatal);
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].ba=
se,
>                                  l2lim_mem);
>
>      /* create PLIC hart topology configuration string */
>      plic_hart_config_len =3D (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1) *
>                             ms->smp.cpus;
>      plic_hart_config =3D g_malloc0(plic_hart_config_len);
>      for (i =3D 0; i < ms->smp.cpus; i++) {
>          if (i !=3D 0) {
>              strncat(plic_hart_config, "," SIFIVE_U_PLIC_HART_CONFIG,
>                      plic_hart_config_len);
>          } else {
>              strncat(plic_hart_config, "M", plic_hart_config_len);
>          }
>          plic_hart_config_len -=3D (strlen(SIFIVE_U_PLIC_HART_CONFIG) + 1=
);
>      }
>
>      /* MMIO */
>      s->plic =3D sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
>          plic_hart_config,
>          SIFIVE_U_PLIC_NUM_SOURCES,
>          SIFIVE_U_PLIC_NUM_PRIORITIES,
>          SIFIVE_U_PLIC_PRIORITY_BASE,
>          SIFIVE_U_PLIC_PENDING_BASE,
>          SIFIVE_U_PLIC_ENABLE_BASE,
>          SIFIVE_U_PLIC_ENABLE_STRIDE,
>          SIFIVE_U_PLIC_CONTEXT_BASE,
>          SIFIVE_U_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_U_PLIC].size);
>      g_free(plic_hart_config);
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART0_I=
RQ));
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_I=
RQ));
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
>          memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].b=
ase);
>
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].bas=
e);
>
>      for (i =3D 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
>          plic_gpios[i] =3D qdev_get_gpio_in(DEVICE(s->plic), i);
>      }
>
>      if (nd->used) {
>          qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>          qdev_set_nic_properties(DEVICE(&s->gem), nd);
>      }
>      object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
>                              &error_abort);
>      object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].bas=
e);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
>                         plic_gpios[SIFIVE_U_GEM_IRQ]);
>
>      create_unimplemented_device("riscv.sifive.u.gem-mgmt",
>          memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
>  }
> --
> 2.21.1
>
>

