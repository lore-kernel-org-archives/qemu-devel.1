Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39FC28CBC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 02:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60A8206EB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 02:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BoC4y8QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60A8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVQaK-0008ED-Ub
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 22:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVQZl-0007p7-Gk
 for qemu-devel@nongnu.org; Sun, 03 May 2020 22:11:21 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVQZj-0004UT-8I
 for qemu-devel@nongnu.org; Sun, 03 May 2020 22:11:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49FmYS2vyNz9sSr; Mon,  4 May 2020 12:11:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588558268;
 bh=OdX1cJ/pt8jzYenPqNfmQDbnc+BKdvRRXG7JYCe/wnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BoC4y8QJxY5G5Ok+3CEdDkVoboqn2GM9eQ+elEZTvKjwgOzpWrDkz2PRrO6JwlCqy
 /WiqTJXgS0l5qs98j2EpZicqa7x8c3ilux1147yCl+H31kfQvi9Er+40tO7eRgmJ8Q
 f8sqQ4x06ovn4nnmYwhxPWLcYh05310bQiO0S3pE=
Date: Mon, 4 May 2020 12:10:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
Message-ID: <20200504021047.GA13695@umbus.fritz.box>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
 <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
 <877dxvke0o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <877dxvke0o.fsf@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 01:58:47PM +0100, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > On 5/1/20 1:15 PM, Alex Benn=E9e wrote:
> >> This seems to be timing out quite often and occasionally running out
> >> of disk space. Relegate it to light duties.
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> ---
> >>   .travis.yml | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> diff --git a/.travis.yml b/.travis.yml
> >> index 49267b73b3..fe708792ca 100644
> >> --- a/.travis.yml
> >> +++ b/.travis.yml
> >> @@ -458,7 +458,7 @@ jobs:
> >>             - genisoimage
> >>         env:
> >>           - TEST_CMD=3D"make check check-tcg V=3D1"
> >> -        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTM=
MU_TARGETS},ppc64le-linux-user"
> >> +        - CONFIG=3D"--disable-containers --target-list=3Dppc64-softmm=
u,ppc64le-linux-user"
> >
> > Cc'ing David, since I'm not sure about this one... Maybe split as we
> > did with other jobs?
>=20
> We could do but it lengthens the run even more. Having
> ppc64le-linux-user ensures we exercise the majority of the TCG code
> generator so I think the only area we aren't covering is the PPC TCG
> softmmu backend. We could add another softmmu target but I didn't want
> to play favourites.

Hrm.  I'd prefer not to drop this coverage if we can avoid it.  What
we're not testing with the proposed patch is TCG generation for a ppc
host but a non-ppc target.  e.g. if the x86 or ARM target side generates
some pattern of TCG ops that's very rare for the ppc target, and is
buggy in the ppc host side.

I'll grant you, bugs that specific aren't particularly likely.  But,
such a regression would also be very unlikely to be caught by ad-hoc
testing, so it would be good to have at least some coverage in Travis.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6veaUACgkQbDjKyiDZ
s5I1SBAAzIJ53CCI9hEzmVW1XsYM1m9k2tfinrX32/FhXOKb6W5RfnIN/r6PGblM
fm9Hs3fY6Ynx9CL0oO2tdNQ4nsciaKJnfnckH5sD+sBUylmG9b9x3gnVeEHR7dGR
Ilhl6Q/x9Lgr0XIVcDq2Cmu6OmWRkoL+BDqu6OIqmZ8/XP5shWUe3Z3aZTNN6rLV
MPtS2HlOyTtddIgXdBmaL8nOB3wKlFwGgXorH9KONeGUmVScu9g4oFl1EDnnaXkI
6irqqnfVAcmD1InJjW92zS7XMrBGJnm2nqdGrjWyH0IEtJuojfBcjMiSYPyM1xh7
ol7JsXO+np5uCEAxQnxkhtMN+RMPQi+VTdZygqLcZprZRv4b4MTijPnagNlHYAYe
lN6Bc12wHYlxkKUxfiLtWx4wuV/QyXnVTtUjMZVfZQ7bRQguTRmC0zDJVZnCDZxS
e4MBQPmcAjNs/u1dv3Qa8Qb6ILqB3fD3tlHM6XVY3yEl4foTNoNutu8rRZKQrxlD
UjAoNidZan7YF9QpQErHapscPdIRq5KjDlNju0k+i0b+Ib1IbqojpMsKEwlPWvee
3zLL/oMe20uFBiIbYRc6DtBV7djMhmpVs9ONOK1jiEjOoe57FK9/h3KuXaaPH7ih
aJHicG0WTJ7pDKi2lPFq2UautMAKOvQaBWTgx16G3VXFVo9X7k8=
=l0jP
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

