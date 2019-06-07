Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFF3C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED63F20840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4UIKmJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED63F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZF7O-0006dW-Dt
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39381)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZF2c-0002vD-Dd
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZF2a-0006Dl-LL
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:36:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:42346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZF2a-0006AL-Cv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:36:20 -0400
Received: by mail-oi1-x22f.google.com with SMTP id s184so1426001oie.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Et4pCPn+fxfaROAeZGunkDRuWHaOJbTpZs8J+7mFNKI=;
 b=F4UIKmJgI3HobeDCurkMJcr25yw1bAiQ8pdFmVmmyWzgiwFgAMLv+DsRIfo2irK2im
 zW74vEIM0ChSh9881nmOQbuF4jcl2ucMcw2792tOlewrPIEUE4Nu8mR1q3U6ChFgvYrB
 oINc970viY6WQ53yFqlI8ffq4AMO91PXoXNk0+VWpSC8Z6ajCKDQMWuMxow7X/QeNY3O
 UBrNOuD3clGUpQkiboxUUvllZFt+kKv6JfO5mAnHQX7m7LLKQg6Ks5SkFLWQq8+KRNjv
 nTtjU7z79K5EYiaLNI8TQwOSwc1cE7Kp4Z+srJvnRrhRyAurgL6n3ns4kTmjOTiL/l8R
 319A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Et4pCPn+fxfaROAeZGunkDRuWHaOJbTpZs8J+7mFNKI=;
 b=eVZLoYIwdGoZGODbhNk5Ip8aBa5rsn+MhFu7i5ZT1TmRpeRQ4epRGMfXWvXUMCYsnp
 5xOKZu9Cyt1VDfcd6iUXraOFXBBTbjadTtJQGUuPv7K3MsypBlNzPZm+YiKPi5k/9pWP
 rI2yTeROJk6P+/wSCesfxUVCQ5m/jPJmLIByffOdcopVJoxO6PlBLbaiTswFhGZk6x1F
 EbqqrQ6/x0Iy8f65owRjlv7Yn95/XMb+brvD1aRvX2IC5BgVsaluhyuioYIZr235l7Ru
 zqH1gb8SG+jagGsTOff2nal0A4W4sR8WvG2F6VFogK+dj4lxNyYC1JkuU7I34oagfNrB
 injQ==
X-Gm-Message-State: APjAAAXyT56N2JcPcO0opY3cIbuvU/U0ftoVuERhc2yD0SAdk97BMosx
 S497AqPtIwdH9nMl0gqZYWgZRDhr9FGx36XOTMHVuw==
X-Google-Smtp-Source: APXvYqztbBg583JqeUln8/aAyqXlGNmd81qYvEXq7esPhpSDsmynEmp2Up4dl6PnOgisS2qrbwZljSbiKc8mzTiwbr4=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr3846484oif.98.1559914578894; 
 Fri, 07 Jun 2019 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190523204409.21068-1-jan.bobek@gmail.com>
 <878suw194o.fsf@zen.linaroharston>
 <CAFEAcA-EN4cS-T3qKeVdGo6124J6e=7z3kjua5oYyomcw7LB4Q@mail.gmail.com>
 <87ftolsj2n.fsf@zen.linaroharston>
In-Reply-To: <87ftolsj2n.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 14:36:07 +0100
Message-ID: <CAFEAcA_WryjKxMe6wmDN8QtEJd8vETxo-79WFXHTEc5qFvrEWQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [RISU v3 00/11] Support for i386/x86_64 with
 vector extensions
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Jun 2019 at 12:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 24 May 2019 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >>
> >> Jan Bobek <jan.bobek@gmail.com> writes:
> >>
> >> > This patch series adds support for i386 and x86_64 architectures to
> >> > RISU. Notably, vector registers (SSE, AVX, AVX-512) are supported fo=
r
> >> > verification of the apprentice. This is V3 of the series posted in [=
1]
> >> > and [2].
> >>
> >> I've sent a patch to enable x86 in the build-all-arches tests script b=
ut
> >> otherwise I think this series looks good to merge.
> >
> > Alex: So should I merge this series, or does it need a respin ?
>
> I think this can be merged. I assume there is more to come to actually
> generate the patterns but it doesn't break any of the existing stuff and
> has at least one test case.

Thanks; pushed this series and your patch to add it to the
build-all-archs script to risu master.

-- PMM

