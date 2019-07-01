Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB4AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0CB214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAtQLg79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0CB214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhv4Z-0002u6-Ac
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv0Y-0000Xd-Du
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhv0S-0007yA-V2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:02:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhv0S-0007wm-OH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:02:00 -0400
Received: by mail-ot1-x343.google.com with SMTP id d17so13223035oth.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mjliL6SGD7W1mzlrS/SGIU2L53Tm1xC2mwquCwVdnAg=;
 b=kAtQLg79yqP8rfCNjn58girppAbLKYpuAHzC81rJfGt9etH000zegyjDgkfkd0rCj0
 hcMy26SDIcE3cDPnAueIRHDfIkqCQZq94euymcu954wfKun9sh3GicYBR5kLCULAFGyd
 7bBIhJs6Uqm1XIWtj9CcEfnUJ2l4asIPvD4105uC+GSOcwXa5jzAGrAMWziBFlUN0Usq
 HmgtMVDa0LK9n9CIjBIDKtbSkaDLBuqeWAtzfeoNBtmsbMCK5mDlexa0CeB2J5MMmU9v
 ZY4ZHspxtPtqb44tNCAvZNC5RpuwvSpUpzLZZq8zjvubZW4p4t69m7eYT3d68vkPvFFd
 cOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mjliL6SGD7W1mzlrS/SGIU2L53Tm1xC2mwquCwVdnAg=;
 b=I2R6xi+xbBo/Nw1QO1Jvko+GVQtsv2lGClpJ0uoW3P1dFZ9aYT9666A9NLC2b0Kk3q
 lpW06F8WGystjlZoZpwDo4E5qRUk7XB5ZFBlLmqOpIxhpLIWzRPMDIySFv5uuyEhBufj
 vjFwVJhq2suI87A4nVOpJfN1qFRa0dLTV0IUpOAu3MEomJR4J35gacPi7V1urYyXiy4W
 1PHB9dSOLxrTlor3a+kE+5zPqQOM90XGUxBHVXcI6QYV108Vlj6VjCowfhTXSGNOKba+
 OqQVECeX7+tGY8UPjVeru6+MM4d5IjGHE4vcqKwuqGRRnXU6F5iuSdxmIdXsvNtmftgB
 NYyg==
X-Gm-Message-State: APjAAAUDrXsd0E6yutzx4LabyBcIrQZqKdmc7My6QD5NTQxtDjLi8jgF
 PogaaOpirDr492AWa1ucEdJUPRMvjXK4H3WE/YawPg==
X-Google-Smtp-Source: APXvYqxLXfzD7ULcJbz9fYHUZvUCTG+XVZ1dGgs8TUGqz1DVsQyyw5Vi0crch06wbaCWdJ5T1GPYVGWO5rJVq5sZO3M=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr19993893oti.91.1561982519462; 
 Mon, 01 Jul 2019 05:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
 <20190416013902.4941-6-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-6-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:01:48 +0100
Message-ID: <CAFEAcA9hGvpafJkVS3o+n=4S_=UyZ=iz352L5DtCkit5bvysCQ@mail.gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 5/5] i.mx7d: pci: Update PCI IRQ mapping to
 match HW
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
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Apr 2019 at 02:39, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Datasheet for i.MX7 is incorrect and i.MX7's PCI IRQ mapping matches
> that of i.MX6:
>
>     * INTD/MSI    122
>     * INTC        123
>     * INTB        124
>     * INTA        125
>
> Fix all of the relevant code to reflect that fact. Needed by latest
> Linux kernels.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---
>  include/hw/arm/fsl-imx7.h | 8 ++++----
>  hw/pci-host/designware.c  | 6 ++++--
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Compare Linux kernel commit 538d6e9d597584e805146 from an
NXP employee confirming that the datasheet is incorrect
and with a report of a test against real h/w.

thanks
-- PMM

