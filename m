Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F95206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKgEP3wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F95206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWW9-0006S3-9b
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jZWV8-00057a-32
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:30 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jZWV7-0005VL-9x
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:29 -0400
Received: by mail-il1-x143.google.com with SMTP id e8so1732445ilm.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IPRUKoDFj+/20efxoyq+4r2wIuVjT9tQ30twanJ1/Ak=;
 b=kKgEP3wuyAWnR4tLOtOCq1XwrD4iBQQ4BtvIBnYkFHmMF1+g/FZmqbHfgimBAEIhaA
 98HJH8pYlo6zyBYTYl9ky5jVyfDx3PNw2h5CjsTBdR8cY6WLEGO3UnsTqByyPNH/cclq
 wgCdm81Wsh+1tvfZoLZyFowG9QUc++pvAf9hJ9Mc16yiByQZHcyKHL5EAzBRTjxhVBoY
 LUQWJp7Q1aRBbkUO6iinbwVeOCufP0TJjZ8VK7R5Em1PLS6qbyZ07T5yvavDOl7cyjVE
 vbMGKRfAFNzKnWA7MYRpCi/XjDGT5/do+vnEvBsTXYsRn42IEJHXcPG6U4FAxQbfc8cR
 /6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IPRUKoDFj+/20efxoyq+4r2wIuVjT9tQ30twanJ1/Ak=;
 b=nOWo2N24eWGtiOH/31q2RREFyyZPgfQ4qhtd3ia2dGhNGhLPdR8p+JElClvekLL3H8
 0SDuHGJ4BrCqSIIe4BIsc6FW5U9K06nsqf8+/QByNJUv33AAkhqsuZQF7BmRfy6MkWes
 RUkrHubVwtcVxu5NXTadfBkVe9OZvs3mNDJdJNYuKSCmQDuI+rod/LGJyG0BzVZV9JlA
 27UM5SWDm5djOfgfODsIV0LdZtzfJ25fhhYezB/7plyTkdM2ysz8n4RF7glVDk4bdLbN
 aRZrWmk6h7oG5jtnDTl8WDo26E7ddX82/hdN/0cCMfA6OHOC2lX1Oox0LCqUr/uDFW05
 VN3w==
X-Gm-Message-State: AOAM532S2yIwvYT6W8EvoB1pOi6ZBFUycHztlu02E4WTsuPyX6Zg42zN
 r2m1m2wH8Ftze5LVrYk8BX/96XtnoY+7MmjnGFM=
X-Google-Smtp-Source: ABdhPJwkWhOAAsUZiX6lnH96KkBuYj9B2TCNb1ElgViC/zFU7RKIRljOE8/sy1/53g1LK5dnujehoEFsD31d3HhhU94=
X-Received: by 2002:a05:6e02:2:: with SMTP id h2mr573264ilr.281.1589534367847; 
 Fri, 15 May 2020 02:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200512064900.28554-1-pauldzim@gmail.com>
 <20200512064900.28554-2-pauldzim@gmail.com>
 <a2690592-fa76-4cd1-2cfb-2093c5ade4ce@amsat.org>
In-Reply-To: <a2690592-fa76-4cd1-2cfb-2093c5ade4ce@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Fri, 15 May 2020 02:19:17 -0700
Message-ID: <CADBGO78Zr=ykRczZj4+KeMyqSC93Yqew3yKt8Fx53+TkqPwYjA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] raspi: add BCM2835 SOC MPHI emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000005a98aa05a5ac4f17"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005a98aa05a5ac4f17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 1:10 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 5/12/20 8:48 AM, Paul Zimmerman wrote:
> > Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)
> > emulation. It is very basic, only providing the FIQ interrupt
> > needed to allow the dwc-otg USB host controller driver in the
> > Raspbian kernel to function.
> >
> > Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Thanks Felippe. Do you think you reviewed hcd-dwc2.c enough to give a
reviewed-by or acked-by to it too?

Thanks,
Paul


>

--0000000000005a98aa05a5ac4f17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, May 15, 2020 at 1:10 AM Philippe Mathieu-Daud=C3=A9=
 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On 5/12/20 8:48 AM, Paul Zimmerman wrot=
e:<br>
&gt; Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)<br>
&gt; emulation. It is very basic, only providing the FIQ interrupt<br>
&gt; needed to allow the dwc-otg USB host controller driver in the<br>
&gt; Raspbian kernel to function.<br>
&gt; <br>
&gt; Signed-off-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com=
" target=3D"_blank">pauldzim@gmail.com</a>&gt;<br>
<br>
Acked-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org=
" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks Felippe. =
Do you think you reviewed hcd-dwc2.c enough to give a reviewed-by or acked-=
by to it too?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</d=
iv><div dir=3D"auto">Paul</div><div dir=3D"auto"><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><br></blockquote></div></div>

--0000000000005a98aa05a5ac4f17--

