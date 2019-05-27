Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D420C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 19:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C25320859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 19:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKOUUUql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C25320859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKqv-0002Fu-Ek
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 15:00:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVKpy-0001qj-Ss
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVKpy-0003Zz-39
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:59:10 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVKpx-0003ZZ-V0
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:59:10 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so12489889oid.13
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pNRoKcCuhIS9xIyaBQiqtrKyyTh6R7Fw5zl+s0X/dUo=;
	b=gKOUUUqljOmFKZwwkNiJMssB7zEQx/HIPvONJgqrTqcgqm3CbWTTjUyxD+onvjwDUr
	wYx5jDVtdmhtx35/EcLcmouG5N/2imBpmZ5HbEbJl6LcNxo5YDy9g8KNhePS2nybkb+h
	3r06cFVLvtbG1m9IhNeMjm5Dw4FTmXaQ7iJk/7TKMvNvCiJh6Zslc1F3IdJuK7ZetiAK
	ug8KDxoAcmvoUwZr3zYqPFhSsRArzrztTVnUNRxzdMZE+wQOfZ0PTrrJzrqbI71XAVrW
	ZkhTSn6/lYF53MIJ16yvQ+V7XgtIFZxzjhh9PFt72VHVJF82n8gi1LR6nsKS+KjPHzex
	aFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pNRoKcCuhIS9xIyaBQiqtrKyyTh6R7Fw5zl+s0X/dUo=;
	b=KrkNdOQImQ+3OG9mnB7HNXNgNHk8vJ+dNXBpIWykGaIB68ZStgucsGp3b5UcCPgGyw
	CVujqB79NjmMa2eF8JKnQk7sqd+uo76ePyYFkR9TXZlXOqh8hQ/G+zKigeTinXoPzsx1
	FOs+EoEDWHB2V8it0L/dhV7mzhvqBKaU/m3/Y1UmFItR1/OKUXsvuV/NFE+SVnIb+7Fp
	24CDdIZGl2WcXtglwZSYn/pQodsJlDMQPvLqnP656o2v+mP8F9OOuk2FzUQlb5UwdEEi
	W1SBwqBF+fZWy9N9+G3oVkGoASqYHq8AKK9k4HKWZr0xuwwFI1+cxbMIyWBGTbO6StXW
	EtzA==
X-Gm-Message-State: APjAAAWsWgEXzNOzmf4CIzCNfE6VJUOZrxIQeyhi2f0/TgcocHdG81Br
	h2Y6J3UN0oMOMFuL46x0vIgYNWOY5ecwRJ4bFTpPOQ==
X-Google-Smtp-Source: APXvYqyzJK4hUa2yxcAoRiPaUD9iZ3DRriWHQF2zFxo5NNhy614LaZ0av+lp+kKrLz3zxvzQ4SL4+LlLAoamnY5sKzA=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr277691oib.170.1558983549317; 
	Mon, 27 May 2019 11:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190527063250.GI5447@atomide.com>
	<5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
In-Reply-To: <5dbec436-4356-415e-eb1c-0f506af89744@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 May 2019 19:58:58 +0100
Message-ID: <CAFEAcA-n8-LV2=hQwQOvRDT+pro7iBQD8i-QBszWHuW56VQsvg@mail.gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] Running linux on qemu omap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Tony Lindgren <tony@atomide.com>, QEMU Developers <qemu-devel@nongnu.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 May 2019 at 16:56, Guenter Roeck <linux@roeck-us.net> wrote:
> I'd be happy to use a different (supported) branch, but the Linaro branch
> was the only one I could find that supports those boards. Unfortunately,
> qemu changed so much since 2.3 that it is all but impossible to merge
> the code into mainline qemu without spending a lot of effort on it.

Even back at 2.3 it wasn't possible to merge the code into mainline
without spending a lot of effort -- that's why it was not merged :-)

thanks
-- PMM

