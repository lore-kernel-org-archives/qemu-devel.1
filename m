Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUE-0007z8-Lr
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUC-0001k2-7O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:45:58 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUC-0001jW-1j
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:45:56 -0500
Received: by mail-pl0-x231.google.com with SMTP id n13so5240459plp.11
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:45:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:29 -0800
Message-Id: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC 00/23] target/arm: decode generator and initial
 sve patches
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

The most important part here, for review, is the first patch.

I add a code generator, writen in python, which takes an input file
that describes the opcode bits and field bits of the instructions,
and outputs a function that does all of the decoding.

The subsequent patches begin to add SVE support and also demonstrate
how I envision how both the decoder and the tcg host vector support
are to be used.  Thus, review of the direction would be appreciated
before there are another 100 patches along the same style.


r~


Richard Henderson (23):
  scripts: Add decodetree.py
  target/arm: Add SVE decode skeleton
  target/arm: Implement SVE Bitwise Logical - Unpredicated Group
  target/arm: Implement PTRUE, PFALSE, SETFFR
  target/arm: Implement SVE predicate logical operations
  target/arm: Implement SVE load vector/predicate
  target/arm: Implement SVE Integer Binary Arithmetic - Predicated Group
  target/arm: Handle SVE registers in write_fp_dreg
  target/arm: Handle SVE registers when using clear_vec_high
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
  target/arm: Implement SVE Element Count Group, register destinations

 target/arm/helper-sve.h    |  409 ++++++++++++++
 target/arm/helper.h        |    1 +
 target/arm/translate-a64.h |  112 ++++
 target/arm/sve_helper.c    | 1177 +++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  272 +++------
 target/arm/translate-sve.c | 1313 ++++++++++++++++++++++++++++++++++++++++++++
 .gitignore                 |    1 +
 scripts/decodetree.py      |  984 +++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |   11 +
 target/arm/sve.def         |  328 +++++++++++
 10 files changed, 4418 insertions(+), 190 deletions(-)
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/translate-a64.h
 create mode 100644 target/arm/sve_helper.c
 create mode 100644 target/arm/translate-sve.c
 create mode 100755 scripts/decodetree.py
 create mode 100644 target/arm/sve.def

-- 
2.14.3
