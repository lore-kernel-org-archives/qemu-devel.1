Received: from eggs.gnu.org ([2001:4830:134:3::10]:58179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgPA-00015G-6m
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgP6-00018n-7B
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:14:48 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgP5-000188-W2
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:14:44 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y25so97656387wrd.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:14:42 -0700 (PDT)
References: <20170602185630.5059-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170602185630.5059-1-f4bug@amsat.org>
Date: Wed, 21 Jun 2017 15:15:23 +0100
Message-ID: <87o9thtojo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/24] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> This patchset add 2 more architectures to the cross-build farm.
>
> There is still some issue trying to cross-build mips64el-softmmu, it seems the
> cross tools use the system outdated libfdt instead of the one checkouted in the
> dtc submodule. I disabled this target for now.

While I was rolling the pullreq I discovered the latest Debian release
Stretch had broken a bunch of things. Fortunately most things where
easily fixed.

> Philippe Mathieu-Daudé (24):
>   docker: let _copy_with_mkdir() sub_path argument be optional
>   docker: add --include-files argument to 'build' command
>   docker: rebuild image if 'extra files' checksum does not match
>   docker: add 'apt-fake' script which generate fake debian packages

dropped for now, no longer needed in mipsel

>   docker: install ca-certificates package in base image
>   docker: create deb-src entry and setup Emdebian in the same layer
>   docker: use better regex to generate deb-src entries
>   docker: use eatmydata, install common build packages in base image
>   docker: use eatmydata in debian armhf image
>   docker: use eatmydata in debian arm64 image
>   docker: add extra libs to armhf target to extend codebase coverage
>   docker: add extra libs to arm64 target to extend codebase coverage
>   docker: add extra libs to s390x target to extend codebase coverage
>   docker: add mipsel build target
>   docker: add powerpc build target

dropped as powerpc was dropped in stretch. This will need re-rolling
with its own jessie based dockerfile.

>   shippable: use C locale to simplify console output
>   shippable: build using all available cpus
>   shippable: do not initialize submodules automatically
>   shippable: be verbose while building docker images
>   shippable: add armeb-linux-user target
>   shippable: add powerpc target

dropped as above

>   shippable: add mipsel target
>   MAINTAINERS: add Shippable automation platform URL
>   MAINTAINERS: self-appoint me as reviewer in build/test automation
>
>  .shippable.yml                                     | 23 +++++++++--
>  MAINTAINERS                                        |  2 +
>  tests/docker/Makefile.include                      |  8 ++++
>  tests/docker/docker.py                             | 30 ++++++++++----
>  tests/docker/dockerfiles/debian-apt-fake.sh        | 46 ++++++++++++++++++++++
>  tests/docker/dockerfiles/debian-arm64-cross.docker | 18 ++++++++-
>  tests/docker/dockerfiles/debian-armhf-cross.docker | 18 ++++++++-
>  .../docker/dockerfiles/debian-mipsel-cross.docker  | 41 +++++++++++++++++++
>  .../docker/dockerfiles/debian-powerpc-cross.docker | 40 +++++++++++++++++++
>  tests/docker/dockerfiles/debian-s390x-cross.docker | 10 +++++
>  tests/docker/dockerfiles/debian.docker             | 18 +++++----
>  11 files changed, 232 insertions(+), 22 deletions(-)
>  create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh
>  create mode 100644 tests/docker/dockerfiles/debian-mipsel-cross.docker
>  create mode 100644 tests/docker/dockerfiles/debian-powerpc-cross.docker

I'll send the pull req once I have a clean run on my branch.

--
Alex Bennée
