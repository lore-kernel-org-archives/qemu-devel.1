Received: from eggs.gnu.org ([2001:4830:134:3::10]:59373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnOwL-00028k-4Z
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fnOwH-0001Qx-Da
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:55:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fnOwH-0001Qq-7X
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:55:49 -0400
Date: Wed, 8 Aug 2018 14:55:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180808135544.GD22936@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180808104930.23133-1-berrange@redhat.com>
	<20180808104930.23133-4-berrange@redhat.com>
	<CAFEAcA8XNE5GOtfAi8+pDvYOdeNOU0eHT-xSSA8RK3F94PUv+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8XNE5GOtfAi8+pDvYOdeNOU0eHT-xSSA8RK3F94PUv+A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ui: remove support for SDL1.2 in
 favour of SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Aug 08, 2018 at 02:51:01PM +0100, Peter Maydell wrote:
> On 8 August 2018 at 11:49, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > SDL1.2 was deprecated in the 2.12.0 release with:
> >
> >   commit e52c6ba34149b4f39c3fd60e59ee32b809db2bfa
> >   Author: Daniel P. Berrange <berrange@redhat.com>
> >   Date:   Mon Jan 15 14:25:33 2018 +0000
> >
> >     ui: deprecate use of SDL 1.2 in favour of 2.0 series
> >
> >     The SDL 2.0 release was made in Aug, 2013:
> >
> >       https://www.libsdl.org/release/
> >
> >     That will soon be 4 + 1/2 years ago, which is enough time to cons=
ider
> >     the 2.0 series widely supported.
> >
> >     Thus we deprecate the SDL 1.2 support, which will allow us to del=
ete it
> >     in the last release of 2018. By this time, SDL 2.0 will be more t=
han 5
> >     years old.
> >
> >     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >     Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >     Message-id: 20180115142533.24585-1-berrange@redhat.com
> >     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > It is thus able to be removed in the 3.1.0 release.
>=20
> At least one of the BSD VMs in tests/vm/ is still using SDL1.2.
> I think we should update that VM before we drop SDL1.2 support.
>=20
> (This is probably just a matter of updating the VM image that
> is currently stored on patchew somewhere. It would also be
> nice if our test infra here had a mechanism for regenerating
> that VM image from scratch rather than just being "here's a
> disk image blob...")

Oh, I can no idea the images used SDL1, because they're totally opaque
to our git repo :-( Just an external blob with no info about how they
were built. Preferrably we'd at least have a manifest for their contents
in git, even better if there's something to automate building them.

According to repology.org/metapackage/sdl2/versions all the *BSDs have
SDL2 available to use at least.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
