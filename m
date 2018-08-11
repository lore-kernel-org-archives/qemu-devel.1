Received: from eggs.gnu.org ([2001:4830:134:3::10]:55049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtC-0005t0-0p
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1foPtB-0001H9-7z
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 05:08:49 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sat, 11 Aug 2018 11:08:29 +0200
Message-Id: <20180811090836.4024-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/7] arm: Instantiation of nRF51 SOC and
 bbc:microbit devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

This patch series extends the stub of the nRF51 SOC and
bbc:microbit machine with the devices provided in the
previous patch series.

Based-on: 20180806100114.21410-1-contrib@steffen-goertz.de

Steffen G=C3=B6rtz (7):
  hw/arm/nrf51_soc: nRF51 Calculate peripheral id from base address
  arm: Move nRF51 machine state to dedicated header
  arm: Add chip variant property to nRF51 SoC
  arm: Add additional datasheets and copyright lines
  arm: Improve error propagation in nRF51 SOC
  arm: Instantiate nRF51 peripherals
  arm: Instantiate Microbit board-level devices

 hw/arm/microbit.c          |  91 ++++++++++++----
 hw/arm/nrf51_soc.c         | 213 +++++++++++++++++++++++++++++++++----
 include/hw/arm/microbit.h  |  30 ++++++
 include/hw/arm/nrf51_soc.h |  32 +++++-
 4 files changed, 321 insertions(+), 45 deletions(-)
 create mode 100644 include/hw/arm/microbit.h

--=20
2.18.0
