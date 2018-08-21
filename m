Received: from eggs.gnu.org ([2001:4830:134:3::10]:46722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs7R4-0001Oz-Sh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fs7R0-0000jO-US
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:15:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fs7R0-0000ir-LQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:15:02 -0400
Date: Tue, 21 Aug 2018 15:14:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180821141456.GR7370@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
	<20180820024504.GA7953@xz-mi>
	<CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
	<20180821062951.GE19915@xz-mi>
	<CAJ+F1C+qTV6gQa6SZJ_HLUP1YO0Nm2C-momg0nAZcV6TWPaREw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+qTV6gQa6SZJ_HLUP1YO0Nm2C-momg0nAZcV6TWPaREw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Aug 21, 2018 at 04:04:45PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 21, 2018 at 8:29 AM Peter Xu <peterx@redhat.com> wrote:
> > I fully agree that current way is not ideal since basically the
> > backend should not depend on the frontend, but now we have the
> > gcontext as an exception then the backend will somehow depend on the
> > frontend.  If you don't like the way I proposed, another thing I am
> > thinking is that whether we can assign the gcontext for the chardev
> > backend before initialization of it (or by parsing the backend &
> > frontend relationships before init of backends), then we assure that
> > we never change the gcontext of any chardev backends.  Though that
>=20
> Yes, I think that's a cleaner solution. I suggested to use an iothread
> argument in the cover letter.
>=20
> Paolo, Daniel, any opinion?

Never changing the GContext once initialized is much nicer. I think I
had suggested that before when this code was first proposed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
