Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE361C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B5122365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4K1YC4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B5122365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNox-0007Nu-Jn
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNgd-000738-IZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXNgc-00077J-7p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXNgc-00074n-3O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:58:14 -0500
Received: by mail-oi1-x241.google.com with SMTP id 14so22061905oir.12
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d/usWlDKJbBWd0S5wNfzU9U4UxVZNWPmRsySSJAeVe8=;
 b=Z4K1YC4vSz4gZ+dCEZ/bAfojVig9hD+C4NQmhwJcIAvvTj2w9gTy9DZQg3mxeQUUS3
 Jezf3CoeCS0q6pkznPs+FUC25izt/x+QqejUDn4M4naUAgGNyYp6ttU3LVs7U2rQ7iGm
 9l4XBL8F9PdVvpA2sejcx1FulAnz5XIgYsfkrbf90zUl/M0wA+ooi2QcbEQXgmKIhMyZ
 KINPHyT5QHZ4qEiNW9vvx9bcCteYx/UC2mN5ZaPROrKRh12l+9yO8BhpJYx4Nd1X9CJv
 r2vPiqOCegtyBvnN8wEWYKJNTi25m2GEYibpSc40xrbsvUaxkM4SjbzLzUgcKJmEIbki
 HmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d/usWlDKJbBWd0S5wNfzU9U4UxVZNWPmRsySSJAeVe8=;
 b=iVwYUiUf4HXK9CV8m5Ix7kSrWp8siD2yqopHlZxarynTZNq0i2nuPyB1Yzw7TGevLv
 tZWqA/OXVR9rLTq78ZcXIB9PkW2eZU9TOrbcVg98sRiUsWDeXfkmnCQVfsYCeuuXTDFh
 qjYgiFVqnOFWQil/cnobDGBgX56iUh2kvgFbUYFT0AABC8RedmPBdZsfWpjVYzGqIc0H
 YplzFooZYtE8B2gUc25PQTNMSMQGR1zTYx69GApnm2e1mjG/FRD6vPbzFm5TkWUMza0K
 bqb9FDkbtLSqKjz5qfYhGuI4PhJ8GiTj3+tEpLJSrSDX8H3OFyLny6Rk7NjdEITSHLDL
 TSEg==
X-Gm-Message-State: APjAAAX+LpP5uIjTKNVWYyus/r1VfiN/J8ew97R1OpTF+N9FnBUwTnXG
 XnUks0ieoY2Rqhc60mtJBKsGryXp8hs4ZFKgIuvgDw==
X-Google-Smtp-Source: APXvYqx5ucnPbnpLHo6273smWsrJH/F5QUbrLFlys7HrkZgqcRE4RxZ+5hM8UGmaPrC5FiKx+LIgWymX1oIMfYg2oKI=
X-Received: by 2002:aca:451:: with SMTP id 78mr2280473oie.170.1574247492167;
 Wed, 20 Nov 2019 02:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-14-marcandre.lureau@redhat.com>
 <CAFEAcA9Cq_MkAzqAjt5uPNu3HDUfxO0hyVWtqEiAashPEEq3=g@mail.gmail.com>
 <CAMxuvawroZ0jrQTJCbakft21Lgk2cHrE9VyihiUvYBVp+AXgXw@mail.gmail.com>
 <CAFEAcA97LxS0LhCN-uqmO++D2U3dXBn3KctW7n-4tA-b50xKcw@mail.gmail.com>
 <CAJ+F1CJGHeb2aT+8t7vEdB0bKZ8r6OAnnqpDdnkGbfDRcV=JjA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJGHeb2aT+8t7vEdB0bKZ8r6OAnnqpDdnkGbfDRcV=JjA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2019 10:58:01 +0000
Message-ID: <CAFEAcA-_fexNrzgdqwoaJVEyHMG-GAPZkEawiE59EX9+u_Kr5Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 10:40, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> On Wed, Nov 20, 2019 at 2:36 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > There are two problems here:
> >  (1) "self" gives no hint at all about whether it's the Object*,
> > the DeviceState*, or the SerialMM*. All of those are the
> > object the method is operating on, but the type differences matter.
>
> "self" should have the type of the object that is being implemented.
>
> serial_mm_instance_init ->  SerialMM *self

In a typical device implementation, some functions take the
object as a "SerialMM" or other specific pointer. Some take
an Object*. Some take a DeviceState*. Some take void*.
Which of those is "the type of the object that is being implemented" ?

> > (2) *Absolutely nobody anywhere else in any other device model
> > is using the 'self' argument name*. It's not a convention if
> > only this one file is using it, and adopting it here gives us
> > absolutely no consistency -- exactly the opposite.
>
> Since there is no clear convention, then adding "self" isn't breaking
> any convention.

There is a clear convention, which I explained to you already
(variable is named with some abbreviation/initialism of
the type name, or sometimes just 's' for "state"). You are trying
to write code which ignores that convention and does something
else *which no other code is doing*. Please stop doing that -- in
particular, don't do it in one device in the middle of a refactoring
series.

If you want to argue that we should change our convention for
how we write QOM code, feel free -- but that should be a separate
discussion and probably ought to come with a plan for how
to do a general update of the codebase to avoid a weird
mix of styles.

thanks
-- PMM

