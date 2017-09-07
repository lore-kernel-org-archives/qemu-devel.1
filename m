Received: from eggs.gnu.org ([2001:4830:134:3::10]:41753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1P1-0003HZ-5I
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1Ov-0007XN-Ct
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:46 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1Ov-0007WJ-6z
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:19:41 -0400
Received: by mail-pg0-x235.google.com with SMTP id t3so887973pgt.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:19:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:19:34 -0700
Message-Id: <20170907181938.3948-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/4] target/alpha queued patches
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

Convert to TranslatorOps and do_transaction_failed.


r~


The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-axp-20170907

for you to fetch changes up to 6ad4d7eed05a1e23537fc92b50f898f5977f37e6:

  target/alpha: Switch to do_transaction_failed() hook (2017-09-07 11:15:55 -0700)

----------------------------------------------------------------
Queued target/alpha patches

----------------------------------------------------------------
Peter Maydell (1):
      target/alpha: Switch to do_transaction_failed() hook

Richard Henderson (3):
      target/alpha: Convert to DisasJumpType
      target/alpha: Convert to DisasContextBase
      target/alpha: Convert to TranslatorOps

 target/alpha/cpu.c        |   2 +-
 target/alpha/cpu.h        |   8 +-
 target/alpha/helper.c     |   8 ++
 target/alpha/mem_helper.c |  19 +--
 target/alpha/translate.c  | 347 +++++++++++++++++++++-------------------------
 5 files changed, 180 insertions(+), 204 deletions(-)
