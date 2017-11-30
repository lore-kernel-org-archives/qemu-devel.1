Received: from eggs.gnu.org ([2001:4830:134:3::10]:39969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKP6N-0006tx-3w
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKP6I-0005Vo-Hk
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:42:07 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Nov 2017 07:41:56 -0600
Message-Id: <20171130134159.9697-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] macro do/while (0) cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Noticed this by chance in the tests/ directory, so I broadened
it to a grep of the entire code base.  I suspect many of the
bad macros were the victims of copy-and-paste from some other
bad location (particularly given how many bit-rotten debug
print macros were involved).

https://wiki.qemu.org/BiteSizedTasks#Bitrot_prevention is still
left for someone else, for another day.

Eric Blake (3):
  net: Drop unusual use of do { } while (0);
  mips: Tweak location of ';' in macros
  maint: Fix macros with broken 'do/while(0);' usage

 tests/acpi-utils.h         |  8 ++++----
 ui/sdl_zoom_template.h     |  8 ++++----
 audio/paaudio.c            |  4 ++--
 hw/adc/stm32f2xx_adc.c     |  2 +-
 hw/block/m25p80.c          |  2 +-
 hw/char/cadence_uart.c     |  2 +-
 hw/char/stm32f2xx_usart.c  |  2 +-
 hw/display/cg3.c           |  2 +-
 hw/display/dpcd.c          |  2 +-
 hw/display/xlnx_dp.c       |  2 +-
 hw/dma/pl330.c             |  2 +-
 hw/dma/xlnx-zynq-devcfg.c  |  2 +-
 hw/dma/xlnx_dpdma.c        |  2 +-
 hw/i2c/i2c-ddc.c           |  2 +-
 hw/misc/auxbus.c           |  2 +-
 hw/misc/macio/mac_dbdma.c  |  4 ++--
 hw/misc/mmio_interface.c   |  2 +-
 hw/misc/stm32f2xx_syscfg.c |  2 +-
 hw/misc/zynq_slcr.c        |  2 +-
 hw/net/cadence_gem.c       |  2 +-
 hw/net/pcnet.c             | 20 ++++++++++----------
 hw/ssi/mss-spi.c           |  2 +-
 hw/ssi/stm32f2xx_spi.c     |  2 +-
 hw/ssi/xilinx_spi.c        |  2 +-
 hw/ssi/xilinx_spips.c      |  2 +-
 hw/timer/a9gtimer.c        |  2 +-
 hw/timer/cadence_ttc.c     |  2 +-
 hw/timer/mss-timer.c       |  2 +-
 hw/timer/stm32f2xx_timer.c |  2 +-
 hw/tpm/tpm_passthrough.c   |  2 +-
 hw/tpm/tpm_tis.c           |  2 +-
 migration/rdma.c           |  2 +-
 target/arm/translate-a64.c |  2 +-
 target/mips/msa_helper.c   | 34 ++++++++++++++++++----------------
 target/s390x/kvm.c         |  2 +-
 tests/tcg/test-mmap.c      |  2 +-
 36 files changed, 70 insertions(+), 68 deletions(-)

-- 
2.14.3
