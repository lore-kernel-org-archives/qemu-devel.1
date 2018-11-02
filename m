Received: from eggs.gnu.org ([2001:4830:134:3::10]:60788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhp-0007C7-AE
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIZhn-0007PY-Bd
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIZhl-00079j-NJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:41:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id d10-v6so2043157wrs.5
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Nov 2018 13:41:08 +0000
Message-Id: <20181102134112.26370-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 0/4] target/arm: LOR, HPD,
 AA32HPD extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Three relatively simple post-8.0 extensions.


r~


Richard Henderson (4):
  target/arm: Move id_aa64mmfr* to ARMISARegisters
  target/arm: Implement the ARMv8.1-LOR extension
  target/arm: Implement the ARMv8.1-HPD extension
  target/arm: Implement the ARMv8.2-AA32HPD extension

 target/arm/cpu.h           | 35 ++++++++++++++++-
 target/arm/internals.h     |  3 +-
 target/arm/cpu.c           |  4 ++
 target/arm/cpu64.c         | 11 ++++--
 target/arm/helper.c        | 80 +++++++++++++++++++++++++++++++++-----
 target/arm/translate-a64.c | 12 ++++++
 6 files changed, 129 insertions(+), 16 deletions(-)

-- 
2.17.2
