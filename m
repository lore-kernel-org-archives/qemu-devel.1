Received: from eggs.gnu.org ([209.51.188.92]:57462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwEuF-0007Vz-CY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwEuC-0001S9-FP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:29 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwEu9-0001Qi-WA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 18:34:26 -0500
Received: by mail-pl1-x641.google.com with SMTP id q3so3815169pll.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 15:34:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 15:34:18 -0800
Message-Id: <20190219233421.388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org

Changes since v1:
  * Apparently I had started a last-minute API change, and failed to
    covert all of the users, and also failed to re-test afterward.
  * Retain assertions for --enable-debug-tcg.


r~


Richard Henderson (3):
  target/arm: Split out recompute_hflags et al
  target/arm: Rebuild hflags at el changes and MSR writes
  target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

 target/arm/cpu.h           |  22 ++-
 target/arm/helper.h        |   3 +
 target/arm/internals.h     |   4 +
 linux-user/syscall.c       |   1 +
 target/arm/cpu.c           |   1 +
 target/arm/helper-a64.c    |   3 +
 target/arm/helper.c        | 279 ++++++++++++++++++++++---------------
 target/arm/machine.c       |   1 +
 target/arm/op_helper.c     |   1 +
 target/arm/translate-a64.c |   6 +-
 target/arm/translate.c     |  14 +-
 11 files changed, 216 insertions(+), 119 deletions(-)

-- 
2.17.1
