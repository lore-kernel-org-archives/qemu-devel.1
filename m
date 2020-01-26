Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5120C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 15:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7009B2071E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 15:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9nLL4Co"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7009B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivjTi-00080G-I6
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 10:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ivjSs-0007Tw-VQ
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 10:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ivjSr-0000Jw-Tl
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 10:04:42 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ivjSr-0000Ir-Oo
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 10:04:41 -0500
Received: by mail-ot1-x32b.google.com with SMTP id h9so6044650otj.11
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sT6DIJkYV1lhv56j7L5wbUS+1k5szM7mpF6BKFkEU3E=;
 b=Q9nLL4CoqxEFQhFKg/Cl9wEOOLHznd/3mZ6NeMuPu/wdx1tPRvnPhwC0vuX3BFO/ph
 JD85HStsu4LfdomF33CnOyOiAkBM7vdWfIj8EI8rl3zwwkQFC2c3iINYYUiElO57RZhp
 Ubq7X5jy7iavGL8G97FHNUDzDjwJ1EEo+KqzpT3bSXpNSFhGdhgLOhCqPplYpbI9l09s
 4g/Rdrnvg/3fAi4KqOpBp/90Dzcj3QJTaHEOtWtcm79SbA9OlLez1TRZQ4H8MFj0mvi3
 ek5MdRPpgF7j8vCwfa3SE2/1knXJ8fgxBtiTMiZaSrQYPX5Ev8ZFUrTn0aeIOkBSQYfS
 aZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sT6DIJkYV1lhv56j7L5wbUS+1k5szM7mpF6BKFkEU3E=;
 b=oQ3k8uo8oeQiLtHqqVcJnA8lcyx9XJEHY/fku/Eov4Wy0/OV5GIXYpAfXNwIBKj8op
 t+xQI3aBFo/QK2CYcxBWT3vuekEhbrnogsHNvXAN6wMENvb/YnaIbsbPpReraVEY270e
 tcWALEXnMlKauWSPhO8wZAzIE/MbELtWZeYjnbzvMCcSRG6M34Tu/DE2vIrCwEWLux3J
 IrYE7AUwf6wGqYEIAfjCkn6ygeJ7po7EKIEhdup/JtZyjWGmzXZscOyrJTSpC9nrohd6
 nEU5I2EnfNErTIXxDWNNuAMtU0DhWZRlrIcc7pXQc88PIt2cu+85f8QSf+2up7xlQ+XC
 3fmQ==
X-Gm-Message-State: APjAAAVhLlYA8pINgKi+Dx3HTO3ymGZBaNGAobYr8axjIhqx7Vyo+Vtl
 ywcSwDYz+SARozU8LcUXZpOe9FIMOycffyVYTGDmQQ==
X-Google-Smtp-Source: APXvYqxsUjUmjbRiax1zHAD7QB0XJODJfTod495YCc9DzAIys7M98C6Uon+kr/6jCt6RX1nhYjHJaz2U3zRpIDU5j6s=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr9553293otq.135.1580051079988; 
 Sun, 26 Jan 2020 07:04:39 -0800 (PST)
MIME-Version: 1.0
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
In-Reply-To: <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Jan 2020 15:04:28 +0000
Message-ID: <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
Subject: Re: Integrating QOM into QAPI
To: Christophe de Dinechin <dinechin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 Jan 2020 at 08:10, Christophe de Dinechin
<dinechin@redhat.com> wrote:
> I=E2=80=99m still puzzled as to why anybody would switch to something lik=
e
> GObject when there is C++.

I'm fairly strongly against using C++. C++'s language design
is an "everything including the kitchen sink, lots of "this
is here for back compat but it's a bear trap", lots of new
stuff arriving all the time. It's just too big to keep in
your head all at once. C has its faults, absolutely, but at
least it tries to be a reasonably sized vaguely coherent
language.

You'd have more luck persuading me we should move to Rust:
at least then we'd get some clear benefits (no more buffer
overrun security bugs) for the upheaval :-)

thanks
-- PMM

