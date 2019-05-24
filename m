Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C538DC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 01:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0F620862
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 01:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GWF6bvFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0F620862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTybK-0007C3-Ly
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 21:02:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTyZy-0006F5-Ns
	for qemu-devel@nongnu.org; Thu, 23 May 2019 21:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTyZx-0000d7-CX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 21:01:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:38605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTyZp-0000DP-Ot; Thu, 23 May 2019 21:00:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4597Mc6zxvz9sDn; Fri, 24 May 2019 11:00:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558659628;
	bh=LzfkUJPn+bK3Ho6BTLu5jREmBJvsBXR30y25zi8YUvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWF6bvFGb4f0pjQp2nZQ2S/6Q3tc1GzobOBGAlPK8+597dTqm1Ny6Z52C+6bg5RV9
	ts16dW0Kqx2N555y9KfhcYQMogNbgHxAJaJN49LBWBwh7PGREMzfDvSCSs4uV4BRdV
	ICLQUEX2xHNB02Jwu6PMEVes5Ccj/jNpAIrGKCko=
Date: Fri, 24 May 2019 10:46:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190524004616.GB1967@umbus.fritz.box>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
	<CAFEAcA_-O7AS-qBmj_Ba6N69WW5DBenPmxUATs3vQcdBW5Hj5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_-O7AS-qBmj_Ba6N69WW5DBenPmxUATs3vQcdBW5Hj5w@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL 00/38] ppc-for-4.1 queue 20190522
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2019 at 10:29:57AM +0100, Peter Maydell wrote:
> On Wed, 22 May 2019 at 05:46, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit a4f667b6714916683408b983cfe0a615a725=
775f:
> >
> >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' i=
nto staging (2019-05-21 16:30:13 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190522
> >
> > for you to fetch changes up to 885659103ad9e1b0460e89c548e9fb823b007b7e:
> >
> >   docs: provide documentation on the POWER9 XIVE interrupt controller (=
2019-05-22 10:38:22 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2019-05-22
> >
> > Next pull request against qemu-4.1.  Highlights:
> >   * KVM accelerated support for the XIVE interrupt controller in PAPR
> >     guests
> >   * A number of TCG vector fixes
> >   * Fixes for the PReP / 40p machine
> >
> > Other than that it's just a bunch of assorted fixes, cleanups and
> > minor improvements.
> >
> > This supersedes the pull request dated 2019-05-21.  I've dropped the
> > headers update, since it had a mistake, but is now made redundant by a
> > similar update in Cornelia's applied PR.  I've also added a patch with
> > extra documentation for the XIVE interrupt controller, and fixed a
> > couple of minor style errors in the previous PR.
> >
> > ----------------------------------------------------------------
>=20
> Hi -- this failed 'make check-tcg' for the linux-static build
> (x86-64 host):
>=20
>   TEST    linux-test on ppc64abi32
> qemu-ppc64abi32:
> /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> cpu_exec: Assertion `!have_mmap_lock()' failed.
> qemu-ppc64abi32:
> /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> cpu_exec: Assertion `!have_mmap_lock()' failed.
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile:122: recipe
> for target 'run-linux-test' failed

Bother.  I did run a make check-tcg on an x86_64 host, and didn't see
this.  Investigating...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlznPtgACgkQbDjKyiDZ
s5Khew/8DcWU9LFnxrRzdRBeNp6SOyd75VafPY7Teqtp3+C9jntlvLBe27/7Fiwc
HoF4HhY63kOgSZMobRftnYocNm3EhgzVCz+gFsM9ovKjEX9dpVFFhaCTsAe3dB46
p9ePYtcgdBJk2TBDYn9USIxRdCwhOCuEPnWMBl3ITf0fThSznmg91gah5nyb9lqb
3alLrKbExp1TdfmV98YpNtencxCp2MJel+3VD5PxJzCtcnZjucBGyBnyUUZiNkxA
adRSZxGdlhxun1jvHCVgZdTKVGJMTqhoa+6lPdMy+G+i30J765ivwNxxoVZcl+Nu
+t7pPvJOI64iEgT/CmHLTie7Z6nhkqNTo8YP9CKJ0h7F3uRwW1z3q1dX1XJ67JO2
yxtL7/3CYRoQTJEzz2NBBaOEIeSKKNfrBDAdCr9Pls9xc9n31vYLulGN5VlXDsoL
3OTyUrobeplqCJwBebR6S0doGOJfeAelabKcTOkoA3nTEj3FqK60iNrjibOGfnQl
VrtePOMWT8idNuaaV+Z1uzGROLZzpTkYZHaTCxpuN1WJO9KDSOyt67mv6Sq478z8
TkrWRD09gClcD2QROyoRwwGvj4unebAERbhwiJhA9WeHPgNppvR3wyCPKSXH+Bue
Z4F/ZRiEO3UY2mHevqNZvoqemtyuEQOC+zvLJEYgY1nLC+8CxLk=
=7WH6
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

