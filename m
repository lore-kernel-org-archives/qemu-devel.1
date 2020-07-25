Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD75CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 12:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A589D20674
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDtnTL4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A589D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzJ73-0004yV-SF
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 08:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jzJ64-0004VN-8B
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 08:16:12 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jzJ62-0001dn-Lr
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 08:16:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id f1so10014361wro.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=CNAR9Dn6SLCGceskC+Fuob5WPbyY9ilQW5Br+oTaEeM=;
 b=HDtnTL4T/QaG/7wQWpOjEPwR82aEpfYCNWU8PCqx5Nev9CLMc9aMHx0yuv1JXvAjc1
 mcAmjPx7iGvZtRmNfjMNTlCKbTFPrNtz5yNM8VSnenFJvWoyFBh/g7wgrdoVvy9SGKKL
 FJnrX+9JTJJB3Ueby0A7tpFKyDO7NktLn29FmWqzZ+OuoMPQcWebBQXH6Lav/sRGwftt
 ZIxhfYfOA3EiOQvqkRJuFdx+yDOifKOhsdMXKbtEyCU1JYdTV0ZPYK7yUs9yTJT2zXls
 Xa+HzB7tFpox2wMaFvMQmK9LTtjBA7bV6NptzP9+Qvfkzw6pLWz63WZLlq28+J5fTHGo
 wd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=CNAR9Dn6SLCGceskC+Fuob5WPbyY9ilQW5Br+oTaEeM=;
 b=s1f9fByrR3aRGQnLvLBlHKmB5x3kkECXHViTXOgP54ne9eZYfhDWNSy2hVXVF7mj3H
 0kLwK2uHaViD54jyf5gzxQRRK1wv2YnMz0vFfS+ABvgr3h56L7xzHSkQuRvFCOSehgvU
 J6TQdrQFJriQN2NzcrnjenjUxuGF8uorfSYiFgb0anx7mFqNych+ySxoCmuuiM9cXMJv
 4wUqvXvxVxyZ08SmYRnFlyWANaRMA0I22x8fsZizodOgrPQQhmM7gHp24CW9oZiDUx4F
 a8V09EqK3MTQdI/2R4N7IrT2D22Y8fF4+XIPKPlGNsorJJA4PGZ0nvhMU5MI/sqa5qKO
 YOKQ==
X-Gm-Message-State: AOAM530eKCpnzhF6Ua1TU1yYhimmKxBHObKM3xG1hUKd8H7Jcr0sbZTi
 Jfja6c1u49JibJVMwG33ZiR1AG3SqWrNZ9OQP2g=
X-Google-Smtp-Source: ABdhPJyTvwbHCw4SVDWQYy5zGlMfIi6K1VsHzT6fzrnnJO0FS4OmxfjeKHx7TMcurLit9dJHhAK6yGQ8hxgZOppd7Cc=
X-Received: by 2002:adf:b34a:: with SMTP id k10mr12340491wrd.402.1595679368562; 
 Sat, 25 Jul 2020 05:16:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP; Sat, 25 Jul 2020 05:16:08
 -0700 (PDT)
In-Reply-To: <20200715084326.678715-3-arilou@gmail.com>
References: <20200715084326.678715-1-arilou@gmail.com>
 <20200715084326.678715-3-arilou@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 25 Jul 2020 14:16:08 +0200
Message-ID: <CAHiYmc7oo3Vn1RaP+UiuQqJVS2OJXgoqyNPvbY+gAGjn_dD=8w@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
To: Jon Doron <arilou@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000f04d6a05ab430dac"
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rvkagan@yandex-team.ru" <rvkagan@yandex-team.ru>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f04d6a05ab430dac
Content-Type: text/plain; charset="UTF-8"

On Wednesday, July 15, 2020, Jon Doron <arilou@gmail.com> wrote:

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  hw/hyperv/vmbus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index 34392e892a..c28bb4201b 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void
> *buf, uint32_t len)
>              }
>          }
>
> -        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
> off_in_page);
> +        p = (void *)(uintptr_t)(((uintptr_t)iter->map &
> TARGET_PAGE_MASK) |
> +                off_in_page);
>          if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
>              memcpy(p, buf, cplen);
>          } else {
> --
> 2.24.1
>
>
>
Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

It looks to me this patch should definitely be selected for 5.1.?

--000000000000f04d6a05ab430dac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, July 15, 2020, Jon Doron &lt;<a href=3D"mailto:arilou=
@gmail.com">arilou@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">Signed-off-by: Jon Doron &lt;<a href=3D"mailto:arilou@gmail.com">arilou@=
gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/hyperv/vmbus.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c<br>
index 34392e892a..c28bb4201b 100644<br>
--- a/hw/hyperv/vmbus.c<br>
+++ b/hw/hyperv/vmbus.c<br>
@@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf=
, uint32_t len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D (void *)(((uintptr_t)iter-&gt;map &amp; =
TARGET_PAGE_MASK) | off_in_page);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D (void *)(uintptr_t)(((uintptr_t)<wbr>ite=
r-&gt;map &amp; TARGET_PAGE_MASK) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 off_in_page);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iter-&gt;dir =3D=3D DMA_DIRECTION_FRO=
M_DEVICE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(p, buf, cplen);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-- <br>
2.24.1<br>
<br>
<br>
</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font-si=
ze:14px;line-height:22.1200008392334px">Tested-by: Aleksandar Markovic &lt;=
</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" style=3D"font-siz=
e:14px;line-height:22.1200008392334px">aleksandar.qemu.devel@gmail.<wbr>com=
</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.120000=
8392334px">&gt;</span><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" style=3D"fo=
nt-size:14px;line-height:22.1200008392334px">aleksandar.qemu.devel@gmail.<w=
br>com</a><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.=
1200008392334px">&gt;</span><br></div><div><span style=3D"color:rgb(34,34,3=
4);font-size:14px;line-height:22.1200008392334px"><br></span></div><div>It =
looks to me this patch should definitely be selected for 5.1.?</div>

--000000000000f04d6a05ab430dac--

