Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61711C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30152206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UtzlzH2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30152206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmVz-0004Kd-2e
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmUU-0003Gp-Al
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSmUS-0007mn-TG
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:26:41 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSmUS-0007mT-Na
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:26:40 -0500
Received: by mail-oi1-x22a.google.com with SMTP id m193so2882784oig.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TGN6Ox9UfozyD4t72/D3VWtg0772RNAUvZn3fVgPBAI=;
 b=UtzlzH2Ra9RY4NfpSi86F3dldhbTyFNZn6DJqS//CiVZtHl/nqgAuGKhLvHqETt+8z
 JwBKg+BDIQDreH7/8Km95IgicH6InaXSuV31eByRbemhe95aZ6bDsDaZtokOOWE/o2BY
 xZ21d2K87f4MnAcZPp1YyzSJ8jYibl3V50KqK1rMnQUDrMkNvj1vVgMSp6KAWjPQV1JJ
 yn2bQ8ibKX+XDrEHGrQZ7Jo+pGRRYWcY542WtGn0/WTopd6OcvzC4azLmEbp9eWehBSn
 M8T/T/vDMYayzYD0OgHI1eab7plPt3RL+80pq2zpgMS58rs3z2/3gZRBgqoB8Dd9O/RR
 bzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TGN6Ox9UfozyD4t72/D3VWtg0772RNAUvZn3fVgPBAI=;
 b=mSrbChmMhhyFo98c21a3Mnb60boLnN58jNkoWHXjt3ISHYO7rKI300xQIKJILjKNyt
 yWirooE+PqSocpYkLDoZ07CC5xM3h5vRYHUv3BdeaoeI1Y8prZKiCd26uX5kdsvMKaWR
 4z1RkRyieWjbBXNeGO2xaV2TslrZf+XL/AisYKHr6p2qf96UGwNgf0CSD1LDk5xyXdtm
 Q0LcAGa0JDUnQxuqYlBYI6DXpK4WyalOKQ70VUfsDn4GSAdIDUDcbHj0Y0roGsdMMvnr
 CYWAXJ7Aeg/6XjNpn4hpW6N1TlpD7CLdye8CLesbLRY9Bl9lPKghULEM+7/sBZ6zJJKV
 euFQ==
X-Gm-Message-State: APjAAAUkBS+uy3oE+0UmR9D6fncA/IejwkNOJu77ia7CO3Jy5SPR6Riy
 O8bR+gXOe5GD/c4JSbTius1OaZrp8DDf00FeyUrgJQ==
X-Google-Smtp-Source: APXvYqyf1XbeHA5UnIaUXyV/b8RtFchIOeT6M2F678dA1kePZfPaHaMkme8RnimlbK2deuO/e0JaaX8dRB/4+JNrjh0=
X-Received: by 2002:aca:451:: with SMTP id 78mr4890735oie.170.1573151199536;
 Thu, 07 Nov 2019 10:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20191107085525.30902-1-kraxel@redhat.com>
In-Reply-To: <20191107085525.30902-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 18:26:27 +0000
Message-ID: <CAFEAcA-N=c5ghYz3y9vaG0yx-rAGHLdFUcxqWf4vnW7uX37LiQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Usb 20191107 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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

On Thu, 7 Nov 2019 at 08:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 412fbef3d076c43e56451bacb28c4544858c66a3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-next-pull-request' into staging (2019-11-05 20:17:11 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20191107-pull-request
>
> for you to fetch changes up to 1dfe2b91dcb1633d0ba450a8139d53006e700a9b:
>
>   usb-host: add option to allow all resets. (2019-11-06 13:26:04 +0100)
>
> ----------------------------------------------------------------
> usb: fix for usb-host
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   usb-host: add option to allow all resets.
>
>  hw/usb/host-libusb.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

This didn't quite make rc0 but it'll go in for rc1.

thanks
-- PMM

