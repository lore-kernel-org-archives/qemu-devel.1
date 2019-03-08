Received: from eggs.gnu.org ([209.51.188.92]:48558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2ETN-0004Sv-6y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h2ETJ-0000Ir-MG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:19:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h2ETJ-0008UW-ED
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:19:29 -0500
Date: Fri, 8 Mar 2019 12:19:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190308121918.GE19819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
	<CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 07, 2019 at 06:18:28PM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 18:17, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > As someone who has also been annoyed having to support in-tree and
> > out-of-tree, I support that move. I used to be a pretty happy use of
> > in-tree builds, but out-of-tree his generally equally convenient.
> >
> > Who is volunteering to do patches to deprecate the support? warning i=
n
> > 4.0, and error in 4.1?
>=20
> Do we need to bother to deprecate it? It doesn't affect end-users,
> only those who build QEMU, and the change is easy...

Yeah, I don't think we need to deprecate it. If we get configure to
report an error straightaway it will be obviuous to developers what
they need to change to adapt.

Sufficient to just announce on the mailing list that we intend todo
it in the start of the next dev cycle. Gives developers plenty of
time to adapt, and it will be in the release notes for the next
release to alert downstream consumers.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
