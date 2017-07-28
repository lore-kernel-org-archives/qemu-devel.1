Received: from eggs.gnu.org ([2001:4830:134:3::10]:44928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazXY-0004bN-MO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dazXV-0003e2-IB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dazXV-0003dL-CM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:18:25 -0400
Date: Fri, 28 Jul 2017 09:18:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728091818.3f96ae91@gondolin>
In-Reply-To: <20170728063337.GR5117@lemon.lan>
References: <20170717063521.GA7393@lemon>
	<bf05437e-b228-bbc4-760f-b3c1cddf9f0a@amsat.org>
	<20170728063337.GR5117@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Fri, 28 Jul 2017 14:33:37 +0800
Fam Zheng <famz@redhat.com> wrote:

> On Fri, 07/28 02:46, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Fam,
> >=20
> > On 07/17/2017 03:35 AM, Fam Zheng wrote: =20
> > > So far we have these tests running by patchew on each patch series:
> > >=20
> > >    * Docker tests
> > >      Basically it is
> > >          make docker-test-quick@centos6 \
> > >               docker-test-build@min-glib \
> > >               docker-test-mingw@fedora"
> > >=20
> > >    * checkpatch.pl
> > >      Each patch is fed to ./scripts/checkpatch.pl and all errors are =
reported.
> > >=20
> > >    * s390x
> > >      It runs on a machine shared by Fedora team, basically only "./co=
nfigure and
> > >      make", because "make check" hanging is tricky to deal with from =
an
> > >      automation perspective. (Ideas?)
> > >=20
> > >    * FreeBSD
> > >      Like s390x.
> > >  =20
> > [...] =20
> > > Q4: Any other improvements/features you want? (E.g. some documentatio=
n? :) =20
> >=20
> > I'm unsure if someone already asked about it, but is it possible to sor=
t the
> > tests, like:
> > - fastest/cheapest
> > - more likely to fail
> > - ...
> > - scarce resources at last
> >=20
> > And abort/send report on first failure. =20
>=20
> Different hosts run tests in parallel, currently they are three: FreeBSD,=
 Fedora
> s390 and Fedora x86_64, and there isn't a strict order between them.
>=20
> Also I'm not sure it's a good idea to _not_ run build tests if checkpatch=
 test
> fails.

Especially as sometimes checkpatch.pl reports things that can be
overridden by the maintainer with a good conscience.

Generally, I find it useful to get *all* problems instead of playing
whack-a-mole.

>=20
> One thing I agree is that checkpatch reports should be generated as
> soon as possible, which is not the case at the moment. Thanks.

+1
