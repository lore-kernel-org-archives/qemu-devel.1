Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE295C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B332206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Sf9Kx0i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B332206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwgJ-0001Gz-M4
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwfR-0000dJ-F1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwfQ-0001fk-20
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:22:01 -0500
Received: from ozlabs.org ([203.11.71.1]:55893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwfP-0001eV-ML; Wed, 15 Jan 2020 23:22:00 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47yrcj0rYJz9sR4; Thu, 16 Jan 2020 15:21:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579148517;
 bh=jL4+c9xr1dUCGq1r/62UtRzr1lPHi41xqPrcraIF+wg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Sf9Kx0i/ZynJJIrB1HXCfueq290ytgiFOncx8hL6W5SWRE+clyQimQKRxl+gwN+zb
 /aC4DggOEFyRsDfhfufcufI06Ql4tAzXEL28LEKxLDsaOeHvDnFbUjvoswYirJWr9c
 whuGrKqI0NcA08Z0HNil/7rLD9csCoY3HKrqDsbY=
Date: Thu, 16 Jan 2020 14:21:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 65/86] ppc:ppc405_boards: use memdev for RAM
Message-ID: <20200116042114.GJ54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-66-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-66-git-send-email-imammedo@redhat.com>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:20PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
> in ref405ep alias RAM into ram_memories[] to avoid re-factoring
> its user ppc405ep_init(), which would be invasive and out of
> scope this patch.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  hw/ppc/ppc405_boards.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index a7a432d..f447e6e 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -168,8 +168,8 @@ static void ref405ep_init(MachineState *machine)
>      }
> =20
>      /* XXX: fix this */
> -    memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405e=
p.ram",
> -                                         machine->ram_size);
> +    memory_region_init_alias(&ram_memories[0], NULL, "ef405ep.ram.alias",
> +                             machine->ram, 0, machine->ram_size);
>      ram_bases[0] =3D 0;
>      ram_sizes[0] =3D machine->ram_size;
>      memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
> @@ -310,6 +310,7 @@ static void ref405ep_class_init(ObjectClass *oc, void=
 *data)
>      mc->desc =3D "ref405ep";
>      mc->init =3D ref405ep_init;
>      mc->default_ram_size =3D 0x08000000;
> +    mc->default_ram_id =3D "ef405ep.ram";
>  }
> =20
>  static const TypeInfo ref405ep_type =3D {
> @@ -422,7 +423,6 @@ static void taihu_405ep_init(MachineState *machine)
>      MemoryRegion *sysmem =3D get_system_memory();
>      MemoryRegion *bios;
>      MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
> -    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
>      hwaddr ram_bases[2], ram_sizes[2];
>      long bios_size;
>      target_ulong kernel_base, initrd_base;
> @@ -436,18 +436,16 @@ static void taihu_405ep_init(MachineState *machine)
>                       mc->default_ram_size);
>          exit(EXIT_FAILURE);
>      }
> -    memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> -                                         machine->ram_size);
> =20
>      ram_bases[0] =3D 0;
>      ram_sizes[0] =3D 0x04000000;
>      memory_region_init_alias(&ram_memories[0], NULL,
> -                             "taihu_405ep.ram-0", ram, ram_bases[0],
> +                             "taihu_405ep.ram-0", machine->ram, ram_base=
s[0],
>                               ram_sizes[0]);
>      ram_bases[1] =3D 0x04000000;
>      ram_sizes[1] =3D 0x04000000;
>      memory_region_init_alias(&ram_memories[1], NULL,
> -                             "taihu_405ep.ram-1", ram, ram_bases[1],
> +                             "taihu_405ep.ram-1", machine->ram, ram_base=
s[1],
>                               ram_sizes[1]);
>      ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                    33333333, &pic, kernel_filename =3D=3D NULL ? 0 : 1);
> @@ -543,6 +541,7 @@ static void taihu_class_init(ObjectClass *oc, void *d=
ata)
>      mc->desc =3D "taihu";
>      mc->init =3D taihu_405ep_init;
>      mc->default_ram_size =3D 0x08000000;
> +    mc->default_ram_id =3D "ef405ep.ram";
>  }
> =20
>  static const TypeInfo taihu_type =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f5LoACgkQbDjKyiDZ
s5L02w/9ESM0SICxtOHvkUaGmmS0zU7/SEEuWjIMHuQ5Lz1mAJgQi4NYMR9RRVI7
UK5E0LkT6CPPA27HE/qo0ixymF9VGHyF3VIKavOZY3tZ/Hy2XNGzBRQgMfY9ekbf
dwJ9HAkkXAZpEh4fKwhlWHaGAjSfFI0opXius/icMArAJubvGLJdBjeHu43a0UBg
v0cLyvdpM66qqIyHNKW0W4gJs+ywAmFtB5CeDG1xRnXRBwU5M/a2i7GKdvNalf8s
6+ucrebPahn6A5UjHn1MdeK2KmegP9C5GO8hp8WP1/hxTtd0WWVDWBBGDcycY2Hs
KrwFJoVt+U3lY2yTGdzUxgI4aE0EuQ1WTGd7DPlD8E9nPJBHGbRnsOTtTP3QU870
ra8AEixHnTZ6F3Adv3Ph2BZORVn01HPupuKPITLMFydA9BGgmk5wbgqGocWDFQfC
5skYR/KDFNTLSsfoCPBdX/jrhDTxl1QtnaBl1h0JVXL27VyVbers/sG9ax+VgtIb
dNDZcMIGzHmltPnKFsjgwYHmFytclCpG7YI3nWdRCpLVzIAaIw2qF3yNFWrm6CPz
USpkXwWjJpHG5BZH4+vRtxhfK+iBWl60CdeLjXeL04+6NTtwgkNpqIBhCEBgY0N/
eOwQNJNiRoQ7JA3EYje2mx7AcB86VSq/57K2vvZfaO27fl1sFOU=
=KZ87
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

