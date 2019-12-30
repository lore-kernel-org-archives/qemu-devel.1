Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F02C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 16:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431EC206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VcjM742h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431EC206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ily94-0002Nd-E4
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 11:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ily8O-0001rA-53
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 11:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ily8M-0005FS-Q9
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 11:43:11 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:40828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ily8M-0005Do-HF
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 11:43:10 -0500
Received: by mail-lj1-x22b.google.com with SMTP id u1so33826217ljk.7
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 08:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZjUhiqstMZuj78cqOT1rhjHaT3mb+h7oGr+unit2u0w=;
 b=VcjM742hEnICaPVExdGd+nuKw3LUw3RCSWITxxiwMgK56en0+BtPq+CIrDRO0Qzt3a
 86DA5T//wHsphWl7GiIgyzDSHOfPcdRwfI14HpbFt6TbnWwTUFe42KC9MS8PFqhjCRXL
 c/gspFv9H1zoSRGR8W3VsFtSWu3TjQA3wJyE6Sf205UigllrKxoise3/lUea+Co+EdN3
 oFc3sUyP1huKomHEEo/YcuNJQ6EQalen9FN9BXBesYGT1O8GcVt9moUKH3QbPj+9r3sO
 WOJASILKmTU/+sMujYWan7vy2I2ix0WNsbkViJ0+VHN8SjIYSZiPEMbtyfRIFMdfejn6
 UrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZjUhiqstMZuj78cqOT1rhjHaT3mb+h7oGr+unit2u0w=;
 b=CrYa2lZKrhEMdYoL76IbmWJkLJuAdBCZecOqfK5NjPwMouZlXbCqQQXwQ5fQDHlpgO
 FuBsbrv1Q4pB1jWAf1kc3QkwVGnuN7UfcC0Uortq8niQclXn/ADChTVNTegSiblaxwCG
 lZtS2xIh7E4iY2hrTju26e/exkeLku1TS7n49RCt01m5oItt0WO51JEu1uhE0sJJ89bZ
 bgpLvQqqoxuwg3h+DnUDvy6CK/lfveR9i9vVPC81xd88rAZCl/dGMRYXqCH6ChCNZSMD
 YqPVIIAV0XwYatUS1k6/x/QGFD5VexHVI7SBH4FXxyCInk8SIg3IOfixupO/u52w4vYV
 uyrQ==
X-Gm-Message-State: APjAAAXdNICqpVQL0aKF3CU52HRZKvwy/oW10MOdfRouTjvMlVtT+t6y
 AMBcGtJTkI/qUCXm87Wp2Tc/1RIooJCyUVO7z3d/aw==
X-Google-Smtp-Source: APXvYqxoBQ2SedT5TFF67ACfrJIu1XS5GRSdKDBvJZCLezKRL2ZzuPUmLyAKQLDpIZMRQWxv46Kje8wKQd8EN0jAFmA=
X-Received: by 2002:a05:651c:239:: with SMTP id
 z25mr39600358ljn.48.1577724188187; 
 Mon, 30 Dec 2019 08:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20191230111801.26315-1-philmd@redhat.com>
In-Reply-To: <20191230111801.26315-1-philmd@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Mon, 30 Dec 2019 16:42:55 +0000
Message-ID: <CAHDbmO2-LeyiGcaZxDdxGr+BZVyUhM0aXeAqSy8pBG+_zBpz9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Claudio Fontana bouncing email
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ca708a059aee8940"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22b
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ca708a059aee8940
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

On Mon, 30 Dec 2019, 11:19 Philippe Mathieu-Daud=C3=A9, <philmd@redhat.com>
wrote:

> Claudio Fontana Huawei email is bouncing, remove it.
>
>   The message you sent to claudio.fontana@huawei.com couldn't be
>   delivered due to: Recipient email address is possibly incorrect.
>
>   Further information:
>     5.1.1 Error: invalid recipients
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 387879aebc..8db4de6b9a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2383,7 +2383,6 @@ F: plugins/
>  F: tests/plugin
>
>  AArch64 TCG target
> -M: Claudio Fontana <claudio.fontana@huawei.com>
>  M: Claudio Fontana <claudio.fontana@gmail.com>
>  S: Maintained
>  L: qemu-arm@nongnu.org
> --
> 2.21.0
>
>
>

--000000000000ca708a059aee8940
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.=
bennee@linaro.org">alex.bennee@linaro.org</a>&gt;</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 30 Dec 2019, 11:19=
 Philippe Mathieu-Daud=C3=A9, &lt;<a href=3D"mailto:philmd@redhat.com">phil=
md@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Claudi=
o Fontana Huawei email is bouncing, remove it.<br>
<br>
=C2=A0 The message you sent to <a href=3D"mailto:claudio.fontana@huawei.com=
" target=3D"_blank" rel=3D"noreferrer">claudio.fontana@huawei.com</a> could=
n&#39;t be<br>
=C2=A0 delivered due to: Recipient email address is possibly incorrect.<br>
<br>
=C2=A0 Further information:<br>
=C2=A0 =C2=A0 5.1.1 Error: invalid recipients<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 387879aebc..8db4de6b9a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -2383,7 +2383,6 @@ F: plugins/<br>
=C2=A0F: tests/plugin<br>
<br>
=C2=A0AArch64 TCG target<br>
-M: Claudio Fontana &lt;<a href=3D"mailto:claudio.fontana@huawei.com" targe=
t=3D"_blank" rel=3D"noreferrer">claudio.fontana@huawei.com</a>&gt;<br>
=C2=A0M: Claudio Fontana &lt;<a href=3D"mailto:claudio.fontana@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">claudio.fontana@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
=C2=A0L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank" rel=3D"no=
referrer">qemu-arm@nongnu.org</a><br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div>

--000000000000ca708a059aee8940--

