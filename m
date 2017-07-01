Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyG-0001f0-3x
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyD-0006lo-13
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:24 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dROyC-0006lW-Rc
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id c20so19168669qte.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 13:26:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat,  1 Jul 2017 13:25:52 -0700
Message-Id: <20170701202600.14057-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 0/8] target/s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, aurelien@aurel32.net

Changes since v1:
  * Errors corrected in CONVERT UNICODE
  * Address writeback corrected in SRST/SRSTU
  * IDTES feature added.
  * RISBG handling fixed.


r~


David Hildenbrand (1):
  target/s390x: Allow to enable "idtes" feature for TCG

Richard Henderson (7):
  target/s390x: Implement CSST
  target/s390x: Implement CONVERT UNICODE insns
  target/s390x: Tidy SRST
  target/s390x: Implement SRSTU
  target/s390x: Implement TRTR
  target/s390x: Mark ETF3 and ETF3_ENH facilities as available
  target/s390x: Fix risbg handling

 target/s390x/helper.h      |  11 +-
 target/s390x/cpu_models.c  |   5 +
 target/s390x/mem_helper.c  | 585 +++++++++++++++++++++++++++++++++++++++++++--
 target/s390x/translate.c   |  92 ++++++-
 target/s390x/insn-data.def |  21 +-
 5 files changed, 689 insertions(+), 25 deletions(-)

-- 
2.9.4
