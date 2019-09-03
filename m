Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E876C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B8222CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evntCF+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B8222CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i56Ct-0007Gh-12
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i56Bj-0006pf-KS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i56Bi-0006Gg-AU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:37:27 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i56Bi-0006GE-4L
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:37:26 -0400
Received: by mail-ot1-x344.google.com with SMTP id y39so6190839ota.7
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=p8qzKcOboRQBd+uq9Q6i85Z9I7cScvE50vGzLleiZLE=;
 b=evntCF+cOQ5ObInf1VFlzHlnVk5EP1OHzZvhMPDAnrkGVKnAaYpGrdej1Pg0cO5hEl
 sFBz3Z9fPXCLGE6u+vZyZ8ITVLiXEEQrtcuVmL+hig/zO0KmziCdFhRd0nxSMBa4ULY/
 egsAJ7j5IurQbX7V8oNbm+FoYRoi+6za5AilU2Avjt5zpB0e05Cwl6HIFzkCqIxXlttY
 yBIkoYsvqf67ury0YH9rz/UzB4SqQU5Dpt4uo5JsvOWUc7C3vW6rjK0TeeNVlwUb9nJy
 Zf2ViiMj+REaIviNZo7sIJxeB77jGh3QUIJIdK+26g0Mbepanz6P+JdkN3VZeWeZanLS
 WISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p8qzKcOboRQBd+uq9Q6i85Z9I7cScvE50vGzLleiZLE=;
 b=j9rrU1V4/M7nedndZu01ZhOZlnh6OV8GXeJf90pz+rNHzd8muq68ShGx81B7KnoEAN
 0ATQqbZMV2Ai4hhsfHcJoIgDpFkPxZTEoDoA0OH/+hsndfSs+SE7pEElft7toIe7dosZ
 7n33stiKO2czEGzUT43zBF1uQDpUYQN55kzO/oTZPyWsYMvlssoBKepb2zN+oBp+A8BU
 ffWxNh6GZ6PDzbeFF4vBqSJPPom380oPLH44tCV7m8bmmEhWfMaRepZIb4JegoRgFGfC
 LyB3ygccZVNI0kwGh7ShHH6Jo/pyYqaiPFtFivK/viaJc6dpk6nEuYRMZ1/JeXJ/ZEl4
 P3Kw==
X-Gm-Message-State: APjAAAU/+Z3uLs07tctAqgGdnhnkm6uNkSp5qBFsYCqGnD0wzK7fOYoY
 ujM39BpUzSzSXvXuqlL7vyE9+2YTH1vvwviBOPoNlg==
X-Google-Smtp-Source: APXvYqzAoQgp+5hTXMZM0X01A68OOaZIklfURECOGMFOCI+1cMMXGjAe/WfcpvdU/ghmBHY+3EAOhxyQrRsqK8MDvzE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr28386708oti.135.1567507045091; 
 Tue, 03 Sep 2019 03:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190828165307.18321-1-alex.bennee@linaro.org>
In-Reply-To: <20190828165307.18321-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2019 11:37:14 +0100
Message-ID: <CAFEAcA9zTL2Cn7dpibW9aVk7ev3XPPtF00YUL09uZbhm2X6-2g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v1 0/9] arm semih-hosting cleanups and
 other misc cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Aug 2019 at 18:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Hi Peter,
>
> Here are the ARM semi-hosting cleanup patches and a small selection of
> miscellaneous TCG clean-ups. If your happy taking them all through
> your tree please do otherwise I'll poke Richard. I'm just trying to
> reduce the delta for my next iteration of the plugin series.
>
> The following patches need review
>    04 - target arm remove run time semihosting checks
>    05 - includes remove stale smp max _cpus externs
>
> The first is the result of review comments, moving CONFIG_TCG ifdefs
> around and the second is pretty trivial.
>
> Alex Benn=C3=A9e (7):
>   target/arm: handle M-profile semihosting at translate time
>   target/arm: handle A-profile T32 semihosting at translate time
>   target/arm: handle A-profile A32 semihosting at translate time

On closer testing, this patch breaks the semihosting test suite:

$ /home/petmay01/linaro/qemu-from-laptop/qemu/build/arm-clang//arm-linux-us=
er/qemu-arm
 usertest-a32
hello world via semi_write0
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)

so I'm unqueueing the first 4 patches (but have kept the
misc unrelated other fixes).

thanks
-- PMM

