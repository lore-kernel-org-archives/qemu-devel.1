Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC8C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 23:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 737A721582
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 23:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bsdimp-com.20150623.gappssmtp.com header.i=@bsdimp-com.20150623.gappssmtp.com header.b="SMaatiur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737A721582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bsdimp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isai4-00072f-Lk
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 18:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wlosh@bsdimp.com>) id 1isahR-0006DR-Oy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wlosh@bsdimp.com>) id 1isahQ-0000EO-Ox
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:06:45 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:44464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1isahQ-0000Di-Ea
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 18:06:44 -0500
Received: by mail-qk1-x735.google.com with SMTP id w127so24352488qkb.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 15:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fbWvjh6hkaqsHmmLlzKZ+NrFiMbkbi6dxezBkCNXVIc=;
 b=SMaatiur2uP/TuNn4g0N1oq4i0PoquQqDW6JUTTR47vjYqEQ/kZ63gzoy7bYiveX5e
 XAKerB0aa/BD/jNbCxUDyh9WuVdymKUvCd9QhCF7ErYV+IZ/U5gMkRi1Euo3d3UleTjd
 v06ENoyxdoIOKK9F9aTWGq6ZNZ2+NyPhgfmdpG9tXq1i7q0IGhLOhbfOuWfq+Lt1DJiF
 T6lY+DXpcJVBB2rbBMrZ/lFa0D1BPoTexG6EmktUbi0BjhArwRxJPzdxSqwoboSXV99N
 fzMBqp2WQdXVy73sjSgW4xFeVQQDofpxa2B8yXOj67y1khgTN7nGrVSKtxwvsRqejQ1O
 kkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fbWvjh6hkaqsHmmLlzKZ+NrFiMbkbi6dxezBkCNXVIc=;
 b=ZGRxlYBSA3iEUZGa+zmec794P5WBKv+LUID5nyE93fi91/7lR7TfjyQYpPMz8n9XBv
 YpLiqAwWowIqCI1pA8GFi0iUiCd7sKgRoIIfbap/WajXF8AImwR6sG42CX9lGxmjPRHh
 Uf0FotpH31c1L/7Rkskqof7ux8SEf//f8vZACJ25fZikG6FdAwH6pl16GHXjD7d3iadh
 /OxHfkA6jiZnwEqykY7/Y0/bHWmLul0/YEhppEVLwTjL+cuvEPFvZCs8axMzSssFH/OE
 Bm6ye7TBcQnpynrzEKLfUKGNasSx9c4UT6l8sh9rZs8Sn++Bcu9jZerKRxi7gyEwaj2/
 bz8Q==
X-Gm-Message-State: APjAAAUWh5IBSM1rZrGYhWo8lS/85AXJe2l5CYaniL3PIxTxtj2GXDPh
 G9cAeZpq8SidXiPWr1qR5lEeor5qDiq3JhW2i6vkqA==
X-Google-Smtp-Source: APXvYqze5LpEC1Y/4zJQPk4yNKzxaurV1eF7Tj2489Rw/U/AdpZJk66BLIZqujC41LZERCCmRa2Q2MOv0AjOjvMIaFU=
X-Received: by 2002:a37:a80a:: with SMTP id r10mr38083487qke.240.1579302403414; 
 Fri, 17 Jan 2020 15:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20200117230245.5040-1-richard.henderson@linaro.org>
In-Reply-To: <20200117230245.5040-1-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 17 Jan 2020 16:06:32 -0700
Message-ID: <CANCZdfpNWaLOureeFTc78+EoAW+t9tu+NzcO7d61=AwuTQWDDQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Reserve space for brk
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000bfad7b059c5dfe76"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::735
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bfad7b059c5dfe76
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 17, 2020 at 4:03 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> With bad luck, we can wind up with no space at all for brk,
> which will generally cause the guest malloc to fail.
>
...

> The choice of 16MB is somewhat arbitrary.  It's enough for libc
> to get going, but without being so large that 32-bit guests or
> 32-bit hosts are in danger of running out of virtual address space.
> It is expected that libc will be able to fall back to mmap arenas
> after the limited brk space is exhausted.
>

The biggest abuser of brk() is emacs, so according to one old wag
this should be 80MB. Eighty Megabytes And Continuously Swapping.

Sorry that I don't have anything constructive to add.

Warner

--000000000000bfad7b059c5dfe76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 17, 2020 at 4:03 PM Richa=
rd Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.he=
nderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">With bad luck, we can wind up with no space at all for br=
k,<br>
which will generally cause the guest malloc to fail.<br></blockquote><div>.=
..=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The choice =
of 16MB is somewhat arbitrary.=C2=A0 It&#39;s enough for libc<br>
to get going, but without being so large that 32-bit guests or<br>
32-bit hosts are in danger of running out of virtual address space.<br>
It is expected that libc will be able to fall back to mmap arenas<br>
after the limited brk space is exhausted.<br></blockquote><div><br></div><d=
iv>The biggest abuser of brk() is emacs, so according to one old wag</div><=
div>this should be 80MB. Eighty Megabytes And Continuously Swapping.</div><=
div><br></div><div>Sorry that I don&#39;t have anything constructive to add=
.</div><div><br></div><div>Warner</div><div><br></div></div></div>

--000000000000bfad7b059c5dfe76--

