Received: from eggs.gnu.org ([209.51.188.92]:56649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwU26-00078r-Hq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gwU22-0001h1-Ow
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:38 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:43208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gwU1u-0001ck-4m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:43:29 -0500
Received: from player759.ha.ovh.net (unknown [10.109.159.140])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 62F631191CA
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 16:43:18 +0100 (CET)
Date: Wed, 20 Feb 2019 16:43:12 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190220164312.574d48d6@bahia.lan>
In-Reply-To: <CAFEAcA9ZhMtkh+2CXYjsbYhj69iGgQzBwT2TFOriPgvDbOaPpw@mail.gmail.com>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
	<CAFEAcA9ZhMtkh+2CXYjsbYhj69iGgQzBwT2TFOriPgvDbOaPpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/43] ppc-for-4.0 queue 20190219
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 19 Feb 2019 09:37:44 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 18 Feb 2019 at 14:30, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit 1e36232994c8ad01774501d2e299deba3a24=
69af:
> >
> >   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-201=
90215' into staging (2019-02-15 11:12:14 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190219
> >
> > for you to fetch changes up to 73e14c6a9cdefb94c01ea488f04e7fba7ac0dc5b:
> >
> >   target/ppc: convert vmin* and vmax* to vector operations (2019-02-18 =
11:00:44 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2019-02-19
> >
> > Here's the next batch of ppc and spapr patches.  Higlights are:
> >
> >  * A bunch of improvements to TCG handling of vector instructions from
> >    Richard Henderson and Marc Cave-Ayland
> >
> >  * Cleanup to the XICS interrupt controller from Greg Kurz, removing
> >    the special KVM subclasses which were a bad idea
> >
> >  * Some refinements to the XIVE interrupt controller from C=C3=A9dric Le
> >    Goater
> >
> >  * Fix from Fabiano Rosas for a really dumb buffer overflow in the
> >    device tree code for memory hotplug
> >
> >  * Code for allowing access to SPRs from the gdb stub from Fabiano
> >    Rosas
> >
> >  * Assorted minor fixes and cleanups
> > =20
>=20
> Applied, thanks.
>=20
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.
>=20
> ^^^ I notice the PowerPC section of the changelog is still pretty bare...
>=20

David,

I have an account. I'll start updating the wiki according to what was
actually merged up to this pull request.

> -- PMM
>=20
