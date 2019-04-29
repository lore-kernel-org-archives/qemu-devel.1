Received: from eggs.gnu.org ([209.51.188.92]:36434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLEIB-00036M-TV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLEIA-0005y7-Sn
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:36619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLEIA-0005xj-N6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 17:58:30 -0400
Received: by mail-pg1-x530.google.com with SMTP id 85so5818517pgc.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 14:58:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 29 Apr 2019 14:58:21 -0700
Message-Id: <20190429215821.10079-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 0/2] target/hppa patch queue
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

Rebased for v2.

The following changes since commit 82b2865e0d0ea4c1001e9e7ed7920bcc0458f6de:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190429' into staging (2019-04-29 18:05:56 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190429

for you to fetch changes up to affdb7e6ba23f8160cb88e11f83db54a35f03d6b:

  target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-29 14:43:39 -0700)

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
