Received: from eggs.gnu.org ([2001:4830:134:3::10]:35133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7r-0005s2-NO
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7n-0001yU-LD
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:55 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHD7n-0001yE-ES
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:51 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so4391795wmf.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:13:51 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Dec 2016 17:12:40 +0000
Message-Id: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC/POC PATCH 0/4] Building TCG tests with emdebian
 cross compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, marcandre.lureau@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Pranith,

Here is a proof-of-concept series for you to consider rolling into the TCG tests
cleanup. It uses the existing docker make machinery to build a Debian
image which has arm, arm64 and ppc64el cross compilers in it. Now if
you run:

  make arm-tcg-tests

It will do the requisite build of the docker image and then use that
to build the TCG tests in the appropriate build directory.

These apply on top of your existing series. There is also a quick hack
to disable the running of the tests by default. I think we need two
stages, maybe a build-FOO-tcg-tests and run-FOO-tcg-tests.

What do you think?

Alex Bennée (4):
  tests/docker: add basic user mapping support
  new tests/docker/dockerfiles/debian-multiarch-cross.docker
  tests/tcg: don't run tests by default
  tests/tcg/Makefile: use docker target for arm-tcg-tests

 tests/docker/docker.py                             | 19 +++++++++++
 tests/docker/dockerfiles/debian-bootstrap.docker   |  3 ++
 .../dockerfiles/debian-multiarch-cross.docker      | 39 ++++++++++++++++++++++
 tests/tcg/Makefile.include                         | 20 +++++++++--
 tests/tcg/arm/Makefile                             |  2 +-
 tests/tcg/misc/Makefile                            |  4 +--
 6 files changed, 81 insertions(+), 6 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-multiarch-cross.docker

-- 
2.11.0
