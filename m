Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95817C3815B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF8B20732
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 15:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fp8yGPiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP6lG-00039Y-He
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 11:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6kJ-0002kD-RE
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP6kH-0000yn-Pq
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:48:07 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP6kH-0000yC-Ex
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 11:48:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id g14so3411236otg.10
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aXD/ilrj32x0teUSG0ekxPktCzU1qYzNs72h1AFuU5g=;
 b=Fp8yGPiSCPq3i7u0wZVPjN9bgReM7bR3D8g7juKl1qagM7oONxKreTWIEYcbXIseWq
 iOvyEv4ihVEWWHwXfQq8wy+Lj8x3Oz85l5WcwkGRhxsUxvl+jWAlhV+6q8usAxhCKehQ
 sVZZD2KuSKmmKiLzhM4C7dfY1sKN4MvbRwd4c3eU+73zvaaqo+2hvVQ1Ik2JPQ49h2et
 jIgEv2wdJ2p1QPv/iOuVdvcBMf5CxCv7Lock9wqXvti9k7q/dW4Qba5lQYJpWRZZoAlP
 ofssV+Lb7E3eSjV7mZ1XcAczwc+Mqukv2tpK1kyXpdvbV0PCxmeSbEI9MPZbFu8YwDkr
 t/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aXD/ilrj32x0teUSG0ekxPktCzU1qYzNs72h1AFuU5g=;
 b=t9fzjtW+/+ZuWUX6EpVkn2vopuiYTQtGoZkgX5PhxJwFyiRqcZf9R9Wm+RagFX2bIy
 kyIGZU2LbyPuyWrdMFJKAlsTXPJ2hDbgaYlrKh7nH2RdSSa8BCuJFZ9cz7RSBHa/5hcu
 xsfK3iD5Q+tN+cNEKTZO057C6dAYlUlj+57gLRoItbUL355Fmst7dWpzLzDButEngFJ4
 XxOIvSDCKoLqp4FF5G83JGiF3CglU/aBI+hoUKDxUAnjbceQLuaLFRl2ka1NOCDPyruq
 myoHm9M5eZdV5WUmdBCJp1SzaPEHkSLLgSXGQlAQwHdSnWzFjvZU0qVVjQJuzX4FrzWR
 lvcQ==
X-Gm-Message-State: AGi0PuZajsvKzCBJmjrlEIF06HN9RvACisSrKt0tF2xqAJrhgy0LizDR
 R+sdfEyCOe0ebbvWIm4ompD492hARVQjdD4PQg1Z1w==
X-Google-Smtp-Source: APiQypJJiyJaK/O+I3SnpsmBsXiFMkOOvcrdQ2yTpJXUvRPrB4IUqrjmQ7y3bYaQ4Lz708kTJS/0QfJ7Y5GFVZL+kEs=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr27566092oth.135.1587052084689; 
 Thu, 16 Apr 2020 08:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200329001705.15966-1-pauldzim@gmail.com>
 <20200329001705.15966-5-pauldzim@gmail.com>
 <CAFEAcA9bL=uZ3-F4bYbHW+V9REnS1OnSusGKB2UoHS0bjSbvzA@mail.gmail.com>
In-Reply-To: <CAFEAcA9bL=uZ3-F4bYbHW+V9REnS1OnSusGKB2UoHS0bjSbvzA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 16:47:53 +0100
Message-ID: <CAFEAcA-nysMVx1-xukuhaUCWaH544+2_J8AtUMru2hsyv-hPEQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dwc-hsotg USB host controller emulation
To: Paul Zimmerman <pauldzim@gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 29 Mar 2020 at 00:18, Paul Zimmerman <pauldzim@gmail.com> wrote:

> > +    s->as = &address_space_memory;
>
> Ideally this should be a device property. (hw/dma/pl080.c
> has an example of how to declare a TYPE_MEMORY_REGION
> property and then create an AddressSpace from it in
> the realize method. hw/arm/versatilepb.c and hw/arm/mps2-tz.c
> show the other end, using object_property_set_link() to pass
> the appropriate MemoryRegion to the device before realizing it.)

On closer inspection you're already doing that with the dma_as/
dma_mr. What's this AddressSpace for if it's different?

thanks
-- PMM

