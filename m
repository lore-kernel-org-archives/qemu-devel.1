Received: from eggs.gnu.org ([2001:4830:134:3::10]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHh-0005lJ-R6
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkqHe-0004P3-ON
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:21 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:36466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkqHe-0004OQ-KQ
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 08:31:18 -0400
Received: by mail-vk0-x242.google.com with SMTP id y9-v6so9179668vky.3
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 05:31:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 Aug 2018 08:31:07 -0400
Message-Id: <20180801123111.3595-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm sve fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, laurent.desnogues@gmail.com

These four patches are minor, reported by Laurent this week.

If there happens to be an -rc4 release, it would be nice if
they were included.  But if not, no biggie.  I suspect that
other minor issues will be found past these four, so I would
hope everyone who cares about sve is just as happy working
from a branch anyway.


r~


Richard Henderson (4):
  target/arm: Fix sign of sve_cmpeq_ppzw/sve_cmpne_ppzw
  target/arm: Fix typo in do_sat_addsub_64
  target/arm: Reorganize SVE WHILE
  target/arm: Fix typo in helper_sve_movz_d

 target/arm/sve_helper.c    | 19 ++++++--------
 target/arm/translate-sve.c | 51 ++++++++++++++++++++++++--------------
 2 files changed, 40 insertions(+), 30 deletions(-)

-- 
2.17.1
