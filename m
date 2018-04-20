Received: from eggs.gnu.org ([2001:4830:134:3::10]:39400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9RKV-0005x5-6v
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9RKQ-0002Zb-V4
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:23:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f9RKQ-0002Yi-Pp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:23:34 -0400
Date: Fri, 20 Apr 2018 16:23:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420082321.GG17690@lemon.usersys.redhat.com>
References: <20180420024005.30245-1-f4bug@amsat.org>
	<20180420025759.GD17690@lemon.usersys.redhat.com>
	<75c31fea-a067-eaf3-4f12-41d166b77749@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <75c31fea-a067-eaf3-4f12-41d166b77749@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: Rename the amd64 image as
 amd64-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Fri, 04/20 00:41, Philippe Mathieu-Daud=E9 wrote:
> On 04/19/2018 11:57 PM, Fam Zheng wrote:
> > On Thu, 04/19 23:40, Philippe Mathieu-Daud=E9 wrote:
> >> Like the other images, this one is also used to cross-compile.
> >> Name it accordingly, matching directory pattern.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> >> ---
> >>  tests/docker/Makefile.include                                   | 2=
 +-
> >>  .../{debian-amd64.docker =3D> debian-amd64-cross.docker}          |=
 0
> >>  2 files changed, 1 insertion(+), 1 deletion(-)
> >>  rename tests/docker/dockerfiles/{debian-amd64.docker =3D> debian-am=
d64-cross.docker} (100%)
> >>
> >> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.i=
nclude
> >> index de87341528..a113a15f77 100644
> >> --- a/tests/docker/Makefile.include
> >> +++ b/tests/docker/Makefile.include
> >> @@ -49,7 +49,7 @@ docker-image-debian-powerpc-cross: EXTRA_FILES:=3D=
$(SRC_PATH)/tests/docker/dockerf
> >>  # Enforce dependancies for composite images
> >>  docker-image-debian: docker-image-debian9
> >>  docker-image-debian8-mxe: docker-image-debian8
> >> -docker-image-debian-amd64: docker-image-debian9
> >> +docker-image-debian-amd64-cross: docker-image-debian9
> >>  docker-image-debian-armel-cross: docker-image-debian9
> >>  docker-image-debian-armhf-cross: docker-image-debian9
> >>  docker-image-debian-arm64-cross: docker-image-debian9
> >> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/do=
cker/dockerfiles/debian-amd64-cross.docker
> >> similarity index 100%
> >> rename from tests/docker/dockerfiles/debian-amd64.docker
> >> rename to tests/docker/dockerfiles/debian-amd64-cross.docker
> >=20
> > But the dockerfile is written differently: it doesn't use the --cross=
-prefix
> > configure option, plus, amd64 is usually the "native" arch making it =
non-cross
> > build.
>=20
> Indeed, the goal of this dockerfile is to let a developer build QEMU
> with as much dependencies as possible, without having to install them o=
n
> his own workstation.

That is quite useful. BTW I think we should mention *which* images can bu=
ild
QEMU with the most complete dependencies in docs/devel/testing.rst, and I=
'd make
sure we use that one on patchew.

However there are opinions that such an image should maintain a list of p=
ackage
names instead of "$pkg_manager build-dep qemu", to avoid dependencies and
assumptions on how downstreams build QEMU, and I'm with that idea. Curren=
tly
fedora.docker has a very long list of packages and people try to make it
complete, but last time I audited it, what I remember is a couple package=
s can
be found on ubuntu/debian are missing on Fedora.  This needs more close l=
ook.  I
don't have a strong preference about distro family, but considering the
maintanence capacity we should focus on one image first and encourage dev=
elopers
to add packages to the (one) image when a new dependency is introduced,
especially since that patchew doesn't have much horsepower for a whole lo=
t of
redundancy.

>=20
> > What do you need this patch for beside the consistency?
>=20
> I was thinking it might be easier for Alex to use these images in his
> last series "fix building of tests/tcg" (having the same pattern).
>=20
I see. I'll leave this to you and Alex to decide.

Fam
