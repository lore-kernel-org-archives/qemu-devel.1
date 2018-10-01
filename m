Received: from eggs.gnu.org ([2001:4830:134:3::10]:43300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g72mv-0003OL-E4
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1g72mu-0006L9-NB
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:19:21 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1g72mu-0006BE-Ec
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:19:20 -0400
Received: by mail-lf1-x142.google.com with SMTP id r191-v6so10636152lff.2
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 11:19:20 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  1 Oct 2018 11:18:58 -0700
Message-Id: <20181001181858.21086-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 00/15] target/xtensa: preparation for FLIX
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following series that rearranges target/xtensa code in
preparation for FLIX support.
The following changes since commit c5e4e49258e9b89cb34c085a419dd9f862935c48:

  Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2018-09-25' into staging (2018-09-25 16:47:35 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20181001-xtensa

for you to fetch changes up to d74624e59a6087ccf233843b936aedc9f8a8050a:

  target/xtensa: extract gen_check_interrupts call (2018-10-01 11:08:36 -0700)

----------------------------------------------------------------
target/xtensa: preparation for FLIX support

Separate generation of per-instruction code (such as raising exceptions
and terminating TB) from per-opcode code.

----------------------------------------------------------------
Max Filippov (15):
      target/xtensa: extract test for an illegal instruction
      target/xtensa: extract test for privileged instruction
      target/xtensa: extract test for syscall instruction
      target/xtensa: extract test for debug exception
      target/xtensa: extract test for window overflow exception
      target/xtensa: extract test for window underflow exception
      target/xtensa: extract test for alloca exception
      target/xtensa: extract test for cpdisabled exception
      target/xtensa: extract test for division by zero
      target/xtensa: extract unconditional TB termination
      target/xtensa: change SR number checks to assertions
      target/xtensa: always end TB on CCOUNT access/CCOMPARE write
      target/xtensa: extract unconditional TB termination via slot 0
      target/xtensa: make rsr/wsr helpers return void
      target/xtensa: extract gen_check_interrupts call

 target/xtensa/cpu.h       |   37 +-
 target/xtensa/helper.c    |    6 +
 target/xtensa/helper.h    |    2 +
 target/xtensa/op_helper.c |   73 +-
 target/xtensa/translate.c | 2673 +++++++++++++++++++++++++++++----------------
 5 files changed, 1817 insertions(+), 974 deletions(-)

Thanks.
-- Max
