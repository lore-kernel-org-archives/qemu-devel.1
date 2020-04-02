Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06179C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FA1206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y3VQJi2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FA1206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyrU-00055D-QZ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJyqt-0004gI-UV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJyqs-0006lF-N9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:21:43 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43436)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJyqs-0006gk-9j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:21:42 -0400
Received: by mail-ot1-x32e.google.com with SMTP id a6so3137300otb.10
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 05:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BkxOoETfgIpod4nLRBUqATLoujQ87pRuz1XMd5bJHHk=;
 b=y3VQJi2CFFM9OVs2xIgSrXOCT9ij7FsxPXgAujTc7JInHCgI39rLlwT1j3q9Xg/Qhb
 bhxLCmIg80KPGxV8bSxGpayywp2jg5tlOkoR08k7Xs673Cajbhn3zx+2+OGZac9VzHdG
 7/0sk5urbvLYJgI3dyAknjqP7DyOso9YWcL5adygi8ZrvY2s2SiX6qpGFmdwTrYSKV85
 qoIeqiusdhD1cKlilB89ERXHBrV+4WabR4e+D5oBRpcfqB7dH9RiHhfPe9REiRnyS+hi
 Jec/4LnZozqacg9Q8eqeK3ntoazEpH8M4iJx6/hTW6nWDI/lkRS/q1M21MqcwWmLpW2P
 eyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BkxOoETfgIpod4nLRBUqATLoujQ87pRuz1XMd5bJHHk=;
 b=eiwNWNr20hVRgli3LX3NvXrGGRC+psrSly679QaIf9Rx7i/t+N9wWdyqP0MAccmHyI
 4GRhquwlkcIm9XtpJyPt7PuHzbjRhfMzVbbFfyYKl14UGLXeHsN756x6e6ZLKDezhDwC
 3+U4kgrjQ1lNxxY0YeOxKLZ3yypYoj4Xh3o8cqnujdyzJETL6zPlBgN298RkGDYHatkp
 nKprNGlRSc3Bkvsgrrv98KXY8ikZwzr9QZOmvdaAyJrk0TGXjLbcVChQSw9gV6E2dYH/
 d0DuCoTw7uT7otL/B2amQ4SWX4IQQHdQL4gEvlIEheBUnwyZfVoP4pwoE4Inp7vNhgpa
 VqSQ==
X-Gm-Message-State: AGi0PubRqDiQyN5gfubewDqosMXBVkar/AfieFjCtyPrywR0vM7BFuWF
 vWeGJDp9N4M8q05jHuRdp9FHNVw+A8Y6zMY0agDLmA==
X-Google-Smtp-Source: APiQypKYTaWgIbr218FAOVTS9ppORUJCAExN50jm5UFTrHCHI4dpu3nTqpqGujMv6QL8SlVzbW3yRKggDKtGc89+RD4=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr2156315oth.135.1585830101199; 
 Thu, 02 Apr 2020 05:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <87k12y5by1.fsf@dusky.pond.sub.org>
In-Reply-To: <87k12y5by1.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Apr 2020 13:21:29 +0100
Message-ID: <CAFEAcA8aBjWPVH7VsicTrKce1K-sOh0Sv+Ok-75zbtsJV=OBaA@mail.gmail.com>
Subject: Re: Function-like macro with the same name as a typedef confuses
 Coccinelle
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Apr 2020 at 13:06, Markus Armbruster <armbru@redhat.com> wrote:
>
> I discovered that Vladimir's auto-propagated-errp.cocci leaves
> hw/arm/armsse.c unchanged, even though it clearly should change it.
> Running spatch with --debug prints (among lots of other things)

> Clearly, Coccinelle is getting spooked to easily.

Is it worth asking on the coccinelle mailing list about whether
coccinelle could be made to be less picky in this area ?

> Regardless, three questions:
>
> 1. Are ALL_CAPS typedef names a good idea?  We shout macros to tell
> readers "beware, possibly magic".  Shouting other stuff as well
> undermines that.
>
> 2. The compiler is quite cool with us using the same name for a
> function-like macro and a not-function-like non-macro.  But is it a good
> idea?

Probably not a great idea, and if we really only do it 3 times
it's not too hard to change I suppose. I think this basically
arises when the natural name for the struct happens to be all
uppercase already because the device name is an acronym. We
don't usually titlecase acronyms in structure names (eg
we say 'SCSIBus', not 'ScsiBus'), and (legacy exceptions aside)
we don't usually tack on a trailing 'State' or 'Device'
to the main device state struct these days -- so if your device's
natural name is an acronym then the struct ends up all-caps.
If we don't like all-caps struct names then ideally we'd
adjust one or the other of those conventions so we have a
consistent way to avoid them.

For 'ARMSSE' we could I suppose rename it 'ArmSSE', which would
be in line with current corporate branding but out of line with
most of the other places we use 'ARM' in a struct name :-)

Q: how many all-upper-case typedefs do we have in total (whether
they have a clashing macro or not)? Your argument 1 would
suggest we should look to change them all, not merely the ones
Coccinelle trips over.

thanks
-- PMM

