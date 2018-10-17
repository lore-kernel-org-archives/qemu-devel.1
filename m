Received: from eggs.gnu.org ([2001:4830:134:3::10]:47714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb3B-0002W7-42
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCb37-0006yg-1F
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:34251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCb36-0006xy-0I
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 21:55:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id f18-v6so11881573plr.1
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 18:54:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 16 Oct 2018 18:54:53 -0700
Message-Id: <20181017015456.3293-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] linux-user: Fix shmat by honoring SHMLBA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

These three patches were posted independently back in July.
The second patch has been modified for feedback from Laurent.

C.f.
  http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01999.html
  http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg02180.html
  http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg02652.html


r~


Richard Henderson (3):
  tests/tcg/multiarch/linux-test: Fix error check for shmat
  linux-user: Fix shmat emulation by honoring host SHMLBA
  linux-user: Align mmap_find_vma to host page size

 linux-user/qemu.h                |  2 +-
 linux-user/elfload.c             | 17 ++++---
 linux-user/mmap.c                | 76 +++++++++++++++++---------------
 linux-user/syscall.c             |  3 +-
 tests/tcg/multiarch/linux-test.c |  3 +-
 5 files changed, 56 insertions(+), 45 deletions(-)

-- 
2.17.2
