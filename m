Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83818C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1C42086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvax8AxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1C42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52906 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcuv-00028k-Io
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:16:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQctv-0001oW-SO
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQctt-0005Dr-58
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:15:46 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hQctt-0005DV-02
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:15:45 -0400
Received: by mail-oi1-x242.google.com with SMTP id l203so13032107oia.3
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=x4w2r9YA+HRGdq8Z+OXuXHjptP2bwzNiRTOrt3ain7w=;
	b=Lvax8AxOrLlcelE31A0zfTQWAQcReVSqgM1awcTBquiwXsRqsh6fqPhYjuIx/eVrv3
	sWxM0yYq13+DH/3T81B0prQsO66FMqnGA9QlR5k0lnHy4b2pEG8bEO1IkCndRXHhtT8g
	MQKX2UbkzJOKRvx8Gb+OLpjjlZeQXZs5Qpf5hqoXiDy9t0r7yzYpa5GYgtenpt+ypMfP
	EJ4Oh/6yk9727gTB1KTLDmv3Pbu4tRWVJkLwG77CkO4xYPKnHFZ0Q86snENfHVB2YJZe
	HlQW/KiqIznJafOfF8/BN90iqq26pPQoztObQgp/m4xHlmSehCm1aTjWEbTc9PA/VONM
	/jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=x4w2r9YA+HRGdq8Z+OXuXHjptP2bwzNiRTOrt3ain7w=;
	b=Y2/24bzXtv0e1l4e+bca3KKh6UHnTdM9ZGwXUCdNpKq3pBsRTPdoxM9spyWr9apRJ3
	B9MA+0RLm08hAzJ8zAHVe1Ura5rdAK9lH8HOZ9KSjAM1UO3MVj7Y19I3GIFLjkhxlclg
	UDeogP8YiZ526Dquv/cNb91K51GNY+0SW+UmH7bIBp2Czbnboapuy8OTU6Qv9/yTj9Sn
	qcYiTSnoMlsmlcZRRZHwdAj8W6L/oPhNlbsd7SjUnN/YKzlxVAEivaHfb8F5RhEIlEJS
	uVuQBARMiJGvTfDZasG3LtBc9TdqnNNvNLptwIl/5j948Bk/WtvLyqnw13Cqz5CBTVVG
	nzXA==
X-Gm-Message-State: APjAAAUpJHB2VtevzqBGxkuwH7UzzXmM/lIZhoPeGsE5gQ2pCNk5Ejbr
	LDABziQioQ/t4lO8l5eILdUCcpExMSdsX9V8jTs=
X-Google-Smtp-Source: APXvYqzM2tqXEQItartCkt7R3KdewtEoofklAV0TdMXXapByBZGjQ5CdLPwzXCgbH80excvIU6+he4dYEjr9rSjkijQ=
X-Received: by 2002:aca:6086:: with SMTP id u128mr3613491oib.79.1557861344209; 
	Tue, 14 May 2019 12:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Tue, 14 May 2019 12:15:42
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Tue, 14 May 2019 12:15:42
	-0700 (PDT)
In-Reply-To: <4a2f1364-b7d2-209e-3d17-ca1eef3b53e3@linaro.org>
References: <20190510203452.11870-1-richard.henderson@linaro.org>
	<CAL1e-=hE4zMwDewsbD6=Kc32Ss9wcB-AyOtY-G=HhDKS9YMOoQ@mail.gmail.com>
	<4a2f1364-b7d2-209e-3d17-ca1eef3b53e3@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 14 May 2019 21:15:42 +0200
Message-ID: <CAL1e-=hsgj0oq_4VUX97KRm3eJovXLw4G28dXiU9X+XA6wsQ2A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
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
Cc: samuel.thibault@ens-lyon.org, qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 13, 2019 11:14 PM, "Richard Henderson" <richard.henderson@linaro.org=
>
wrote:
>
> On 5/11/19 5:47 AM, Aleksandar Markovic wrote:
> >
> > On May 10, 2019 10:36 PM, "Richard Henderson" <
richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >>
> >> For linux-user, there is no need to add slirp to the set of
> >> git modules checked out, nor build it.
> >>
> >> This also avoids a makefile bug wrt insufficient dependencies
> >> on subdir-slirp.  If slirp/ is not initially present, the
> >> dependencies that check it out are associated with softmmu,
> >> which then generates a build error on slirp/ not present.
> >>
> >
> > Hi,
> >
> > Does this work if only user mode targets are specified via
=CB=8A--target-list=CB=8A
> > switch?
>
> Yes.  There is a bit of code that converts such a target list to the same
> result as --disable-system, which is $softmmu =3D no.
>
> > If no, the patch shoud be amended. If yes, the commit message should be
> > extended.
>
> Like what?  I think it's pretty clear as is.
>

Richard, no. In this case, there is a glaring discrepancy between the title
and the functionality that the change provides. Much better title would be
=E2=80=9Cconfigure: Disable slirp if no system mode target is selected=E2=
=80=9D.

I leave it to you to find out what can be improved in the commit message.

How well did you test your change? Did you try some corner cases?

I don't have concerns about the wording of the commit message only. I agree
with Thomas that combination of =E2=80=9Cno system mode target is selected=
=E2=80=9D and
=E2=80=9C--enable-slirp is used=E2=80=9D must have some special handing. We=
 can't just
leave the rest of the script to do whatever the current code happens to do.
The patch code should be completed.

Thanks,
Aleksandar

>
> r~
