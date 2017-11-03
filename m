Received: from eggs.gnu.org ([2001:4830:134:3::10]:48426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX6-00029r-3W
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX1-0002PJ-Rw
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:56 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eAXX1-0002P8-Kr
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id s66so3380448wmf.5
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:40:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 Nov 2017 09:40:43 +0100
Message-Id: <20171103084046.12821-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] TCG queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Two bug fixes this time.


r~


The following changes since commit 094611b426b3b532a3ec72256cb4e958149269d3:

  oslib-posix: Use sysctl(2) call to resolve exec_dir on NetBSD (2017-11-02 16:19:34 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20171103

for you to fetch changes up to 426eeecdf5d9cf1695a53c08f46394f8e5351750:

  cpu-exec: Exit exclusive region on longjmp from step_atomic (2017-11-03 09:34:21 +0100)

----------------------------------------------------------------
Queued tcg patches

----------------------------------------------------------------
Peter Maydell (1):
      cpu-exec: Exit exclusive region on longjmp from step_atomic

Richard Henderson (2):
      tcg: Allow constant pool entries in the prologue
      tcg/s390x: Use constant pool for prologue

 accel/tcg/cpu-exec.c      | 15 ++++++++++++---
 tcg/s390/tcg-target.inc.c | 44 ++++++++++++------------------------------
 tcg/tcg.c                 | 49 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 66 insertions(+), 42 deletions(-)
