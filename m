Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZeC-0008HY-GS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDZe9-0000YV-9M
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:04 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDZe8-0000Xj-VY
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:05:01 -0400
Received: by mail-pf0-x243.google.com with SMTP id e9so5636899pfi.4
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  1 May 2018 11:04:53 -0700
Message-Id: <20180501180455.11214-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Coverity fixups
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

The first patch covers four related false positives.  However, 
we check the same condition twice and we certainly don't need
to that.  Plus the assert might just help documentation-wise.

The second patch covers dead code.  I believe that Coverity is
right and that there are no paths that have !is_q at this point.
Add the assert to check that is true.

The RISU tests that I ran over these insns came out clean.


r~


Richard Henderson (2):
  target/arm: Tidy conditions in handle_vec_simd_shri
  target/arm: Tidy condition in disas_simd_two_reg_misc

 target/arm/translate-a64.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.14.3
