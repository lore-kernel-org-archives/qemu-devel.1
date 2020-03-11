Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A048CC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFE5208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 04:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IFccpMIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFE5208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBtPM-0006re-JY
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 00:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtOa-000685-Ma
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jBtOZ-0004wi-5y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 00:55:04 -0400
Received: from ozlabs.org ([203.11.71.1]:39851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jBtOY-0004te-C7; Wed, 11 Mar 2020 00:55:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48cflQ10Xnz9sPJ; Wed, 11 Mar 2020 15:54:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1583902498;
 bh=dDGp86XhdllSd/56TNYK1wzc0vlSAAvvMKKtVm6eoMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IFccpMIfeYkBcgbN7F3BY6MLRvJVNyKFGYc094M8HAGKCAP7kjn4s1YsIqSTAEx34
 KCdTMm9kE7A/a0C9bNbEGUzVTDS9GapBSMgHNz7tIzQ3gCN+VbSRSGQ0QKNaHhXkQS
 6Uy9Jz46Xn74Sndbi5E8r+GYE8CrUvKxrGFubdEg=
Date: Wed, 11 Mar 2020 15:54:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
Message-ID: <20200311045449.GX660117@umbus.fritz.box>
References: <20200211134504.9156-1-philmd@redhat.com>
 <87eeuewv4k.fsf@linaro.org>
 <20200310014116.GF660117@umbus.fritz.box>
 <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mu6rDKe19l+MneQx"
Content-Disposition: inline
In-Reply-To: <517418432.204149.1583807554368.JavaMail.zimbra@redhat.com>
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mu6rDKe19l+MneQx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2020 at 10:32:34PM -0400, Cleber Rosa wrote:
>=20
>=20
> ----- Original Message -----
> > From: "David Gibson" <david@gibson.dropbear.id.au>
> > To: "Alex Benn=E9e" <alex.bennee@linaro.org>
> > Cc: qemu-devel@nongnu.org, "Wainer dos Santos Moschetta" <wainersm@redh=
at.com>, "Kamil Rytarowski"
> > <kamil@netbsd.org>, "Herv=E9 Poussineau" <hpoussin@reactos.org>, "Clebe=
r Rosa" <crosa@redhat.com>,
> > qemu-ppc@nongnu.org, "Philippe Mathieu-Daud=E9" <philmd@redhat.com>
> > Sent: Monday, March 9, 2020 9:41:16 PM
> > Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org =
hostname
> >=20
> > On Fri, Feb 28, 2020 at 04:10:19PM +0000, Alex Benn=E9e wrote:
> > >=20
> > > Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
> > >=20
> > > > Use NetBSD content delivery network to get faster downloads.
> > >=20
> > > Even with this patch I get failures on my big dev box:
> > >=20
> > >  (48/67)
> > >  tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and=
_netbsd:
> > >  INTERRUPTED: Failed to fetch NetBSD-7.1.2-prep.iso.\nRunner error
> > >  occurred: Timeout reached\nOriginal status: ERROR\n{'name':
> > >  '48-tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios=
_and_netbsd',
> > >  'logdir': '/home/alex/lsrc/qemu.git/builds/all/tests/results/jo... (=
60.31
> > >  s)
> > >=20
> > > I think ultimately a whole ISO download is just too much for an
> > > acceptance test.
> >=20
> > I tend to agree.  Here in a network-remote part of the world, these
> > always seem to cause timeouts and other problems, in a bunch of the
> > testcases.
> >=20
> > Those are testing useful things though, so I'd really like to see the
> > downloads split out into some sort of preparation step that can be
> > done just once, rather than part of the test proper.
>=20
> We have added functionality in the latest Avocado that will let us
> easily set a "cancel this test if the ISO has not being previously
> downloaded", or "cancel if it fails to be downloaded during the
> test".

That certainly sounds like an improvement.  I still don't love the
idea that the test results will vary based on something outside of the
tested code, even if a cancel is definitely better than a fail.

> +Willian can explain how it works, and if found to be suitable, and work
> on a patch.

Ok.  That would be good to know - will there be some command to run in
advance to attempt to download all the necessary images?  Would that
run without a timeout - or at least a much longer timeout than the
testcase itself has.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mu6rDKe19l+MneQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5obxkACgkQbDjKyiDZ
s5IzDhAAyka9121hAXGmeXYjzUE3a5n4RYdVeqMjy/efgNUu4H+NoTGELsnp9v1Y
sjbCjI2r31pm4dYSUWgeqzVpUzMQnHY8UhYxsvtw1PAyrTZF1OMBSuH9n0iFk/cB
mXUVJ9Gk8nYR2D8xbbpTXyfWEXl5ZDGkGDBVu2YbnfI+9aXF+PRbI+G2QTCj3lxY
SyXp/aEWV8sptkidBx50l5zYsDiHKe9hT7IbpvQ4MloncwLFaJ8lWB1tamPtp9p0
54f9kSj45zkHqHMs74sF60vL/G/o1NTeAgjVErrl40PVr/ZjXyM38824IgvhZCqC
4NtTeCxgjqWNp6H9h6zMVMJLeUas8V+sWCXqtSFQL6ZtGKUv4J87Ir+uKJiG+D30
liqKZW0vlvvVsuy6otlSBgLgnrFIqpHqhx8J47h7A1+0TtrjdWp0Rns1AhDMC/QQ
4IQPeCeBCsy68VRtZ0Hznm69KZA9aEsgX+xs4G0/zlA8pgwaobIWmlp0QzPIXvPf
gnvUQWzMhdCgEL9KIXvgn2MKL0YE44ooL10Q6V25+nA7I6nkD5HMxPOvm+9wR9N8
8h3ST4jCt1TEZYGJD0fgYJxzLhmBFx1x7fp3sVX1M+RwFVLk6IbMrZs/9/+AQToD
BOjFHqXu9hGp9yGhEAoj7mQCs6RdwTBrl9zhAoNqdYkyGdgKA74=
=Q9xF
-----END PGP SIGNATURE-----

--mu6rDKe19l+MneQx--

