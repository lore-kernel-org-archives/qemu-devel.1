Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B89C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCA42084A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/DiZRQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCA42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqqO-00070N-VD
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:09:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQqoe-000665-Gg
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQqod-0006Cv-MQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:07:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQqod-0006BE-HQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:07:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id z65so1362573oia.11
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=vqsI3erugCaXqXddMzoGeeqFkWiLdxN9UOH9bZVZ0dI=;
	b=Y/DiZRQrMpYbOc0ds3Yg8IYttbNZnH8CpTK8/jBLq2R2wOE/szQmicpnTy3y1BJ4md
	1ClDZcaZyk2Xk28jPXyuJsru1O8Y04JwcGTr1i5/JvrlgYzS/uhappaiKF+lMZBKwTuy
	QH7JNyMgGwdG/cTVa88izpkBHQ7bfiP6r1wqGmSvaOut8lP6uRIRpdT1qJyOF69r0ViM
	dfmnyHVzJYaDz60rVAWTNYrx801MY/waJgEBc3goylJag+egdZZgTtLuuJ4NhiDkAjxC
	04gRS/3u+RYltTB254cmgp/IcYe5OwZUxS7KeO6LCvSXxaaib5Ns/QscuxWDEgwPr8yd
	8nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=vqsI3erugCaXqXddMzoGeeqFkWiLdxN9UOH9bZVZ0dI=;
	b=mfBJnpWg2JANnrZJi78W693Z9MGkArKGFUIWOMND8OUi4kGigP81bHHXcT773x6cU4
	+pXhuX8W/zFD2O+MsB//Z3kM5m5iiRAVD929Netqd9M1PATCWGvTfGcqPVdcwmsrBmSF
	JQ1ifZuSuvr7AL39pBe6W9ZzdtqZJazrKR/jLFbn210zBJYx4jw3VwqeaDfEHxR6OuLY
	IbKxfMsUBuo9fb7ufYJXPUAkGty0it4qRgVSGU4g82zn1M1ygabOT8P+SfAon43LYlDF
	+yeNa6mqpQV/T/3o/PqzoXdyjrTsBkzeJP8kf4ib8n+jGjbwC/JVjTo9v9PWCG7/J08b
	EIlQ==
X-Gm-Message-State: APjAAAU8H2nQ+ibWXwqYJiA/N5PJU8lYtpx1rmjs1IYv9FC2iYAYurw0
	fnP8QpgEMSicxccLOljRn1na9ZnFQt45Bli5kTsugw==
X-Google-Smtp-Source: APXvYqyG5CC5i3akBNghyehHTUaEU+PKOLKY6KSCcoS13Kgq2fP6FSzTF5eMs7sODj4Fu3LIfx0hmqXlaBiXPd31jP4=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5560094oib.48.1557914833673; 
	Wed, 15 May 2019 03:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190510203452.11870-1-richard.henderson@linaro.org>
	<CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
	<4a2f1364-b7d2-209e-3d17-ca1eef3b53e3@linaro.org>
	<CAL1e-=hsgj0oq_4VUX97KRm3eJovXLw4G28dXiU9X+XA6wsQ2A@mail.gmail.com>
In-Reply-To: <CAL1e-=hsgj0oq_4VUX97KRm3eJovXLw4G28dXiU9X+XA6wsQ2A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 May 2019 11:07:02 +0100
Message-ID: <CAFEAcA9mU7OPhr1Koktzttj3nzXbr6i4DG6Wzy8tgVP95BkjxA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] configure: Disable slirp if
 --disable-system
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 20:16, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On May 13, 2019 11:14 PM, "Richard Henderson" <richard.henderson@linaro.o=
rg>
> wrote:
> >
> > On 5/11/19 5:47 AM, Aleksandar Markovic wrote:
> > > If no, the patch shoud be amended. If yes, the commit message should =
be
> > > extended.
> >
> > Like what?  I think it's pretty clear as is.
> >
>
> Richard, no. In this case, there is a glaring discrepancy between the tit=
le
> and the functionality that the change provides. Much better title would b=
e
> =E2=80=9Cconfigure: Disable slirp if no system mode target is selected=E2=
=80=9D.
>
> I leave it to you to find out what can be improved in the commit message.

Aleksandar: I think this is not really a very productive stance to take.
Richard thinks the commit message is reasonable. If you have something
you would like him to change, I think we will reach a useful endpoint
much more quickly and smoothly if you suggest some new text, rather than
effectively saying "you need to think of something, and I'm going to keep
making you rewrite it until you telepathically figure out what the text
I wanted you to write is".

thanks
-- PMM

