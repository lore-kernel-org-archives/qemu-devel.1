Received: from eggs.gnu.org ([209.51.188.92]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbde-000721-Cl
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwbdV-0005bX-0f
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:48 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwbdT-0003vK-VB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:50:44 -0500
Received: by mail-pg1-x52d.google.com with SMTP id u9so9208835pgo.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 15:50:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Feb 2019 15:50:15 -0800
Message-Id: <20190220235017.1060-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: SB and PredRes extensions
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

Both of these are defined by the ARMv8.5 spec, but back-defined
as v8.0 extensions.

All of the relevant instructions are nops within QEMU.  Tested by
locally setting SCTLR_EL1.EnRCTX for aarch64-linux-user and then
executing each of the insns to see that they decode properly.

The SB extension is already upstream in linux 5.0-rc1, with the
HWCAP entry.  The PredRes extension has no upstream support yet,
so we need to wait to see what they do for userland ABI.


r~


Richard Henderson (2):
  target/arm: Implement ARMv8.0-SB
  target/arm: Implement ARMv8.0-PredRes

 target/arm/cpu.h           | 21 ++++++++++++++++
 linux-user/elfload.c       |  1 +
 target/arm/cpu.c           |  2 ++
 target/arm/cpu64.c         |  4 ++++
 target/arm/helper.c        | 49 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 14 +++++++++++
 target/arm/translate.c     | 22 +++++++++++++++++
 7 files changed, 113 insertions(+)

-- 
2.17.2
