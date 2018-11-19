Received: from eggs.gnu.org ([2001:4830:134:3::10]:40809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOkHk-0007RY-IG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOkHc-0001TI-TU
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:16 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOkHc-0001Sy-L2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:12:12 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so972057ywd.12
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 06:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20181118203312.5376-1-f4bug@amsat.org>
	<20181118203312.5376-2-f4bug@amsat.org> <87wop9i7db.fsf@linaro.org>
In-Reply-To: <87wop9i7db.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 19 Nov 2018 15:11:58 +0100
Message-ID: <CAAdtpL5r2W9fQQYuPhCqF4GsFWTFRoL2FGffSxPRor=riYropQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] docker: Add
 gentoo-mipsr5900el-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Fredrik Noring <noring@nocrew.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Mike Frysinger <vapier@gentoo.org>

On Mon, Nov 19, 2018 at 1:23 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
> > This image is based on Gentoo and the toolchain is built using crossdev=
.
> >
> > Recipe from:
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03944.html
> >
> > Suggested-by: Fredrik Noring <noring@nocrew.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > TODO:
> > - Add Fredrik Noring S-o-b in his patches
> > - Check patch merged upstream
> >
> >  tests/docker/Makefile.include                 |   6 +
> >  .../gentoo-mipsr5900el-cross.docker           |  39 ++++
> >  .../binutils-v2.30-ps2-llsc.patch             |  36 +++
> >  .../crossdev.conf                             |   5 +
> >  .../gcc-v7.2.0-ps2-llsc.patch                 |  23 ++
> >  .../gcc-v7.2.0-ps2.patch                      | 219 ++++++++++++++++++
> >  6 files changed, 328 insertions(+)
> >  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.d=
ocker
> >  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.d=
ocker.d/binutils-v2.30-ps2-llsc.patch
> >  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.d=
ocker.d/crossdev.conf
> >  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.d=
ocker.d/gcc-v7.2.0-ps2-llsc.patch
> >  create mode 100644 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.d=
ocker.d/gcc-v7.2.0-ps2.patch
> >
> > diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> > index 9467e9d088..6ca615206f 100644
> > --- a/tests/docker/Makefile.include
> > +++ b/tests/docker/Makefile.include
> > @@ -119,6 +119,12 @@ docker-image-debian-sparc64-cross: docker-image-de=
bian-sid
> >  docker-image-debian-mips64-cross: docker-image-debian-sid
> >  docker-image-debian-riscv64-cross: docker-image-debian-sid
> >  docker-image-debian-powerpc-cross: docker-image-debian-sid
> > +docker-image-gentoo-mipsr5900el-cross: EXTRA_FILES:=3D$(addprefix \
> > +                     $(SRC_PATH)/tests/docker/dockerfiles/gentoo-mipsr=
5900el-cross.docker.d/,\
> > +                             crossdev.conf \
> > +                             binutils-v2.30-ps2-llsc.patch \
> > +                             gcc-v7.2.0-ps2.patch \
> > +                             gcc-v7.2.0-ps2-llsc.patch)
> >  docker-image-travis: NOUSER=3D1
> >
> >  # Specialist build images, sometimes very limited tools
> > diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker b=
/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
> > new file mode 100644
> > index 0000000000..dbc2eb007b
> > --- /dev/null
> > +++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
> > @@ -0,0 +1,39 @@
> > +#
> > +# Docker mipsel (r5900) cross-compiler target
> > +#
> > +# Using multi-stage builds, this image requires docker-17.05.0 or late=
r.
> > +# (See: https://github.com/gentoo/gentoo-docker-images)
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +# name the portage image
> > +FROM gentoo/portage:latest as portage
>
> This is going to be a rolling state of portage which may be why it broke.

Oh, same problem than Debian/unstable.
I'll see with Gentoo ppl how to fix this.

> > +
> > +# image is based on stage3-amd64
> > +FROM gentoo/stage3-amd64:latest
> > +
> > +# copy the entire portage volume in
> > +COPY --from=3Dportage /usr/portage /usr/portage
> > +
> > +MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > +
> > +# continue with image build ...
> > +RUN emerge -qv sys-devel/crossdev
> > +
> > +# set CROSSDEV_OVERLAY to /usr/local/portage-crossdev
> > +RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
> > +    echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name &=
& \
> > +    echo 'masters =3D gentoo' > /usr/local/portage-crossdev/metadata/l=
ayout.conf && \
> > +    chown -R portage:portage /usr/local/portage-crossdev && \
> > +    mkdir -p /etc/portage/repos.conf
> > +ADD crossdev.conf /etc/portage/repos.conf/crossdev.conf
> > +
> > +# Fredrik's patches
> > +RUN mkdir -p /etc/portage/patches/cross-mipsr5900el-unknown-linux-gnu/=
{binutils,gcc}
> > +ADD binutils-v2.30-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900=
el-unknown-linux-gnu/binutils
> > +ADD gcc-v7.2.0-ps2.patch /etc/portage/patches/cross-mipsr5900el-unknow=
n-linux-gnu/gcc
> > +ADD gcc-v7.2.0-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el-u=
nknown-linux-gnu/gcc
> > +
> > +RUN crossdev -s3 -t mipsr5900el-unknown-linux-gnu --binutils ">=3D2.30=
" --gcc ">=3D7.2.0"
> > +
>
> This fails to build glibc, but doesn't exactly give much info:
>
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-binutils.l=
og
>    * Emerging cross-binutils ...                                         =
   [ ok ]
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-linux-head=
ers-quick.log
>    * Emerging cross-linux-headers-quick ...                              =
   [ ok ]
