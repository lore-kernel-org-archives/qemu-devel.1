Received: from eggs.gnu.org ([2001:4830:134:3::10]:59329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7n00-0001eL-1E
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7mzv-0001xb-KB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:39:55 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:36533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7mzo-0001sS-6I
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:39:46 -0400
Received: by mail-qt1-x844.google.com with SMTP id u34-v6so7306379qth.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 12:39:42 -0700 (PDT)
Received: from cloudburst.twiddle.net ([172.56.13.153])
	by smtp.gmail.com with ESMTPSA id
	t16-v6sm1284946qth.68.2018.10.03.12.39.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 03 Oct 2018 12:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Oct 2018 14:39:22 -0500
Message-Id: <20181003193931.18096-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/9] tcg: Reorg 128-bit atomic operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For v2, and history, see
  http://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg04533.html

Changes since v2:
  * Fixed a typo noticed by Emilio.
  * Brought the target/s390x changes back, as the patches with
    which they conflicted are now in mainline.


r~


Richard Henderson (9):
  tcg: Split CONFIG_ATOMIC128
  target/i386: Convert to HAVE_CMPXCHG128
  target/arm: Convert to HAVE_CMPXCHG128
  target/arm: Check HAVE_CMPXCHG128 at translate time
  target/ppc: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
  target/s390x: Convert to HAVE_CMPXCHG128 and HAVE_ATOMIC128
  target/s390x: Split do_cdsg, do_lpq, do_stpq
  target/s390x: Skip wout, cout helpers if op helper does not return
  target/s390x: Check HAVE_ATOMIC128 and HAVE_CMPXCHG128 at translate

 accel/tcg/atomic_template.h |  20 ++-
 include/qemu/atomic128.h    | 155 ++++++++++++++++++++++
 target/ppc/helper.h         |   2 +-
 tcg/tcg.h                   |  16 ++-
 accel/tcg/cputlb.c          |   3 +-
 accel/tcg/user-exec.c       |   5 +-
 target/arm/helper-a64.c     | 251 ++++++++++++++++++------------------
 target/arm/translate-a64.c  |  38 +++---
 target/i386/mem_helper.c    |   9 +-
 target/ppc/mem_helper.c     |  33 ++++-
 target/ppc/translate.c      | 115 +++++++++--------
 target/s390x/mem_helper.c   | 202 +++++++++++++----------------
 target/s390x/translate.c    |  37 ++++--
 configure                   |  19 +++
 14 files changed, 561 insertions(+), 344 deletions(-)
 create mode 100644 include/qemu/atomic128.h

-- 
2.17.1
