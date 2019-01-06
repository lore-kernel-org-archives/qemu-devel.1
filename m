Received: from eggs.gnu.org ([209.51.188.92]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggHFm-0003ln-76
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggHFl-0004fd-G5
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:50:46 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:36490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggHFl-0004fO-3T
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 17:50:45 -0500
Received: by mail-pg1-x532.google.com with SMTP id n2so19871520pgm.3
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 14:50:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  7 Jan 2019 08:50:32 +1000
Message-Id: <20190106225035.5671-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] target/arm: Vector expansion improvments.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Based-on: <20190104223116.14037-1-richard.henderson@linaro.org>
which is queued in my tcg-next branch.

Patch 1 removes some conditionals that were added to the
generic expander.  The other two make use of the new min/max
vector expanders.


r~


Richard Henderson (3):
  target/arm: Rely on optimization within tcg_gen_gvec_or
  target/arm: Use vector minmax expanders for aarch64
  target/arm: Use vector minmax expanders for aarch32

 target/arm/translate-a64.c | 41 ++++++++++++++------------------------
 target/arm/translate-sve.c |  6 +-----
 target/arm/translate.c     | 37 ++++++++++++++++++++--------------
 3 files changed, 38 insertions(+), 46 deletions(-)

-- 
2.17.2
