Received: from eggs.gnu.org ([2001:4830:134:3::10]:45172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbrx-0001Zz-Gb
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbrw-0000qj-NJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:53 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbrw-0000qY-II
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:52 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so27740804qke.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:22:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:13 -0700
Message-Id: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 00/33] target/s390x unwind patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Changes from v1:
  * Drop major implementation change to EXECUTE; I'll pick that up later.
  * But there are some implementation errors for EXECUTE, which are not
    exhibited in real-life code.  Mostly because those edge cases are
    not really useful.
  * Incorporate feedback from Aurelien.


r~


Richard Henderson (33):
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

 target/s390x/helper.h      |   6 +-
 target/s390x/insn-data.def |   7 +-
 target/s390x/mem_helper.c  | 537 ++++++++++++++++++++++++---------------------
 target/s390x/translate.c   |  94 ++++----
 4 files changed, 354 insertions(+), 290 deletions(-)

-- 
2.9.4
