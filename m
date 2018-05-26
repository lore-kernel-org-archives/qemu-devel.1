Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMS5U-0000Wj-VJ
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMS5R-0004dY-RI
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:49:57 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:42821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMS5R-0004dR-J7
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:49:53 -0400
Received: by mail-qt0-x22f.google.com with SMTP id c2-v6so9214227qtn.9
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:49:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141910.6384-1-alex.bennee@linaro.org>
	<20180525141910.6384-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8e25536-a5e2-1177-eb63-0b07d23a515c@amsat.org>
Date: Sat, 26 May 2018 02:49:41 -0300
MIME-Version: 1.0
In-Reply-To: <20180525141910.6384-6-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="BjLx36g9W2ZGU8GfuypYw37ONJUhIcwR8"
Subject: Re: [Qemu-devel] [PATCH v5 35/49] tests/tcg: enable building for
 Alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BjLx36g9W2ZGU8GfuypYw37ONJUhIcwR8
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org,
 famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Message-ID: <f8e25536-a5e2-1177-eb63-0b07d23a515c@amsat.org>
Subject: Re: [PATCH v5 35/49] tests/tcg: enable building for Alpha
References: <20180525133851.27161-1-alex.bennee@linaro.org>
 <20180525141910.6384-1-alex.bennee@linaro.org>
 <20180525141910.6384-6-alex.bennee@linaro.org>
In-Reply-To: <20180525141910.6384-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

(Cc'ing Samuel who replied in a previous thread)

Hi Alex,

On 05/25/2018 11:19 AM, Alex Benn=C3=A9e wrote:
> We can't use our normal Debian based compilers as Alpha isn't an
> officially supported architecture. However it is available as a port
> and fortunately cross compilers for all these targets are included in
> Debian Sid, the perpetual rolling/unstable/testing version of Debian.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

These tags are only for the Alpha part, maybe I wasn't clear enough in
my previous review:
https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04443.html

> ---
> v5
>   - drop the unused debian-cross-build docker image
>   - add note to debian-sid docker image
>   - echo reference to notes on build failure
>   - include EXTRA_RUNS for mmap tests
> ---
>  tests/docker/Makefile.include                 |  1 +
>  .../dockerfiles/debian-alpha-cross.docker     | 12 +++++++
>  tests/docker/dockerfiles/debian-sid.docker    | 32 +++++++++++++++++++=

>  tests/tcg/alpha/Makefile.include              |  2 ++
>  tests/tcg/alpha/Makefile.target               |  6 ++++
>  5 files changed, 53 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/debian-alpha-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-sid.docker
>  create mode 100644 tests/tcg/alpha/Makefile.include
>  create mode 100644 tests/tcg/alpha/Makefile.target
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index b56386f49e..5dc49c6a54 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -62,6 +62,7 @@ docker-image-debian-ppc64el-cross: docker-image-debia=
n9
>  docker-image-debian-s390x-cross: docker-image-debian9
>  docker-image-debian-win32-cross: docker-image-debian8-mxe
>  docker-image-debian-win64-cross: docker-image-debian8-mxe
> +docker-image-debian-alpha-cross: docker-image-debian-sid
>  docker-image-travis: NOUSER=3D1
> =20
>  # Expand all the pre-requistes for each docker image and test combinat=
ion
> diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests=
/docker/dockerfiles/debian-alpha-cross.docker
> new file mode 100644
> index 0000000000..29a25d0dfd
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
> @@ -0,0 +1,12 @@
> +#
> +# Docker cross-compiler target
> +#
> +# This docker target builds on the debian sid base image which
> +# contains cross compilers for Debian "ports" targets.
> +#
> +FROM qemu:debian-sid
> +
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt-get install -y --no-install-recommends \
> +        gcc-alpha-linux-gnu \
> +        libc6.1-dev-alpha-cross || { echo "Failed to build - see debia=
n-sid.docker notes"; exit 1; }
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> new file mode 100644
> index 0000000000..9a3d168705
> --- /dev/null
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -0,0 +1,32 @@
> +#
> +# Debian Sid Base
> +#
> +# A number of our guests exist as ports only. We can either use the
> +# ports repo or get everything from Sid. However Sid is a rolling
> +# distro which may be broken at any particular time. If you are
> +# unlucky and try and build your images while gcc is in the process of=

> +# being uploaded this can fail. Your only recourse is to try again in
> +# a few hours when the repos have re-synced. Once built however you
> +# won't be affected by repo changes unless the docker recipies are
> +# updated and trigger a re-build.

OK, the comment is explaining well.

> +#
> +
> +FROM debian:sid-slim
> +
> +# Duplicate deb line as deb-src
> +RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/s=
ources.list
> +
> +# Install common build utilities
> +RUN apt update
> +RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata
> +RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
> +    apt install -y --no-install-recommends \
> +        bison \
> +        build-essential \
> +        ca-certificates \
> +        flex \
> +        git \
> +        pkg-config \
> +        psmisc \
> +        python \
> +        texinfo || { echo "Failed to build - see debian-sid.docker not=
es"; exit 1; }

Output is:

I have a very low success rate at building Sid-based images.
Recently trying your debian-powerpc-cross:

[...]
Need to get 21.8 MB of archives.
After this operation, 72.0 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian sid/main amd64
binutils-powerpc-linux-gnu amd64 2.30-15 [2411 kB]
Err:2 http://deb.debian.org/debian sid/main amd64
gcc-7-powerpc-linux-gnu-base amd64 7.3.0-15cross1
  404  Not Found
Err:3 http://deb.debian.org/debian sid/main amd64
cpp-7-powerpc-linux-gnu amd64 7.3.0-15cross1
  404  Not Found
Get:4 http://deb.debian.org/debian sid/main amd64 cpp-powerpc-linux-gnu
amd64 4:7.3.0-3 [16.0 kB]
Get:5 http://deb.debian.org/debian sid/main amd64 gcc-7-cross-base-ports
all 7.3.0-15cross1 [182 kB]
Get:6 http://deb.debian.org/debian sid/main amd64 gcc-8-cross-base-ports
all 8-20180402-1cross2 [179 kB]
Get:7 http://deb.debian.org/debian sid/main amd64 libc6-powerpc-cross
all 2.27-3cross2 [1373 kB]
[...]
E: Failed to fetch
http://deb.debian.org/debian/pool/main/g/gcc-7-cross-ports/gcc-7-powerpc-=
linux-gnu_7.3.0-15cross1_amd64.deb
 404  Not Found
E: Unable to fetch some archives, maybe run apt-get update or try with
--fix-missing?
Failed to build - see debian-sid.docker notes
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
apt-get install -y --no-install-recommends         gcc-powerpc-linux-gnu
        libc6-dev-powerpc-cross || { echo "Failed to build - see
debian-sid.docker notes"; exit 1; }' returned a non-zero code: 1
Traceback (most recent call last):
  File "./tests/docker/docker.py", line 456, in <module>
    sys.exit(main())
  File "./tests/docker/docker.py", line 453, in main
    return args.cmdobj.run(args, argv)
  File "./tests/docker/docker.py", line 326, in run
    extra_files_cksum=3Dcksum)
  File "./tests/docker/docker.py", line 209, in build_image
    quiet=3Dquiet)
  File "./tests/docker/docker.py", line 147, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian-powerpc-cross', '-f',
'/tmp/docker_buildQI1jpf/tmpf8x3A7.docker', '/tmp/docker_buildQI1jpf']'
returned non-zero exit status 1
make: *** [tests/docker/Makefile.include:39:
docker-image-debian-powerpc-cross] Error 1
~/source/qemu ((0340bb063f...))$

Due to the ugly output, I didn't notice the "see debian-sid.docker
notes" at first.

I'm not sure using apt repository snapshot resolve everything.

Assuming I'm located in an area where Debian mirrors are very
unreliable, and most of QEMU developers are in area with strong
connectivity, I won't object more on this patch. My network issues
shouldn't be a blocker for the community.

I'll see if I can arrange Dockerfiles to optionally use snapshots.

So finally, you are welcome to keep my R-b and T-b tags :)

