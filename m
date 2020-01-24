Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E225C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9F6206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1aCw2TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9F6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuw3U-0007q2-34
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuw2q-0007M3-29
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuw2p-0006lb-03
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:18:31 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuw2o-0006ko-Qb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:18:30 -0500
Received: by mail-oi1-x241.google.com with SMTP id q81so1390374oig.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=i0Ggrkt05j/Cpp4BpkNtZgwYDpuvZIRtVSjOkoUjDkA=;
 b=G1aCw2TEIkwTEcPkjpLCw6mDxHiaMDvi3ne2xOLul3nogl7hAo/fDCCtcDD+p6Um0M
 bxD664JKykB6EnKnnZgdT1xUZSLHVOu5RTFDq4zlJ62QsTI9HwjOgGlD5Pd1J3Dt+WJX
 oOVgsjhPS8tlk1x7tgXv8QrhFmlYyJY9vTGZxA2xfLiMWUVxjUPavTG4nAIq3JbbevTe
 6C1UYwF8hf1jghU/Ak3heImhQG1/nQ3GpWIDGj3fUV9n8GNeIG5IxxG3oqeyU++mvLRg
 sWZoD7TlxJdPewiXCaiDWjFV/lJjuaIesVjR8PvKukTrV0XSXW+ZGooVL/ytS2krh+Q1
 0M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=i0Ggrkt05j/Cpp4BpkNtZgwYDpuvZIRtVSjOkoUjDkA=;
 b=goO9NtTSA/unzPwLOISbJw4/6Iqx42LMyP19cYP5/dGKuIhr/RIvLSDlnNyEcsHeu6
 v4cSaWio/hxT99nhL+76nBIdowrfbWVLKRB8Cmep5hF+IaVsymGY6Bs1pdEXs3DH0Brk
 Dozr8d7PHqu16nRvTclMk3eimKlEip9mw5DQiDfMlkA9M0FO5lSNWoUIkCOmiA+AgtKf
 PTuZWmz0odYhEFjT9lBtQ7w8C+IHv6y9vQkokrrJZoTNAXJYIhoxCFr9LbFhCB6qX+oi
 BelzYJnS/woorSQ3u5bERQ5jpwzxWcDZMRsa49lDYgtnOYjCz9eLmPxcvZP+itVvStYW
 whhw==
X-Gm-Message-State: APjAAAXBaEcGbRSUAw6ykkWvmQi4wT1qt0zw/Yn3qpa1BOWHoHCrFWNE
 JQj7onjpIGz16AIthnE9C6qfTHygLS3ycWAYW4yDdQ==
X-Google-Smtp-Source: APXvYqy6SanwZWy5ThpRFnC6QcyIbsZSSNS7uwIV/htKZ4F7x2AYBIdoiUrYVX3NbdVahRjhBPykoWSnyQ9dxX+PXZA=
X-Received: by 2002:aca:f484:: with SMTP id s126mr1454918oih.48.1579861109740; 
 Fri, 24 Jan 2020 02:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
 <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
 <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
In-Reply-To: <81bde2c9-76d3-f5a0-3e54-089028be9dfb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 10:18:18 +0000
Message-ID: <CAFEAcA_927erQTvG3LS9ffqwY2WochmF4cKNSs12aPqiReTfRg@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 10:17, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 1/24/20 11:05 AM, Peter Maydell wrote:
> > On Thu, 23 Jan 2020 at 13:28, Damien Hedde <damien.hedde@greensocs.com>=
 wrote:
> >> v8:
> >>    + patch 3&5: ResettableState::count type from uint32_t to unsigned
> >>      (Philippe)
> >
> > We'll have to change that back if we ever want to migrate
> > the count (migration insists on fixed-sized types), but
> > I guess we can do that when we get to it...
>
> Oh I forgot about migration :( (this was just a suggestion, not a
> requirement).

Migration handling is going to require changes anyway, flipping
the type of the field will just be a minor part of that patch
if/when it arrives. It seems easier to take v8 if it's otherwise OK.

thanks
-- PMM

