Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB074C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB26A2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mlCH4r6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB26A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruWK-0007AQ-EC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUR-0005BW-RF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUO-0007ZV-PP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:31 -0500
Received: from ozlabs.org ([203.11.71.1]:39385)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iruUN-0007X8-Sc; Wed, 15 Jan 2020 21:02:28 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ynWg6Pwfz9sRW; Thu, 16 Jan 2020 13:02:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579140143;
 bh=x2G3wBI9kwsPUUd71j6U5XAqgOG8S5mY9FyaCojVtmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mlCH4r6uhI2CL2Fukb8rdQk1ANIMpBuQ2m9yDz+f/5siOZBg88m3OT+7wHFLFuSTL
 4H8PLR45sfzsRXUUkYphjRefiow1y9q/iqx0q38wkBevdHkeOTiDh43Msi/qeJn/m+
 ktNu7k3ZTuG9xvw0JtuUjU00inR9g9dy/7Irsi38=
Date: Thu, 16 Jan 2020 12:00:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 60/86] ppc:e500: use memdev for RAM
Message-ID: <20200116020016.GE54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-61-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-61-git-send-email-imammedo@redhat.com>
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


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:15PM +0100, Igor Mammedov wrote:
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
> ---
>  hw/ppc/e500.c      | 5 +----
>  hw/ppc/e500plat.c  | 1 +
>  hw/ppc/mpc8544ds.c | 1 +
>  3 files changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 6d119fe..256ab5a 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -831,7 +831,6 @@ static void ppce500_power_off(void *opaque, int line,=
 int on)
>  void ppce500_init(MachineState *machine)
>  {
>      MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      PPCE500MachineState *pms =3D PPCE500_MACHINE(machine);
>      const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(machine=
);
>      PCIBus *pci_bus;
> @@ -912,9 +911,7 @@ void ppce500_init(MachineState *machine)
>      }
> =20
>      /* Register Memory */
> -    memory_region_allocate_system_memory(ram, NULL, "mpc8544ds.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
> =20
>      dev =3D qdev_create(NULL, "e500-ccsr");
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 7078386..bddd5e7 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -97,6 +97,7 @@ static void e500plat_machine_class_init(ObjectClass *oc=
, void *data)
>      mc->init =3D e500plat_init;
>      mc->max_cpus =3D 32;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
> +    mc->default_ram_id =3D "mpc8544ds.ram";
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
>   }
> =20
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index c2c5e11..8117750 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -55,6 +55,7 @@ static void e500plat_machine_class_init(ObjectClass *oc=
, void *data)
>      mc->init =3D mpc8544ds_init;
>      mc->max_cpus =3D 15;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
> +    mc->default_ram_id =3D "mpc8544ds.ram";
>  }
> =20
>  #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4fw60ACgkQbDjKyiDZ
s5ILww/+OO61rjC0sEt7CbW102K9ty4KXdw8SSqG74DJqM0PuaLzpCHmL+5M8JDF
500aiTxBWkFSBnHKkOmIiAh/PdxaIYca0ftrkF+iFl+kgIMuwC1fRacbjhXDxRyq
eqdN6oE7WLlgN2+igoh5+/KmpOmNdCIx69nOkSAqlPCclUyO3ZdsDNpsw1wdKboY
T+IkDNsqj/V4/RxtgDHCMBdy1oQxyrMOHDWiLyYHWKZ5f3iC4ympE/r3hYdZsT+q
1s3tAD32Tah93nM8vnh4F/nONbc75jE/yGLq6qciFG2Mg+5injvag7tEjf7RO3Ew
mo22JomPA7KLgiaaR2/OM82ZQhAJB6cXpUSPnJYBkpdFFWeSkeYGLfFchawp6KnE
00fGe9etKa1UbJfTklFTq6xU3tZe5FbA4W/9HKDzeyCoAfm2mV7xMlKqEUi1ThWN
qrsPxjhU7EFJ6eXS1pGdAXmWh/2R2bO3p0yY8G11fNmC2PDoMZdpgDbk8O60w9Ts
YeyEL5OAOFgbfBCXEXqPLM4E24SWdEckqwI3GBooe0XljQ2J1G2gM9gVMdELE7KB
+L2VVhTjIOEcdOyWxTJ9YHkRXAlgrpSj41NyDkyv3/WXkw9GvcyGtjhnn2UHfu2c
3uSEPbpuB+4H4/znvxTX+xer3yK8bP3xttlXY/YcCLMch01VgFQ=
=84JT
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

