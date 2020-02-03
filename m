Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9225DC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609782082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 12:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKLF0J7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609782082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybAA-0003Ny-HJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 07:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyb0O-0005gu-5i
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:39:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyb0M-0006Hb-Rt
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:39:07 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyb0M-0006HJ-Ml
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 07:39:06 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so13398864otb.13
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 04:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TJOJMpimz0X5QZ3m5+Es3XMPXq8niRmGuvgUFMjVEm8=;
 b=hKLF0J7CyyK6rndGMpX77nbpz9ZwhD69F8JsDI/pRafmhkZsVFfGA/eKvtHoZgUWnp
 T0cHyGN6aK3svwfoqmZXx+2cWtZAIojtpE3EYoscHD/HabeqDiHRFocn6Y96pu96Y0tw
 VV9Y3lBJbwzEdyjOjg/RerypHzxjD5ecf5EwDMAyENidkCjh0iG0Qj/Nq7bIyfH+9QCX
 POdbwov3Kx1dej7CPDCUa/KIq4qlrNXEVLm1dh4rEUX+LV5aZixO3aL7gUDy/dqGIF5H
 yRwDyPXh2I35fkj6xexxFUH3zvihkvC+jrWKwpPJY36yjYJPXBAuEiZh8UIyMqjI8eXG
 ZWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TJOJMpimz0X5QZ3m5+Es3XMPXq8niRmGuvgUFMjVEm8=;
 b=sdAvdASZ6iKRHfKqECL6lRIM/rivu2yCQDsrZpPGXk1TfhBpBGep6vyfwtHtLmFA4W
 FdO9m+lGjZDbWoimEgYs35NA9T0BqNThDqXzfX7t7Q5HSWEulabBAUfSU//NKHc6pwfn
 id2u4X4dj/wExyX27S1w9ndNGHSvF5PdZtA6Sr4NxzWA8RWS+Ea7y4QpGSbvEQWa1Ovv
 vHviJow5J84yR+tWZEPPktELGXEszNP2VdnnhpEOc9+0ccj7Rv55qE5m9gj3vMnlg19z
 3OzfmacLXxcJmOd65ix1nxiVpFGlvolRo/uniEviaEBfzU7Susi/XYYcWiZd29pnPVmW
 U0Lw==
X-Gm-Message-State: APjAAAWtd3OS9fZpOWJZ/pdyFrFV/Rd9VbdCrS9guhwpLVv0nm44oEX3
 65SbNUhLUB7Cts14uafdD2ylwYqtGCWVJsTYxRnzgQ==
X-Google-Smtp-Source: APXvYqywVErQQb6f7cfHTpUWJyeFqNz27oMdPKSSNzVufMqm1bRie0eF/Z8Y9Msy+Za1ffQfjVFH7HURYOihp8A8W9o=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr17704599otq.135.1580733545542; 
 Mon, 03 Feb 2020 04:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
 <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
 <CAFEAcA8pHXeqtC3WT67vwC=g4Vw7BsYpDxUih1XWYzC+dAjoGg@mail.gmail.com>
 <31ba2839-a7c1-28dd-8319-1ea6defb5daa@redhat.com>
In-Reply-To: <31ba2839-a7c1-28dd-8319-1ea6defb5daa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 12:38:54 +0000
Message-ID: <CAFEAcA-kDpwAWzqME7-uKy7svu7wrJ8Vq2jxOqmjdsKXvO2grA@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 12:12, Thomas Huth <thuth@redhat.com> wrote:
> Ok. Should we then just remove https://www.qemu.org/documentation/
> completely and make the "Documentation" link in the "menu" point
> directly to https://www.qemu.org/docs/master/ instead?
> We could simply mention the Wiki in docs/index.html.in, too, I think?

I think I'd keep the current documentation/ page for now
(we probably don't want index.html.in to refer to the
developer documentation or the git tree).

thanks
-- PMM

