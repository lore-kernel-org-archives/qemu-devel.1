Received: from eggs.gnu.org ([2001:4830:134:3::10]:40614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEadT-0003EU-8u
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fEadP-0000qy-9o
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:20:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fEadP-0000qB-3j
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:20:27 -0400
Date: Fri, 4 May 2018 15:20:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180504132023.GA5098@localhost.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 03.05.2018 um 15:43 hat Gerd Hoffmann geschrieben:
> On Thu, May 03, 2018 at 10:26:40AM +0100, Peter Maydell wrote:
> > On 3 May 2018 at 10:07, Daniel P. Berrang=E9 <berrange@redhat.com> wr=
ote:
> > > On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
> > >> I don't see an issue with time-based numbering schemes.  Ubuntu ma=
de it
> > >> popular and other projects (like DPDK) are doing the same thing no=
w.
> > >>
> > >> The convention is YY.MM though, not YYMM.
> > >
> > > It feels like we've got quite a strong backing for time based versi=
oning
> > > amongst people replying here. I'd be happy with YY.MM
> >=20
> > I'm not hugely in favour mostly because I don't much like
> > changing version numbering formats -- does it really gain
> > us anything? But I guess it's a bit of a bikeshed-colour question.
>=20
> Well, major/minor numbers don't mean anything.  So I think it makes
> sense to give them a meaning, and given we do time-based releases it
> surely makes sense to use a time-based scheme.  Major indicating the
> year is the obvious and common choice here.  Various variants are in
> use:
>=20
>   (a) major equals year, minor equals month (ubuntu style).
>   (b) major equals year, minor counts up (mesa style).
>   (c) major is bumped each year, but doesn't equal year (libvirt style)=
.

I generally don't like time-based versioning schemes too much, but I
guess the only real objection I can think of is what happens when a
release slips? Either the version number wouldn't match the actual
release date, which doesn't look too good, or it's unpredictable during
the development cycle and we'd have to get used to fixing up things like
the "Since:" specification in the QAPI schema immediately before a
release.

But if I had to choose between these options, I think I'd go for (b) or
(c).

> If we don't want give them a meaning, how about:
>=20
>   (d) just drop the minor and count up major each release (systemd styl=
e)?

I'm not sure what the exact systemd model is, but as we came to the
conclusion that there is no semantic difference between major and minor
version number for QEMU, I'd just merge them.

This would result in 3.0 for the next release, 3.1 etc. would be stable
releases, and the December release would be 4.0.

It feels like the minimal change to fix our existing versioning scheme.

Or in fact:

    (e) What's the problem with 2.42, really?

I agree that a constant "2." prefix isn't really useful, but it probably
doesn't really hurt either.

Kevin
