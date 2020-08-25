Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48AAC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E18E20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 18:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYJTO9ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E18E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAdxU-0003E4-PA
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 14:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAdw6-0002Dx-U8; Tue, 25 Aug 2020 14:44:46 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAdw4-0001B8-LS; Tue, 25 Aug 2020 14:44:46 -0400
Received: by mail-il1-x144.google.com with SMTP id j9so11292515ilc.11;
 Tue, 25 Aug 2020 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3qo1IZB0HbtcHNu/D/DGyqQmqFzRH59VFpvpYDxcmyk=;
 b=HYJTO9ss9OA3Hn+AdJLSX9Tr9vuOEHrVUt//FWSwjJnaQv4TO8XyDzp9cvpjXHHxPu
 atl4Im7YhAHP7EDuwXEAsy73J1oWvfGmsKlQoZZcYlNNSPFV1S/cP7ALyJjtfH4fnKU6
 EauYPv1iP7m52rwOYDCfGwV34FZssbdzt6AuwP6GVrE4vAeu7Y6/th+cBPL96CBx+oXW
 yhlkIfvf1TO1J4q74LgRNSfpmvA9ajfj2NUrxO2GAHNHGlEBHF+Vhw5R7z95+DA6UCYB
 ngV0S7dLAJ05LGUmkvRJELH2RNuPLhf0QS+XenH4MSlddrnguoxK6m4S8jDF5YzjJPmT
 zJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3qo1IZB0HbtcHNu/D/DGyqQmqFzRH59VFpvpYDxcmyk=;
 b=cZ4YkSzJ+X4QrX7bssH/cJVJ5kTxUfKf/G7+TmkPloVbdMY1ojmetNP1KdWLFEolz9
 sXsCfE1CugHAuqfLELsbQrQgaU6DnCeRYpqYHDXeBlsMJAiYWx9CrosKmAR6syWBdQGa
 eEA9ry6hwTVrwbpRpH+ZQ4C/ZJWYSRg5IgnMYGHTZxDKwOlUnAKsdCUr/1X6Ec1ZlPsL
 vcXPHpJ1511vuDRxraLCbjW1E0OycfH26fFd2z3BRzDAgF2bFRpZK+8dYM49rrzi+Z0S
 oWRIp0crWFpU95Q9oOa4d/dNxG0gsNcWmI2wtn/US3Bgs5ogo+3eLh6KzhRNmQgXTcFu
 ZazA==
X-Gm-Message-State: AOAM532A696/jid5+V6jBVSGd1WcSphJysKiL1S5lDSPOoG6Dqj9IWLi
 tP5f43Jl/3m9uoTrL+U273wLGryJ8Tue2XAayOQ=
X-Google-Smtp-Source: ABdhPJzToXorCr9fTsQVbf9CywBuyRxPBJe+CXIHKG10KHHyUW43qvTuAz9mKl9P3CllMKBcJGOTObSfS9KmQOZCBzs=
X-Received: by 2002:a05:6e02:ef3:: with SMTP id
 j19mr10782405ilk.227.1598381083181; 
 Tue, 25 Aug 2020 11:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-18-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-18-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 11:33:59 -0700
