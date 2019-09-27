Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD62C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E42E207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pPHU7DA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E42E207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkSE-00031P-0d
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDkRE-0002ND-VZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDkRC-0001D1-RF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 03:13:12 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:35461 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDkRB-00010A-Lp; Fri, 27 Sep 2019 03:13:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46fjgM3yHBz9sPS; Fri, 27 Sep 2019 17:13:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569568383;
 bh=mLlqMdAaoXijkWwAJ7PNItjmmS97R5I19cGWJXGqMcc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pPHU7DA+aPVccnlpxMsMB3lOKsDuobFgCN3bobctp3YrJqdh2+EvFXAuzl2/ONtnj
 t+MS7PzCGFWHSbBWCZGvWrQYj/GrbOOoGOgcZRqWu/IurG05aPBAezNpcX5W/anpe8
 HdmlmW6g6p2VAQTUMELypGXpaAnFccBcPr9QaxUk=
Date: Fri, 27 Sep 2019 17:12:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr-pci: Stop providing assigned-addresses
Message-ID: <20190927071252.GA12116@umbus.fritz.box>
References: <20190927022651.71642-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20190927022651.71642-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 12:26:51PM +1000, Alexey Kardashevskiy wrote:
> QEMU does not allocate PCI resources (BARs) in any case - coldplug devices
> are configured by the firmware and hotplug devices rely on the guest
> system to do the assignment via the PCI rescan mechanism. Also in order
> to create non empty "assigned-addresses", the device has to be enabled
> (i.e. PCI_COMMAND needs the MMIO bit set) first as otherwise
> io_regions[i].addr are -1, and devices are not enabled at this point.
>=20
> This removes "assigned-addresses" and leaves it to those who actually
> do resource allocation.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This replaces:
> [PATCH qemu] spapr-pci: Provide either correct assigned-addresses or
> none

Applied to ppc-for-4.2, along with your earlier full fdt render patch,
which this now unbreaks.

>=20
> ---
>  hw/ppc/spapr_pci.c | 42 +++++++-----------------------------------
>  1 file changed, 7 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 6934d506a7e9..01ff41d4c43f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -836,7 +836,7 @@ static char *spapr_phb_get_loc_code(SpaprPhbState *sp=
hb, PCIDevice *pdev)
>  #define b_fff(x)        b_x((x), 8, 3)  /* function number */
>  #define b_rrrrrrrr(x)   b_x((x), 0, 8)  /* register number */
> =20
> -/* for 'reg'/'assigned-addresses' OF properties */
> +/* for 'reg' OF properties */
>  #define RESOURCE_CELLS_SIZE 2
>  #define RESOURCE_CELLS_ADDRESS 3
> =20
> @@ -850,17 +850,14 @@ typedef struct ResourceFields {
> =20
>  typedef struct ResourceProps {
>      ResourceFields reg[8];
> -    ResourceFields assigned[7];
>      uint32_t reg_len;
> -    uint32_t assigned_len;
>  } ResourceProps;
> =20
> -/* fill in the 'reg'/'assigned-resources' OF properties for
> +/* fill in the 'reg' OF properties for
>   * a PCI device. 'reg' describes resource requirements for a
> - * device's IO/MEM regions, 'assigned-addresses' describes the
> - * actual resource assignments.
> + * device's IO/MEM regions.
>   *
> - * the properties are arrays of ('phys-addr', 'size') pairs describing
> + * the property is an array of ('phys-addr', 'size') pairs describing
>   * the addressable regions of the PCI device, where 'phys-addr' is a
>   * RESOURCE_CELLS_ADDRESS-tuple of 32-bit integers corresponding to
>   * (phys.hi, phys.mid, phys.lo), and 'size' is a
> @@ -889,18 +886,7 @@ typedef struct ResourceProps {
>   * phys.mid and phys.lo correspond respectively to the hi/lo portions
>   * of the actual address of the region.
>   *
> - * how the phys-addr/size values are used differ slightly between
> - * 'reg' and 'assigned-addresses' properties. namely, 'reg' has
> - * an additional description for the config space region of the
> - * device, and in the case of QEMU has n=3D0 and phys.mid=3Dphys.lo=3D0
> - * to describe the region as relocatable, with an address-mapping
> - * that corresponds directly to the PHB's address space for the
> - * resource. 'assigned-addresses' always has n=3D1 set with an absolute
> - * address assigned for the resource. in general, 'assigned-addresses'
> - * won't be populated, since addresses for PCI devices are generally
> - * unmapped initially and left to the guest to assign.
> - *
> - * note also that addresses defined in these properties are, at least
> + * note also that addresses defined in this property are, at least
>   * for PAPR guests, relative to the PHBs IO/MEM windows, and
>   * correspond directly to the addresses in the BARs.
>   *
> @@ -914,8 +900,8 @@ static void populate_resource_props(PCIDevice *d, Res=
ourceProps *rp)
>      uint32_t dev_id =3D (b_bbbbbbbb(bus_num) |
>                         b_ddddd(PCI_SLOT(d->devfn)) |
>                         b_fff(PCI_FUNC(d->devfn)));
> -    ResourceFields *reg, *assigned;
> -    int i, reg_idx =3D 0, assigned_idx =3D 0;
> +    ResourceFields *reg;
> +    int i, reg_idx =3D 0;
> =20
>      /* config space region */
>      reg =3D &rp->reg[reg_idx++];
> @@ -944,21 +930,9 @@ static void populate_resource_props(PCIDevice *d, Re=
sourceProps *rp)
>          reg->phys_lo =3D 0;
>          reg->size_hi =3D cpu_to_be32(d->io_regions[i].size >> 32);
>          reg->size_lo =3D cpu_to_be32(d->io_regions[i].size);
> -
> -        if (d->io_regions[i].addr =3D=3D PCI_BAR_UNMAPPED) {
> -            continue;
> -        }
> -
> -        assigned =3D &rp->assigned[assigned_idx++];
> -        assigned->phys_hi =3D cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_=
n(1));
> -        assigned->phys_mid =3D cpu_to_be32(d->io_regions[i].addr >> 32);
> -        assigned->phys_lo =3D cpu_to_be32(d->io_regions[i].addr);
> -        assigned->size_hi =3D reg->size_hi;
> -        assigned->size_lo =3D reg->size_lo;
>      }
> =20
>      rp->reg_len =3D reg_idx * sizeof(ResourceFields);
> -    rp->assigned_len =3D assigned_idx * sizeof(ResourceFields);
>  }
> =20
>  typedef struct PCIClass PCIClass;
> @@ -1472,8 +1446,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb,=
 PCIDevice *dev,
