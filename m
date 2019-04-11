Received: from eggs.gnu.org ([209.51.188.92]:48870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYBP-0004d2-Ty
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYBO-0004Fy-K9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEYBO-0004FT-CC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:47:54 -0400
Date: Thu, 11 Apr 2019 12:47:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190411114744.GM3641@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-4-armbru@redhat.com>
	<CAMxuvayc+RnpmFpUVFaLW2Uh8y6bZo2N4o6wu6YVyE1XRHtdWg@mail.gmail.com>
	<87bm1gr83k.fsf@dusky.pond.sub.org>
	<1f1ab942-49e9-0714-c6bc-65c7a0c4fa27@redhat.com>
	<CAJ+F1C+7gBUPFY5hJ8aCg4_KWJHiNMNx_6CjAQExOVKqmG7FOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+7gBUPFY5hJ8aCg4_KWJHiNMNx_6CjAQExOVKqmG7FOA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] char-pty: Drop "char device
 redirected to" message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Tue, Apr 09, 2019 at 01:25:43PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Apr 9, 2019 at 12:40 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 4/8/19 2:31 PM, Markus Armbruster wrote:
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> > >
> > >> Hi
> > >>
> > >> On Mon, Apr 8, 2019 at 10:36 AM Markus Armbruster <armbru@redhat.c=
om> wrote:
> > >>>
> > >>> char_pty_open() prints a "char device redirected to PTY_NAME (lab=
el
> > >>> LABEL)" message to the current monitor or else to stderr.  No oth=
er
> > >>> ChardevClass::open() prints anything on success.  Drop the messag=
e.
> > >>>
> > >>> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> > >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > >>> ---
> > >>>  chardev/char-pty.c | 2 --
> > >>>  1 file changed, 2 deletions(-)
> > >>>
> > >>
> > >> I guess that was printed for convenience.
> > >>
> > >> Allocated pty can be read from "info chardev", so I suppose we can
> > >> make qemu more silent. Fine with me:
> > >>
> > >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Thanks!
> > >
> > > If we should decide the message is still useful enough to be worth
> > > keeping, I could direct it to stdout instead of dropping it.
> >
> > I prefer this, if Marc-Andr=C3=A9 is still OK.
>=20
> I don't mind, but I wonder if we really have users that care. Power
> users can easily get the associated pty from a monitor query.

IMHO if people want predictable filenames for chardevs without needing to
lookup the name via the monitor, then UNIX sockets fill that need.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
