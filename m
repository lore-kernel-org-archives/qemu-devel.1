Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B2CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D57A206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hj0KQ0Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D57A206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISsy-0001hB-D0
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISii-0004kE-3R; Wed, 16 Sep 2020 04:23:16 -0400
Received: from ozlabs.org ([203.11.71.1]:38907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kISig-0005FH-32; Wed, 16 Sep 2020 04:23:15 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BrtQH728Yz9sTs; Wed, 16 Sep 2020 18:23:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1600244583;
 bh=7crGrX784o8VR9fYf+XTvBKCri4oNb6QzGod350j46U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hj0KQ0Yx0xPvzTVcsA0v5kRXiOJPNnOQcL1/vt1t9D8zAYVCwB009kN43+TUx1Rs0
 SpiIy0Vm4mPlMhAXy5IeXjNYXczhsQuaSaETZ7hm7nrJCYyMDbTZUVbvmAkbkW2hZd
 Mqih3hxCsshwLM9HYe541RZnWXvWFeag2Oq6HuHQ=
Date: Wed, 16 Sep 2020 12:50:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
Message-ID: <20200916025022.GE5258@yekko.fritz.box>
References: <20200914102425.1152962-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Content-Disposition: inline
In-Reply-To: <20200914102425.1152962-1-f4bug@amsat.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 04:23:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 12:24:25PM +0200, Philippe Mathieu-Daud=E9 wrote:
> As the 'io_base' argument of m48t59_init() is unused (set to 0),
> remove it to simplify.
> To create a device on the ISA bus, m48t59_init_isa() is the
> preferred function to use.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  include/hw/rtc/m48t59.h |  2 +-
>  hw/ppc/ppc405_boards.c  |  2 +-
>  hw/rtc/m48t59.c         | 10 ++--------
>  hw/sparc/sun4m.c        |  2 +-
>  hw/sparc64/sun4u.c      |  2 +-
>  5 files changed, 6 insertions(+), 12 deletions(-)

ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
> index 04abedf3b2b..62297ee0db1 100644
> --- a/include/hw/rtc/m48t59.h
> +++ b/include/hw/rtc/m48t59.h
> @@ -50,7 +50,7 @@ struct NvramClass {
>  Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
>                         int base_year, int type);
>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint32_t io_base, uint16_t size, int base_year,
> +                   uint16_t size, int base_year,
>                     int type);
> =20
>  #endif /* HW_M48T59_H */
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 6198ec1035b..93ffee801a3 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
>      /* Register FPGA */
>      ref405ep_fpga_init(sysmem, 0xF0300000);
>      /* Register NVRAM */
> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
> +    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
>      /* Load kernel */
>      linux_boot =3D (kernel_filename !=3D NULL);
>      if (linux_boot) {
> diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
> index 6525206976b..2d6a095c4e4 100644
> --- a/hw/rtc/m48t59.c
> +++ b/hw/rtc/m48t59.c
> @@ -566,7 +566,7 @@ const MemoryRegionOps m48t59_io_ops =3D {
> =20
>  /* Initialisation routine */
>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> -                   uint32_t io_base, uint16_t size, int base_year,
> +                   uint16_t size, int base_year,
>                     int model)
>  {
>      DeviceState *dev;
> @@ -584,13 +584,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
>          s =3D SYS_BUS_DEVICE(dev);
>          sysbus_realize_and_unref(s, &error_fatal);
>          sysbus_connect_irq(s, 0, IRQ);
> -        if (io_base !=3D 0) {
> -            memory_region_add_subregion(get_system_io(), io_base,
> -                                        sysbus_mmio_get_region(s, 1));
> -        }
> -        if (mem_base !=3D 0) {
> -            sysbus_mmio_map(s, 0, mem_base);
> -        }
> +        sysbus_mmio_map(s, 0, mem_base);
> =20
>          return NVRAM(s);
>      }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 947b69d1597..56a0d38f274 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -970,7 +970,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
>          create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
>      }
> =20
> -    nvram =3D m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1=
968, 8);
> +    nvram =3D m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968=
, 8);
> =20
>      slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cp=
u_irq, smp_cpus);
> =20
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b4aabfc076f..1cc57b030a7 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -675,7 +675,7 @@ static void sun4uv_init(MemoryRegion *address_space_m=
em,
>      pci_ide_create_devs(pci_dev);
> =20
>      /* Map NVRAM into I/O (ebus) space */
> -    nvram =3D m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
> +    nvram =3D m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
>      s =3D SYS_BUS_DEVICE(nvram);
>      memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>                                  sysbus_mmio_get_region(s, 0));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9hfW4ACgkQbDjKyiDZ
s5IV/BAAjXVTtfVkiyfGVtxJFGfYhd1uOef7EUmCXuB1FRxUwOyHhqgQdHubeXGi
anlq4rVhM9rR0D9kuRtzMC1ARA6eVrMkYIeikoYdwdXN7rwjyvHMsKEkMQ0s2LB4
XxA3lVuPSgrF2Fh6/xxM5ay3KCr8DxIR2/cmqV7EIww9eUMc94iNSeOtCGlcwqsG
XKBA+WOTvnNGIdmIAUbs6rUtLUrq6f3SzD9CMY+kssES5l6g8ES8r1bvyy9+HS4l
f3EaPhmZxOxnVCOdArUW0P6HHfgJcvBuDB2e9I1IvM6hMciAZXKfS77OW3ivFQko
rHCRTVSn6dC3An/KqS8d5h3HCLVduhCSs3L59TkXQKjIha7dEwfnbJOeYMkq1csD
FuDjcSIVAY79orbaGmi/WtSTm8tAnCAhDsHFWrVQ/YDb1DkMsn64JDaIcMwcmoAs
WgWctM8ESi94R/MwdSZSYJFmrOo9Lob2Y4uoTCwzbj/Gv/mxLdjvD6FgmyyWdK5A
E9WaBimzjNNY+T8+XoL82KWNEFoqiYKAA7iQarnQPqt1YD0rsQQGL73+C1/vzPaT
fxMUOlE6HjELYul26sSNo4Bvt8UlZtQpAX9suViTrQR/w1bDW0zHihqsVHME58dJ
7X/FFtp6fqOwGCaoBln608t0a1t4cNqZxGklXGhW6iDq9kt3iGo=
=SU0y
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--

