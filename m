Received: from eggs.gnu.org ([209.51.188.92]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAq-0005S3-M8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gldAo-0002s3-Ve
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gldAo-0002qP-Gp
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:15:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so24248379wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:15:46 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 21 Jan 2019 17:15:40 +0000
Message-Id: <20190121171543.32422-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH  0/3] vmbuild tweaks for BSD targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kamil@netbsd.org, brad@comstyle.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>


Hi,

While I was digging through the BSD failures on my failed fpu/next PR
I realised the build wasn't quite as flexible as it could be. These
patches expose BUILD_TARGET, TARGET_LIST and EXTRA_CONFIGURE_OPTS to
the vmbuild machinery so you can "quickly" run a subset of your build
via the VMs.

Currently OpenBSD hasn't been tweaked because make check fails on
that. If any of the OpenBSD folk wish to chime in on why that would be
nice.

Alex Bennée (3):
  tests/vm: call make check directly for netbsd/freebsd
  tests/vm: add --build-target option
  tests/vm: expose BUILD_TARGET, TARGET_LIST and EXTRA_CONFIGURE_OPTS

 tests/vm/Makefile.include | 10 +++++++++-
 tests/vm/basevm.py        |  3 +++
 tests/vm/freebsd          |  3 +--
 tests/vm/netbsd           |  3 +--
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.17.1
