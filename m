Received: from eggs.gnu.org ([2001:4830:134:3::10]:54391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4G-0005AI-E1
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clw4B-0006S6-Sf
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:12 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:34073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clw4B-0006RX-L7
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:17:07 -0500
Received: by mail-wm0-x231.google.com with SMTP id 196so35140550wmm.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:17:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Mar 2017 11:17:03 +0000
Message-Id: <20170309111714.20394-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/11] MTTCG Fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit b64842dee42d6b24d51283e4722140b73be1e222:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-03-08 09:47:52 +0000)

are available in the git repository at:

  https://github.com/stsquad/qemu.git tags/pull-mttcg-fixups-090317-1

for you to fetch changes up to 68bf93ce9dc5c84c45a827ce2bd6eab768524e79:

  hw/intc/arm_gic: modernise the DPRINTF (2017-03-09 10:41:49 +0000)

----------------------------------------------------------------
Fix-ups for MTTCG regressions for 2.9

This is the same as v3 posted a few days ago except with a few extra
Reviewed-by tags added.

----------------------------------------------------------------
Alex Bennée (9):
      vl/cpus: be smarter with icount and MTTCG
      target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
      cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
      sparc/sparc64: grab BQL before calling cpu_check_irqs
      s390x/misc_helper.c: wrap IO instructions in BQL
      target/xtensa: hold BQL for interrupt processing
      translate-all: exit cpu_restore_state early if translating
      target/arm/helper: make it clear the EC field is also in hex
      hw/intc/arm_gic: modernise the DPRINTF

Paolo Bonzini (1):
      target-i386: defer VMEXIT to do_interrupt

Yongbok Kim (1):
      target/mips: hold BQL for timer interrupts

 cpus.c                      | 11 +++++++----
 hw/intc/arm_gic.c           | 13 +++++++++----
 hw/sparc/sun4m.c            |  3 +++
 hw/sparc64/sparc64.c        |  3 +++
 target/arm/helper.c         |  2 +-
 target/i386/cpu.h           |  5 +++++
 target/i386/seg_helper.c    | 20 +++++++++++---------
 target/i386/svm_helper.c    | 22 +++++++++++++---------
 target/mips/op_helper.c     | 21 ++++++++++++++++++---
 target/s390x/misc_helper.c  | 21 +++++++++++++++++++++
 target/sparc/int64_helper.c |  3 +++
 target/sparc/win_helper.c   | 13 +++++++++++++
 target/xtensa/helper.c      |  1 +
 target/xtensa/op_helper.c   |  7 +++++++
 translate-all.c             | 13 +++++++++++++
 vl.c                        |  7 ++-----
 16 files changed, 130 insertions(+), 35 deletions(-)

-- 
2.11.0
