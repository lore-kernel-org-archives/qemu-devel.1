Received: from eggs.gnu.org ([2001:4830:134:3::10]:33397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYum5-0006sa-ID
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYum1-0003xB-7g
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:25 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYum1-0003vo-1b
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:53:21 -0400
Received: by mail-qt0-x241.google.com with SMTP id c5-v6so8052778qth.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:53:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-8-f4bug@amsat.org> <8736x5vf6s.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0718f2ac-a47f-1869-ce94-182552dd69cd@amsat.org>
Date: Fri, 29 Jun 2018 11:53:16 -0300
MIME-Version: 1.0
In-Reply-To: <8736x5vf6s.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/8] docker: Cross build QEMU on ppc32 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org

On 06/29/2018 11:29 AM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Since 08f56d8c9c the powerpc-cross image is no more based on Emdebian
>> but on the Sid release.
>>
>> This patch restore the ability to cross build QEMU on powerpc, which
>> is interesting since it is a 32-bit host.
>>
>> The ugly apt-fake script is, however, still required.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> 
> Hmm I couldn't get this to work with:
> 
>    make docker-test-build@debian-powerpc-cross J=9 V=1 NOCACHE=1
> 
> 
> Step 9/13 : RUN apt-fake install         glusterfs-common:powerpc=4.0.2-fake
>  ---> Running in 0bf7bf5e268a
> Reading package lists...
> Building dependency tree...
> Reading state information...
> E: Version '4.0.2-fake' for 'glusterfs-common:powerpc' was not found
> Generating fake glusterfs-common powerpc 4.0.2-fake ...
> Selecting previously unselected package glusterfs-common:powerpc.
> (Reading database ... 19461 files and directories currently installed.)
> Preparing to unpack glusterfs-common_4.0.2-fake_powerpc.deb ...
> Unpacking glusterfs-common:powerpc (4.0.2-fake) ...
> Setting up glusterfs-common:powerpc (4.0.2-fake) ...
> Removing intermediate container 0bf7bf5e268a
>  ---> 9f903850b104
> Step 10/13 : RUN DEBIAN_FRONTEND=noninteractive eatmydata     apt-get build-dep -yy -a powerpc qemu
>  ---> Running in 973b5c17668d
> Reading package lists...
> Building dependency tree...
> Reading state information...
> Some packages could not be installed. This may mean that you have
> requested an impossible situation or if you are using the unstable
> distribution that some required packages have not yet been created
> or been moved out of Incoming.
> The following information may help to resolve the situation:
> 
> The following packages have unmet dependencies:
>  builddeps:qemu:powerpc : Depends: libcapstone-dev:powerpc but it is not going to be installed
>                           Depends: libaio-dev:powerpc but it is not going to be installed
>                           Depends: libpulse-dev:powerpc but it is not going to be installed
>                           Depends: libasound2-dev:powerpc but it is not going to be installed
>                           Depends: libattr1-dev:powerpc but it is not going to be installed
>                           Depends: libbluetooth-dev:powerpc but it is not going to be installed
>                           Depends: libbrlapi-dev:powerpc but it is not going to be installed
>                           Depends: libcap-dev:powerpc but it is not going to be installed
>                           Depends: libcap-ng-dev:powerpc but it is not going to be installed
>                           Depends: libcurl4-gnutls-dev:powerpc but it is not going to be installed
>                           Depends: libfdt-dev:powerpc but it is not going to be installed
>                           Depends: gnutls-dev:powerpc
>                           Depends: libgtk-3-dev:powerpc but it is not going to be installed
>                           Depends: libvte-2.91-dev:powerpc but it is not going to be installed
>                           Depends: libiscsi-dev:powerpc (> 1.9.0~) but it is not going to be installed
>                           Depends: libncursesw5-dev:powerpc
>                           Depends: libnfs-dev:powerpc (> 1.9.3) but it is not going to be installed
>                           Depends: libnuma-dev:powerpc but it is not going to be installed
>                           Depends: libcacard-dev:powerpc but it is not going to be installed
>                           Depends: libpixman-1-dev:powerpc but it is not going to be installed
>                           Depends: librados-dev:powerpc but it is not going to be installed
>                           Depends: librbd-dev:powerpc but it is not going to be installed
>                           Depends: libsasl2-dev:powerpc but it is not going to be installed
>                           Depends: libseccomp-dev:powerpc (>= 2.3.0) but it is not going to be installed
>                           Depends: libusb-1.0-0-dev:powerpc (>= 2:1.0.13~) but it is not going to be installed
>                           Depends: libusbredirparser-dev:powerpc (>= 0.6~) but it is not going to be installed
>                           Depends: libssh2-1-dev:powerpc but it is not going to be installed
>                           Depends: libvdeplug-dev:powerpc but it is not going to be installed
>                           Depends: uuid-dev:powerpc but it is not going to be installed
>                           Depends: xfslibs-dev:powerpc but it is not going to be installed
>                           Depends: zlib1g-dev:powerpc but it is not going to be installed
>                           Depends: libjpeg-dev:powerpc
>                           Depends: libpng-dev:powerpc but it is not going to be installed
> E: Unable to correct problems, you have held broken packages.
> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata     apt-get build-dep -yy -a powerpc qemu' returned a non-zero code: 100
> Traceback (most recent call last):
>   File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 526, in <module>
>     sys.exit(main())
>   File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 523, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 344, in run
>     extra_files_cksum=cksum)
>   File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 227, in build_image
>     quiet=quiet)
>   File "/home/alex/lsrc/qemu/qemu.git/tests/docker/docker.py", line 154, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t', 'qemu:debian-powerpc-cross', '-f', '/tmp/docker_buildjXN8x4/tmpJASaT1.docker', '--no-cache', '/tmp/docker_buildjXN8x4']' returned non-zero exit status 100
> /home/alex/lsrc/qemu/qemu.git/tests/docker/Makefile.include:50: recipe for target 'docker-image-debian-powerpc-cross' failed
> make: *** [docker-image-debian-powerpc-cross] Error 1

