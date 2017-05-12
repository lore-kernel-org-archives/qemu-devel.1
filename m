Received: from eggs.gnu.org ([2001:4830:134:3::10]:45464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAS-00018Y-0f
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAR-0003vd-4H
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:16 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAQ-0003us-Qg
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:15 -0400
Received: by mail-qk0-x22c.google.com with SMTP id u75so59704410qka.3
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:00 -0700
Message-Id: <20170512234009.32557-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/9] Queued s390 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

This is a combination of my queued patches and those
posted by Aurelien this week.


r~


The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c526949:

  maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -0400)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170512

for you to fetch changes up to 538fad597d898f677f81cb4daacd37e7cdc18e6e:

  target/s390x: implement serialization in BRANCH CONDITION (2017-05-12 15:48:41 -0700)

----------------------------------------------------------------
Queued target/s390 patches

----------------------------------------------------------------
Aurelien Jarno (3):
      target/s390x: mask the SIGP order_code using SIGP_ORDER_MASK
      target/s390x: fix SIGNAL PROCESSOR return value
      target/s390x: implement serialization in BRANCH CONDITION

Eric Bischoff (1):
      target/s390x: Implement LOAD PAIR DISJOINT

Miroslav Benes (1):
      target/s390x: Implement LOAD PROGRAM PARAMETER

Richard Henderson (4):
      target/s390x: Implement STORE FACILITIES LIST EXTENDED
      target/s390x: Diagnose specification exception for atomics
      target/s390x: Use atomic operations for COMPARE SWAP
      target/s390x: Use atomic operations for LOAD AND OP

 target/s390x/cpu.c         |   1 +
 target/s390x/cpu.h         |   6 ++
 target/s390x/helper.c      |  16 +++
 target/s390x/helper.h      |   3 +
 target/s390x/insn-data.def |  38 ++++---
 target/s390x/kvm.c         |   2 -
 target/s390x/mem_helper.c  |  40 ++++++++
 target/s390x/misc_helper.c |  62 +++++++++++-
 target/s390x/translate.c   | 245 ++++++++++++++++++++++++++-------------------
 9 files changed, 288 insertions(+), 125 deletions(-)
