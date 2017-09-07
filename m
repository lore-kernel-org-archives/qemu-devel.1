Received: from eggs.gnu.org ([2001:4830:134:3::10]:54104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tJ-000080-03
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1tE-0000Sl-Cs
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:05 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1tE-0000SP-5n
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:51:00 -0400
Received: by mail-pg0-x22d.google.com with SMTP id d8so979589pgt.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:51:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:50:52 -0700
Message-Id: <20170907185057.23421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/5] target/sh4 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net

Mostly the update for TranslatorOps.

But also a new implementation of movco using cmpxchg.  
Aurelien had previously requested the change exclude
system mode.  I've made the change only for parallel_cpus.


r~


Richard Henderson (5):
  target/sh4: Use cmpxchg for movco when parallel_cpus
  target/sh4: Convert to DisasJumpType
  target/sh4: Do not singlestep after exceptions
  target/sh4: Convert to DisasContextBase
  target/sh4: Convert to TranslatorOps

 linux-user/main.c      |  19 +-
 target/sh4/cpu.h       |   4 +-
 target/sh4/helper.c    |   1 +
 target/sh4/translate.c | 490 +++++++++++++++++++++++++++----------------------
 4 files changed, 291 insertions(+), 223 deletions(-)

-- 
2.13.5
