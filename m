Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD2CC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFB520758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLl4zYrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFB520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOO63-0003GW-I3
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOO5K-0002I3-Cd; Fri, 02 Oct 2020 12:39:06 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOO5I-0004pi-2v; Fri, 02 Oct 2020 12:39:06 -0400
Received: by mail-lf1-x144.google.com with SMTP id b12so2608623lfp.9;
 Fri, 02 Oct 2020 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Y2FcZtlzNL2nG5FAhEijNPeJeoTKAI21EfueWq/sp44=;
 b=vLl4zYrtui5YhP9lfPQZbkmF22gWTGB3qWPELD1ebm2mprTVmlVjJZIir5pjf3CjFb
 PCVhoevYJxPfHNW6AMvB5avDDZp3pTH+dJeoBAxGcCEeOZuMFiq3tmP+tiMJwME0wKuL
 FeQ0OcpeatzWz/PZgcL49Em2xReVeebUXfF3lsH8DOQZ+4LtP54jAOOgEpHTd9uXGX2N
 dNbBDa316qu3c/McoZN3qY1LgUsNEJBVQjOGb88bdOxDjdZDyy/tvxQLa0B4C/UE1Yah
 4MF5frkzdTvYI8rg40ReLZyEJPczgJRrWMHz1qcRRljMu5kRpno1j3j8GSItRvCgD6H4
 Yeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Y2FcZtlzNL2nG5FAhEijNPeJeoTKAI21EfueWq/sp44=;
 b=hZm7Rn2PtyrPWKUTCPGGkoLxYWPrwO0DiOm5PLnrezYPY2C/H8bzVPQItXPqW5/CdZ
 rtAMEfhUfWOSXFJsfYHUCdU4is2JVLqv0rRmabaZugo9NEUzgAjESMbSy8r5GMHZTOfG
 HFIrW0Sv5MffuOZ4oXLmARkuGoHypvFjAWS2//hESed6uyduJSeinievsfDmel5MQEjm
 sfkznmByhp0+5OeQigAFZzZ60iYgpa3A4WmXrv8QuiRu67LkefIK4fWjWJShce8tB147
 mCW3Zomn4QN56W5jDQKDUaKIUQmRJ/HlpIBP5HQZMp3KK9JECGyE/6GmFxuYjLWSHSa/
 KK5g==
X-Gm-Message-State: AOAM530HF2Y5imA5i8CL9/L/EK/jPwp+WOGjHEg0GZEzMOHNovnaXEPO
 yFqI3lC40LCHBCVga75QaeoVMee38mGk45027Yk=
X-Google-Smtp-Source: ABdhPJyq0PjGk8uAvZ8GejVoZYM3emQXF9GQzu4vM/27Yq6gP1lUjT2rfNPG1/afZ+E+hUo2HyF/SW1j8dQBE+gSqgE=
X-Received: by 2002:a19:383:: with SMTP id 125mr1238438lfd.356.1601656741871; 
 Fri, 02 Oct 2020 09:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
 <20201002153559.GJ2338114@redhat.com>
