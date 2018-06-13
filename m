Received: from eggs.gnu.org ([2001:4830:134:3::10]:43977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv1s-0002A6-OX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv1p-0006CN-KU
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:56 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:40312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv1p-0006C8-DK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:56:53 -0400
Received: by mail-pg0-x236.google.com with SMTP id l2-v6so457681pgc.7
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:56:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:23 -1000
Message-Id: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 00/18] target/arm: SVE instructions, part 2
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

Here's the second installment of SVE instructions.
There are about 25 patches waiting for a third installment;
this makes a nice break before beginning with the memory ops.

Since v3, r-b tags, comment fixes, and other review feedback.


r~


Richard Henderson (18):
  target/arm: Extend vec_reg_offset to larger sizes
  target/arm: Implement SVE Permute - Unpredicated Group
  target/arm: Implement SVE Permute - Predicates Group
  target/arm: Implement SVE Permute - Interleaving Group
  target/arm: Implement SVE compress active elements
  target/arm: Implement SVE conditionally broadcast/extract element
  target/arm: Implement SVE copy to vector (predicated)
  target/arm: Implement SVE reverse within elements
  target/arm: Implement SVE vector splice (predicated)
  target/arm: Implement SVE Select Vectors Group
  target/arm: Implement SVE Integer Compare - Vectors Group
  target/arm: Implement SVE Integer Compare - Immediate Group
  target/arm: Implement SVE Partition Break Group
  target/arm: Implement SVE Predicate Count Group
  target/arm: Implement SVE Integer Compare - Scalars Group
  target/arm: Implement FDUP/DUP
  target/arm: Implement SVE Integer Wide Immediate - Unpredicated Group
  target/arm: Implement SVE Floating Point Arithmetic - Unpredicated
    Group

 target/arm/helper-sve.h    |  294 ++++++++
 target/arm/helper.h        |   19 +
 target/arm/translate-a64.h |   26 +-
 target/arm/sve_helper.c    | 1250 +++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 1458 ++++++++++++++++++++++++++++++++++++
 target/arm/vec_helper.c    |   69 ++
 target/arm/sve.decode      |  248 ++++++
 7 files changed, 3355 insertions(+), 9 deletions(-)

-- 
2.17.1
