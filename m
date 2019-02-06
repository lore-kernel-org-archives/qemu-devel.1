Received: from eggs.gnu.org ([209.51.188.92]:53309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFlf-0003kM-L2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grFle-00068U-Jw
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:32921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grFle-000688-Cf
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 00:29:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id h22so893635wmb.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 21:29:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 05:28:54 +0000
Message-Id: <20190206052857.5077-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/3] target/arm: Implement ARMv8.3-JSConv
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

Changes since v1:
  * Typo fixed in patch 2, which had scrogged FMOV
  * Return 0 for NaN, as for any other ARM fp conversion.


r~


Richard Henderson (3):
  target/arm: Force result size into dp after operation
  target/arm: Restructure disas_fp_int_conv
  target/arm: Implement ARMv8.3-JSConv

 target/arm/cpu.h           |  10 ++++
 target/arm/helper.h        |   2 +
 target/arm/cpu.c           |   1 +
 target/arm/cpu64.c         |   2 +
 target/arm/op_helper.c     |  76 +++++++++++++++++++++++
 target/arm/translate-a64.c | 120 +++++++++++++++++++++++--------------
 target/arm/translate.c     |  47 ++++++++++-----
 7 files changed, 197 insertions(+), 61 deletions(-)

-- 
2.17.2
