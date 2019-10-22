Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26875CA9EB9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91FA2084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuhdHhHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91FA2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxc6-00085Z-Hb
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxMe-0005dX-3K
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMxMc-0002XA-7m
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:31 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:35913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMxMX-0002Uw-BC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:50:27 -0400
Received: by mail-il1-x144.google.com with SMTP id s75so6331797ilc.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3rbLX8hyHjXvC0RWsfQyJiuqcLKv+R/GgI5pEEIOve0=;
 b=yuhdHhHEonv2R7nvjZMd/z8YNvHQJ0qji0VX6sqJ27SUOcXuEWHub47WlFQXe9+gQw
 a7Ze5mc696/xXbY7XIHYYhAyT9eVWlxdmkE5QsTKs7yT3Pf2UpnEUVpmtDmQkdHLQ6Av
 O27SDyQ4XQtqb/n65RNtulQkpbpPTG+Lsvg5nTCBVPLtlfefuaOR4bXF8qr8WZl0YNpK
 q61dCUNLFJWMJSioX25i1aw9iU7hTw6czYWoBkZyv0IBDT+hxczWa1p9SEG5EXllFCBI
 l9TCm4yzshu436aP6WWAw5y/cprhoKkBD82/42gtEFasHimmTCXeQGGODpq/W8iwyG4B
 RsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3rbLX8hyHjXvC0RWsfQyJiuqcLKv+R/GgI5pEEIOve0=;
 b=ldXHisqWOuz7+8Uu9x6zJhN65XBYBXHscObEZFVR8e/CW7mLcnbGwJ+268h1ZxXb3R
 DRsE+aoIOmNyoeNIuTV/qmzazVOW1mnC3HfZSS/3duEg8XS2Cn1+U/F7Z4oAom3fopfW
 wXxpbb+9y17X3S3QPn8oVH3czITomCoHoQT4CFQzhGKK9E2y6F0utBU8ZGfNzEN9SUya
 XuB7Sn/up/K26MM0kz3JY7fMjQFEIvGiOK+f5AcvgrdB75VgfZTmTSLYGoqVFT92ZuLT
 O5dpeyVjQS8oZUF/i+R63Ell3c6BV6a4KfpXcg5pM5RAgQ+PS+IkiqtcUvRh8k7BDMUV
 S0HA==
X-Gm-Message-State: APjAAAV0+NJFoTLKzEFs9GNpVFqrJsv1qtOrWF2ZxdWE0D2tWEMtdDFM
 ZHmjX9RucGX7KdozuK764wVG94/Vh6QLl/gQGVlwIg==
X-Google-Smtp-Source: APXvYqxLu6/mERiDrayLVOeihPNAjBX1iBfn20sr2uw3l4T8CC8K1/90J7oxvmaezsbkBJxKF5qTy52M+K64S1dg/iU=
X-Received: by 2002:a92:8dd9:: with SMTP id w86mr31836132ill.93.1571763024655; 
 Tue, 22 Oct 2019 09:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
 <20191022162137.27161-11-marcandre.lureau@redhat.com>
 <CAFEAcA-5DkdB-iUHBRONB0SHO6rYmU7ZzdojJd5iZbQdLHswTQ@mail.gmail.com>
 <CAMxuvaxTdPyODFAofKWURq8_zJNQtxiX7Xj8dogB1iFPqgbj4A@mail.gmail.com>
In-Reply-To: <CAMxuvaxTdPyODFAofKWURq8_zJNQtxiX7Xj8dogB1iFPqgbj4A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 17:50:13 +0100
Message-ID: <CAFEAcA_QEdzo2usdkfaJGsVjeLcSM1bxVN4APVWAUvcB7oj0zw@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] serial: add "base" property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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

On Tue, 22 Oct 2019 at 17:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Tue, Oct 22, 2019 at 6:32 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Tue, 22 Oct 2019 at 17:23, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > Devices shouldn't have properties to set their MMIO base
> > address -- instead the memory-mapped serial device should
> > be a child of TYPE_SYSBUS_DEVICE, and should provide
> > a sysbus mmio region, which users of the device can
> > map at the address they want to map the registers.
>
>
> Can we make serial a sysbus device? It seems to be embedded from
> various places, in various buses. Not sure that makes sense, please
> advise me :)

You want the SerialMMState to be is-a sysbus-device, and to
has-a SerialState, I think.

> "base" is mostly needed to set qdev_set_legacy_instance_id(), I should
> have added a commit comment. Otherwise, it can be passed to
> serial_mm_connect() directly.

serial_mm_connect() shouldn't exist at all, though -- we
want to end up with a normal sysbus device whose users
create it and wire up its MMIO and IRQ in the same way they
do any other sysbus device.

thanks
-- PMM

