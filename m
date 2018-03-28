Received: from eggs.gnu.org ([2001:4830:134:3::10]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10jg-0004R1-Dl
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f10jd-0002jM-88
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:48 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f10jd-0002jC-2q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:22:45 -0400
Received: by mail-pl0-x241.google.com with SMTP id 9-v6so661783ple.11
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 19:22:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Mar 2018 10:22:31 +0800
Message-Id: <20180328022233.13400-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12 0/2] RISC-V: Mark FP status dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mjc@sifive.com, patches@groups.riscv.org, palmer@sifive.com

Since it was my patch that broke FP state tracking in the
first place, I feel obligated to fix it again.

Mark mstatus[fs] as dirty whenever we write to the file.
This can be optimized by only doing so once within a TB
which initially began with a clean file.

I have not yet put together an environment that can test
this, so I'll need someone else to give it a go.


r~


Richard Henderson (2):
  target/riscv: Split out mstatus_fs from tb_flags during translation
  target/riscv: Mark MSTATUS_FS dirty

 target/riscv/cpu.h       |  6 +++---
 target/riscv/op_helper.c | 25 ++++++++++++++++--------
 target/riscv/translate.c | 50 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 64 insertions(+), 17 deletions(-)

-- 
2.14.3
