Received: from eggs.gnu.org ([209.51.188.92]:33903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOg-0004la-ME
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheOf-0008Rr-Mv
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:38 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheOd-0007XT-Mi
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:45:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id p6so12872856wmc.1
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:45:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:44:57 +0000
Message-Id: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 00/19] testing/next queue for travis and
 docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

This series collects together a bunch of Daniel and Philippe's testing
patches and adds a few of my own. Broadly they simplify the Travis
test cases to be all VM based in preparation for switching to running
docker based builds and tests. I also bumped up the base build to
Xenial given we can always (and will eventually) run the legacy LTS
builds via our own docker images.

The following patches need review
 patch 0006/tests use in place sed magic for enabling deb src.patch
 patch 0017/travis bump to Xenial baseline.patch
 patch 0018/tests docker update our Travis image.patch
 patch 0019/tests docker remove SID_AGE test hack.patch

Alex Bennée (5):
  tests: use in-place sed magic for enabling deb-src in travis image
  travis: use homebrew addon for MacOSX
  travis: bump to Xenial baseline
  tests/docker: update our Travis image
  tests/docker: remove SID_AGE test hack

Daniel P. Berrangé (12):
  tests: run ldconfig after installing extra software
  tests: remove obsolete 'debian' dockerfile
  tests: update Fedora dockerfile to use Fedora 29
  tests: update Fedora i386 cross image to Fedora 29
  travis: add whitespace between each major section & matrix entry
  travis: define all the build matrix entries in one place
  travis: standardize the syntax used for env variables
  travis: don't clone git submodules upfront
  travis: stop redefining the script commands
  travis: stop using container based envs
  travis: run tests in verbose mode
  travis: remove matrix settings that duplicate global settings

Philippe Mathieu-Daudé (2):
  docker: Use stable git tag for virglrenderer
  docker: Use a stable snapshot for Debian Sid

 .travis.yml                                   | 172 ++++++++++++------
 tests/docker/Makefile.include                 |  13 --
 tests/docker/dockerfiles/debian-amd64.docker  |   5 +-
 tests/docker/dockerfiles/debian-sid.docker    |   7 +-
 tests/docker/dockerfiles/debian.docker        |  13 --
 .../dockerfiles/fedora-i386-cross.docker      |   2 +-
 tests/docker/dockerfiles/fedora.docker        |   4 +-
 tests/docker/dockerfiles/travis.docker        |   4 +-
 8 files changed, 131 insertions(+), 89 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian.docker

-- 
2.17.1
