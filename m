Received: from eggs.gnu.org ([2001:4830:134:3::10]:54683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06R-0005YI-Oy
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06Q-0003fu-VH
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:19 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06Q-0003fq-RI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:18 -0400
Received: by mail-qt0-x234.google.com with SMTP id t26so117346705qtg.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:18 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:16 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:41 -0700
Message-Id: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 00/31] target/s390x unwind patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We can use cpu_restore_state (and via *_ra memory helpers) to avoid
storing cpu state in expectation of the unlikely case of page fault
or specification error.

There are more that can be fixed, but this is all of mem_helper.c,
and this patch set is large enough.


r~


Richard Henderson (31):
  target/s390: Use cpu_loop_exit_restore for tlb_fill
  target/s390x: Implement EXECUTE via new TranslationBlock
  target/s390x: Use unwind data for helper_nc
  target/s390x: Use unwind data for helper_xc
  target/s390x: Use unwind data for helper_oc
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
  target/s390x: Use atomic operations for COMPARE SWAP PURGE
  target/s390x: Implement CSPG
  target/s390x: Use unwind data for helper_mvcs/mvcp

 target/s390x/cpu.h         |   4 +-
 target/s390x/helper.h      |   6 +-
 target/s390x/insn-data.def |   7 +-
 target/s390x/machine.c     |  19 ++
 target/s390x/mem_helper.c  | 428 +++++++++++++++++++--------------------------
 target/s390x/translate.c   | 197 ++++++++++++---------
 6 files changed, 321 insertions(+), 340 deletions(-)

-- 
2.9.4
