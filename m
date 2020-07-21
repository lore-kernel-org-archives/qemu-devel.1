Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8A7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7428A20729
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOWOX2lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7428A20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxp7Q-0002wx-Q0
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxp6i-0002Be-VN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:02:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxp6g-00076q-Go
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:02:44 -0400
Received: by mail-oi1-x241.google.com with SMTP id h17so16737133oie.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=awL/01hPpP9Z7+laZvrYGFEzbSimdAKZH1G/PVXrNcY=;
 b=nOWOX2lqQUoza4SnwynYKi8vxQHOn7GDGEkruQcAay87WpARypl3Nk+C4w/WOG4gOp
 13197TNvSCTJkVhSg4PKP8mh/mv+nF47dNWU9U47gAoQlpic9iWlejyzXqBhyLkrxRkx
 JrbBdhMcxEJsmLlwMfXIrgYFFtFylzM+ma+1M8Z1C4UWCbAK15SI51itcYC3qxclia7+
 2ZT9rz50/rl9aDTioHo9SfjYmcAWS5FF7oVTORSFcrPHok1RT++xoxzd8jZsj6sgnUsl
 IY1P13SUj++j2lcVar/Vc2dCanc0D7fQa0O2yiNixf+C2r+EOEMD3sK8bwVz9VeMqR24
 T5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=awL/01hPpP9Z7+laZvrYGFEzbSimdAKZH1G/PVXrNcY=;
 b=LT+yjkoWUS0uShrDlp4nYtC0HdHMVCnDKgn7T3KMtpRpSizzAUHB78P5edbPeQcsMh
 3smkUZHQDHRQ5WnMeze8qm5vNvsL0nMpsn0gXXgSmtk0EABS8rfIMyKmc3+GIXu0NYpj
 oGwGdx9p2K6Qw0mo5Vg/0LeskDttDLs9ZT8tE5XfhjNW+YOF/ogOoXyaW6fR6YfNEUGK
 cmaqKHZc3Ldi57ZCLNys2c+X0YD1nM+IBdPrCtVzecGhAp0EUzFIYlp/skt0Zm7bcYhz
 3FNNTgCmaopOUoMGZQGgMq74sGpzWPDm3pQ/IYmaye9vC0qHlH4M3J+IudKiY+kYWDsS
 Hbug==
X-Gm-Message-State: AOAM530tRRCpP8xZdTKZOnVEkITnVdpUpaZU+Vp27zsTd9CfVD8nRvOH
 kV4+THJKlA4irM8+q7B8um8iKgT0rmO5RoYkdPAW+Q==
X-Google-Smtp-Source: ABdhPJxGByaDr6QmoRvii6wtJ79s61j+UfehF4QH2eUjniFYStS43KAGDBF5LKCmOvS+W9S5H7KrWm307d0ADVB9ke0=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr2364625oib.163.1595325761221; 
 Tue, 21 Jul 2020 03:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200711101033.47371-1-drjones@redhat.com>
 <20200711101033.47371-3-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-3-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 11:02:30 +0100
Message-ID: <CAFEAcA93VMoQxPSvk7YNkkbXhrFufuFN8R9Sqjj6C97Xz2buvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
>
> Move the KVM PMU setup part of fdt_add_pmu_nodes() to
> virt_cpu_post_init(), which is a more appropriate location. Now
> fdt_add_pmu_nodes() is also named more appropriately, because it
> no longer does anything but fdt node creation.
>
> No functional change intended.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cb2fa99b1ef5..63ef530933e5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -521,30 +521,15 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>
>  static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>  {
> -    CPUState *cpu;
> -    ARMCPU *armcpu;
> +    ARMCPU *armcpu = ARM_CPU(first_cpu);
>      uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
>
> -    CPU_FOREACH(cpu) {
> -        armcpu = ARM_CPU(cpu);
> -        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> -            return;
> -        }

So previously we would say "if the CPU doesn't actually have
a PMU, don't put the PMU nodes in the FDT", but in the new logic
it looks like we put the PMU nodes in the FDT unconditionally ?

> -        if (kvm_enabled()) {
> -            if (kvm_irqchip_in_kernel()) {
> -                kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> -            }
> -            kvm_arm_pmu_init(cpu);
> -        }
> -    }
> -
>      if (vms->gic_version == VIRT_GIC_VERSION_2) {
>          irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
>                               GIC_FDT_IRQ_PPI_CPU_WIDTH,
>                               (1 << vms->smp_cpus) - 1);
>      }
>
> -    armcpu = ARM_CPU(qemu_get_cpu(0));
>      qemu_fdt_add_subnode(vms->fdt, "/pmu");
>      if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
>          const char compat[] = "arm,armv8-pmuv3";
> @@ -1678,11 +1663,23 @@ static void finalize_gic_version(VirtMachineState *vms)
>   */
>  static void virt_cpu_post_init(VirtMachineState *vms)
>  {
> -    bool aarch64;
> +    bool aarch64, pmu;
> +    CPUState *cpu;
>
>      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> +    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
>
> -    if (!kvm_enabled()) {
> +    if (kvm_enabled()) {
> +        CPU_FOREACH(cpu) {
> +            if (pmu) {
> +                assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
> +                if (kvm_irqchip_in_kernel()) {
> +                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> +                }
> +                kvm_arm_pmu_init(cpu);
> +            }
> +        }
> +    } else {
>          if (aarch64 && vms->highmem) {
>              int requested_pa_size = 64 - clz64(vms->highest_gpa);
>              int pamax = arm_pamax(ARM_CPU(first_cpu));

thanks
-- PMM

