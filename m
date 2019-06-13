Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112DDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC94420B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekvsw4Ei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC94420B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQb8-0004l9-3N
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbPnz-0005lp-Mj
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbPnu-00079Y-Mk
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:15 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbPnu-00078C-HV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:30:10 -0400
Received: by mail-ot1-x333.google.com with SMTP id j19so18964886otq.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=72I0M+sAdg5Hz9N2FoCUAjzdNN5xrSrpkHbPvg4Wojw=;
 b=ekvsw4EilV/myGwWcwh2118uvmzJo9+x15SzxwbhHh8Ax6bmSDDKW+Aygjb+JCPqTs
 XADU2OAuQX7kMtkvke8LcwKBjeep4JGLkhd5syuA4v8zMVR223E/JS7QSLziDiQ4e1Uc
 9rEYE4fP0+t/61AjuiwvzJQns4s4h7gNBf1QcqKz4S/M1mDt64Az+Sl4A/RuW4Xhnrw3
 +vrb5vg2e0K8j8SlHLzg4fyBJJ1vsK67g7F+1IElmgmHkgcTW6lfh0fIzECX2KPiY+mD
 fglEWyugbh8H0AH+PF3XIIdM9wt10f9Iasqhg5f00+WEL9Dy7FXlK4xKh+rr5464ZGsd
 75HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=72I0M+sAdg5Hz9N2FoCUAjzdNN5xrSrpkHbPvg4Wojw=;
 b=I4TWJzMQVLQg8uo7e7nagK/tIDUaH64Tr9nj/5zgieGnlLkhrVBuHw4xts3OYrzhBt
 Cco03b6q1gVSJUjA7VlCGaaTct/GHsEjfcu88SYNnH5aGOLMe1qyquvrPgEmms0I2vRr
 zKnU8BH8jB5nntUaCeeO3H4X8F4S3jwLZPVgRS7MONGQKoqBKqZkNZEE0fvilerqCY3M
 7R/Y7L2hbU32QgKg1sjGF2Pt6PJxyf9+vYu6T9qHUSBW2d9NaS9UI7afoFPrMD+u41W/
 +XkWsLBdeWjAKLonZ7MqejZPAJE+g/TjQJekw1j0zl2yEewOgQNGvSk/ycbwTwTFrKrT
 sMPQ==
X-Gm-Message-State: APjAAAUgYEQ5zAbcOW97uxi7pkUD2PSfk0BbG7nQACdav+U87200HV4Z
 BbtksWQmQhsFlnB8cDz/EDTUxh7X3fxyW+hA2mfl8A==
X-Google-Smtp-Source: APXvYqwUY81b/AUScoNEn7t9h+qQtAfHyz6nlx9HNDBXF946GBQKzj2UiWiWzYvpRyCHmFoZm4vpIy5akQreAXnPh6Q=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr8566482otj.97.1560432608583; 
 Thu, 13 Jun 2019 06:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190613073834.22001-1-kraxel@redhat.com>
In-Reply-To: <20190613073834.22001-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 14:29:57 +0100
Message-ID: <CAFEAcA-r4nT+GpgyNHkaFmVov3WzZagp8+uV+brePPZgHtcpzQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL 0/2] Vga 20190613 patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Jun 2019 at 08:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit a050901d4b40092dc356b59912c6df39e389c7b9:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190612' into staging (2019-06-12 14:43:47 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20190613-pull-request
>
> for you to fetch changes up to 0a71966253c8b07586ebd6bee094a818e1e163b8:
>
>   edid: flip the default to enabled (2019-06-13 09:34:50 +0200)
>
> ----------------------------------------------------------------
> edid: add xmax + ymax properties, enable by default.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

