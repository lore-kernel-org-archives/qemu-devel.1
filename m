Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2F72072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnyLYKBo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2F72072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9qS-000780-TP
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9oW-0004xq-6L; Tue, 19 May 2020 17:30:16 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:45144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9oT-0006fO-FC; Tue, 19 May 2020 17:30:15 -0400
Received: by mail-il1-x141.google.com with SMTP id b15so916459ilq.12;
 Tue, 19 May 2020 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mxGwLEKZBoOAP+TKuPlyok3TZRTwZAMgKoyKcE0B1SM=;
 b=jnyLYKBo0nqRCgww0ZbA6DleAmwz6ngkukQdykQ8DDC5IVE88AK1icJ6KuLoDnAQIz
 wHlYKQlylJdhoh3fm40kvNxRi/vWcz8Cn4v9+Hw5zundB3mJnxCOWqa/mvpCtUGt8u1v
 CFXugzRfoEXJEyIjav+L8ogJgcf4gXpdgCSy3VdsC7FCqg25M6vAtagrvuwcCQIkQaB/
 FtO8REk+k5bhSCQgW483MowlDqsDNPZj5FBrWSZ5h9YweEJ7nveZj9A42ARp5gffW4AH
 aF5RDd0CNGUckwyw1rT57kepKePdc4M8IaTBhCtBo0tTIIwVDaDeuQlSj1fQx1UXBCxc
 tCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mxGwLEKZBoOAP+TKuPlyok3TZRTwZAMgKoyKcE0B1SM=;
 b=ow7a2NFXhxx3LcYnRZM8eXE/4UkegF0ZXVbbfX5lrs/F3jZ+UsMwIPeCnvoHimiGjt
 xo8Tqbf90oyarbbRAzKf0MXhMbBbclGAB9ni9wtHARfME9BhhDhD4wBvqIw1K/TeVPzC
 x8CUOf7A5MOnJxsj9Vjhz0k+xXBLazesmp7RKCAMj9MqD0xqJvlRimFWwKhgPM8o7ZSf
 +M4gGbAC6fdWEXCPHCWM1UvRUnWxqUqdWEUl1sYBuqUxVUjh/i153bp1dxuQovwIrHqN
 CDZ/LgpTOngTyKAMlhPol9S7rCLRv5Jyz8ZyQV6L77OWjnDLGnrx5IHK6IAlCjyltKH2
 x7nQ==
X-Gm-Message-State: AOAM531YmzFjOXS/lsqt5ItrSmEVedtefLylY7dBS8rtMML6UAuerIvW
 YewaP6Sr36gSl+dNSPaAcM1+r8ZB3ixESWW/qFQ=
X-Google-Smtp-Source: ABdhPJxNVJ5Vv6sJyzIqntMAAweof7JyXfmE2ouB/FJ0eWj6eq2L072S0/39wSNDWmR0FXt6XK/09eiXl9eosw0UmQg=
X-Received: by 2002:a92:d087:: with SMTP id h7mr1119105ilh.227.1589923811804; 
 Tue, 19 May 2020 14:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200516063746.18296-1-anup.patel@wdc.com>
 <20200516063746.18296-2-anup.patel@wdc.com>
