Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A2AC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6253E206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="M46Jrj+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6253E206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwev-00005m-Fo
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwe4-0007zl-KM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwe2-0000iS-Ou
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:20:36 -0500
Received: from ozlabs.org ([203.11.71.1]:39189)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwe0-0000cO-FE; Wed, 15 Jan 2020 23:20:34 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47yrZy6nTRz9sR4; Thu, 16 Jan 2020 15:20:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579148426;
 bh=ZgN7gau1WNqcX+vysDzPmRXmZRM6cRInPzVpxQD4PUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M46Jrj+sXdMbDQtFcyLBSEn0HU2umpMoAo/mMr3uOuygJGHi6s9oqTVkEk7t9z5W1
 X7rJ7XQJId8JD5OHlFrgSiM31DRXK3U/xuH9N0GYUd5crpaHKlD32H5UcBuW0kjXVs
 5Ol0j+o2FsnFdhPGOFIMvhbT+dNxoT+CXQVLWyjc=
Date: Thu, 16 Jan 2020 14:20:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 64/86] ppc:ppc405_boards: add RAM size checks
Message-ID: <20200116042013.GI54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-65-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-65-git-send-email-imammedo@redhat.com>
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


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:19PM +0100, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will ignore it
> and continue running with fixed RAM size.
>=20
> Also RAM is going to be allocated by generic code, so it
> won't be possible for board to fix CLI.
>=20
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>=20
> PS:
> move fixed RAM size into mc->default_ram_size, so that
> generic code will know how much to allocate.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Wow, that's spectacularly broken.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daud=E9 <philmd@redhat.com>)
>=20
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  hw/ppc/ppc405_boards.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 1f721fe..a7a432d 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -137,7 +137,7 @@ static void ref405ep_fpga_init(MemoryRegion *sysmem, =
uint32_t base)
> =20
>  static void ref405ep_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -161,15 +161,20 @@ static void ref405ep_init(MachineState *machine)
>      DriveInfo *dinfo;
>      MemoryRegion *sysmem =3D get_system_memory();
> =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Byte=
s",
> +                     mc->default_ram_size);
> +        exit(EXIT_FAILURE);
> +    }
> +
>      /* XXX: fix this */
>      memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405e=
p.ram",
> -                                         0x08000000);
> +                                         machine->ram_size);
>      ram_bases[0] =3D 0;
> -    ram_sizes[0] =3D 0x08000000;
> +    ram_sizes[0] =3D machine->ram_size;
>      memory_region_init(&ram_memories[1], NULL, "ef405ep.ram1", 0);
>      ram_bases[1] =3D 0x00000000;
>      ram_sizes[1] =3D 0x00000000;
> -    ram_size =3D 128 * MiB;
>      env =3D ppc405ep_init(sysmem, ram_memories, ram_bases, ram_sizes,
>                          33333333, &pic, kernel_filename =3D=3D NULL ? 0 =
: 1);
>      /* allocate SRAM */
> @@ -227,7 +232,7 @@ static void ref405ep_init(MachineState *machine)
>      if (linux_boot) {
>          memset(&bd, 0, sizeof(bd));
>          bd.bi_memstart =3D 0x00000000;
> -        bd.bi_memsize =3D ram_size;
> +        bd.bi_memsize =3D machine->ram_size;
>          bd.bi_flashstart =3D -bios_size;
>          bd.bi_flashsize =3D -bios_size;
>          bd.bi_flashoffset =3D 0;
> @@ -255,7 +260,7 @@ static void ref405ep_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          /* now we can load the kernel */
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_bas=
e);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> @@ -266,7 +271,7 @@ static void ref405ep_init(MachineState *machine)
>          if (initrd_filename) {
>              initrd_base =3D INITRD_LOAD_ADDR;
>              initrd_size =3D load_image_targphys(initrd_filename, initrd_=
base,
> -                                              ram_size - initrd_base);
> +                                              machine->ram_size - initrd=
_base);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -304,6 +309,7 @@ static void ref405ep_class_init(ObjectClass *oc, void=
 *data)
