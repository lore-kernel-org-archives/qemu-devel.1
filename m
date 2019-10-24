Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A650CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556A921906
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBOrHOdi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556A921906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNi0n-0000G0-Vb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNhhD-0007Ez-AM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNhhB-0002dm-IQ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:18:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNhhB-0002dB-F1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 14:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571941128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4hEX+4cIs0DMwrT8Wl9TOWVtesh0j815VovywBvLEw=;
 b=QBOrHOdiZypHK4LrGCwKlrOHfcU69j+svufEvC7liFs8uHke+aBX6Q9lEopnn5dzLGJJnx
 zwlD+/yixCsrQNzDRyXjsQQ3dPall7fiGQq/XwBKOYTHdGrtetnJ8lkTnzjQCylAC/+bT1
 Lz04QUfrWs0rLvArAGUcFfuh+DCrBtI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-bGXiJUuVO7iGxTfjBUyZMA-1; Thu, 24 Oct 2019 14:18:46 -0400
Received: by mail-wm1-f71.google.com with SMTP id z24so1303247wmk.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 11:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VFq5AyiYPnMm4nnMbX6TjQe1ZpUV+JiAuX8Oc7/JJiE=;
 b=bqsqYxcdZJT2MH0M5/084Db4TPe946RUejAdWLS6jMDeFSfJI00ft73bMcYjUmNl+B
 NdJz6q+uNcrAz5o3qqeWnNiS3cfKiAR+VdokuCZBDc015iiAx9oPZ/fokz6rU8zr5RsJ
 bBGjD9tVpN2IddwTz1zU9HxyM5uSTjcTY0vcdXHKwhSErhq1bVedaYtyxMjuwXxOuQUH
 FHxgcnrU1uDIiUOx76SYlaJMejlin90qTXWKCd0vFTIQUTCcfxQsqGQ3b87q5M+EKcaE
 p5UD08eIchDiSwyxLiiE++uMQ04kFeATJhLhV/qiUQDqzinNXfjKxKPSQGDBAj8Eaocn
 FxzA==
X-Gm-Message-State: APjAAAUMc1NoND4uUdzpmbyqh0SnlWFp9mYCEj09FxOPHkRV8RZDGs3h
 9cL/CL9UQUZ/LoWFFBIIeQhNQTww5maTtRB4TiMHdEAmxXkGiGg4M18ZQD4c6E3jK4Q/cw2VmUr
 P20OxLhWP/8GLbNg=
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr5112989wrf.221.1571941124913; 
 Thu, 24 Oct 2019 11:18:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyOvINGb6M7dIbNq4iIIYc4/Z9A7pcZAaIl0DJHZKyN9s+FOWd96XPg+eUB17uUW3s/FHlYsg==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr5112973wrf.221.1571941124608; 
 Thu, 24 Oct 2019 11:18:44 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x8sm26144172wrr.43.2019.10.24.11.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 11:18:43 -0700 (PDT)
