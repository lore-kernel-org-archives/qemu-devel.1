Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1658C35247
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700D420842
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 03:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nCWwuHiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700D420842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivvHR-0002w3-IL
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 22:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ivvGG-0001cm-AU
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 22:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ivvGD-0005Mi-L3
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 22:40:28 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36481 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ivvGC-0005Jx-NX; Sun, 26 Jan 2020 22:40:25 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 485b9Y2VtZz9sR1; Mon, 27 Jan 2020 14:40:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580096417;
 bh=5zoYTP3Jot7AkKaVp60/bWvFd/mKlug3Bf7P9+jiEik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nCWwuHiOMZ0jmSabU9oCoQYQHcgtOoJ4Wx7T9BwvK6UI6MRLDLLNR5cWOCR8GIQGm
 P4yghHbCZ4AJqeZegLuwzJtCHoBVv6Yv4lQ+QPtXNL9NiBgD7z7y8WhVjlD5amtnmA
 iVk7IFAQjEdfncK09GtCCVKEL1Sim5QgdHm2pDN8=
Date: Mon, 27 Jan 2020 14:40:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH REPOST v3 65/80] ppc/{ppc440_bamboo, sam460ex}: use
 memdev for RAM
Message-ID: <20200127034008.GD1818@umbus.fritz.box>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-66-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <1579779525-20065-66-git-send-email-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 12:38:30PM +0100, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v3:
>   * drop ram_size from comment above ppc4xx_sdram_banks
>      (BALATON Zoltan <balaton@eik.bme.hu>)
>   * move memory alias initialization into the same loop
>     where RAM is split on banks.
>      (BALATON Zoltan <balaton@eik.bme.hu>)
> v3.1
>   * rebase on top of previous patch due to changed context
>=20
> CC: balaton@eik.bme.hu
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  include/hw/ppc/ppc4xx.h |  2 +-
>  hw/ppc/ppc440_bamboo.c  |  3 ++-
>  hw/ppc/ppc4xx_devs.c    | 25 +++++++++----------------
>  hw/ppc/sam460ex.c       |  3 ++-
>  4 files changed, 14 insertions(+), 19 deletions(-)
>=20
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index b8c8f32..cc19c8d 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -42,7 +42,7 @@ enum {
>  qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>                         uint32_t dcr_base, int has_ssr, int has_vr);
> =20
> -void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
>                          MemoryRegion ram_memories[],
>                          hwaddr ram_bases[], hwaddr ram_sizes[],
>                          const ram_addr_t sdram_bank_sizes[]);
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 29a9642..1d4a11d 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -202,7 +202,7 @@ static void bamboo_init(MachineState *machine)
>      /* SDRAM controller */
>      memset(ram_bases, 0, sizeof(ram_bases));
>      memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_m=
emories,
> +    ppc4xx_sdram_banks(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memori=
es,
>                         ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>      /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UI=
C0. */
>      ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memorie=
s,
> @@ -289,6 +289,7 @@ static void bamboo_machine_init(MachineClass *mc)
>      mc->desc =3D "bamboo";
>      mc->init =3D bamboo_init;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440epb");
> +    mc->default_ram_id =3D "ppc4xx.sdram";
>  }
> =20
>  DEFINE_MACHINE("bamboo", bamboo_machine_init)
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index d89008a..0e2f81c 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -666,7 +666,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
>          sdram_map_bcr(sdram);
>  }
> =20
> -/* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
> +/* Split RAM between SDRAM banks.
>   *
>   * sdram_bank_sizes[] must be in descending order, that is sizes[i] > si=
zes[i+1]
>   * and must be 0-terminated.
> @@ -674,16 +674,14 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq =
irq, int nbanks,
>   * The 4xx SDRAM controller supports a small number of banks, and each b=
ank
>   * must be one of a small set of sizes. The number of banks and the supp=
orted
>   * sizes varies by SoC. */
> -void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
> +void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
>                          MemoryRegion ram_memories[],
>                          hwaddr ram_bases[], hwaddr ram_sizes[],
>                          const ram_addr_t sdram_bank_sizes[])
>  {
> -    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
> -    ram_addr_t size_left =3D ram_size;
> +    ram_addr_t size_left =3D memory_region_size(ram);
>      ram_addr_t base =3D 0;
>      ram_addr_t bank_size;
> -    int last_bank =3D 0;
>      int i;
>      int j;
> =20
> @@ -691,11 +689,15 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr=
_banks,
>          for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
>              bank_size =3D sdram_bank_sizes[j];
>              if (bank_size <=3D size_left) {
> +                char name[32];
> +
>                  ram_bases[i] =3D base;
>                  ram_sizes[i] =3D bank_size;
>                  base +=3D bank_size;
>                  size_left -=3D bank_size;
> -                last_bank =3D i;
> +                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> +                memory_region_init_alias(&ram_memories[i], NULL, name, r=
am,
> +                                         ram_bases[i], ram_sizes[i]);
>                  break;
>              }
>          }
> @@ -706,7 +708,7 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_b=
anks,
>      }
> =20
>      if (size_left) {
> -        ram_addr_t used_size =3D ram_size - size_left;
> +        ram_addr_t used_size =3D memory_region_size(ram) - size_left;
>          GString *s =3D g_string_new(NULL);
> =20
>          for (i =3D 0; sdram_bank_sizes[i]; i++) {
> @@ -722,15 +724,6 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_=
banks,
>          g_string_free(s, true);
>          exit(EXIT_FAILURE);
>      }
> -
> -    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_=
size);
> -
> -    for (i =3D 0; i <=3D last_bank; i++) {
> -        char name[32];
> -        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> -        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> -                                 ram_bases[i], ram_sizes[i]);
> -    }
>  }
> =20
>  /***********************************************************************=
******/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 949acba..b48aea5 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
>      /* SDRAM controller */
>      /* put all RAM on first bank because board has one slot
>       * and firmware only checks that */
> -    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ra=
m_sizes,
> +    ppc4xx_sdram_banks(machine->ram, 1, ram_memories, ram_bases, ram_siz=
es,
>                         ppc460ex_sdram_bank_sizes);
> =20
>      /* FIXME: does 460EX have ECC interrupts? */
> @@ -483,6 +483,7 @@ static void sam460ex_machine_init(MachineClass *mc)
>      mc->init =3D sam460ex_init;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
>      mc->default_ram_size =3D 512 * MiB;
> +    mc->default_ram_id =3D "ppc4xx.sdram";
>  }
> =20
>  DEFINE_MACHINE("sam460ex", sam460ex_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4uW5gACgkQbDjKyiDZ
s5LOuhAA1Wo80aClARG4AXJqgb93BW+8AiyeRDTJSBQt6a/gltlyF/i8Vmlu4Ebk
PyLhruaLno1XKzIoVtwXDlIgSmYSdybU/p0FG2pv7Ud4w7UI77vVIRMZaKxmSy26
4reyFfqVGhH/J8Taftimfrahkrl6MiNkhilUNAEIjYiILVlFYCCTVUq546YkgFzW
ipduwe/3CVME3g4PctdhJgJOfFnsnSm9TUcUMIFDnw+CU5+R83WlbBkJl6BqpuxU
OKjKQ5M8FCOSO2sIiQSYH07+nVwPu1r0D/dekm4Q8gWGDi9S8JKUX85cMV1omvgg
81SFkBLILIdtc56S13FsKWrvlBR2VCRQOBuv72aJOcgHNEspG6euyD8yWZidj1Xl
J+SGPNjEu5upypcCEnB1GUOr0LzYOa0f4SUgLA42eBHft8wxHBd22U8thsTAD+gi
UR5t+7rEs+ckC+GAkVg8xxWwmd8HCRp2ppfhmR+V0ENRZicO2NFmsdprKHzaZ1Os
kpcoropgPca5m2Vgo1tSrjj2GGpF13ISNXlILgK2P69TT5O5y9UYCJUcaaWTxiTA
hA0BrCngkmbelnUPLh3MVYio7cBlDywUbPLYL9ffj42PYAqUUxurbgU0qFjep/a5
tephh5cxp9gf/pfGRHv4tXCMCXkr/now0EIkDvqIK/mOeV70FzM=
=8lyJ
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--

