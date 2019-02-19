Received: from eggs.gnu.org ([209.51.188.92]:48567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw0j4-0005l6-Hm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw0j3-00073Z-Kg
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:26:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw0j3-0006zr-DC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:26:01 -0500
Date: Tue, 19 Feb 2019 09:19:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219081948.klww6y5de53s7bec@sirius.home.kraxel.org>
References: <RO1P152MB1483088A66FD63B63FD7279A97650@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190212131136.GH9386@redhat.com>
	<875ztokz0g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <875ztokz0g.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Key repeat is no longer working on TTY and grub
 menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Leonardo Soares =?utf-8?Q?M=C3=BCller?= <leozinho29_eu@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Feb 13, 2019 at 07:01:35AM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > Yes, this is another regression accidentally introduced by the keyboa=
rd
> > state tracker.
> >
> > When GTK does key repeat it omits the Up event for repeated keys.
> >
> > IOW, you get
> >
> >     Press (a)
> >     Press (a)
> >     Press (a)
> >     Release (a)
>=20
> This is how keyboards commonly do it, if I remember correctly.

Yes, this is pretty much what the hardware sends, intentionally, so the
software can figure whenever the event is a autorepeat event or not.

These days most software just ignores repeated events from the hardware
and generates them in software instead, to not depend on the keyboard
hardware capabilities for autorepeat.

> > This might affect other frontends too if they use the same trick for
> > key repeat
>=20
> Plausible.

UIs are not consistent here.  But, yes, we probably should just allow
down events even if the key is already in down state.

cheers,
  Gerd
