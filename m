Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE147C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E045206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlbhjgAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E045206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtNr-0000bx-RO
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbtMd-0006pY-UD; Thu, 21 May 2020 18:08:31 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jbtMc-00084w-JI; Thu, 21 May 2020 18:08:31 -0400
Received: by mail-io1-xd41.google.com with SMTP id f3so9352668ioj.1;
 Thu, 21 May 2020 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YiwTY9FFMWYx7ULCqRmU7ItaOvMyntJC2WWMydEepEM=;
 b=LlbhjgAYDTgjqKr7oInz69utGL9ndkwIR0dhFQTVrlegy18/WsapR0HYEix0hdZ8Fn
 Jyzz/7J5ySYaI+5QKiAjCRIxjmoTqcnKLYdk3xstgWNzoG/8q/3Gar0GFTtRCznsrrV4
 wViO/iDiW+8rV56p9aLJci23DLgVt/e3sZMxEnpGeNKGQb902Xw8efQWloCpC7fX9bXl
 5JuCwRbp/94QNhCFuhuUOMnkhlfplW4qlgwbEQCBvnz0XCHL2pdzGZpsh1uFaoqSGgw9
 du4gzuhpSnymFQTe8IhR8asgeck1n6V+B4jLRWv1wREGNFw5DhT4ZQpTKRPCLOnlmStL
 iIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YiwTY9FFMWYx7ULCqRmU7ItaOvMyntJC2WWMydEepEM=;
 b=rbijmcw4SuFliv9JuPVxc5vLLbhjT9aGH3fmLNUMgTtnWrVLUhtxi2rUB/MdAu97eR
 0Ew2PkTX4qXJBYIAZsohXLsrN+kJLdRVR6pJ50prjHVpBz+r0JPWjRc/qg+VyBIpF85j
 jlpXZ6MpiVFU6lzkGl5/DRLjmgaGG5czNZVhVgZDvcme4RAELXddhxeAmwl2RVnJqsEc
 A6ow5veqJyEEEiLICGJHFSljT8JmDKMz5LRIcOSglJHo4Q+CpNzOaPuizaW+f8wO3n+n
 neWzubjmXwdLdPYsDwH8VjbUedGM3THM+HHknuy+yRj7NoD4kvEyNfTgWbWm7H2Twx6n
 oa6A==
X-Gm-Message-State: AOAM5301KWyzbnr4zUDf2B4wW/lFZRiKin4KWxBn6CR5X11+ZH9Oo+Ta
 39saARHngpGCN9LqWtSbWL56rdWnXkxRbAwnGCo=
X-Google-Smtp-Source: ABdhPJxXTQsw/6k8xCc25f4J77bGkQqq+lwwobMxy5HAwp8FkPBqnLQj6bJXolp032dse4b14/6SNIuipNU4zniyYJY=
X-Received: by 2002:a02:54ca:: with SMTP id t193mr5910128jaa.26.1590098908784; 
 Thu, 21 May 2020 15:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200516063746.18296-1-anup.patel@wdc.com>
 <20200516063746.18296-4-anup.patel@wdc.com>
