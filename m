Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B120C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2825D2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAGgIDSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2825D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixElr-0005NI-80
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 13:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ixEkr-0004m5-3w
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ixEkp-0002xM-LC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:41:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ixEkp-0002wF-DJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 13:41:27 -0500
Received: by mail-wr1-x444.google.com with SMTP id a6so5350121wrx.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZeJC8uBJTeGgO4mOxMovMUtB83qqIdATcRRjBe0c7Ek=;
 b=AAGgIDSPPlNaGIKNJivRRNmFn2Lp1fMjlqYn4Gd++2qfdEeYz3FXnX+5xfzgw90fCG
 bDaqSh1gW39EcxRBF0aUk67hXxgkg3kAV12P9YxbwCpXsSLfMOKtAcZ6muxA3BeGruzg
 8AUnc/zdT/HSZUGSgFs4fwH9R0nX9Y7d6uUj5aiDyiclLc4haI/rT3lJ2MCRw4b7H5WP
 dqOqvl0xLdGGxX+X0YCIRuvKGDgD2xMZQMTrd2VQjU20Zm0d/wry6YSl7rPD5SuOA8RO
 sY/heVomVpQNNPEdGKn6DzOUe6nvAFwgaIF3e+k4+e91UmdBkefzDoQI0heTk1rgXYhD
 tB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZeJC8uBJTeGgO4mOxMovMUtB83qqIdATcRRjBe0c7Ek=;
 b=qn5jI4pn54Zvd0CFZWz9RejChkeX50D2g87rucUxcXhUSe0vxaQdxIxIh0CDerIJFA
 kR9K8V+cLNj4IZT2Om1zAUyJhtYOPA1lmElCyDwLfc+Hd1Ndjl1bRg/V/lY8pdtxddgz
 LdRGOAECS5TvRsS2f5Uv18M2bDMswG7VqBhqYig0Bjyzs/DorVhy/Pu8upUARygU6LMA
 n0re6Kzszr0Nk8mPJBC6vD503T41Uv973arGLn/29HrhdsA5KAzsJc3KxxQEtQbgoKAZ
 HcQDzcCbjilryFSB98pR2/QEHEJH+6ngMQ+zlAeRuJLlqiw2rGjUYPs9mm/vHgzicfUz
 K5jA==
X-Gm-Message-State: APjAAAU5MloYHsU3dx3drpBpgzmAIJ/hEjSpWhUBM3PaT1NLBl//z8mL
 4NiCDBS/0Tc774lcsw3Z8+iZZw==
X-Google-Smtp-Source: APXvYqzJoQsKOeKPcHToaYXR2D5OmOAP4p11YnCm4gxNkWo8Q6qdQshKvhn/0PuM8GV6U7xPeD8PQg==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr7435224wru.57.1580409685153; 
 Thu, 30 Jan 2020 10:41:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y10sm8281276wrw.68.2020.01.30.10.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 10:41:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 31B231FF87;
 Thu, 30 Jan 2020 18:41:23 +0000 (GMT)
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-2-alxndr@bu.edu> <87y2tp7zlj.fsf@linaro.org>
 <20200130174401.xgdzeq4we2cqry4a@mozz.bu.edu>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v8 01/21] softmmu: split off vl.c:main() into main.c
In-reply-to: <20200130174401.xgdzeq4we2cqry4a@mozz.bu.edu>
Date: Thu, 30 Jan 2020 18:41:23 +0000
Message-ID: <87v9os948c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


Alexander Bulekov <alxndr@bu.edu> writes:

> On 200130 1506, Alex Benn=C3=A9e wrote:
>>=20
>> Bulekov, Alexander <alxndr@bu.edu> writes:
>>=20
>> > A program might rely on functions implemented in vl.c, but implement i=
ts
>> > own main(). By placing main into a separate source file, there are no
>> > complaints about duplicate main()s when linking against vl.o. For
>> > example, the virtual-device fuzzer uses a main() provided by libfuzzer,
>> > and needs to perform some initialization before running the softmmu
>> > initialization. Now, main simply calls three vl.c functions which
>> > handle the guest initialization, main loop and cleanup.
>> >
>> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>> > ---
>> <snip>
>> >  main.c                  | 53 +++++++++++++++++++++++++++++++++++++++++
>> <snip>
>> > --- a/Makefile.objs
>> > +++ b/Makefile.objs
>> > @@ -84,6 +84,8 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
>> >  # qapi
>> >=20=20
>> >  common-obj-y +=3D qapi/
>> > +
>> > +softmmu-obj-y =3D main.o
>> >  endif
>> >=20=20
>> <snip>
>> > diff --git a/main.c b/main.c
>> > new file mode 100644
>> > index 0000000000..f10ceda541
>> > --- /dev/null
>> > +++ b/main.c
>> > @@ -0,0 +1,53 @@
>> > +/*
>> > + * QEMU System Emulator
>> > + *
>> > + * Copyright (c) 2003-2008 Fabrice Bellard
>> > + *
>> > + * Permission is hereby granted, free of charge, to any person obtain=
ing a copy
>> > + * of this software and associated documentation files (the "Software=
"), to deal
>> > + * in the Software without restriction, including without limitation =
the rights
>> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/=
or sell
>> > + * copies of the Software, and to permit persons to whom the Software=
 is
>> > + * furnished to do so, subject to the following conditions:
>> > + *
>> > + * The above copyright notice and this permission notice shall be inc=
luded in
>> > + * all copies or substantial portions of the Software.
>> > + *
>> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR
>> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY,
>> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT =
SHALL
>> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES =
OR OTHER
>> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, AR=
ISING FROM,
>> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN
>> > + * THE SOFTWARE.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qemu-common.h"
>> > +#include "sysemu/sysemu.h"
>> > +
>> > +#ifdef CONFIG_SDL
>> > +#if defined(__APPLE__) || defined(main)
>> > +#include <SDL.h>
>> > +int main(int argc, char **argv)
>> > +{
>> > +    return qemu_main(argc, argv, NULL);
>> > +}
>> > +#undef main
>> > +#define main qemu_main
>> > +#endif
>> > +#endif /* CONFIG_SDL */
>> > +
>> > +#ifdef CONFIG_COCOA
>> > +#undef main
>> > +#define main qemu_main
>> > +#endif /* CONFIG_COCOA */
>> > +
>> > +int main(int argc, char **argv, char **envp)
>> > +{
>> > +    qemu_init(argc, argv, envp);
>> > +    qemu_main_loop();
>> > +    qemu_cleanup();
>> > +
>> > +    return 0;
>> > +}
>> <snip>
>>=20
>> Can we put the main in a project appropriate sub-directory so it's on
>> the same order as linux-user/main.c?
>>=20
>> I guess the new directory could be "softmmu" which matches the directory
>> or "system" which matches the binary name. I'd lean towards the latter
>> as softmmu is very specifically not this bit.
> Will do - should vl.c move into this directory, as well?
> -Alex

Might as well so it doesn't get lonely ;-)

There has been a slow process of moving bits and pieces of the root
directory into a respective sub-directories over the years (decades?) so
this is a good opportunity to clean this bit up.

>
>> --=20
>> Alex Benn=C3=A9e


--=20
Alex Benn=C3=A9e

