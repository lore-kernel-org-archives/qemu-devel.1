Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD0AC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA96206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pimIQuxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA96206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkJO-0001xP-3y
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjwk-0008ES-WF
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjwj-00053v-K4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:02 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLjwj-00053Z-6i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id k5so804623oiw.10
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KtxdNu1HXgzI2aJnUuQ/V+W7GgXzf+se8c+Cw9+cO/U=;
 b=pimIQuxq/3m7GiSEafrP0Yby8GxC17Kbjmdkk90DOfJ0nopmtkdek2AWeGtgxTge23
 44c9FMmjRbRb4ZGl+eicL3claK8rlpKoSRdzgI3RYleQ+fJOGglzg4L1MfoK3uXT2dPZ
 EgSXwR78a3+nH1LQKCojRGzdEZ8SFvJ8c/crkHhN7Hx0tQdfdcyf9IFK8NlEdMn4QOgW
 zFDryqGemtUcZZucvis5HCdOsvTUPiGWOtZk+VD3/pC/RjEbwNUBLWtaFaiJRdu3Q12g
 xlL+Ih2pPEe7MUHaXhFHZiOkDeITlS4iTndagJNVZNeivpiM6wxps/8TgxcFaEv3Iyfh
 1Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KtxdNu1HXgzI2aJnUuQ/V+W7GgXzf+se8c+Cw9+cO/U=;
 b=CgCIadatYXAr7iPP8Wxh9aIaXE7H15OuWvYNN1mcNSLFoel85n7173srQrR8/k24aR
 eozP7xCydgZmioTAn2KEZZeQ8vxNxWUj19RsZSzkwBzD1aXPJIuwFFh5XZ2IfsiSqj7U
 hwnH9m08tithqO1CA9nv5c+d+Kf0h8+U5u7VYOGwy8EfmJXYJCRwy8QcF6ajcwJ2s60E
 V5MMFxQZWQ08XkhiBt3UIzRrHMGVQeXc41POsX9fnyZwXYNNxV1Haiz2u0duB7iCZ2zG
 r3j2C6hGE2ASih8ocbISMR3AMtOWSAE8HBl33eNUFKHmH3S712uYFnE/gPnZwPlzVqer
 DVXQ==
X-Gm-Message-State: AGi0PuZzo2EUbkM2Smq1lQnQxOdC8moc2hVArlO88S1a+IlnCl33/q3U
 asCAWWtCdo7BsRkgGX2lP/iXhpeL58hv4MCccN/a0Q==
X-Google-Smtp-Source: APiQypJHVeLS3kpxJwVUHxEwREJhqevjhunmyM5cL36EIxrMcvCf9HVwbjV2upSRZP0dHUdk2wOzYtWbzaSJwJeMkcA=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr822975oij.48.1586249459834; 
 Tue, 07 Apr 2020 01:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <CAFEAcA9FSVzxwudyaDoCty8B+Up33caM20qytLNO7HAXWmcwtg@mail.gmail.com>
 <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
In-Reply-To: <CACPK8Xc3mpoakAqq2_wccCH6_2i+V4NB61CmdxtMecJ4ejzgmQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 09:50:48 +0100
Message-ID: <CAFEAcA9erXezwsn_UaXJz0SL5Zaj=UmjTO0LPg0LDM4P50tjHQ@mail.gmail.com>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Joel Stanley <joel@jms.id.au>
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 09:45, Joel Stanley <joel@jms.id.au> wrote:
> On Tue, 7 Apr 2020 at 08:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Do you have a link to this patch, please? I had a quick search through
> > my mailing list articles but couldn't see anything obviously relevant.
>
> There is a reference in this thread:
>
> https://lore.kernel.org/qemu-devel/dd8fc1f7-56d9-4d9f-96a4-0fdcafdc8f55@www.fastmail.com/
>
> The patch is here:
>
> https://lore.kernel.org/qemu-devel/20170630030058.28943-1-andrew@aj.id.au/

Oh, that's from 2017, no wonder I couldn't find it!

Does somebody who's already reviewed the patch want to summarize
what the effects on devices are -- i.e. what calls the device's read/write
methods used to get if the guest did an unaligned access, including an
unaligned access half off-the-end of the memory region, and what
calls the read/write methods get after the patch ? The patch's commit
message doesn't really describe what it's doing...

thanks
-- PMM

