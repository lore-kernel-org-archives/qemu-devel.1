Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A100C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 09:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5E720719
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XyRmEItX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5E720719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYRnO-0000S6-V0
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 04:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iYRmj-0008ML-AF
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 04:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iYRmh-000760-O4
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 04:32:56 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:49439 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iYRmg-00073d-LY; Sat, 23 Nov 2019 04:32:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Kp4C2RDBz9sPc; Sat, 23 Nov 2019 20:32:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574501563;
 bh=bi17XhG6IXPhqsvEU4h98tcF6Ipm7+ozCiCX17Wm/9M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XyRmEItXnIjJ78X/WqsUdj5MPRNHGSygsSUENpq8ga6bvzT2zCA8HNsLyoEUzw6hj
 7LUB7e+zGGSfrPQziIZGva7XGC867IkyEyi/la1KixF1BAymPodFHUxhmVj+e2SqXY
 6C3l3iK8Lgs0wgFlHBRGy1uy/KPNdMuM6c1L9tRo=
Date: Sat, 23 Nov 2019 20:25:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 00/23] ppc/pnv: add XIVE support for KVM guests
Message-ID: <20191123092524.GG5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <3a76eea8-9009-8762-be89-c2c045db8721@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jUCoXxerhcimRwK6"
Content-Disposition: inline
In-Reply-To: <3a76eea8-9009-8762-be89-c2c045db8721@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jUCoXxerhcimRwK6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 07:17:05PM +0100, C=E9dric Le Goater wrote:
> On 15/11/2019 17:24, C=E9dric Le Goater wrote:
> > Hello,
> >=20
> > The QEMU PowerNV machine emulates a baremetal OpenPOWER system and
> > acts as an hypervisor (L0). Supporting emulation of KVM to run guests
> > (L1) requires a few more extensions, among which guest support for the
> > XIVE interrupt controller on POWER9 processor.
> >=20
> > The following changes extend the XIVE models with the new XiveFabric
> > and XivePresenter interfaces to provide support for XIVE escalations
> > and interrupt resend. This mechanism is used by XIVE to notify the
> > hypervisor that a vCPU is not dispatched on a HW thread. Tested on a
> > QEMU PowerNV machine and a simple QEMU pseries guest doing network on
> > a local bridge.
> >=20
> > The XIVE interrupt controller offers a way to increase the XIVE
> > resources per chip by configuring multiple XIVE blocks on a chip. This
> > is not currently supported by the model. However, some configurations,
> > such as OPAL/skiboot, use one block-per-chip configuration with some
> > optimizations. One of them is to override the hardwired chip ID by the
> > block id in the PowerBUS operations and for CAM line compares. This
> > patchset improves the support for this setup. Tested with 4 chips.
> >=20
> > A series from Suraj adding guest support in the Radix MMU model of the
> > QEMU PowerNV machine is still required and will be send later. The
> > whole patchset can be found under :
> >=20
> >   https://github.com/legoater/qemu/tree/powernv-4.2
>=20
>=20
>  [ ... ]
>=20
> > C=E9dric Le Goater (23):
> >   ppc/xive: Record the IPB in the associated NVT
> >   ppc/xive: Introduce helpers for the NVT id
> >   ppc/pnv: Remove pnv_xive_vst_size() routine
> >   ppc/pnv: Dump the XIVE NVT table
> >   ppc/pnv: Quiesce some XIVE errors
> >   ppc/xive: Introduce OS CAM line helpers
> >   ppc/xive: Check V bit in TM_PULL_POOL_CTX
> >   ppc/xive: Introduce a XivePresenter interface
> >   ppc/xive: Implement the XivePresenter interface
>=20
> David,
>=20
> I have reworked the following patches to address Greg's comments=20
> and your comment on "ppc/pnv: Dump the XIVE NVT table".=20
>=20
> Shall I wait for some feedback from you or just resend ?

Just resend, thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jUCoXxerhcimRwK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3Y+wIACgkQbDjKyiDZ
s5Lr3Q//Xbr9q6lluA7u12xf46657YezIItHNAFVSYLlNEQGdCXHnISJ4t5dcZPJ
H0hPHlD8Mzi7ovwI1COLYv62gjoigxnGORIIMfC8BLsLPSpf3OLOLm8SrqrCZAEC
RGnqNmZUSh203gh71w4jEuUSjThZTVpjPHkj4uB2gNLzn4x3xTIyctbQWmJ/SBWJ
Q/cVFimtxBvkWyCcZu4mAVA3sS/UodzD3JV3ubLbDZbEt0UqfOpqyFSRAAKFHCyP
FysotfK3bJhP9pFGPiCRq7swcnmWsYpYrNVsNJQtUPHNMK5uvEWLO1ENQok76rKy
4LpSAMDThJUyJ0DF6pzX1EHxxbds8CPSj5fAsT66cVAhuakp581qEx60HfQusWD5
xJaaE4R/oyLsz0Oc7ems7Z86QjofM7f9AipjnvYb1EFZBpEewgBbn6lv/ST2rjE+
/J5J1Ah1yM0MKQJPXD03OGWB1PKUQR8YP6XetK4zbShdstNXgNx7SGV5eIS8PPt2
FzPYYb7KMG08mj9Euw8JL8UfIePsFz8THeOgwongx4raJ5ud7mHqpHajTktgxpQv
J8R9d11TOtlRYa+1HOD7AIRkzAjoLgRBBGOa9u4Ssgqr40lJ+fpHM+0ar+lFijwA
HDeNqbIFnXlj34EZuEU2tZtGlpqVaPhXsgBwlq50XmRNpdWomNo=
=bReB
-----END PGP SIGNATURE-----

--jUCoXxerhcimRwK6--

