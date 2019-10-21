Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F240ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5AF2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrUyCiY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5AF2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZTI-0000KM-Gg
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iMZSK-00089n-3R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iMZSI-0004CZ-Sl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:18:48 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iMZSH-0004Ba-0a
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:18:45 -0400
Received: by mail-ot1-x329.google.com with SMTP id 60so11324356otu.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1x+45LAF6NhcUXFiwpg+YITg80URlofEztTg/h35ZHc=;
 b=lrUyCiY8ecQeKOvK9Z146wY7CcEJ9lSG/SldiZ0WmXluUpt5mDKc6vK0wr5sdkV7yO
 8Si3MHx1EeDrfzz2TzKnimCvYGHyA1Dc1oay18E3klwoAwLUFBft1yti3frdAQIEVc3w
 CAE0L2THJug1ANkVssSsL3XNyTxbwPScDx6vsabHFC6OGuwQZ6ik8jt/VdGQwLFtVXrS
 ZFKZniDk4yZxcMIZIvUU5oqIQCxCWca+tSDjEGpap0PWcknwBRScRAtX9QlvF6fMthc6
 5z0SPl9xfM18lCGZKElPZMyJm/ElAihyal7+83Ht0+HKkOBd/254M/rHSUtAz73XPYFb
 8nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1x+45LAF6NhcUXFiwpg+YITg80URlofEztTg/h35ZHc=;
 b=q9XxLCjPMjmNe4L/PLo+ChOW8GI9ppbkCrCipTnF7EKxyx3VrUJW6YGHK9RlNkQCtZ
 iUXz6IHHABddU2kbUKON4ZkvqSSeQWAvoIy6WDd/nOtLkk0SDxbMh8Mo+tMCdgcAY6eM
 aB/FqlAKrd2r0wqGOY9sYW7qEmhiY7yErv0Rkwb51y5KK9Yk2GU2lxiUwIUXfzxo2UH3
 yEADCGXk4iyGyAp2GZ7aiBdWjpgIoCaA9CVSfosRc3E4Ia/x3rbuLu6v604/n8r5VshG
 h1WOeT0AwACfbmJegdyNTmjdcoc5HDb2RskOPd3xECa4O0AZDlbKO/ZjqLWHTCkwUfj5
 gxEw==
X-Gm-Message-State: APjAAAXnAC1igyRa+oqmWU6hiQuaeSluzM/ZgbHPQ5WxECKV6WHtrhXx
 ttGtvorzjPw2Osz2oxVd2JIUCRsZVLsb1C8uRv4=
X-Google-Smtp-Source: APXvYqwY9QIGPCqd7c3usrHMnLqv7GrRFyhQY/vu5ERB5/kp5RYmHsUFmSkXq55rwt4hX/xJoPrI8QVcLsGWSyYrHEc=
X-Received: by 2002:a9d:6d11:: with SMTP id o17mr18527222otp.333.1571671123476; 
 Mon, 21 Oct 2019 08:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-5-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-5-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Oct 2019 23:18:06 +0800
Message-ID: <CAKXe6S+4eugvZb557znfNxWO1r6QeChQc5QmF55sfTLJ0y8aNA@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] Revert "irq: introduce qemu_irq_proxy()"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000004c6d305956d3362"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000004c6d305956d3362
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=
=93=EF=BC=9A

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> This function isn't used anymore.
>
> This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/core/irq.c    | 14 --------------
>  include/hw/irq.h |  5 -----
>  2 files changed, 19 deletions(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index 7cc0295d0e..fb3045b912 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -120,20 +120,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2=
)
>      return qemu_allocate_irq(qemu_splitirq, s, 0);
>  }
>
> -static void proxy_irq_handler(void *opaque, int n, int level)
> -{
> -    qemu_irq **target =3D opaque;
> -
> -    if (*target) {
> -        qemu_set_irq((*target)[n], level);
> -    }
> -}
> -
> -qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
> -{
> -    return qemu_allocate_irqs(proxy_irq_handler, target, n);
> -}
> -
>  void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler,
> int n)
>  {
>      int i;
> diff --git a/include/hw/irq.h b/include/hw/irq.h
> index fe527f6f51..24ba0ece11 100644
> --- a/include/hw/irq.h
> +++ b/include/hw/irq.h
> @@ -51,11 +51,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);
>   */
>  qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
>
> -/* Returns a new IRQ set which connects 1:1 to another IRQ set, which
> - * may be set later.
> - */
> -qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
> -
>  /* For internal use in qtest.  Similar to qemu_irq_split, but operating
>     on an existing vector of qemu_irq.  */
>  void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler,
> int n);
> --
> 2.21.0
>
>
>

--00000000000004c6d305956d3362
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.o=
rg" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
<br>
This function isn&#39;t used anymore.<br>
<br>
This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.<br>
<br>
Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank">thuth@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div><br><=
/div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com">liq=
3ea@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
---<br>
=C2=A0hw/core/irq.c=C2=A0 =C2=A0 | 14 --------------<br>
=C2=A0include/hw/irq.h |=C2=A0 5 -----<br>
=C2=A02 files changed, 19 deletions(-)<br>
<br>
diff --git a/hw/core/irq.c b/hw/core/irq.c<br>
index 7cc0295d0e..fb3045b912 100644<br>
--- a/hw/core/irq.c<br>
+++ b/hw/core/irq.c<br>
@@ -120,20 +120,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2)<=
br>
=C2=A0 =C2=A0 =C2=A0return qemu_allocate_irq(qemu_splitirq, s, 0);<br>
=C2=A0}<br>
<br>
-static void proxy_irq_handler(void *opaque, int n, int level)<br>
-{<br>
-=C2=A0 =C2=A0 qemu_irq **target =3D opaque;<br>
-<br>
-=C2=A0 =C2=A0 if (*target) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq((*target)[n], level);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)<br>
-{<br>
-=C2=A0 =C2=A0 return qemu_allocate_irqs(proxy_irq_handler, target, n);<br>
-}<br>
-<br>
=C2=A0void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handle=
r, int n)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
diff --git a/include/hw/irq.h b/include/hw/irq.h<br>
index fe527f6f51..24ba0ece11 100644<br>
--- a/include/hw/irq.h<br>
+++ b/include/hw/irq.h<br>
@@ -51,11 +51,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);<br>
=C2=A0 */<br>
=C2=A0qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);<br>
<br>
-/* Returns a new IRQ set which connects 1:1 to another IRQ set, which<br>
- * may be set later.<br>
- */<br>
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);<br>
-<br>
=C2=A0/* For internal use in qtest.=C2=A0 Similar to qemu_irq_split, but op=
erating<br>
=C2=A0 =C2=A0 on an existing vector of qemu_irq.=C2=A0 */<br>
=C2=A0void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handle=
r, int n);<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--00000000000004c6d305956d3362--

