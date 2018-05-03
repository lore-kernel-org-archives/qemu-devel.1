Received: from eggs.gnu.org ([2001:4830:134:3::10]:57187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEAVL-0006XN-Mt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEAVI-0007xa-HS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:26:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fEAVI-0007xG-Dj
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:26:20 -0400
Date: Thu, 3 May 2018 11:26:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180503112616.08e795f8.cohuck@redhat.com>
In-Reply-To: <20180503090727.GC11382@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 3 May 2018 10:07:27 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
> > On Wed, May 02, 2018 at 09:02:00AM +0100, Daniel P. Berrang=C3=A9 wrote=
: =20
> > > On Wed, May 02, 2018 at 09:44:03AM +0200, Gerd Hoffmann wrote: =20
> > > >   Hi,
> > > >  =20
> > > > > > If we bump the major version each year anyway, why not go the w=
hole way
> > > > > > and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice =
thing
> > > > > > about that is that you can see at a glance when the release too=
k place. =20
> > > > >=20
> > > > > ... or simply drop the first two digits and call them 18.1, 18.2,=
 ...? =20
> > >  =20
> > > > We could also drop the major/minor scheme altogether (as they are
> > > > meaningless anyway) and just go for YYMM, i.e. 1808 (for a august
> > > > release). =20
> > >=20
> > > I don't much like that - it'll lead to a wierd progression of numbers
> > > where we'll be constantly the rationale re-explaining to people who
> > > want to know why we've jumped from 1808 to 1902 to 1905 etc =20
> >=20
> > I don't see an issue with time-based numbering schemes.  Ubuntu made it
> > popular and other projects (like DPDK) are doing the same thing now.
> >=20
> > The convention is YY.MM though, not YYMM. =20
>=20
> It feels like we've got quite a strong backing for time based versioning
> amongst people replying here. I'd be happy with YY.MM

FWIW, both YY.MM and YYYY.MM look fine to me.
