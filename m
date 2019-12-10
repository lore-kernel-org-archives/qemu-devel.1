Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4C1C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F3C2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 15:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuFGnYt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F3C2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iehr5-0008KD-8L
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 10:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iehqB-0007av-V3
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iehqA-0008JF-RG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:54:23 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iehqA-0008Iy-LZ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 10:54:22 -0500
Received: by mail-oi1-x244.google.com with SMTP id a124so10186725oii.13
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qkvXH55G+iv0yZ4areBM4JInh6uKCzUpqm+YCgqvJbg=;
 b=KuFGnYt/t268MsTXofoQshaYJr/nAShbCt+AOCnnzl96R8uRChzhjFXZN5CMtqb7Xr
 pxY21NtQsyPc8qWeSj36a/J7SC56DecORnLahkTeDyelNgVzR8wtuLGlvptJLsT1DWnY
 b+37dw4vio4cT+HWLqfeh+BTveDbM/SkVpXUtH+gdvfEuJcquhdK/8O9UF2iA/Jr5onx
 OsIhWk+j3bD7fxvViXxNgHWZN2+7n5hzdwHT1lDLjXeNrqTqd0MpYE6ADUTDAYATeM6Y
 GYx/j74CL0yipW+ERJ5B/GRI+HakWcD9/S+FgHXY5Ae4woqoc+itArFHecIwL3MtLEx2
 15Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qkvXH55G+iv0yZ4areBM4JInh6uKCzUpqm+YCgqvJbg=;
 b=SwPFA8bz8q3XPtVZs/utBoVikAo4xLFyOpkW+ucrxRTiFIiu14Ca8vxLncHAzESa4V
 1LfSHnTb+S3ODKJAJ73dQPo51jdw8wwczMR6GBgplq/BwnpuChJwaIVROBmqhl0lBcti
 Uz04p0/bhDbTpLV66FwZuY16IRgXvDIzg++7R3Q/5O8m9Zo77KzRsYQgQh/0gnRbiCuv
 OZON93uyNS+t0msl4jSmGRkft3Oc5D9NIiGWL43Nx1MQIhcG0F3/1lYw8rB4qZNzzX2L
 qVrCZBA0hVxoNtPy1rYddezgBgWjN5TRIoE/Ckq+aPUHX/CDzmyDNs6Eu9bGDLeyLOWo
 c+4Q==
X-Gm-Message-State: APjAAAUStJaXQUsxhNVUwYHo1xoEu5af/VzA4n+M6QaOE7d6u9hys+6O
 E28urUIejI4NTHq0dhutVLVfDyXG0tilEVwiKbgAbQ==
X-Google-Smtp-Source: APXvYqxlLGNk8aLVogO0zZkyoe+jfnwIR09cEFRD/p9gfWAP77vgqEJcSYX924cfMdQy/KubluT2raGTjGSR2xd8veI=
X-Received: by 2002:aca:3182:: with SMTP id x124mr4651766oix.170.1575993261791; 
 Tue, 10 Dec 2019 07:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191016143410.5023-4-drjones@redhat.com>
In-Reply-To: <20191016143410.5023-4-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2019 15:54:11 +0000
Message-ID: <CAFEAcA-uP9eAMu=S98hv7Ge_3GU42acpfvWDMmcMSKagnD9rsQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] target/arm/kvm: Implement cpu feature kvm-adjvtime
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Marc Zyngier <maz@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 15:34, Andrew Jones <drjones@redhat.com> wrote:
>
> When kvm-adjvtime is enabled the guest's cntvct[_el0] won't count
> the time when the VM is stopped. That time is skipped by updating
> cntvoff[_el2] on each transition to vm_running using the current
> QEMU_CLOCK_VIRTUAL time. QEMU_CLOCK_VIRTUAL only ticks when the VM
> is running.
>
> This patch only provides the implementation. A subsequent patch
> will provide the CPU property allowing the feature to be enabled.


> +void kvm_arm_set_virtual_time(CPUState *cs)
> +{
> +    uint64_t cnt;
> +    struct kvm_one_reg reg = {
> +        .id = KVM_REG_ARM_TIMER_CNT,
> +        .addr = (uintptr_t)&cnt,
> +    };
> +    int ret;
> +
> +    cnt = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
> +                   cpu_get_host_tick_frequency(),
> +                   NANOSECONDS_PER_SECOND);
> +
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        error_report("Failed to set KVM_REG_ARM_TIMER_CNT");
> +        abort();
> +    }

The commit message (and the doc comment for this function)
say that we're updating the counter offset, but the
kvm_one_reg operation here is updating the timer count
(and relying on the kernel's handling of "if we update
the timer count implement that by changing the offset").
That seems a bit confusing.

Would it be possible to implement "cntvct should not change while the
VM is stopped" with "read cntvct when the VM stops, and just write
back that value when the VM is restarted", rather than
"write back a new value calculated from QEMU_CLOCK_VIRTUAL"?
If I understand commit 00f4d64ee76e873be8 correctly, that's
basically how x86 is doing it. It would also let you sidestep
the need to know the tick frequency of the counter.

thanks
-- PMM

