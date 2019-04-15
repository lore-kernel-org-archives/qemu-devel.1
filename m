Received: from eggs.gnu.org ([209.51.188.92]:35441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4sQ-0001lI-Qp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hG4sP-0003bE-MB
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:54:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hG4sP-0003aj-Bd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:54:37 -0400
Date: Mon, 15 Apr 2019 17:54:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415165426.GT5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190415154503.6758-1-berrange@redhat.com>
	<jpgk1fvp5wm.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jpgk1fvp5wm.fsf@linux.bootlegged.copy>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Apr 15, 2019 at 12:52:41PM -0400, Bandan Das wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > Two previous attempts to fix this due to GCC 9 highlighting
> > unaligned data access. My attempt:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
> >
> > And a previous one:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
> >   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
> >
> > There are a number of bugs in the USB MTP usb_mtp_write_metadata
> > method handling the filename character set conversion.
> >
> > The 2nd patch in this series is a security flaw fix since the
> > code was not correctly validating guest provided data length.
> >
> > I've been unable to figure out how to exercise the codepath that
> > calls usb_mtp_write_metadata. At a guess, it looks like something
> > that should be called when writing to a file from a guest, but the
> > GNOME GVFS MTP driver doesn't provide write support. Using the
> > command line MTP tools "mtp-sendfile" command results in an
> > protocol error
> >
> >     # mtp-sendfile foo eek.txt
> >     libmtp version: 1.1.14
> >
>=20
> The store is read only by default. Are you trying something like:
>  -device usb-mtp,rootdir=3D/code/mtpshare,readonly=3Dfalse ?

Ah ha, I didn't realize I had to enable write support explicitly. Will
retry with that.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
