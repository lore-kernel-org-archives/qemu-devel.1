Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3931CC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0055120578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIfcfGNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0055120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPl7-0000C1-Lq
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPhd-0004PP-Se
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCPhc-0002z3-Ez
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:52:37 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCPhc-0002xx-7N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:52:36 -0400
Received: by mail-ot1-x342.google.com with SMTP id m19so10516884otp.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iTbtJjbk8lgdEI0M1s4ncYPkAsxfZSTy4Hjoq28vzsQ=;
 b=xIfcfGNXukaILQEp/rh5XPacs37pF1Y4qkYF4QQy6svAPhi/n3RNbpWLaONPBQq4KS
 uxwRU7NWP0WC5oZKBnt6jKBpbGfInE/HXuJ9n47M6Cgs20A0YxNARq+S5f9ALzL++tiH
 dxISrAKKfKqK3TBlxIxKrKI8uwgWv0MHOHULwChIvZ2jNcw9I2ySp16I5z6qz6xu6sIl
 +Ixj0xM8UR2L3djaE/W9ovRLVUEX7IUN5PGS/xRHzXZtjBDw9/48o14OuVrdVcKFlP4R
 txYGSW5Djc0H6/GtidNTCxM+9KAz6Aq7FYOiQ7fdi+uMIxM9wByY0nYtBC07yBLlw/Tp
 GN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iTbtJjbk8lgdEI0M1s4ncYPkAsxfZSTy4Hjoq28vzsQ=;
 b=WScZkaWRUlK8lataCLqsERwE96iFvDj2kNXujnlzlLvk5rcDvFjbJAUeMZPKi/qAV+
 ie2ucqdDMQsjXZybr7l5/bef/jncUqrjLbmler9ioE8rJ5aGelzounf+/+/NWUaDLkuy
 U5QMyNVHZYVPNW82c1hsnkXqs6WxE7Osj1NlHqP+R/aPV/J+ORNClSTdKQOX/1HKrG9k
 VsduXtYrggmqNy39s+rogzm66fJXT3Aywsg4gCBVSfJJ/xT5+vo8gtW3vinfNzOWaWst
 VGFrsJ7hRx2xF1dawpcIBW0YiElHckCqUzeJANqo5LufTWKqpu9EZmL/Rd5YmgSGwe5Y
 EIAw==
X-Gm-Message-State: APjAAAX7aumn6CdLX+69wuLsfE+4ai4VPYy0G2h5Aow10vjUxfXCgW40
 Q5nEL5/C52qvfa1AAwzUYajlQD9+s/OMZsjp5APvKQ==
X-Google-Smtp-Source: APXvYqy/jwhz+An55w1fZvfKismrlNzdU3/yV9yTP6W17TFH98W6R+OL11dZ3Nzw4VHVPfcESH3EV1ROut01Ax4SvTY=
X-Received: by 2002:a9d:562:: with SMTP id 89mr194605otw.232.1569250355095;
 Mon, 23 Sep 2019 07:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190921150420.30743-1-thuth@redhat.com>
 <20190921150420.30743-4-thuth@redhat.com>
In-Reply-To: <20190921150420.30743-4-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 15:52:24 +0100
Message-ID: <CAFEAcA_6UxMBeyOMM0iT5cnCQEpWXfRO2XMuV9ez_0Su2osXNg@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm: Move armv7m_nvic.c to hw/arm/ and always
 enable it for arm builds
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 21 Sep 2019 at 16:04, Thomas Huth <thuth@redhat.com> wrote:
>
> qemu-system-arm/-aarch64 currently can't be built without setting the
> switch CONFIG_ARM_V7M=y - which we currently always do in the config file
> default-configs/arm-softmmu.mak. This is because the code in target/arm/
> calls many functions from this armv7m_nvic.c, and thus linking fails
> without this file.
>
> So armv7m_nvic.c should not be under the CONFIG_ARM_V7M switch, but always
> compiled for arm builds. Since we can not simply do this in hw/intc/ (with
> "obj-y += ..." it would get compiled for all other architectures, too),
> let's move the file to hw/arm/ instead and always enable it there.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Makefile.objs           |  2 ++
>  hw/{intc => arm}/armv7m_nvic.c |  0
>  hw/arm/trace-events            | 17 +++++++++++++++++
>  hw/intc/Makefile.objs          |  1 -
>  hw/intc/trace-events           | 17 -----------------
>  5 files changed, 19 insertions(+), 18 deletions(-)
>  rename hw/{intc => arm}/armv7m_nvic.c (100%)

Please don't move this file. This is an interrupt
controller (with some other functionality jammed into it)
and so it should be in hw/intc. It's true that it's rather
tightly-coupled to the CPU, but the same is true for our
GICv3 model.

thanks
-- PMM

