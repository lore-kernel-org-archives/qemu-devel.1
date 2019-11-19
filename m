Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0C9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 01:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F96522310
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Iy22A/3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F96522310
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWruB-0007Oc-1j
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 20:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrsX-0006pQ-KV
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 20:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWrsW-0001qY-Dv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 20:00:25 -0500
Received: from ozlabs.org ([203.11.71.1]:56115)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWrsW-0001oz-2A; Mon, 18 Nov 2019 20:00:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47H6tq5YhSz9sPV; Tue, 19 Nov 2019 12:00:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574125219;
 bh=PsSDjfi61zbflZICabmIrHcXIAPqJQq/L2+4OMfn2nE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iy22A/3Sc4EJUbGUcrcTMHXfDTWA15hJvKZ/ssM3vhx+BZ6KGDfSIrMDQyYjg+XT5
 V3aVJmyMm8w226k1Ewi+O1tQaBpaWgoWTqSXrzZdau1uIMC4GuT0IFBex6lFVN9YpA
 MbLtUGWqwID/p1A3mwS2JxEmp5VDzs6+689lra0Y=
Date: Tue, 19 Nov 2019 12:00:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] spapr: Fix VSMT mode when it is not supported by the
 kernel
Message-ID: <20191119010012.GI5582@umbus.fritz.box>
References: <20191108154035.12913-1-lvivier@redhat.com>
 <20191108174759.2d4040f1@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Content-Disposition: inline
In-Reply-To: <20191108174759.2d4040f1@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-ppc@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 05:47:59PM +0100, Greg Kurz wrote:
> On Fri,  8 Nov 2019 16:40:35 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
> > Commit 29cb4187497d sets by default the VSMT to smp_threads,
> > but older kernels (< 4.13) don't support that.
> >=20
> > We can reasonably restore previous behavior with this kernel
> > to allow to run QEMU as before.
> >=20
> > If VSMT is not supported, VSMT will be set to MAX(8, smp_threads)
> > as it is done for previous machine types (< pseries-4.2)
> >=20
>=20
> It is usually _bad_ to base the machine behavior on host capabilities.
> What happens if we migrate between an older kernel and a recent one ?

Right.  We're really trying to remove instaces of such behaviour.  I'd
prefer to completely revert Greg's original patch than to re-introduce
host configuration dependency into the guest configuration..

> I understand this is to fix tests/migration-test on older kernels.
> Couldn't this be achieved with migration-test doing some introspection
> and maybe pass vsmt=3D8 on the QEMU command line ?

=2E.adjusting the test case like this might be a better idea, though.

What's the test setup where we're using the old kernel?  I really only
applied the original patch on the guess that we didn't really care
about kernels that old.  The fact you've hit this in practice makes me
doubt that assumption.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TPpwACgkQbDjKyiDZ
s5Lh2w//elWGoxSXj8vo1T1pxDrgVMgVp70k40oilWPHE4faKFP/jfTq+OpGIxQP
yLHyMnKQLITtC6ITjhThfJ6pwlYetumbIeI0SRqHgHnPIHJCMnOeV2V61Ly93IVK
e/9pPwI/BzT/P9MXOOcOz1vl4aMRKAFoj75mgiFl1Dujy1XRK21YJgIh0ziSfyPW
IczycAOMzPw0Q2MkAlTlHJWRpxP3mh0LHTOpC4tiZxTWxruwQ+mBGKF3ea+UMVXk
AcWjGZdGfnPJCyn69q9hiexNSW3BnqF7cO7R7YpEo3hG97aNyjIeI0CM4aGBUpUG
8x1/bp7V6U8s1ztLHhNVUgNGiuNr8/N4DFnkOwU0ek15mRaeDsvS44j9knwiC7Pm
rx6xy7GdK1irVePC+MZJHIju5XY+tnSgfBx4qxh7Iy4yqtxEJUvl7BjA9QN88OE2
yrMTyRIwwYqrd/T8plju+OIpe4GUmbesnT1IMNlp9E4hhwt4DyHoIO+ns7C0Hl8/
FF3dScf4g4DUpH90HCiT77Xxew2Jzpcxr3TU0e4oaCeecFzkwqyt8HZCC69fFZMA
UQYX4iOFIA5A1xAFvaAgqldGR036w7D0Od0PWYg9s4W0+lOkrfNcr/w8WywwNYot
DHLnFhNz910GS9A2aTibkFf96cNNyi31bbPq2MsCPKdA1+gt++Q=
=p1Tk
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--

