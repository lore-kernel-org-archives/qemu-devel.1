Received: from eggs.gnu.org ([209.51.188.92]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK43-0003tG-Vd
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwK42-0004xg-Vt
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:04:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwK41-0004vw-7T
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 00:04:58 -0500
Received: by mail-pg1-x543.google.com with SMTP id m1so11228719pgq.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 21:04:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 21:04:48 -0800
Message-Id: <20190220050451.10939-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] target/arm: Implement ARMv8.5-CondM
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

Based-on: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02733.html
aka the v3 ARMv8.5-MemTag patch set,
or at least some of the early patches that split handle_msr_i.

The v8.4 parts have been tested vs FVP, but there's no released
version that supports v8.5 yet, so XAFlag and AXFlag are untested.
But they seem fairly straightforward, unless I've done something silly.


r~


Richard Henderson (3):
  target/arm: Rearrange disas_data_proc_reg
  target/arm: Implement ARMv8.4-CondM
  target/arm: Implement ARMv8.5-CondM

 target/arm/cpu.h           |  10 ++
 linux-user/elfload.c       |   1 +
 target/arm/cpu64.c         |   1 +
 target/arm/translate-a64.c | 249 +++++++++++++++++++++++++++++++------
 4 files changed, 221 insertions(+), 40 deletions(-)

-- 
2.17.2
