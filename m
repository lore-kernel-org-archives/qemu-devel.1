Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6BEC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BA52137B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bIY9EJRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BA52137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPN68-0003Fe-99
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPN5B-0002Zj-D0
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPN59-0002MH-R3
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:14:44 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:33527 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPN58-0002Cs-Ui; Fri, 17 Apr 2020 05:14:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493Vlx3Knmz9sR4; Fri, 17 Apr 2020 19:14:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587114877;
 bh=CE8hoR6yC4x6OU86espSc1c1jv2jb73U69leidC8bdk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bIY9EJRaitUi5ZTI0PSAzw81DpSvYkcs+srXlnEgqaYcY4JKFxunhzIsnY2GdOHXa
 KGED+pyMh2by1CZE6kSArwpMZKEyJ6uQKd2W9tMdXIe/O7nWYQ23roXoWlRh2O5PG4
 L8CpY2a6PyKWYrc2Qq+bAomRhBiFmRlyUA30Py74=
Date: Fri, 17 Apr 2020 19:14:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/3] ppc-for-5.0 queue 20200417
Message-ID: <20200417091431.GC2102@umbus.fritz.box>
References: <20200417050514.235060-1-david@gibson.dropbear.id.au>
 <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8qLznGS2YCFxz7QYrhbociZsqzEcxQPdp1rUy4OnnnFQ@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 09:28:46AM +0100, Peter Maydell wrote:
> On Fri, 17 Apr 2020 at 06:05, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c899=
5472:
> >
> >   Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200417
> >
> > for you to fetch changes up to 5ed195065cc6895f61b9d59bfa0a0536ed5ed51e:
> >
> >   target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts (2020-04=
-17 10:39:03 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue for 2020-04-17
> >
> > Here are a few late bugfixes for qemu-5.0 in the ppc target code.
> > Unless some really nasty last minute bug shows up, I expect this to be
> > the last ppc pull request for qemu-5.0.
> >
>=20
> We're past rc3 now, so I don't really want to do an rc4 unless we
> absolutely critically need to. How important are these bug fixes?

Eh, probably not important enough.  They're not regressions AFAICT -
two fairly longstanding bugs, and one bug in a new feature.  It can
wait until 5.1.

But, I guess throw them in if something else does force an rc4.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6Zc3QACgkQbDjKyiDZ
s5KSpRAApQ6bTmzUB7C0RAh75RMhkwxXIqx9RbjUjgVx8L+C05Cr8TaP8nz5f23f
UdnQOcJlPK/rmN4vRpeLpIfxbBMpSmcQxM+VlMACQZ4Pvo/8kWxDYpBh51iEDf3P
OSfIvuAN31aNQwavariVKANt44sVzIgYVk0P/eVy97m/Nox/ZGrWs7jirYInC3Ln
VvUxxzhTRae4FCyfeeDKdk2J7lYwGe7RFmNtwxG3Pw/v6KgafKHEZ39C4Y5veRQA
kZtl7z4tCPQGYhlQDg3KAoPMZoxMvxASYlyCDB5Kw8Yfa5Kbbf4MWdfbzZyc9Omr
nRdng7deuihnwX+jE7VydH30pwEuDwj8PcQVUNnELnuXEaAfXIXz+lVQc3OyNUtz
b8BuTDkDTwG9Dyt72mHP18s5Zp6B/fgzB3aPtGtRxyBXo8kuREcX/BZTJso1lqLS
qn7OR2r476hC3+T9PV04CANLLjNGd8M83LBqd5mMLH94hmtC8S8HK7t1/sOzMiZn
ZgWfYMfDa/oADrpGsrzBTQmUy/TXkYEETTrpxyLLYBuyjdaqHEat4DHg/LXVslVR
rXaNxkiVwHtzatkrUwWb9KiApSvyIMWONv642Gv4FlRqkEQBh8NQS4K3mAm3xjrx
JGeVu2S62U8/aDY53Nf2kGCUwwx/5z+ni5fxPq0lv5jlHhOpD28=
=J65M
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

