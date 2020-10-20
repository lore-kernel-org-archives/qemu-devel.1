Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA07C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08A0206CA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enw3uuJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08A0206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUukV-0008C9-Np
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUuct-0005mp-9i
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:36:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUucr-0000kt-4g
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:36:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so2959739wrp.10
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xyOEjw5JKqtGQbd5QrUxBprTklWfkYvZi7yE0Bb7psI=;
 b=enw3uuJuEVWJdpQFo6QFjZUKZjg6I7BRR9r0gGoS58U62LgC6YS6JPuHCmYRp5lGuK
 WiTMvhhvdqR7lw4OzO3bNUvobVaIFBFAtMFr5IU1B2HDZCylQvWh3BTqWkO96zDwh4Dm
 Z4xOPEal/YCbd+aK0E+8pCD7cxBeDhr1tZ8EAfuWxMBSxjX1q8QTjZ6B4rSwrTXFMSdP
 o7KCWZjOhmYM0OjY+a6ugBheZIByOzTWOhNS+5bW0Muh3qPeOhS9VRIu1ui/3Yk8SJaI
 GWw2eLejxPvGorWqPaTDvKwklb9FW+HwqcW4J2Yk9ickQDqPp2SUStTXvg0fFybKh3wF
 Q2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xyOEjw5JKqtGQbd5QrUxBprTklWfkYvZi7yE0Bb7psI=;
 b=O7W9y5NVWX9Lc6PWRK6x6VMzyLphne2HeahEioFjBR43Cz3EylYnsBxEjypaVZNZlq
 M4fcdkWTFW1zK/bZy+Kw9bDodOPrwTxlIXVu4mC3lVX+yPZmu9PSZPn5BglFezmqCBK6
 i/eJAhB/cb0fq/+ro6GMHQBAMhqdhqmNyuixpFVvX5ImTeeWrRKwiTkftB6NmyablQTo
 Zmz0wVkTO13qzaKg0nJp3LjlgXxmfN1OK80GCkr/6eO77tZbU9VR61etMX//1xWPRV/b
 0vMvUIYlATAKHVhQLdi1z/mqjjiCPmOGCb5Mm2vIUDvGkdY1edYcHjqbDrqYFnANSkER
 +kUA==
X-Gm-Message-State: AOAM530qlP83RQGtv+vaXUbOBtBn/YsQmyxAyoBM1v9LtZ+7ZL2M/poC
 /PzsZO9oZN16kyHDly9wIWuea/2n/1o=
X-Google-Smtp-Source: ABdhPJyEJCOW9MuKI6fMXvUsSSicm2DAsrtyjabBUvH4SCeQwJbC+uHbYvocJ8Qz1zAW4IMlBsZKbg==
X-Received: by 2002:adf:f88a:: with SMTP id u10mr4467363wrp.1.1603211799268;
 Tue, 20 Oct 2020 09:36:39 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y21sm3250933wma.19.2020.10.20.09.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 09:36:38 -0700 (PDT)
Subject: Re: [PULL 00/41] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201020155656.8045-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <abd213a9-9da7-2338-cfe6-1b6915f17615@amsat.org>
Date: Tue, 20 Oct 2020 18:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 5:56 PM, Peter Maydell wrote:
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:
> 
>    Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201020
> 
> for you to fetch changes up to 6358890cb939192f6169fdf7664d903bf9b1d338:
> 
>    tests/tcg/aarch64: Add bti smoke tests (2020-10-20 16:12:02 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * Fix AArch32 SMLAD incorrect setting of Q bit
>   * AArch32 VCVT fixed-point to float is always round-to-nearest
>   * strongarm: Fix 'time to transmit a char' unit comment
>   * Restrict APEI tables generation to the 'virt' machine
>   * bcm2835: minor code cleanups

Just to clarify, the main part there is a bugfix ;) Only the first
IRQ from the SYS_timer was delivered to the ARM core. It passed my
smoke test because when I wrote the model only u-boot was using this
peripheral, then Linux started to use it.

Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")