In-Reply-To: <20201002153559.GJ2338114@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 00:38:50 +0800
Message-ID: <CAE2XoE_z3j+_+Oh1Kn-GSAT4q0_nXnT0sLHMLCw0+r1o0WBJSA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000026c50f05b0b2c5f8"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000026c50f05b0b2c5f8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2020 at 11:36 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:
>
> On Fri, Oct 02, 2020 at 01:32:28AM +0800, Yonggang Luo wrote:
> > msys2/mingw lacks the POSIX-required langinfo.h.
> >
> > gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe
-lncursesw -lgnurx -ltre -lintl -liconv
> > test.c:4:10: fatal error: langinfo.h: No such file or directory
> >     4 | #include <langinfo.h>
> >       |          ^~~~~~~~~~~~
> > compilation terminated.
> >
> > So we using g_get_codeset instead of nl_langinfo(CODESET)
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  ui/curses.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/ui/curses.c b/ui/curses.c
> > index a59b23a9cf..12bc682cf9 100644
> > --- a/ui/curses.c
> > +++ b/ui/curses.c
> > @@ -30,7 +30,6 @@
> >  #endif
> >  #include <locale.h>
> >  #include <wchar.h>
> > -#include <langinfo.h>
> >  #include <iconv.h>
> >
> >  #include "qapi/error.h"
> > @@ -526,6 +525,7 @@ static void font_setup(void)
> >      iconv_t nativecharset_to_ucs2;
> >      iconv_t font_conv;
> >      int i;
> > +    g_autofree gchar *local_codeset =3D g_get_codeset();
> >
> >      /*
> >       * Control characters are normally non-printable, but VGA does hav=
e
> > @@ -566,14 +566,14 @@ static void font_setup(void)
> >        0x25bc
> >      };
> >
> > -    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), "UCS-2"=
);
> > +    ucs2_to_nativecharset =3D iconv_open(local_codeset, "UCS-2");
> >      if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
> >          fprintf(stderr, "Could not convert font glyphs from UCS-2:
'%s'\n",
> >                          strerror(errno));
> >          exit(1);
> >      }
> >
> > -    nativecharset_to_ucs2 =3D iconv_open("UCS-2", nl_langinfo(CODESET)=
);
> > +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", local_codeset);
> >      if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
> >          iconv_close(ucs2_to_nativecharset);
> >          fprintf(stderr, "Could not convert font glyphs to UCS-2:
'%s'\n",
> > @@ -581,7 +581,7 @@ static void font_setup(void)
> >          exit(1);
> >      }
> >
> > -    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
> > +    font_conv =3D iconv_open(local_codeset, font_charset);
> >      if (font_conv =3D=3D (iconv_t) -1) {
> >          iconv_close(ucs2_to_nativecharset);
> >          iconv_close(nativecharset_to_ucs2);
> > @@ -602,7 +602,7 @@ static void font_setup(void)
> >      /* DEL */
> >      convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
> >
> > -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> > +    if (strcmp(local_codeset, "UTF-8")) {
>
> If you're removing use of nl_langinfo / langinfo.h then you need
> to also update configure, because it is checking for this function
> and header file when validating curses library support.
The change of configure are waiting for meson 0.56, so I didn't post that
yet And this patch
is a pre-request for msys2/mingw support and won't hurt other platform

We are converting everything to meson, so I am not willing to change
configure this time
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000026c50f05b0b2c5f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 2, 2020 at 11:36 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Fri, Oct 02, 2020 at 01:32:28AM +0800, Yonggan=
g Luo wrote:<br>&gt; &gt; msys2/mingw lacks the POSIX-required langinfo.h.<=
br>&gt; &gt;<br>&gt; &gt; gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/=
ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv<br>&gt; &gt; test.c:=
4:10: fatal error: langinfo.h: No such file or directory<br>&gt; &gt; =C2=
=A0 =C2=A0 4 | #include &lt;langinfo.h&gt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>&gt; &gt; compilati=
on terminated.<br>&gt; &gt;<br>&gt; &gt; So we using g_get_codeset instead =
of nl_langinfo(CODESET)<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang L=
uo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&g=
t;<br>&gt; &gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@red=
hat.com">kraxel@redhat.com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0ui/c=
urses.c | 10 +++++-----<br>&gt; &gt; =C2=A01 file changed, 5 insertions(+),=
 5 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/ui/curses.c b/ui/cur=
ses.c<br>&gt; &gt; index a59b23a9cf..12bc682cf9 100644<br>&gt; &gt; --- a/u=
i/curses.c<br>&gt; &gt; +++ b/ui/curses.c<br>&gt; &gt; @@ -30,7 +30,6 @@<br=
>&gt; &gt; =C2=A0#endif<br>&gt; &gt; =C2=A0#include &lt;locale.h&gt;<br>&gt=
; &gt; =C2=A0#include &lt;wchar.h&gt;<br>&gt; &gt; -#include &lt;langinfo.h=
&gt;<br>&gt; &gt; =C2=A0#include &lt;iconv.h&gt;<br>&gt; &gt; <br>&gt; &gt;=
 =C2=A0#include &quot;qapi/error.h&quot;<br>&gt; &gt; @@ -526,6 +525,7 @@ s=
tatic void font_setup(void)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0iconv_t native=
charset_to_ucs2;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0iconv_t font_conv;<br>&gt=
; &gt; =C2=A0 =C2=A0 =C2=A0int i;<br>&gt; &gt; + =C2=A0 =C2=A0g_autofree gc=
har *local_codeset =3D g_get_codeset();<br>&gt; &gt; <br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0/*<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 * Control characters are =
normally non-printable, but VGA does have<br>&gt; &gt; @@ -566,14 +566,14 @=
@ static void font_setup(void)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A00x25=
bc<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0};<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =
=C2=A0ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET), &quot;UCS-=
2&quot;);<br>&gt; &gt; + =C2=A0 =C2=A0ucs2_to_nativecharset =3D iconv_open(=
local_codeset, &quot;UCS-2&quot;);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0if (ucs=
2_to_nativecharset =3D=3D (iconv_t) -1) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fprintf(stderr, &quot;Could not convert font glyphs from UCS-=
2: &#39;%s&#39;\n&quot;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errno));<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0}<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =C2=A0nativecharset_to_u=
cs2 =3D iconv_open(&quot;UCS-2&quot;, nl_langinfo(CODESET));<br>&gt; &gt; +=
 =C2=A0 =C2=A0nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot;, local=
_codeset);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0if (nativecharset_to_ucs2 =3D=
=3D (iconv_t) -1) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_cl=
ose(ucs2_to_nativecharset);<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
fprintf(stderr, &quot;Could not convert font glyphs to UCS-2: &#39;%s&#39;\=
n&quot;,<br>&gt; &gt; @@ -581,7 +581,7 @@ static void font_setup(void)<br>&=
gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0}<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =C2=A0font_conv =3D iconv_o=
pen(nl_langinfo(CODESET), font_charset);<br>&gt; &gt; + =C2=A0 =C2=A0font_c=
onv =3D iconv_open(local_codeset, font_charset);<br>&gt; &gt; =C2=A0 =C2=A0=
 =C2=A0if (font_conv =3D=3D (iconv_t) -1) {<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0iconv_close(ucs2_to_nativecharset);<br>&gt; &gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_close(nativecharset_to_ucs2);<br>&gt; &gt;=
 @@ -602,7 +602,7 @@ static void font_setup(void)<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0/* DEL */<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0convert_ucs(0x7F, 0x23=
02, ucs2_to_nativecharset);<br>&gt; &gt; <br>&gt; &gt; - =C2=A0 =C2=A0if (s=
trcmp(nl_langinfo(CODESET), &quot;UTF-8&quot;)) {<br>&gt; &gt; + =C2=A0 =C2=
=A0if (strcmp(local_codeset, &quot;UTF-8&quot;)) {<br>&gt;<br>&gt; If you&#=
39;re removing use of nl_langinfo / langinfo.h then you need<br>&gt; to als=
o update configure, because it is checking for this function<br>&gt; and he=
ader file when validating curses library support.<div>The change of configu=
re are waiting for meson 0.56, so I didn&#39;t post that yet And this patch=
</div><div>is a pre-request for msys2/mingw support and won&#39;t hurt othe=
r platform</div><div><br></div><div>We are converting everything to meson, =
so I am not willing to change configure this time<br>&gt;<br>&gt;<br>&gt; R=
egards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://berrange.co=
m">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D=
"https://www.flickr.com/photos/dberrange">https://www.flickr.com/photos/dbe=
rrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https://libvirt.or=
g</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138.berrange.c=
om</a> :|<br>&gt; |: <a href=3D"https://entangle-photo.org">https://entangl=
e-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.instag=
ram.com/dberrange">https://www.instagram.com/dberrange</a> :|<br>&gt;<br><b=
r><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo</div></div>

--00000000000026c50f05b0b2c5f8--

