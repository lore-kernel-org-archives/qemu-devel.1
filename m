Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3317C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795CE2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW/S8bUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795CE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgqy-0001fJ-JX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihgnV-0007NV-JI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihgnR-0004Ml-N5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:23:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihgnR-0004K3-8V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576704232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LVZFMcIEjQKaW0eDLoog1RTkQaYm2YhANjpvmc6A8+A=;
 b=BW/S8bUtS2IeG9oYpTCOrxwtVmKAmO/XawUkI1KwhZU0VAa7jCRrQhsUEXTHQaVEV24+VV
 PTVh4z0PQ0pfi7/gSxSXdSWT2oG0WnpH/ay0klhY12tszttlk0pTNNUd/UHAjPFuouMncJ
 PBFtKEjnYw90eGHs8bEArdImoxr77E0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-rCNYesjcNC6s6Z06Y7vnWg-1; Wed, 18 Dec 2019 16:23:48 -0500
Received: by mail-ed1-f71.google.com with SMTP id cy24so2132567edb.12
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LVZFMcIEjQKaW0eDLoog1RTkQaYm2YhANjpvmc6A8+A=;
 b=aQ9TtfA1ICSWd9GZEcE7QtegvhvCmJeUevUj2JOPPe+OIeO/v2SFAy647EMC8TI1Lx
 cPP8d6LTmyQn4dIcmIvpnx6F9QN4q4RGgHU0kMmTrRIQ5csGCoMcZbbEUmyYSwcEkn84
 UQ76G82sPBoC5Zf+r1nR1NI50nzSUUSG20eS80pJ2DQGG/IIBcisoUMig4NWB0hEbuv3
 8O57VcGNJmgcEs5hoiIi52CUKoI4DK9warY5Bi0dDqsK2aElJQJPfCzL2EQtqFA7h1MR
 NzPKe0bmoJ/nlk1Pp60qfGlipFlfzk/EVOf7ds0n8S227bTQ0mXYaU4VNvM6UOlsPlG6
 YuOQ==
X-Gm-Message-State: APjAAAVcXlrFJQdv3i+TRnEEP8a1t1Q7UwvLdCpVsMLipuWbEzbOEU6E
 TJJYdlDiqOlPLXZK5AUy/6vhO5ZYfyeMXLBUl2HbSSpnh3i3F4WxB08D1T+dYQiWOq7qCEwrIPF
 GCTk8xoVF76yFZQI8IiU1mqRHZP6n/e4=
X-Received: by 2002:a17:906:7fd0:: with SMTP id
 r16mr5049042ejs.319.1576704227181; 
 Wed, 18 Dec 2019 13:23:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrpAUekW53Fe3LOd+MfvP3xxphyDzaoy2yWMGzjbIa5G9Yt1M77gkZOd2UtKL7DVOtlt4CV80HDR+Hak3oO8A=
X-Received: by 2002:a17:906:7fd0:: with SMTP id
 r16mr5049023ejs.319.1576704226919; 
 Wed, 18 Dec 2019 13:23:46 -0800 (PST)
MIME-Version: 1.0
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com>
 <87bls7vzjc.fsf@linaro.org> <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com>
 <875zifvxw0.fsf@linaro.org> <5c6068cb-f8bf-fe4b-391b-7ced97f14221@redhat.com>
 <877e2tfsd1.fsf@linaro.org>
In-Reply-To: <877e2tfsd1.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 18 Dec 2019 22:23:34 +0100
Message-ID: <CABgObfbUE8TjnA+Jz6nqPim3uQmepSrFiM-U3ZJ4iKJeByfxTg@mail.gmail.com>
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-MC-Unique: rCNYesjcNC6s6Z06Y7vnWg-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="0000000000005cb131059a010f32"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Packard, Keith" <keithp@keithp.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005cb131059a010f32
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 18 dic 2019, 18:36 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 17/12/19 15:18, Alex Benn=C3=A9e wrote:
> >> cpu_has_work is a guest function though and semihosting_console is a
> >> common hw module. It can't peek into the guests internal state.
> >
> > semihosting_console only needs to something like
> > cpu_interrupt(cpu->stopped_cpu, CPU_INTERRUPT_SEMIHOST).
>
> As an exception is being delivered we just end up re-executing the
> EXCP_SEMIHOST. I still don't see why using cpu_interrupt is an
> improvement seeing as it is secondary to exception processing.
>

FWIW I skimmed your patch and yes an interrupt is not needed since you are
delaying the update of the program counter; that's nicer.

Paolo

--0000000000005cb131059a010f32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 18 dic 2019, 18:36 Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On 17/12/19 15:18, Alex Benn=C3=A9e wrote:<br>&gt;&gt; cpu_has_work is=
 a guest function though and semihosting_console is a<br>
&gt;&gt; common hw module. It can&#39;t peek into the guests internal state=
.<br>
&gt;<br>
&gt; semihosting_console only needs to something like<br>
&gt; cpu_interrupt(cpu-&gt;stopped_cpu, CPU_INTERRUPT_SEMIHOST).<br>
<br>
As an exception is being delivered we just end up re-executing the<br>
EXCP_SEMIHOST. I still don&#39;t see why using cpu_interrupt is an<br>
improvement seeing as it is secondary to exception processing.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">FWIW I skimme=
d your patch and yes an interrupt is not needed since you are delaying the =
update of the program counter; that&#39;s nicer.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div>

--0000000000005cb131059a010f32--


