Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337B0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F017E20795
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 00:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NtoeFyJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F017E20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTDq9-0004qg-Qt
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 20:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDp0-00046g-UX; Thu, 15 Oct 2020 20:42:14 -0400
Received: from ozlabs.org ([203.11.71.1]:48149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTDoy-0001oP-Ur; Thu, 15 Oct 2020 20:42:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CC6mb4v9Xz9sTK; Fri, 16 Oct 2020 11:42:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602808927;
 bh=QSCVYgt5dfSZdPnu/6X4zOVNFZwfUa6m8OormgP9o1Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NtoeFyJAQRP4ug64OFtcsbyRpSIURGtWcnFbVTYLP56jNHzW0M8rwEBAAmmjmaj3I
 Ga8pceyPeIJZf80/bpkMD62JMhjw3eOV9bOVXLPCe2+NXFagHKZPfAEiIPB4vn+3qE
 dtKWm7/7tF9uTqb8C4ynl1PNQGjFkDiLg7WjI5kU=
Date: Fri, 16 Oct 2020 11:42:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Move spapr_create_nvdimm_dr_connectors() to core
 machine code
Message-ID: <20201016004200.GG7078@yekko.fritz.box>
References: <160249772183.757627.7396780936543977766.stgit@bahia.lan>
 <20201013004014.GF71119@yekko.fritz.box>
 <20201013093344.644b5677@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20201013093344.644b5677@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:30:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 09:33:44AM +0200, Greg Kurz wrote:
> On Tue, 13 Oct 2020 11:40:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Oct 12, 2020 at 12:15:21PM +0200, Greg Kurz wrote:
> > > The spapr_create_nvdimm_dr_connectors() function doesn't need to acce=
ss
> > > any internal details of the sPAPR NVDIMM implementation. Also, pretty
> > > much like for the LMBs, only spapr_machine_init() is responsible for =
the
> > > creation of DR connectors for NVDIMMs.
> > >=20
> > > Make this clear by making this function static in hw/ppc/spapr.c.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > Hrm, I'm not really seeing the advantage to moving this.  It doesn't
> > have to be in spapr_nvdimm for data hiding, but it is related, and
> > spapr.c is kind of huge.
> >=20
>=20
> The only advantage is to give an appropriate scope to this function,
> as many other functions that create internal devices, eg. other DRC
> types or the default PHB for which a similar change was accepted
> 2 years ago.
>=20
> commit 999c9caf2eee66103195e1ec7580b379929db9d2
> Author: Greg Kurz <groug@kaod.org>
> Date:   Fri Dec 21 01:35:09 2018 +0100
>=20
>     spapr: move spapr_create_phb() to core machine code
>    =20
>     This function is only used when creating the default PHB. Let's rename
>     it and move it to the core machine code for clarity.
>    =20
>     Signed-off-by: Greg Kurz <groug@kaod.org>
>     Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>     Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> I agree that spapr.c is huge indeed (4943 lines) but this increases its
> size by _just_ 0.2 %. And there are certainly good candidates that
> landed in spapr.c by _default_ over the years but should rather be
> moved to their own compilation unit (eg. a bunch of FDT building
> functions for various resources or some hotplug related functions
> that don't need to access machine internals).

Good points.  Applied to ppc-for-5.2.

>=20
> > > ---
> > >  hw/ppc/spapr.c                |   10 ++++++++++
> > >  hw/ppc/spapr_nvdimm.c         |   11 -----------
> > >  include/hw/ppc/spapr_nvdimm.h |    1 -
> > >  3 files changed, 10 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 63315f2d0fa9..ee716a12af73 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2641,6 +2641,16 @@ static hwaddr spapr_rma_size(SpaprMachineState=
 *spapr, Error **errp)
> > >      return rma_size;
> > >  }
> > > =20
> > > +static void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spa=
pr)
> > > +{
> > > +    MachineState *machine =3D MACHINE(spapr);
> > > +    int i;
> > > +
> > > +    for (i =3D 0; i < machine->ram_slots; i++) {
> > > +        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i=
);
> > > +    }
> > > +}
> > > +
> > >  /* pSeries LPAR / sPAPR hardware init */
> > >  static void spapr_machine_init(MachineState *machine)
> > >  {
> > > diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
> > > index b3a489e9fe18..9e3d94071fe1 100644
> > > --- a/hw/ppc/spapr_nvdimm.c
> > > +++ b/hw/ppc/spapr_nvdimm.c
> > > @@ -106,17 +106,6 @@ void spapr_add_nvdimm(DeviceState *dev, uint64_t=
 slot, Error **errp)
> > >      }
> > >  }
> > > =20
> > > -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr)
> > > -{
> > > -    MachineState *machine =3D MACHINE(spapr);
> > > -    int i;
> > > -
> > > -    for (i =3D 0; i < machine->ram_slots; i++) {
> > > -        spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM, i=
);
> > > -    }
> > > -}
> > > -
> > > -
> > >  static int spapr_dt_nvdimm(SpaprMachineState *spapr, void *fdt,
> > >                             int parent_offset, NVDIMMDevice *nvdimm)
> > >  {
> > > diff --git a/include/hw/ppc/spapr_nvdimm.h b/include/hw/ppc/spapr_nvd=
imm.h
> > > index b834d82f5545..490b19a009f4 100644
> > > --- a/include/hw/ppc/spapr_nvdimm.h
> > > +++ b/include/hw/ppc/spapr_nvdimm.h
> > > @@ -31,6 +31,5 @@ void spapr_dt_persistent_memory(SpaprMachineState *=
spapr, void *fdt);
> > >  bool spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice=
 *nvdimm,
> > >                             uint64_t size, Error **errp);
> > >  void spapr_add_nvdimm(DeviceState *dev, uint64_t slot, Error **errp);
> > > -void spapr_create_nvdimm_dr_connectors(SpaprMachineState *spapr);
> > > =20
> > >  #endif
> > >=20
> > >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+I7FgACgkQbDjKyiDZ
s5K42A/+MBDZbqwQvEb7Rg9GtjRqYNXKuFOrKvpTpqmGWHKzfIOHOrjOpVYHNMZt
ajWTaiwLHJb2iMqC95KAeSmOnjfVaNIqse4vk5DM0BcMuqpbeSFc+OpswvWVRJeJ
1Y3TqZ3wMRUgYLuf5FjbLOykg4jNJCaDEdPfJNY3A3wBNvOz/fYSJecTM1LNcyn8
EZfO3uCsjLOQtHlRKW2tfZQ2wvqGJ/9jUXobBMfwSHbApJXHN/NeDk5yI3gERST0
gdy4tPJWGuvUv5lazBPlOc6l+9Oa+d1LvtUtcNvSokcEu/4lhUNzKicbVnQYwPIf
clLCT9MA30XHWicXcN/kdZq27YghbnqSz01a/2dI/beUVhe5UB5zYbO121sEP2/U
rPdyjBy7lwp+QEA9Eo1ksRJdZ3MBt0V8cyPOksjFohvKMSNFQpZOgBEkQINzWO40
1Itkq61P9CeorITGx8akdBbaFSxLVA6UJ2cOEGmeoha5ViBNl48cP4Gtu4WbXVps
EH0QHWza+bkFDki8GcJ2mXt1h6HAyKA3ifBVNxLk5rmdWDboejO4NkBdciyJjx6K
AZZBiuPIBomLHGWVzXHoCC9yDx4cw0q3E+RveuNF9BoG72bZhOO7IxUK+TT8rpcj
15y4c6+CoiWKHKhpTmwcbjPA4CKigw4exabX8Ss4uEo2uoLuqwU=
=ZSep
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--