>   * correctly flush TLBs when TBI is enabled
>   * tests/qtest: Add npcm7xx timer test
>   * loads-stores.rst: add footnote that clarifies GETPC usage
>   * Fix reported EL for mte_check_fail
>   * Ignore HCR_EL2.ATA when {E2H,TGE} != 11
>   * microbit_i2c: Fix coredump when dump-vmstate
>   * nseries: Fix loading kernel image on n8x0 machines
>   * Implement v8.1M low-overhead-loops
>   * linux-user: Support AArch64 BTI
> 
> ----------------------------------------------------------------
> Emanuele Giuseppe Esposito (1):
>        loads-stores.rst: add footnote that clarifies GETPC usage
> 
> Havard Skinnemoen (1):
>        tests/qtest: Add npcm7xx timer test
> 
> Peng Liang (1):
>        microbit_i2c: Fix coredump when dump-vmstate
> 
> Peter Maydell (12):
>        target/arm: Fix SMLAD incorrect setting of Q bit
>        target/arm: AArch32 VCVT fixed-point to float is always round-to-nearest
>        decodetree: Fix codegen for non-overlapping group inside overlapping group
>        target/arm: Implement v8.1M NOCP handling
>        target/arm: Implement v8.1M conditional-select insns
>        target/arm: Make the t32 insn[25:23]=111 group non-overlapping
>        target/arm: Don't allow BLX imm for M-profile
>        target/arm: Implement v8.1M branch-future insns (as NOPs)
>        target/arm: Implement v8.1M low-overhead-loop instructions
>        target/arm: Fix has_vfp/has_neon ID reg squashing for M-profile
>        target/arm: Allow M-profile CPUs with FP16 to set FPSCR.FP16
>        target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension
> 
> Philippe Mathieu-Daudé (10):
>        hw/arm/strongarm: Fix 'time to transmit a char' unit comment
>        hw/arm: Restrict APEI tables generation to the 'virt' machine
>        hw/timer/bcm2835: Introduce BCM2835_SYSTIMER_COUNT definition
>        hw/timer/bcm2835: Rename variable holding CTRL_STATUS register
>        hw/timer/bcm2835: Support the timer COMPARE registers
>        hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer IRQs
>        hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
>        hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers
>        hw/arm/nseries: Fix loading kernel image on n8x0 machines
>        linux-user/elfload: Avoid leaking interp_name using GLib memory API
> 
> Richard Henderson (16):
>        accel/tcg: Add tlb_flush_page_bits_by_mmuidx*
>        target/arm: Use tlb_flush_page_bits_by_mmuidx*
>        target/arm: Remove redundant mmu_idx lookup
>        target/arm: Fix reported EL for mte_check_fail
>        target/arm: Ignore HCR_EL2.ATA when {E2H,TGE} != 11
>        linux-user/aarch64: Reset btype for signals
>        linux-user: Set PAGE_TARGET_1 for TARGET_PROT_BTI
>        include/elf: Add defines related to GNU property notes for AArch64
>        linux-user/elfload: Fix coding style in load_elf_image
>        linux-user/elfload: Adjust iteration over phdr
>        linux-user/elfload: Move PT_INTERP detection to first loop
>        linux-user/elfload: Use Error for load_elf_image
>        linux-user/elfload: Use Error for load_elf_interp
>        linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes
>        linux-user/elfload: Parse GNU_PROPERTY_AARCH64_FEATURE_1_AND
>        tests/tcg/aarch64: Add bti smoke tests
> 
>   docs/devel/loads-stores.rst             |   8 +-
>   default-configs/devices/arm-softmmu.mak |   1 -
>   include/elf.h                           |  22 ++
>   include/exec/cpu-all.h                  |   2 +
>   include/exec/exec-all.h                 |  36 ++
>   include/hw/timer/bcm2835_systmr.h       |  17 +-
>   linux-user/qemu.h                       |   4 +
>   linux-user/syscall_defs.h               |   4 +
>   target/arm/cpu.h                        |  13 +
>   target/arm/helper.h                     |  13 +
>   target/arm/internals.h                  |   9 +-
>   target/arm/m-nocp.decode                |  10 +-
>   target/arm/t32.decode                   |  50 ++-
>   accel/tcg/cputlb.c                      | 275 +++++++++++++++-
>   hw/arm/bcm2835_peripherals.c            |  13 +-
>   hw/arm/nseries.c                        |   1 +
>   hw/arm/strongarm.c                      |   2 +-
>   hw/i2c/microbit_i2c.c                   |   1 +
>   hw/intc/bcm2835_ic.c                    |   4 +-
>   hw/intc/bcm2836_control.c               |   8 +-
>   hw/timer/bcm2835_systmr.c               |  57 ++--
>   linux-user/aarch64/signal.c             |  10 +-
>   linux-user/elfload.c                    | 326 ++++++++++++++----
>   linux-user/mmap.c                       |  16 +
>   target/arm/cpu.c                        |  38 ++-
>   target/arm/helper.c                     |  55 +++-
>   target/arm/mte_helper.c                 |  13 +-
>   target/arm/translate-a64.c              |   6 +-
>   target/arm/translate.c                  | 239 +++++++++++++-
>   target/arm/vfp_helper.c                 |  76 +++--
>   tests/qtest/npcm7xx_timer-test.c        | 562 ++++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/bti-1.c               |  62 ++++
>   tests/tcg/aarch64/bti-2.c               | 108 ++++++
>   tests/tcg/aarch64/bti-crt.inc.c         |  51 +++
>   hw/arm/Kconfig                          |   1 +
>   hw/intc/trace-events                    |   4 +
>   hw/timer/trace-events                   |   6 +-
>   scripts/decodetree.py                   |   2 +-
>   target/arm/translate-vfp.c.inc          |  41 ++-
>   tests/qtest/meson.build                 |   1 +
>   tests/tcg/aarch64/Makefile.target       |  10 +
>   tests/tcg/configure.sh                  |   4 +
>   42 files changed, 1973 insertions(+), 208 deletions(-)
>   create mode 100644 tests/qtest/npcm7xx_timer-test.c
>   create mode 100644 tests/tcg/aarch64/bti-1.c
>   create mode 100644 tests/tcg/aarch64/bti-2.c
>   create mode 100644 tests/tcg/aarch64/bti-crt.inc.c
> 


