Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB63CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACF4222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/J28ZQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACF4222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWHz-0005RV-Re
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWGu-0004Mo-Gq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWGs-0004A6-Cp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:42:40 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLWGs-00049V-7s; Fri, 18 Oct 2019 13:42:38 -0400
Received: by mail-oi1-x242.google.com with SMTP id i185so5886569oif.9;
 Fri, 18 Oct 2019 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=lXCV0xNTYB6B5XQMcPxs3OMaTd1jVfOpj5nbEwV/4QI=;
 b=X/J28ZQZfn6fcRP9KsBGgRZIeSYd6F5I1nDAERKDTZY01IbM+O+tMC5m9NsQrZFX1+
 hDW9Q03IecBpOLV/upE4sGEOKe82+SQrFRCb2TSGjVT9ptq5g6W45MhNyYLHMiStxzJy
 gyoURwxs+a5qGrXqxA8+dwBei3kN/F/jdcDE+IASpla7PiNdlTyY0CLF4+PxmYip29+w
 MofUiZQBeiTd/30gsDnxTsbax/9geUYRz6EWNgkiVed7TlILXA2Rf0a437OsedFAPQYc
 09mNtEaE/8tSVz628R79YOiG6Yf+VkDMx+2YDR6icRtG8F2IfRtb/ng+d1cYnqrhcObh
 ebuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=lXCV0xNTYB6B5XQMcPxs3OMaTd1jVfOpj5nbEwV/4QI=;
 b=Nny1lS5A6bCdOM+nMKr9tUIXyWlCCVseLNBWaWLSlWRf+CWXLvUiNEVuaYeBxcIZ/F
 svoFlOombg+wSBnXo2dVz1uueo34//pa98OMgK3Ttshg+JkSAmVGSo9qvP0SVxCmsKJa
 DmPasnezCdkahCF29sk59LeyN9Esajw9LCoj+Ad+Fg4wN+ldOP4wzt4V41sYKjcaDV34
 TFGLbDgiz1uzbp9xxImBCBnVGRJZeUY/TloLQ4TG+zIXa+XrHRIdhIgOGXPJZc4jsVIM
 p2lOgtQR67lFa5O72NT1QFFNX1F7fwIJVNrjci8kDwCxhmidFYBwuOpoooBdS84EY1fd
 T6ww==
X-Gm-Message-State: APjAAAWYBb6eXEpACXyuogwjD0bDuwaU2o8JAWeWRha56uHKcJUIww/9
 TbkmLDK/VdzI75Gy92UPZ13zQZNAV2APZiRgZSk=
X-Google-Smtp-Source: APXvYqx6toib1HK1F3CV3V0Z5tZjv2LjLiDrkAjOxXYIJGRqyEpzi9cxUd4jEp9A53xBJ15kiLFAWjKNqaMkJXtuDTs=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr9091616oib.53.1571420557370; 
 Fri, 18 Oct 2019 10:42:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 10:42:36
 -0700 (PDT)
In-Reply-To: <20191018154212.13458-8-marcandre.lureau@redhat.com>
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-8-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 19:42:36 +0200
Message-ID: <CAL1e-=iTPwYTa1CVfxuJ9Q6J21DKVO6x3F1Uw_-g3UTh=VdboQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] RFC: mips/cps: fix setting saar property
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001d6b98059532dcf4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001d6b98059532dcf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 18, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
wrote:

> There is no "saar" property. Note: I haven't been able to test this
> code. Help welcome.
>
> May fix commit 043715d1e0fbb3e3411be3f898c5b77b7f90327a ("target/mips:
> Update ITU to utilize SAARI and SAAR CP0 registers")
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/cps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
This was a part of larger body code that is still in process of upstreaming
(and testing). I'll try to take a closer look in next few days. But, for
4.2, only minor changes are acceptable (like this patch). I'll get back to
you when I get more info on all options. Thank you anyway!

Aleksandar



> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 1660f86908..c49868d5da 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Error
> **errp)
>          object_property_set_bool(OBJECT(&s->itu), saar_present,
> "saar-present",
>                                   &err);
>          if (saar_present) {
> -            qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void
> *)&env->CP0_SAAR);
> +            s->itu.saar =3D &env->CP0_SAAR;
>          }
>          object_property_set_bool(OBJECT(&s->itu), true, "realized",
> &err);
>          if (err !=3D NULL) {
> --
> 2.23.0.606.g08da6496b6
>
>
>

--0000000000001d6b98059532dcf4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">There is no &quot;saar&quot; property=
. Note: I haven&#39;t been able to test this<br>
code. Help welcome.<br>
<br>
May fix commit 043715d1e0fbb3e3411be3f898c5b7<wbr>7b7f90327a (&quot;target/=
mips:<br>
Update ITU to utilize SAARI and SAAR CP0 registers&quot;)<br>
<br>
Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com">marcandre.lureau@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/cps.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div>This was a part of larger body code th=
at is still in process of upstreaming (and testing). I&#39;ll try to take a=
 closer look in next few days. But, for 4.2, only minor changes are accepta=
ble (like this patch). I&#39;ll get back to you when I get more info on all=
 options. Thank you anyway!</div><div><br></div><div>Aleksandar</div><div><=
br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
diff --git a/hw/mips/cps.c b/hw/mips/cps.c<br>
index 1660f86908..c49868d5da 100644<br>
--- a/hw/mips/cps.c<br>
+++ b/hw/mips/cps.c<br>
@@ -106,7 +106,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(<wbr>OBJECT(&amp=
;s-&gt;itu), saar_present, &quot;saar-present&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (saar_present) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_ptr(DEVICE(&amp;s-=
&gt;<wbr>itu), &quot;saar&quot;, (void *)&amp;env-&gt;CP0_SAAR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;itu.saar =3D &amp;env-&gt;=
CP0_SAAR;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_bool(<wbr>OBJECT(&amp=
;s-&gt;itu), true, &quot;realized&quot;, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NULL) {<br>
-- <br>
2.23.0.606.g08da6496b6<br>
<br>
<br>
</blockquote>

--0000000000001d6b98059532dcf4--

