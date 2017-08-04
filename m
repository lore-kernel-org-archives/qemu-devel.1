Received: from eggs.gnu.org ([2001:4830:134:3::10]:36239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVA9-0007TJ-Ii
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVA5-00013W-E2
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:41 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVA5-000122-5y
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:37 -0400
Received: by mail-pg0-x241.google.com with SMTP id 123so778116pga.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:28:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:28:22 -0700
Message-Id: <20170804052833.10187-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 0/8] tcg/s390 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, cohuck@redhat.com, borntraeger@de.ibm.com

The distinct-operands facility was introduced with z196, but using
it wasn't practical until the tcg_target_op_def cleanup.

The load-on-condition-2 facility was introduced with z13.  This has
been compile-tested only, because I've never had access to anything
beyond z12.  It'd be nice if someone with access could verify.


r~


Richard Henderson (8):
  tcg/s390: Fully convert tcg_target_op_def
  tcg/s390: Merge cmpi facilities check to tcg_target_op_def
  tcg/s390: Merge muli facilities check to tcg_target_op_def
  tcg/s390: Merge add2i facilities check to tcg_target_op_def
  tcg/s390: Merge ori+xori facilities check to tcg_target_op_def
  tcg/s390: Use distinct-operands facility
  tcg/s390: Use load-on-condition-2 facility
  tcg/s390: Use slbgr for setcond le and leu

 tcg/s390/tcg-target.h     |   2 +
 tcg/s390/tcg-target.inc.c | 700 +++++++++++++++++++++++++---------------------
 2 files changed, 380 insertions(+), 322 deletions(-)

-- 
2.13.3
