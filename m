Received: from eggs.gnu.org ([2001:4830:134:3::10]:58693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fanvD-0004mR-Et
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fanvA-0001eN-FV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:39 -0400
Received: from smtp37.i.mail.ru ([94.100.177.97]:38706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fanvA-0001cD-2i
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:58:36 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Wed,  4 Jul 2018 22:58:10 +0300
Message-Id: <20180704195812.28798-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH 0/2] nvic: Handle ARMv6-M SCS reserved registers
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

Julia Suvorova (2):
  nvic: Handle ARMv6-M SCS reserved registers
  tests: Add ARMv6-M reserved register test

 hw/intc/armv7m_nvic.c             | 69 +++++++++++++++++++++++++------
 tests/Makefile.include            |  2 +
 tests/tcg/arm/test-reserved-reg.c | 60 +++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/arm/test-reserved-reg.c

-- 
2.17.1
