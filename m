Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Rp-0004tu-JE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Rl-0005HA-W1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d32Rl-0005H0-Q1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:32:09 -0400
Date: Tue, 25 Apr 2017 16:32:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170425153206.GM21129@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAFEAcA8xJ11azOh-sQhzpsb0b++EGT+hML-fvvKRSkyOirB1PQ@mail.gmail.com>
	<20170425145823.GL21129@redhat.com> <87bmrkbjdp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bmrkbjdp.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU travis builds: can we move the preseed
 tarball to qemu.org ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>

On Tue, Apr 25, 2017 at 04:24:18PM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrange <berrange@redhat.com> writes:
>=20
> > On Tue, Apr 25, 2017 at 03:51:17PM +0100, Peter Maydell wrote:
> >> Hi; a recent travis build failure made me notice that our .travis.ym=
l
> >> config references a preseed tarball from here:
> >> http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz
> >>
> >> I think this is a bit less than ideal -- we should really be hosting
> >> this on qemu.org. Can we arrange to move it?
> >
> > I'm curious how much speed difference there is in seeding the git sub=
modules
> > in this way vs letting git pull down from git.qemu.org directly ?
>=20
> It was quite high from what I recall, exacerbated by the fact we have
> quite so many submodules. Unfortunately it doesn't seem that easy to go
> back in the history of the tests to find out so I'll have to re-run the
> test:
>=20
>   https://travis-ci.org/stsquad/qemu/builds/225648653
>=20
> So roughly 62s without a seed vs 15s with. I presume the seed is also
> cached by Travis's web-caching.

Wow, yes, that is quite a difference !

I wonder if Travis' arbitrary sub-dir caching feature would help us to
the same extent, while avoiding need to manually maintain the preseed.

  https://docs.travis-ci.com/user/caching/

It just caches entire content of a given subdir between runs. First time
it would be slow, but presumably fast thereafter, and any time the submod=
ule
gets new updates, those would get cached too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