Subject: Re: [PULL 00/51] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191024162724.31675-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bf876f8-b868-ac37-e7ef-083fdf2544a9@redhat.com>
Date: Thu, 24 Oct 2019 20:18:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: bGXiJUuVO7iGxTfjBUyZMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 10/24/19 6:26 PM, Peter Maydell wrote:
> Probably the last arm pullreq before softfreeze...
>=20
> The following changes since commit 58560ad254fbda71d4daa6622d71683190070e=
e2:
>=20
>    Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.2-2019102=
4' into staging (2019-10-24 16:22:58 +0100)
>=20
> are available in the Git repository at:
>=20
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-a=
rm-20191024
>=20
> for you to fetch changes up to a01a4a3e85ae8f6fe21adbedc80f7013faabdcf4:
>=20
>    hw/arm/highbank: Use AddressSpace when using write_secondary_boot() (2=
019-10-24 17:16:30 +0100)
>=20
> ----------------------------------------------------------------
> target-arm queue:
>   * raspi boards: some cleanup
>   * raspi: implement the bcm2835 system timer device
>   * raspi: implement a dummy thermal sensor
>   * KVM: support providing SVE to the guest
>   * misc devices: switch to ptimer transaction API
>   * cache TB flag state to improve performance of cpu_get_tb_cpu_state
>   * aspeed: Add an AST2600 eval board
>=20
> ----------------------------------------------------------------
> Andrew Jones (9):
>        target/arm/monitor: Introduce qmp_query_cpu_model_expansion
>        tests: arm: Introduce cpu feature tests
>        target/arm: Allow SVE to be disabled via a CPU property
>        target/arm/cpu64: max cpu: Introduce sve<N> properties
>        target/arm/kvm64: Add kvm_arch_get/put_sve
>        target/arm/kvm64: max cpu: Enable SVE when available
>        target/arm/kvm: scratch vcpu: Preserve input kvm_vcpu_init feature=
s
>        target/arm/cpu64: max cpu: Support sve properties with KVM
>        target/arm/kvm: host cpu: Add support for sve<N> properties
>=20
> C=C3=A9dric Le Goater (2):
>        hw/gpio: Fix property accessors of the AST2600 GPIO 1.8V model
>        aspeed: Add an AST2600 eval board
>=20
> Peter Maydell (8):
>        hw/net/fsl_etsec/etsec.c: Switch to transaction-based ptimer API
>        hw/timer/xilinx_timer.c: Switch to transaction-based ptimer API
>        hw/dma/xilinx_axidma.c: Switch to transaction-based ptimer API
>        hw/timer/slavio_timer: Remove useless check for NULL t->timer
>        hw/timer/slavio_timer.c: Switch to transaction-based ptimer API
>        hw/timer/grlib_gptimer.c: Switch to transaction-based ptimer API
>        hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
>        hw/watchdog/milkymist-sysctl.c: Switch to transaction-based ptimer=
 API
