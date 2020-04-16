Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CBC352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED4C20786
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S75OjJEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED4C20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP56v-00064U-00
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP569-0005XD-0E
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP567-0007ux-Fv
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:02:32 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:42905
 helo=mail-oo1-xc44.google.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP567-0007tZ-3j
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:02:31 -0400
Received: by mail-oo1-xc44.google.com with SMTP id e18so666552oot.9
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bK7H8mZBC1M9jaa+zdop9zDdD2J3ilKiMpcnXRm9/wc=;
 b=S75OjJEUYpb6Z8Ok91mLrz3lPxofemMNkAQA1i3r6UhQPpDgwDrlfyGb/w8paViyEC
 rQZ0Y39Y1slvIdhcQTdZSJL1qwTFYQRRrjpkU8AjNAcAj1ncnYW9ndpkOVmqMKLRjE0g
 AWuGETJV2o92M9d8JNUDAjw1xnE0JRg1jV4awo8ocR3quYZus/2zojs8IYyEqXToEWwW
 NvKRf8jYYN7Y3M8mkS//cwpUH34XwsEiHhXEGb4O3YLXd9qp8tdGiInT74KWH25l+bax
 xtv701IBjfmMe9ma7ZFjukFwgas2g34GXpaxLXBPwkkY61L5/GraJPoZO+PacRZnvxko
 a9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bK7H8mZBC1M9jaa+zdop9zDdD2J3ilKiMpcnXRm9/wc=;
 b=CaogaZFQZPdDGOxeqsQn4+2qloKQ7Tp4t6xSErPkNq/puGLuR/yKSkuDyGYxhanIV7
 M6d5k5HNWzoGMXHkMhhzAuykjWqNAajF7O2WdopIUjCxr3MsZmCWlSqQi3ISUaXdQhMw
 zpuqCeB5G9H8ZMNMdUeRlzYNkPpd1cVGgG/oh6bY67A1frAZo7AhWaHPNpJQxupS3+BC
 rxZtE63zA6UY2sp319Q0VBJGepGXf1wn4JCRN0uIsXbiMrC3bSEqLsucBM8UsH5kD8Xk
 A32uvgYfprd1kAfBJZluJg4NKe6mEx5oU3n5UA6WsShTF/5wc5bvNEDusPPe7duG8jVk
 3Dbg==
X-Gm-Message-State: AGi0PuYHWzjVP5pA7jEuT9x+IRzAXH2VZRh3CRHA4aC1AALtNg0HU/Ex
 B5hXu+5W7XUFRiD9a8EDY3YvAOyTRkbFxw5QlHxrOQ==
X-Google-Smtp-Source: APiQypJUJwn9q949J4jXdUe6aFPBX8YziM8R4GhLsgRIYP8spb1sUXkLRxFdfswJKyD7fWYk3R9w9fp+kZdyZVRdRGQ=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr26704869ooi.85.1587045746654; 
 Thu, 16 Apr 2020 07:02:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <5e9863af.1c69fb81.dbe22.5caaSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5e9863af.1c69fb81.dbe22.5caaSMTPIN_ADDED_BROKEN@mx.google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 15:02:14 +0100
Message-ID: <CAFEAcA_-fcGUKoo955jeHzNDDVTKCsgvH6QGqUWu0efAyth1rg@mail.gmail.com>
Subject: Re: [PATCH v25 00/10] Add ARMv8 RAS virtualization support in QEMU
To: gengdongjiu <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: fam <fam@euphon.net>, "xiaoguangrong.eric" <xiaoguangrong.eric@gmail.com>,
 kvm <kvm@vger.kernel.org>, mst <mst@redhat.com>,
 mtosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl" <shannon.zhaosl@gmail.com>,
 "zhengxiang \(A\)" <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, pbonzini <pbonzini@redhat.com>,
 imammedo <imammedo@redhat.com>, rth <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 14:54, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> ping....

Hi; this is on my to-review queue, but so are 25 other patchsets.
(I've built up a bit of a backlog due to concentrating on work
for the 5.0 release while we're in the freeze period.) I will
get to it eventually if nobody else does first...

thanks
-- PMM

