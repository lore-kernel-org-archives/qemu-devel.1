Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C46C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1113420678
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcL0N+Kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1113420678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBPp-000332-8q
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixBPB-0002aT-HN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixBPA-00042W-7D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:06:53 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40832)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixBP9-0003zp-V0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:06:52 -0500
Received: by mail-wr1-x441.google.com with SMTP id j104so4440952wrj.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rq8xFcDZaCjgbxAJDzFhCRvg9c8iLPDpSIerCOhzM10=;
 b=kcL0N+KcpLKYATKR5/J3Tr8Ve+yPNUopXBR5Rzbk9O1HWi/dchC5yrF+IDex6Uj0EM
 jHDrxNI9NLT9yGidzbHIFjY4Swp9ezGJDy2uk7v1R3ql6DTPjLjzgvBsDvvC6TUHOLnt
 iT0nJjL0L6MrZDQX5mnVB6zhwKrYOnCRWHuku0QRpOeUtZLEKQJccFdoWvStkUE3Jwyb
 MwsAWFAwtSVA3RPHhQBkNHT14TRyq0uvyzusdQJTd8VVmu+V0dYG0M7AZ4OYUmG+ws8r
 DgyPNFKzw7Nnvmx414vHO/FvTw3DKgQE8vxDZbt8DVxRGCFJK05w4COKcZHyIB3YRx/u
 R2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rq8xFcDZaCjgbxAJDzFhCRvg9c8iLPDpSIerCOhzM10=;
 b=JceHVOI1Xjh9vcB8gn37ukCFrk4YYB6N8Cbg7B5JEGxweW4zymLBajDF7zdHzluWRF
 YetLAEtWtgl1uZLFrOQWnLWZa4qmq5FszVWE+03LYjG/2fas/Bu6THJGAgZiNXgiibYO
 NcTF8tDXKpeyxP2DoXvQoTXRj6mC/C9JsELl0MiESBpC/hAhkDi6K9y9zY45PNPLENMR
 WqQVAyE1WLnf4gWJe996gEEgeijOkykNwnZi7ayk2n8zpxqAXlPgUW3it3yO7HeUF/Eq
 UQMOPTRb54t7i7qC4E1nG4jqMbW/8IxiG8A7Cbu6XA82uKWJ0y8/C/xpank1/IO5NJX9
 dMAw==
X-Gm-Message-State: APjAAAWkG28cnN7NpYdvQEIq1qvzAwgjgT7b/2rUfXSzc0hmLaeSwmzQ
 Wh8v66ge1fxD3C5DCNQbzwepkw==
X-Google-Smtp-Source: APXvYqxtTp3sfQ6fynsWDID2/5Zy4QeN9j2H37PZbNzCut91LzURMTq8gJaK2uAmogoqe+2/iGGYDw==
X-Received: by 2002:adf:fd0f:: with SMTP id e15mr6176868wrr.241.1580396810439; 
 Thu, 30 Jan 2020 07:06:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h10sm5765612wre.3.2020.01.30.07.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 07:06:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6250C1FF87;
 Thu, 30 Jan 2020 15:06:48 +0000 (GMT)
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-2-alxndr@bu.edu>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 01/21] softmmu: split off vl.c:main() into main.c
In-reply-to: <20200129053357.27454-2-alxndr@bu.edu>
Date: Thu, 30 Jan 2020 15:06:48 +0000
Message-ID: <87y2tp7zlj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, qemu-devel@nongnu.org,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bulekov, Alexander <alxndr@bu.edu> writes:

> A program might rely on functions implemented in vl.c, but implement its
> own main(). By placing main into a separate source file, there are no
> complaints about duplicate main()s when linking against vl.o. For
> example, the virtual-device fuzzer uses a main() provided by libfuzzer,
> and needs to perform some initialization before running the softmmu
> initialization. Now, main simply calls three vl.c functions which
> handle the guest initialization, main loop and cleanup.
>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
<snip>
>  main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
<snip>
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -84,6 +84,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>  # qapi
>=20=20
>  common-obj-y +=3D qapi/
> +
> +softmmu-obj-y =3D main.o
>  endif
>=20=20
<snip>
> diff --git a/main.c b/main.c
> new file mode 100644
> index 0000000000..f10ceda541
> --- /dev/null
> +++ b/main.c
> @@ -0,0 +1,53 @@
> +/*
> + * QEMU System Emulator
> + *
> + * Copyright (c) 2003-2008 Fabrice Bellard
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "sysemu/sysemu.h"
> +
> +#ifdef CONFIG_SDL
> +#if defined(__APPLE__) || defined(main)
> +#include <SDL.h>
> +int main(int argc, char **argv)
> +{
> +    return qemu_main(argc, argv, NULL);
> +}
> +#undef main
> +#define main qemu_main
> +#endif
> +#endif /* CONFIG_SDL */
> +
> +#ifdef CONFIG_COCOA
> +#undef main
> +#define main qemu_main
> +#endif /* CONFIG_COCOA */
> +
> +int main(int argc, char **argv, char **envp)
> +{
> +    qemu_init(argc, argv, envp);
> +    qemu_main_loop();
> +    qemu_cleanup();
> +
> +    return 0;
> +}
<snip>

Can we put the main in a project appropriate sub-directory so it's on
the same order as linux-user/main.c?

I guess the new directory could be "softmmu" which matches the directory
or "system" which matches the binary name. I'd lean towards the latter
as softmmu is very specifically not this bit.

--=20
Alex Benn=C3=A9e

