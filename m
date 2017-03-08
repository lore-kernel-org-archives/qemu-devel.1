Received: from eggs.gnu.org ([2001:4830:134:3::10]:57834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clUt1-0004jC-GN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 01:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clUsy-0006Ka-AR
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 01:15:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1clUsy-0006II-4G
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 01:15:44 -0500
Date: Wed, 8 Mar 2017 14:15:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170308061531.GC7835@lemon.lan>
References: <20170306112848.659-1-alex.bennee@linaro.org>
	<20170307103744.GA6117@lemon.lan> <87d1dti4qk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87d1dti4qk.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker/dockerfiles/debian-s390-cross:
 include clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 03/07 13:41, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > On Mon, 03/06 11:28, Alex Benn=E9e wrote:
> >> It's a silly little limitation on Shippable that is looks for clang
> >> in the container even though we won't use it. The arm/aarch64 cross
> >> builds inherit this from debian.docker but as we needed to use
> >> debian-testing for this we add it here. We also collapse the update
> >> step into one RUN line to remove and intermediate layer of the docke=
r
> >> build.
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/docker/dockerfiles/debian-s390x-cross.docker | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/te=
sts/docker/dockerfiles/debian-s390x-cross.docker
> >> index bbb21ed088..3a687feda0 100644
> >> --- a/tests/docker/dockerfiles/debian-s390x-cross.docker
> >> +++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
> >> @@ -13,8 +13,8 @@ RUN cat /etc/apt/sources.list | sed "s/deb/deb-src=
/" >> /etc/apt/sources.list
> >>  RUN dpkg --add-architecture s390x
> >>
> >>  # Grab the updated list of packages
> >> -RUN apt update
> >> -RUN apt dist-upgrade -yy
> >> +RUN apt update && apt dist-upgrade -yy
> >> +RUN apt install -yy build-essential clang
> >>  RUN apt-get build-dep -yy -a s390x qemu || apt-get -f install
> >>  RUN apt install -yy gcc-multilib-s390x-linux-gnu binutils-multiarch
> >>
> >> --
> >> 2.11.0
> >>
> >
> > Looks sane. Is this for 2.9?
>=20
> Yes please. The s390x cross build on shippable is currently broken
> without it although we can use the container locally.

OK, I'll send a pull request soon.

Fam
