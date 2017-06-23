Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMC-0001SZ-Jk
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORM8-0007lI-Hh
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:52 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORM8-0007kF-DH
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:48 -0400
Received: by mail-qk0-x22f.google.com with SMTP id 16so39554954qkg.2
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:26 -0700
Message-Id: <20170623162241.8964-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/15] Queued target/s390x patches
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

There are more in the pipeline, but these are the ones that
have passed review.  Let's flush before it becomes unwieldy.


r~


The following changes since commit e18a639164e162b3a4f078ab60606cd2f163d934:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170621-pull-request' into staging (2017-06-22 15:09:48 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170623

for you to fetch changes up to be7f28de5d7f635647d7991ace96c54d9f724be4:

  target/s390x: Implement idte instruction (2017-06-23 09:17:45 -0700)

----------------------------------------------------------------
Queued target/s390x patches

----------------------------------------------------------------
David Hildenbrand (5):
      target/s390x: change PSW_SHIFT_KEY
      target/s390x: implement mvcos instruction
      target/s390x: Indicate and check for local tlb clearing
      target/s390x: Improve heuristic for ipte
      target/s390x: Implement idte instruction

Richard Henderson (10):
      target/s390x: Map existing FAC_* names to S390_FEAT_* names
      target/s390x: Mark FPSEH facility as available
      target/s390x: Implement load-on-condition-2 insns
      target/s390x: Implement load-and-zero-rightmost-byte insns
      target/s390x: Mark STFLE_53 facility as available
      target/s390x: Implement execution-hint insns
      target/s390x: Implement processor-assist insn
      target/s390x: Mark STFLE_49 facility as available
      target/s390x: Finish implementing ETF2-ENH
      target/s390x: Clean up TB flag bits

 target/s390x/cpu.h           |  48 +++++---
 target/s390x/cpu_models.c    |   6 +
 target/s390x/helper.h        |   2 +
 target/s390x/insn-data.def   |  30 +++++
 target/s390x/insn-format.def |   1 +
 target/s390x/mem_helper.c    | 270 ++++++++++++++++++++++++++++++++++++++-----
 target/s390x/translate.c     | 143 +++++++++++++++--------
 7 files changed, 411 insertions(+), 89 deletions(-)
