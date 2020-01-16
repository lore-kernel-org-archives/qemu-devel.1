Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCBC33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555212075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="S9J/6JZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwm9-0005sz-9j
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwkv-0004NJ-SO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwku-0004xt-GS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:27:41 -0500
Received: from ozlabs.org ([203.11.71.1]:57065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwku-0004wd-4Q; Wed, 15 Jan 2020 23:27:40 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47yrlF571Sz9sR4; Thu, 16 Jan 2020 15:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579148857;
 bh=cMIZRZ5ZfFUt1uOoPcf34fhX/+05uAVFcHMi7WrC+tI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S9J/6JZjWCO7Mb2y7jZECmCZ8D5/lDBMNvAugEQr6i/CVpuZYzIHwq7WoP5H9bPHa
 hU/D4gwHpCMbhN91XDSku1XEOA+IoWrMjlmiGGZKAWojkxA5197K1A04LNNJv3/gZo
 zlrS6tNfkJb5n3RtCAAy3bMchUJdQpW5v7fm7bGo=
Date: Thu, 16 Jan 2020 14:26:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 68/86] ppc:prep: use memdev for RAM
Message-ID: <20200116042658.GL54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-69-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t5C3/nrmPumNj5sH"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-69-git-send-email-imammedo@redhat.com>
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
Cc: qemu-ppc@nongnu.org, hpoussin@reactos.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--t5C3/nrmPumNj5sH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:23PM +0100, Igor Mammedov wrote:
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

Although it's probably fairly pointless, since I'm looking to merge a
patch removing prep entirely soon.

> ---
> CC: hpoussin@reactos.org
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> ---
>  hw/ppc/prep.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 862345c..bf75dde 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -400,7 +400,6 @@ static int PPC_NVRAM_set_params (Nvram *nvram, uint16=
_t NVRAM_size,
>  /* PowerPC PREP hardware initialisation */
>  static void ppc_prep_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
> @@ -413,7 +412,6 @@ static void ppc_prep_init(MachineState *machine)
>      MemoryRegion *xcsr =3D g_new(MemoryRegion, 1);
>  #endif
>      int linux_boot, i, nb_nics1;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      uint32_t kernel_base, initrd_base;
>      long kernel_size, initrd_size;
>      DeviceState *dev;
> @@ -444,15 +442,14 @@ static void ppc_prep_init(MachineState *machine)
>          qemu_register_reset(ppc_prep_reset, cpu);
>      }
> =20
> -    /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_=
size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    /* map RAM */
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
> =20
>      if (linux_boot) {
>          kernel_base =3D KERNEL_LOAD_ADDR;
>          /* now we can load the kernel */
>          kernel_size =3D load_image_targphys(kernel_filename, kernel_base,
> -                                          ram_size - kernel_base);
> +                                          machine->ram_size - kernel_bas=
e);
>          if (kernel_size < 0) {
>              error_report("could not load kernel '%s'", kernel_filename);
>              exit(1);
> @@ -461,7 +458,7 @@ static void ppc_prep_init(MachineState *machine)
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
> @@ -576,7 +573,7 @@ static void ppc_prep_init(MachineState *machine)
>      sysctrl->nvram =3D m48t59;
> =20
>      /* Initialise NVRAM */
> -    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
> +    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", machine->ram_size,
>                           ppc_boot_device,
>                           kernel_base, kernel_size,
>                           kernel_cmdline,
> @@ -596,6 +593,7 @@ static void prep_machine_init(MachineClass *mc)
>      mc->default_boot_order =3D "cad";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("602");
>      mc->default_display =3D "std";
> +    mc->default_ram_id =3D "ppc_prep.ram";
>  }
> =20
>  static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
> @@ -814,6 +812,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->init =3D ibm_40p_init;
>      mc->max_cpus =3D 1;
>      mc->default_ram_size =3D 128 * MiB;
> +    mc->default_ram_id =3D "ppc_prep.ram";
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_boot_order =3D "c";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("604");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t5C3/nrmPumNj5sH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f5hEACgkQbDjKyiDZ
s5J8QxAA08ZdlASKV5+qKq/LhkzIAykYqEcq6OScsKonXCsWd1UcxNTbi4PfcsCe
Ws8xe+wzb6jGLlBxMKwd306Y/YkCM8giF2Binl7XpjPg/zhlYKuls9vFy5Az/7Dt
05eLTadrejFnGZHYvJSscj0tqsnRGzt9OdiQJ3FgStxWRo2c3J0eGTEWskQh5IL+
ZnTto05SrW79xSnxCmhXUj/Rr7qGOKvyLW37P/+orB/nZ9PhrCbmiy1HV/utwYd8
4oGOdMo+KFAyVicl6jOoTV50ewYpsSoiq1VnE1XDumoNWnmY8mggu0zW3OqblsEB
JE/yC/NBWqjSJIYYnWf9FpfWtr01zy0hbO1XY1ygkE2//PpkBVN4Knk1hG6GUIh6
8eRm7P7zVmKumArRpmOquqIKJ9tt01s8/sluCUfLdbRyVaMoRhMzlB5qPVFF441I
8U/TH+fKV87Y5pc41jQZ/yHg6JlQEZwc5gKwYQCvFBjuD8BKlsGQSRLNT9aUXLtS
ZDh1JIkJw6+dL7PL2CmV6TmjjHJC0E3SQzOeEyvDz3dIoG6y28mNWqLSZi+TYPk3
f8A5iRpp5VJR4doaqmKCFk7431AocBYmR9V1jAFpWKTOBTvhOxSZjYxXhKcWQnt1
TOZEMYGxWmQCu9snii4mtH7vFz2lc+XlWFd0dvj0swtt52YXayg=
=5RCu
-----END PGP SIGNATURE-----

--t5C3/nrmPumNj5sH--

