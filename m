Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2EEC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABB520B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSR76XfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABB520B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZD5N-000293-39
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBmu-00066t-0H
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBmr-0003VE-Rk
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:07:55 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:39444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZBmq-0003Qe-Ea
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:07:53 -0400
Received: by mail-oi1-x230.google.com with SMTP id m202so1037044oig.6
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=elBvZ4wTXKAyEGsuylqaCQ1KiohdVTFPu8177gmCtzI=;
 b=DSR76XfV6aP93byEyCozeeoIyDA9yc2mU9f0/+JiK7c4i20kFybcQweGOOoAxcX5/E
 I8CUAvyE2W0qyo+YEPdhzOq2L9DlnAPR11s7LmgMH9nLDfSbbUckGDm2Qe8IkOE58Vip
 szYzypAaGAow/nI3YSZv0fauDW5//tNyC8qjeI2JWvyYFYGPuo2Cu4Rn4RHtF1mf4gW7
 9PA9zfLmY2DmrXLUqoz+XR6uvsPKYRd3yEBAsn56WASlvVYM5TPapy5EjNpIcRJSeE5r
 jyQQMA3UIpv2dFTJyIgE5Sd1p18JHZFI4jDTHQvJcwtMYKQVIDCw3vMIepR7oWUKhurf
 Sw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=elBvZ4wTXKAyEGsuylqaCQ1KiohdVTFPu8177gmCtzI=;
 b=T6k0whcAdgIKHbY1Ile8gGkeapUtOVxsjoqZlk1zAcdUmX9dlJi8k/TTCcuuPEuCVv
 vDMjyZ2/ofb0kb/Rj4dsN7Ito1l1US+7ptSqUzwu/3TWdVoxWbDvD9sRbXkc3hyda2dl
 XW9aB3C/+lbQPQ0OO9hQCaVtFWBYTBzEsuWwVbjp4ik8ecEeFQlOVVFNRDdFBKHjpyja
 kDXTGD226RUa1T8XXeBFIw8I5TmeElPeP1Y3JsNkZsWigtpF1IAbJFZiBVjbtGbvEiak
 FAkLayVOqc+ogK4hY09kYrury9GqQLF7/uZONpjEYdJNApsa5Rlepc+IatziL4oQMMtt
 uZ2g==
X-Gm-Message-State: APjAAAWt+YIyI2eIoDoUoLJZA4+LO9I8ka+eaj1k6YriDb6oKnqEUtA/
 x+hJnfMml7OPJVhrORN2UDES+WXGS7ivCCL7LxH5dQ==
X-Google-Smtp-Source: APXvYqwdI79GAmqe885OJdzTWzZL6+oAu8aQd4dJGmICMVabVMOHL94oproPPQU599MqXASYFBIYnuUZg7F6m2R1zR0=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr3108311oie.48.1559902071231; 
 Fri, 07 Jun 2019 03:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190523204409.21068-1-jan.bobek@gmail.com>
 <878suw194o.fsf@zen.linaroharston>
In-Reply-To: <878suw194o.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 11:07:40 +0100
Message-ID: <CAFEAcA-EN4cS-T3qKeVdGo6124J6e=7z3kjua5oYyomcw7LB4Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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

On Fri, 24 May 2019 at 10:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Jan Bobek <jan.bobek@gmail.com> writes:
>
> > This patch series adds support for i386 and x86_64 architectures to
> > RISU. Notably, vector registers (SSE, AVX, AVX-512) are supported for
> > verification of the apprentice. This is V3 of the series posted in [1]
> > and [2].
>
> I've sent a patch to enable x86 in the build-all-arches tests script but
> otherwise I think this series looks good to merge.

Alex: So should I merge this series, or does it need a respin ?

thanks
-- PMM

