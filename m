Received: from eggs.gnu.org ([2001:4830:134:3::10]:59742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqK-0003PQ-3S
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewWqH-000506-0u
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewWqG-0004z8-Rb
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:39:04 -0400
Received: by mail-pf0-x243.google.com with SMTP id j20so3104869pfi.1
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 16 Mar 2018 01:38:52 +0800
Message-Id: <20180315173855.22456-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 0/3] tcg queued patches
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

Ho hum, I rushed v1 before leaving on holidays and failed to format
the cover letter properly, so Peter's scripts did not pick it up.

Patches 2 & 3 are real bug fixes and so still appropriate for the
softfreeze.  Patch 1 is trivial enough I didn't feel it needed to
be held back for 2.13 development.  Let me know if you disagree.


r~


The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180316

for you to fetch changes up to adb196cbd5cff26547bc32a208074f03f4c4a627:

  tcg: Add choose_vector_size (2018-03-16 00:55:04 +0800)

----------------------------------------------------------------
Queued TCG patches

----------------------------------------------------------------
Richard Henderson (3):
      tcg: Improve tcg_gen_muli_i32/i64
      tcg/i386: Support INDEX_op_dup2_vec for -m32
      tcg: Add choose_vector_size

 tcg/i386/tcg-target.inc.c |   9 +
 tcg/tcg-op-gvec.c         | 438 +++++++++++++++++++++++++++-------------------
 tcg/tcg-op.c              |  24 ++-
 3 files changed, 286 insertions(+), 185 deletions(-)
