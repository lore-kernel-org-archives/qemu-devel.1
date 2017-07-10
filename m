Received: from eggs.gnu.org ([2001:4830:134:3::10]:35094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZj-0002Tz-9g
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUfZf-00055k-Sk
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:35 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUfZf-00055Q-OF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 16:46:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id v31so14192204qtb.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 13:46:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 10 Jul 2017 10:45:13 -1000
Message-Id: <20170710204521.2058-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 0/8] target/s390x tcg improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, david@redhat.com

Changes since v2:
  * Another error in CONVERT UNICODE

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
 target/s390x/translate.c   |  91 ++++++-
 target/s390x/insn-data.def |  21 +-
 5 files changed, 688 insertions(+), 25 deletions(-)

-- 
2.9.4
