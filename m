Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E9C10F26
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 05:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EE3206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 05:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j/gCoYli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE3206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGFma-0001Vy-Mz
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 01:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGFlr-00011W-Vi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 01:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGFlq-0003YX-Ew
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 01:37:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48763 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGFlp-0003Xy-4U; Mon, 23 Mar 2020 01:37:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48m36N4D0yz9sRN; Mon, 23 Mar 2020 16:37:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584941820;
 bh=7BoE+53EUCUg6D8bi7ede19r1O1FERpJK/W3l+RHmDo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j/gCoYliX8NUl9eMUGtRabeXxoUcWS6CwbWXFl5BV2bpVWNVuFLB4W0aHgLBbCaQP
 7puIdXmSAqTIG+P72rammAItTX+0zFN4tQWeL3rsrGYTdAYi5U/bl8PpPzSA3U24Xn
 cbMndv7zq7xKHwz1DDO0BenZlm8qUU393ZUjtQUo=
Date: Mon, 23 Mar 2020 15:50:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Willian Rampazzo <wrampazz@redhat.com>
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Message-ID: <20200323045050.GF2213@umbus.fritz.box>
References: <20200211134504.9156-1-philmd@redhat.com>
 <87eeuewv4k.fsf@linaro.org>
 <20200310014116.GF660117@umbus.fritz.box>
 <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
 <20200311045449.GX660117@umbus.fritz.box>
 <CAKJDGDZpRrtSVkH0+h0ec8bfnAvfQGftTu7whOn9hXpYLLnDqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Content-Disposition: inline
In-Reply-To: <CAKJDGDZpRrtSVkH0+h0ec8bfnAvfQGftTu7whOn9hXpYLLnDqA@mail.gmail.com>
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 12:59:44PM -0300, Willian Rampazzo wrote:
> > That certainly sounds like an improvement.  I still don't love the
> > idea that the test results will vary based on something outside of the
> > tested code, even if a cancel is definitely better than a fail.
>=20
> During the development of Avocado release 76.0, we have discussed how
> to implement a new resolver that gathers requirements listed for a
> test and fulfills them before the test starts. The discussion resulted
> in blueprint BP002 [1]. We are in the last development week of release
> 77.0, so the development of this new feature should start during the
> next release cycle.
>=20
> >
> > > +Willian can explain how it works, and if found to be suitable, and w=
ork
> > > on a patch.
> >
> > Ok.  That would be good to know - will there be some command to run in
> > advance to attempt to download all the necessary images?  Would that
> > run without a timeout - or at least a much longer timeout than the
> > testcase itself has.
>=20
> In the current release development (77.0), we are adding a feature
> that makes it possible to cancel a test if an asset is not available
> in the cache. It should be as simple as setting two parameters during
> the fetch call, like:
>=20
> bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash,
> find_only=3DTrue, cancel_on_missing=3DTrue)
>=20
> Release 77.0 of Avocado is scheduled for the beginning of next week.
> As soon as it is available, I can send a patch to bump the Avocado
> version for qemu tests and a patch to this test enabling this new
> feature.
>=20
> Since avocado 73.0, it is possible to fetch the assets from a test
> without actually running the test. It is a feature that parses the
> test code looking for the fetch_asset call and its parameters defined
> as variables, at a limited depth. I have tested it on ppc_prep_40p.py,
> and it works as expected. This command does not have a timeout for
> fetching the assets and is as follows:
>=20
> avocado assets fetch ppc_prep_40p.py
>=20
> The upcoming feature to cancel the test when an asset is not available
> used in conjunction with the command line fetch should give some
> flexibility to people running this test while the resolver is under
> development.

I saw how this worked when I did my last batch of pre-pull tests.  It
was way better than how it used to work (when I had at least a half
dozen that failed or skipped unpredictably depending on how long the
download took).

Great work, thanks!

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl54QCoACgkQbDjKyiDZ
s5LWrw//UYsRwjoxSLb5Zjdw+DMZbj4nDovwdd2dgMYxVTjdr0F2ugw4htTnZWyZ
1KeHxBhd7MnF84rkfIazuwc79AIw3UCySNDZUFecC3r1XnnBdUGuFGkEOiuW13rP
9fP1nXxwabJQjmuDNv6yZNOu4fV0nLX24iXyfUxM5zOl5lKwg4lPPTpwc5UUkMVs
T8OMZYex4/IEsLALHoMsnXOuE7moK20isFI7sg53+eRtjrYjKgsxNJrd2UFBLE/k
mHj/BneU9AmNffNNyfZ9Z+2hgjnUiL55uSacztpcMLtJkZI/qbOEzSkjf+Y+r8dV
FgsEluQAE9zA6gOAPWPZspUNwU3Q2Ph8qvqgNmIbopqFSqngU5tcT2ehPiQVDnpQ
L+ZQB4heeKNydmKIdh2D+Jy/xrSUoWMtEt6V+bzSAZEC7XdpM5IeQfL979Vkvwwi
0k8SiAdcGGwrnANT47EmySom0ifPEAsuavRbD8Qm5gZOKlB4XXU/8ABJ7AzFJyfu
Jhvtsu/8NFrgjBNiJpxsBgNK2ItBnxLjivs+gLKUbk/86N91qC8qDn8hcvBBW6Zd
83uzTuFCU1FgIzOqvYZwyXjSK4w5bCQSc4HQwTtsJux1cSzjCXz9wYpbNVKKMzXW
C3EMwhI58asazRqpuPl/bu57RCzsik91XnM4dX+eS4r7Gol7v5U=
=uXi7
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

