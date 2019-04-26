Received: from eggs.gnu.org ([209.51.188.92]:59436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-00062c-Ej
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UF-0006Nl-FO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006MG-6u
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id y27so1268154pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 11:22:08 -0700
Message-Id: <20190426182210.10442-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/2] target/hppa patch queue
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

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190426

for you to fetch changes up to 647ad90a1eb6c016071d21e4f1e22b9cd4986417:

  target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-26 11:09:22 -0700)

----------------------------------------------------------------
Implement fast tlb insert insns.
Fix data tlb exception for pa 1.1.

----------------------------------------------------------------
Nick Hudson (2):
      target/hppa: Implement Fast TLB Insert instructions
      target/hppa: Always return EXCP_DMAR for protection id trap

 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/insns.decode |  3 +++
 3 files changed, 58 insertions(+), 2 deletions(-)
