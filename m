Received: from eggs.gnu.org ([209.51.188.92]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXj-0008N6-36
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXf-0007ME-5N
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXV-0007Fv-Kh
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:57:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id h22so7303019wmb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:57:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:57:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:18 +0000
Message-Id: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm queue -- mostly the first slice of my Musca patches.

thanks
-- PMM

The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190221

for you to fetch changes up to 3733f80308d2a7f23f5e39b039e0547aba6c07f1:

  hw/arm/armsse: Make 0x5... alias region work for per-CPU devices (2019-02-21 18:17:48 +0000)

----------------------------------------------------------------
target-arm queue:
 * Model the Arm "Musca" development boards: "musca-a" and "musca-b1"
 * Implement the ARMv8.3-JSConv extension
 * v8M MPU should use background region as default, not always
 * Stop unintentional sign extension in pmu_init

----------------------------------------------------------------
Aaron Lindsay OS (1):
      target/arm: Stop unintentional sign extension in pmu_init

Peter Maydell (16):
      hw/arm/armsse: Fix memory leak in error-exit path
      target/arm: v8M MPU should use background region as default, not always
      hw/misc/tz-ppc: Support having unused ports in the middle of the range
      hw/timer/pl031: Allow use as an embedded-struct device
      hw/timer/pl031: Convert to using trace events
      hw/char/pl011: Allow use as an embedded-struct device
      hw/char/pl011: Support all interrupt lines
      hw/char/pl011: Use '0x' prefix when logging hex numbers
      hw/arm/armsse: Document SRAM_ADDR_WIDTH property in header comment
      hw/arm/armsse: Allow boards to specify init-svtor
      hw/arm/musca.c: Implement models of the Musca-A and -B1 boards
      hw/arm/musca: Add PPCs
      hw/arm/musca: Add MPCs
      hw/arm/musca: Wire up PL031 RTC
      hw/arm/musca: Wire up PL011 UARTs
      hw/arm/armsse: Make 0x5... alias region work for per-CPU devices

Richard Henderson (4):
      target/arm: Restructure disas_fp_int_conv
      target/arm: Split out vfp_helper.c
      target/arm: Rearrange Floating-point data-processing (2 regs)
      target/arm: Implement ARMv8.3-JSConv

 hw/arm/Makefile.objs            |    1 +
 target/arm/Makefile.objs        |    2 +-
 include/hw/arm/armsse.h         |    7 +-
 include/hw/char/pl011.h         |   34 ++
 include/hw/misc/tz-ppc.h        |    8 +-
 include/hw/timer/pl031.h        |   44 ++
 target/arm/cpu.h                |   10 +
 target/arm/helper.h             |    3 +
 hw/arm/armsse.c                 |   44 +-
 hw/arm/musca.c                  |  669 ++++++++++++++++++++++
 hw/char/pl011.c                 |   81 +--
 hw/misc/tz-ppc.c                |   32 ++
 hw/timer/pl031.c                |   80 ++-
 target/arm/cpu.c                |    1 +
 target/arm/cpu64.c              |    2 +
 target/arm/helper.c             | 1072 +----------------------------------
 target/arm/translate-a64.c      |  120 ++--
 target/arm/translate.c          |  237 ++++----
 target/arm/vfp_helper.c         | 1176 +++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                     |    7 +
 default-configs/arm-softmmu.mak |    1 +
 hw/timer/trace-events           |    6 +
 22 files changed, 2307 insertions(+), 1330 deletions(-)
 create mode 100644 include/hw/timer/pl031.h
 create mode 100644 hw/arm/musca.c
 create mode 100644 target/arm/vfp_helper.c
