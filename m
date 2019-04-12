Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE4C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F552083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 02:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I7c/bDPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F552083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hElwM-0003w7-N8
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 22:29:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hElvb-0003d7-91
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hElva-0005l7-1X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 22:28:31 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59219 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hElvX-0005hM-7e; Thu, 11 Apr 2019 22:28:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44gMJ940SMz9s6w; Fri, 12 Apr 2019 12:28:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555036089;
	bh=LV9kNPmezaD93lYNlQeHtqWoMY5ynItwZK3DWUtbVwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7c/bDPI+VS793552ipvvEafMoA20kM5yhqxWBR72+pZW/VXNv+Ii0BRRjLM+0lYN
	uhmrLPzNOw+cU98GXjX4nMzydc1E5MV2GhbDVhaRD/ENln7aJlVkBGORuJyyMMwiHa
	LsuoFHuSlb6JkxbrdOGeITU/Y8c0Ac9df95PwFzk=
Date: Fri, 12 Apr 2019 12:24:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190412022451.GA8171@umbus.fritz.box>
References: <155500034416.646888.1307366522340665522.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <155500034416.646888.1307366522340665522.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH for-4.0] spapr_pci: Fix broken naming of
 PCI bus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412022451.f9wvsDXWdhkp1VqhGcrguJhBOt0zVYAnOxtZnBi82lY@z>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 06:32:24PM +0200, Greg Kurz wrote:
> Recent commit 5cf0d326a0fe fixed a regression which was preventing the
> guest to access the extended config space of a PCIe device. This was
> done by introducing a new PCI bus subtype for PAPR. The original fix
> was causing PCI busses to be named "spapr-pci-host-bridge-root-bus.N"
> instead of "pci.N", which was making upper layers unhappy of course.
> This got worked around by hardcoding the PCI bus name to "pci.0", but
> this only works for the default PHB. And we're now hitting:
>=20
> # qemu-system-ppc64 \
>              -device spapr-pci-host-bridge,index=3D1 \
>              -device e1000e,bus=3Dpci.0 \
>              -device e1000e,bus=3Dpci.1
> qemu-system-ppc64: -device e1000e,bus=3Dpci.1: Bus 'pci.1' not found
>=20
> David already posted some patches [1] to control PCI extended config
> space accesses with a new flag in the base PCI bus class instead of
> subtyping. These patches are a bit more intrusive though, and
> are targetted for 4.1.
>=20
> When no name is passed to pci_register_bus(), the core device code
> generates a lowercase name based on the QOM typename. The typename
> for the base PCI bus class is "PCI", hence the "pci.0", "pci.1"
> bus names. Rename the type of the PAPR PCI bus to "pci", so that
> the QOM code can generate proper names. This is a hack but it is
> enough to fix the regression. And all this will be reworked properly
> in 4.1.
>=20
> [1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D100486
>=20
> Fixes: 5cf0d326a0fe
> Signed-off-by: Greg Kurz <groug@kaod.org>

Oof.  That's a hack-and-a-half.  But, I don't see a better way of
fixing this quickly, and as you say, I already have clean ups for this
ready to go for 4.1.  Applied to ppc-for-4.0, and I'll try to rush out
a pull request today.

> ---
>  hw/ppc/spapr_pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index f0b6b23afc9b..f62e6833b8c9 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1652,7 +1652,7 @@ static void spapr_phb_root_bus_class_init(ObjectCla=
ss *klass, void *data)
>      pbc->allows_extended_config_space =3D spapr_phb_allows_extended_conf=
ig_space;
>  }
> =20
> -#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
> +#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
> =20
>  static const TypeInfo spapr_phb_root_bus_info =3D {
>      .name =3D TYPE_SPAPR_PHB_ROOT_BUS,
> @@ -1761,7 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>      memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
>                                  &sphb->iowindow);
> =20
> -    bus =3D pci_register_root_bus(dev, "pci.0",
> +    bus =3D pci_register_root_bus(dev, NULL,
>                                  pci_spapr_set_irq, pci_spapr_map_irq, sp=
hb,
>                                  &sphb->memspace, &sphb->iospace,
>                                  PCI_DEVFN(0, 0), PCI_NUM_PINS,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyv9vAACgkQbDjKyiDZ
s5LCyA//f9GzAFnkdKFAepx4OnZkHcHpQyHHwFzQzgUtECyCUvCqFRCvskaWdOuE
7g0eVVhpGEb98zCPVV2oQxKGs8lu6EB0e4kQEofb9WCfKZrYJ5fG+lKqsmCs0glW
DWEvWx+ZDHUa0NDxzVuivLT0RxThKyw3yq0ya7lkQJ2N2dO1/8/VFxVXi4yLt5pc
RHcZNdeQnemYMOp5PZOtKapfr+AqecW9KqA2m/3mcLs/edHAZBQnofP88OYCdsBk
ttweMwM0CFl3sbTgULJ9a9AOH9JrCdYknRYkYRGBxOaeNqJSoTYc2AR5C+XNY4bi
z27R698Z43UY1WdhI5m9Fx8uBsPoXzYDukB90UQz415TG7977gXCT0b2EzYNrulp
BCnaIw9sOTlFhuyJhrag/wt03rNPDZ9lB0+7ByOAVwL4xY08Rv5vy3XwnyDlAgod
BbOGmrjITrHr9AjmBcxNCNvFLzPt4+qUG/X9IOXaxbIZThhD4iup/rgOavK8mqjk
9Z3UPAHEoY5UPLQh1FqRVBPTJIEk6AUKoXT7pSdFM4AoZFCr0FAsPHeQEwsU7y+2
Gk1FZ4NLPHj+nVjeDsLzxm42GQTR5rLt4Vc+0j7Hwf20yiZQyd6WeJyzRdvg47VE
StF+Po5wYGHtZkbG2FuUg0q475A1uyntUsZ1p+go+2zOZ1MWiZc=
=AFHK
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

