Received: from eggs.gnu.org ([2001:4830:134:3::10]:39091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVona-0003wr-To
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fVonX-0002r9-30
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:11 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fVonW-0002qC-Sc
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 21:54:07 -0400
Received: by mail-pg0-x233.google.com with SMTP id r21-v6so644101pgv.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:54:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 20 Jun 2018 15:53:24 -1000
Message-Id: <20180621015359.12018-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 00/35] target/arm SVE patches
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

This is the remainder of the SVE enablement patches,
with an extra bonus patch to enable ARMv8.2-DotProd.


r~


Richard Henderson (35):
  target/arm: Implement SVE Memory Contiguous Load Group
  target/arm: Implement SVE Contiguous Load, first-fault and no-fault
  target/arm: Implement SVE Memory Contiguous Store Group
  target/arm: Implement SVE load and broadcast quadword
  target/arm: Implement SVE integer convert to floating-point
  target/arm: Implement SVE floating-point arithmetic (predicated)
  target/arm: Implement SVE FP Multiply-Add Group
  target/arm: Implement SVE Floating Point Accumulating Reduction Group
  target/arm: Implement SVE load and broadcast element
  target/arm: Implement SVE store vector/predicate register
  target/arm: Implement SVE scatter stores
  target/arm: Implement SVE prefetches
  target/arm: Implement SVE gather loads
  target/arm: Implement SVE first-fault gather loads
  target/arm: Implement SVE scatter store vector immediate
  target/arm: Implement SVE floating-point compare vectors
  target/arm: Implement SVE floating-point arithmetic with immediate
  target/arm: Implement SVE Floating Point Multiply Indexed Group
  target/arm: Implement SVE FP Fast Reduction Group
  target/arm: Implement SVE Floating Point Unary Operations-Unpredicated Group
  target/arm: Implement SVE FP Compare with Zero Group
  target/arm: Implement SVE floating-point trig multiply-add coefficient
  target/arm: Implement SVE floating-point convert precision
  target/arm: Implement SVE floating-point convert to integer
  target/arm: Implement SVE floating-point round to integral value
  target/arm: Implement SVE floating-point unary operations
  target/arm: Implement SVE MOVPRFX
  target/arm: Implement SVE floating-point complex add
  target/arm: Implement SVE fp complex multiply add
  target/arm: Pass index to AdvSIMD FCMLA (indexed)
  target/arm: Implement SVE fp complex multiply add (indexed)
  target/arm: Implement SVE dot product (vectors)
  target/arm: Implement SVE dot product (indexed)
  target/arm: Enable SVE for aarch64-linux-user
  target/arm: Implement ARMv8.2-DotProd

 target/arm/cpu.h           |    1 +
 target/arm/helper-sve.h    |  682 ++++++++++++++
 target/arm/helper.h        |   44 +-
 linux-user/elfload.c       |    1 +
 target/arm/cpu.c           |    8 +
 target/arm/cpu64.c         |    2 +
 target/arm/helper.c        |    2 +-
 target/arm/sve_helper.c    | 1827 ++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |   57 +-
 target/arm/translate-sve.c | 1691 ++++++++++++++++++++++++++++++++-
 target/arm/translate.c     |   81 +-
 target/arm/vec_helper.c    |  283 +++++-
 target/arm/sve.decode      |  422 +++++++++
 13 files changed, 5039 insertions(+), 62 deletions(-)

-- 
2.17.1
