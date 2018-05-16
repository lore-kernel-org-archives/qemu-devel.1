Received: from eggs.gnu.org ([2001:4830:134:3::10]:40868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4w2-0007Qo-T9
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4vz-0007Gq-IL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:14 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4vz-0007GB-DU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:11 -0400
Received: by mail-pl0-x229.google.com with SMTP id i5-v6so1250563plt.2
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:40 -0700
Message-Id: <20180516223007.10256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3-a 00/27] target/arm: Scalable Vector
 Extension
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

This is the first third, more or less, of my current patch set.
I'm sending only this portion now, rather than another monster
set all at once.

The major change is to move the call to sve_access_check inside
any final decode reject that might be required.  There are other
minor cleanups to patch integrity and comments.

The changes are mostly trivial from the February v2 patch set,
so if an R-b was given, I have retained it.

That leaves 4, 7, 8, and 26 (new) as unreviewed.

The patch that enables SVE for aarch64-linux-user is not present.


r~


Richard Henderson (27):
  target/arm: Introduce translate-a64.h
  target/arm: Add SVE decode skeleton
  target/arm: Implement SVE Bitwise Logical - Unpredicated Group
  target/arm: Implement SVE load vector/predicate
  target/arm: Implement SVE predicate test
  target/arm: Implement SVE Predicate Logical Operations Group
  target/arm: Implement SVE Predicate Misc Group
  target/arm: Implement SVE Integer Binary Arithmetic - Predicated Group
  target/arm: Implement SVE Integer Reduction Group
  target/arm: Implement SVE bitwise shift by immediate (predicated)
  target/arm: Implement SVE bitwise shift by vector (predicated)
  target/arm: Implement SVE bitwise shift by wide elements (predicated)
  target/arm: Implement SVE Integer Arithmetic - Unary Predicated Group
  target/arm: Implement SVE Integer Multiply-Add Group
  target/arm: Implement SVE Integer Arithmetic - Unpredicated Group
  target/arm: Implement SVE Index Generation Group
  target/arm: Implement SVE Stack Allocation Group
  target/arm: Implement SVE Bitwise Shift - Unpredicated Group
  target/arm: Implement SVE Compute Vector Address Group
  target/arm: Implement SVE floating-point exponential accelerator
  target/arm: Implement SVE floating-point trig select coefficient
  target/arm: Implement SVE Element Count Group
  target/arm: Implement SVE Bitwise Immediate Group
  target/arm: Implement SVE Integer Wide Immediate - Predicated Group
  target/arm: Implement SVE Permute - Extract Group
  target/arm: Extend vec_reg_offset to larger sizes
  target/arm: Implement SVE Permute - Unpredicated Group

 target/arm/cpu.h           |    8 +-
 target/arm/helper-sve.h    |  450 ++++++++
 target/arm/helper.h        |    1 +
 target/arm/translate-a64.h |  118 ++
 target/arm/sve_helper.c    | 1676 +++++++++++++++++++++++++++
 target/arm/translate-a64.c |  119 +-
 target/arm/translate-sve.c | 2203 ++++++++++++++++++++++++++++++++++++
 .gitignore                 |    1 +
 target/arm/Makefile.objs   |   10 +
 target/arm/sve.decode      |  446 ++++++++
 10 files changed, 4933 insertions(+), 99 deletions(-)
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/translate-a64.h
 create mode 100644 target/arm/sve_helper.c
 create mode 100644 target/arm/translate-sve.c
 create mode 100644 target/arm/sve.decode

-- 
2.17.0
