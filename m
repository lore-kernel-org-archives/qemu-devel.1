Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 07:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E396E20702
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 07:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gxSIEJqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E396E20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrz8c-0005Dg-5a
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 03:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jrz7q-0004cE-Av; Sun, 05 Jul 2020 03:31:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43527 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jrz7m-0001Vq-CU; Sun, 05 Jul 2020 03:31:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B00kc2jPmz9sSJ; Sun,  5 Jul 2020 17:31:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593934296;
 bh=jnVOvbd4MsHIGYKVwWo8vOYgCAYm8ObryT0W5JNZbYE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gxSIEJqR2bxgRwgPIMRcdmN6rGyBSLDpswi0/8Qv4G4Bt9LdGGJybmfsodQ0sBF12
 zu37eflwOj85Z+Ua9UWuXu7GM66KSlbUw/aAuNC8iqk+OWg0dOOSy5uAoiww868+ay
 IMPxLfBAnhsPdSZcD+Dw2g+v+R2sIW9TjReTbR8I=
Date: Sun, 5 Jul 2020 17:31:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v7 1/8] mac_oldworld: Allow loading binary ROM image
Message-ID: <20200705073128.GB6626@umbus.fritz.box>
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <c69a791c7cad1246f3f34b3993dee4f549b75aa2.1593456926.git.balaton@eik.bme.hu>
 <ad28ac08-160d-0bde-7856-483308d164cb@ilande.co.uk>
 <alpine.BSF.2.22.395.2006302249091.46417@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.22.395.2006302249091.46417@zero.eik.bme.hu>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 03:31:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 11:45:42PM +0200, BALATON Zoltan wrote:
