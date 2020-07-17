Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB9AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A86120684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A86120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwX2o-0005Pg-MF
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwX24-0004pp-M4
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:32:36 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:45981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwX20-0008C5-TK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:32:36 -0400
Received: from player798.ha.ovh.net (unknown [10.108.42.73])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9F1B8170CA2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 22:32:29 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id 29049148CCAE3;
 Fri, 17 Jul 2020 20:32:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003bcc50225-b47a-4b5c-8a89-c0938f7b6666,EDCDB8C856EF0F0B0CA5B21EBB7B009702C7510A)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 00/13] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200717060258.1602319-1-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <686266f7-c19e-918c-6df4-02f470506446@kaod.org>
Date: Fri, 17 Jul 2020 22:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717060258.1602319-1-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 782781912329784099
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeejgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfeeuveeuudegtdeujefhtdevleduhfeggeekiedtkeevhfegvefgheffgefgheevnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpnhhuvhhothhonhdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.118; envelope-from=clg@kaod.org;
 helo=19.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 16:32:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 kfting@nuvoton.com, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
> I also pushed this and the previous two patchsets to my qemu fork on github.
> The branches are named npcm7xx-v[1-6].
> 
>   https://github.com/hskinnemoen/qemu
> 
> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
> an OpenBMC image built for quanta-gsj. This includes device models for:
> 
>   - Global Configuration Registers
>   - Clock Control
>   - Timers
>   - Fuses
>   - Memory Controller
>   - Flash Controller
> 
> These modules, along with the existing Cortex A9 CPU cores and built-in
> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
> the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
> two SoCs are very similar; the only difference is that NPCM730 is missing some
> peripherals that NPCM750 has, and which are not considered essential for
> datacenter use (e.g. graphics controllers). For more information, see
> 
> https://www.nuvoton.com/products/cloud-computing/ibmc/
> 
> Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
> At the end of the series, qemu can boot an OpenBMC image built for one of these
> boards with some minor modifications.
> 
> The patches in this series were developed by Google and reviewed by Nuvoton. We
> will be maintaining the machine and peripheral support together.
> 
> The data sheet for these SoCs is not generally available. Please let me know if
> more comments are needed to understand the device behavior.

I think this series is ready to go.

Patch 6 "roms: Add virtual Boot ROM for NPCM7xx SoCs" needs a few
add-ons which can come later.

Patch 13 "tests/acceptance: console boot tests for quanta-gsj" needs
an Acked-by by our test gurus. Aspeed needs the same kind of tests
if possible. It depends on the pressure that the QEMU CI will put on 
the web servers hosting the images.

I think that the rest of the comments are minor and can be fixed
as follow-ups when 5.2 is being assembled. 

Thanks,

C.


