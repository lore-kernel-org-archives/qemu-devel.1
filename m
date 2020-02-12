Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C792C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:35:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3720B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAvJrwfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3720B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1qIn-0003jV-E9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 06:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1qI6-0003FN-72
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1qI5-000378-6P
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:34:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1qI5-00036f-1u
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 06:34:49 -0500
Received: by mail-ot1-x344.google.com with SMTP id z9so1569557oth.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 03:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fXjD8EyEhHZYAbdaSuBNtwAxsP8oXh4ihx4v8XWc8ZY=;
 b=sAvJrwfYEQf6wxKXNTL9s89ja4IuxpoThZM75cx8exaqi8S2ixZoM8SrzI4MG0Uusn
 Lg5r5q0u+eiYLX0XNiDZMiINSpOo/77F0NuU7IW8EFjZvODFOA7AyLzSvj80bEjxqe2R
 jyy+bwqf9QLH39hqTLJu4z7uWlr3Ws6h0Wh1IRRfiXl1X7uATyrWGCiaVii5jjwghNH/
 BpFfQybckDCLZCL/i1rmyOxZYXVGvflrC7FICxZ1nRoZv2oxJQfmUfV/PKNQdbLcptqh
 7k8Pv/426ak805nJTPeuKRKxniMt+hkofPr4eJai81jHfSmPlxlOsgQBBrMxp6i7z04R
 l06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fXjD8EyEhHZYAbdaSuBNtwAxsP8oXh4ihx4v8XWc8ZY=;
 b=H1HnynCIOa7/YJF8xooG4wtL5J3zRlyOqSzVU7r8VxW9W9KYny68yX+uDrRaFno/z4
 WuV5RDzYWEFzMqFBObbLhZhP7bsKcAE65rXLqja1xAXY69JR/BLo5XyfyuhzFIVPkb1r
 hZbq4tKgVygeBO5t5LTKWA1DmCA32d5d/+4MSE8pd3E3a7mIX5OhQrWIrwRlh4yJFPrt
 tsGE0GpA8d+JCooYR0DEFnJ/AfJCLBcL/TQs7uZ3xWiFf9sxVeo9lGj95O9ND4wnj64R
 wyU1kElY3Bsj35PCHqXIMKpPIiaF4rycPuw/95wthsSUb70z2WmaIHzMbxUC5sTNJQyI
 FD5Q==
X-Gm-Message-State: APjAAAVgezZWWVEXb04I3LBPG108bKkjKjIGS8MnOMkWaN4ccqGEB+59
 QgEkEQUV5REEq+1WyikYflw2bQHsAX1xhDexLyEUsg==
X-Google-Smtp-Source: APXvYqwFknkgmqkvDlYP+49y8nd5as/q6PpFbMRXfHhJe+TrzrfVyMUSquGVSFpi4SwMEeNd70SJ0DNDSnwnKsnx/iQ=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr8447382otq.221.1581507288260; 
 Wed, 12 Feb 2020 03:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20200205110541.37811-2-gshan@redhat.com>
 <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
In-Reply-To: <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Feb 2020 11:34:37 +0000
Message-ID: <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
To: Gavin Shan <gshan@redhat.com>
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
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 06:39, Gavin Shan <gshan@redhat.com> wrote:
>
> On 2/5/20 10:05 PM, Gavin Shan wrote:
> > This allows to inject SError interrupt, which will be used on receiving
> > QMP/HMP "nmi" command in next patch.
> >
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >   target/arm/cpu.c    | 11 +++++++++++
> >   target/arm/cpu.h    | 12 +++++++++---
> >   target/arm/helper.c |  4 ++++
> >   3 files changed, 24 insertions(+), 3 deletions(-)
> >
>
> Hi Peter, could you please take a look when you get a chance? I'm not sure
> the implementation is good enough to inject SError. If there are somebody
> else who can help to review, please let me know so that I can copy her/him
> either.

Yeah, this is on my list to look at; Richard Henderson also could
have a look at it. From a quick scan I suspect you may be missing
handling for AArch32.

thanks
-- PMM

