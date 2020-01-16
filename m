Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103AC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D432075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 04:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jxDYeasv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D432075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irwm8-0005sc-7k
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 23:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1irwkw-0004NK-27
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1irwku-0004y2-KC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 23:27:42 -0500
Received: from ozlabs.org ([203.11.71.1]:38201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1irwku-0004wk-8M; Wed, 15 Jan 2020 23:27:40 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47yrlF73F3z9sPW; Thu, 16 Jan 2020 15:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579148857;
 bh=lby+7OQlty8UIZ0varJoGZppZVfh/6knE6FXRFYaJzo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jxDYeasvUzTk41Y0RPlUtIkhIjgyF/kjLvn/0pzeJX+A+L84VuAHt+Q5T4u4ViE6y
 Sgm/H2+/5qK7DMa+nm6BIhOxYILCOlw96rO47UCBWQKbBYY+0iUKo+wqkmZl5Hv4jH
 dnPffnVB5nymxat9qsuPpY7UupWctQP7JZiQzaFg=
Date: Thu, 16 Jan 2020 14:27:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 69/86] ppc:spapr: use memdev for RAM
Message-ID: <20200116042726.GM54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-70-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Content-Disposition: inline
In-Reply-To: <1579100861-73692-70-git-send-email-imammedo@redhat.com>
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


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 04:07:24PM +0100, Igor Mammedov wrote:
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
>  hw/ppc/spapr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 30a5fbd..bcbe1f1 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2587,7 +2587,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>      PCIHostState *phb;
>      int i;
>      MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      hwaddr node0_size =3D spapr_node0_size(machine);
>      long load_limit, fw_size;
>      char *filename;
> @@ -2766,10 +2765,8 @@ static void spapr_machine_init(MachineState *machi=
ne)
>          kvmppc_enable_h_page_init();
>      }
> =20
> -    /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_spapr.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    /* map RAM */
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
> =20
>      /* always allocate the device memory information */
>      machine->device_memory =3D g_malloc0(sizeof(*machine->device_memory)=
);
> @@ -4344,6 +4341,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D "";
>      mc->default_ram_size =3D 512 * MiB;
> +    mc->default_ram_id =3D "ppc_spapr.ram";
>      mc->default_display =3D "std";
>      mc->kvm_type =3D spapr_kvm_type;
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDG=
E);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4f5i4ACgkQbDjKyiDZ
s5ItrxAA2XLaJT6Fo+nBXdWLuSoqvOOxptEadXeJq5WDrWjRAR6a6+Q1yUdh4t7k
/j3nz2GGbJNhbkUj2Zg96nS8DsaIW5GcOZJZfAGlDgf0VgdeD8YUfZSt9KGsg9KN
yo7aWoQuDLhD0vxxbAnMynPKVhJqM281lPcBdBa6XbrE3fNX6if0TjgOI1iq5hzs
F5biyirzYZEY/kXL1XWnCig30r/27WxyxEeNmpIBMHAbUhSyVXjyElUEcmRFTkbs
7VRJqVs+gQzY6vT5XPAe7d6kdN1ZbzjRZT+gocD6YjGQ+BY5apW+wTVCJNj8qt8w
SnVbGKhggr7pYMPeRsKG59YA8ZoDpO+eFvZkZJmREB0Z4Cw/0QqCsQdsTvnAjmcg
EjHGGc6jX5oQH/4/vRCRkREXm06aiYo2YxxiahZg7+vTGKdG5aK8KXQyn6IwvAiw
VIgqUE90EMaluIDKLU2IP52dNmoh7ocaVyMscLxLo2EGU//cVf9d48PRy20QN3EP
r5pQEX0UkcRetWlvmJNLjfZH2vDltApMNlM7B5c8t2qGe2FKqI6iagvEiB7mSMcB
nBjjHej7R0OJFWxBVYC82b25pvnP9vcijqhNvaqnLL1x2tAQV1QXilLl1T79xA6p
VoMNk9Uj+w9QXi/Bo+0DtII9BZtRJ7sie1EXhTqBhd8LDUmBiIA=
=8/s9
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--