Regards,

Phil.

> diff --git a/tests/tcg/alpha/Makefile.include b/tests/tcg/alpha/Makefil=
e.include
> new file mode 100644
> index 0000000000..c7dc48eadb
> --- /dev/null
> +++ b/tests/tcg/alpha/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=3Ddebian-alpha-cross
> +DOCKER_CROSS_COMPILER=3Dalpha-linux-gnu-gcc
> diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile=
=2Etarget
> new file mode 100644
> index 0000000000..bedf1b6444
> --- /dev/null
> +++ b/tests/tcg/alpha/Makefile.target
> @@ -0,0 +1,6 @@
> +# -*- Mode: makefile -*-
> +#
> +# Alpha specific tweaks
> +
> +# On Alpha Linux only supports 8k pages
> +EXTRA_RUNS+=3Drun-test-mmap-8192
>=20


--BjLx36g9W2ZGU8GfuypYw37ONJUhIcwR8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsI9XoACgkQ4+MsLN6t
wN4+yg//Z7VOCYzh5SO+oiMl9AJYiHOeZFegcvxAEh5GmC7Q0mx0qxnvy9SInSxW
uDTI78a6RgjPXDEtpLZy9Ul17E9h05Hoghf188/5UKysd+/DjN+bdH/YDEcSnmqa
MBMnPXnrMBM6MgZxWh6egs2cTFUDCslymkFLuQp9Lqehq0xpOoO1krwQJG3L1eEv
de8bs5jy/nF0yduG/bESkhIb4+Eb2lF37wBlaUR6+pcl/zJXrK4dp8ZvJKgeThXs
kUY7M4xN2cCTlR+CemVVrbGJrCnvm+vqrdS3RiBq+BmNmx6uONeT0x+fAT/t0x3j
J/vUf+qtCEPM8peLzjBfK4ejUXnPj8d/UY5j7Ubdcy4SMFNyjpHxnZTt1p32zooL
G9fxcWUecy0g3FFSAZqyORCxZeE/h7njSV/Qst6oB0g6VOLQLpXReRaPvwq9G4I6
TArlOFKOnB9+5Bh/VMkR33D4k4Y79T1TWHf2uZyjI45ORf8NihZRZFGKXA9ttQv5
rNlsHfjYAIldQeyUZ0bqZPgkU2upoP05lVWv3ncqHuBt6xAekVg16jdIv/jKc3Iu
BfwMbIAI426o/NHzezXaKQelB/eTmA4KaJWrWkNVrathpKjjBdWuPPSsqkN1NAMx
4zVnGaDaHmMIni5fxgWNeU2UeZq9xwd6sHTBvIMsc6KesvI5kAo=
=4lGv
-----END PGP SIGNATURE-----

--BjLx36g9W2ZGU8GfuypYw37ONJUhIcwR8--
