Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB5CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA1E20869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdMQUklI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA1E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagN1-00049O-C0
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iafcR-00071K-6p
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iafcP-00084o-01
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:43:30 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35958)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iafcK-0007xe-Bv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:43:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id c16so3823951oic.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 04:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qxAHFu+3cqO2839SH/Af/vJRTg8BAmcYc9dW3TUL0z8=;
 b=rdMQUklIhBjdmOSi73uUyFjW1XKXPSfEomjc0wae6K4M+XOO0bhRWASGctCx3gE7EH
 dNpVyJJ1LkLWDUex35IZZyAwGEABcPPsv8CwSJ4I0U0gv202U49MX1z5iBKOhuKQRUbM
 hNzHZJu9y8Z+8iRSn1ezq7kPdi2S6UIhkbi7DN085QbEADVr3eHR0quUazu6vOYfeFiT
 BP1tL2VNvX0TYroM4IiRdhZYKPRYgZpnebN3WSo5WYnzHsCjJOY9wsm+t8ImjZtKyIay
 M6yS6IfcGx+Rx2VrSTP142SCl3NvJ2eu68HC9dPoyiHrP1aFTWYM83VluTNAWBB71Azn
 aV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qxAHFu+3cqO2839SH/Af/vJRTg8BAmcYc9dW3TUL0z8=;
 b=FgBhN4EFQ75CoaI6GWn26Ih4ErRjVDqOkw9MOI36MsaChyOO5vdQ+JP6+5OA0ToF8g
 IEmCaErhddzRXas9MRW+Rnt+e/bhUOm0jje+R3lJWEv0HYfV2Sm8ESbb363530NTSw+w
 IbKP9foPEqOYlCUoRfQfk3jnM8snEuYc8a4IjS5tjIt6+AnwPV9Q46zLYKWIbl+DHaAU
 6PYLyg2rXazkAxabG3zEJUnCzCssPrwhrhVfswKTfErGoOojYdRTQT5er/gtzY5vto5h
 3iSjU5zLfkMHInb5e7XwK+f8Iby14nPNHdE2BYKp1FMQ8GWqWQylTduf56A4TWuldpZ0
 AYog==
X-Gm-Message-State: APjAAAVG+8ZM/qsXJGFKPYwY1E3ZZ/oItfbje76nHP7qBvI/FZWuURw9
 SRNYYsYLlQn4cK1W9qH0mHzbfnhaNdja+1Pwuvn2yQ==
X-Google-Smtp-Source: APXvYqxxtEPhNW9hbGxa5Ro5RyWG7o9j44fE59I5V36IGOGzyIB+sWuKRcsmzGeXuimMAipIIQB/erF1bFReaN5j0Ss=
X-Received: by 2002:aca:f484:: with SMTP id s126mr9518142oih.48.1575031396192; 
 Fri, 29 Nov 2019 04:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20191129100835.21734-1-thuth@redhat.com>
 <CAFEAcA8J4tJfa3-m_Lf4TUs6yvycp5v4umo8zp6-Cck6ACk=MA@mail.gmail.com>
 <f5203ce4-6684-42f5-8cf2-c5e2a54b5947@redhat.com>
In-Reply-To: <f5203ce4-6684-42f5-8cf2-c5e2a54b5947@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 12:43:05 +0000
Message-ID: <CAFEAcA-g9HNCx_4XSeSLgmOQeq0FxZOp5LRKwnmTkgKH3g1tVg@mail.gmail.com>
Subject: Re: [PULL 0/2] Fix for the s390-ccw bios
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 12:08, Thomas Huth <thuth@redhat.com> wrote:
> without the fix, certain boot scenarios break:
>
> - "-boot menu=on" does not work anymore.
>
> - It's not possible anymore to specify the s390x-specific "loadparm"
>   option (can be used e.g. with "-machine s390-ccw-virtio,loadparm=xyz")
>   This is e.g. important for booting alternate kernel that are installed
>   on the guest's hard disk image.
>
> The fix is just a one-liner, has been reviewed and tested by multiple
> people already, so it should not cause any other regressions.

OK, that sounds worth fixing.

> I think you could merge it also without doing another RC next week

I never do releases which have any changes which haven't been in
an RC. This is a rule I'm not willing to break. Sometimes we do
an RC with less than the usual week's delay if there's just one
last simple bug to be fixed.

thanks
-- PMM

