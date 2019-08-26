Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0DC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755B920679
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755B920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Fs8-0005di-Us
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Fp1-0003vE-U9
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Foz-0007zG-QL
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:15 -0400
Received: from nsstlmta07p.bpe.bigpond.com ([203.38.21.7]:48785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i2Foz-0007uk-6a
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:13 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep07p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141805.CNBS4111.nsstlfep07p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:18:05 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D117510588646; Tue, 27 Aug 2019 00:18:05 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:26 +1000
Message-Id: <cover.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.7
Subject: [Qemu-devel]  [PATCH 00/19] Declare device little or big endian
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

On Fri, 16 Aug 2019 at 13:02, Peter Maydell wrote:
> OTOH it's worth noting that it's quite likely that most of
> the implementations of these DEVICE_NATIVE_ENDIAN devices
> picked it in an equally naive way, by just copying some other
> device's code...

Approach this in two steps.

1. Naively. For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.

2. Manually. Inspect with heuristics (thanks Paolo):
- if not used, re-declare as DEVICE_HOST_ENDIAN.
- if max/min size=1, re-declare as DEVICE_HOST_ENDIAN.
- if just a bit bucket, re-declare as DEVICE_HOST_ENDIAN
- if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
- if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
- if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.

Likely still not %100 correct, but I think more than before.

Since RFC:
- Applied Paolo's heuristics

Tony Nguyen (19):
  hw/audio: Declare device little or big endian
  hw/block: Declare device little or big endian
  hw/char: Declare device little or big endian
  hw/core: Declare device little or big endian
  hw/display: Declare device little or big endian
  hw/dma: Declare device little or big endian
  hw/gpio: Declare device little or big endian
  hw/i2c: Declare device little or big endian
  hw/input: Declare device little or big endian
  hw/intc: Declare device little or big endian
  hw/ipack: Declare device little or big endian
  hw/isa: Declare device little or big endian
  hw/misc: Declare device little or big endian
  hw/net: Declare device little or big endian
  hw/pci-host: Declare device little or big endian
  hw/sd: Declare device little or big endian
  hw/ssi: Declare device little or big endian
  hw/timer: Declare device little or big endian
  build: Correct non-common common-obj-* to obj-*

 hw/audio/cs4231.c              |  2 +-
 hw/audio/intel-hda.c           |  2 +-
 hw/audio/marvell_88w8618.c     |  2 +-
 hw/audio/milkymist-ac97.c      |  2 +-
 hw/audio/pl041.c               |  2 +-
 hw/block/Makefile.objs         |  4 ++--
 hw/block/fdc.c                 |  4 ++--
 hw/block/onenand.c             |  2 +-
 hw/char/Makefile.objs          |  4 ++--
 hw/char/cadence_uart.c         |  2 +-
 hw/char/escc.c                 |  2 +-
 hw/char/etraxfs_ser.c          |  2 +-
 hw/char/grlib_apbuart.c        |  2 +-
 hw/char/imx_serial.c           |  2 +-
 hw/char/lm32_uart.c            |  2 +-
 hw/char/milkymist-uart.c       |  2 +-
 hw/char/pl011.c                |  2 +-
 hw/core/empty_slot.c           |  2 +-
 hw/display/Makefile.objs       |  2 +-
 hw/display/exynos4210_fimd.c   |  2 +-
 hw/display/jazz_led.c          |  2 +-
 hw/display/pl110.c             |  2 +-
 hw/display/tc6393xb.c          |  2 +-
 hw/dma/Makefile.objs           |  4 ++--
 hw/dma/bcm2835_dma.c           |  4 ++--
 hw/dma/etraxfs_dma.c           | 14 +++++++-------
 hw/dma/i8257.c                 |  4 ++--
 hw/dma/pl080.c                 |  2 +-
 hw/dma/pl330.c                 |  2 +-
 hw/dma/puv3_dma.c              |  2 +-
 hw/dma/sparc32_dma.c           |  2 +-
 hw/gpio/pl061.c                |  2 +-
 hw/gpio/puv3_gpio.c            |  2 +-
 hw/gpio/zaurus.c               |  2 +-
 hw/i2c/exynos4210_i2c.c        |  2 +-
 hw/i2c/imx_i2c.c               |  2 +-
 hw/i2c/mpc_i2c.c               |  2 +-
 hw/i2c/versatile_i2c.c         |  2 +-
 hw/input/Makefile.objs         |  2 +-
 hw/input/pl050.c               |  2 +-
 hw/intc/Makefile.objs          |  2 +-
 hw/intc/arm_gic.c              | 12 ++++++------
 hw/intc/arm_gicv3.c            |  4 ++--
 hw/intc/arm_gicv3_its_common.c |  2 +-
 hw/intc/etraxfs_pic.c          |  2 +-
 hw/intc/imx_avic.c             |  2 +-
 hw/intc/imx_gpcv2.c            |  2 +-
 hw/intc/pl190.c                |  2 +-
 hw/intc/puv3_intc.c            |  2 +-
 hw/intc/slavio_intctl.c        |  4 ++--
 hw/ipack/tpci200.c             | 10 +++++-----
 hw/isa/vt82c686.c              |  2 +-
 hw/misc/a9scu.c                |  2 +-
 hw/misc/applesmc.c             |  6 +++---
 hw/misc/arm11scu.c             |  2 +-
 hw/misc/arm_integrator_debug.c |  2 +-
 hw/misc/arm_l2x0.c             |  2 +-
 hw/misc/edu.c                  |  2 +-
 hw/misc/mos6522.c              |  2 +-
 hw/misc/puv3_pm.c              |  2 +-
 hw/misc/unimp.c                |  2 +-
 hw/net/Makefile.objs           |  2 +-
 hw/net/allwinner_emac.c        |  2 +-
 hw/net/imx_fec.c               |  2 +-
 hw/net/lan9118.c               |  4 ++--
 hw/net/lance.c                 |  2 +-
 hw/net/smc91c111.c             |  2 +-
 hw/net/stellaris_enet.c        |  2 +-
 hw/pci-host/bonito.c           |  2 +-
 hw/pci-host/q35.c              |  2 +-
 hw/pci-host/versatile.c        |  4 ++--
 hw/scsi/Makefile.objs          |  2 +-
 hw/sd/pl181.c                  |  2 +-
 hw/ssi/Makefile.objs           |  2 +-
 hw/ssi/mss-spi.c               |  2 +-
 hw/ssi/pl022.c                 |  2 +-
 hw/ssi/stm32f2xx_spi.c         |  2 +-
 hw/ssi/xilinx_spips.c          |  2 +-
 hw/timer/Makefile.objs         |  2 +-
 hw/timer/a9gtimer.c            |  4 ++--
 hw/timer/arm_mptimer.c         |  4 ++--
 hw/timer/arm_timer.c           |  4 ++--
 hw/timer/armv7m_systick.c      |  2 +-
 hw/timer/aspeed_rtc.c          |  2 +-
 hw/timer/cadence_ttc.c         |  2 +-
 hw/timer/grlib_gptimer.c       |  2 +-
 hw/timer/hpet.c                |  2 +-
 hw/timer/imx_epit.c            |  2 +-
 hw/timer/imx_gpt.c             |  2 +-
 hw/timer/lm32_timer.c          |  2 +-
 hw/timer/milkymist-sysctl.c    |  2 +-
 hw/timer/mss-timer.c           |  2 +-
 hw/timer/pl031.c               |  2 +-
 hw/timer/puv3_ost.c            |  2 +-
 hw/timer/slavio_timer.c        |  2 +-
 hw/timer/stm32f2xx_timer.c     |  2 +-
 hw/timer/sun4v-rtc.c           |  2 +-
 hw/virtio/Makefile.objs        |  2 +-
 98 files changed, 128 insertions(+), 128 deletions(-)

-- 
2.23.0


