Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIV6h-0002eV-Dj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIV6e-0000Qk-7i
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIV6e-0000Qc-1l
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:10:16 -0400
Date: Wed, 7 Jun 2017 03:10:12 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <878070384.6595572.1496819412787.JavaMail.zimbra@redhat.com>
In-Reply-To: <8760g846pe.fsf@dusky.pond.sub.org>
References: <20170605085254.16485-1-sf@sfritsch.de>
	<e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
	<39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com>
	<87a85ljdhn.fsf@dusky.pond.sub.org>
	<1378843477.6503332.1496789071735.JavaMail.zimbra@redhat.com>
	<8760g846pe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>



----- Original Message -----
> From: "Markus Armbruster" <armbru@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>
> Cc: "Stefan Fritsch" <sf@sfritsch.de>, qemu-devel@nongnu.org, "Dr. David =
Alan Gilbert" <dgilbert@redhat.com>,
> "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Sent: Wednesday, June 7, 2017 9:06:53 AM
> Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> >> >> Is there an obvious test that we can enhance to add coverage of the=
 new
> >> >> QMP command?
> >> >
> >> > You could have a new test covering hw/char/serial.c, but I wouldn't =
let
> >> > that hold the patch.
> >>=20
> >> Holding patches is pretty much the only leverage I have to get tests f=
or
> >> new stuff :)
> >>=20
> >> Asking for tests that cover all of serial.c wouldn't be fair.  But I a=
m
> >> asking for basic test coverage of new QMP commands.
> >
> > I agree, on the other hand it's not exactly a comparable area.  I am pl=
anning
> > to write a serial qtest for migration as well (which is more complex th=
an this
> > QMP command) so I might as well write the test for this new QMP command
> > myself to get my feet wet...
>=20
> I'm willing to take a committment from someone I trust in lieu of actual
> tests.  Is this one?

Sure, though it looks like Stefan also wrote actual tests so we might get
two birds with a stone.

Paolo
