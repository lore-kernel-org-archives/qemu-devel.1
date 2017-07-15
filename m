Received: from eggs.gnu.org ([2001:4830:134:3::10]:50083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuE-0006Q5-4r
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQu9-0000lv-Dn
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:02 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:35379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQu9-0000lh-7x
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:30:57 -0400
Received: by mail-pg0-x231.google.com with SMTP id v190so1739090pgv.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:30:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:42 -1000
Message-Id: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 0/8] target/s390x tcg improvements
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

Instructions implementing another missing facility,
getting us a bit closer to being able to upgrade the
default tcg cpu.

Plus one bug fix for an existing instruction that
isn't used unless we upgrade the tcg cpu.


r~


The following changes since commit 4871b51b9241b10f4fd8e04bbb21577886795e25:

  vmgenid-test: use boot-sector infrastructure (2017-07-14 17:03:03 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170715

for you to fetch changes up to 4fb4047e74c21a3692360b9b1df473d7512d8055:

  target/s390x: Fix risbg handling (2017-07-15 07:17:36 -1000)

----------------------------------------------------------------
Queued s390x tcg patches

----------------------------------------------------------------
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
 target/s390x/translate.c   |  99 +++++++-
 target/s390x/insn-data.def |  21 +-
 5 files changed, 696 insertions(+), 25 deletions(-)
