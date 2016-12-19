Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cIvp9-0005Te-Gp
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cIvp4-00030n-F9
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:09:43 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cIvp4-0002zS-6N
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:09:38 -0500
Date: Mon, 19 Dec 2016 06:09:34 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <903503264.6427014.1482145774126.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161214171244.26813-1-alex.bennee@linaro.org>
References: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/POC PATCH 0/4] Building TCG tests with
 emdebian cross compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: bobby prani <bobby.prani@gmail.com>, marcandre lureau <marcandre.lureau@redhat.com>, peter maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> Hi Pranith,
>=20
> Here is a proof-of-concept series for you to consider rolling into the TC=
G
> tests
> cleanup. It uses the existing docker make machinery to build a Debian
> image which has arm, arm64 and ppc64el cross compilers in it. Now if
> you run:
>=20
>   make arm-tcg-tests
>=20
> It will do the requisite build of the docker image and then use that
> to build the TCG tests in the appropriate build directory.
>=20
> These apply on top of your existing series. There is also a quick hack
> to disable the running of the tests by default. I think we need two
> stages, maybe a build-FOO-tcg-tests and run-FOO-tcg-tests.
>=20
> What do you think?

I like the idea, as long as you can also run the tcg tests without docker. =
How many of the qemu archs debian cross tools support? last time I looked t=
here was annoying limitations, but I can't remember the details.

crosstool-ng has perhaps more potential, especially if devs would share the=
ir config/samples (we could then have a cross-distro packaging with flatpac=
k?)

> Alex Benn=C3=A9e (4):
>   tests/docker: add basic user mapping support
>   new tests/docker/dockerfiles/debian-multiarch-cross.docker
>   tests/tcg: don't run tests by default
>   tests/tcg/Makefile: use docker target for arm-tcg-tests
>=20
>  tests/docker/docker.py                             | 19 +++++++++++
>  tests/docker/dockerfiles/debian-bootstrap.docker   |  3 ++
>  .../dockerfiles/debian-multiarch-cross.docker      | 39
>  ++++++++++++++++++++++
>  tests/tcg/Makefile.include                         | 20 +++++++++--
>  tests/tcg/arm/Makefile                             |  2 +-
>  tests/tcg/misc/Makefile                            |  4 +--
>  6 files changed, 81 insertions(+), 6 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.docke=
r
>=20
> --
> 2.11.0
>=20
>=20
