Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61581C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1435720748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nrNBxP4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1435720748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwjN-0002YT-5i
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwiU-0001va-BV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwiS-0003VA-Ep
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:25:10 -0500
Received: from ozlabs.org ([203.11.71.1]:57165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwiS-0003U6-1r; Wed, 15 Jan 2020 23:25:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47yrhK54RHz9sR4; Thu, 16 Jan 2020 15:25:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579148705;
 bh=dgKWrON6WnrCNg1h8ZbEpvPzlHpUmL5pk7iErJmp+Y0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nrNBxP4FyQPjz2zvdKEW4cZ5O7DcKHYSyTDjlmVHlHClsH8VMIQznB+Fio2wslEeF
 8alCWawXH6jlZk7xYOR+ePAHfwfSXOfsHDn/oynwBP5C6iflFNExpDnfVDDAeI5CgK
 JTKjF1ryIbh6Rx7zRQK5t0xTBe6cg3mYATwm3GRI=
Date: Thu, 16 Jan 2020 14:24:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo, sam460x}: drop RAM size fixup
Message-ID: <20200116042406.GK54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-67-git-send-email-imammedo@redhat.com>
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


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:21PM +0100, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported or sometimes
> crash like this:
>   %QEMU -M bamboo -m 1
>     exec.c:1926: find_ram_offset: Assertion `size !=3D 0' failed.
>     Aborted (core dumped)
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>=20
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
> That also fixes crash issue, since wrongly calculated size
> isn't used to allocate RAM
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
>      (BALATON Zoltan <balaton@eik.bme.hu>)
>   * print possible valid ram size id not all RAM was distributed
>   * initialize ram_bases/ram_bases at the same time we are checking
>     that user supplied RAM would fit available banks and drop nested
>     loop that were duplicating the same calculations.
>   * coincidentally fix crash when -m is less than minimal bank size
>=20
> CC: balaton@eik.bme.hu
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  include/hw/ppc/ppc4xx.h |  9 ++++----
>  hw/ppc/ppc440_bamboo.c  | 11 ++++------
>  hw/ppc/ppc4xx_devs.c    | 56 +++++++++++++++++++++++++------------------=
------
>  hw/ppc/sam460ex.c       |  5 ++---
>  4 files changed, 39 insertions(+), 42 deletions(-)
>=20
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 7d82259..103c875 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -42,11 +42,10 @@ enum {
>  qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>                         uint32_t dcr_base, int has_ssr, int has_vr);
> =20
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[]);
> +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> +                       MemoryRegion ram_memories[],
> +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> +                       const ram_addr_t sdram_bank_sizes[]);
> =20
>  void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>                          MemoryRegion ram_memories[],
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index b782641..c162598 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
> =20
>  static void bamboo_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
>      /* SDRAM controller */
>      memset(ram_bases, 0, sizeof(ram_bases));
>      memset(ram_sizes, 0, sizeof(ram_sizes));
> -    ram_size =3D ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
> -                                   ram_memories,
> -                                   ram_bases, ram_sizes,
> -                                   ppc440ep_sdram_bank_sizes);
> +    ppc4xx_sdram_prep(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
> +                      ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
>      /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UI=
C0. */
>      ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memorie=
s,
>                        ram_bases, ram_sizes, 1);
> @@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
>      /* Load initrd. */
>      if (initrd_filename) {
>          initrd_size =3D load_image_targphys(initrd_filename, RAMDISK_ADD=
R,
> -                                          ram_size - RAMDISK_ADDR);
> +                                          machine->ram_size - RAMDISK_AD=
DR);
> =20
>          if (initrd_size < 0) {
>              error_report("could not load ram disk '%s' at %x",
> @@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
> =20
>      /* If we're loading a kernel directly, we must load the device tree =
too. */
>      if (kernel_filename) {
> -        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
> +        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK=
_ADDR,
>                                      initrd_size, kernel_cmdline) < 0) {
>              error_report("couldn't load device tree");
>              exit(1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index c2e5013..92d33a4 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -673,16 +673,16 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq =
irq, int nbanks,
>   * The 4xx SDRAM controller supports a small number of banks, and each b=
ank
>   * must be one of a small set of sizes. The number of banks and the supp=
orted
>   * sizes varies by SoC. */
> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
> -                               MemoryRegion ram_memories[],
> -                               hwaddr ram_bases[],
> -                               hwaddr ram_sizes[],
> -                               const ram_addr_t sdram_bank_sizes[])
> +void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
> +                       MemoryRegion ram_memories[],
> +                       hwaddr ram_bases[], hwaddr ram_sizes[],
> +                       const ram_addr_t sdram_bank_sizes[])
>  {
>      MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
>      ram_addr_t size_left =3D ram_size;
>      ram_addr_t base =3D 0;
>      ram_addr_t bank_size;
> +    int last_bank =3D 0;
>      int i;
>      int j;
> =20
> @@ -690,7 +690,11 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, =
int nr_banks,
>          for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
>              bank_size =3D sdram_bank_sizes[j];
>              if (bank_size <=3D size_left) {
> +                ram_bases[i] =3D base;
> +                ram_sizes[i] =3D bank_size;
> +                base +=3D bank_size;
>                  size_left -=3D bank_size;
> +                last_bank =3D i;
>              }
>          }
>          if (!size_left) {
> @@ -699,34 +703,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size,=
 int nr_banks,
>          }
>      }
> =20
> -    ram_size -=3D size_left;
>      if (size_left) {
> -        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
> -                     " controller limits", ram_size / MiB);
> +        ram_addr_t used_size =3D ram_size - size_left;
> +        GString *s =3D g_string_new(NULL);
> +
> +        for (i =3D 0; sdram_bank_sizes[i]; i++) {
> +            g_string_append_printf(s, "%" PRIi64 "%s",
> +                                   sdram_bank_sizes[i] / MiB,
> +                                   sdram_bank_sizes[i + 1] ? " ," : "");
> +        }
> +        error_report("Max %d banks of %s MB DIMM/bank supported",
> +            nr_banks, s->str);
> +        error_report("Possible valid RAM size: %" PRIi64,
> +            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
> +
> +        g_string_free(s, true);
> +        exit(EXIT_FAILURE);
>      }
> =20
>      memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_=
size);
> =20
> -    size_left =3D ram_size;
> -    for (i =3D 0; i < nr_banks && size_left; i++) {
> -        for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
> -            bank_size =3D sdram_bank_sizes[j];
> -
> -            if (bank_size <=3D size_left) {
> -                char name[32];
> -                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> -                memory_region_init_alias(&ram_memories[i], NULL, name, r=
am,
> -                                         base, bank_size);
> -                ram_bases[i] =3D base;
> -                ram_sizes[i] =3D bank_size;
> -                base +=3D bank_size;
> -                size_left -=3D bank_size;
> -                break;
> -            }
> -        }
> +    for (i =3D 0; i <=3D last_bank; i++) {
> +        char name[32];
> +        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
> +        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
> +                                 ram_bases[i], ram_sizes[i]);
>      }
> -
> -    return ram_size;
>  }
> =20
>  /***********************************************************************=
******/
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 437e214..ec7ac1f 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
>      /* SDRAM controller */
>      /* put all RAM on first bank because board has one slot
>       * and firmware only checks that */
> -    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
> -                                   ram_memories, ram_bases, ram_sizes,
> -                                   ppc460ex_sdram_bank_sizes);
> +    ppc4xx_sdram_prep(machine->ram_size, 1, ram_memories, ram_bases, ram=
_sizes,
> +                      ppc460ex_sdram_bank_sizes);
> =20
>      /* FIXME: does 460EX have ECC interrupts? */
>      ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f5WYACgkQbDjKyiDZ
s5L24g//TQpJgBM+Uxkoug/zkMJvu1s9ndLgPHA3sixpxEwAQX6YGVl2HTbgw86L
g+8ksf+Ylz8LiH+p7OAgQjwxpeZM1/WtsAjK+o8MmbRYtMd6UV9dZH7+/S1YRhNg
h5JSXxm/Ec/e9MHZJzOVv5VOZWvWB426jZsJOiWPLwyW5/i8wblUCK2geriYCvkV
e/7L9h/UfLi3XHngY68NhzCSMdSAyEALV/g6PM2RjfXvminoZhNx/rf4cUUD/vuB
jBVvPjR20n8qSUzHdSiHyydq4r6lcoOXnDE0ZR4jcflkVRxaPclp8/MTXojU4DaZ
4AWFWbOOtpMmrgqjVDnRMuxjJB3CV0zOozIrYC1vykAC72iKbovU+LJTV7ERfKFE
YLRPXeC8j4tRbFRHPVPhl9H3cWr27QflUGWnPnkIMBk4LDzSJiqpTJCwo+Oomhhv
iDpqe5ridhN0/I6YqxZc5BmrkpRZQynm5Pt3VmzBbesajZzb+glK2g2dTSGOQqTd
PVSKVCjwtSkESuN5tTHsUuD42iq4ZP3irxVT1sI+RW1PMH99m7CWLj3HkLo/EUXT
VqZw7Q6HjzSbFpa3V8IBkEObApKXCPI8bJAW5BxZxVWsl0bsU8ZH6p67P+Ht07x2
1XiQ0vV17bBi9ggRNY5B82Vly1+IxGNcZdwgOlVt81X4/bYKeds=
=S7uR
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--

