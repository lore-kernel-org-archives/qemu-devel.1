Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDFC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33382071E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 07:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kLkbUuEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33382071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieD6w-0000ya-55
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 02:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieD5u-0000DW-Ql
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:04:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieD5s-0003Vf-QC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 02:04:34 -0500
Received: from ozlabs.org ([203.11.71.1]:50349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieD5s-0003Up-DY; Mon, 09 Dec 2019 02:04:32 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47WZ1p0F85z9sPc; Mon,  9 Dec 2019 18:04:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575875070;
 bh=+5DHq/ROT43NtT6HRVKnKlJCN/t8Nab3V3faN+XyDk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kLkbUuEZtTHJQFKMqX55relg9k55bY8gucPRMf6WaBLPz92osjyGMX7rCbjQKCJdA
 kGwa5mn+8v2XvUUsH6M0MSyc+xZO1Aymtf4x0CcfF2dJrF/PL5Ur0KPH2wMyqXDaoj
 +9rUkIyDxP+MiaqJP2dN169UtSFd3MqlYayXqqP4=
Date: Mon, 9 Dec 2019 18:00:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] ppc-for-4.2 queue 20191206
Message-ID: <20191209070011.GA103449@umbus.fritz.box>
References: <20191206044134.259488-1-david@gibson.dropbear.id.au>
 <CAFEAcA-oGLx+mcgqxC6-QRv9dSdzOqvM8g7q7SzUuAqKSZU-tA@mail.gmail.com>
 <20191206102903.GM5031@umbus.fritz.box>
 <CAFEAcA_j3VdVGgu8=vTPtmafEjX34OMKjyjdYuRkKNU=yAW7BA@mail.gmail.com>
 <CAFEAcA8Q9u=fXsBDqemur2EkbQYtepYu4qYpfi=ibKMFUmQjEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Q9u=fXsBDqemur2EkbQYtepYu4qYpfi=ibKMFUmQjEA@mail.gmail.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 01:40:19PM +0000, Peter Maydell wrote:
> On Fri, 6 Dec 2019 at 11:19, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Fri, 6 Dec 2019 at 10:43, David Gibson <david@gibson.dropbear.id.au>=
 wrote:
> > >
> > > On Fri, Dec 06, 2019 at 09:52:54AM +0000, Peter Maydell wrote:
> > > > On Fri, 6 Dec 2019 at 04:41, David Gibson <david@gibson.dropbear.id=
=2Eau> wrote:
> > > > >
> > > > > The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13=
666fd9278e:
> > > > >
> > > > >   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +000=
0)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191206
> > > > >
> > > > > for you to fetch changes up to d887a8cfc083bcf3856f9f42352989f362=
4e0cae:
> > > > >
> > > > >   pseries: Update SLOF firmware image (2019-12-06 15:33:23 +1100)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > ppc patch queue 2019-12-06
> > > > >
> > > > > This is a last minute pull request for ppc-for-4.2.  I know it's =
very
> > > > > late in freeze, but this does fix a regression: a bad interaction
> > > > > between the new qemu and SLOF device tree construction code means=
 that
> > > > > SLOF will crash if PCI to PCI bridges are included in the system.
> > > >
> > > > I really really really don't want to do an rc5. This would
> > > > have to be "everybody using ppc gets crashes" for me to
> > > > really want to put it in at this point...
> > >
> > > Yeah, alright.  I'll send it to Mike for a 4.2.1.
> >
> > Paolo says he has something that needs to go into rc5, so maybe
> > we can take this too. How confident are you that the change is
> > small and safe? It's a bit hard to tell with updates to
> > firmware binaries.
>=20
> ...I just read the commit message for the firmware blob update.
> That is way too many random changes to go into rc5. I'd have
> taken a firmware blob update that was just "one change, fixing
> this specific bug", but not one which has all that other stuff too.

Yeah, that's a good point.  I've just resent, but with a cherry-picked
update that only includes the SLOF patches directly relevant to this
regression.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3t8PkACgkQbDjKyiDZ
s5KnxxAAhK4zrM8c/6mD2DFXkNX9YL7EP4RpMH7EAzs9068yfnSPcsZc8T24+mYC
FShlpVdDG1QGJVTsntBFx4A85JiW1hEQlrpIGXakXHFcmBTwcuhH1NHdfCuMEJn5
RnoC0YSm2la3z3K0y1djz/sucmc80pUQW0mknz7KfBMBcJCi1tH98biZ4Stf7Ywa
AcnSYSQiJbORfqPdlfvvBvrH6UDixyZswbF2ngT/puGceteG93EZYSKn3gzupirz
B0E8lF5Abbhr7t8JtDOnphohOC38xDWpVdZSYT8wlPu8WPhGbT5qqeHzpieOpd0M
YUkv0UlEavNnzxRkRRCPu7n7EmUqKxsgpP74/PDqY+v3xkcHSWB2dL5YDtfJZ+I8
qG716OWVjx7kq98ICn1DE+8P0dmPhaZmmZ7BspgTlUUyjkkCOizaSnj9+odrJfMu
ZPAagXCU9ZnevtLdt6UxVPW1n3ipu3YTL+hOXjDhgppzg1VV2iLxs23y+GqUiv3e
1hfkOFTGjSqyFNwagtVK0PwipAN2dTTBmtYYiwO2wxUgfoelKffx5GS1rbFZX0eQ
hpMS+X2afuXUOKCNV+FTP+7+YegWXP0k2OuSrvxClDktp9YdVJ6LRHM2MkYmCFLF
HO6ircRpAaraxI31PTy4qVZlxnsOpAWw9bnpg9PI96nBK/dkxgY=
=yj4R
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