In-Reply-To: <20200516063746.18296-2-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:21:18 -0700
Message-ID: <CAKmqyKOWR5SMnfWFLDGTqs981_=sA5gw0V65MJYBfakAVgSSVA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/riscv: Allow creating multiple instances of CLINT
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 11:39 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> We extend CLINT emulation to allow multiple instances of CLINT in
> a QEMU RISC-V machine. To achieve this, we remove first HART id
> zero assumption from CLINT emulation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_clint.c         | 20 ++++++++++++--------
>  hw/riscv/sifive_e.c             |  2 +-
>  hw/riscv/sifive_u.c             |  2 +-
>  hw/riscv/spike.c                |  6 +++---
>  hw/riscv/virt.c                 |  2 +-
>  include/hw/riscv/sifive_clint.h |  7 ++++---
>  6 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> index e933d35092..7d713fd743 100644
> --- a/hw/riscv/sifive_clint.c
> +++ b/hw/riscv/sifive_clint.c
> @@ -78,7 +78,7 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
>      SiFiveCLINTState *clint = opaque;
>      if (addr >= clint->sip_base &&
>          addr < clint->sip_base + (clint->num_harts << 2)) {
> -        size_t hartid = (addr - clint->sip_base) >> 2;
> +        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -91,7 +91,8 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
>          }
>      } else if (addr >= clint->timecmp_base &&
>          addr < clint->timecmp_base + (clint->num_harts << 3)) {
> -        size_t hartid = (addr - clint->timecmp_base) >> 3;
> +        size_t hartid = clint->hartid_base +
> +            ((addr - clint->timecmp_base) >> 3);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -128,7 +129,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>
>      if (addr >= clint->sip_base &&
>          addr < clint->sip_base + (clint->num_harts << 2)) {
> -        size_t hartid = (addr - clint->sip_base) >> 2;
> +        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -141,7 +142,8 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
>          return;
>      } else if (addr >= clint->timecmp_base &&
>          addr < clint->timecmp_base + (clint->num_harts << 3)) {
> -        size_t hartid = (addr - clint->timecmp_base) >> 3;
> +        size_t hartid = clint->hartid_base +
> +            ((addr - clint->timecmp_base) >> 3);
>          CPUState *cpu = qemu_get_cpu(hartid);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
> @@ -185,6 +187,7 @@ static const MemoryRegionOps sifive_clint_ops = {
>  };
>
>  static Property sifive_clint_properties[] = {
> +    DEFINE_PROP_UINT32("hartid-base", SiFiveCLINTState, hartid_base, 0),
>      DEFINE_PROP_UINT32("num-harts", SiFiveCLINTState, num_harts, 0),
>      DEFINE_PROP_UINT32("sip-base", SiFiveCLINTState, sip_base, 0),
>      DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
> @@ -226,13 +229,13 @@ type_init(sifive_clint_register_types)
>  /*
>   * Create CLINT device.
>   */
> -DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
> -    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime)
> +DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
> +    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
> +    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime)
>  {
>      int i;
>      for (i = 0; i < num_harts; i++) {
> -        CPUState *cpu = qemu_get_cpu(i);
> +        CPUState *cpu = qemu_get_cpu(hartid_base + i);
>          CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
>          if (!env) {
>              continue;
> @@ -246,6 +249,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
>      }
>
>      DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
> +    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
>      qdev_prop_set_uint32(dev, "num-harts", num_harts);
>      qdev_prop_set_uint32(dev, "sip-base", sip_base);
>      qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index b53109521e..1c3b37d0ba 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -163,7 +163,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_E_PLIC_CONTEXT_STRIDE,
>          memmap[SIFIVE_E_PLIC].size);
>      sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
> -        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
> +        memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>      create_unimplemented_device("riscv.sifive.e.aon",
>          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index bed10fcfa8..22997fbf13 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -601,7 +601,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
>      sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
> -        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
> +        memmap[SIFIVE_U_CLINT].size, 0, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index d0c4843712..d5e0103d89 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -253,7 +253,7 @@ static void spike_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>  }
>
> @@ -343,7 +343,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>  }
>
> @@ -452,7 +452,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
>
>      /* Core Local Interruptor (timer and IPI) */
>      sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
> -        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
> +        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
>          false);
>
>      g_free(config_string);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index daae3ebdbb..dcb8a83b35 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -596,7 +596,7 @@ static void riscv_virt_board_init(MachineState *machine)
>          VIRT_PLIC_CONTEXT_STRIDE,
>          memmap[VIRT_PLIC].size);
>      sifive_clint_create(memmap[VIRT_CLINT].base,
> -        memmap[VIRT_CLINT].size, smp_cpus,
> +        memmap[VIRT_CLINT].size, 0, smp_cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
>      sifive_test_create(memmap[VIRT_TEST].base);
>
> diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
> index 4a720bfece..9f5fb3d31d 100644
> --- a/include/hw/riscv/sifive_clint.h
> +++ b/include/hw/riscv/sifive_clint.h
> @@ -33,6 +33,7 @@ typedef struct SiFiveCLINTState {
>
>      /*< public >*/
>      MemoryRegion mmio;
> +    uint32_t hartid_base;
>      uint32_t num_harts;
>      uint32_t sip_base;
>      uint32_t timecmp_base;
> @@ -40,9 +41,9 @@ typedef struct SiFiveCLINTState {
>      uint32_t aperture_size;
>  } SiFiveCLINTState;
>
> -DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
> -    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
> -    bool provide_rdtime);
> +DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
> +    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
> +    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
>
>  enum {
>      SIFIVE_SIP_BASE     = 0x0,
> --
> 2.25.1
>
>

