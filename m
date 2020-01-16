Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0FC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A194D20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T1OsLs15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A194D20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwwz-0005Yf-RP
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwvs-0004Q8-DM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwvq-00057S-Qn
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:39:00 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37557 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwvq-000549-G2; Wed, 15 Jan 2020 23:38:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ys0G1zMzz9sPW; Thu, 16 Jan 2020 15:38:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579149534;
 bh=oUHnwwu7WcE/N3uu6p5zlIgl+lbsLFqfu6FyFG7GL3M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1OsLs15NuTrdhQc7NUBzJ5bt5OUAWaZXJbieUlhXwu8CIQHPuIYmlb2ruH3VERrL
 xPKHnrb3jpmLldWNjk8CkCTtwnVAeF6xGRLhCQiHy7VxtkQZQU9Y8MFPBECJmSejQc
 KnGl/gA3pOiO3FxS1MtBAvAWWaouzguVWJbolTs0=
Date: Thu, 16 Jan 2020 14:35:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 71/86] ppc:virtex_ml507: use memdev for RAM
Message-ID: <20200116043515.GO54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-72-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8WA4ILJSyYAmUzbY"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-72-git-send-email-imammedo@redhat.com>
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8WA4ILJSyYAmUzbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:26PM +0100, Igor Mammedov wrote:
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
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> CC: edgar.iglesias@gmail.com
> ---
>  hw/ppc/virtex_ml507.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 651d8db..b74a269 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -193,7 +193,6 @@ static int xilinx_load_device_tree(hwaddr addr,
> =20
>  static void virtex_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      hwaddr initrd_base =3D 0;
> @@ -204,7 +203,6 @@ static void virtex_init(MachineState *machine)
>      CPUPPCState *env;
>      hwaddr ram_base =3D 0;
>      DriveInfo *dinfo;
> -    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
>      qemu_irq irq[32], *cpu_irq;
>      int kernel_size;
>      int i;
> @@ -221,8 +219,7 @@ static void virtex_init(MachineState *machine)
> =20
>      qemu_register_reset(main_cpu_reset, cpu);
> =20
> -    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size=
);
> -    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> +    memory_region_add_subregion(address_space_mem, ram_base, machine->ra=
m);
> =20
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
> @@ -265,7 +262,7 @@ static void virtex_init(MachineState *machine)
>              /* If we failed loading ELF's try a raw image.  */
>              kernel_size =3D load_image_targphys(kernel_filename,
>                                                boot_offset,
> -                                              ram_size);
> +                                              machine->ram_size);
>              boot_info.bootstrap_pc =3D boot_offset;
>              high =3D boot_info.bootstrap_pc + kernel_size + 8192;
>          }
> @@ -276,7 +273,7 @@ static void virtex_init(MachineState *machine)
>          if (machine->initrd_filename) {
>              initrd_base =3D high =3D ROUND_UP(high, 4);
>              initrd_size =3D load_image_targphys(machine->initrd_filename,
> -                                              high, ram_size - high);
> +                                              high, machine->ram_size - =
high);
> =20
>              if (initrd_size < 0) {
>                  error_report("couldn't load ram disk '%s'",
> @@ -290,7 +287,7 @@ static void virtex_init(MachineState *machine)
>          boot_info.fdt =3D high + (8192 * 2);
>          boot_info.fdt &=3D ~8191;
> =20
> -        xilinx_load_device_tree(boot_info.fdt, ram_size,
> +        xilinx_load_device_tree(boot_info.fdt, machine->ram_size,
>                                  initrd_base, initrd_size,
>                                  kernel_cmdline);
>      }
> @@ -302,6 +299,7 @@ static void virtex_machine_init(MachineClass *mc)
>      mc->desc =3D "Xilinx Virtex ML507 reference design";
>      mc->init =3D virtex_init;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
> +    mc->default_ram_id =3D "ram";
>  }
> =20
>  DEFINE_MACHINE("virtex-ml507", virtex_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8WA4ILJSyYAmUzbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f6AMACgkQbDjKyiDZ
s5KBRBAAraPR79OWhM33LOPfMRKzKhF5GzaqL3hE/cWWL8Z5GrtToSCXYUfE7RX2
0hF0ROUUcMv3HhxrbQBaXNCjFT7OdTweJJqvHTF2OmdYEToxgqcKvqHMnlPMNxzR
mQvLZFAk53GzBeMX2BWA2XAGYkfhZck2k89syDussYyL/JA41WTWnYAc6AKjPHHY
1jW/7tNjnr8mNLu4SnhQk8uuopxtVwhGy6bzb6cEooLF2/Z5QMVzbGy00OcjU62J
ocd9zBK6D5CAn8vA0KVeteomOzwDPzh3pTecqkt2aCk36fLOwzxtI6o+DzuOct0V
LxIyFgqL0c+/ail2pyBpyxorvwE1O3QgVPHPfqgjpLHzc/if0KVVqmA/NGk91K/7
+7yZ/QkFRQElI4QM9YlzXCv5PnRHmJLuhJq2KNBP/hyAtRJDahd8+tmZXv5TuJhl
o1CP+3feYAYq5coIPqcCbRUDTSny9LlG9as3Xa4Yt2BHLvh4rVeZSJST6vdunZAP
9oW+/NYYi5Y5H9m7J49EyjjGoPn3XfnpzpsSV65VC1ia+p3ZB+rYR6udW/2J3esC
7dlToBu2z5NoGrHgx/57e5tYGCtEvpL/XPlD5JEhXO5+loIh0JCnw4xx2UsBJwW4
McB1D22iwmTZPoJZ0+P4UIf+CaSyd8GQPfQOtHNvo9skenIteuM=
=IfUj
-----END PGP SIGNATURE-----

--8WA4ILJSyYAmUzbY--

