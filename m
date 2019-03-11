Received: from eggs.gnu.org ([209.51.188.92]:34436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb0-0004Hb-PI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007WC-6Q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007RM-L5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:51 +0100
Message-Id: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] target/hppa patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>

Hi Richard,

here are a few fixes for the HPPA architecture. Some fixes for
problems reported by diagnostics software, some TLB fixes to make
HP-UX 10.20 work with TB chaining in QEMU. I'm not sure whether the
'call eval_interrupt() after ssm' fix is really the right way - please
check.

I haven't seen any problems with these HP-UX 10.20 anymore, and Linux also
still works.

Thanks
Sven

Sven Schnelle (11):
  target/hppa: fix overwriting source reg in addb
  target/hppa: fix TLB handling for page 0
  target/hppa: report ITLB_EXCP_MISS for ITLB misses
  target/hppa: add TLB trace events
  target/hppa: remove PSW I/R/Q bit check
  target/hppa: ignore DIAG opcode
  target/hppa: fix b,gate instruction
  target/hppa: allow multiple itlbp without itlba
  target/hppa: add TLB protection id check
  target/hppa: exit TB if either Data or Instruction TLB changes
  target/hppa: call eval_interrupt() after ssm

 Makefile.objs            |  1 +
 target/hppa/cpu.h        |  5 +++
 target/hppa/insns.decode |  3 ++
 target/hppa/int_helper.c |  2 +-
 target/hppa/mem_helper.c | 68 +++++++++++++++++++++++++++++++---------
 target/hppa/op_helper.c  | 13 +++++---
 target/hppa/trace-events | 18 +++++++++++
 target/hppa/translate.c  | 23 +++++++++-----
 8 files changed, 106 insertions(+), 27 deletions(-)
 create mode 100644 target/hppa/trace-events

-- 
2.20.1
