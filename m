Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AF9C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F420820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRmbFYKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haO1e-0005Ab-87
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 13:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haNtu-0001Ou-FU
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haNts-0002en-KQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:16:05 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haNtr-0002aM-Qp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:16:04 -0400
Received: by mail-ot1-x32e.google.com with SMTP id l15so9012270otn.9
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e1FcQZYscdw+pGkCSgNF7N2a6MlDv12P2xjFLyweMjk=;
 b=mRmbFYKt0JC5s0Pb/nY7+APQhc/WFOs5zxd4B9GeIBITphymujA66DNJ+aKaK6XYIu
 P80TnDkmUegOVgsOkmG7amyt5RjxCa6vUs5wvcdCln9CIOLx7B9cBVMkVQbvbe4dlFiU
 QaosU9XeBL5+H/aHkD8JumMCV7jAiS2xFh8PjsEpfcP0o+1RXNYdUcyy/ka4/zv2yD6E
 WbtwlEh8+KhNjmCepgE0P48l9vjhRFZwopZDpjgTAUtXvaZ94KsAiztqlKxhjLBS/PsO
 BYj36Fj5Qs7X9tJHgTbRjltWSdyNIyCBVY3JglJlvPOBhwFgpePjtQdaseO/y0s9lpih
 8Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e1FcQZYscdw+pGkCSgNF7N2a6MlDv12P2xjFLyweMjk=;
 b=crUkcjSGjc5BBU5/GLDvbmQ75GKcztwzb2IuRL7bfvXAYkijMNaI1MrfsDAHNAAspV
 R9mfp3Jg2C/xGR3MA4Y0vdfb5csWTCNf544QtjS6ISNufDDD296QLEayq9bRNyXz5GRM
 ctYmiueJyR7oeXN+uoBDLBxBvHTbAPM6HH8oquvq3QzhE2SA1x5GNNjsX/GdJa3CjNaQ
 dzJPEggq6IBdHZMQtImjbLyaFh6NX3rsfXbSSJd1EvGfJXBsbymmwKqfZTjG340TCfiJ
 2iRq6dR9/zZ1gTm0DJ8/gi4CFIXVsl1nUzCBoN9BXAd+5J/tmlQ5catBfAJHyGaju/us
 zp1A==
X-Gm-Message-State: APjAAAVGgyy4ByJ2FJbs2nYRIfff9HMSwr3dAhRkvuVfUEPL7mXA+Hph
 cb0J/f0ajG8X7Zt59HE+5EJ+pLjuPR9BOaIDfTRGUg==
X-Google-Smtp-Source: APXvYqyYbUzmbSRDAGrOe76z/J2SeiQyIOumG6ZYj5lnWQYjnj2iNqAIR85o0q+GJIae5QKsL36iJr+gV+8DimKH+/Y=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr31511487otk.232.1560186957241; 
 Mon, 10 Jun 2019 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190610131105.GJ22416@habkost.net>
 <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
 <20190610171213.GK7809@redhat.com>
In-Reply-To: <20190610171213.GK7809@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 18:15:46 +0100
Message-ID: <CAFEAcA8L7dFfwi84_wLwEV1xYyyAbf31WxiqCf_z_m8p0SAhhg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
Cc: Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 18:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> There's been two new LTS releases of Ubuntu since then
> with Xenial and Bionic, so IMHO, it is pretty reasonable
> to want to drop Trusty rather than continuing to spend time
> on software versions from 2014 and before. Both our Travis
> and Docker setups use Xenial as minimum and the number of
> our developers stuck using Trusty is likely negligible.
>
> What gap is your gcc compile farm filling & can we find an
> alternate way to address that gap that's viable ?

In this case, it's the aarch64 host. I can probably
find something else to run this on, but it's not going
to happen immediately.

> docker containers for non-x86_64 arches that cross compile.

You need to actually run the tests, so merely cross
compiling doesn't suffice. (Running 'make check' catches
a fair number of bugs.)

I've asked the gcc farm admins if they have plans for an
OS upgrade on those boxes.

thanks
-- PMM