>=20
> Philippe Mathieu-Daud=C3=A9 (8):
>        hw/misc/bcm2835_thermal: Add a dummy BCM2835 thermal sensor
>        hw/arm/bcm2835_peripherals: Use the thermal sensor block
>        hw/timer/bcm2835: Add the BCM2835 SYS_timer
>        hw/arm/bcm2835_peripherals: Use the SYS_timer
>        hw/arm/bcm2836: Make the SoC code modular
>        hw/arm/bcm2836: Rename cpus[] as cpu[].core
>        hw/arm/raspi: Use AddressSpace when using arm_boot::write_secondar=
y_boot
>        hw/arm/highbank: Use AddressSpace when using write_secondary_boot(=
)
>=20
> Richard Henderson (24):
>        target/arm: Split out rebuild_hflags_common
>        target/arm: Split out rebuild_hflags_a64
>        target/arm: Split out rebuild_hflags_common_32
>        target/arm: Split arm_cpu_data_is_big_endian
>        target/arm: Split out rebuild_hflags_m32
>        target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
>        target/arm: Split out rebuild_hflags_a32
>        target/arm: Split out rebuild_hflags_aprofile
>        target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in cpu_get_tb_cpu=
_state
>        target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
>        target/arm: Hoist computation of TBFLAG_A32.VFPEN
>        target/arm: Add arm_rebuild_hflags
>        target/arm: Split out arm_mmu_idx_el
>        target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
>        target/arm: Add HELPER(rebuild_hflags_{a32, a64, m32})
>        target/arm: Rebuild hflags at EL changes
>        target/arm: Rebuild hflags at MSR writes
>        target/arm: Rebuild hflags at CPSR writes
>        target/arm: Rebuild hflags at Xscale SCTLR writes
>        target/arm: Rebuild hflags for M-profile
>        target/arm: Rebuild hflags for M-profile NVIC
>        linux-user/aarch64: Rebuild hflags for TARGET_WORDS_BIGENDIAN
>        linux-user/arm: Rebuild hflags for TARGET_WORDS_BIGENDIAN
>        target/arm: Rely on hflags correct in cpu_get_tb_cpu_state
>=20
>   hw/misc/Makefile.objs                |   1 +
>   hw/timer/Makefile.objs               |   1 +
>   tests/Makefile.include               |   5 +-
>   qapi/machine-target.json             |   6 +-
>   hw/net/fsl_etsec/etsec.h             |   1 -
>   include/hw/arm/aspeed.h              |   1 +
>   include/hw/arm/bcm2835_peripherals.h |   5 +-
>   include/hw/arm/bcm2836.h             |   4 +-
>   include/hw/arm/raspi_platform.h      |   1 +
>   include/hw/misc/bcm2835_thermal.h    |  27 ++
>   include/hw/timer/bcm2835_systmr.h    |  33 +++
>   include/qemu/bitops.h                |   1 +
>   target/arm/cpu.h                     | 105 +++++--
>   target/arm/helper.h                  |   4 +
>   target/arm/internals.h               |   9 +
>   target/arm/kvm_arm.h                 |  39 +++
>   hw/arm/aspeed.c                      |  23 ++
>   hw/arm/bcm2835_peripherals.c         |  30 +-
>   hw/arm/bcm2836.c                     |  44 +--
>   hw/arm/highbank.c                    |   3 +-
>   hw/arm/raspi.c                       |  14 +-
>   hw/dma/xilinx_axidma.c               |   9 +-
>   hw/gpio/aspeed_gpio.c                |   8 +-
>   hw/intc/armv7m_nvic.c                |  22 +-
>   hw/m68k/mcf5206.c                    |  15 +-
>   hw/misc/bcm2835_thermal.c            | 135 +++++++++
>   hw/net/fsl_etsec/etsec.c             |   9 +-
>   hw/timer/bcm2835_systmr.c            | 163 +++++++++++
>   hw/timer/grlib_gptimer.c             |  28 +-
>   hw/timer/milkymist-sysctl.c          |  25 +-
>   hw/timer/slavio_timer.c              |  32 ++-
>   hw/timer/xilinx_timer.c              |  13 +-
>   linux-user/aarch64/cpu_loop.c        |   1 +
>   linux-user/arm/cpu_loop.c            |   1 +
>   linux-user/syscall.c                 |   1 +
>   target/arm/cpu.c                     |  26 +-
>   target/arm/cpu64.c                   | 364 +++++++++++++++++++++--
>   target/arm/helper-a64.c              |   3 +
>   target/arm/helper.c                  | 403 +++++++++++++++++---------
>   target/arm/kvm.c                     |  25 +-
>   target/arm/kvm32.c                   |   6 +-
>   target/arm/kvm64.c                   | 325 ++++++++++++++++++---
>   target/arm/m_helper.c                |   6 +
>   target/arm/machine.c                 |   1 +
>   target/arm/monitor.c                 | 158 ++++++++++
>   target/arm/op_helper.c               |   4 +
>   target/arm/translate-a64.c           |  13 +-
>   target/arm/translate.c               |  33 ++-
>   tests/arm-cpu-features.c             | 540 ++++++++++++++++++++++++++++=
+++++++
>   docs/arm-cpu-features.rst            | 317 ++++++++++++++++++++
>   hw/timer/trace-events                |   5 +
>   51 files changed, 2725 insertions(+), 323 deletions(-)
>   create mode 100644 include/hw/misc/bcm2835_thermal.h
>   create mode 100644 include/hw/timer/bcm2835_systmr.h
>   create mode 100644 hw/misc/bcm2835_thermal.c
>   create mode 100644 hw/timer/bcm2835_systmr.c
>   create mode 100644 tests/arm-cpu-features.c
>   create mode 100644 docs/arm-cpu-features.rst
>=20

If this pull ever fails, please consider fixing:

typo "device":
https://www.mail-archive.com/qemu-devel@nongnu.org/msg654117.html

Tested-by: Mark Cave-Ayland
https://www.mail-archive.com/qemu-devel@nongnu.org/msg653861.html


