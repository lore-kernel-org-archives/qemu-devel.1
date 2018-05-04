Received: from eggs.gnu.org ([2001:4830:134:3::10]:38245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSP-0008OY-TP
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSM-0004c3-Qs
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:37 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:34865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSM-0004aT-Cq
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:34 -0400
Received: by mail-pf0-x229.google.com with SMTP id j5so16586127pfh.2
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:17 -0700
Message-Id: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/13] target/openrisc: Convert to decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

While the openrisc decode isn't particularly complicated,
the result, I think, is still cleaner.


r~


Richard Henderson (13):
  target-openrisc: Write back result before FPE exception
  target/openrisc: Start conversion to decodetree.py
  target/openrisc: Convert branch insns
  target/openrisc: Convert memory insns
  target/openrisc: Convert remainder of dec_misc insns
  target/openrisc: Convert dec_calc
  target/openrisc: Convert dec_mac
  target/openrisc: Convert dec_logic
  target/openrisc: Convert dec_M
  target/openrisc: Convert dec_comp
  target/openrisc: Convert dec_compi
  target/openrisc: Convert dec_float
  target/openrisc: Merge disas_openrisc_insn

 target/openrisc/helper.h      |   25 +-
 target/openrisc/fpu_helper.c  |  250 ++----
 target/openrisc/translate.c   | 1847 +++++++++++++++++++----------------------
 target/openrisc/Makefile.objs |    9 +
 target/openrisc/insns.decode  |  189 +++++
 5 files changed, 1110 insertions(+), 1210 deletions(-)
 create mode 100644 target/openrisc/insns.decode

-- 
2.14.3
