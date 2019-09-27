Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A47C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AFD217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvGA2OAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AFD217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDsxW-0004LD-1L
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqql-0000up-Vh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqqk-0000sX-DJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:03:59 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDqqk-0000sA-1N
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:03:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so2342939otb.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+Xs4DziX2kpdYgxtkDru2a37dM2G00+Xc8J5f0/eIcY=;
 b=vvGA2OAwK3UXWWsz/dwMyiuZPATgHxFnZ8CP7VqySKtzMUG86U3wJULEJ/NBfAM/aV
 +MgMT4ClJ6KmqYy4tSPMUJ27Kw8J7gnRVptQ5YleN8XHQ4kBLXByTs7o+IWMPjylOkyi
 9JnOMkxyH9KOeKZRZCiQBcO7sINXwXG7MrxZGPHZ5yq3aA+Nz+7SROUX3g7EFngJYK+I
 Xa1i6elrjT2KVKZnbSFMKmLbntkDSDOxy0v3NF0RhNbpo4MZYGFO0htirBX7omGZnqUn
 vKcHDFYOPAabn32qWt3s+pLuPmAjVDi1oPUM1YPQAnaCfiRsTVNM39aEud1a8FQQQDFm
 P7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+Xs4DziX2kpdYgxtkDru2a37dM2G00+Xc8J5f0/eIcY=;
 b=JoEiciQG8WifBccA/KelFePgVjXxtoGRfOdhT1In9AUAUSSDeXVerWQBMrUkqhO0PS
 SNKS9bI5u63ajsDQpNQWpcMqfO0oeVXMx7sUCMLbRLRfyVsKPK0TOdK9mFf/QpC3furz
 SCAykh0kuIU+Kd+DptwUcaOF5XBH3DHkjPv8ztRCju9PxAOrT8n9jRFCGe0aznWuOZjM
 YrXvajrh6xmIFelleq30MyCbucbk8G1rH0nfbxubfag7CDHRycO3x1Kw0LOKN4+1AwRe
 mBkZ074G0r4Omxk65LRlTXYLuGqvUx56d1zOBblt+er/sKI18p7pmIJ11oLN8V//UEjh
 23Eg==
X-Gm-Message-State: APjAAAXEDPTGokkc9Slu7e94u+13dF18F2LlYbVglz+6u4zlFn6I8c8V
 TzdOS9xThVAmJAUZEW+AGJA+RhlVUCbn5CcAAb5OaA==
X-Google-Smtp-Source: APXvYqxMkjxFUQFCiUWjrhvMTT61NgrlCwcj6YbcGtgfo1EaG+FY2ksLxoTuoeKN+x01eLPKSLdA7NfdTM8PjRwN8mc=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr3390754oti.135.1569593037088; 
 Fri, 27 Sep 2019 07:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190906083152.25716-1-zhengxiang9@huawei.com>
In-Reply-To: <20190906083152.25716-1-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 15:03:46 +0100
Message-ID: <CAFEAcA96W-FLfYc2MdGnn3y5Kk_D4QN4tSJv7ZgLwO7WZU447g@mail.gmail.com>
Subject: Re: [Qemu-arm] [PATCH v18 0/6] Add ARMv8 RAS virtualization support
 in QEMU
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 09:33, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> In the ARMv8 platform, the CPU error types are synchronous external abort(SEA)
> and SError Interrupt (SEI). If exception happens in guest, sometimes it's better
> for guest to perform the recovery, because host does not know the detailed
> information of guest. For example, if an exception happens in a user-space
> application within guest, host does not know which application encounters
> errors.
>
> For the ARMv8 SEA/SEI, KVM or host kernel delivers SIGBUS to notify userspace.
> After user space gets the notification, it will record the CPER into guest GHES
> buffer and inject an exception or IRQ into guest.
>
> In the current implementation, if the type of SIGBUS is BUS_MCEERR_AR, we will
> treat it as a synchronous exception, and notify guest with ARMv8 SEA
> notification type after recording CPER into guest.
>
> This series of patches are based on Qemu 4.1, which include two parts:
> 1. Generate APEI/GHES table.
> 2. Handle the SIGBUS signal, record the CPER in runtime and fill it into guest
>    memory, then notify guest according to the type of SIGBUS.
>
> The whole solution was suggested by James(james.morse@arm.com); The solution of
> APEI section was suggested by Laszlo(lersek@redhat.com).
> Show some discussions in [1].
>
> This series of patches have already been tested on ARM64 platform with RAS
> feature enabled:
> Show the APEI part verification result in [2].
> Show the BUS_MCEERR_AR SIGBUS handling verification result in [3].
>
> ---
>
> Since Dongjiu is too busy to do this work, I will finish the rest work on behalf
> of him.


Thanks for picking up the work on this patchset, and sorry it's taken me
a while to get to reviewing it. I've now given review comments on the
arm parts of this, which are looking in generally good shape (my comments
are all pretty minor stuff I think). I'll have to leave the ACPI parts
to somebody else to review as that is definitely not my speciality.

thanks
-- PMM

