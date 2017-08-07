Received: from eggs.gnu.org ([2001:4830:134:3::10]:50460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek86-0004cw-S3
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek82-0006XF-4t
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:42 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dek81-0006WS-Vq
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:38 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m85so10327330wma.0
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 08:39:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Aug 2017 16:39:28 +0100
Message-Id: <20170807153934.29477-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v3 0/6] Various docker fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I didn't get around to posting the pull-req before I went on holiday
as there were some comments to address on "docker: reduce noise when
building travis.docker". If there are no other comments I shall roll
the pull request with this.

Alex Bennée (6):
  docker: ensure NOUSER for travis images
  docker: fix dirty/stash detection on some systems
  docker: ignore submodules when checking diff
  docker: docker.py make --no-cache skip checksum test
  docker: don't install device-tree-compiler build-deps in travis.docker
  docker: reduce noise when building travis.docker

 tests/docker/Makefile.include          | 3 ++-
 tests/docker/docker.py                 | 3 ++-
 tests/docker/dockerfiles/travis.docker | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.13.0
