Received: from eggs.gnu.org ([2001:4830:134:3::10]:54411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYuPN-0003sg-H4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYuPG-00088l-Ta
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:29:57 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYuPG-00086v-9V
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:29:50 -0400
Received: by mail-wm0-x243.google.com with SMTP id u18-v6so2318764wmc.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:29:50 -0700 (PDT)
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-8-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180628164643.9668-8-f4bug@amsat.org>
Date: Fri, 29 Jun 2018 15:29:47 +0100
Message-ID: <8736x5vf6s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] docker: Cross build QEMU on ppc32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Since 08f56d8c9c the powerpc-cross image is no more based on Emdebian
> but on the Sid release.
>
> This patch restore the ability to cross build QEMU on powerpc, which
> is interesting since it is a 32-bit host.
>
> The ugly apt-fake script is, however, still required.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Hmm I couldn't get this to work with:

   make docker-test-build@debian-powerpc-cross J=3D9 V=3D1 NOCACHE=3D1


Step 9/13 : RUN apt-fake install         glusterfs-common:powerpc=3D4.0.2-f=
ake
 ---> Running in 0bf7bf5e268a
Reading package lists...
Building dependency tree...
Reading state information...
E: Version '4.0.2-fake' for 'glusterfs-common:powerpc' was not found
Generating fake glusterfs-common powerpc 4.0.2-fake ...
Selecting previously unselected package glusterfs-common:powerpc.
(Reading database ... 19461 files and directories currently installed.)
Preparing to unpack glusterfs-common_4.0.2-fake_powerpc.deb ...
Unpacking glusterfs-common:powerpc (4.0.2-fake) ...
Setting up glusterfs-common:powerpc (4.0.2-fake) ...
Removing intermediate container 0bf7bf5e268a
 ---> 9f903850b104
Step 10/13 : RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata     apt-get bui=
ld-dep -yy -a powerpc qemu
 ---> Running in 973b5c17668d
Reading package lists...
Building dependency tree...
Reading state information...
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
 builddeps:qemu:powerpc : Depends: libcapstone-dev:powerpc but it is not go=
ing to be installed
                          Depends: libaio-dev:powerpc but it is not going t=
o be installed
                          Depends: libpulse-dev:powerpc but it is not going=
 to be installed
                          Depends: libasound2-dev:powerpc but it is not goi=
ng to be installed
                          Depends: libattr1-dev:powerpc but it is not going=
 to be installed
                          Depends: libbluetooth-dev:powerpc but it is not g=
oing to be installed
                          Depends: libbrlapi-dev:powerpc but it is not goin=
g to be installed
                          Depends: libcap-dev:powerpc but it is not going t=
o be installed
                          Depends: libcap-ng-dev:powerpc but it is not goin=
g to be installed
                          Depends: libcurl4-gnutls-dev:powerpc but it is no=
t going to be installed
                          Depends: libfdt-dev:powerpc but it is not going t=
o be installed
                          Depends: gnutls-dev:powerpc
                          Depends: libgtk-3-dev:powerpc but it is not going=
 to be installed
                          Depends: libvte-2.91-dev:powerpc but it is not go=
ing to be installed
                          Depends: libiscsi-dev:powerpc (> 1.9.0~) but it i=
s not going to be installed
                          Depends: libncursesw5-dev:powerpc
                          Depends: libnfs-dev:powerpc (> 1.9.3) but it is n=
ot going to be installed
                          Depends: libnuma-dev:powerpc but it is not going =
to be installed
                          Depends: libcacard-dev:powerpc but it is not goin=
g to be installed
                          Depends: libpixman-1-dev:powerpc but it is not go=
ing to be installed
                          Depends: librados-dev:powerpc but it is not going=
 to be installed
                          Depends: librbd-dev:powerpc but it is not going t=
o be installed
                          Depends: libsasl2-dev:powerpc but it is not going=
 to be installed
                          Depends: libseccomp-dev:powerpc (>=3D 2.3.0) but =
it is not going to be installed
                          Depends: libusb-1.0-0-dev:powerpc (>=3D 2:1.0.13~=
) but it is not going to be installed
                          Depends: libusbredirparser-dev:powerpc (>=3D 0.6~=
) but it is not going to be installed
                          Depends: libssh2-1-dev:powerpc but it is not goin=
g to be installed
                          Depends: libvdeplug-dev:powerpc but it is not goi=
ng to be installed
                          Depends: uuid-dev:powerpc but it is not going to =
be installed
                          Depends: xfslibs-dev:powerpc but it is not going =
to be installed
                          Depends: zlib1g-dev:powerpc but it is not going t=
o be installed
                          Depends: libjpeg-dev:powerpc
                          Depends: libpng-dev:powerpc but it is not going t=
