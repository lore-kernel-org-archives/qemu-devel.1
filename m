Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8311C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E5D206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZIpFWNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E5D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is81O-0006xG-Qg
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is80l-0006Px-D2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is80k-0006VL-8C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:28:47 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is80k-0006Uu-2Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:28:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id z9so17768864oth.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8WJbhTsTM0l8OxSV/uIB4OR8tInBfjFfl18OnoFr1k8=;
 b=CZIpFWNKSSkddyHn0xfkX3f+epSDDAvMbHfRBWgvdlTV3XTp32GimGfWhltlCnH5dg
 zwNWVLC8ODcUw0hnJ7BUb6N/6WFyzmvmTI4fxkj6+kAucL0VINZBHy/ZQPRa5LDRCIFg
 5tTMkPMIYlWcxAD/Fa1hh4uMi7e5Dzy7Tmgd0XWPEWSa8yrwHLIxEBAUGYLzgCZmU2MD
 o7p5q+c1i/Pv/OHbR9HGRgLomkRrfxiEjzMOZ6xHSbvpdYxzsDEO+Unn7aisMtITaPVf
 j0KgID6jEvnxsROKVz3yvnET9ScJc4RjaFDEsB2os6A93rD2YXDjXzFxcqBIp/2HRM2v
 Kn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8WJbhTsTM0l8OxSV/uIB4OR8tInBfjFfl18OnoFr1k8=;
 b=fnOkR8wCf3gERkzD/w9fksWmYPyCCXbXfL7jAk1xSBGoCtjK+wOyfq3Zj16KQdEsVt
 ftH/EczwsfBMyOi/7aR65+F4uqCNyG5aqrPIW80QKfn1F6+95iWk6nmuvQ/+eRLQ3XA/
 djByaqMOB9UIUhl+yF6Z5VxxwLXbFejVXW7lIoAjlLjvjxL/eKC9ONYddCtLfyvX+tI6
 UKucz8swNJggERLiAwC9qREVvPgp9uYUatKP2X2WU0nEtJCRat4FUZmmXAm83b7MBPvk
 xpQ7NKr1IoL6iWXYHy7TvXYAOTCVX3fYMN96vt1129OcLklORZZ7VkwzGhUViDQ7F4Wc
 LJaw==
X-Gm-Message-State: APjAAAWz3lycVNISFqsSmAJnz6uykGyLQ7mKL11U9jkGXtiQGd7zxne7
 aGnt7VcWxbbkFIlk6qoQx9Sn8S2EN1Jo77lQ6pg3/w==
X-Google-Smtp-Source: APXvYqzVRHK6rAR/t7eQ6rK72kuegcol5aP6HpRQ6XN1d8kQUY49Ip/TiPMoQmY8K+2LVdsvUCVlgzE6SjuScdy75g4=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr2528446otr.221.1579192125156; 
 Thu, 16 Jan 2020 08:28:45 -0800 (PST)
MIME-Version: 1.0
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 16:28:34 +0000
Message-ID: <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
Subject: Re: [PATCH v22 8/9] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 11:33, Dongjiu Geng <gengdongjiu@huawei.com> wrote:

> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> +{
> +    ram_addr_t ram_addr;
> +    hwaddr paddr;
> +
> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> +
> +    if (acpi_enabled && addr &&
> +            object_property_get_bool(qdev_get_machine(), "ras", NULL)) {
> +        ram_addr = qemu_ram_addr_from_host(addr);
> +        if (ram_addr != RAM_ADDR_INVALID &&
> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> +            kvm_hwpoison_page_add(ram_addr);
> +            /*
> +             * Asynchronous signal will be masked by main thread, so
> +             * only handle synchronous signal.
> +             */

I don't understand this comment. (I think we've had discussions
about it before, but it's still not clear to me.)

This function (kvm_arch_on_sigbus_vcpu()) will be called in two contexts:

(1) in the vcpu thread:
  * the real SIGBUS handler sigbus_handler() sets a flag and arranges
    for an immediate vcpu exit
  * the vcpu thread reads the flag on exit from KVM_RUN and
    calls kvm_arch_on_sigbus_vcpu() directly
  * the error could be MCEERR_AR or MCEERR_AO
(2) MCE errors on other threads:
  * here SIGBUS is blocked, so MCEERR_AR (action-required)
    errors will cause the kernel to just kill the QEMU process
  * MCEERR_AO errors will be handled via the iothread's use
    of signalfd(), so kvm_on_sigbus() will get called from
    the main thread, and it will call kvm_arch_on_sigbus_vcpu()
  * in this case the passed in CPUState will (arbitrarily) be that
    for the first vCPU

For MCEERR_AR, the code here looks correct -- we know this is
only going to happen for the relevant vCPU so we can go ahead
and do the "record it in the ACPI table and tell the guest" bit.

But shouldn't we be doing something with the MCEERR_AO too?
That of course will be trickier because we're not necessarily
in the vcpu thread, but it would be nice to let the guest
know about it.

One comment that would work with the current code would be:

/*
 * If this is a BUS_MCEERR_AR, we know we have been called
 * synchronously from the vCPU thread, so we can easily
 * synchronize the state and inject an error.
 *
 * TODO: we currently don't tell the guest at all about BUS_MCEERR_AO.
 * In that case we might either be being called synchronously from
 * the vCPU thread, or a bit later from the main thread, so doing
 * the injection of the error would be more complicated.
 */

but I don't know if that's what you meant to say/implement...

> +            if (code == BUS_MCEERR_AR) {
> +                kvm_cpu_synchronize_state(c);
> +                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                    kvm_inject_arm_sea(c);
> +                } else {
> +                    error_report("failed to record the error");
> +                    abort();
> +                }
> +            }
> +            return;
> +        }
> +        if (code == BUS_MCEERR_AO) {
> +            error_report("Hardware memory error at addr %p for memory used by "
> +                "QEMU itself instead of guest system!", addr);
> +        }
> +    }
> +
> +    if (code == BUS_MCEERR_AR) {
> +        error_report("Hardware memory error!");
> +        exit(1);
> +    }
> +}
>

thanks
-- PMM

