Received: from eggs.gnu.org ([2001:4830:134:3::10]:44534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAXzu-00031E-As
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAXzq-0007AX-GE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:42:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAXzq-0007AQ-AG
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:42:54 -0400
Date: Mon, 23 Apr 2018 10:42:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180423094251.GF3267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
	<8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
	<CAFEAcA9pJBRXTes8V8C0ka7_QYcehgPJzd6RNqGyktn7PLMKqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9pJBRXTes8V8C0ka7_QYcehgPJzd6RNqGyktn7PLMKqg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unknown keycodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Mike R <picnet@me.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Apr 23, 2018 at 10:10:47AM +0100, Peter Maydell wrote:
> On 23 April 2018 at 04:31, Thomas Huth <thuth@redhat.com> wrote:
> > On 21.04.2018 11:27, Mike R wrote:
> >> (qemu) unknown keycodes `empty+aliases(qwerty)=E2=80=99, please repo=
rt to qemu-devel@nongnu.org
> >>
> >> reported.
> >
> > Well, please also report:
>=20
> It's kind of our own fault that we didn't ask for those
> sorts of details in that error message. I think that a lot
> of the time it was reported without necessarily meaning that
> any interesting keys weren't being handled correctly.
>=20
> In any case, as of commit 2ec78706d188 that message has
> been removed, so the 2.12 release should fix this, or
> at least not produce unhelpful warnings :-)

Yes, if you get the same situation in 2.12, it will now print a much
better mesage:

        g_warning("Unknown X11 keycode mapping '%s'.\n"
                  "Please report to qemu-devel@nongnu.org\n"
                  "including the following information:\n"
                  "\n"
                  "  - Operating system\n"
                  "  - X11 Server\n"
                  "  - xprop -root\n"
                  "  - xdpyinfo\n",
                  keycodes ? keycodes : "<null>");


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
