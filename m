Received: from eggs.gnu.org ([2001:4830:134:3::10]:39544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabk-0003pY-FM
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabe-0002mz-PF
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabe-0002mA-IP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabc-0001Mv-Nv
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:08 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:51 +0100
Message-Id: <20180515140707.15957-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/16] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit ad1b4ec39caa5b3f17cbd8160283a03a3dcfe2ae:

  Merge remote-tracking branch 'remotes/kraxel/tags/input-20180515-pull-request' into staging (2018-05-15 12:50:06 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180515

for you to fetch changes up to ae7651804748c6b479d5ae09aeac4edb9c44f76e:

  tcg: Optionally log FPU state in TCG -d cpu logging (2018-05-15 14:58:44 +0100)

----------------------------------------------------------------
target-arm queue:
 * Fix coverity nit in int_to_float code
 * Don't set Invalid for float-to-int(MAXINT)
 * Fix fp_status_f16 tininess before rounding
 * Add various missing insns from the v8.2-FP16 extension
 * Fix sqrt_f16 exception raising
 * sdcard: Correct CRC16 offset in sd_function_switch()
 * tcg: Optionally log FPU state in TCG -d cpu logging

----------------------------------------------------------------
Alex Bennée (5):
      fpu/softfloat: int_to_float ensure r fully initialised
      target/arm: Implement FCMP for fp16
      target/arm: Implement FCSEL for fp16
      target/arm: Implement FMOV (immediate) for fp16
      target/arm: Fix sqrt_f16 exception raising

Peter Maydell (3):
      fpu/softfloat: Don't set Invalid for float-to-int(MAXINT)
      target/arm: Fix fp_status_f16 tininess before rounding
      tcg: Optionally log FPU state in TCG -d cpu logging

Philippe Mathieu-Daudé (1):
      sdcard: Correct CRC16 offset in sd_function_switch()

Richard Henderson (7):
      target/arm: Implement FMOV (general) for fp16
      target/arm: Early exit after unallocated_encoding in disas_fp_int_conv
      target/arm: Implement FCVT (scalar, integer) for fp16
      target/arm: Implement FCVT (scalar, fixed-point) for fp16
      target/arm: Introduce and use read_fp_hreg
      target/arm: Implement FP data-processing (2 source) for fp16
      target/arm: Implement FP data-processing (3 source) for fp16

 include/qemu/log.h         |   1 +
 target/arm/helper-a64.h    |   2 +
 target/arm/helper.h        |   6 +
 accel/tcg/cpu-exec.c       |   9 +-
 fpu/softfloat.c            |   6 +-
 hw/sd/sd.c                 |   2 +-
 target/arm/cpu.c           |   2 +
 target/arm/helper-a64.c    |  10 ++
 target/arm/helper.c        |  38 +++-
 target/arm/translate-a64.c | 421 ++++++++++++++++++++++++++++++++++++++-------
 util/log.c                 |   2 +
 11 files changed, 428 insertions(+), 71 deletions(-)
