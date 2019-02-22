Received: from eggs.gnu.org ([209.51.188.92]:42046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xu-0006lx-N0
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gx7Xt-0007nG-Nk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:56310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gx7Xs-00076D-PN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:55:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id q187so1367361wme.5
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 01:54:23 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 09:54:12 +0000
Message-Id: <20190222095421.28938-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/9] various Travis and Docker fixes,
 add gitlab CI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-next-220219-1

for you to fetch changes up to 4300dadc00bec6d75283ffbe1fd85c2b442bef2d:

  tests/cdrom-test: only include isapc cdrom test when g_test_slow() (2019-02-22 09:32:32 +0000)

----------------------------------------------------------------
Various testing fixes:

  - Travis updates (inc disable isapc cdrom test)
  - Add gitlab control
  - Fix docker image
  - keep softloat tests short

----------------------------------------------------------------
Alex Bennée (5):
      .travis.yml: split debug builds
      tests/docker: squash initial update and install step for debian9
      tests/docker: peg netmap code to a specific version
      tests/softfloat: always do quick softfloat tests
      tests/cdrom-test: only include isapc cdrom test when g_test_slow()

Dr. David Alan Gilbert (2):
      .travis.yml: Test with disable-replication
      .travis.yml: Remove disable-uuid

Paolo Bonzini (1):
      .travis.yml: the xcode10 image seems to be hosed

Thomas Huth (1):
      Add a gitlab-ci file for Continuous Integration testing on Gitlab

 .gitlab-ci.yml                               | 73 ++++++++++++++++++++++++++++
 .travis.yml                                  | 16 +++---
 MAINTAINERS                                  |  5 ++
 tests/Makefile.include                       |  6 +--
 tests/cdrom-test.c                           | 10 +++-
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 tests/docker/dockerfiles/debian9.docker      |  4 +-
 7 files changed, 98 insertions(+), 17 deletions(-)
 create mode 100644 .gitlab-ci.yml

-- 
2.20.1
