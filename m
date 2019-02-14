Received: from eggs.gnu.org ([209.51.188.92]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu89f-0006m8-DJ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gu7wL-00074t-2X
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:43:57 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gu7wK-0006y0-Pt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:43:57 -0500
Received: by mail-pl1-x644.google.com with SMTP id r14so2356067pls.12
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 19:43:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 13 Feb 2019 19:43:41 -0800
Message-Id: <20190214034345.24722-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Implement ARMv8.2-FHM
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

Tested with RISU vs Foundation Model, both a32 and a64.

I am aware of a trivial conflict with the ARMv8.3-JSConv patch set.
I just thought it was easier to manage separately based on master.


r~


Richard Henderson (4):
  target/arm: Add helpers for FMLAL and FMLSL
  target/arm: Implement FMLAL and FMLSL for aarch64
  target/arm: Implement VFMAL and VFMSL for aarch32
  target/arm: Enable ARMv8.2-FHM for -cpu max

 target/arm/cpu.h           |  10 +++
 target/arm/helper.h        |   9 +++
 target/arm/cpu.c           |   1 +
 target/arm/cpu64.c         |   2 +
 target/arm/translate-a64.c |  49 +++++++++++-
 target/arm/translate.c     | 104 ++++++++++++++++++-------
 target/arm/vec_helper.c    | 154 +++++++++++++++++++++++++++++++++++++
 7 files changed, 299 insertions(+), 30 deletions(-)

-- 
2.17.2
