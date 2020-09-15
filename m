Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0157C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41735206C9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ysfZ5tAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41735206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI53D-0003zW-Ac
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI50L-0002Mz-06
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:03:53 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI50I-0001f0-KG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:03:52 -0400
Received: by mail-io1-xd42.google.com with SMTP id z13so2898692iom.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LZV+LKtuke5ktqAOa6s8VZ03TBrNFczJt3tAnhtD+fE=;
 b=ysfZ5tAjrSHaQPrWuSGyriIftNKNgVLkh4zDDHvVURWNrJB5OL/bO77qBhBQJIbeyb
 o/icB97SrXyzaKJHD/ECXWWHUUA3xbfra83LFBzbhigw6ldfVUIx7X5lKg2RunnhHPVd
 x8dQD6bpV06qE4rV7X0TubdnMwsz5xOy/7Gs//2DII5FGCh7dhtbUIcNyDy6MvDuwFfl
 gAitivQoKS6fgMrQ1oLKHnPR/tbLEn6zJ2X3A7n4bogoouXH8CwbeAxSegaEo7sV+qby
 upc7bIfbfJKL/UBqkC14pAPuwUdRiXV3Oa8zW1KN5ceJ76dyaesguIWThfD5vTVPSqLF
 dgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZV+LKtuke5ktqAOa6s8VZ03TBrNFczJt3tAnhtD+fE=;
 b=qp+YlAvzR/8Ebv7rJ4qGPOtnuTpiqpzQgvbcrNpssJeDMP96t44pGdkVGCvfcbkTDm
 V0DmufXwK4z6+7mcXVzNTgdR/xdDGI5wt0JQ8oCtC2CFpPhCg9V5WQ24rQ8MYhxBhaaB
 O2r2Wl/85ZyORjxie56A+/JEEAZEHQZJA3GTS/TYZDuf2Cf+bztMfvYHDIat18HnfONd
 OlFFADX2j+ejyxNB1gBBn7KtIsNR7moSbl0Z0JIz40L7pY3w9u7LIfrPTYESFgEIhO/d
 7tVYd235DhFU46srmlAlw82vXYmrW/boQYq415H9Wrn/rMz7z182Cwf5RB2Kk69Wes8B
 W4rA==
X-Gm-Message-State: AOAM532s/iyAN4eW2KGCnmv0jtsAJk3Kh4/TPpbdLv9/xHlypTvsNHcO
 N7c/hzetBzbhhU4v7xFl105MpUTFacyGsJFjrpRx
X-Google-Smtp-Source: ABdhPJxdoS8Yj33fZq2ZYbQOrZ6G/xQu7dts9iCP37OU/00s+fB4yAoo9U0fCHK6e/GMQKifFCML1gZxsm2WNq3bBss=
X-Received: by 2002:a05:6602:22d3:: with SMTP id
 e19mr13915602ioe.197.1600153429358; 
 Tue, 15 Sep 2020 00:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600135462.git.haibo.xu@linaro.org>
 <20eedb95441ecec7b23527cde78aa5b63c67b400.1600135462.git.haibo.xu@linaro.org>
 <20200915062219.dtnl6p3nan76xvv7@kamzik.brq.redhat.com>
In-Reply-To: <20200915062219.dtnl6p3nan76xvv7@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Tue, 15 Sep 2020 15:03:49 +0800
Message-ID: <CAJc+Z1Gk2pjiaMKxohj80x1YkvTw4eNW7BZxp_ztsF8E68pYeg@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] hw/arm/virt: Move post cpu realize check into
 its own function
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd42.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 at 14:22, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 15, 2020 at 03:11:43AM +0000, Haibo Xu wrote:
> > From: Andrew Jones <drjones@redhat.com>
> >
> > We'll add more to this new function in coming patches so we also
> > state the gic must be created and call it below create_gic().
> >
> > No functional change intended.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/virt.c | 38 ++++++++++++++++++++++----------------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
>
> This still isn't the right version of this patch. You need
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg727591.html
>

My fault! Very sorry for forgetting to address that in this version.
Shall I re-send this patch with the fix? Or fix it in the next version?

> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 3f6d26c531..2ffcb073af 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1672,6 +1672,26 @@ static void finalize_gic_version(VirtMachineState *vms)
> >      }
> >  }
> >
> > +static void virt_cpu_post_init(VirtMachineState *vms)
> > +{
> > +    bool aarch64;
> > +
> > +    aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> > +
> > +    if (!kvm_enabled()) {
> > +        if (aarch64 && vms->highmem) {
> > +            int requested_pa_size = 64 - clz64(vms->highest_gpa);
> > +            int pamax = arm_pamax(ARM_CPU(first_cpu));
> > +
> > +            if (pamax < requested_pa_size) {
> > +                error_report("VCPU supports less PA bits (%d) than requested "
> > +                            "by the memory map (%d)", pamax, requested_pa_size);
> > +                exit(1);
> > +            }
> > +        }
> > +     }
> > +}
> > +
> >  static void machvirt_init(MachineState *machine)
> >  {
> >      VirtMachineState *vms = VIRT_MACHINE(machine);
> > @@ -1890,22 +1910,6 @@ static void machvirt_init(MachineState *machine)
> >      fdt_add_timer_nodes(vms);
> >      fdt_add_cpu_nodes(vms);
> >
> > -   if (!kvm_enabled()) {
> > -        ARMCPU *cpu = ARM_CPU(first_cpu);
> > -        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
> > -
> > -        if (aarch64 && vms->highmem) {
> > -            int requested_pa_size, pamax = arm_pamax(cpu);
> > -
> > -            requested_pa_size = 64 - clz64(vms->highest_gpa);
> > -            if (pamax < requested_pa_size) {
> > -                error_report("VCPU supports less PA bits (%d) than requested "
> > -                            "by the memory map (%d)", pamax, requested_pa_size);
> > -                exit(1);
> > -            }
> > -        }
> > -    }
> > -
> >      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
> >                                  machine->ram);
> >      if (machine->device_memory) {
> > @@ -1917,6 +1921,8 @@ static void machvirt_init(MachineState *machine)
> >
> >      create_gic(vms);
> >
> > +    virt_cpu_post_init(vms);
> > +
> >      fdt_add_pmu_nodes(vms);
> >
> >      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> > --
> > 2.17.1
> >
> >
>

