Received: from eggs.gnu.org ([2001:4830:134:3::10]:50792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL3-0004Ox-Lc
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1figL0-0004F9-J1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1figL0-0004Bi-Am
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:29:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id e7-v6so1724273wrs.9
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 06:29:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 26 Jul 2018 14:29:45 +0100
Message-Id: <20180726132947.28538-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 for 3.0 0/2] fix for bug 1783362
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This fixes a bug where a zero len is passed to mmap. It comes with an
enhancement to the mmap test case.

Alex Bennée (2):
  linux-user/mmap.c: handle len = 0 maps correctly
  tests: add check_invalid_maps to test-mmap

 linux-user/mmap.c               | 14 +++++++++++---
 tests/tcg/multiarch/test-mmap.c | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.17.1
