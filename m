Received: from eggs.gnu.org ([2001:4830:134:3::10]:48243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEF25-0000Je-KG
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEF21-0006mU-MJ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEF21-0006kv-Dv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:16:25 -0400
Date: Thu, 3 May 2018 15:16:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180503141610.GC11382@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
	<d9203797-be4a-3cd7-c718-56fa41f60310@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9203797-be4a-3cd7-c718-56fa41f60310@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, May 03, 2018 at 04:06:19PM +0200, Thomas Huth wrote:
> On 03.05.2018 15:43, Gerd Hoffmann wrote:
> > On Thu, May 03, 2018 at 10:26:40AM +0100, Peter Maydell wrote:
> >> On 3 May 2018 at 10:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >>> On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
> >>>> I don't see an issue with time-based numbering schemes.  Ubuntu ma=
de it
> >>>> popular and other projects (like DPDK) are doing the same thing no=
w.
> >>>>
> >>>> The convention is YY.MM though, not YYMM.
> >>>
> >>> It feels like we've got quite a strong backing for time based versi=
oning
> >>> amongst people replying here. I'd be happy with YY.MM
> >>
> >> I'm not hugely in favour mostly because I don't much like
> >> changing version numbering formats -- does it really gain
> >> us anything? But I guess it's a bit of a bikeshed-colour question.
> >=20
> > Well, major/minor numbers don't mean anything.  So I think it makes
> > sense to give them a meaning, and given we do time-based releases it
> > surely makes sense to use a time-based scheme.  Major indicating the
> > year is the obvious and common choice here.  Various variants are in
> > use:
> >=20
> >   (a) major equals year, minor equals month (ubuntu style).
> >   (b) major equals year, minor counts up (mesa style).
> >   (c) major is bumped each year, but doesn't equal year (libvirt styl=
e).
> >=20
> > If we don't want give them a meaning, how about:
> >=20
> >   (d) just drop the minor and count up major each release (systemd st=
yle)?
> >=20
> > My personal preference would be (a) or (b), because it is easy to see
> > when a version was released.  (b) looks more like a classic version
> > number, we would have 18.0, 18.1, ... instead of 18.04, 18.08, ...
>=20
> I'd really would like to avoid variant (a) ... otherwise people will
> confuse 18.1.1 and 18.11 (aka. 18.11.0) again...

We could keep major =3D=3D year, minor =3D=3D nth release of $year. eg 18=
.1,
18.2, 18.3 for the 1st, 2nd and 3rd releases of 2018. Still makes it
fairly clear what timeframe each was released in, without having to
follow month numbers.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
