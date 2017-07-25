Received: from eggs.gnu.org ([2001:4830:134:3::10]:56904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiK-0004eO-48
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiH-0005lY-16
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:48 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:35979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZpiG-0005lJ-TB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:44 -0400
Received: by mail-qt0-x22c.google.com with SMTP id v29so1098157qtv.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:36:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 19:36:07 -0700
Message-Id: <20170725023611.9169-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/4] target/s390x ilen via unwinding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

David Hildenbrand recently posted a series of patches correcting
various mistakes in the computation of ILEN for various instructions
in the respective helpers.

I think a better approach is to include ilen in the set of unwind
data for each insn.  In this way we can fix these sorts of errors
automatically.  At the same time begin to wean ourselves away from
ILEN_AUTO, which requires re-reading from the instruction stream.

Almost certainly 2.11 material.  Thoughts?


r~


Richard Henderson (4):
  target/s390x: Add ilen to unwind data
  target/s390x: Use ILEN_UNWIND in trivial cases
  target/s390x: Use unwind info in STSI
  target/s390x: Use ilen from unwind in tlb_fill

 target/s390x/cpu.h         |  9 ++++++---
 target/s390x/helper.c      | 14 ++++++++------
 target/s390x/mem_helper.c  | 39 +++++++++++++++++++++++++--------------
 target/s390x/misc_helper.c | 10 +++++++---
 target/s390x/translate.c   | 10 ++++++++--
 5 files changed, 54 insertions(+), 28 deletions(-)

-- 
2.13.3
