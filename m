Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCSLU-0000OY-6m
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eCSLR-000262-44
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:52 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:52704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eCSLQ-00025W-T5
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:32:49 -0500
Received: by mail-wr0-x243.google.com with SMTP id j23so2772256wra.9
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:32:48 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  8 Nov 2017 15:32:43 +0000
Message-Id: <20171108153245.20740-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] fixing translation time segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is a follow up to the patch I posted yesterday. I've made some
clean-ups to the comments and logic as suggested from the review.
Additionally I've added a clean-up patch which tidied up all the
call-sites which no longer need to check retaddr/pc before calling
cpu_restore_state.

Alex Bennée (2):
  accel/tcg/translate-all: expand cpu_restore_state addr check
  target/*helper: don't check retaddr before calling cpu_restore_state

 accel/tcg/translate-all.c                  | 52 +++++++++++++++++-------------
 include/exec/exec-all.h                    | 11 +++++++
 scripts/coccinelle/cpu_restore_state.cocci | 12 +++++++
 target/alpha/mem_helper.c                  | 12 ++-----
 target/arm/op_helper.c                     | 17 +++-------
 target/i386/svm_helper.c                   |  4 +--
 target/lm32/op_helper.c                    |  7 ++--
 target/m68k/op_helper.c                    |  7 ++--
 target/microblaze/op_helper.c              |  7 ++--
 target/moxie/helper.c                      |  4 +--
 target/nios2/mmu.c                         |  7 ++--
 target/openrisc/mmu_helper.c               |  7 ++--
 target/s390x/excp_helper.c                 |  4 +--
 target/tricore/op_helper.c                 | 11 ++-----
 target/unicore32/op_helper.c               |  7 ++--
 15 files changed, 77 insertions(+), 92 deletions(-)
 create mode 100644 scripts/coccinelle/cpu_restore_state.cocci

-- 
2.14.2
