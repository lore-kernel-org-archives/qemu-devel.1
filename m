Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ED5CA9EAE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A23920679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 01:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lG+NNymc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A23920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMMDT-00034e-L8
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 21:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iMMBS-00011h-6B
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iMMBN-00020b-Dv
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 21:08:27 -0400
Received: from ozlabs.org ([203.11.71.1]:60927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iMMB1-0001mG-Qm; Sun, 20 Oct 2019 21:08:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46xJR01sX4z9sPT; Mon, 21 Oct 2019 12:07:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571620076;
 bh=M8UGZOaAiVqj2gy82UKp0dM4181PwyoTZGOXb2DUnBs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lG+NNymcXAuVo0+Rziv5z+nkQrO9eQy+Zfx1k1E1E4TT703iEUkFemWIMG7ww2ujJ
 Y///ohTHMFtLh4t68r/kMpG8/CS6CM8JH7wylxN+YdQRsA2m3UFDuWCed00hzNrQCF
 t5Nzb0F2flDd4au6EvrV/iWo/WuLpJRqw1/Wv7Ys=
Date: Mon, 21 Oct 2019 11:44:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 19/21] hw/ppc: Let the machine be the owner of the system
 memory
Message-ID: <20191021004414.GO1960@umbus.fritz.box>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-20-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rZHzn+A9B7nBTGyj"
Content-Disposition: inline
In-Reply-To: <20191020225650.3671-20-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rZHzn+A9B7nBTGyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 12:56:48AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/e500.c          | 3 ++-
>  hw/ppc/mac_newworld.c  | 3 ++-
>  hw/ppc/mac_oldworld.c  | 2 +-
>  hw/ppc/pnv.c           | 2 +-
>  hw/ppc/ppc405_boards.c | 6 +++---
>  hw/ppc/prep.c          | 3 ++-
>  hw/ppc/spapr.c         | 2 +-
>  hw/ppc/virtex_ml507.c  | 2 +-
>  8 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 91cd4c26f9..9c7be26248 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -912,7 +912,8 @@ void ppce500_init(MachineState *machine)
>      machine->ram_size =3D ram_size;
> =20
>      /* Register Memory */
> -    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram", ram=
_size);
> +    memory_region_allocate_system_memory(ram, machine, "mpc8544ds.ram",
> +                                         ram_size);
>      memory_region_add_subregion(address_space_mem, 0, ram);
> =20
>      dev =3D qdev_create(NULL, "e500-ccsr");
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index c5bbcc7433..8409114eed 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -152,7 +152,8 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ra=
m_size);
> +    memory_region_allocate_system_memory(ram, machine, "ppc_core99.ram",
> +                                         ram_size);
>      memory_region_add_subregion(get_system_memory(), 0, ram);
> =20
>      /* allocate and load BIOS */
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 0fa680b749..9dd645476a 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -127,7 +127,7 @@ static void ppc_heathrow_init(MachineState *machine)
>          exit(1);
>      }
> =20
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_heathrow.ram",
> +    memory_region_allocate_system_memory(ram, machine, "ppc_heathrow.ram=
",
>                                           ram_size);
>      memory_region_add_subregion(sysmem, 0, ram);
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7cf64b6d25..ac731c4f88 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -640,7 +640,7 @@ static void pnv_init(MachineState *machine)
>      }
> =20
>      ram =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
> +    memory_region_allocate_system_memory(ram, machine, "pnv.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(get_system_memory(), 0, ram);
> =20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 388cae0b43..8a2d2f4511 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -162,8 +162,8 @@ static void ref405ep_init(MachineState *machine)
>      MemoryRegion *sysmem =3D get_system_memory();
> =20
>      /* XXX: fix this */
> -    memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405e=
p.ram",
> -                                         0x08000000);
> +    memory_region_allocate_system_memory(&ram_memories[0], machine,
> +                                         "ef405ep.ram", 128 * MiB);
>      ram_bases[0] =3D 0;
>      ram_sizes[0] =3D 0x08000000;
>      memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
> @@ -427,7 +427,7 @@ static void taihu_405ep_init(MachineState *machine)
> =20
>      /* RAM is soldered to the board so the size cannot be changed */
>      ram_size =3D 0x08000000;
> -    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> +    memory_region_allocate_system_memory(ram, machine, "taihu_405ep.ram",
>                                           ram_size);
> =20
>      ram_bases[0] =3D 0;
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4f3c6bf190..54b00805e0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -445,7 +445,8 @@ static void ppc_prep_init(MachineState *machine)
>      }
> =20
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_=
size);
> +    memory_region_allocate_system_memory(ram, machine, "ppc_prep.ram",
> +                                         ram_size);
>      memory_region_add_subregion(sysmem, 0, ram);
> =20
>      if (linux_boot) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4eb97d3a9b..1f168edd43 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2840,7 +2840,7 @@ static void spapr_machine_init(MachineState *machin=
e)
>      }
> =20
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
> +    memory_region_allocate_system_memory(ram, machine, "ppc_spapr.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, 0, ram);
> =20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 68625522d8..86c9273dc0 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -224,7 +224,7 @@ static void virtex_init(MachineState *machine)
> =20
>      qemu_register_reset(main_cpu_reset, cpu);
> =20
> -    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size=
);
> +    memory_region_allocate_system_memory(phys_ram, machine, "ram", ram_s=
ize);
>      memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> =20
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rZHzn+A9B7nBTGyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2s/1sACgkQbDjKyiDZ
s5IXEBAA3UFr55JtIvkD0rAlvWpp03so7MHbpF/SrjSKiRtWkZWnDdsxEYajiGdM
EplD21UorhCGPxWKqQ4ryz+4t9Dmbygdmn760IWG/95fky29wH0/V2A6bddHhTdh
BUVrmKe0QAwXcA6mEDUHs9RhvKZVL3HCCdIHUQPLx0n/OaHnIZFeVI+g06gzQQEV
+5B+CS6XUVkE+u8W/8KzXIU3GgTc/5rx84IW6/sOZzhOqqS+F8Eu5a8rrHxhlKek
MCeU7Mz2Z8eaWvtHgw5tqvfIm8RcdBplJzE5EiNRW/E1pAUTngxAxGMS2F0yFhwN
Hx/NUzvVqXgjl4pX8eFaNHDZfEikEx8tjh3YyyYmSYg+/sOuqgVHiSTmsl2tiQA5
j1XdpSqZSgGXPP3wyOmRGYyIGarbqt721eULeVekCdjGnD7Ntc+/jZlyUta7fysz
9tbzYskMf9zzIPqzanIwqG9gSVKYJLG7WJ8lGHzXI5aKmKs1nVCyNj+fRVj7gcWs
hZlOOdiS4jj8S1jp8BnBkwXbOnCGtHv+TEwlYLIRhKOE7XqISrp1jJX4112EYWzI
UfQj9OLviqKirKDsFaGxto4J7Ufi10r6mTFENbXFqYLxAHXkUgwroowrglsmUaUz
z4/rCWslxo7TK+XXJ8YBZ3Ke1gOtX9beVxvyzSfdlEPaWod/+Qc=
=nXPs
-----END PGP SIGNATURE-----

--rZHzn+A9B7nBTGyj--

