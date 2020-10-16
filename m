Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64190C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 01:41:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C6420789
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 01:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BhfgFO2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C6420789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTEk6-0007uI-BQ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 21:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTEjB-0007NX-Uj; Thu, 15 Oct 2020 21:40:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34099 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTEj8-0000K2-Oe; Thu, 15 Oct 2020 21:40:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC83W1YD1z9sTD; Fri, 16 Oct 2020 12:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602812407;
 bh=JqBp0wFPBsIZmsCG3bs0mT/7BuYJTZZoQh/6ez71pJI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BhfgFO2gFjCNgiiN4byyRr/A59+bUNcZTlsDmMv/h8GysemsuIlbbbytMpsBvN6yn
 tRwlX9Clf8RSBWM4ugkDhbst/OwB+mjHGpsk9/Mf7EixR5bZXbMMWotcTVImX5KL6a
 /WMVXvr2J2vkY+uCrmxrxWSWDWu7iF4UL8D24Qew=
Date: Fri, 16 Oct 2020 11:44:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 2/2] hw/rtc/m48t59: Simplify m48t59_init() passing
 MemoryRegion argument
Message-ID: <20201016004457.GH7078@yekko.fritz.box>
References: <20201015194647.477252-1-f4bug@amsat.org>
 <20201015194647.477252-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20201015194647.477252-3-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:30:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 09:46:47PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Pass a MemoryRegion* to m48t59_init(), directly call
> memory_region_add_subregion() instead of sysbus_mmio_map().
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/rtc/m48t59.h |  2 +-
>  hw/ppc/ppc405_boards.c  |  2 +-
>  hw/rtc/m48t59.c         | 10 +++-------
>  hw/sparc/sun4m.c        |  3 ++-
>  hw/sparc64/sun4u.c      |  7 ++-----
>  5 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> index d99dda2b7de..3c337e8171c 100644
> --- a/include/hw/rtc/m48t59.h
> +++ b/include/hw/rtc/m48t59.h
> @@ -49,7 +49,7 @@ struct NvramClass {
> =20
>  Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
>                         int base_year, int type);
> -Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> +Nvram *m48t59_init(MemoryRegion *mr, hwaddr mem_base, qemu_irq IRQ,
>                     uint16_t size, int base_year, int model);
> =20
>  #endif /* HW_M48T59_H */
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 93ffee801a3..6ab1b860545 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
>      /* Register FPGA */
>      ref405ep_fpga_init(sysmem, 0xF0300000);
>      /* Register NVRAM */
> -    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
> +    m48t59_init(get_system_memory(), 0xF0000000, NULL, 8192, 1968, 8);
>      /* Load kernel */
>      linux_boot =3D (kernel_filename !=3D NULL);
>      if (linux_boot) {
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index 8b02c2ec558..7ec4b241218 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -565,9 +565,8 @@ const MemoryRegionOps m48t59_io_ops =3D {
>  };
> =20
>  /* Initialisation routine */
> -Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint16_t size, int base_year,
> -                   int model)
> +Nvram *m48t59_init(MemoryRegion *mr, hwaddr mem_base, qemu_irq IRQ,
> +                   uint16_t size, int base_year, int model)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -584,10 +583,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>          s =3D SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(s, &error_fatal);
>          sysbus_connect_irq(s, 0, IRQ);
> -        if (mem_base !=3D 0) {
> -            sysbus_mmio_map(s, 0, mem_base);
> -        }
> -
> +        memory_region_add_subregion(mr, mem_base, sysbus_mmio_get_region=
(s, 0));
>          return NVRAM(s);
>      }
> =20
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 20c1fa41192..aebe9e0df3d 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -966,7 +966,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>          create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>      }
> =20
> -    nvram =3D m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968=
, 8);
> +    nvram =3D m48t59_init(get_system_memory(), hwdef->nvram_base, slavio=
_irq[0],
> +                        0x2000, 1968, 8);
> =20
>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cp=
u_irq, smp_cpus);
> =20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 6854522bbfa..4c975c25274 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -561,7 +561,6 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
>      SabreState *sabre;
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
>      PCIDevice *ebus, *pci_dev;
> -    SysBusDevice *s;
>      DeviceState *iommu, *dev;
>      FWCfgState *fw_cfg;
>      NICInfo *nd;
> @@ -671,10 +670,8 @@ static void sun4uv_init(MemoryRegion *address_space_=
mem,
>      pci_ide_create_devs(pci_dev);
> =20
>      /* Map NVRAM into I/O (ebus) space */
> -    nvram =3D m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
> -    s =3D SYS_BUS_DEVICE(nvram);
> -    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
> -                                sysbus_mmio_get_region(s, 0));
> +    nvram =3D m48t59_init(pci_address_space_io(ebus), 0x2000, NULL,
> +                        NVRAM_SIZE, 1968, 59);
>  =20
>      initrd_size =3D 0;
>      initrd_addr =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I7QkACgkQbDjKyiDZ
s5KO4g//YPfxO0rdy0GrP2JkE3U77uBieYwN/80HS1Y8kiwJ8Jhw2Ta2YCZTRTH+
Z2c7eEUFjrZTynM0GBjtC1EfJaHbPITnde4BgJC+pqgMJcrFSZXcfRnhKkSKBCz0
40NQIO6EFN8i9KUCnhl0xZa/r9BeQP5ZF7O4zmlTGcfIEJSkwG45LlyLEkPUzOL9
gZCi7qPFBdOEqShae7rYCHo56QF+AdTztqKpjW9eGzEqyO5+Wv+ak9cQH0xyKaoN
FMgTu9od3EPRH4OUifjxK4gizelySV07zGbR5LiHzAlfu56KYNRobJiszDgyG87K
IgpSuTvOV1Tpe1tiIB9qid3RIvl2dZzUMs8jfRsTMwoc1E1DOpoxgTLtt5IH2nsR
BJ4KH0OBtNVS9ad8/cgBOzoN0Mk8QsOk8m0BjMaGtXIRkyBm3Db3y6RsBC5Oaj5u
RX3J474eNFYiNuwCwrM/KK9NV5cISsc5JcPkPlgJdh7nTI136GsvO1YkUDUN+JUS
bSKT3CZLR7GvJQEs0jmCOkJPzQm5X6ztoiaa7an+7pMH3Io9X3KfSOBxhb/PcfzG
GLq61FSK9xwy3jUth34AWq6l44j8pqwmT4dFTG2z0wWkCHMcbYhBUYJodNCX2/Mj
1EHbvtkULw4qHiGczseGISf9HgHQJ2pVH3fvansydFlMXbJUPhs=
=HnW+
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--

