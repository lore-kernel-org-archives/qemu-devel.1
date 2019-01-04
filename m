Received: from eggsout.gnu.org ([209.51.188.92]:54788 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfY02-0002dQ-KF
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfXzz-0001Cm-GO
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:30 -0500
Received: from mail-it1-x12c.google.com ([2607:f8b0:4864:20::12c]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfXzz-0001Bk-C0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:31:27 -0500
Received: by mail-it1-x12c.google.com with SMTP id p197so3463998itp.0
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:31:27 -0800 (PST)
Received: from cloudburst.twiddle.net ([172.56.12.23])
	by smtp.gmail.com with ESMTPSA id
	t6sm27793259ioc.87.2019.01.04.14.31.23 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 04 Jan 2019 14:31:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  5 Jan 2019 08:31:06 +1000
Message-Id: <20190104223116.14037-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I've split this out from the target/ppc patch set in which
it was developed.


r~


Richard Henderson (10):
  tcg: Add logical simplifications during gvec expand
  tcg: Add gvec expanders for nand, nor, eqv
  tcg: Add write_aofs to GVecGen4
  tcg: Add opcodes for vector saturated arithmetic
  tcg: Add opcodes for vector minmax arithmetic
  tcg/i386: Split subroutines out of tcg_expand_vec_op
  tcg/i386: Implement vector saturating arithmetic
  tcg/i386: Implement vector minmax arithmetic
  tcg/aarch64: Implement vector saturating arithmetic
  tcg/aarch64: Implement vector minmax arithmetic

 accel/tcg/tcg-runtime.h      |  23 ++
 tcg/aarch64/tcg-target.h     |   2 +
 tcg/i386/tcg-target.h        |   2 +
 tcg/tcg-op-gvec.h            |  18 ++
 tcg/tcg-op.h                 |  11 +
 tcg/tcg-opc.h                |   8 +
 tcg/tcg.h                    |   2 +
 accel/tcg/tcg-runtime-gvec.c | 257 ++++++++++++++++
 tcg/aarch64/tcg-target.inc.c |  48 +++
 tcg/i386/tcg-target.inc.c    | 580 +++++++++++++++++++++--------------
 tcg/tcg-op-gvec.c            | 305 ++++++++++++++++--
 tcg/tcg-op-vec.c             |  75 ++++-
 tcg/tcg.c                    |  10 +
 13 files changed, 1078 insertions(+), 263 deletions(-)

-- 
2.17.2