>    * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-head=
ers.log
>    * Emerging cross-glibc-headers ...
>
>    * error: glibc failed :(
>    *
>    * If you file a bug, please attach the following logfiles:
>    * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-info.log
>    * /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-headers.l=
og.xz
>    * /var/tmp/portage/cross-mipsr5900el-unknown-linux-gnu/glibc*/temp/gli=
bc-config.logs.tar.xz
>   The command '/bin/sh -c crossdev -s3 -t mipsr5900el-unknown-linux-gnu -=
-binutils ">=3D2.30" --gcc ">=3D7.2.0"' returned a non-zero code: 1
>
> But running in a container I did get:
>
>   >>> Running pre-merge checks for cross-mipsr5900el-unknown-linux-gnu/gl=
ibc-2.27-r6
>    * Checking general environment sanity.
>    * Your //etc/nsswitch.conf is out of date.
>    * Please make sure you have 'files' entries for
>    * 'passwd:', 'group:' and 'shadow:' databases.
>    * For more details see:
>    *   https://wiki.gentoo.org/wiki/Project:Toolchain/nsswitch.conf_in_gl=
ibc-2.26
>    * ERROR: cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev f=
ailed (pretend phase):
>    *   nsswitch.conf has no 'files' provider in 'passwd'.
>    *
>    * Call stack:
>    *              ebuild.sh, line 115:  Called pkg_pretend
>    *   glibc-2.27-r6.ebuild, line 723:  Called sanity_prechecks
>    *   glibc-2.27-r6.ebuild, line 651:  Called die
>    * The specific snippet of code:
>    *                              die "nsswitch.conf has no 'files' provi=
der in '${entry}'."
>    *
>    * If you need support, post the output of `emerge --info '=3Dcross-mip=
sr5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev'`,
>    * the complete build log and the output of `emerge -pqv '=3Dcross-mips=
r5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev'`.
>    * The complete build log is located at '/var/tmp/portage/cross-mipsr59=
00el-unknown-linux-gnu/glibc-2.27-r6/temp/build.log'.
>    * The ebuild environment file is located at '/var/tmp/portage/cross-mi=
psr5900el-unknown-linux-gnu/glibc-2.27-r6/temp/die.env'.
>    * Working directory: '/usr/lib64/python3.4/site-packages'
>    * S: '/var/tmp/portage/cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-=
r6/work/glibc-2.27'
>    * Messages for package cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-=
r6:
>    * Your //etc/nsswitch.conf is out of date.
>    * Please make sure you have 'files' entries for
>    * 'passwd:', 'group:' and 'shadow:' databases.
>    * For more details see:
>    *   https://wiki.gentoo.org/wiki/Project:Toolchain/nsswitch.conf_in_gl=
ibc-2.26
>    * ERROR: cross-mipsr5900el-unknown-linux-gnu/glibc-2.27-r6::crossdev f=
ailed (pretend phase):
>    *   nsswitch.conf has no 'files' provider in 'passwd'.
>    *
>    * Call stack:
>    *              ebuild.sh, line 115:  Called pkg_pretend
>    *   glibc-2.27-r6.ebuild, line 723:  Called sanity_prechecks
>    *   glibc-2.27-r6.ebuild, line 651:  Called die
>    * The specific snippet of code:
>    *                              die "nsswitch.conf has no 'files' provi=
der in '${entry}'."

You can see a successful build from Saturday here:
https://app.shippable.com/github/philmd/qemu/runs/268/1/console

...
Step 12/17 : RUN crossdev -s3 -t mipsr5900el-unknown-linux-gnu
--binutils ">=3D2.30" --gcc ">=3D7.2.0"
 ---> Running in b8016468d14f
-
 * crossdev version:      20171230
 * Host Portage ARCH:     amd64
 * Target Portage ARCH:   mips
 * Target System:         mipsr5900el-unknown-linux-gnu
 * Stage:                 3 (C compiler & libc)
 * ABIs:                  default
 * binutils:              >=3Dbinutils-2.30
 * gcc:                   >=3Dgcc-7.2.0
 * headers:               linux-headers-[latest]
 * libc:                  glibc-[latest]
 * CROSSDEV_OVERLAY:      /usr/local/portage-crossdev
 * PORT_LOGDIR:           /var/log/portage
 * PORTAGE_CONFIGROOT:    /
 * Portage flags:

 * leaving metadata/layout.conf alone in /usr/local/portage-crossdev

 * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-binutils.log
 * Emerging cross-binutils ...
                                            [ ok ]
 * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-linux-headers-=
quick.log
 * Emerging cross-linux-headers-quick ...
                                 [ ok ]
 * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc-headers.=
log
 * Emerging cross-glibc-headers ...
                                       [ ok ]
 * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-gcc-stage1.log
 * Emerging cross-gcc-stage1 ...
                                          [ ok ]
* Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-linux-headers.l=
og
 * Emerging cross-linux-headers ...
                                       [ ok ]
 * Log: /var/log/portage/cross-mipsr5900el-unknown-linux-gnu-glibc.log
 * Emerging cross-glibc ...
                                               [ ok ]
 ---> a46540f0ffd1
Removing intermediate container b8016468d14f
Step 13/17 : ENV QEMU_CONFIGURE_OPTS
--cross-prefix=3Dmipsr5900el-unknown-linux-gnu-
[...]
 ---> 77daccf424a7
Successfully built 77daccf424a7
Successfully tagged qemu:gentoo-mipsr5900el-cross

Thanks for giving this a try!

Phil.
