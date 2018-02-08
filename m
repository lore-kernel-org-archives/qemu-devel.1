Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ejf7D-0001sV-Q5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ejf7A-0000PJ-Nz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:51:23 -0500
Sender: Pekka Enberg <penberg@gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Date: Thu,  8 Feb 2018 07:50:36 +0200
Message-Id: <20180208055039.24666-1-penberg@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] Raspberry Pi 3 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Pekka Enberg <penberg@iki.fi>

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

  git@github.com:penberg/qemu.git raspi3/v1

Pekka Enberg (3):
  bcm2836: Make CPU type configurable
  raspi: Raspberry Pi 3 support
  raspi: Add "raspi3" machine type

 hw/arm/bcm2836.c         | 17 ++++++++-------
 hw/arm/raspi.c           | 55 +++++++++++++++++++++++++++++++++++++++---------
 include/hw/arm/bcm2836.h |  1 +
 3 files changed, 55 insertions(+), 18 deletions(-)

-- 
2.14.3
