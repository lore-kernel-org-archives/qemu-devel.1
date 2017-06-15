Received: from eggs.gnu.org ([2001:4830:134:3::10]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLNjI-0000oF-5g
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLNjF-00017U-3J
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:04 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLNjE-00017B-Sf
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:01 -0400
Received: by mail-pf0-x242.google.com with SMTP id w12so719026pfk.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:54:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 22:53:51 -0700
Message-Id: <20170615055356.20684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/5] More s390x improvements
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

David, in his first mvcos patch, points out that we're not enforcing
the facilties on translation.  This takes care of that.  I also went
through and see that we fully implement 3 other facilities bits.


r~


David Hildenbrand (2):
  target/s390x: change PSW_SHIFT_KEY
  target/s390x: implement mvcos instruction

Richard Henderson (3):
  target/s390x: Map existing FAC_* names to S390_FEAT_* names
  target/s390x: Enforce instruction features
  target/s390x: mark CSST, CSST2, FPSEH facilities as available

 target/s390x/cpu.h         |  24 +++++-
 target/s390x/cpu_models.c  |   4 +
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def |   2 +
 target/s390x/mem_helper.c  | 181 +++++++++++++++++++++++++++++++++++++++++----
 target/s390x/translate.c   |  78 +++++++++++--------
 6 files changed, 243 insertions(+), 47 deletions(-)

-- 
2.9.4
