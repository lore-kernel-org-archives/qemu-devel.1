Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1664C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0C021743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4A2nGFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0C021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0peX-0000kW-LH
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0pWq-00019h-Pz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0pWi-0000IJ-Sz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:01:32 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:33965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0pWi-0000I7-HL
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:01:28 -0400
Received: by mail-ot1-x336.google.com with SMTP id c7so5953807otp.1
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dlriq+Y6J2Z+3tF8iNJdWTDXN+V13v+YaIXsL0KS8eI=;
 b=t4A2nGFlyZe9ynubQRK4IUXEnwPVzaUN4kizXki04JbfCTZDbudAH3HWAbWMErVRXw
 VqnXSGO0vSjLqISQIV/9l0Kapw1qoZ1w4avVNpC+N/1HbzA0CjcFU5//XJrLRkU+8DUh
 WCgAsN2YKB8YWKQsLtXJZxm8ivvXwlJXy63ZSy+nXjbcuKMEnpF1/1eygN/g0MUy8eLq
 IqR0sZA8JuaL3u1XxLOVW5oJHH+Dx5MoCZ845lcPHWXrGSWjiZKxvCaRfukEAhsa++EG
 d1vOnYLZSoYgXBsa3piQR86bdKarYmfV+S5WFpEYvs4T1pQdWu4Xkyr02Kb5qIjTBfSi
 aINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dlriq+Y6J2Z+3tF8iNJdWTDXN+V13v+YaIXsL0KS8eI=;
 b=TQjTO64XkOealK3IK2AMGjIa2/yER4BTg9VNzEccV+3w9+mNoOJJibzGXAqnqPfHiM
 jpUr36Ap1fFgN8NyzvvQnbevBu09vjoCi1bhS+REMPm7/hZbKAh493rwWknT4e0wbKz4
 QHSE3htgMFsh6rGFfMysKCzRTjn1lH0apuVC9bhun84X+DruBvmJ6v3YijchQjbYEbXk
 IJIi+ZPQkuc5hIRU1QO6jWZRYAAbIJWcPtGm4ucvwoZd6JJJY+ZElEr9O/5yV+bIe+i3
 xPF6UT90CnNiIYxgRnJWQIW1qrrYhzR1J8m0mxz85uXBbesKacideBbWc3pHVadAzB6m
 C1MA==
X-Gm-Message-State: APjAAAVuhdMow5EIozfkb6dHdumGgl6U0RydnjrNajbApZVXqL9sQMjA
 9t4NKsBQEJdFpCUotXeVvnif9VZhHJVMNB6BF9o4dD7B
X-Google-Smtp-Source: APXvYqw+fR6UE4VktFW0iXDg9GswMuBJUlAztknh6o1wKJSsw8xgRnPfyDO4i9vClk/XjTVReoLQbXrOHu7+KdSpgK0=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr214122otq.221.1566489687740; 
 Thu, 22 Aug 2019 09:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190822080503.12063-1-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Aug 2019 17:01:16 +0100
Message-ID: <CAFEAcA9Scj20-ozWAqR1MjBs7jaWdxk10p2j1xp7JRCVYVGCVA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 0/8] Vga 20190822 patches
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

On Thu, 22 Aug 2019 at 09:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190822-pull-request
>
> for you to fetch changes up to b7105d280cab053465de79ff1766d2f7e1ea7554:
>
>   ati-vga: Implement dummy VBlank IRQ (2019-08-22 10:04:20 +0200)
>
> ----------------------------------------------------------------
> vga: a collection of ati fixes/improvements.
>
> ----------------------------------------------------------------
>
> BALATON Zoltan (8):
>   ati-vga: Add registers for getting apertures
>   ati-vga: Add some register definitions for debugging
>   ati-vga: Fix GPIO_MONID register write
>   ati-vga: Fix cursor color with guest_hwcursor=true
>   ati-vga: Fix hardware cursor image offset
>   ati-vga: Attempt to handle CRTC offset not exact multiple of stride
>   ati-vga: Add limited support for big endian frame buffer aperture
>   ati-vga: Implement dummy VBlank IRQ

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

