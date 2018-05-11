Received: from eggs.gnu.org ([2001:4830:134:3::10]:43719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3U-0001sd-46
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGy3R-0005wy-1Q
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:12 -0400
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:45478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGy3Q-0005wq-RS
	for qemu-devel@nongnu.org; Thu, 10 May 2018 22:45:08 -0400
Received: by mail-pl0-x22a.google.com with SMTP id bi12-v6so2410469plb.12
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 19:45:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 19:44:43 -0700
Message-Id: <20180511024454.31679-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/11] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Changes since v2:
  * Rebased vs target-arm.next.
  * Merged Peter's review.
  * Split out return fix as a separate patch.

Changes since v1:
  * Rebased vs master instead of tgt-arm-sve-9.
  * Alex did some additional digging through the ARM xhtml
    and came up with some additional missing instructions.
  * Everything cc'd to qemu-stable.


r~


Alex Bennée (4):
  target/arm: Implement FCMP for fp16
  target/arm: Implement FCSEL for fp16
  target/arm: Implement FMOV (immediate) for fp16
  target/arm: Fix sqrt_f16 exception raising

Richard Henderson (7):
  target/arm: Implement FMOV (general) for fp16
  target/arm: Early exit after unallocated_encoding in disas_fp_int_conv
  target/arm: Implement FCVT (scalar,integer) for fp16
  target/arm: Implement FCVT (scalar,fixed-point) for fp16
  target/arm: Introduce and use read_fp_hreg
  target/arm: Implement FP data-processing (2 source) for fp16
  target/arm: Implement FP data-processing (3 source) for fp16

 target/arm/helper-a64.h    |   2 +
 target/arm/helper.h        |   6 +
 target/arm/helper-a64.c    |  10 +
 target/arm/helper.c        |  38 +++-
 target/arm/translate-a64.c | 421 +++++++++++++++++++++++++++++++------
 5 files changed, 413 insertions(+), 64 deletions(-)

-- 
2.17.0