> Changes since v5:
> 
>   - Boot ROM included, as a git submodule and a binary blob, and loaded by
>     default, so the -bios option is usually not necessary anymore.
>   - Two acceptance tests added (openbmc image boot, and direct kernel boot).
>   - npcm7xx_load_kernel() moved to SoC code.
>   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
>   - Comments added clarifying available SPI flash chip selects.
>   - Error handling adjustments:
>       - Errors from CPU and GCR realization are propagated through the SoC
>         since they may be triggered by user-configurable parameters.
>       - Machine init uses error_fatal instead of error_abort for SoC
>         realization flash init. This makes error messages more helpful.
>       - Comments added to indicate whether peripherals may fail to realize.
>       - Use ERRP_GUARD() instead of Error *err when possible.
>   - Default CPU type is now set, and attempting to set it to anything else
>     will fail.
>   - Format string fixes (use HWADDR_PRIx, etc.)
>   - Simplified memory size encoding and error checking in npcm7xx_gcr.
>   - Encapsulate non-obvious pointer subtraction into helper functions in the
>     FIU and TIMER modules.
>   - Incorporate review feedback into the FIU module:
>       - Add select/deselect trace events.
>       - Use npcm7xx_fiu_{de,}select() consistently.
>       - Use extract/deposit in more places for consistency.
>       - Use -Wimplicit-fallthrough compatible fallthrough comments.
>       - Use qdev_init_gpio_out_named instead of sysbus_init_irq for chip
>         selects.
>   - Incorporate review feedback into the TIMER module:
>       - Assert that we never pause a timer that has already expired, instead of
>         trying to handle it. This should be safe since QEMU_CLOCK_VIRTUAL is
>         stopped while this code is running.
>       - Simplify the switch blocks in the read and write handlers.
> 
> I made a change to error out if a flash drive was not specified, but reverted
> it because it caused make check to fail (qom-test). When specifying a NULL
> block device, the m25p flash device initializes its in-memory storage with 0xff
> and doesn't attempt to write anything back. This seems correct to me.
> 
> Changes since v4:
> 
>   - OTP cleanups suggested by Philippe Mathieu-Daudé.
>       - Added fuse array definitions based on public Nuvoton bootblock code.
>       - Moved class structure to .c file since it's only used internally.
>       - Readability improvements.
>   - Split the first patch and folded parts of it into three other patches so
>     that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx machine
>     support is added.
>   - DRAM init moved to machine init code.
>   - Consistently use lower-case hex literals.
>   - Switched to fine-grained unimplemented devices, based on public bootblock
>     source code. Added a tiny SRAM that got left out previously.
>   - Simplified error handling in npcm7xx_realize() since the board code will
>     abort anyway, and SoCs are not hot-pluggable.
> 
> Changes since v3:
> 
>   - License headers are now GPL v2-or-later throughout.
>   - Added vmstate throughout (except the memory controller, which doesn't
>     really have any state worth saving). Successfully booted a gsj image
>     with two stop/savevm/quit/loadvm cycles along the way.
>       - JFFS2 really doesn't like it if I let qemu keep running after savevm,
>         and then jump back in time with loadvm. I assume this is expected.
>   - Fixed an error API violation in npcm7xx_realize, removed pointless error
>     check after object_property_set_link().
>   - Switched the OTP device to use an embedded array instead of a g_malloc0'd
>     one because I couldn't figure out how to set up vmstate for the latter.
> 
> Changes since v2:
> 
>   - Simplified the MAINTAINERS entry.
>   - Added link to OpenPOWER jenkins for gsj BMC images.
>   - Reverted the smpboot change, back to byte swapping.
>   - Adapted to upstream API changes:
>       - sysbus_init_child_obj -> object_initialize_child
>       - object_property_set_bool -> qdev_realize / sysbus_realize
>       - ssi_create_slave_no_init -> qdev_new
>       - qdev_init_nofail -> qdev_realize_and_unref
>       - ssi_auto_connect_slaves removed
>   - Moved Boot ROM loading from soc to machine init.
>   - Plumbed power-on-straps property from GCR to the machine init code so it
>     can be properly initialized. Turns out npcm750 memory init doesn't work
>     without this. npcm730 is fine either way, though I'm not sure why.
>   - Reworked the flash init code so it looks more like aspeed (i.e. the flash
>     device gets added even if there's no drive).
> 
> Changes since v1 (requested by reviewers):
> 
>   - Clarify the source of CLK reset values.
>   - Made smpboot a constant byte array, eliinated byte swapping.
>   - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMCPUs.
>   - Clarify why EL3 is disabled.
>   - Introduce NPCM7XX_NUM_IRQ constant.
>   - Set the number of CPUs according to SoC variant, and disallow command line
>     overrides (i.e. you can no longer override the number of CPUs with the -smp
>     parameter). This is trying to follow the spirit of
>     https://patchwork.kernel.org/patch/11595407/.
>   - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
>   - Machine documentation added (new patch).
> 
> Changes since v1 to support flash booting:
> 
>   - GCR reset value changes to get past memory initialization when booting
>     from flash (patches 2 and 5):
>       - INTCR2 now indicates that the DDR controller is initialized.
>       - INTCR3 is initialized according to DDR memory size. A realize()
> 	method was implemented to achieve this.
>   - Refactor the machine initialization a bit to make it easier to drop in
>     machine-specific flash initialization (patch 6).
>   - Extend the series with additional patches to enable booting from flash:
>       - Boot ROM (through the -bios option).
>       - OTP (fuse) controller.
>       - Memory Controller stub (just enough to skip memory training).
>       - Flash controller.
>       - Board-specific flash initialization.
> 
> Thanks for reviewing,
> 
> Havard
> 
> Havard Skinnemoen (13):
>   hw/misc: Add NPCM7xx System Global Control Registers device model
>   hw/misc: Add NPCM7xx Clock Controller device model
>   hw/timer: Add NPCM7xx Timer device model
>   hw/arm: Add NPCM730 and NPCM750 SoC models
>   hw/arm: Add two NPCM7xx-based machines
>   roms: Add virtual Boot ROM for NPCM7xx SoCs
>   hw/arm: Load -bios image as a boot ROM for npcm7xx
>   hw/nvram: NPCM7xx OTP device model
>   hw/mem: Stubbed out NPCM7xx Memory Controller model
>   hw/ssi: NPCM7xx Flash Interface Unit device model
>   hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
>   docs/system: Add Nuvoton machine documentation
>   tests/acceptance: console boot tests for quanta-gsj
> 
>  docs/system/arm/nuvoton.rst            |  90 +++++
>  docs/system/target-arm.rst             |   1 +
>  Makefile                               |   1 +
>  default-configs/arm-softmmu.mak        |   1 +
>  include/hw/arm/npcm7xx.h               | 111 +++++
>  include/hw/mem/npcm7xx_mc.h            |  36 ++
>  include/hw/misc/npcm7xx_clk.h          |  72 ++++
>  include/hw/misc/npcm7xx_gcr.h          |  76 ++++
>  include/hw/nvram/npcm7xx_otp.h         |  88 ++++
>  include/hw/ssi/npcm7xx_fiu.h           | 100 +++++
>  include/hw/timer/npcm7xx_timer.h       |  96 +++++
>  hw/arm/npcm7xx.c                       | 500 +++++++++++++++++++++++
>  hw/arm/npcm7xx_boards.c                | 195 +++++++++
>  hw/mem/npcm7xx_mc.c                    |  84 ++++
>  hw/misc/npcm7xx_clk.c                  | 234 +++++++++++
>  hw/misc/npcm7xx_gcr.c                  | 227 +++++++++++
>  hw/nvram/npcm7xx_otp.c                 | 424 +++++++++++++++++++
>  hw/ssi/npcm7xx_fiu.c                   | 539 +++++++++++++++++++++++++
>  hw/timer/npcm7xx_timer.c               | 489 ++++++++++++++++++++++
>  .gitmodules                            |   3 +
>  MAINTAINERS                            |   8 +
>  hw/arm/Kconfig                         |   9 +
>  hw/arm/Makefile.objs                   |   1 +
>  hw/mem/Makefile.objs                   |   1 +
>  hw/misc/Makefile.objs                  |   2 +
>  hw/misc/trace-events                   |   8 +
>  hw/nvram/Makefile.objs                 |   1 +
>  hw/ssi/Makefile.objs                   |   1 +
>  hw/ssi/trace-events                    |  11 +
>  hw/timer/Makefile.objs                 |   1 +
>  hw/timer/trace-events                  |   5 +
>  pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
>  roms/Makefile                          |   7 +
>  roms/vbootrom                          |   1 +
>  tests/acceptance/boot_linux_console.py |  65 +++
>  35 files changed, 3488 insertions(+)
>  create mode 100644 docs/system/arm/nuvoton.rst
>  create mode 100644 include/hw/arm/npcm7xx.h
>  create mode 100644 include/hw/mem/npcm7xx_mc.h
>  create mode 100644 include/hw/misc/npcm7xx_clk.h
>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
>  create mode 100644 include/hw/timer/npcm7xx_timer.h
>  create mode 100644 hw/arm/npcm7xx.c
>  create mode 100644 hw/arm/npcm7xx_boards.c
>  create mode 100644 hw/mem/npcm7xx_mc.c
>  create mode 100644 hw/misc/npcm7xx_clk.c
>  create mode 100644 hw/misc/npcm7xx_gcr.c
>  create mode 100644 hw/nvram/npcm7xx_otp.c
>  create mode 100644 hw/ssi/npcm7xx_fiu.c
>  create mode 100644 hw/timer/npcm7xx_timer.c
>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
>  create mode 160000 roms/vbootrom
> 


