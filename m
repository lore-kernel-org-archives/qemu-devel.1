Received: from eggs.gnu.org ([2001:4830:134:3::10]:52525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtH-0000WL-Qg
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtE-0007BV-CZ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:23 -0500
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:43759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elRtE-0007BP-70
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:08:20 -0500
Received: by mail-qt0-x230.google.com with SMTP id d26so2207173qtk.10
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:08:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 13 Feb 2018 01:07:39 -0300
Message-Id: <20180213040809.26021-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v13 00/30] SDHCI: clean v1/2 Specs,
 UHS-I cards tuning sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Fam Zheng <famz@redhat.com>

This series includes the last versions of both series:
- SDHCI: clean v1/v2 Specs (part 2)
- SDHCI: add tuning sequence for UHS-I cards (part 3)

Since v12:
- rebased...
- bcc'ing patchew, spaming others

Since v11:
- rebased due to conflict (IMX_USDHC fd1e5c817964)
- QSDHCI uses union (Paolo)
- do not enable UNIMP logging when running qtests

Since v10:
- rebased
- add Paolo's R-b in patch 2
- rename patch 11 subject (Alistair)
- add Alistair's R-b in "UHS-I cards tuning sequence" patches

Thanks Paolo :)

Phil.

$ git backport-diff with v11
001/30:[----] [--] 'sdhci: use error_propagate(local_err) in realize()'
002/30:[0028] [FC] 'sdhci: add qtest to check the SD capabilities register'
003/30:[0016] [FC] 'sdhci: add check_capab_readonly() qtest'
004/30:[0010] [FC] 'sdhci: add a check_capab_baseclock() qtest'
005/30:[0006] [FC] 'sdhci: add a check_capab_sdma() qtest'
006/30:[0012] [FC] 'sdhci: add qtest to check the SD Spec version'
007/30:[----] [-C] 'sdhci: add a 'spec_version property' (default to v2)'
008/30:[----] [--] 'sdhci: use a numeric value for the default CAPAB register'
009/30:[----] [--] 'sdhci: simplify sdhci_get_fifolen()'
010/30:[0029] [FC] 'sdhci: check the Spec v1 capabilities correctness'
011/30:[----] [--] 'sdhci: replace DMA magic value by BLOCK_SIZE_MASK'
012/30:[----] [--] 'sdhci: Fix 64-bit ADMA2'
013/30:[0006] [FC] 'sdhci: check Spec v2 capabilities (DMA and 64-bit bus)'
014/30:[----] [--] 'hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()'
015/30:[----] [--] 'hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)'
016/30:[----] [--] 'hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet'
017/30:[----] [-C] 'sdhci: add support for v3 capabilities'
018/30:[0006] [FC] 'sdhci: rename the hostctl1 register'
019/30:[----] [--] 'sdhci: implement the Host Control 2 register (tuning sequence)'
020/30:[----] [--] 'sdbus: add trace events'
021/30:[----] [-C] 'sdhci: implement UHS-I voltage switch'
022/30:[----] [--] 'sdhci: implement CMD/DAT[] fields in the Present State register'
023/30:[----] [--] 'hw/arm/bcm2835_peripherals: implement SDHCI Spec v3'
024/30:[----] [--] 'hw/arm/bcm2835_peripherals: change maximum block size to 1kB'
025/30:[----] [--] 'hw/arm/fsl-imx6: implement SDHCI Spec. v3'
026/30:[----] [--] 'hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet'
027/30:[----] [--] 'hw/arm/xilinx_zynqmp: enable the UHS-I mode'
028/30:[----] [--] 'sdhci: check Spec v3 capabilities qtest'
029/30:[0006] [FC] 'sdhci: add a check_capab_v3() qtest'
030/30:[0008] [FC] 'sdhci: add Spec v4.2 register definitions'

Philippe Mathieu-Daudé (29):
  sdhci: use error_propagate(local_err) in realize()
  sdhci: add qtest to check the SD capabilities register
  sdhci: add check_capab_readonly() qtest
  sdhci: add a check_capab_baseclock() qtest
  sdhci: add a check_capab_sdma() qtest
  sdhci: add qtest to check the SD Spec version
  sdhci: add a 'spec_version property' (default to v2)
  sdhci: use a numeric value for the default CAPAB register
  sdhci: simplify sdhci_get_fifolen()
  sdhci: check the Spec v1 capabilities correctness
  sdhci: replace DMA magic value by BLOCK_SIZE_MASK
  sdhci: check Spec v2 capabilities (DMA and 64-bit bus)
  hw/arm/exynos4210: access the 64-bit capareg with qdev_prop_set_uint64()
  hw/arm/exynos4210: add a comment about a very similar SDHCI (Spec. v2)
  hw/arm/xilinx_zynq: fix the capabilities register to match the datasheet
  sdhci: add support for v3 capabilities
  sdhci: rename the hostctl1 register
  sdhci: implement the Host Control 2 register (tuning sequence)
  sdbus: add trace events
  sdhci: implement UHS-I voltage switch
  sdhci: implement CMD/DAT[] fields in the Present State register
  hw/arm/bcm2835_peripherals: implement SDHCI Spec v3
  hw/arm/bcm2835_peripherals: change maximum block size to 1kB
  hw/arm/fsl-imx6: implement SDHCI Spec. v3
  hw/arm/xilinx_zynqmp: fix the capabilities/spec version to match the datasheet
  hw/arm/xilinx_zynqmp: enable the UHS-I mode
  sdhci: check Spec v3 capabilities qtest
  sdhci: add a check_capab_v3() qtest
  sdhci: add Spec v4.2 register definitions

Sai Pavan Boddu (1):
  sdhci: Fix 64-bit ADMA2

 include/hw/sd/sd.h           |  20 +++
 include/hw/sd/sdhci.h        |   6 +-
 hw/sd/sdhci-internal.h       |  78 +++++++--
 hw/arm/bcm2835_peripherals.c |  23 +--
 hw/arm/exynos4210.c          |  14 +-
 hw/arm/fsl-imx6.c            |   7 +
 hw/arm/xilinx_zynq.c         |  53 +++---
 hw/arm/xlnx-zynqmp.c         |  30 ++--
 hw/sd/core.c                 |  61 ++++++-
 hw/sd/sd.c                   |  29 ++++
 hw/sd/sdhci.c                | 375 +++++++++++++++++++++++++++++++------------
 hw/sd/trace-events           |   9 ++
 tests/sdhci-test.c           | 252 +++++++++++++++++++++++++++++
 tests/Makefile.include       |   4 +
 14 files changed, 800 insertions(+), 161 deletions(-)
 create mode 100644 tests/sdhci-test.c

-- 
2.16.1
