Received: from eggs.gnu.org ([2001:4830:134:3::10]:51947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4xt-0007cY-RA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4xq-0005a4-MH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:09 -0400
Received: from steffen-goertz.de ([88.198.119.201]:51424)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fY4xq-0005Xm-Ee
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:34:06 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Wed, 27 Jun 2018 09:33:43 +0200
Message-Id: <20180627073351.856-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 0/8] arm: Changes to Microbit Board and NRF51 SOC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This is a series of changes to the NRF51 SOC and the microbit board.
The changes can not be posted as patches as the nrf51 is not mergable
yet due to missing cortex-m0/armv6 support.

"arm: Add NRF51 random number generator peripheral" was already
posted to devel and is being discussed in <20180626104943.2756-1-contrib@=
steffen-goertz.de>

"arm: Add NRF51 SOC non-volatile memory controller" was already=20
posted to devel and is being discussed in
<20180626093204.27612-1-contrib@steffen-goertz.de>

Steffen G=C3=B6rtz (8):
  arm: NRF51/Microbit Memory container and SOC variants
  arm: NRF51 Add unimplemented device for MMIO
  arm: NRF51 create UART in-place, error handling
  arm: NRF51 Calculate peripheral id from base address
  arm: Add NRF51 random number generator peripheral
  arm: Add UICR/FICR handling to NRF51 SOC
  arm: Add NRF51 SOC non-volatile memory controller
  arm: Instantiate NVMC in NRF51.

 hw/arm/microbit.c             |   8 +-
 hw/arm/nrf51_soc.c            | 332 ++++++++++++++++++++++++++--------
 hw/char/nrf51_uart.c          |  10 +-
 hw/misc/Makefile.objs         |   1 +
 hw/misc/nrf51_rng.c           | 243 +++++++++++++++++++++++++
 hw/nvram/Makefile.objs        |   1 +
 hw/nvram/nrf51_nvmc.c         | 168 +++++++++++++++++
 include/hw/arm/nrf51_soc.h    |  38 +++-
 include/hw/char/nrf51_uart.h  |  26 +--
 include/hw/misc/nrf51_rng.h   |  73 ++++++++
 include/hw/nvram/nrf51_nvmc.h |  51 ++++++
 11 files changed, 845 insertions(+), 106 deletions(-)
 create mode 100644 hw/misc/nrf51_rng.c
 create mode 100644 hw/nvram/nrf51_nvmc.c
 create mode 100644 include/hw/misc/nrf51_rng.h
 create mode 100644 include/hw/nvram/nrf51_nvmc.h

--=20
2.17.1
