Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9DCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0AB2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0AB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNirE-0007qn-6l
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57562)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iNinG-0006P2-HK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iNinE-0008TN-Ic
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:29:10 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:56620
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iNinE-0008T3-CL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:29:08 -0400
Received: from host86-185-106-131.range86-185.btcentralplus.com
 ([86.185.106.131] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iNing-0000aw-Rt; Thu, 24 Oct 2019 20:29:37 +0100
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191024162724.31675-1-peter.maydell@linaro.org>
 <1bf876f8-b868-ac37-e7ef-083fdf2544a9@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <f03025d5-e704-27f8-b941-39f4cc7cd2c4@ilande.co.uk>
Date: Thu, 24 Oct 2019 20:29:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1bf876f8-b868-ac37-e7ef-083fdf2544a9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.185.106.131
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 00/51] target-arm queue
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2019 19:18, Philippe Mathieu-Daudé wrote:

> On 10/24/19 6:26 PM, Peter Maydell wrote:
>> Probably the last arm pullreq before softfreeze...
>>
>> The following changes since commit 58560ad254fbda71d4daa6622d71683190070ee2:
>>
>>    Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-20191024' into
>> staging (2019-10-24 16:22:58 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191024
>>
>> for you to fetch changes up to a01a4a3e85ae8f6fe21adbedc80f7013faabdcf4:
>>
>>    hw/arm/highbank: Use AddressSpace when using write_secondary_boot() (2019-10-24
>> 17:16:30 +0100)
>>
>> ----------------------------------------------------------------
>> target-arm queue:
>>   * raspi boards: some cleanup
>>   * raspi: implement the bcm2835 system timer device
>>   * raspi: implement a dummy thermal sensor
>>   * KVM: support providing SVE to the guest
>>   * misc devices: switch to ptimer transaction API
>>   * cache TB flag state to improve performance of cpu_get_tb_cpu_state
>>   * aspeed: Add an AST2600 eval board
>>
>> ----------------------------------------------------------------
>> Andrew Jones (9):
>>        target/arm/monitor: Introduce qmp_query_cpu_model_expansion
>>        tests: arm: Introduce cpu feature tests
>>        target/arm: Allow SVE to be disabled via a CPU property
>>        target/arm/cpu64: max cpu: Introduce sve<N> properties
>>        target/arm/kvm64: Add kvm_arch_get/put_sve
>>        target/arm/kvm64: max cpu: Enable SVE when available
>>        target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init features
>>        target/arm/cpu64: max cpu: Support sve properties with KVM
>>        target/arm/kvm: host cpu: Add support for sve<N> properties
>>
>> Cédric Le Goater (2):
>>        hw/gpio: Fix property accessors of the AST2600 GPIO 1.8V model
>>        aspeed: Add an AST2600 eval board
>>
>> Peter Maydell (8):
>>        hw/net/fsl_etsec/etsec.c: Switch to transaction-based ptimer API
>>        hw/timer/xilinx_timer.c: Switch to transaction-based ptimer API
>>        hw/dma/xilinx_axidma.c: Switch to transaction-based ptimer API
>>        hw/timer/slavio_timer: Remove useless check for NULL t->timer
>>        hw/timer/slavio_timer.c: Switch to transaction-based ptimer API
>>        hw/timer/grlib_gptimer.c: Switch to transaction-based ptimer API
>>        hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
>>        hw/watchdog/milkymist-sysctl.c: Switch to transaction-based ptimer API
>>
>> Philippe Mathieu-Daudé (8):
>>        hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
>>        hw/arm/bcm2835_peripherals: Use the thermal sensor block
>>        hw/timer/bcm2835: Add the BCM2835 SYS_timer
>>        hw/arm/bcm2835_peripherals: Use the SYS_timer
>>        hw/arm/bcm2836: Make the SoC code modular
>>        hw/arm/bcm2836: Rename cpus[] as cpu[].core
>>        hw/arm/raspi: Use AddressSpace when using arm_boot::write_secondary_boot
>>        hw/arm/highbank: Use AddressSpace when using write_secondary_boot()
>>
>> Richard Henderson (24):
>>        target/arm: Split out rebuild_hflags_common
>>        target/arm: Split out rebuild_hflags_a64
>>        target/arm: Split out rebuild_hflags_common_32
>>        target/arm: Split arm_cpu_data_is_big_endian
>>        target/arm: Split out rebuild_hflags_m32
>>        target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
>>        target/arm: Split out rebuild_hflags_a32
>>        target/arm: Split out rebuild_hflags_aprofile
>>        target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in cpu_get_tb_cpu_state
>>        target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
>>        target/arm: Hoist computation of TBFLAG_A32.VFPEN
>>        target/arm: Add arm_rebuild_hflags
>>        target/arm: Split out arm_mmu_idx_el
>>        target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
>>        target/arm: Add HELPER(rebuild_hflags_{a32, a64, m32})
>>        target/arm: Rebuild hflags at EL changes
>>        target/arm: Rebuild hflags at MSR writes
>>        target/arm: Rebuild hflags at CPSR writes
>>        target/arm: Rebuild hflags at Xscale SCTLR writes
>>        target/arm: Rebuild hflags for M-profile
>>        target/arm: Rebuild hflags for M-profile NVIC
>>        linux-user/aarch64: Rebuild hflags for TARGET_WORDS_BIGENDIAN
>>        linux-user/arm: Rebuild hflags for TARGET_WORDS_BIGENDIAN
>>        target/arm: Rely on hflags correct in cpu_get_tb_cpu_state
>>
>>   hw/misc/Makefile.objs                |   1 +
>>   hw/timer/Makefile.objs               |   1 +
>>   tests/Makefile.include               |   5 +-
>>   qapi/machine-target.json             |   6 +-
>>   hw/net/fsl_etsec/etsec.h             |   1 -
>>   include/hw/arm/aspeed.h              |   1 +
>>   include/hw/arm/bcm2835_peripherals.h |   5 +-
>>   include/hw/arm/bcm2836.h             |   4 +-
>>   include/hw/arm/raspi_platform.h      |   1 +
>>   include/hw/misc/bcm2835_thermal.h    |  27 ++
>>   include/hw/timer/bcm2835_systmr.h    |  33 +++
>>   include/qemu/bitops.h                |   1 +
>>   target/arm/cpu.h                     | 105 +++++--
>>   target/arm/helper.h                  |   4 +
>>   target/arm/internals.h               |   9 +
>>   target/arm/kvm_arm.h                 |  39 +++
>>   hw/arm/aspeed.c                      |  23 ++
>>   hw/arm/bcm2835_peripherals.c         |  30 +-
>>   hw/arm/bcm2836.c                     |  44 +--
>>   hw/arm/highbank.c                    |   3 +-
>>   hw/arm/raspi.c                       |  14 +-
>>   hw/dma/xilinx_axidma.c               |   9 +-
>>   hw/gpio/aspeed_gpio.c                |   8 +-
>>   hw/intc/armv7m_nvic.c                |  22 +-
>>   hw/m68k/mcf5206.c                    |  15 +-
>>   hw/misc/bcm2835_thermal.c            | 135 +++++++++
>>   hw/net/fsl_etsec/etsec.c             |   9 +-
>>   hw/timer/bcm2835_systmr.c            | 163 +++++++++++
>>   hw/timer/grlib_gptimer.c             |  28 +-
>>   hw/timer/milkymist-sysctl.c          |  25 +-
>>   hw/timer/slavio_timer.c              |  32 ++-
>>   hw/timer/xilinx_timer.c              |  13 +-
>>   linux-user/aarch64/cpu_loop.c        |   1 +
>>   linux-user/arm/cpu_loop.c            |   1 +
>>   linux-user/syscall.c                 |   1 +
>>   target/arm/cpu.c                     |  26 +-
>>   target/arm/cpu64.c                   | 364 +++++++++++++++++++++--
>>   target/arm/helper-a64.c              |   3 +
>>   target/arm/helper.c                  | 403 +++++++++++++++++---------
>>   target/arm/kvm.c                     |  25 +-
>>   target/arm/kvm32.c                   |   6 +-
>>   target/arm/kvm64.c                   | 325 ++++++++++++++++++---
>>   target/arm/m_helper.c                |   6 +
>>   target/arm/machine.c                 |   1 +
>>   target/arm/monitor.c                 | 158 ++++++++++
>>   target/arm/op_helper.c               |   4 +
>>   target/arm/translate-a64.c           |  13 +-
>>   target/arm/translate.c               |  33 ++-
>>   tests/arm-cpu-features.c             | 540 +++++++++++++++++++++++++++++++++++
>>   docs/arm-cpu-features.rst            | 317 ++++++++++++++++++++
>>   hw/timer/trace-events                |   5 +
>>   51 files changed, 2725 insertions(+), 323 deletions(-)
>>   create mode 100644 include/hw/misc/bcm2835_thermal.h
>>   create mode 100644 include/hw/timer/bcm2835_systmr.h
>>   create mode 100644 hw/misc/bcm2835_thermal.c
>>   create mode 100644 hw/timer/bcm2835_systmr.c
>>   create mode 100644 tests/arm-cpu-features.c
>>   create mode 100644 docs/arm-cpu-features.rst
>>
> 
> If this pull ever fails, please consider fixing:
> 
> typo "device":
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg654117.html
> 
> Tested-by: Mark Cave-Ayland
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg653861.html

Certainly it's not worth a re-spin just on account of a missing tag, I really just
wanted to confirm that the changes are good here :)


ATB,

Mark.

