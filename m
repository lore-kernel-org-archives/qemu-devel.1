Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 03:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243062175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 03:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="B8BYFBoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243062175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46951 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU153-00024S-5t
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 23:41:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hU147-0001Db-59
	for qemu-devel@nongnu.org; Thu, 23 May 2019 23:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hU13z-0004PM-4v
	for qemu-devel@nongnu.org; Thu, 23 May 2019 23:40:15 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52175 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hU13w-0004Dg-Qx; Thu, 23 May 2019 23:40:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 459Bvg6L1bz9s6w; Fri, 24 May 2019 13:39:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558669199;
	bh=rcsa597b9NrF+fDR+9PPXEIlTOv2kFQyLX6WGml/NsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8BYFBoJh7mUP4dIKa7Jd2Gill0bAJfi4iJo7Os6jxLlXmy/EhUXbcKIVp96uM3t6
	wLhQ2SnUfnRMrISq7NZLr72em0KAPRYpB6K35bvf+tzwehFNpIuTvo/hoUuBsIyKMs
	ZRy3gqAEXaVbGjFz1zHMKVbZ/xeJ3g9SkjLSUOvw=
Date: Fri, 24 May 2019 12:17:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190524021725.GC1967@umbus.fritz.box>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
	<CAFEAcA_-O7AS-qBmj_Ba6N69WW5DBenPmxUATs3vQcdBW5Hj5w@mail.gmail.com>
	<20190524004616.GB1967@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20190524004616.GB1967@umbus.fritz.box>
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


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 10:46:16AM +1000, David Gibson wrote:
> On Thu, May 23, 2019 at 10:29:57AM +0100, Peter Maydell wrote:
> > On Wed, 22 May 2019 at 05:46, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > >
> > > The following changes since commit a4f667b6714916683408b983cfe0a615a7=
25775f:
> > >
> > >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3'=
 into staging (2019-05-21 16:30:13 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190522
> > >
> > > for you to fetch changes up to 885659103ad9e1b0460e89c548e9fb823b007b=
7e:
> > >
> > >   docs: provide documentation on the POWER9 XIVE interrupt controller=
 (2019-05-22 10:38:22 +1000)
> > >
> > > ----------------------------------------------------------------
> > > ppc patch queue 2019-05-22
> > >
> > > Next pull request against qemu-4.1.  Highlights:
> > >   * KVM accelerated support for the XIVE interrupt controller in PAPR
> > >     guests
> > >   * A number of TCG vector fixes
> > >   * Fixes for the PReP / 40p machine
> > >
> > > Other than that it's just a bunch of assorted fixes, cleanups and
> > > minor improvements.
> > >
> > > This supersedes the pull request dated 2019-05-21.  I've dropped the
> > > headers update, since it had a mistake, but is now made redundant by a
> > > similar update in Cornelia's applied PR.  I've also added a patch with
> > > extra documentation for the XIVE interrupt controller, and fixed a
> > > couple of minor style errors in the previous PR.
> > >
> > > ----------------------------------------------------------------
> >=20
> > Hi -- this failed 'make check-tcg' for the linux-static build
> > (x86-64 host):
> >=20
> >   TEST    linux-test on ppc64abi32
> > qemu-ppc64abi32:
> > /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> > cpu_exec: Assertion `!have_mmap_lock()' failed.
> > qemu-ppc64abi32:
> > /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:700:
> > cpu_exec: Assertion `!have_mmap_lock()' failed.
> > /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile:122: recipe
> > for target 'run-linux-test' failed
>=20
> Bother.  I did run a make check-tcg on an x86_64 host, and didn't see
> this.  Investigating...

  BUILD   TCG tests for ppc64abi32-linux-user
  BUILD   ppc64abi32 guest-tests SKIPPED
  RUN     TCG tests for ppc64abi32-linux-user
  RUN     tests for ppc64abi32 SKIPPED

Well, that explains why I didn't see it.  I'm using the docker setup
for check-tcg, but it's not clear to me what bits I need to run the
ppc64abi32 tests.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlznVDEACgkQbDjKyiDZ
s5LV2A//fLZETti9ATpDWLgV3RnHrYXVpLSIYTG7Gk8ummP3VMI0sWr2RnwRCxis
l3dJ/D4/mZilwIjmL6K3qnsENxZ7t1m4nS3KSNoOZhX3jcddmy7h1hkmLXcmr3/W
vN5kqU5RMhgmdbxLFk2q0sy73+yHI65RJSPtdD8OLWMSNE8rglFHQrT5LZ4IuCEu
5c+oezGHo+QRQBTZk9p3xow/MFHDjYotNFUTMjC1PvA8+rNpB+s/WagyvJbVw/H1
NwQLc9QyPnf/MgNMUCcgbxQbOJZDqcJ3DW/916NNG0ZANADdcQKH+iDPeKo4HfKW
mJ0fVx/9ViavY1qmIBzVKyjhuz37zPSrWUAG6+NJ0/vKZgSmZhp00pKjzErZJi07
5GAdvDIZiBpwKdBjnm/1K8aeKciewx/ygZ27SPEGcij+QEferTiPmX7wrpW90m7T
6MKwwj3KcYjxZ+ZdlDkOtBZheJFOfLtYXo5SF1jAhbt2jvQjtmByZWPMVk3z1/ns
8j25zvpQakfRiIyvnGNFtLzFFRDzeGD0LQ7Skd0q9vWflN57qergJdlM7LA+oao7
Tagz7xPrln8PB5brWqFjy53Yv/ZorvRr38oLzlVPT38mCHRE7HfI9KDv4c7kgpLt
pRz2MgACObUHByE3QrvzOwgbQhg5ucE8vzvZOxtNVQwzXRg9gIY=
=E093
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