Caveats of using Debian/Sid again :(

It worked for me 5 days ago, and I'v been using this image since, but
without rebuilding it, so did not notice the upstream packages change
again... whew :(

Let's postpone this for the next development window.

Thanks for giving it a try!

Phil.

> 
>> ---
>>  tests/docker/Makefile.include                 |  2 +
>>  tests/docker/dockerfiles/debian-apt-fake.sh   | 46 +++++++++++++++++++
>>  .../dockerfiles/debian-powerpc-cross.docker   | 43 +++++++++++++++++
>>  3 files changed, 91 insertions(+)
>>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>>
>> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
>> index 301ee68ae6..d73d60cfbb 100644
>> --- a/tests/docker/Makefile.include
>> +++ b/tests/docker/Makefile.include
>> @@ -58,6 +58,8 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>>  		"BUILD","$*")
>>  endif
>>
>> +docker-image-debian-powerpc-cross: EXTRA_FILES:=$(SRC_PATH)/tests/docker/dockerfiles/debian-apt-fake.sh
>> +
>>  # Enforce dependencies for composite images
>>  docker-image-debian: docker-image-debian9
>>  docker-image-debian8-mxe: docker-image-debian8
>> diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
>> new file mode 100755
>> index 0000000000..2ec0fdf47a
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/debian-apt-fake.sh
>> @@ -0,0 +1,46 @@
>> +#! /bin/sh
>> +#
>> +# Generate fake debian package to resolve unimportant unmet dependencies held
>> +# by upstream multiarch broken packages.
>> +#
>> +# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2
>> +# or (at your option) any later version. See the COPYING file in
>> +# the top-level directory.
>> +
>> +test $1 = "install" && shift 1
>> +
>> +fake_install()
>> +{
>> +    echo "Generating fake $2 $1 $3 ..."
>> +    (cd /var/cache/apt/archives
>> +        (cat << 'EOF'
>> +Section: misc
>> +Priority: optional
>> +Standards-Version: 3.9.2
>> +
>> +Package: NAME
>> +Version: VERSION
>> +Maintainer: qemu-devel@nongnu.org
>> +Architecture: any
>> +Multi-Arch: same
>> +Description: fake NAME
>> +EOF
>> +        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
>> +        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
>> +        dpkg -i --force-overwrite $2_$3_$1.deb
>> +    )
>> +}
>> +
>> +try_install()
>> +{
>> +    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
>> +    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
>> +    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
>> +    apt-get install -q -yy $1 || fake_install $arch $name $vers
>> +}
>> +
>> +for package in $*; do
>> +    try_install $package
>> +done
>> diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> index 5e62ca0df1..4ccd17d9d5 100644
>> --- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
>> @@ -11,3 +11,46 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>>      apt-get install -y --no-install-recommends \
>>          gcc-powerpc-linux-gnu \
>>          libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
>> +
>> +# Setup some basic tools we need
>> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>> +    apt-get install -y --no-install-recommends \
>> +        bison \
>> +        binutils-multiarch \
>> +        build-essential \
>> +        ca-certificates \
>> +        curl \
>> +        flex \
>> +        gettext \
>> +        git \
>> +        gnupg \
>> +        pkg-config \
>> +        python-minimal
>> +
>> +RUN dpkg --add-architecture powerpc && \
>> +    apt-get update
>> +
>> +ENV PKG_CONFIG_PATH /usr/lib/powerpc-linux-gnu/pkgconfig
>> +
>> +# Specify the cross prefix for this image (see tests/docker/common.rc)
>> +ENV QEMU_CONFIGURE_OPTS --cross-prefix=powerpc-linux-gnu-
>> +
>> +# <kludge> to fix "following packages have unmet dependencies" ...
>> +ADD debian-apt-fake.sh /usr/local/bin/apt-fake
>> +RUN apt-get install -y --no-install-recommends \
>> +        equivs
>> +RUN apt-fake install \
>> +        glusterfs-common:powerpc=4.0.2-fake
>> +# </kludge>
>> +
>> +RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>> +    apt-get build-dep -yy -a powerpc qemu
>> +RUN DEBIAN_FRONTEND=noninteractive \
>> +    apt-get install -y --no-install-recommends \
>> +        glusterfs-common:powerpc \
>> +        libbz2-dev:powerpc \
>> +        liblzo2-dev:powerpc \
>> +        libncursesw5-dev:powerpc \
>> +        libnfs-dev:powerpc \
>> +        librdmacm-dev:powerpc \
>> +        libsnappy-dev:powerpc
> 
> 
> --
> Alex Bennée
> 
