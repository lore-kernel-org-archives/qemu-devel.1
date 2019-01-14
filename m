Received: from eggs.gnu.org ([209.51.188.92]:36528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3op-0002Ws-0a
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gj3oe-0007OC-JZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:06:24 -0500
Date: Mon, 14 Jan 2019 15:05:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190114150551.GK3686@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547473614-20033-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9RQ+_vC3z4qxkX9Jsu4FKHGqi6qXxgbUKn=wpPzwy4Nw@mail.gmail.com>
	<20190114143144.GH3686@redhat.com>
	<0afe72f6-05fe-9547-5f54-46a47ba1ff30@redhat.com>
	<2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d4074cf-2a2c-a4b7-ec50-3324af877ff9@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Work-around a bug in libiscsi
 1.9.0 when used in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 14, 2019 at 03:53:48PM +0100, Thomas Huth wrote:
> On 2019-01-14 15:50, Eric Blake wrote:
> > On 1/14/19 8:31 AM, Daniel P. Berrang=C3=A9 wrote:
> >=20
> >>>
> >>> Can we suppress the warnings with #pragma instead ?
> >>> That would avoid compiling the .o file with different
> >>> C semantics.
> >>
> >> IIUC this is a built-in warning you can't disable, except by changin=
g
> >> the compilation mode to have gnu89 inline semantics :-(
> >=20
> > Could we instead fix the warning by one of:
> >=20
> > Using pragma to declare the header as a system header (used to silenc=
e
> > warnings from misbehaving external headers),
>=20
> How do you do that?
>=20
> > and/or adding #defines around the inclusion of the header to neutrali=
ze
> > the poor warnings,
>=20
> You mean something like:
>=20
> #define inline /* nothing */
>=20
> ?
>=20
> ... sounds quite ugly to me, too.

That actually works very nicely, as long as any system headers
used by iscsi.h are already included by QEMU.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