> =20
>      populate_resource_props(dev, &rp);
>      _FDT(fdt_setprop(fdt, offset, "reg", (uint8_t *)rp.reg, rp.reg_len));
> -    _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
> -                     (uint8_t *)rp.assigned, rp.assigned_len));
> =20
>      if (sphb->pcie_ecs && pci_is_express(dev)) {
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", =
0x1));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2NtnIACgkQbDjKyiDZ
s5LHLw//azXKuGgwHeVfjf6Af0UPurNXI4BWbZm8A+DoHwGCJ+6cIOXWRy5HntVP
6lHQcM34L8mLYwVk1ARhwKCNzEOVjcg7BLhJEa3fAwpwkcEc/onLFci1tEKlz4Vl
AHcGOFQlAnS7WJAxIuAm+gouVDUEcUy2fRmnt3IReSfRvs+Q6w32KU4Y0i3dxcqQ
fOKAqPia1OpNEae+mui2etj93E1ZWGe3T2kYM1a98XpmM0xloGahIFhB1OXN+/kD
KwBCHmPtRQBqWuV4H9TLG7iYcQmuiph7meF4YJG1vyV/p7jMmum/ffpkkuEeTDKL
J9xBKn5YPKvt4VKnVxhFR0sx8me5lGOcLY4lc94sP8plCrWfmEnQR7T4v95XtLsn
zJUpmdMRZH2mJuz4TG2s3niuMWNZEPqKgKMwehcrdYI1Qzklc0l2bqFS0hiLlj0Z
+CaiLvCotweBQ3qTYi4B+ImNnFAZtdeRuWlsgxHecvy1bzhGY8jNjuWDQoH/6DSI
OwXgQSrZvkfe8zA2JGtdSwPJV5cdL4PcSE4sMtMcNHX/u5SFhJoCTQtxoc/pmgMr
ce/FP3DFzsECgFxLJdApegDEZjVqPVzFA1r+Oa2IbOAjAS7cYdKdW0b61STZLg6w
k6s03GIr3BTdXC8zLvqIXgvZscldedHo3eZVxWzH70dzYrxBres=
=4EeY
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

