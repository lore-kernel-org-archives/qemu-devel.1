Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DFC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A0B2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnDEKLCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A0B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmov-0007yG-At
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmo7-0007Wu-4B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXmo6-0006zW-3U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:47:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXmo5-0006yH-Se
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:47:38 -0500
Received: by mail-oi1-x242.google.com with SMTP id j7so3230701oib.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Vo7hEU3Mj5iG/FMHwIocJK9P4pxE2T5Sjm606/4Nvig=;
 b=AnDEKLCS1PJhKPp2rpTZInLhk1qdWj5jr21Twli/f5bwrOgm2LTWnQSfWFczqH6eJT
 w68/HVOdpyrYBQ3OvKqBMGqWDHt6QLemaRBaVhzJw9t5TVnQdebhSxy7bRuOHNN8PIZV
 Y8swSVdbkkolyavnXMrW+9teOloX9hHpYP4p3ZRczsVeCYcFywesw2WY8+FMO0hjirKO
 SjZpvSjYtfTc8EgIo/etOHm9rMSwDm5WUYmjyrY5SKuIHIHetkAXn3B/tdmKpbpL7XmV
 V2hfr7am/bjZyOzv2+BEALDLslFwPmqnicccM++ufCsNVeBKnrrlCCbouzCXNFyEGFgG
 BvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Vo7hEU3Mj5iG/FMHwIocJK9P4pxE2T5Sjm606/4Nvig=;
 b=YtJ5Mlskmo3DM0g7Cgk8BjtY01vRMg8SlQ3gWtxVNOkAoFewjI8PqObbutCd2dLsw/
 81RLnr3rJHcFIB3tnTwqNci0kzHaBMiP1QY89PbQ1raDKYXFu3GR+qipsX5dQKJ/wohv
 uQ/lyr3r3cxhYKD3pUi0gem0WC1/Oaa0UKnvsIT9az3/aWXROxuHhsfalXnXQ2mVURFz
 sh70zoTDVILjtHpQIH6BEPGe5KXJf8QbTPgxl4vgYRS9ua2wJeGLkimeFXKznJJYcaOx
 hzJZ6Q98XjvTv8YfkKZ9yzBef8QITVFNNk/ymXggUyFXS7B3yfIq26S9eIivOLfwRIo2
 6ilA==
X-Gm-Message-State: APjAAAVtchhDtzKUVLH+d5Zrfm5VnJUv1kbP55e+w9MQPk0517scg10X
 eUQdVzXOB6ozE0FyjDfT8Mc+/sHurNWmgfR6XRBwJg==
X-Google-Smtp-Source: APXvYqxi6Uqsnl4EWRZf2zi6gNPBh1H5PbqcODnfyIyCfFFNBK7/N6DatX3tU7iDpRLeKeT01uIcuUQjM/uRsseM20U=
X-Received: by 2002:aca:451:: with SMTP id 78mr7897361oie.170.1574344056767;
 Thu, 21 Nov 2019 05:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <20191120152442.26657-13-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-13-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 13:47:25 +0000
Message-ID: <CAFEAcA8aj71ue1Y_o1PphD8+iAZeOgqo647hgXS0Z22T9Qa8yg@mail.gmail.com>
Subject: Re: [PATCH v4 12/37] serial: start making SerialMM a sysbus device
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 at 15:27, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Memory mapped serial device is in fact a sysbus device. The following
> patches will make use of sysbus facilities for resource and
> registration. In particular, "serial-mm: use sysbus facilities" will
> move internal serial realization to serial_mm_realize callback to
> follow qdev best practices.

What goes wrong if you just put the realize of smm->serial in
the right place to start with ?

thanks
-- PMM

