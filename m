Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4EC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0012084D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PC/48g8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0012084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruWI-0007AG-0U
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUR-00059y-3X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iruUP-0007aE-2l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:02:30 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46255 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iruUO-0007XD-N8; Wed, 15 Jan 2020 21:02:29 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47ynWh1ttLz9sRQ; Thu, 16 Jan 2020 13:02:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579140144;
 bh=fsU60vkfFxLn6UXYA57JdeliRCeDEc1SvrpH2moGRwY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PC/48g8CVuS8xB4dQHSPKAH9MOFsyrJzGWYzI/+gw5XnUJoZEYFnXoy1p6+dLhX0q
 18ta2aTOLK9O5/g4DXnyT2BlRm4V8EZFK3l1sb1gqK9Ke56wa3wYEaELf+vkKoQ0Dz
 +DzbJFLbzzOzm6orcPr99MSB8rxGzXQ+yUzBt3KQ=
Date: Thu, 16 Jan 2020 12:01:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 61/86] ppc:mac_newworld: use memdev for RAM
Message-ID: <20200116020109.GF54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-62-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-62-git-send-email-imammedo@redhat.com>
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:16PM +0100, Igor Mammedov wrote:
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
> CC: mark.cave-ayland@ilande.co.uk
> ---
>  hw/ppc/mac_newworld.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 3594517..2546d33 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -118,7 +118,7 @@ static void ppc_core99_init(MachineState *machine)
>      char *filename;
>      IrqLines *openpic_irqs;
>      int linux_boot, i, j, k;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
> +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>      hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
>      long kernel_size, initrd_size;
>      UNINHostState *uninorth_pci;
> @@ -152,8 +152,7 @@ static void ppc_core99_init(MachineState *machine)
>      }
> =20
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ra=
m_size);
> -    memory_region_add_subregion(get_system_memory(), 0, ram);
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
> =20
>      /* allocate and load BIOS */
>      memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
> @@ -586,6 +585,7 @@ static void core99_machine_class_init(ObjectClass *oc=
, void *data)
>  #else
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("7400_v2.9");
>  #endif
> +    mc->default_ram_id =3D "ppc_core99.ram";
>      mc->ignore_boot_device_suffixes =3D true;
>      fwc->get_dev_path =3D core99_fw_dev_path;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4fw+UACgkQbDjKyiDZ
s5K3hxAAvsiuunWfd6jDJZJAOF5MDShIsMQMwQgCqLxDFgKGJRAw3xUVmWVWR4V8
sjIzz160elXcgu1MSHGIFsC6r7mPgHHZCAIfAVVdTtq5UjAPgRySM7+MuasduNr2
sYC5e2FQ9KA9MEExRCm7NbVOzjq78T5wQBKdiigCwcRijSGzaJtpODB5T3BRFZOB
N5SU0/iJdnPTRHg+5YkjakfwM8K6TGRnrYLLFf+d58OpUiPlrsd4+rdaK+evuaik
/6O0rfQddeTcyQ8cVvpPdirRrcByigmLZoo8KqSq706TJNRsfvPiRS4SaIwWiL/H
y/JMt5O2EtiHgjw4pOngwP73FCGnffQUtmowU8WD9tZfHGP+vyXFaNxO6mwfub8P
O1D7yqZLe+/ia6mTTuDMpFGxSTcZYMttsZxgU2JzvAqt+7HtrZQnD/w5sW4g4PF4
8og9FosUXPV7qyr27Q72Vdx9on3XbhmPhpaDUbY+P8g6R79IubGFSq+ctX4I1EHS
Y3HBe0vAk8uG7NgMK0KNgg5z/mpfp30PSLRFJUnpDWcSqqHwauWegtyPVX4TuWD0
45pXe6tARZdAXJAiImnarNiwPqrGCy0q19DaiUqgfGREe7zfoswIFtjQjVIs67kD
XmQP0VdpOvwCpkkQkdepLyyelOaZIEEMTYv8+29j9e+B7mydJgU=
=uVLk
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--

