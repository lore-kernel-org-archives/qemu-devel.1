Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D3C43141
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE1E22440
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 22:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="agQNzygw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE1E22440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXBdX-00043q-Dw
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 17:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb3-0002IX-0D
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXBb1-0007pR-66
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 17:03:40 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45689 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXBb0-0007nF-QA; Tue, 19 Nov 2019 17:03:39 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HfwP0b5mz9sPV; Wed, 20 Nov 2019 09:03:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574201013;
 bh=/mD7CGW7/rYFAPyyHxHGSXYZMYX0p6LQfbfLh4dNVm0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=agQNzygw07RfGJZG3uOEql+llKW+0u2q2OpGVplSl8RMj2vNAWcj6iH4EAgTPT39c
 Gj/so6uE5EaukpNUGiLszZUSijh6RM4aHY0dHmnj2TD25+F/2/dRhb/nVZkD0tTpzZ
 F/Il7VOUXw878tQdtlErnfZHKaPcIvcQ+dFAtVlI=
Date: Wed, 20 Nov 2019 08:52:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0] xive/kvm: Trigger interrupts from userspace
Message-ID: <20191119215215.GT5582@umbus.fritz.box>
References: <157408992731.494439.3405812941731584740.stgit@bahia.lan>
 <f81b87b2-c6c9-9c12-2929-adbb341cd391@kaod.org>
 <20191119004713.GF5582@umbus.fritz.box>
 <50ff4d1f-6576-0fc3-e1d5-9600cdbef5e4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l4+/aJnPlhOv5JVj"
Content-Disposition: inline
In-Reply-To: <50ff4d1f-6576-0fc3-e1d5-9600cdbef5e4@kaod.org>
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


--l4+/aJnPlhOv5JVj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 09:15:52AM +0100, C=E9dric Le Goater wrote:
> On 19/11/2019 01:47, David Gibson wrote:
> > On Mon, Nov 18, 2019 at 04:37:16PM +0100, C=E9dric Le Goater wrote:
> >> On 18/11/2019 16:12, Greg Kurz wrote:
> >>> When using the XIVE KVM device, the trigger page is directly accessib=
le
> >>> in QEMU. Unlike with XICS, no need to ask KVM to fire the interrupt. A
> >>> simple store on the trigger page does the job.
> >>>
> >>> Just call xive_esb_trigger().
> >>
> >> Yes but the KVM XIVE device does a few other checks.=20
> >>
> >> It checks that the interrupt was correctly initialized at the KVM devi=
ce
> >> level. We should be fine in QEMU which has similar checks.
> >>
> >> It caches the LSI assertion level. We should be fine also because it is
> >> useless in KVM when using the XIVE native exploitation mode.
> >>
> >> It checks it is not a passthru interrupt. Any idea on how to check thi=
s=20
> >> condition under QEMU ?=20
> >> =20
> >>> This may improve performance of emulated devices that go through
> >>> qemu_set_irq(), eg. virtio devices created with ioeventfd=3Doff or
> >>> configured by the guest to use LSI interrupts, which aren't really
> >>> recommended setups.
> >>
> >> LGTM.
> >=20
> > Ok, between the comments above and this, I'm not sure if this is ready
> > to merge or not.
>=20
> I think it is.=20
>=20
> With this change, we are loosing a check on passthrough interrupts but=20
> I am not sure how critical this is given that QEMU can anyhow bypass=20
> KVM and trigger the interrupt using a store on the ESB page.=20
>=20
> >> Any figures to share ?=20
>=20
> I am torturing Greg to have numbers :) but he resisted well.
>=20
> >> C.
> >>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Let's move on.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Works for me.  Applied.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l4+/aJnPlhOv5JVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZA8ACgkQbDjKyiDZ
s5JY7Q//WFxXpx7cw2B4pCVNEWCcv1UxmbKX96H5J1mXaMwmYHFv9axTmRCWAcs6
M+G/HZSOx2bB1o9NW0HwIzaKspzVaO6YO3xLqikCH/vYRykKkijhlPpaT//Ak11S
d6tGzwgxgIq0tTWxN056zanjMoBhUzAuzSNevIyD7HdzPYMkAIQ1SxRj1dlH3K14
gcJR+upmdS6ik3PjGdte70KshP48G7hYmBjQuEXNTiyBF6WtdHbHUwA201avvl5D
j07pombTyTrPpTqq28TiDVjVg1dqiLrrC73vjYARBQuGUxgiaHZzbY1e/vi2kXyA
Mwg6CxLtnEtBGoChD5DGjhVisYZ03NtoGw96g3qknr7W/ecpicwNtfeJ6vFRnEEq
IyfFJQc+FBP2s8Vzxiz4VU947rEV0wx1VcOQXzwqXQOaAew/ZfIZRAguxcCwTC5Z
tnwGKCfTadzONm7LTJT9YiG+WHFKjIOLY+pJBbYc0DlHK3MPMqNEUMY+2tIDtvE2
59XApxE2Ji/FnosT07k0dXhU7h7ulVSySEo1PF/D068s6DvlI2mS68O4OVJsg9PZ
NNwHqbJt2lSAAq9U4B8nDl67H0MU4Rzjk7Too+WmoexogMPK4juDECGEL59a8P6D
kqYag0RqZNmvWP09WacBQ6iisgaC7UGdAQF8bTKfM/KXb5rfkIU=
=xpPh
-----END PGP SIGNATURE-----

--l4+/aJnPlhOv5JVj--

