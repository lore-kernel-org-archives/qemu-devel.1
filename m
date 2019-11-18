Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5485C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF2D2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSLu42dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF2D2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60731 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWevJ-0001UY-LQ
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWeu2-0008RD-4B
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWeu0-0003WS-UT
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:05 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWeu0-0003W1-PD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:09:04 -0500
Received: by mail-ot1-x342.google.com with SMTP id d5so14132665otp.4
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 03:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KbOVYI+ydVbw+ayeWHjOmyxuU9+KfHJGy84vYvqdy9s=;
 b=hSLu42dWg+4ySTpZ2I4mGW4pAAeTzFTUAAa83tYa9VD0jog+kuZE1CvsyT2Kx2bff4
 ANbPfEKiz67XlBMgmTYa+z4TPD8DffVadWv7GL/4zQl1/a6WAKMrYWyEuTElW9tD/xB3
 eA+B4QdYQzdEvpCiILlGAAx5HNNr47PDEeRFOiCfwqTGaOgGMTWl+jdHZORoP+hIzGfP
 DBUeS+xPoMQ9EGFMpF9bOR/Xlt1MIvQjdcM7mbN1A6a7bSuDjuJMpV/EUr/xZjbSkaSa
 wA7B5BB2RookBpOTluNE4P/a5ey3sya0IfvZMun1KstLHzUC5bhCpLlI/jLlfnc8ioHB
 3qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KbOVYI+ydVbw+ayeWHjOmyxuU9+KfHJGy84vYvqdy9s=;
 b=U4zSXV/EVZwlLpvSSLp5lXpzL8srJkGzBUDEWP7JEZ4zapxnIhNJ1Jl9RYfSJ+upxX
 Hp1GDDRrPASq82oaM+f4W0V2eNMropNPILaqRkBmW9EG7Okyqd3ZXvFcXIjTJNjtcFqL
 zHaS8ILcfMo6ed96LHEbQngc/oDjaEK3hCmO32z0+7N8MxmAsRu/WDFqlQLBzvH6DXvM
 pSYkO3ll180JCDyfTY5h4qY9cZEM5OajIM4gKXHKfgJhXm1mSFaFllTtc0n2yg/J6uWe
 9TTlEdyRdNKecvphZgZL5Ndh2zuFDE/BwmNUvP2TdTMX6DXlA7kksOm12J5jjUPHXBeO
 vgqg==
X-Gm-Message-State: APjAAAX3SXdDILR5yvlddzLuimP1BiF4QSso58O6MnjZ4/0euuXZ5dHA
 OJ+z9h2NBBmAJMPcWgfH1rLnWj0dARi30o8n8zi2WQ==
X-Google-Smtp-Source: APXvYqyUh19/Z0u4lDrtc79M/2whl5pbMNjbHkZkA2bvc5AEZdmux02VVcsEWgIaHd6btvg4Adp13zGOQNiMWuXc6ZE=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr22073430otn.135.1574075343680; 
 Mon, 18 Nov 2019 03:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20191023101956.19120-1-kraxel@redhat.com>
 <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com>
 <87blt9y2c4.fsf@dusky.pond.sub.org>
In-Reply-To: <87blt9y2c4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 11:08:52 +0000
Message-ID: <CAFEAcA8yQm7B7Cdif8GtzL_67io_-DvHZzV6H+Aiy+L0CaP2Rg@mail.gmail.com>
Subject: Re: [PATCH] buildfix: update texinfo menu
To: Markus Armbruster <armbru@redhat.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 09:13, Markus Armbruster <armbru@redhat.com> wrote:
>
> Laszlo Ersek <lersek@redhat.com> writes:
>
> > On 10/23/19 12:19, Gerd Hoffmann wrote:
> >> Build error message:
> >> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed features' despite being its Up target
> >>
> >> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload parameter")
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  qemu-doc.texi | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/qemu-doc.texi b/qemu-doc.texi
> >> index 3c5022050f0f..3ddf5c0a6865 100644
> >> --- a/qemu-doc.texi
> >> +++ b/qemu-doc.texi
> >> @@ -44,6 +44,7 @@
> >>  * Security::
> >>  * Implementation notes::
> >>  * Deprecated features::
> >> +* Recently removed features::
> >>  * Supported build platforms::
> >>  * License::
> >>  * Index::
> >>
> >
> > Can this patch be included in v4.2.0-rc2 please?
>
> Cc'ing qemu-trivial again, might be a workable path into -rc2.

I've just applied it directly to master. (Not sure why none
of my build test machines complain about the error.)

thanks
-- PMM

