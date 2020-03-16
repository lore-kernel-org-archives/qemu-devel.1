Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2EA205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 23:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eZNcYdO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2EA205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDzEx-0000x1-4D
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 19:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDa-0007dW-Nb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jDzDZ-0005fj-77
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 19:32:22 -0400
Received: from ozlabs.org ([203.11.71.1]:55155)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jDzDY-00050P-9e; Mon, 16 Mar 2020 19:32:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hCJJ3hCdz9sRY; Tue, 17 Mar 2020 10:32:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584401536;
 bh=9e5ApgCXvMxcdcANt5BvHOIJ1GwEe2q7CwyDoxato00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eZNcYdO0B6Oo98vWu0an7XiFFdQSqUI6xZYi+5hM7KFqHShl0DPMoi0RO50Gcvuas
 UrUJjRvWUBCW1yTmwP+2vXG+EK4B+5wlMp5xtyALVlqxywyGyxH5F88xfgG+ylJXmc
 cIyvVNObHqVaaYKEtEOJOryA6brhVFUgFhvoBS5M=
Date: Tue, 17 Mar 2020 10:31:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 7/8] ppc/spapr: Implement FWNMI System Reset delivery
Message-ID: <20200316233135.GH20264@umbus.fritz.box>
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-8-npiggin@gmail.com>
 <20200316173500.576hdvush3fzvvef@in.ibm.com>
 <20200316185254.1aca6e20@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline
In-Reply-To: <20200316185254.1aca6e20@bahia.lan>
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Ganesh Goudar <ganeshgr@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 06:52:54PM +0100, Greg Kurz wrote:
> On Mon, 16 Mar 2020 23:05:00 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>=20
> > On 2020-03-17 00:26:12 Tue, Nicholas Piggin wrote:
> > > PAPR requires that if "ibm,nmi-register" succeeds, then the hypervisor
> > > delivers all system reset and machine check exceptions to the registe=
red
> > > addresses.
> > >=20
> > > System Resets are delivered with registers set to the architected sta=
te,
> > > and with no interlock.
> > >=20
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > >  hw/ppc/spapr.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 25221d843c..78e649f47d 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -967,7 +967,29 @@ static void spapr_dt_rtas(SpaprMachineState *spa=
pr, void *fdt)
> > >      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
> > >                       maxdomains, sizeof(maxdomains)));
> > >=20
> > > -    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_SIZE));
> > > +    /*
> > > +     * FWNMI reserves RTAS_ERROR_LOG_MAX for the machine check error=
 log,
> > > +     * and 16 bytes per CPU for system reset error log plus an extra=
 8 bytes.
> > > +     *
> > > +     * The system reset requirements are driven by existing Linux an=
d PowerVM
> > > +     * implementation which (contrary to PAPR) saves r3 in the error=
 log
> > > +     * structure like machine check, so Linux expects to find the sa=
ved r3
> > > +     * value at the address in r3 upon FWNMI-enabled sreset interrup=
t (and
> > > +     * does not look at the error value).
> > > +     *
> > > +     * System reset interrupts are not subject to interlock like mac=
hine
> > > +     * check, so this memory area could be corrupted if the sreset is
> > > +     * interrupted by a machine check (or vice versa) if it was shar=
ed. To
> > > +     * prevent this, system reset uses per-CPU areas for the sreset =
save
> > > +     * area. A system reset that interrupts a system reset handler c=
ould
> > > +     * still overwrite this area, but Linux doesn't try to recover i=
n that
> > > +     * case anyway.
> > > +     *
> > > +     * The extra 8 bytes is required because Linux's FWNMI error log=
 check
> > > +     * is off-by-one.
> > > +     */
> > > +    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-size", RTAS_ERROR_LOG_MAX=
 +
> > > +			  ms->smp.max_cpus * sizeof(uint64_t)*2 + sizeof(uint64_t)));
> >=20
> > Currently the rtas region is only of size 2048 (i.e RTAS_ERROR_LOG_MAX).
> > Do we need SLOF change to increase rtas area as well ? Otherwise QEMU
> > may corrupt guest memory area OR Am I wrong ?
> >=20
>=20
> A change is pending for SLOF to use the "rtas-size" property
> provided by QEMU:
>=20
> https://patchwork.ozlabs.org/patch/1255264/

In the meantime, this is still correct.  Because we rebuild the device
tree at CAS time, the qemu supplied value will be the one the guest
sees in the end.  We obviously want that qemu update to avoid
confusion, but we don't need it for things to work.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5wDFcACgkQbDjKyiDZ
s5KDkg//at0M2IWgaP6aICdPwyQr+2iUpD7PMG5h4EoBhr7OjU9UWEDMj15popkR
6gXeaHG7qmNOrgJXXehpUcLIPbOJZV7wAv0PxJ5myqGMeISKMOQH94xgEF1PM56V
Ej7SgKC7fRyLaZTnZMNFx/FGjVXqOmGxPxqL7pu1d28MVBBebkjywp4iRXvseajm
AgmwAvif/kmIJigu2/J5sMIeYex9T18wAhn2uzm/gXR7u8cNhTuzhAi6nF5IiIyg
1EwI6s92faCflk4b6vDpm+4knsEFsXNdAo9mngu6BnC0l7rLQEnOMn2i2dfDyPf8
0kIfaoMdybuMhLi+YkOYW9tiKLzz+bfYFPGeZveXnQN8hkar/W18Cs2Dq6lhSzNt
iYGbP8cwg4Gs/ZcpmLx0nQ/pXRjWruErxK0Ovqz/ho+NULNNMPyKFeuD1XwqiLnv
C8fp5JtFy4xJhnAb7a1acRynuXmHoz3MAj6hY66WZdLgUtBx7KL98ky49RJZpUSR
N7gHSZoO+QiSdW80+cjRX8N/m7rnaQZI2xvm0frNvNUDluQbjWLv7MHPuWR729sE
/BD5djO9qV4KfUDLOcX9qRw3IJxLtMOHYTesLBRw39ZEa6DuZ/TyVJnSMNIgUIRX
hwGxqkhu+Zm6Hg8Mzc+DTLtmlB+rBegSr8iu0+AwNGZoy2eZgjw=
=2UZy
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--

