Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C23C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6A92146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvqIeuse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6A92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHm6-0000hV-Cv
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHQh-0005x8-5j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiHQe-0001J4-4l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:58:34 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiHQd-0001Bg-71
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:58:31 -0400
Received: by mail-oi1-x232.google.com with SMTP id w196so12784211oie.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c08WAgEv0QxCiA2QHkQco1UPhJ2eLZg+K2e9SKfQq+A=;
 b=YvqIeuseWQoNtb/OPhuygyCUZ45NyCcbDtrMAu1QWN3XLUPrnaewqmt3Q/L2bpoPKI
 zZgLzm9BMPs6d2yBKZbql7ridGDKLZauuy3R2urTh83TCWH4iNxNU4VO3GsWtc8Dkzb9
 pwTwscEiHbZk3eEmvHioqMFqFekaNlBbU6xvTOodzB4wh2OyaSs1obtKrb7h1e/Z7KCo
 rY76t70eD/2IcTL+oFppC3AAa8aMh8VuoyseVdQYWNAOlpI67jJa1EHAiVGGY9fPJZNf
 zne989cQ5WbXCvLzYA9JlOD4MyjJPpAP3IEN2qHEB042pkSdmBWhoXyBtNyJBQIsf+hC
 xj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c08WAgEv0QxCiA2QHkQco1UPhJ2eLZg+K2e9SKfQq+A=;
 b=KjhqcGrw11rI/fkbNwRsRrhUi2/qzt3xOUW+4cXKdC5KqJHGTrktHUBsexrf1NtuFw
 K09/zlpFt9YSNrqbuKq1Go0PKTE15W0fdSdxQ00vN2bxedvlCfQL3b/gqvryBGwrQ4Aw
 I+j+KD3ub6vJ87pQD3P+LIe46g0EaxtvTtLR07Gw6bNZuj8JpJLDr85P4zjO6NxdBfmq
 2iVW5xAluQCelW2SX9gDt/BpRr/ettdgUUSzLh/IMsDNhlvSmZe5uojl0W+SeffHGUAq
 iqjJu/u2bmiEbIaxdRnT0I1/wZrg7vp5H0hGw7WrkYjfKHvTWoKemRmR69p1IzJ31fqX
 cQTg==
X-Gm-Message-State: APjAAAWtO8Cot5N1CVwyzZLEuBFXGS86im8BKEgbhOvRux+vuZ1XXiJb
 bQ5HCUQi+kjsxIF562OX4ggmD/dj698IUaxVg9hGAw==
X-Google-Smtp-Source: APXvYqwtC/rov1T+vvpB5dydOgyqcyks7NtRl5Of1Z2AehqTijuCdYJm2LMThCSlddWc7sr7DM+kGKy3PiCjx+XetzA=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr2665628oie.48.1562068707269; 
 Tue, 02 Jul 2019 04:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190701111722.32068-1-cohuck@redhat.com>
In-Reply-To: <20190701111722.32068-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 12:58:16 +0100
Message-ID: <CAFEAcA_GJCoLdTbEvwMPjga=1gui4hGubi3X65SV8EZus__1kg@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 0/6] final s390x patches for 4.1 softfreeze
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 12:17, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190701
>
> for you to fetch changes up to 8b3410deb2a496866468ab949c666a21c6a7239e:
>
>   s390x: add cpu feature/model files to KVM section (2019-07-01 12:44:35 +0200)
>
> ----------------------------------------------------------------
> - cleanup/refactoring in the cpu feature code
> - fix for a tcg test case
> - halt/clear support for vfio-ccw, and use a new helper


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

