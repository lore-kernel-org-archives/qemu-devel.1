Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE81C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4386B24673
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcIcchFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4386B24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8q1W-0000wF-Ec
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8q0e-0008Ox-MN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8q0d-0006Fe-Pi
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:44 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:43874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8q0d-0006Ey-LE
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:41:43 -0500
Received: by mail-oi1-x235.google.com with SMTP id p125so224745oif.10
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8sWl7qXgM9ihdhjKFMdbKfh1ROfYoA/z90r6aWj2sI4=;
 b=LcIcchFU8xFf1PF9QSetPzLwa03POyd7dSmsxh3pRnVhy72rmSOiVzMVYEH91hcQ59
 pKvC4KLnPC3jj4jaMXR2FSIO6XF4w5Jsxprg2jjK4tHPztjmwcpCIGUa077ZXNLBYuTw
 rpnHnKZnXiV/i+7Usevylq+xjP0pNabEu+08ZJ51Hz3Y+eM22cFdeSW5jNqdzYO7cbZ2
 92PZSeEA5oXbVYfW97C8LL69gqiAfW6et0lT1mzy+hnoXCUnRuVsGSUQpBQRZVZ7QEKp
 2raH20z7AuXNQYTOMhQCAKNbLMUDmbY5+luXNNVpg8eamklFIqqP7moo6lQgDcZnua/a
 VEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8sWl7qXgM9ihdhjKFMdbKfh1ROfYoA/z90r6aWj2sI4=;
 b=lEAVAtpzETC9mCVdXzOCKQ08dy4ukqlGZ+MrCnrp/AcBNHYHe5boULXHNIl5ZkDPJ8
 qtCJCCZ26x+ixvNL6XaeJEDo2wJD2qFHnIRlpn8cbVTMnIL+o8w1eX+oxRzwR4rLOuCI
 X7337LO60JqQb0jnRMZ3CiJt787PjP2q/6vjko1g2T0Ln8gOF54w4rNf5iQRllh4VimR
 3TP1N37Zh8vq59AfmEU3RwiH8hTzB97jLCXkFtUiNo/2zsH22LS5ngZYyoP/mS0gINhJ
 IB5kz9XpdrSgRiRl0ALg8FwALog15PhP2zDS+s8t6qCnrPe0RnC4Z50pSM9W4BVDZ/ba
 QYcw==
X-Gm-Message-State: ANhLgQ0JXNmTvgtKcz/xUBq77OqIxx+VTAaXsdC4c6aH8VB5eFhVN6KJ
 y4UTJWSQadIzb11bat+ga05HdRgy6OalYTQGS6fGag==
X-Google-Smtp-Source: ADFU+vssMYVGSwP8DmRe0ABUj6WAAc1qWjKTGEEphQQu6q/y2inMr6DdS/nggF9Dyy8xTS8knxL7Iq0AW8LlE2G5uqE=
X-Received: by 2002:a05:6808:289:: with SMTP id z9mr347074oic.48.1583174502791; 
 Mon, 02 Mar 2020 10:41:42 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9rQ4_o53zfsdcGZWse3eYWksYJdYHLeUFhq6TcBX3_zw@mail.gmail.com>
 <20200302174551.GK4440@habkost.net>
In-Reply-To: <20200302174551.GK4440@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 18:41:31 +0000
Message-ID: <CAFEAcA8AY4ZPuWh=oPd4heepAAZziLP1DLNHhrC_3jLuMXnBcQ@mail.gmail.com>
Subject: Re: CPU reset vs DeviceState reset
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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

On Mon, 2 Mar 2020 at 17:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> My impression is that this is just historical legacy, but I'm not
> sure how much work a conversion to the new system would require.
> I see lots of cpu_reset() calls scattered around the code.

I think we can just make the cpu_reset() function be a
wrapper that calls device_cold_reset(DEVICE(cpu)).
We would need to update the prototypes for

> To make it worse, TYPE_CPU do have a DeviceClass::reset method
> implemented, but cpu_reset() won't call it because it bypasses
> the Device reset system completely.  I will do some git
> archaeology work to try to find out why the code is this way.

At least for Arm CPUs, I don't think it does (well, it
has the default DeviceState base class reset method
which does nothing). Is there somewhere I missed?

(I'm currently attempting to wrestle Coccinelle into
doing the conversion of the target/ code automatically.)

thanks
-- PMM

