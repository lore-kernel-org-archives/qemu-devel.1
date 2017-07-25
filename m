Received: from eggs.gnu.org ([2001:4830:134:3::10]:44486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzyq-00045f-4t
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzym-0004Mc-7s
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:32 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZzyl-0004Lx-UX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:28 -0400
Received: by mail-wm0-x22b.google.com with SMTP id m85so42435484wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:34:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 25 Jul 2017 14:34:19 +0100
Message-Id: <20170725133425.436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 0/6] Various docker fixes
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

Phillipe pointed out a few anomalies with the travis.docker image
during review which has led to a couple more patches. As they are bug
fixes I didn't race to get a pull-req out today for hard-freeze. I
will roll a pull-req by the end of the week if there are no objections
as I'll be away for the rc1/2 cycles.

Alex Bennée (6):
  docker: ensure NOUSER for travis images
  docker: fix dirty/stash detection on some systems
  docker: ignore submodules when checking diff
  docker: docker.py make --no-cache skip checksum test
  docker: don't install device-tree-compiler build-deps in travis.docker
  docker: reduce noise when building travis.docker

 tests/docker/Makefile.include          | 3 ++-
 tests/docker/docker.py                 | 3 ++-
 tests/docker/dockerfiles/travis.docker | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.13.0
