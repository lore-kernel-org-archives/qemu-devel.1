Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F9C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3305F20829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5LnnTks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3305F20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JBK-0007oy-8U
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1k6JAH-0006jO-30; Thu, 13 Aug 2020 15:45:29 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:40325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mrolnik@gmail.com>)
 id 1k6JAF-0000fa-FR; Thu, 13 Aug 2020 15:45:28 -0400
Received: by mail-qk1-x742.google.com with SMTP id 62so6273602qkj.7;
 Thu, 13 Aug 2020 12:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pNtNfajHiWjonfTsQFh+T69gMqes4UiFF7HcjJUaAz0=;
 b=d5LnnTksnNRn4zyIbTdUyctAiO9wDp0T7CBrltZM4BIdIWxQrgc+WXWwk/G4AE5oP0
 LyIXqLsiSy5l9VxEVtzuKXxBGyEaXx5Ahge8XwF9n3Bb/Sr3TSttOKe44GDL9w02pgRf
 WswxNER6sVR7Ukcm3oVQibwTZEBUg/50IZ2rpELhMeigsPEnkKvBdLYZXihd5GVyhuUt
 +gCtEABQ2hR/Juwg0wELBxBlI3JHFrJd7HN0eUgSXbBh/3TxRf8OEleDaU1eXqZVb3YV
 G5a7bQlqRp49cKSORgukcUEpCah956wj4rXsq68jMBptDGusGluxlZ+V1QRTarcuAQV5
 gYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pNtNfajHiWjonfTsQFh+T69gMqes4UiFF7HcjJUaAz0=;
 b=Qu+ScHk69lqs/QiQVFtCHzkDwGxu3BUNvHg9Cc/SyoEYtfuz3hfQj2uD7ueWDVUC5D
 EvDYuUtYcEb1k5G3Ep1LUWwqvdqCgmq5F/eFtgVYkHySc8H0TsHLf7qBfxnRJXRk7m40
 b2eR940v/RWtH+N9AZpkhpmAkvTCiDC62YlKuGo2+JF3UkR80tfy9w+Tpheyu5gO8plW
 Dj6B/vrvJC/ueVk5e0Ild5JluoMXsblIsTbsp8yTc8wvwb5Wwu1Lr9AJZAvhiI3e2gW2
 0UwRhyHwdS/ZYkvwYOC5w6Y/+2aABcIe363GA/UNXjXkakLvw2GdvARvDGuFmG4DZXuO
 SlwQ==
X-Gm-Message-State: AOAM5328OtxtR8vehp8YbTRHUZIT00xREjdr078Q5QGgR9+U1FR3ywpy
 AkJGyOFbPNv1wENlkQ159XgN4CHAn3VMNRg4i0Y=
X-Google-Smtp-Source: ABdhPJxtfeHl0scMjSabIAkFZUr/GzyrxXUr6uzbGsGEGMXkykQj62s37067E1Byc68OqYFvequhl/fQSD0svFAxz4w=
X-Received: by 2002:a37:9f94:: with SMTP id i142mr6164196qke.310.1597347925149; 
 Thu, 13 Aug 2020 12:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200812155304.18016-1-huth@tuxfamily.org>
 <7ae16b1c-50a2-3cd8-dfda-e3dd76f5cd7a@linaro.org>
In-Reply-To: <7ae16b1c-50a2-3cd8-dfda-e3dd76f5cd7a@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Thu, 13 Aug 2020 22:44:38 +0300
Message-ID: <CAK4993hK6OUtG=PapUy8cLSAb8a1yv9KKyG0nNWmLCzY3e5bWA@mail.gmail.com>
Subject: Re: [PATCH] docs/system/target-avr: Improve the AVR docs and add to
 MAINTAINERS
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a98e1105acc78b4a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=mrolnik@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-trivial@nongnu.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a98e1105acc78b4a
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Michael Rolnik <mrolnik@gmail.com>

On Thu, Aug 13, 2020 at 7:50 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/12/20 8:53 AM, Thomas Huth wrote:
> > The examples look nicer when using "::" code blocks.
> > Also mention that "-d in_asm" only outputs instructions that have not
> > been translated by the JIT layer yet.
> > And while we're at it, also add the AVR doc file to the MAINTAINERS file.
> >
> > Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> > ---
> >  MAINTAINERS                |  1 +
> >  docs/system/target-avr.rst | 47 +++++++++++++++++++++++---------------
> >  2 files changed, 30 insertions(+), 18 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~
>


-- 
Best Regards,
Michael Rolnik

--000000000000a98e1105acc78b4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@=
gmail.com">mrolnik@gmail.com</a>&gt;<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 13, 2020 at 7:50 PM Ric=
hard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richard.=
henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 8/12/20 8:53 AM, Thomas Huth wrote:<br>
&gt; The examples look nicer when using &quot;::&quot; code blocks.<br>
&gt; Also mention that &quot;-d in_asm&quot; only outputs instructions that=
 have not<br>
&gt; been translated by the JIT layer yet.<br>
&gt; And while we&#39;re at it, also add the AVR doc file to the MAINTAINER=
S file.<br>
&gt; <br>
&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:huth@tuxfamily.org" t=
arget=3D"_blank">huth@tuxfamily.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 docs/system/target-avr.rst | 47 +++++++++++++++++++++++---------=
------<br>
&gt;=C2=A0 2 files changed, 30 insertions(+), 18 deletions(-)<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
<br>
r~<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000a98e1105acc78b4a--

