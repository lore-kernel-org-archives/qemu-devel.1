Received: from eggs.gnu.org ([2001:4830:134:3::10]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCd7-0007i9-Np
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fbCd4-0003U5-KG
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:21:37 -0400
Received: from smtp32.i.mail.ru ([94.100.177.92]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fbCd4-0003P1-Cs
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 18:21:34 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Fri,  6 Jul 2018 01:21:13 +0300
Message-Id: <20180705222115.17013-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 0/2] nvic: Handle ARMv6-M SCS reserved
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v3:
    * Fix indents
v2:
    * Use ARM_FEATURE_M_MAIN instead of ARM_FEATURE_V7 in most cases
    * Remove CPUID registers check
    * Use bad_offset instead of return
    * Misc style fixes

Julia Suvorova (2):
  nvic: Handle ARMv6-M SCS reserved registers
  tests: Add ARMv6-M reserved register test

 hw/intc/armv7m_nvic.c             | 51 ++++++++++++++++++++++++--
 tests/Makefile.include            |  2 ++
 tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/arm/test-reserved-reg.c

-- 
2.17.1
