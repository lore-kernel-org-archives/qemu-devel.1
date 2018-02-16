Received: from eggs.gnu.org ([2001:4830:134:3::10]:46706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema2E-0003QL-D7
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema29-0007jI-M6
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:18 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <penberg@gmail.com>) id 1ema29-0007i7-Do
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:13 -0500
Received: by mail-lf0-x241.google.com with SMTP id t79so2762316lfe.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 23:02:13 -0800 (PST)
Sender: Pekka Enberg <penberg@gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Date: Fri, 16 Feb 2018 09:01:58 +0200
Message-Id: <20180216070201.4271-1-penberg@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] Raspberry Pi 3 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pekka Enberg <penberg@iki.fi>

This patch series adds support for Raspberry Pi 3 as a new machine model
"raspi3", which is an extension of the "raspi2" model with the following
differences:

  - Default CPU type is "cortex-a53"
  - Firmware is at address 0x80000
  - Board ID is 0xc44 and board revision is 0xa02082

The patches were written by me but I used Zoltán Baldaszti's previous
work as a reference (with permission from the author):
    
  https://github.com/bztsrc/qemu-raspi3

Also available from:

  git@github.com:penberg/qemu.git raspi3/v2

Changes from v1 to v2:

- Wrap Raspberry Pi 3 machine definition with TARGET_AARCH64 (Peter
  Maydell)

Pekka Enberg (3):
  bcm2836: Make CPU type configurable
  raspi: Raspberry Pi 3 support
  raspi: Add "raspi3" machine type

 hw/arm/bcm2836.c         | 17 ++++++++-------
 hw/arm/raspi.c           | 57 +++++++++++++++++++++++++++++++++++++++---------
 include/hw/arm/bcm2836.h |  1 +
 3 files changed, 57 insertions(+), 18 deletions(-)

-- 
2.14.3
