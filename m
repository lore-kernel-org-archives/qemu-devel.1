Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BDBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887E122CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887E122CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1EzV-0005i7-9U
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EgR-0002CE-NZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EgQ-0002xJ-43
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:53:11 -0400
Received: from nsstlmta33p.bpe.bigpond.com ([203.38.21.33]:48392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1EgP-0002vo-H0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:53:10 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep33p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823185303.IVQX15166.nsstlfep33p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:53:03 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3581440CDC404D; Sat, 24 Aug 2019 04:53:02 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:56:21 +1000
Message-Id: <cover.1566467963.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.33
Subject: [Qemu-devel] [RFC PATCH 00/17] Declare device little or big endian
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is an attempt to re-declare devices with DEVICE_NATIVE_ENDIAN as
DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN.

This clean up was split out from an earlier series which collapsed byte swaps
along the I/O path.

On Wed, 7 Aug 2019 at 12:42, Paolo Bonzini wrote:
> On 07/08/19 10:31, tony.nguyen@bt wrote:
>>
>> Device realizing code with MemorRegionOps endianness as
>> DEVICE_NATIVE_ENDIAN is not common code.
>> 
>> Corrected devices were identified by making the declaration of
>> DEVICE_NATIVE_ENDIAN conditional upon NEED_CPU_H and then listing
>> what failed to compile.
>
> The general approach makes sense.  However, most of these should not be
> DEVICE_NATIVE_ENDIAN.  I can help with some of them.

An RFC as most devices I have never heard of... a collective effort is needed =)

On Fri, 16 Aug 2019 at 13:02, Peter Maydell wrote:
> OTOH it's worth noting that it's quite likely that most of
> the implementations of these DEVICE_NATIVE_ENDIAN devices
> picked it in an equally naive way, by just copying some other
> device's code...

I am starting off with the following *naive* approach.

For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
respectively.

This *naive* deduction may result in genuinely native endian devices
being incorrectly declared as little or big endian, but should not
introduce regressions for current targets.

Please help spot devices which are genuinely native endian.

Thanks!

