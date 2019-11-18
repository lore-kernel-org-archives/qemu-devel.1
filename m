Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B46C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A775B2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRCDATzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A775B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiR8-0003Vh-Oq
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiQS-0002oB-31
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWiQR-0001Qp-0p
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:54:47 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWiQQ-0001QH-PD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:54:46 -0500
Received: by mail-oi1-x242.google.com with SMTP id j7so15554189oib.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IJ1R95Tq2U323m+SrNCc2wMVXEs4GOpGTfqI2NZcmwo=;
 b=VRCDATzX6fFSmHaGj0S21jhf1EqmtxJILSjPyKwXvO7b5JN09YRIFMMl/8PbJ54Pic
 Jw5q11TRpKkautVM3DyUko2IV5cY+JYTTYw5Hw2Sk7XgxBquqZvjmEV1k1D7+fQI3vR8
 njVlrfGSmmzzCZPW91bXTuDeaQn7fKqylRuXuYGWukQd/bg2jvY6C9/T75s/4a67oGpl
 G6PkipQOsSvGf9SfnpBLqHmg/VZ/mVLqH3dbzFkkwY3HvUeuvkGOD4XTGK7NxEPNdmga
 jTzMKfEKWrT3dTufgZ23NJIFrc9ZMRNsdfEhlFEeu+JVJsJXSBcJsLAeMLdLC2N/RSWL
 127w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IJ1R95Tq2U323m+SrNCc2wMVXEs4GOpGTfqI2NZcmwo=;
 b=EDTwhBUOmKD2kiUxXff5shMZGeW4LnFGZDlY4BNsj/3y1ANZkbiCXZkp9OyICSwYyJ
 ioJ9H0/GYynH49L5BnFL1Bw+aAvW9wNhRpDrWas3/aj6k8Wn7ktTDqS5o2bVc+wDPX78
 tnj1yBvflP8WF4KWN9A/0lonRdQhGDcovHxFOsallVHl8OREM3JoY40FwyoqIwtQdliz
 OKHnBBmWlDb/4COidGt1bYKhkIEq5RuJh+JCvlpk3/CNz6RnEuG0mfYuTEI/HpPG6Ble
 jRgqvTkmBnhnGV0sA3VVx2WDo7UxyDcwa6QnLvjMSSgvBT3sSaFcM7EWFA8EYPWwzVdh
 a7rw==
X-Gm-Message-State: APjAAAXfQm4P6uOIfaqQQosDzUw+VaPOlJDtCUdHtHUS79ReQaOvmNNs
 jM1Fl7yXzZ+RyQZStp/jROGyTd6BwkL3MUP3Q4zs0g==
X-Google-Smtp-Source: APXvYqyJsdfqTcgxnhlVmo3r2PxwtU+64xrSqavlwb+LbYNybIL+qcEs0EPOWtqFcjpUXaj247ltBZlQzdboN9N6tCk=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr20768047oij.163.1574088885660; 
 Mon, 18 Nov 2019 06:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-15-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-15-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:54:34 +0000
Message-ID: <CAFEAcA_2ct-fOfBGgNExjCrjg7WKb-Xp44GghHWXiW2+3HjWbg@mail.gmail.com>
Subject: Re: [PATCH v3 14/33] serial-mm: add "regshift" property
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> And a property and rename "it_shift" field to "regshift", as it seems
> to be more popular (and I don't know what "it" stands for).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I have no idea what it_shift means either (I had a look in the
git history but it seems to have been added with that name
very early on when the commit logs were generally not very
informative); 'regshift' sounds good to me too.

> +static Property serial_mm_properties[] =3D {
> +    DEFINE_PROP_UINT8("regshift", SerialMM, regshift, 0),

This could use a comment describing what the property does.

> +    DEFINE_PROP_END_OF_LIST(),

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

