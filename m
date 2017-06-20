Received: from eggs.gnu.org ([2001:4830:134:3::10]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eR-0003MO-TT
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eO-0001nB-PD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:11 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6eO-0001mw-J5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:08 -0400
Received: by mail-pf0-x243.google.com with SMTP id s66so19891258pfs.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:03:47 -0700
Message-Id: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 00/18] target/s390x improvements
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

Changes since v2:
  * Dropped the enforcement of PGM_OPERATION for insns for
    which the feature bit is set.  There's no agreement on
    exactly how to do this yet.
  * Add implementations of insns for 6 more facilities.

I think we can get to z990 fairly quickly after this.
Ignoring HFP, the ones I see missing are DAT-ENH, MSA.


r~


David Hildenbrand (2):
  target/s390x: change PSW_SHIFT_KEY
  target/s390x: implement mvcos instruction

Richard Henderson (16):
  target/s390x: Map existing FAC_* names to S390_FEAT_* names
  target/s390x: Implement CSST
  target/s390x: Mark FPSEH facility as available
  target/s390x: Implement load-on-condition-2 insns
  target/s390x: Implement load-and-zero-rightmost-byte insns
  target/s390x: Mark STFLE_53 facility as available
  target/s390x: Implement execution-hint insns
  target/s390x: Implement processor-assist insn
  target/s390x: Mark STFLE_49 facility as available
  target/s390x: Finish implementing ETF2-ENH
  target/s390x: Implement CONVERT UNICODE insns
  target/s390x: Tidy SRST
  target/s390x: Implement SRSTU
  target/s390x: Implement TRTR
  target/s390x: Mark ETF3 and ETF3_ENH facilities as available
  target/s390x: Clean up TB flag bits

 target/s390x/cpu.h           |  48 ++-
 target/s390x/cpu_models.c    |   8 +
 target/s390x/helper.h        |  12 +-
 target/s390x/insn-data.def   |  46 +++
 target/s390x/insn-format.def |   1 +
 target/s390x/mem_helper.c    | 765 +++++++++++++++++++++++++++++++++++++++++--
 target/s390x/translate.c     | 196 ++++++++---
 7 files changed, 987 insertions(+), 89 deletions(-)

-- 
2.9.4
