Received: from eggs.gnu.org ([2001:4830:134:3::10]:51891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6a-0000JA-BQ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fup6Z-0003rE-Hj
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:08 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fup6Z-0003qi-8x
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 21:17:07 -0400
Received: by mail-lj1-x241.google.com with SMTP id s12-v6so2981876ljj.0
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 18:17:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 Aug 2018 18:16:50 -0700
Message-Id: <20180829011652.4466-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] target/xtensa: convert to
 do_transaction_failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hello,

this series converts target/xtensa to use do_transaction_failed callback
and adds a test that checks various types of access to the physically
unmapped addresses.

Changes v1->v2:
- change ldl_phys to address_space_ldl in get_pte and check transaction
  for success;
- add tests that attempt TLB autorefill from the physically unmapped
  addresses.

Max Filippov (2):
  target/xtensa: convert to do_transaction_failed
  tests/tcg/xtensa: add test for failed memory transactions

 target/xtensa/cpu.c              |   2 +-
 target/xtensa/cpu.h              |   7 ++-
 target/xtensa/helper.c           |  22 ++++++-
 target/xtensa/op_helper.c        |  12 ++--
 tests/tcg/xtensa/Makefile        |   1 +
 tests/tcg/xtensa/test_phys_mem.S | 124 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 156 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_phys_mem.S

-- 
2.11.0
