Received: from eggs.gnu.org ([209.51.188.92]:45676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlV-00024E-ES
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlT-0001A7-30
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlS-000126-6B
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:34 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:01 +0000
Message-Id: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] Misc fixes / improvements for the docker
 and travis configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

I've be exploring the possibility of using docker images from within
travis to let us avoid the ancient versions of ubuntu travis requires.

As part of this I needed todo some refactoring of travis config to
more consistently structure build / test commands and use of env
variables. That resulted in this series of misc fixes and improvements
for both docker & travis configs.

I've struggled to get travis to complete successfully in testing this,
but to best of my knowledge the problems I'm hitting are pre-existing.
In particular the gprof test fails reliably with 10 min timeout. The
OS-X build is failing fairly often with "make: write error" which looks
like a possible travis infrastructure bug AFAICT.  Other tests get some
non-deterministic failures too which are things we've seen often in
QEMU.

Daniel P. Berrang=C3=A9 (13):
  tests: run ldconfig after installing extra software
  tests: remove obsolete 'debian' dockerfile
  tests: update Fedora dockerfile to use Fedora 29
  tests: update Fedora i386 cross image to Fedora 29
  travis: add whitespace between each major section & matrix entry
  travis: define all the build matrix entries in one place
  travis: standardize the syntax used for env variables
  travis: don't clone git submodules upfront
  travis: move macOS brew setup into the macOS matrix entries
  travis: stop redefining the script commands
  travis: stop using container based envs
  travis: run tests in verbose mode
  travis: remove matrix settings that duplicate global settings

 .travis.yml                                   | 164 ++++++++++++------
 tests/docker/dockerfiles/debian-amd64.docker  |   2 +
 tests/docker/dockerfiles/debian.docker        |  13 --
 .../dockerfiles/fedora-i386-cross.docker      |   2 +-
 tests/docker/dockerfiles/fedora.docker        |   4 +-
 5 files changed, 117 insertions(+), 68 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian.docker

--=20
2.19.2
