Received: from eggs.gnu.org ([2001:4830:134:3::10]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSI-0007Z8-3H
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDeSH-00053v-7o
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:34 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDeSH-00053h-3t
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:08:33 -0400
Received: by mail-qk0-x244.google.com with SMTP id u75so28153754qka.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:08:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 15:08:23 -0700
Message-Id: <20170524220827.21154-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/4] target/s390x Implement EXECUTE via
 TranslationBlock
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

This is the rewrite of EX that I posted last week, fixed with
Aurelien's help, and adjusted to be applied on top of my v2 unwind
patch set.

It also splits the patch into more pieces to make it easier to debug,
and keeps the direct implementation of the most common target insns.
Which are in fact so common I don't see any other usage while booting
the debian installer.


r~


Richard Henderson (4):
  target/s390x: Save current ilen during translation
  target/s390x: End the TB after EXECUTE
  target/s390x: Implement EXECUTE via new TranslationBlock
  target/s390x: Re-implement a few EXECUTE target insns directly

 target/s390x/cpu.h        |   4 +-
 target/s390x/helper.c     |   5 ++
 target/s390x/machine.c    |  19 ++++++
 target/s390x/mem_helper.c | 156 ++++++++++++++++------------------------------
 target/s390x/translate.c  |  92 ++++++++++++++++-----------
 5 files changed, 136 insertions(+), 140 deletions(-)

-- 
2.9.4