> On Tue, 30 Jun 2020, Mark Cave-Ayland wrote:
> > On 29/06/2020 19:55, BALATON Zoltan wrote:
> > > The beige G3 Power Macintosh has a 4MB firmware ROM. Fix the size of
> > > the rom region and fall back to loading a binary image with -bios if
> > > loading ELF image failed. This allows testing emulation with a ROM
> > > image from real hardware as well as using an ELF OpenBIOS image.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > > v4: use load address from ELF to check if ROM is too big
> > >=20
> > >  hw/ppc/mac_oldworld.c | 29 ++++++++++++++++++++---------
> > >  1 file changed, 20 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> > > index f8c204ead7..baf3da6f90 100644
> > > --- a/hw/ppc/mac_oldworld.c
> > > +++ b/hw/ppc/mac_oldworld.c
> > > @@ -59,6 +59,8 @@
> > >  #define NDRV_VGA_FILENAME "qemu_vga.ndrv"
> > >=20
> > >  #define GRACKLE_BASE 0xfec00000
> > > +#define PROM_BASE 0xffc00000
> > > +#define PROM_SIZE (4 * MiB)
> > >=20
> > >  static void fw_cfg_boot_set(void *opaque, const char *boot_device,
> > >                              Error **errp)
> > > @@ -99,6 +101,7 @@ static void ppc_heathrow_init(MachineState *machin=
e)
> > >      SysBusDevice *s;
> > >      DeviceState *dev, *pic_dev;
> > >      BusState *adb_bus;
> > > +    uint64_t bios_addr;
> > >      int bios_size;
> > >      unsigned int smp_cpus =3D machine->smp.cpus;
> > >      uint16_t ppc_boot_device;
> > > @@ -127,24 +130,32 @@ static void ppc_heathrow_init(MachineState *mac=
hine)
> > >=20
> > >      memory_region_add_subregion(sysmem, 0, machine->ram);
> > >=20
> > > -    /* allocate and load BIOS */
> > > -    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZ=
E,
> > > +    /* allocate and load firmware ROM */
> > > +    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZ=
E,
> > >                             &error_fatal);
> > > +    memory_region_add_subregion(sysmem, PROM_BASE, bios);
> > >=20
> > > -    if (bios_name =3D=3D NULL)
> > > +    if (!bios_name) {
> > >          bios_name =3D PROM_FILENAME;
> > > +    }
> > >      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > > -    memory_region_add_subregion(sysmem, PROM_ADDR, bios);
> > > -
> > > -    /* Load OpenBIOS (ELF) */
> > >      if (filename) {
> > > -        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, =
NULL, NULL,
> > > -                             1, PPC_ELF_MACHINE, 0, 0);
> > > +        /* Load OpenBIOS (ELF) */
> > > +        bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL, &bi=
os_addr,
> > > +                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
> > > +        if (bios_size <=3D 0) {
> > > +            /* or load binary ROM image */
> > > +            bios_size =3D load_image_targphys(filename, PROM_BASE, P=
ROM_SIZE);
> > > +            bios_addr =3D PROM_BASE;
> > > +        } else {
> > > +            /* load_elf sets high 32 bits for some reason, strip tho=
se */
> > > +            bios_addr &=3D 0xffffffffULL;
> >=20
> > Repeating my earlier comment from v5: something is wrong here if you ne=
ed to manually
> > strip the high bits. If you compare with SPARC32 which uses the same ap=
proach, there
> > is no such strip required - have a look there to try and figure out wha=
t's going on here.
>=20
> OK, the problem here is this:
>=20
> $ gdb qemu-system-ppc
> (gdb) b mac_oldworld.c:146
> Breakpoint 1 at 0x416770: file hw/ppc/mac_oldworld.c, line 146.
> (gdb) r
> Thread 1 "qemu-system-ppc" hit Breakpoint 1, ppc_heathrow_init (machine=
=3D0x555556863800) at hw/ppc/mac_oldworld.c:146
> 146	    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> (gdb) n
> 147	    if (filename) {
> 149	        bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL, &bio=
s_addr,
> 151	        if (bios_size <=3D 0) {
> (gdb) p bios_size
> $1 =3D 755500
> (gdb) p/x bios_addr
> $2 =3D 0xfffffffffff00000
>=20
> this happens within load_elf that I don't feel like wanting to debug but
> causes problem when we use it to calculate bios size later here:

I think the problem is here, in include/hw/elf_ops.h:

    if (lowaddr)
        *lowaddr =3D (uint64_t)(elf_sword)low;

"low" is a u64, but for a 32-bit ELF file, which is what I'm guessing
you're dealing with here, elf_sword is an int32_t.  So the first cast
truncates the high bits, but makes it a signed value, so the second
cast sign extends, resulting in those high bits.

Sign extending rather than zero-extending seems a dubious choice here,
so I wonder if that should be (elf_word) instead of (elf_sword).  But
maybe there's some weird other case where we do want the sign
extension here.

>=20
> -    if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +    if (bios_size < 0 || bios_addr - PROM_BASE + bios_size > PROM_SIZE) {
>=20
> unless we strip it down to expected 32 bits. This could be some unwanted
> size extension or whatnot but I don't have time to dig deeper.
>=20
> Now lets see what sun4m does:
>=20
> $ gdb qemu-system-sparc
> (gdb) b sun4m.c:721
> Breakpoint 1 at 0x1fc0e6: file hw/sparc/sun4m.c, line 721.
> (gdb) r
> Thread 1 "qemu-system-spa" hit Breakpoint 1, prom_init (addr=3D1879048192=
, bios_name=3D0x555555b3c60d "openbios-sparc32") at hw/sparc/sun4m.c:721
> 721	    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> (gdb) p/x addr
> $1 =3D 0x70000000
> (gdb) n
> 722	    if (filename) {
> 723	        ret =3D load_elf(filename, NULL,
> 726	        if (ret < 0 || ret > PROM_SIZE_MAX) {
> (gdb) p ret
> $2 =3D 847872
> (gdb) p/x addr
> $3 =3D 0x70000000
>=20
> Hmm, does not happen here, the difference is that this calls load_elf with
> addr already initialised so maybe load_elf only sets low 32 bits? By the
> way, sun4m does not use the returned addr so even if it was wrong it would
> not be noticed,
>=20
> Maybe initialising addr before calling load_elf in mac_oldworld,c could f=
ix
> this so we can get rid of the fix up? Unfortunately not:
>=20
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -98,7 +98,7 @@ static void ppc_heathrow_init(MachineState *machine)
>      SysBusDevice *s;
>      DeviceState *dev, *pic_dev;
>      BusState *adb_bus;
> -    uint64_t bios_addr;
> +    uint64_t bios_addr =3D 0;
>      int bios_size;
>      unsigned int smp_cpus =3D machine->smp.cpus;
>      uint16_t ppc_boot_device;
>=20
> $ gdb qemu-system-ppc
> [...]
> Thread 1 "qemu-system-ppc" hit Breakpoint 1, ppc_heathrow_init (machine=
=3D0x555556863800) at hw/ppc/mac_oldworld.c:146
> 146	    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> (gdb) p bios_addr
> $1 =3D 0
> (gdb) n
> 147	    if (filename) {
> 149	        bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL, &bio=
s_addr,
> 151	        if (bios_size <=3D 0) {
> (gdb) p/x bios_addr
> $2 =3D 0xfffffffffff00000
>=20
> Could this be something about openbios-ppc? I don't know. I give up
> investigating further at this point and let someone else find out.
> Any ideas?
>=20
> Regards,
> BALATON Zoltan
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8Bgc0ACgkQbDjKyiDZ
s5JwLBAAiyHJ6ZdtAew690sH4F4CiaG7GwudohyT9JporpU02oSVNkxwsuknWJvM
mbCBkya3RDTovqqRCG1ksawbH3etKKCEeZbXitGj7YTVB2R5dzsQd6rTrSERvk0p
h7jYGIc7mK5+X4Dw3qJSq46D/ybSkBsSBb1Km6a76IDVZoDvCr0mYTgjxU0zQf9u
mUas2UffxgqEs0Rl2NRxevof8nKgJ/MS5WOIq9FWDJ2XWXMIaKEChEgg3qoaBnH4
/Dg0hNR4C73ohpjcQBgIOJUYVwC7B+hbW/VuvaxXXLz+ZC0CdQybQNfFeUBxwOE1
FSwmlhDSOxQ8iQG1UxXZ0Lg9cwNfL8kerkoPtR+6y+AIt2dqooBnW3qIK5OcBQbr
PSl/EEdzneTkOhk4ATbzzLQ1G5WBAgZnPI/5vYSZEqRjtXyOggkOe7a5HRU/cRue
+11fnRQobVt+bQLhE6YYQm626f69zaThgg/DF6N2pFqrPCYSnnfFNMSRLVshWbBK
BZJwZfZlo1aNz1CrWD5vYiYbqGTJggxak8zJVa0+5llu8KMHe5heESMhnzBFbJP3
Wo5HKhI4s3Mmc37WJE2kqA0rJi26ZpOPod3agykyxkVXgbo8t/jEhL4bhQXYy7jy
leeh5HSvf0/BYqB/m7pZRltH7CTVjlr8cCbLBDAS4f66P0o3ElA=
=I8px
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

