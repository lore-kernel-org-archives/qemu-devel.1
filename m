Received: from eggs.gnu.org ([2001:4830:134:3::10]:42112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fFgM2-0002NO-Cw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fFgLz-00067G-Bu
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:39:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1fFgLz-000671-5b
	for qemu-devel@nongnu.org; Mon, 07 May 2018 09:38:59 -0400
Date: Mon, 7 May 2018 15:38:30 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180507133830.GA18277@paraplu>
References: <20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
	<d9203797-be4a-3cd7-c718-56fa41f60310@redhat.com>
	<20180503141610.GC11382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180503141610.GC11382@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, May 03, 2018 at 03:16:10PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, May 03, 2018 at 04:06:19PM +0200, Thomas Huth wrote:
> > On 03.05.2018 15:43, Gerd Hoffmann wrote:

[...]

> > >   (a) major equals year, minor equals month (ubuntu style).
> > >   (b) major equals year, minor counts up (mesa style).
> > >   (c) major is bumped each year, but doesn't equal year (libvirt st=
yle).
> > >=20
> > > If we don't want give them a meaning, how about:
> > >=20
> > >   (d) just drop the minor and count up major each release (systemd =
style)?
> > >=20
> > > My personal preference would be (a) or (b), because it is easy to s=
ee
> > > when a version was released.  (b) looks more like a classic version
> > > number, we would have 18.0, 18.1, ... instead of 18.04, 18.08, ...
> >=20
> > I'd really would like to avoid variant (a) ... otherwise people will
> > confuse 18.1.1 and 18.11 (aka. 18.11.0) again...
>=20
> We could keep major =3D=3D year, minor =3D=3D nth release of $year. eg =
18.1,
> 18.2, 18.3 for the 1st, 2nd and 3rd releases of 2018. Still makes it
> fairly clear what timeframe each was released in, without having to
> follow month numbers.

FWIW, the above option sounds simplest to explain so far.

--=20
/kashyap
