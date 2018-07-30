Received: from eggs.gnu.org ([2001:4830:134:3::10]:49610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk8SN-0006KP-KB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk8SK-0000y4-EZ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:43:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fk8SK-0000xm-7g
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:43:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id h15-v6so12938718wrs.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 06:43:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 30 Jul 2018 14:43:19 +0100
Message-Id: <20180730134321.19898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 0/2] fix for bug #1783362
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1783362@bugs.launchpad.net, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

Updated to cover the overflow case properly as well.

Alex Bennée (2):
  linux-user/mmap.c: handle invalid len maps correctly
  tests: add check_invalid_maps to test-mmap

 linux-user/mmap.c               | 15 ++++++++++++---
 tests/tcg/multiarch/test-mmap.c | 22 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.17.1
