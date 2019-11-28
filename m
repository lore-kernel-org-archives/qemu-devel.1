Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86340C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8F720880
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7mqPvn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPu7-0007HN-FE
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaOCt-0008UC-RK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaO3S-0003Q8-Eg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:58:20 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:42542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaO3S-0002yk-4c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:58:14 -0500
Received: by mail-oi1-x22b.google.com with SMTP id o12so23907981oic.9
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+kKnxnvqzuEeAybIP4XfeZJizQ7yNHX5z5AcpM9iV/g=;
 b=A7mqPvn0A1PSRwECEDgMzN4/2vfiCuOQn7Vn6fmUyYTMQZmnNixPQEm6uKtpTYb5HY
 uX680xpnwLgWQyVhqvVMXYu+jJtYyG0XLrdTcWRQ6YJTDsrPNPULZI45m5dhcTTD0B66
 hcfGDIBvGITuo3R6GZmEfU1cJHkY0hG+mT5qYrzkwugLIY9v112DO2L1NfMs2rwDS/DU
 kDTS+ZNIrLN9pflaksJ5aew7D3b478/S5aE1tYZ7x5pJJchtHqU1M2jsoUgbom/OBZJ+
 TXKPWx3W8ZKaXSmb4/I0UHWvtGGnDKgz229TTFXQZgXV9bYojAZGz5Dlo28GyyOgtoKb
 7EBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+kKnxnvqzuEeAybIP4XfeZJizQ7yNHX5z5AcpM9iV/g=;
 b=t6iXCg4ym3eAQ4VceHQPEJgY6c5djpdffYUYRMnSKOSNF6Yw0SIsh+xnrDjTEgd9+D
 cnTvD4uU3sszDOJJgTW6SRPAnHle1PsKatbeNLK4scTvqo0OPgbqhBgyGG76paNvTris
 JNNF0gQvtoAyvjeiNh01iBq+I+xbRaVhjRMD8Ue1KKcIzeWHzS8apFx0zhQFtQMVaAgU
 Nue4hhwYn/RZg3vjYP7miy0y0wyHfdVkciTYB0fHakgxr45RugEu7FLvngoN602j/UAv
 dSTd5PDaBf8BkRRWiuyA70M/bvQL+N11g7c5n+wbUz7c+dqmnigMu6BvGAAGRKVpRgyi
 DMpA==
X-Gm-Message-State: APjAAAWpdFPzzljM9F9xlCAoIit9DPN6ZrJrCE79yWx62d1shT8CJKpm
 w7mzUmmahJWszVwKF2n8dDoPyVP8wDfXBRJ8pE7qzg==
X-Google-Smtp-Source: APXvYqzRazSqPjnqL+uvPeukN2nWaVaLJCc4+2GPuXTc9vpFcnFqXFMGreA7Gv42rbPX7QXZ9M6KFoutdTZaVaZZkLs=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr7136840oia.146.1574963887638; 
 Thu, 28 Nov 2019 09:58:07 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9E-Z-RPwFsAiz9Pi3_MtBUFEU7enJFVrpOQ7UKW8e1DQ@mail.gmail.com>
 <20191128182705.0635d1d4@redhat.com>
In-Reply-To: <20191128182705.0635d1d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 17:57:56 +0000
Message-ID: <CAFEAcA-qA6n49KdHsGLqt422L_b_9xPfSaJB3tATQvRdfKt-xw@mail.gmail.com>
Subject: Re: qom device lifecycle interaction with hotplug/hotunplug ?
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 17:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 28 Nov 2019 16:00:06 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Once a device is hot-unplugged (and thus unrealized) is it valid
> > for it to be re-hot-plugged, or is the assumption that it's then
> > destroyed and a fresh device is created if the user wants to plug
> > something in again later ? Put another way, is it valid for a qdev
> > device to see state transitions realize -> unrealize -> realize ?
>
> I don't think we do it currently (or maybe we do with failover but
> I missed that train), but I don't see why it can't be done.

Well, as Eduardo says, if we don't currently do it then
we probably have a lot of subtly buggy code. Requiring it to work
imposes a requirement on the 'unrealize' function that it
doesn't just do required cleanup/resource releasing actions,
but also returns the device back to exactly the state it was in
after instance_init, so that 'realize' will work correctly.
That's quite a lot of code auditing/effort if we don't actually
have a current or future use for making this work, rather than
just requiring that an unrealized device object is immediately
finalized without possibility of resurrection.

If we do have a plausible usecase then I think we should document
that unrealize needs to handle this, and also have a basic
smoke test of the realize->unrealize->realize.

thanks
-- PMM

