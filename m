Received: from eggs.gnu.org ([2001:4830:134:3::10]:40009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP8-00037F-BI
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKsP5-00043B-75
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:10 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKsP5-00042W-2V
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:27:07 -0400
Received: by mail-qt0-x244.google.com with SMTP id x58so37621818qtc.2
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:27:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 13 Jun 2017 13:26:56 -0700
Message-Id: <20170613202659.1920-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/3] Queued s390x tcg patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Cleanups and fixes from David Hildenbrand.


r~



The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170613

for you to fetch changes up to 076d4d39b65f50ca1bba3d3c8a8f1cf977c1c3f0:

  s390x/cpumodel: wire up cpu type + id for TCG (2017-06-13 11:09:39 -0700)

----------------------------------------------------------------
Queued s390 patches

----------------------------------------------------------------
David Hildenbrand (3):
      target/s390x: correctly indicate PER nullification
      target/s390x: rework PGM interrupt psw.addr handling
      s390x/cpumodel: wire up cpu type + id for TCG

 target/s390x/cpu.h         |  9 +++------
 target/s390x/cpu_models.c  |  8 ++++++--
 target/s390x/helper.c      | 44 +++++++++++++++++++++++++++++++++++---------
 target/s390x/insn-data.def |  2 +-
 target/s390x/misc_helper.c | 31 +++++++++++++++----------------
 target/s390x/mmu_helper.c  |  6 +++---
 target/s390x/translate.c   | 12 +++---------
 7 files changed, 66 insertions(+), 46 deletions(-)
