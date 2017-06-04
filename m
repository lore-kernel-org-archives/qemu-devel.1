Received: from eggs.gnu.org ([2001:4830:134:3::10]:49931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQr-0007BI-Ui
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZQn-0002aG-Vp
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:17 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZQn-0002ZU-MT
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:13 -0400
Received: by mail-pf0-x242.google.com with SMTP id u26so18118358pfd.2
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:00 -0700
Message-Id: <20170604173509.29684-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/69] target/s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

The queue has gotten overlong.  This includes my unwinding patches,
the execute rewrite, and Aurelien's flushing out of missing Z insns.

It does *not* include Aurelian's final patch to bump the base tcg
cpu to z800.  David Hildenbrand had objections to that; I expect
that we can address that in the next patch set.


r~


The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47eac5:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-06-02 17:46:22 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170604

for you to fetch changes up to 2be5fdbe14165d47a88054c9d117801e09239098:

  target/s390x: addressing exceptions are suppressing (2017-06-04 10:23:15 -0700)

----------------------------------------------------------------
Queued s390x tcg patches

----------------------------------------------------------------
Aurelien Jarno (29):
      target/s390x: remove dead code in translate.c
      target/s390x: remove some Linux assumptions from IPTE
      target/s390x: implement local-TLB-clearing in IPTE
      target/s390x: implement TEST AND SET
      target/s390x: implement TEST ADDRESSING MODE
      target/s390x: implement PACK
      target/s390x: implement LOAD PAIR FROM QUADWORD
      target/s390x: implement STORE PAIR TO QUADWORD
      target/s390x: implement COMPARE AND SIGNAL
      target/s390x: implement MOVE INVERSE
      target/s390x: implement MOVE NUMERICS
      target/s390x: implement MOVE WITH OFFSET
      target/s390x: implement MOVE ZONES
      target/s390x: improve 24-bit and 31-bit addresses read
      target/s390x: improve 24-bit and 31-bit addresses write
      target/s390x: improve 24-bit and 31-bit lengths read/write
      target/s390x: fix COMPARE LOGICAL LONG EXTENDED
      target/s390x: implement COMPARE LOGICAL LONG
      target/s390x: fix adj_len_to_page
      target/s390x: improve MOVE LONG and MOVE LONG EXTENDED
      target/s390x: implement COMPARE LOGICAL LONG UNICODE
      target/s390x: implement MOVE LONG UNICODE
      target/s390x: implement PACK ASCII
      target/s390x: implement PACK UNICODE
      target/s390x: implement UNPACK ASCII
      target/s390x: implement UNPACK UNICODE
      target/s390x: implement TEST DECIMAL
      target/s390x: implement TRANSLATE ONE/TWO TO ONE/TWO
      target/s390x: mark ETF2 and ETF2-ENH facilities as available

David Hildenbrand (1):
      target/s390x: addressing exceptions are suppressing

Richard Henderson (37):
      target/s390x: Use cpu_loop_exit_restore for tlb_fill
      target/s390x: Move helper_ex to end of file
      target/s390x: Use unwind data for helper_nc
      target/s390x: Use unwind data for helper_oc
      target/s390x: Use unwind data for helper_xc
      target/s390x: Use unwind data for helper_mvc
      target/s390x: Use unwind data for helper_clc
      target/s390x: Use unwind data for helper_clm
      target/s390x: Use unwind data for helper_srst
      target/s390x: Use unwind data for helper_clst
      target/s390x: Use unwind data for helper_mvpg
      target/s390x: Use unwind data for helper_mvst
      target/s390x: Use unwind data for helper_lam
      target/s390x: Use unwind data for helper_stam
      target/s390x: Use unwind data for helper_mvcl
      target/s390x: Use unwind data for helper_mvcle
      target/s390x: Use unwind data for helper_clcle
      target/s390x: Use unwind data for helper_cksm
      target/s390x: Use unwind data for helper_unpk
      target/s390x: Use unwind data for helper_tr
      target/s390x: Use unwind data for helper_tre
      target/s390x: Use unwind data for helper_trt
      target/s390x: Use unwind data for helper_lctlg
      target/s390x: Use unwind data for helper_lctl
      target/s390x: Use unwind data for helper_stctl
      target/s390x: Use unwind data for helper_testblock
      target/s390x: Use unwind data for helper_tprot
      target/s390x: Use unwind data for helper_lra
      target/s390x: Use unwind data for helper_mvcs/mvcp
      target/s390x: Fix some helper_ex problems
      target/s390x: Fix EXECUTE with R1==0
      target/s390x: Use atomic operations for COMPARE SWAP PURGE
      target/s390x: Implement CSPG
      target/s390x: Save current ilen during translation
      target/s390x: End the TB after EXECUTE
      target/s390x: Implement EXECUTE via new TranslationBlock
      target/s390x: Re-implement a few EXECUTE target insns directly

Thomas Huth (2):
      target/s390x: Add support for the TEST BLOCK instruction
      target/s390x/cpu_models: Allow some additional feature bits for the "qemu" CPU

 target/s390x/cpu.h         |    7 +-
 target/s390x/cpu_models.c  |   36 +-
 target/s390x/fpu_helper.c  |   27 +
 target/s390x/helper.c      |    7 +-
 target/s390x/helper.h      |   28 +-
 target/s390x/insn-data.def |   66 ++-
 target/s390x/machine.c     |   19 +
 target/s390x/mem_helper.c  | 1297 +++++++++++++++++++++++++++++++-------------
 target/s390x/misc_helper.c |    4 +-
 target/s390x/mmu_helper.c  |    4 +-
 target/s390x/translate.c   |  526 ++++++++++++++----
 11 files changed, 1525 insertions(+), 496 deletions(-)
