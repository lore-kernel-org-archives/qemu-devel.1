Received: from eggs.gnu.org ([2001:4830:134:3::10]:33533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fdYaQ-000398-Fp
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fdYaM-0005FR-Fv
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:12:34 -0400
Received: from steffen-goertz.de ([88.198.119.201]:56138)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fdYaM-0005B8-7l
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 06:12:30 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Thu, 12 Jul 2018 12:12:17 +0200
Message-Id: <20180712101219.32707-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 0/2] Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

Add some non-volatile memories and a non-volatile
memory controller for the nRF51.
Furthermore, a testsuite for the bbc:microbit and
nrf51 soc was added.

Examination of the real device showed that
NVMs remained unchanged when the write/erase enabled
bits are not set in the controller, so we can
safely ignore all writes.
More: https://github.com/douzepouze/gsoc18-qemu/blob/master/notes.md#test=
-nvmc-behavior-out-of-micropython-repl

The CODE/FLASH NVM is not currently included in this
peripheral. It is hosted in the SOC and must be read-only
to provide an accurate model.

Steffen G=C3=B6rtz (2):
  arm: Add NRF51 SOC non-volatile memory controller
  tests: Add bbc:microbit / nRF51 test suite

 hw/nvram/Makefile.objs       |   1 +
 hw/nvram/nrf51_nvm.c         | 401 +++++++++++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h   |   2 +-
 include/hw/nvram/nrf51_nvm.h |  56 +++++
 tests/Makefile.include       |   2 +
 tests/microbit-test.c        | 118 +++++++++++
 6 files changed, 579 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvram/nrf51_nvm.c
 create mode 100644 include/hw/nvram/nrf51_nvm.h
 create mode 100644 tests/microbit-test.c

--=20
2.18.0
