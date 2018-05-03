Received: from eggs.gnu.org ([2001:4830:134:3::10]:51964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEADG-0003MU-JQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEADB-0000JY-Cx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:07:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35514 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEADB-0000JK-9K
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:07:37 -0400
Date: Thu, 3 May 2018 10:07:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180503090727.GC11382@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
	<20180430132107.0a37704d.cohuck@redhat.com>
	<ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180503072100.GA5301@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, May 03, 2018 at 08:21:00AM +0100, Stefan Hajnoczi wrote:
> On Wed, May 02, 2018 at 09:02:00AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, May 02, 2018 at 09:44:03AM +0200, Gerd Hoffmann wrote:
> > >   Hi,
> > >=20
> > > > > If we bump the major version each year anyway, why not go the w=
hole way
> > > > > and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice =
thing
> > > > > about that is that you can see at a glance when the release too=
k place.
> > > >=20
> > > > ... or simply drop the first two digits and call them 18.1, 18.2,=
 ...?
> >=20
> > > We could also drop the major/minor scheme altogether (as they are
> > > meaningless anyway) and just go for YYMM, i.e. 1808 (for a august
> > > release).
> >=20
> > I don't much like that - it'll lead to a wierd progression of numbers
> > where we'll be constantly the rationale re-explaining to people who
> > want to know why we've jumped from 1808 to 1902 to 1905 etc
>=20
> I don't see an issue with time-based numbering schemes.  Ubuntu made it
> popular and other projects (like DPDK) are doing the same thing now.
>=20
> The convention is YY.MM though, not YYMM.

It feels like we've got quite a strong backing for time based versioning
amongst people replying here. I'd be happy with YY.MM

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
