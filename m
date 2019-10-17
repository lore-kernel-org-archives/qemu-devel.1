Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D90DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DF920854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqoH7dIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DF920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4aa-0007vU-6K
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 08:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4ZI-00070J-NJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL4ZH-0001kz-OH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:07:48 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL4ZH-0001kt-J7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:07:47 -0400
Received: by mail-oi1-x243.google.com with SMTP id w144so1916581oia.6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=e6dbv6Kqq67lv11A6nCDbRmPwgPO8LDQFivKOLzVBLE=;
 b=PqoH7dIT4PWDN9yD0WPufRXGOqKYryoX6kDLaB2WQsOsFM4YJ6BX+Vd0Q1QIn6bCMU
 ILjNiGTq6TlxD98x8Yyl7buANyUenIhy2WqvHWiiu1v8+TIfMlwlr1s0Odo7voTKqZzY
 Divmlotpf4MRFH8ZJsNKw2Rj7+Jh6OUgpYGoCdZ2su+/SLy8TXDcsafnAvh7xtCO57mk
 ZSZh2ZbxMS7+bFn2GvG1T0Q+zWkXnHmj32cynzcJCAfXDSnF8ZfqfSnypGRrSKJly/oF
 exOAPWh3zt22vnQyG6KmGEZ4aCzpbqkVucmVGhLfOa+OEBUtSdTNaaDo/+8eZ8JSv/Vn
 +Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=e6dbv6Kqq67lv11A6nCDbRmPwgPO8LDQFivKOLzVBLE=;
 b=kpcJtSlWWJwtbroDv3TGHp5VoyLjBaM32dHUg/PuQsC80DzHMrETQagN+5d1uU2mkE
 GklSFryV4FRHUwHQwY3aphtEZO6vFG/VQDJnSjOOMSbWCUme3YgnJQHHA4GrwhJHvCvB
 yXf0+sXaPxfXY64ZmnCfoP8TzksiGuuEsMaSDC3jM9fwhcK2AB8x+LfFdAGtfJTBV5rB
 2xuwWHo0ZqwmH+KKQANUglFdWxre4xy7GBAt9irjSBYShEimCQJMQB5IfXWMnbOHODPJ
 wpB75PjqJrxWTD4UPKrHnAWXMkRVHnoApH4ijD/ziWK0S8Ey4rzcB7pKy9Z8s5jOFckL
 jRUA==
X-Gm-Message-State: APjAAAXiHrUosDeP+7c8os1Zg9eRMTacw+ynn+cRo+59xUgynT4FYCvO
 GMSxJX8JLHcTnqgQAUO+DT+hmyzSznocot2R5rBIivUTWwg=
X-Google-Smtp-Source: APXvYqzE65HIR9YQD8/LG7njaovwUFdxCUbsveB+9GRbRNJ//jUqfTurr1tV69Wv7BACVT1JI/TIvqix57pzcRzcj50=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr2748253oik.146.1571314066544; 
 Thu, 17 Oct 2019 05:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 13:07:35 +0100
Message-ID: <CAFEAcA_yHtDR=bjVR3brqsTeYoae7_ixADOS2ve+qQOyhoQo-w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Audio: misc fixes for "Audio 20190821
 patches", part two
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi -- not sure what's happened with this patchset, but
can we at least get the first patch (which fixes some
coverity errors) in, even if the other two need more
consideration?

(cc'ing Gerd as audio maintainer.)

thanks
-- PMM


On Wed, 11 Sep 2019 at 00:27, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice=
.hu@gmail.com> wrote:
>
> Hi,
>
> This series contains some random fixes for the "Audio 20190821 patches":
> a coverity bugfix and pulseaudio connection/stream names fix.
>
> Since there wasn't a clear consensus about naming the pa streams, I've
> split it into two commits: the first time just uses the audiodev id
> unconditionally, while the last commit adds a new option to qapi to
> override it.  This way we can easily drop the last commit if it turns
> out to be unnecessary.
>
> Regards,
> Zoltan
>
>
> K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (3):
>   audio: fix parameter dereference before NULL check
>   audio: paaudio: fix connection and stream name
>   audio: paaudio: ability to specify stream name
>
>  audio/audio_template.h | 7 +++++--
>  audio/paaudio.c        | 9 ++++++---
>  qapi/audio.json        | 6 ++++++
>  3 files changed, 17 insertions(+), 5 deletions(-)

