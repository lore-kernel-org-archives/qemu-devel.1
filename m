Received: from eggs.gnu.org ([2001:4830:134:3::10]:50810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5IFh-0007gq-D6
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5IFe-00088Z-7P
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:17 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:48786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5IFe-00087s-0r
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:21:14 -0400
Received: by mail-pf0-x241.google.com with SMTP id b79so7825158pfk.5
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:21:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Oct 2017 14:21:07 -0700
Message-Id: <20171019212109.11341-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] Fix armeb-linux-user disassembly
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

Reported in 
  https://bugs.launchpad.net/qemu/+bug/1724485

There's one existing bug here, wrt setting INSN_ARM_BE32, and
another when it comes to the capstone disassembler patch set.


r~


Richard Henderson (2):
  target/arm: Move BE32 disassembler fixup
  target/arm: Don't set INSN_ARM_BE32 for CONFIG_USER_ONLY

 include/disas/bfd.h |  7 -------
 disas/arm.c         | 21 ++++++++++++++++-----
 target/arm/cpu.c    | 28 +++++++---------------------
 3 files changed, 23 insertions(+), 33 deletions(-)

-- 
2.13.6
