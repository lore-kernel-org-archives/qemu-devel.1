Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C32C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6062073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woYkD56T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6062073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8Ca-0008Rf-7W
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1is8Bq-0007uJ-Jj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1is8Bp-0004yz-9G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:40:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1is8Bp-0004xm-34
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:40:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id h9so19882797otj.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nYAUE2nnyeDshvTu7pIzpU64iJrg7qrenO7ys1Dxxjw=;
 b=woYkD56TT4VCIBc2vrqR+aUhpmqUXOPywHLUbQE8IDLw8Ne8bFBNNiIDStDHO92/Mw
 OAKZmwTTwde7sQUxx6xfA57WzItiAmlyjhOtolgvJnpNR6p8JGYPpQNYwh+1g8lMKdx3
 wfFNwNOLXi54UWK3roQaPN9ydHyIem3V2IUsetxsMeY0yphOUZW5GxzD3HdTTi5iYObA
 g4OXDIAGacflRUUce6S3FXSlnu52xNQjnNDEBdogFYwMfVdpGIm9eAJpvU51kIu2UudN
 6QDYmNF4cT8aRFyPTqTou8oX8p7ATScsqEkY/ybU71fhxxg/BEhfmQAn/GOqDjb/GPmw
 ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nYAUE2nnyeDshvTu7pIzpU64iJrg7qrenO7ys1Dxxjw=;
 b=K3pG4WRAltUSi7fVYHk7MBDFPsrayOD9Zqhi7xR4iOea/Rz1PlTLmgNcq6QHBaisnd
 /zF+aS1fmZ20fe0TPaTfvuP8UQ3FfCvHrNwJAXOfs/WT6nqmJdSgvQK4nSLnmmH8FEww
 JxVxNvcCXErveqqGLnm1cJrn12BUaj68Q6nH0hzCB2LQLMMUqzgWbyXf66pW/CSud867
 ZzDpHEn6hscohGIq2FOdqC8uV/jRdI9ho+31SlkIYQ6u0tGx1IicI0q2BPs620BJcxxl
 mDDC1XZ515SobLCuBpolSayIEjSI/rQH5Piz8MNwL4oxYyvCfmscVY8v9VUUzA4kWi9e
 VVYA==
X-Gm-Message-State: APjAAAVPnIxSSPdlPQTVtAMFh4DYO2vWjRSrS/rRKI0uLj3Nt3jJ4mf3
 4qw5YoOv8Ac64utr0Du2ypcmhq30cE7uYxiyKkbTwg==
X-Google-Smtp-Source: APXvYqx/emCu+rrCc6WG6o6dKNsnHDt6h8pMhVbFZ6t7fFuXEEJhoMyAfWCqWNoLl5KtNLC8zD9IL7H2fgVXXxDJ9qs=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr2574132otr.221.1579192812062; 
 Thu, 16 Jan 2020 08:40:12 -0800 (PST)
MIME-Version: 1.0
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-9-git-send-email-gengdongjiu@huawei.com>
 <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
In-Reply-To: <CAFEAcA_=PgkrWjwPxD89fCi85XPpcTHssXkSmE04Ctoj7AX0kA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2020 16:40:01 +0000
Message-ID: <CAFEAcA9tFcsMrX8_VQwh1P4h3BcwpLoo2h6COHBdQaK=0CoL5g@mail.gmail.com>
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

On Thu, 16 Jan 2020 at 16:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> This function (kvm_arch_on_sigbus_vcpu()) will be called in two contexts:
>
> (1) in the vcpu thread:
>   * the real SIGBUS handler sigbus_handler() sets a flag and arranges
>     for an immediate vcpu exit
>   * the vcpu thread reads the flag on exit from KVM_RUN and
>     calls kvm_arch_on_sigbus_vcpu() directly
>   * the error could be MCEERR_AR or MCEERR_AO
> (2) MCE errors on other threads:
>   * here SIGBUS is blocked, so MCEERR_AR (action-required)
>     errors will cause the kernel to just kill the QEMU process
>   * MCEERR_AO errors will be handled via the iothread's use
>     of signalfd(), so kvm_on_sigbus() will get called from
>     the main thread, and it will call kvm_arch_on_sigbus_vcpu()
>   * in this case the passed in CPUState will (arbitrarily) be that
>     for the first vCPU
>
> For MCEERR_AR, the code here looks correct -- we know this is
> only going to happen for the relevant vCPU so we can go ahead
> and do the "record it in the ACPI table and tell the guest" bit.
>
> But shouldn't we be doing something with the MCEERR_AO too?
> That of course will be trickier because we're not necessarily
> in the vcpu thread, but it would be nice to let the guest
> know about it.

An IRC discussion with Paolo came to the conclusion that
the nicest approach here would be for kvm_on_sigbus() to
use run_on_cpu() to call the whole of kvm_arch_on_sigbus_vcpu()
in the vcpu thread for the cpu it gets passed. Then the code
here would not have to worry about the "not on the right thread"
case. This would be a refactoring of the x86 code, which currently
does the run_on_cpu inside its implementation, in
cpu_x86_inject_mce().

thanks
-- PMM