Tony Nguyen (17):
  hw/audio: Declare device little or big endian
  hw/block: Declare device little or big endian
  hw/char: Declare device little or big endian
  hw/display: Declare device little or big endian
  hw/dma: Declare device little or big endian
  hw/gpio: Declare device little or big endian
  hw/i2c: Declare device little or big endian
  hw/input: Declare device little or big endian
  hw/intc: Declare device little or big endian
  hw/isa: Declare device little or big endian
  hw/misc: Declare device little or big endian
  hw/net: Declare device little or big endian
  hw/pci-host: Declare device little or big endian
  hw/sd: Declare device little or big endian
  hw/ssi: Declare device little or big endian
  hw/timer: Declare device little or big endian
  build: Correct non-common common-obj-* to obj-*

 hw/audio/Makefile.objs      |  3 ++-
 hw/audio/cs4231.c           |  2 +-
 hw/audio/marvell_88w8618.c  |  2 +-
 hw/audio/milkymist-ac97.c   |  2 +-
 hw/audio/pl041.c            |  2 +-
 hw/block/Makefile.objs      |  6 +++---
 hw/block/onenand.c          |  2 +-
 hw/char/Makefile.objs       |  4 ++--
 hw/char/cadence_uart.c      |  2 +-
 hw/char/escc.c              |  2 +-
 hw/char/etraxfs_ser.c       |  2 +-
 hw/char/grlib_apbuart.c     |  2 +-
 hw/char/imx_serial.c        |  2 +-
 hw/char/lm32_uart.c         |  2 +-
 hw/char/milkymist-uart.c    |  2 +-
 hw/char/pl011.c             |  2 +-
 hw/core/Makefile.objs       |  2 +-
 hw/display/Makefile.objs    |  6 +++---
 hw/display/pl110.c          |  2 +-
 hw/display/tc6393xb.c       |  2 +-
 hw/dma/Makefile.objs        |  6 +++---
 hw/dma/bcm2835_dma.c        |  4 ++--
 hw/dma/etraxfs_dma.c        |  2 +-
 hw/dma/pl080.c              |  2 +-
 hw/dma/pl330.c              |  2 +-
 hw/dma/puv3_dma.c           |  2 +-
 hw/dma/sparc32_dma.c        |  2 +-
 hw/gpio/Makefile.objs       |  2 +-
 hw/gpio/pl061.c             |  2 +-
 hw/gpio/zaurus.c            |  2 +-
 hw/i2c/Makefile.objs        |  2 +-
 hw/i2c/imx_i2c.c            |  2 +-
 hw/i2c/mpc_i2c.c            |  2 +-
 hw/i2c/versatile_i2c.c      |  2 +-
 hw/input/Makefile.objs      |  2 +-
 hw/input/pl050.c            |  2 +-
 hw/intc/Makefile.objs       |  6 +++---
 hw/intc/arm_gic.c           | 12 ++++++------
 hw/intc/arm_gicv3.c         |  4 ++--
 hw/intc/etraxfs_pic.c       |  2 +-
 hw/intc/imx_avic.c          |  2 +-
 hw/intc/imx_gpcv2.c         |  2 +-
 hw/intc/pl190.c             |  2 +-
 hw/intc/puv3_intc.c         |  2 +-
 hw/ipack/Makefile.objs      |  2 +-
 hw/isa/vt82c686.c           |  2 +-
 hw/misc/Makefile.objs       | 10 +++++-----
 hw/misc/a9scu.c             |  2 +-
 hw/misc/applesmc.c          |  6 +++---
 hw/misc/arm11scu.c          |  2 +-
 hw/misc/arm_l2x0.c          |  2 +-
 hw/misc/puv3_pm.c           |  2 +-
 hw/net/Makefile.objs        |  2 +-
 hw/net/allwinner_emac.c     |  2 +-
 hw/net/imx_fec.c            |  2 +-
 hw/net/lan9118.c            |  4 ++--
 hw/net/lance.c              |  2 +-
 hw/net/smc91c111.c          |  2 +-
 hw/net/stellaris_enet.c     |  2 +-
 hw/pci-host/Makefile.objs   |  2 +-
 hw/pci-host/q35.c           |  2 +-
 hw/pci-host/versatile.c     |  4 ++--
 hw/scsi/Makefile.objs       |  2 +-
 hw/sd/pl181.c               |  2 +-
 hw/ssi/Makefile.objs        |  2 +-
 hw/ssi/mss-spi.c            |  2 +-
 hw/ssi/pl022.c              |  2 +-
 hw/ssi/stm32f2xx_spi.c      |  2 +-
 hw/ssi/xilinx_spips.c       |  2 +-
 hw/timer/Makefile.objs      |  6 +++---
 hw/timer/a9gtimer.c         |  4 ++--
 hw/timer/arm_mptimer.c      |  4 ++--
 hw/timer/arm_timer.c        |  4 ++--
 hw/timer/armv7m_systick.c   |  2 +-
 hw/timer/aspeed_rtc.c       |  2 +-
 hw/timer/cadence_ttc.c      |  2 +-
 hw/timer/grlib_gptimer.c    |  2 +-
 hw/timer/hpet.c             |  2 +-
 hw/timer/imx_epit.c         |  2 +-
 hw/timer/imx_gpt.c          |  2 +-
 hw/timer/lm32_timer.c       |  2 +-
 hw/timer/milkymist-sysctl.c |  2 +-
 hw/timer/mss-timer.c        |  2 +-
 hw/timer/pl031.c            |  2 +-
 hw/timer/stm32f2xx_timer.c  |  2 +-
 hw/timer/sun4v-rtc.c        |  2 +-
 hw/virtio/Makefile.objs     |  2 +-
 87 files changed, 117 insertions(+), 116 deletions(-)

-- 
2.23.0


