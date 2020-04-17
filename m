Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9B8C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D9820B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC7Yj10K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D9820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPR7Y-0005lg-NZ
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPR6n-0004rr-3r
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPR6l-0006SS-Te
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:32:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPR6l-0006Rz-Ke
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:32:39 -0400
Received: by mail-ot1-x342.google.com with SMTP id c3so1394878otp.8
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Fwc+6Mwwqh7DLXhvjwR3QXK3J1CjVqSulYYfvjFl8X4=;
 b=XC7Yj10K2YbNqP0Op42aczXxU2SVnP+I7j8RdrbXcaV5FrlnBhYCcPR0Sh738Wvr5G
 tX+0dH039S9FzwTiVSAsytcPCgzUcYYm76hyTG7zlmnv6059MBXCWiSawyE613uFITUK
 ZjhDl5JN181/yMQnE3hRDxqu0FTU8O/CDjX7fWz9SWilP1NDaMfgOeUgjWSZEmSP3dMw
 Q9TRLPFoewDvArnMtORImP9bSQsuGI99WIpd7zmv4XR6st2uUAKY8ji0FcfLFxqW/VKA
 wA5BW8HHlVZciS8/OWB8pkWP1SPZK7hKLzZQXE5RaM4lD6B0zmaViU50kAkIbzOlT7rU
 4zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Fwc+6Mwwqh7DLXhvjwR3QXK3J1CjVqSulYYfvjFl8X4=;
 b=MEWv9M62AUXpzCyOhA1a4h8JaM/Xw8gGYfWyJpblhd7y+FyjDgNIA0zijPI5yuXkom
 XHhsmZxyS5ePKAI7Z8kX52GP+f0/z3LS59wyUwtB1GCiwMyXxyNmyT7D3jNv3x5KBzhj
 0pR2BH4Q1uFutGRl0qgESNYZy+TuQQVmzPfUsf99OITimLEIFCH+Mgsv/QeA3AfaPl5U
 y7srCmNdAW8j4mLBxtp9vVOY+fHqLdnLuiuyQKWEzW1Uciwo7pkPqt+J6QiDDJyJgzYt
 PvYPTFvMZjg47UQSEL0rNrzBpG9fBQzV9xIGyW6Uc6iuXYH39HuXBZ/2qh7pTjHp6vDC
 FznA==
X-Gm-Message-State: AGi0PuZzezf4Y0ScTE7d9qEsHuyG8uAJZpSjjz42UDHYL2B34HgZzWhv
 nciyOdRmDpGMmYgOEgkM5uR4BCwnv7hoHJ8+tnhRRg==
X-Google-Smtp-Source: APiQypJ1LUCZ73GGjz1B9eI/M746O3mpnpKIp/F2JG5itGR86qXuxUSBx5/6zNG8wtVspr+Jpg19hI9l1tzgcHwfQrk=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr2492560otj.91.1587130358818; 
 Fri, 17 Apr 2020 06:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
In-Reply-To: <20200410114639.32844-1-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 14:32:27 +0100
Message-ID: <CAFEAcA9oNuDf=bdSSE8mZWrB23+FegD5NeSAmu8dGWhB=adBQg@mail.gmail.com>
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 at 12:46, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> In the ARMv8 platform, the CPU error types includes synchronous external abort(SEA)
> and SError Interrupt (SEI). If exception happens in guest, host does not know the detailed
> information of guest, so it is expected that guest can do the recovery. For example, if an
> exception happens in a guest user-space application, host does not know which application
> encounters errors, only guest knows it.
>
> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> After user space gets the notification, it will record the CPER into guest GHES
> buffer and inject an exception or IRQ to guest.
>
> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> notification type after recording CPER into guest.

Hi. I left a comment on patch 1. The other 3 patches unreviewed
are 5, 6 and 8, which are all ACPI core code, so that's for
MST, Igor or Shannon to review.

Once those have been reviewed, please ping me if you want this
to go via target-arm.next.

thanks
-- PMM