In-Reply-To: <20200516063746.18296-4-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 21 May 2020 14:59:31 -0700
Message-ID: <CAKmqyKNeTR7_G5KkN0sh8YALYdUp6nnXPJ+9sUrrMk-_ATtSDQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/riscv: Allow creating multiple instances of PLIC
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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
> We extend PLIC emulation to allow multiple instances of PLIC in
> a QEMU RISC-V machine. To achieve this, we remove first HART id
> zero assumption from PLIC emulation.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c            |  2 +-
>  hw/riscv/sifive_plic.c         | 24 +++++++++++++-----------
>  hw/riscv/sifive_u.c            |  2 +-
>  hw/riscv/virt.c                |  2 +-
>  include/hw/riscv/sifive_plic.h | 12 +++++++-----
>  5 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 1c3b37d0ba..bd122e71ae 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -152,7 +152,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
>
>      /* MMIO */
>      s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> -        (char *)SIFIVE_E_PLIC_HART_CONFIG,
> +        (char *)SIFIVE_E_PLIC_HART_CONFIG, 0,
>          SIFIVE_E_PLIC_NUM_SOURCES,
>          SIFIVE_E_PLIC_NUM_PRIORITIES,
>          SIFIVE_E_PLIC_PRIORITY_BASE,
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index c1e04cbb98..f88bb48053 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -352,6 +352,7 @@ static const MemoryRegionOps sifive_plic_ops = {
>
>  static Property sifive_plic_properties[] = {
>      DEFINE_PROP_STRING("hart-config", SiFivePLICState, hart_config),
> +    DEFINE_PROP_UINT32("hartid-base", SiFivePLICState, hartid_base, 0),
>      DEFINE_PROP_UINT32("num-sources", SiFivePLICState, num_sources, 0),
>      DEFINE_PROP_UINT32("num-priorities", SiFivePLICState, num_priorities, 0),
>      DEFINE_PROP_UINT32("priority-base", SiFivePLICState, priority_base, 0),
> @@ -400,10 +401,12 @@ static void parse_hart_config(SiFivePLICState *plic)
>      }
>      hartid++;
>
> -    /* store hart/mode combinations */
>      plic->num_addrs = addrid;
> +    plic->num_harts = hartid;
> +
> +    /* store hart/mode combinations */
>      plic->addr_config = g_new(PLICAddr, plic->num_addrs);
> -    addrid = 0, hartid = 0;
> +    addrid = 0, hartid = plic->hartid_base;
>      p = plic->hart_config;
>      while ((c = *p++)) {
>          if (c == ',') {
> @@ -429,8 +432,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
>
>  static void sifive_plic_realize(DeviceState *dev, Error **errp)
>  {
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -    unsigned int smp_cpus = ms->smp.cpus;
>      SiFivePLICState *plic = SIFIVE_PLIC(dev);
>      int i;
>
> @@ -451,8 +452,8 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
>       * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
>       * hardware controlled when a PLIC is attached.
>       */
> -    for (i = 0; i < smp_cpus; i++) {
> -        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
> +    for (i = 0; i < plic->num_harts; i++) {
> +        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(plic->hartid_base + i));
>          if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
>              error_report("SEIP already claimed");
>              exit(1);
> @@ -488,16 +489,17 @@ type_init(sifive_plic_register_types)
>   * Create PLIC device.
>   */
>  DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> -    uint32_t num_sources, uint32_t num_priorities,
> -    uint32_t priority_base, uint32_t pending_base,
> -    uint32_t enable_base, uint32_t enable_stride,
> -    uint32_t context_base, uint32_t context_stride,
> -    uint32_t aperture_size)
> +    uint32_t hartid_base, uint32_t num_sources,
> +    uint32_t num_priorities, uint32_t priority_base,
> +    uint32_t pending_base, uint32_t enable_base,
> +    uint32_t enable_stride, uint32_t context_base,
> +    uint32_t context_stride, uint32_t aperture_size)
>  {
>      DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PLIC);
>      assert(enable_stride == (enable_stride & -enable_stride));
>      assert(context_stride == (context_stride & -context_stride));
>      qdev_prop_set_string(dev, "hart-config", hart_config);
> +    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
>      qdev_prop_set_uint32(dev, "num-sources", num_sources);
>      qdev_prop_set_uint32(dev, "num-priorities", num_priorities);
>      qdev_prop_set_uint32(dev, "priority-base", priority_base);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 22997fbf13..69dbd7980b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -585,7 +585,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>
>      /* MMIO */
>      s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
> -        plic_hart_config,
> +        plic_hart_config, 0,
>          SIFIVE_U_PLIC_NUM_SOURCES,
>          SIFIVE_U_PLIC_NUM_PRIORITIES,
>          SIFIVE_U_PLIC_PRIORITY_BASE,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index dcb8a83b35..f40efcb193 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -585,7 +585,7 @@ static void riscv_virt_board_init(MachineState *machine)
>
>      /* MMIO */
>      s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
> -        plic_hart_config,
> +        plic_hart_config, 0,
>          VIRT_PLIC_NUM_SOURCES,
>          VIRT_PLIC_NUM_PRIORITIES,
>          VIRT_PLIC_PRIORITY_BASE,
> diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
> index 4421e81249..ace76d0f1b 100644
> --- a/include/hw/riscv/sifive_plic.h
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -48,6 +48,7 @@ typedef struct SiFivePLICState {
>      /*< public >*/
>      MemoryRegion mmio;
>      uint32_t num_addrs;
> +    uint32_t num_harts;
>      uint32_t bitfield_words;
>      PLICAddr *addr_config;
>      uint32_t *source_priority;
> @@ -58,6 +59,7 @@ typedef struct SiFivePLICState {
>
>      /* config */
>      char *hart_config;
> +    uint32_t hartid_base;
>      uint32_t num_sources;
>      uint32_t num_priorities;
>      uint32_t priority_base;
> @@ -70,10 +72,10 @@ typedef struct SiFivePLICState {
>  } SiFivePLICState;
>
>  DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
> -    uint32_t num_sources, uint32_t num_priorities,
> -    uint32_t priority_base, uint32_t pending_base,
> -    uint32_t enable_base, uint32_t enable_stride,
> -    uint32_t context_base, uint32_t context_stride,
> -    uint32_t aperture_size);
> +    uint32_t hartid_base, uint32_t num_sources,
> +    uint32_t num_priorities, uint32_t priority_base,
> +    uint32_t pending_base, uint32_t enable_base,
> +    uint32_t enable_stride, uint32_t context_base,
> +    uint32_t context_stride, uint32_t aperture_size);
>
>  #endif
> --
> 2.25.1
>
>

