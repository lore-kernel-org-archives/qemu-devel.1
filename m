Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC9CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5834320854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMvjkleR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5834320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVTp-0003b3-9R
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVSd-0002X8-5e
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVSb-0000rN-UF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVSb-0000qt-Lx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id w144so5777715oia.6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C4eO51fwA1ukbfwgea+E2N+xXGL/cfwgmawR3uZJAMs=;
 b=NMvjkleR5y8POmR0i9XQbuNlRFR2Vq2Vjzmay0avN+Xaazu0w2BXP25TUQHCqntCrV
 UeILQA5RjXuEYYT6spgx2i+bOlR6ST2Iq/PZZtncX+yG219PPYXynEnBtlGQcnjYc6js
 mTFCvyYmgA4NXVWkrpX1Fg5RjVG+cImIr6273f2JWyfCDXLon/XAVz+RqveqTyZawJCx
 Iu8PF3EEIL8lVU9Vyv1JylE8N4+VhhRGtENwb8/VJk8lZnKeTVRnWqdgUs+7U0iO421r
 4J/wcskVDeVuGhxupdE51bkIdMDDfeg+r8kjH+ap/gcVRmROXGyEmzJMy2GN4gpO25D0
 nwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C4eO51fwA1ukbfwgea+E2N+xXGL/cfwgmawR3uZJAMs=;
 b=jqdCf3+iaz/iRIR9el7G1h7IxvrAyHzq06ralPnZ4VfNObtjuPvHG//FCnj45lLwFQ
 gV9ihpe0Eg08JbBjkSPkfX49glHEQQ1VYQEgHtctvO6RAk5jXM1kJycDo/MTfCnD1zP6
 ThBY29vs6o7ORvQPs5GRhpCIq4gFIBEqCjH/BppGyO34CFGfTVNV+H3NxbaPfO2KekmY
 gyQ/pkD3GDv6tmvcXIrQNDhTlzCFzv98AqBlvQ0mhDt4Ex2AvmdfLqfYASC9lBSsPaCc
 znP6Y0wwl7N4Cnj8IT4qn0hkUYJgJxs7K+5cKueIUkSMotlGMhAk/LCZGKm0L6/nFd9K
 a8mg==
X-Gm-Message-State: APjAAAVwJfkLrqoiBkaIsZS1zo0ZNXEz4wyLRi69mljuLhbJkMJrHBzW
 19/hbbp0JLVKMXMykeeOLGSfzIsVEaohlc9CDYBNOw==
X-Google-Smtp-Source: APXvYqzKDpMkIThMztdejS5wjfDJkZi1vLc3NM8jLJeCVXnumOFs7cvr6NaHmwQJz82co5OJHx1X3nOI7kh5Hb4s/oI=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr8464402oik.146.1571417440323; 
 Fri, 18 Oct 2019 09:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-2-marcandre.lureau@redhat.com>
 <CAFEAcA_7zxe6YfM6c8v_SQ+qh2L7Q5RS_xEPvy01q9aPZ6YyiQ@mail.gmail.com>
 <CAMxuvaw2CMqOuGXVq4Gk+GDNrjq++Ho+460WN9yo-pJFPVZhjw@mail.gmail.com>
In-Reply-To: <CAMxuvaw2CMqOuGXVq4Gk+GDNrjq++Ho+460WN9yo-pJFPVZhjw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 17:50:29 +0100
Message-ID: <CAFEAcA9fRzCKQp=KkqXHdrN69ZNhtuy=XU+MZHJsjP-smx6MzQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] sm501: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 17:36, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> On Fri, Oct 18, 2019 at 6:22 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > So I think the right fix here is to properly QOMify the
> > code which is not QOMified, ie hw/char/serial.c, in a
> > way that means that the various "memory mapped 16650-ish
> > devices" we have can use it and can define a
> > TYPE_CHARDEV property.
>
> I see, I can look at that.

It would certainly be a nice cleanup/refactoring to have;
it's likely quite painful though as so many things use
serial_mm_init, many of them not properly QOMified themselves;
and because SerialState is used by x86 it's likely to be
tricky to handle for migration-compat reasons.

> > In general I think our uses of PROP_PTR are code smells
> > that indicate places where we have not properly converted
> > code over to the general approach that the QOM/qdev
> > design desires; but we should be getting rid of PROP_PTR
> > by actually doing all those (difficult) conversions.
>
> I think all user_creatable =3D false are smelly in that regard.

I dunno, I tend to think that "not user creatable" is the
default state of things. Almost all devices aren't user
creatable, because they need to be wired up and put at
suitable addresses and IRQ lines. Pluggable devices like
PCI, ISA, etc are the weird exceptions that are usefully
user-creatable.

> > Merely removing PROP_PTR itself by rephrasing the dubious
> > inter-device connections in a way that makes them harder
> > to grep for doesn't seem to me to be necessarily worth
>
> grep for user_creatable =3D false
>
> > doing. Is the existence of PROP_PTR getting in your way
> > for a change you want to make ?
>
> Yes, I am looking at improving the qdev vs object and class vs
> instance properties. I have a larger series of wip refactoring. This
> initial series is preliminary cleanup that would help.

OK, that makes sense. I'll have a look through the series
again; if we don't want to do the nice cleanups now then
probably these changes are ok, possibly with some TODO
comments noting what we ideally ought to do instead.

thanks
-- PMM

