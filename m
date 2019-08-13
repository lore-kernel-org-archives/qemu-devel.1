Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECAA20651
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="A9sThVw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECAA20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxY67-0000hh-Pd
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42601)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxY5Y-0007v5-WE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxY5X-00072D-Lh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:47:52 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59663 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxY5X-0006zL-1s; Tue, 13 Aug 2019 10:47:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 467Ftl3VVWz9sN6; Wed, 14 Aug 2019 00:47:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565707663;
 bh=cDsaORSWAkfUTg1MkA8s34NdSMlxPUWkbrJO2M6nsEc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A9sThVw3YSiOQErIgPBrWLI45ToEMH2kjTPja3y21tR9hgw/Wn7Boe80Gcsk+ysvd
 tyQs+VSSpZ8aUWSXHqRbK4PCCVr+ev+mlMD0/kEaW4/GoVZCkiy2VacDCxEVU9m1Gv
 10hiaXG6hJ6P8rHOdeuMyyGDvGRS7+1QBOyCBNVY=
Date: Wed, 14 Aug 2019 00:16:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190813141607.GM3947@umbus.fritz.box>
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
 <CAFEAcA9-oo-LCrhUdCzV7MZvwyTeT6sxQFt9B0JEaT7FE4tidA@mail.gmail.com>
 <CAFEAcA_wpGVhZ4VG8kK=+Akonww5FHcy2C6ZQ+Sp6YDs7pYH3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RNRUMt0ZF5Yaq/Aq"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_wpGVhZ4VG8kK=+Akonww5FHcy2C6ZQ+Sp6YDs7pYH3g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.1 queue 20190813
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
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 12:45:51PM +0100, Peter Maydell wrote:
> On Tue, 13 Aug 2019 at 10:23, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Tue, 13 Aug 2019 at 07:59, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003=
c37eef:
> > >
> > >   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190813
> > >
> > > for you to fetch changes up to 310cda5b5e9df642b19a0e9c504368ffba3b3a=
b9:
> > >
> > >   spapr/xive: Fix migration of hot-plugged CPUs (2019-08-13 16:50:30 =
+1000)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue 2019-08-13 (last minute qemu-4.1 fixes)
> > >
> > > Here's a very, very last minute pull request for qemu-4.1.  This fixes
> > > two nasty bugs with the XIVE interrupt controller in "dual" mode
> > > (where the guest decides which interrupt controller it wants to use).
> > > One occurs when resetting the guest while I/O is active, and the other
> > > with migration of hotplugged CPUs.
> > >
> > > The timing here is very unfortunate.  Alas, we only spotted these bugs
> > > very late, and I was sick last week, delaying analysis and fix even
> > > further.
> > >
> > > This series hasn't had nearly as much testing as I'd really like, but
> > > I'd still like to squeeze it into qemu-4.1 if possible, since
> > > definitely fixing two bad bugs seems like an acceptable tradeoff for
> > > the risk of introducing different bugs.
> >
> > Are these regressions? Are they security issues?

They're effectively regressions.  Pedantically, they're bugs in a new
feature, but since the new feature is enabled by default in the new
machine type (and it's the interrupt controller, so you can't do
without it), so it means a normal setup will be broken where the
normal setup in the old version wasn't.

> > We are going to have an rc5 today, but my intention was to only put in
> > the security-fix bug in the bochs display device, and then have
> > a final release Thursday.
>=20
> After thinking about this and reading the commit messages I've
> applied this pullreq, since it clearly only affects spapr and you're
> in a better position to judge the significance of the fixes than me,
> but it was really really borderline...

Fair enough.  As I said, the timing sucked, but there's not really
anything I could do about that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1SxiUACgkQbDjKyiDZ
s5LWLw//RE7I0Fy6cG8Jy+Ver7f3BuQxh+mSNnQL4IBIU4DWzWP7SUVqE8waI5Hp
k+oQxMz6v92IED5dYEkRYJm5LGOv26c6U6aqwfhyEMQbjTlm8wEodGYn+TX88a8i
vHyox4sa1Eh+tcX8vBipkfqTJrtdawW65WE3GjMry1ei8pADC7m7+ouV8chRmbIe
UQfWNJAO1h8Txwj27jxaHI/xeFtkvVmVZGiBflqpF25FpOybpIGFzn677Jt/Jklo
7iRNT9RJIYNDs8nCuPCQr8d3TGRMT5HAxkB3yTJ+qNGUcTaqDVytCoNw6m0d4sqb
8d/QP0SckEXfMDgkBqTCQE1s1i1ooS5nTNUhNLWDZrP7vSGtUoxQJ3zZCbyJC/GH
WLsBt3gbRnAIOGhwsezaqvJg1KAK5HjZeuYu1b/En6TgJCM88vmG2jITZtAR/buW
wnQFZYP6WUlT5yoAIHfZiX4utSDxpTEMgjsb/CAJg658hFIkfaT1nZuDrvEY4wG0
uS0cc7xbmBbCLYTz1AAyGjMK7+hK9JaYPgTPKlQIVHLgWN0x8kwACLLuea4D5eCp
dwK/KiZ6XHzcJnvC82p5/ahvvyFK6CnsKzNcUiz2xT7Jg8zsIbxR4fX72czvgvwU
SimZ3jS7bF+ealntcbx0x3imqtkkTWzqHG9uxsj5j3VlSEkLZbM=
=YP/z
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--