> =20
>      mc->desc =3D "ref405ep";
>      mc->init =3D ref405ep_init;
> +    mc->default_ram_size =3D 0x08000000;
>  }
> =20
>  static const TypeInfo ref405ep_type =3D {
> @@ -408,7 +414,7 @@ static void taihu_cpld_init(MemoryRegion *sysmem, uin=
t32_t base)
> =20
>  static void taihu_405ep_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *initrd_filename =3D machine->initrd_filename;
>      char *filename;
> @@ -425,10 +431,13 @@ static void taihu_405ep_init(MachineState *machine)
>      int fl_idx;
>      DriveInfo *dinfo;
> =20
> -    /* RAM is soldered to the board so the size cannot be changed */
> -    ram_size =3D 0x08000000;
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        error_report("Invalid RAM size, should be " RAM_ADDR_UFMT " Byte=
s",
> +                     mc->default_ram_size);
> +        exit(EXIT_FAILURE);
> +    }
>      memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> -                                         ram_size);
> +                                         machine->ram_size);
> =20
>      ram_bases[0] =3D 0;
>      ram_sizes[0] =3D 0x04000000;
> @@ -500,7 +509,7 @@ static void taihu_405ep_init(MachineState *machine)
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          /* now we can load the kernel */
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_bas=
e);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> @@ -509,7 +518,7 @@ static void taihu_405ep_init(MachineState *machine)
>          if (initrd_filename) {
>              initrd_base =3D INITRD_LOAD_ADDR;
>              initrd_size =3D load_image_targphys(initrd_filename, initrd_=
base,
> -                                              ram_size - initrd_base);
> +                                              machine->ram_size - initrd=
_base);
>              if (initrd_size < 0) {
>                  error_report("could not load initial ram disk '%s'",
>                               initrd_filename);
> @@ -533,6 +542,7 @@ static void taihu_class_init(ObjectClass *oc, void *d=
ata)
> =20
>      mc->desc =3D "taihu";
>      mc->init =3D taihu_405ep_init;
> +    mc->default_ram_size =3D 0x08000000;
>  }
> =20
>  static const TypeInfo taihu_type =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f5HoACgkQbDjKyiDZ
s5Jvbg/2MvErG8KDN2IWZwFAAMcLtv+wzwE6H8PQLf7B+KrGis4/IihtkH/Ewh25
G1qjAlCrke2GoxmPEP+5qHaph5Hik/OY5dRzACFiHw54m6wmws2hWlpdlqnOQRjM
kz747TT3aFsc1EJdMY0LqX7PbNFJGAhQjlxln4mZ2unAUd9Q4uvVDjtjQnBIUpl7
hl1Ry4Cmmti3iydk8EFzZ9unhOyjq7O5kzXrCttAtleiGPXBPAEOGmP8Pt6vL4l2
pFSEUGSMNJsTYFF/hWBXVSIO2m+GinpJfNA356pHnTagWBvDrWtUkjqptz6QP4e2
ibGNtQLZapNiB4/0xYZclQvPT6/hs3ZwJ2/2ZjsL7hF2tPNp6c8zVZwapys2wbvp
EsdrOMkRVhNt2XN42Kt0dAeWjgjxWCXg18zzvRf+sMraZvhNmfZcX2AGlL5PCWAY
WsbCQK9/85x6ss6sm+cE+toBqtiZqEvw5H6EtzGydG4fx4o2QDcXOMWyGGZOP+fW
qvbiZ9hSBUiDn56SPjqJmhx8zxXKHDhdbN+rO2r57jGNoR0o9cdIhfjAO2yE8kZs
Dab1yyI6xCsDfVcU/BdcJZpM0A2qJ60NOhOEtj3wrGQZdfWsA0qg3OgcnJcq644z
TfKlWXSr5C07mXHVUN3X9BnsmGY4g7an20m7Y63oLAxNryMb4A==
=sSlZ
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--