o be installed
E: Unable to correct problems, you have held broken packages.
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata     apt-=
get build-dep -yy -a powerpc qemu' returned a non-zero code: 100
Traceback (most recent call last):
  File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 526, in=
 <module>
    sys.exit(main())
  File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 523, in=
 main
    return args.cmdobj.run(args, argv)
  File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 344, in=
 run
    extra_files_cksum=3Dcksum)
  File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 227, in=
 build_image
    quiet=3Dquiet)
  File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 154, in=
 _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu:deb=
ian-powerpc-cross', '-f', '/tmp/docker_buildjXN8x4/tmpJASaT1.docker', '--no=
-cache', '/tmp/docker_buildjXN8x4']' returned non-zero exit status 100
/home/alex/lsrc/qemu/qemu.git/tests/docker/Makefile.include:50: recipe for =
target 'docker-image-debian-powerpc-cross' failed
make: *** [docker-image-debian-powerpc-cross] Error 1

> ---
>  tests/docker/Makefile.include                 |  2 +
>  tests/docker/dockerfiles/debian-apt-fake.sh   | 46 +++++++++++++++++++
>  .../dockerfiles/debian-powerpc-cross.docker   | 43 +++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 301ee68ae6..d73d60cfbb 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -58,6 +58,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>  		"BUILD","$*")
>  endif
>
> +docker-image-debian-powerpc-cross: EXTRA_FILES:=3D$(SRC_PATH)/tests/dock=
er/dockerfiles/debian-apt-fake.sh
> +
>  # Enforce dependencies for composite images
>  docker-image-debian: docker-image-debian9
>  docker-image-debian8-mxe: docker-image-debian8
> diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/d=
ockerfiles/debian-apt-fake.sh
> new file mode 100755
> index 0000000000..2ec0fdf47a
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-apt-fake.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +#
> +# Generate fake debian package to resolve unimportant unmet dependencies=
 held
> +# by upstream multiarch broken packages.
> +#
> +# Copyright (c) 2017 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2
> +# or (at your option) any later version. See the COPYING file in
> +# the top-level directory.
> +
> +test $1 =3D "install" && shift 1
> +
> +fake_install()
> +{
> +    echo "Generating fake $2 $1 $3 ..."
> +    (cd /var/cache/apt/archives
> +        (cat << 'EOF'
> +Section: misc
> +Priority: optional
> +Standards-Version: 3.9.2
> +
> +Package: NAME
> +Version: VERSION
> +Maintainer: qemu-devel@nongnu.org
> +Architecture: any
> +Multi-Arch: same
> +Description: fake NAME
> +EOF
> +        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
> +        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
> +        dpkg -i --force-overwrite $2_$3_$1.deb
> +    )
> +}
> +
> +try_install()
> +{
> +    name=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\1/")
> +    arch=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\2/")
> +    vers=3D$(echo $1|sed "s/\(.*\):\(.*\)=3D\(.*\)/\3/")
> +    apt-get install -q -yy $1 || fake_install $arch $name $vers
> +}
> +
> +for package in $*; do
> +    try_install $package
> +done
> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests=
/docker/dockerfiles/debian-powerpc-cross.docker
> index 5e62ca0df1..4ccd17d9d5 100644
> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
> @@ -11,3 +11,46 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
>          gcc-powerpc-linux-gnu \
>          libc6-dev-powerpc-cross || { echo "Failed to build - see debian-=
sid.docker notes"; exit 1; }
> +
> +# Setup some basic tools we need
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        bison \
> +        binutils-multiarch \
> +        build-essential \
> +        ca-certificates \
> +        curl \
> +        flex \
> +        gettext \
> +        git \
> +        gnupg \
> +        pkg-config \
> +        python-minimal
> +
> +RUN dpkg --add-architecture powerpc && \
> +    apt-get update
> +
> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
> +
> +# Specify the cross prefix for this image (see tests/docker/common.rc)
> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=3Dpowerpc-linux-gnu-
> +
> +# <kludge> to fix "following packages have unmet dependencies" ...
> +ADD debian-apt-fake.sh /usr/local/bin/apt-fake
> +RUN apt-get install -y --no-install-recommends \
> +        equivs
> +RUN apt-fake install \
> +        glusterfs-common:powerpc=3D4.0.2-fake
> +# </kludge>
> +
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get build-dep -yy -a powerpc qemu
> +RUN DEBIAN_FRONTEND=3Dnoninteractive \
> +    apt-get install -y --no-install-recommends \
> +        glusterfs-common:powerpc \
> +        libbz2-dev:powerpc \
> +        liblzo2-dev:powerpc \
> +        libncursesw5-dev:powerpc \
> +        libnfs-dev:powerpc \
> +        librdmacm-dev:powerpc \
> +        libsnappy-dev:powerpc


--
Alex Benn=C3=A9e
