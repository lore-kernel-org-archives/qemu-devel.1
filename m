Received: from eggs.gnu.org ([2001:4830:134:3::10]:34198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebIBW-0005ys-81
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ebIBR-00073w-AQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:45:14 -0500
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:40937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ebIBR-00073m-5I
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 22:45:09 -0500
Received: by mail-pl0-x236.google.com with SMTP id 62so5141477pld.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 19:45:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 15 Jan 2018 19:45:01 -0800
Message-Id: <20180116034503.31926-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/4] tcg/arm fixes
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

Patch 1:
  * Use rsb/rsc for gt/le.  Now we always use "rI" as a constraint,
    so we never have to load immediates into registers by hand.

Patch 2:
  * We can't use add_ofs in the while condition and cmp_ofs in the
    reduction and converge; use cmp_ofs always.  Fixes the sparc64
    regression that Peter noticed.


r~


Richard Henderson (4):
  tcg/arm: Fix double-word comparisons
  tcg/arm: Support tlb offsets larger than 64k
