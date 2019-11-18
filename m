Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1AFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9712089F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPHMGIFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9712089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWj4S-0007pW-1s
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj3I-0006kd-P1
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWj3H-0005jT-Cn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:34:56 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWj3H-0005ij-6c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:34:55 -0500
Received: by mail-ot1-x342.google.com with SMTP id l14so14840526oti.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lFcD0c4XBd2VxlKYJhUQ7FMwh9UM1pbxiLuaAZ2es24=;
 b=UPHMGIFLFrii9wDXK0ssxifqPC2W7RSbhjBdstsfKPW3KdiEcgJdk3TrtfQ4EitH0P
 dTJx9OWYXgnptDTRX3kM4pFfA+pNafwKJeCda/9mZoV1ydjmf1a5NnuuNTM8xtlxcPoj
 hno+Rwzu4Yt2zt+9nZ/+G6ohmsIFgsiVUZH1VGm2C2Uq3aFCp7lCKoUr9FG3kdocTR6O
 4kvcnaJ2t25XUEp4vpjyHIUdGmAvAvUOf39AFL9mNBGxLRIiirk+bPvuET1cYZOrp94N
 ZY+E+DlBNbJ+V/ooB338QuGLk6zhmHlz5jVLgiCVUHpNj6h7KBRmAHvzYMCwXs41KbC0
 /v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lFcD0c4XBd2VxlKYJhUQ7FMwh9UM1pbxiLuaAZ2es24=;
 b=n3Z3qYkKl/9oqG/4PHCMs6c8pIt/5ZDA0P9pgZAk1d//zPyAAcx9u4luJD+N1Edvg9
 e9AseySIxmeTr0KB3YNARCV0QqCdmnlC8oAa8IvBR6d+Zsq4T+KKdGBSuc+owZPlZDI8
 16euTL8i0JcAJVSwLWNW2oELImsL0hKBjsOa+PWW5dqowUDWSwPAqmRrBZy4vHS551qZ
 z4xIymBAruO2F4267NDeGjUH2M4GSWmTlmHavvrzWVImUeH5SLrFhjnlxL7Pq8ojGBO1
 DEVhb7pYGHP6j+vBFp898kAS169+s/FwMIx4xlzEcsoDwrfkg/PeSwCAm3SE+YRmS4JF
 JPnw==
X-Gm-Message-State: APjAAAXLuDFK4O4k/hxC9927WB098fLzUlDve4RbgtHjWRx6SWJ+/fkH
 HEjsihU4xkOoxl1bdNG6OPh+grkHk1tm2pSRnfAvkA==
X-Google-Smtp-Source: APXvYqzQVVnzCjtz2o8JtMIagY6qP3hRbZ3gw5XHJ8R6+acLqHiOw3Z5DZEw1mdMVgHZmG0ZElz0K7FFRnnD+RXs8f0=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr23006601otn.135.1574091294327; 
 Mon, 18 Nov 2019 07:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-25-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-25-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:34:43 +0000
Message-ID: <CAFEAcA_R1Ne+H5k-PYEjqX+d7G55kZNh2QTxq2WN5bv1U3K=Ng@mail.gmail.com>
Subject: Re: [PATCH v3 24/33] leon3: use qemu_irq framework instead of
 callback as property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
> "set_pin_in" property is used to define a callback mechanism where the
> device says "call the callback function, passing it an opaque cookie
> and a 32-bit value". We already have a generic mechanism for doing
> that, which is the qemu_irq. So we should just use that.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

This is probably a good place to put a comment:

/*
 * This device assumes that the incoming 'level' value on the
 * qemu_irq is the interrupt number, not just a simple 0/1 level.
 */

> -static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
> +static void leon3_set_pil_in(void *opaque, int n, int level)
>  {
> -    CPUSPARCState *env =3D (CPUSPARCState *)opaque;
> +    CPUSPARCState *env =3D opaque;
> +    uint32_t pil_in =3D level;
>      CPUState *cs;
>
>      assert(env !=3D NULL);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

