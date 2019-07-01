Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96009C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627C4213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhVaXBhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627C4213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsK7-00039O-H1
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhsIW-0001yn-An
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhsIU-0004tP-TJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:08:28 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhsIU-0004sL-Ly
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:08:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so12420888ota.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rk6Ml3WHRwFEon2e/EIFooAQ3Xuk+EOEJJej0U+Bu70=;
 b=DhVaXBhqNiq58rdsWM8iBzRFWU5mvc0bolrs+XEoTfak4/r7fzSd/djA2GEhddJSPi
 IRtsHPETCZdZpXMXIZqpncIlz/75Dd5nwF5PKnZhK7fFBwzqttcIFse2uyyppXqXqfTI
 hjBQaT/5tmzguZ8PHKhRemrUyM+KVMjVUAEaStU1PX/yu5fvBQ4qAIb4h3Lx1c5JFPUc
 uQVNgyRO/UyVPhWYX9QJ6LvfhXDWP3O25hQGoiHr36NKWGsbIRDwOkxHoLmXzeCOZSvb
 xXNp8kZ0wF6CegUAMRxqB3rzx75bedHlK8rS/6L03x1ia7doGutbjlxDz14jpJG+NeKe
 v9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rk6Ml3WHRwFEon2e/EIFooAQ3Xuk+EOEJJej0U+Bu70=;
 b=Bw89nNRtP4Hoj21VJ5YaXcvg8L/1N3bQusZUHXMDAO/hV9fgB9rx7IfRR5W5g1XJX/
 UmVW3qQkQJ+2NRs/46jwUYiBKt+NrfHlBdjB92MEb75yALzdZjeNo2IPNQszekFnatyg
 TbWGIIVVz85NBrUX4/f3fSbo7pQs8n9ZPJTmCvZcQv+BraZOs3cjkc+2QGxow2FXg/gm
 yRUDUg45eryRrm63O3/z7oynjDIvcUrLTJ5s21qa6eenDz6AktoYBChOf3C3eF/DhZK/
 45xcikbQwnRdOUT3XD1ayIbuE6PxuEr2+Y6Pxml9bLsEE4x3uaOX5fHjxHoO3Dum5juQ
 xkIQ==
X-Gm-Message-State: APjAAAW388+CG/dks/XaCgvrQz4KGuEi/hkCfyt2YphSm1EBvvIoRTX8
 RNYf8qF4GzlkzfqD/z7rOqjO9flQXRHTAD1jslr83A==
X-Google-Smtp-Source: APXvYqxtx1fkd72hjQjfeLv0BqNWsIIoozINITGUNiuZzlSaK60en1OSKL0spFui8m1/HWX4+K8UgZx0Law2rwQYhfk=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr19683493otk.232.1561972105328; 
 Mon, 01 Jul 2019 02:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <CALw29ZZZ08Lt13oZsbZCwV+uP0roLuT6t+8m16y+8YT-KH4t7A@mail.gmail.com>
 <CALw29ZbiqpGFOGHOP_7K2DvAfap_xE+PWAfXvvr35eK7aKn-dA@mail.gmail.com>
 <e3282346-166b-ef37-b874-2c2625cf31c1@redhat.com>
In-Reply-To: <e3282346-166b-ef37-b874-2c2625cf31c1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 10:08:14 +0100
Message-ID: <CAFEAcA-ZVGq1bD4+fu2+7GOVq_nBXBy8h31AY-0=i2ixnvvRnQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Cc: Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Jun 2019 at 11:53, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Marlies,
>
> On 6/29/19 1:26 AM, Marlies Ruck wrote:
> > Hi,
> >
> > I just wanted to follow up since I sent this patch a week ago to make s=
ure
> > it was a received.  An ack would be appreciated.
>
> You did not Cc'ed the maintainer, so he likely missed it.
> See:
> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
>
> $ ./scripts/get_maintainer.pl -f linux-user/signal.c
> Riku Voipio <riku.voipio@iki.fi> (maintainer:Linux user)
> Laurent Vivier <laurent@vivier.eu> (reviewer:Linux user)
>
> BTW you should also look at the next paragraph in this wiki page:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Do_not_send_as_an_attachmen=
t
>
> Since you credit Peter Maydell, it would be kind to Cc him too.

I have a strong suspicion that if we applied this patch it would
break running a pile of Go binaries that currently work, which means
it's something we need to be cautious about. (The Go runtime special
cases the fact that when it tries to register some signals they don't
work, but will abort on startup I think if it can't register a handler
for SIGRTMAX-1, which will be the case after this patch.)

thanks
-- PMM

