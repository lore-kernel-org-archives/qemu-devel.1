Received: from eggs.gnu.org ([2001:4830:134:3::10]:33584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDS4-0002m5-N5
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDS0-0007VA-MB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:20 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYDS0-0007UX-Cg
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:33:16 -0400
Received: by mail-wm0-x22f.google.com with SMTP id w126so27703976wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:33:16 -0700 (PDT)
References: <20170718104513.23947-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:33:13 +0100
Message-ID: <87379r86o6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Fwd: [PULL 00/32] Final updates for Travis/Shippable
 for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Alex Bennée <alex.bennee@linaro.org> writes:

Hmm it looked like the cover letter never made it to the list.

> The following changes since commit 5a477a78060638b8433e9fb96a3ada100b1ab8e9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-07-17 18:39:32 +0100)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-ci-updates-for-softfreeze-180717-2
>
> for you to fetch changes up to 118d1becc0e6332145bb9d6aee8ed232eed770e8:
>
>   docker: install clang since Shippable setup_ve() verify it is available (2017-07-18 10:58:36 +0100)
>
> ----------------------------------------------------------------
> Final CI updates for soft-freeze
>
> Tweaks from Paolo for J=x Travis compiles
> Bunch of updated cross-compile targets from Philippe
> Additional debug tools in travis image from Me
>
> ----------------------------------------------------------------
> Alex Bennée (3):
>       docker: include python-yaml in travis.docker
>       docker: add debug tools to travis.docker
>       docker: add debian/powerpc based on Jessie
>
> Paolo Bonzini (2):
>       docker: allow customizing Travis global_env variables
>       travis: move make -j flag out of script
>
> Philippe Mathieu-Daudé (27):
>       docker: rename debian stable -> 9 (Stretch)
>       docker: add common packages to debian base
>       docker: debian/s390x no more in unstable, now available in Stretch
>       docker: remove packages now dependent of qemu in Stretch
>       docker: optimize debian9 base image
>       docker: add debian/armel based on Stretch
>       docker: add debian/ppc64el based on Stretch
>       docker: add debian/amd64 based on Stretch
>       docker: enable virgl to extend code coverage on amd64
>       docker: enable netmap to extend code coverage on amd64
>       docker: enable gcrypt to extend code coverage on amd64
>       docker: enable nettle to extend code coverage on arm64
>       shippable: add armel targets
>       shippable: add ppc64el targets
>       shippable: add x86_64 targets
>       docker: add qemu:debian-jessie based on outdated jessie release
>       docker: add 'apt-fake' script which generate fake debian packages
>       shippable: add powerpc target
>       docker: add debian/mips[eb] images
>       shippable: use debian/mips[eb] targets
>       docker: add debian/mips64el image
>       shippable: add mips64el targets
>       docker: add MXE (M cross environment) base image for MinGW-w64
>       shippable: add win32/64 targets
>       docker: add debian Ports base image
>       docker: warn users to use newer debian8/debian9 base image
>       docker: install clang since Shippable setup_ve() verify it is available
>
>  .shippable.yml                                     | 19 +++++++--
>  .travis.yml                                        |  3 +-
>  tests/docker/Makefile.include                      | 18 +++++++--
>  tests/docker/dockerfiles/debian-amd64.docker       | 39 ++++++++++++++++++
>  tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
>  tests/docker/dockerfiles/debian-arm64-cross.docker | 10 ++---
>  tests/docker/dockerfiles/debian-armel-cross.docker | 24 +++++++++++
>  tests/docker/dockerfiles/debian-armhf-cross.docker |  7 +---
>  tests/docker/dockerfiles/debian-mips-cross.docker  | 29 ++++++++++++++
>  .../dockerfiles/debian-mips64el-cross.docker       | 30 ++++++++++++++
>  .../docker/dockerfiles/debian-mipsel-cross.docker  | 16 ++++----
>  tests/docker/dockerfiles/debian-ports.docker       | 35 ++++++++++++++++
>  .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
>  .../docker/dockerfiles/debian-ppc64el-cross.docker | 25 ++++++++++++
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 23 +++++------
>  tests/docker/dockerfiles/debian-win32-cross.docker | 32 +++++++++++++++
>  tests/docker/dockerfiles/debian-win64-cross.docker | 32 +++++++++++++++
>  tests/docker/dockerfiles/debian.docker             | 27 +++++--------
>  tests/docker/dockerfiles/debian8-mxe.docker        | 18 +++++++++
>  tests/docker/dockerfiles/debian8.docker            | 36 +++++++++++++++++
>  tests/docker/dockerfiles/debian9.docker            | 30 ++++++++++++++
>  tests/docker/dockerfiles/travis.docker             |  2 +-
>  tests/docker/travis.py                             |  6 +--
>  23 files changed, 488 insertions(+), 59 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/debian-amd64.docker
>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>  create mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-mips64el-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-ports.docker
>  create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-ppc64el-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian8-mxe.docker
>  create mode 100644 tests/docker/dockerfiles/debian8.docker
>  create mode 100644 tests/docker/dockerfiles/debian9.docker


--
Alex Bennée