Message-ID: <CAKmqyKMQ29BA2r7-CGnG+40voFCAOseec4A-HWV0CPwivgsGEw@mail.gmail.com>
Subject: Re: [PATCH 17/18] hw/riscv: clint: Avoid using hard-coded timebase
 frequency
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:54 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the CLINT timestamp is using a hard-coded timebase
> frequency value SIFIVE_CLINT_TIMEBASE_FREQ. This might not be
> true for all boards.
>
> Add a new 'timebase-freq' property to the CLINT device, and
> update various functions to accept this as a parameter.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/microchip_pfsoc.c      |  6 +++++-
>  hw/riscv/sifive_clint.c         | 25 ++++++++++++++-----------
>  hw/riscv/sifive_e.c             |  3 ++-
>  hw/riscv/sifive_u.c             |  3 ++-
>  hw/riscv/spike.c                |  2 +-
>  hw/riscv/virt.c                 |  3 ++-
>  include/hw/riscv/sifive_clint.h |  3 ++-
>  target/riscv/cpu.h              |  6 ++++--
>  target/riscv/cpu_helper.c       |  4 +++-
>  target/riscv/csr.c              |  4 ++--
>  10 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 139284a..e8b7f86 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -60,6 +60,9 @@
>  #define BIOS_FILENAME   "hss.bin"
>  #define RESET_VECTOR    0x20220000
>
> +/* CLINT timebase frequency */
> +#define CLINT_TIMEBASE_FREQ 1000000
> +
>  /* GEM version */
>  #define GEM_REVISION    0x0107010c
>
> @@ -189,7 +192,8 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      /* CLINT */
>      sifive_clint_create(memmap[MICROCHIP_PFSOC_CLINT].base,
>          memmap[MICROCHIP_PFSOC_CLINT].size, ms->smp.cpus,
> -        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        CLINT_TIMEBASE_FREQ, false);
>
>      /* L2 cache controller */
>      create_unimplemented_device("microchip.pfsoc.l2cc",
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index 669c21a..a568568 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -29,22 +29,23 @@
>  #include "hw/riscv/sifive_clint.h"
>  #include "qemu/timer.h"
>
> -static uint64_t cpu_riscv_read_rtc(void)
> +static uint64_t cpu_riscv_read_rtc(uint32_t timebase_freq)
>  {
>      return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> -        SIFIVE_CLINT_TIMEBASE_FREQ, NANOSECONDS_PER_SECOND);
> +        timebase_freq, NANOSECONDS_PER_SECOND);
>  }
>
>  /*
>   * Called when timecmp is written to update the QEMU timer or immediately
>   * trigger timer interrupt if mtimecmp <= current timer value.
>   */
> -static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
> +static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value,
> +                                       uint32_t timebase_freq)
>  {
>      uint64_t next;
>      uint64_t diff;
>
> -    uint64_t rtc_r = cpu_riscv_read_rtc();
> +    uint64_t rtc_r = cpu_riscv_read_rtc(timebase_freq);
>
>      cpu->env.timecmp = value;
>      if (cpu->env.timecmp <= rtc_r) {
> @@ -59,7 +60,7 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
>      diff = cpu->env.timecmp - rtc_r;
>      /* back to ns (note args switched in muldiv64) */
>      next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -        muldiv64(diff, NANOSECONDS_PER_SECOND, SIFIVE_CLINT_TIMEBASE_FREQ);
> +        muldiv64(diff, NANOSECONDS_PER_SECOND, timebase_freq);
>      timer_mod(cpu->env.timer, next);
>  }
>
> @@ -111,10 +112,10 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
>          }
>      } else if (addr == clint->time_base) {
>          /* time_lo */
> -        return cpu_riscv_read_rtc() & 0xFFFFFFFF;
> +        return cpu_riscv_read_rtc(clint->timebase_freq) & 0xFFFFFFFF;
>      } else if (addr == clint->time_base + 4) {
>          /* time_hi */
> -        return (cpu_riscv_read_rtc() >> 32) & 0xFFFFFFFF;
> +        return (cpu_riscv_read_rtc(clint->timebase_freq) >> 32) & 0xFFFFFFFF;
>      }
>
>      error_report("clint: invalid read: %08x", (uint32_t)addr);
> @@ -151,13 +152,13 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>              /* timecmp_lo */
>              uint64_t timecmp_hi = env->timecmp >> 32;
>              sifive_clint_write_timecmp(RISCV_CPU(cpu),
> -                timecmp_hi << 32 | (value & 0xFFFFFFFF));
> +                timecmp_hi << 32 | (value & 0xFFFFFFFF), clint->timebase_freq);
>              return;
>          } else if ((addr & 0x7) == 4) {
>              /* timecmp_hi */
>              uint64_t timecmp_lo = env->timecmp;
>              sifive_clint_write_timecmp(RISCV_CPU(cpu),
> -                value << 32 | (timecmp_lo & 0xFFFFFFFF));
> +                value << 32 | (timecmp_lo & 0xFFFFFFFF), clint->timebase_freq);
>          } else {
>              error_report("clint: invalid timecmp write: %08x", (uint32_t)addr);
>          }
> @@ -191,6 +192,7 @@ static Property sifive_clint_properties[] = {
>      DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
>      DEFINE_PROP_UINT32("time-base", SiFiveCLINTState, time_base, 0),
>      DEFINE_PROP_UINT32("aperture-size", SiFiveCLINTState, aperture_size, 0),
> +    DEFINE_PROP_UINT32("timebase-freq", SiFiveCLINTState, timebase_freq, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -229,7 +231,7 @@ type_init(sifive_clint_register_types)
>   */
>  DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>      uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime)
> +    uint32_t timebase_freq, bool provide_rdtime)
>  {
>      int i;
>      for (i = 0; i < num_harts; i++) {
> @@ -239,7 +241,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>              continue;
>          }
>          if (provide_rdtime) {
> -            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
> +            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc, timebase_freq);
>          }
>          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                    &sifive_clint_timer_cb, cpu);
> @@ -252,6 +254,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>      qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
>      qdev_prop_set_uint32(dev, "time-base", time_base);
>      qdev_prop_set_uint32(dev, "aperture-size", size);
> +    qdev_prop_set_uint32(dev, "timebase-freq", timebase_freq);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>      return dev;
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index c84d407..e7f6460 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -213,7 +213,8 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          memmap[SIFIVE_E_PLIC].size);
>      sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
>          memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
> -        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        SIFIVE_CLINT_TIMEBASE_FREQ, false);
>      create_unimplemented_device("riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
>      sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index e256da2..5ec9fca 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -706,7 +706,8 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
>          memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
> -        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        SIFIVE_CLINT_TIMEBASE_FREQ, false);
>
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->prci), errp)) {
>          return;
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 13958bd..ae8593a 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -235,7 +235,7 @@ static void spike_board_init(MachineState *machine)
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
>          smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> -        false);
> +        SIFIVE_CLINT_TIMEBASE_FREQ, false);
>  }
>
>  static void spike_machine_init(MachineClass *mc)
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 6e91cf1..af0d06a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -572,7 +572,8 @@ static void virt_machine_init(MachineState *machine)
>          memmap[VIRT_PLIC].size);
>      sifive_clint_create(memmap[VIRT_CLINT].base,
>          memmap[VIRT_CLINT].size, smp_cpus,
> -        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
> +        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        SIFIVE_CLINT_TIMEBASE_FREQ, true);
>      sifive_test_create(memmap[VIRT_TEST].base);
>
>      for (i = 0; i < VIRTIO_COUNT; i++) {
> diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
> index 4a720bf..eb8577a 100644
> --- a/include/hw/riscv/sifive_clint.h
> +++ b/include/hw/riscv/sifive_clint.h
> @@ -38,11 +38,12 @@ typedef struct SiFiveCLINTState {
>      uint32_t timecmp_base;
>      uint32_t time_base;
>      uint32_t aperture_size;
> +    uint32_t timebase_freq;
>  } SiFiveCLINTState;
>
>  DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>      uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime);
> +    uint32_t timebase_freq, bool provide_rdtime);
>
>  enum {
>      SIFIVE_SIP_BASE     = 0x0,
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d34bcfa..02486c3 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -219,7 +219,8 @@ struct CPURISCVState {
>      pmp_table_t pmp_state;
>
>      /* machine specific rdtime callback */
> -    uint64_t (*rdtime_fn)(void);
> +    uint64_t (*rdtime_fn)(uint32_t);
> +    uint32_t rdtime_fn_arg;
>
>      /* True if in debugger mode.  */
>      bool debugger;
> @@ -347,7 +348,8 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
>  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value);
>  #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
> -void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
> +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(uint32_t),
> +                             uint32_t arg);
>  #endif
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fd1d373..c82a521 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -258,9 +258,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
>      return old;
>  }
>
> -void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
> +void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(uint32_t),
> +                             uint32_t arg)
>  {
>      env->rdtime_fn = fn;
> +    env->rdtime_fn_arg = arg;
>  }
>
>  void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6a96a01..6cef1ac 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -294,7 +294,7 @@ static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
>          return -1;
>      }
>
> -    *val = env->rdtime_fn() + delta;
> +    *val = env->rdtime_fn(env->rdtime_fn_arg) + delta;
>      return 0;
>  }
>
> @@ -307,7 +307,7 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>          return -1;
>      }
>
> -    *val = (env->rdtime_fn() + delta) >> 32;
> +    *val = (env->rdtime_fn(env->rdtime_fn_arg) + delta) >> 32;
>      return 0;
>  }
>  #endif
> --
> 2.7.4
>
>

