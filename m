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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55239C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5E8206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Uz9vBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5E8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPCK-0006DP-PJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOP9L-0002kM-7Q; Fri, 02 Oct 2020 13:47:19 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOP9I-0004Q2-DK; Fri, 02 Oct 2020 13:47:18 -0400
Received: by mail-lj1-x241.google.com with SMTP id a15so1875814ljk.2;
 Fri, 02 Oct 2020 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=9bckGEsdJ4rfT4qLRpHPnXbsTMT5MvGwDPFj9taiq80=;
 b=K/Uz9vBmb97w886C/kNqziqYSsJuob2BC+9XoCCweuxrAj72ccWS3n8y44eqB4nRZS
 Z48pbLUgol+L43BtqkMN8X70ddRy+MGcYv/HaxR+WPt4aqQ8dAU7j4c9khU21XIkDnGH
 Qpwvp8Jr2FonjH+OdhfuUmZ17u+M7gUpon0D3zVUfqCJ+p+VzROxkn7UO8nRxCr+U2dI
 2T416yxGtquxsoYL7Zr63JjLpA1k0nx6wuB+G0J9eRKnujI8LR5F4wNNwrHjuJvsO6RH
 2KlZjVeTxlLNO2zzyu++z/UQayA6hOqJp5e+MfSkOP1dAZ2ntoosxT4neWoGKwwF5ik3
 BFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=9bckGEsdJ4rfT4qLRpHPnXbsTMT5MvGwDPFj9taiq80=;
 b=mrO6isWB9gZFhx0TW4QAwLVkVfSnz3Tp7OLSgla5Qa/Mq+Jyrnrfibg5H8BwA+jC3i
 zDCknbs/WHXrz7F9fXblJHDUg/8GafDLQZb1CDt3t2uYSHtSQuSAiTlUXnHrRxZR3Kh9
 eKWwHvwtrRRK/SitxcqET8DoJJmCJg6l/XayU+EOQfPHoZCWYnSDTPEv7mPaOxpfN3zg
 4U3Tus51ANyNT2udaXTmw5t6NrSXN22h3rkNVAKtEnHqcuqi6BDOECZQbMEAxev9wxHP
 6xiH1ij8coYLT29/575h+JPsSoiEt5WaO3f4mVZ3bP33WZo261gSu6bmYnyX0t48ntWb
 kf3A==
X-Gm-Message-State: AOAM531VRVehkwUfoRXNjnq7brk/X82kK3rfX/MXMKPHfPR2Wa7q/vQp
 0U6MPQkWSfuSELuBH3+HFJT9z4zkI3LtaX+5mg0=
X-Google-Smtp-Source: ABdhPJwdXrJIicN3LdlWXXyKIaCYK2J+xWKB9SYdcU8wd70L6QEMLhF1mWdsu3xHivVpnhdZ2+7XZ9C3W5LnWCwPRk8=
X-Received: by 2002:a2e:b80c:: with SMTP id u12mr949926ljo.300.1601660833914; 
 Fri, 02 Oct 2020 10:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201001173230.829-1-luoyonggang@gmail.com>
 <20201001173230.829-3-luoyonggang@gmail.com>
 <20201002153559.GJ2338114@redhat.com>
 <CAE2XoE_z3j+_+Oh1Kn-GSAT4q0_nXnT0sLHMLCw0+r1o0WBJSA@mail.gmail.com>
 <20201002164232.GO2338114@redhat.com>
In-Reply-To: <20201002164232.GO2338114@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2020 01:47:02 +0800
Message-ID: <CAE2XoE_+ERRdDgGcisNj0WWMU=rCs49PrikVw6Tk+Ov2TC0+Tw@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000e66de05b0b3b9e2"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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

--0000000000000e66de05b0b3b9e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2020 at 12:42 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:
>
> On Sat, Oct 03, 2020 at 12:38:50AM +0800, =E7=BD=97=E5=8B=87=E5=88=9A(Yon=
ggang Luo) wrote:
> > On Fri, Oct 2, 2020 at 11:36 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com>
> > wrote:
> > >
> > > On Fri, Oct 02, 2020 at 01:32:28AM +0800, Yonggang Luo wrote:
> > > > msys2/mingw lacks the POSIX-required langinfo.h.
> > > >
> > > > gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe
> > -lncursesw -lgnurx -ltre -lintl -liconv
> > > > test.c:4:10: fatal error: langinfo.h: No such file or directory
> > > >     4 | #include <langinfo.h>
> > > >       |          ^~~~~~~~~~~~
> > > > compilation terminated.
> > > >
> > > > So we using g_get_codeset instead of nl_langinfo(CODESET)
> > > >
> > > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > ---
> > > >  ui/curses.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/ui/curses.c b/ui/curses.c
> > > > index a59b23a9cf..12bc682cf9 100644
> > > > --- a/ui/curses.c
> > > > +++ b/ui/curses.c
> > > > @@ -30,7 +30,6 @@
> > > >  #endif
> > > >  #include <locale.h>
> > > >  #include <wchar.h>
> > > > -#include <langinfo.h>
> > > >  #include <iconv.h>
> > > >
> > > >  #include "qapi/error.h"
> > > > @@ -526,6 +525,7 @@ static void font_setup(void)
> > > >      iconv_t nativecharset_to_ucs2;
> > > >      iconv_t font_conv;
> > > >      int i;
> > > > +    g_autofree gchar *local_codeset =3D g_get_codeset();
> > > >
> > > >      /*
> > > >       * Control characters are normally non-printable, but VGA does
have
> > > > @@ -566,14 +566,14 @@ static void font_setup(void)
> > > >        0x25bc
> > > >      };
> > > >
> > > > -    ucs2_to_nativecharset =3D iconv_open(nl_langinfo(CODESET),
"UCS-2");
> > > > +    ucs2_to_nativecharset =3D iconv_open(local_codeset, "UCS-2");
> > > >      if (ucs2_to_nativecharset =3D=3D (iconv_t) -1) {
> > > >          fprintf(stderr, "Could not convert font glyphs from UCS-2:
> > '%s'\n",
> > > >                          strerror(errno));
> > > >          exit(1);
> > > >      }
> > > >
> > > > -    nativecharset_to_ucs2 =3D iconv_open("UCS-2",
nl_langinfo(CODESET));
> > > > +    nativecharset_to_ucs2 =3D iconv_open("UCS-2", local_codeset);
> > > >      if (nativecharset_to_ucs2 =3D=3D (iconv_t) -1) {
> > > >          iconv_close(ucs2_to_nativecharset);
> > > >          fprintf(stderr, "Could not convert font glyphs to UCS-2:
> > '%s'\n",
> > > > @@ -581,7 +581,7 @@ static void font_setup(void)
> > > >          exit(1);
> > > >      }
> > > >
> > > > -    font_conv =3D iconv_open(nl_langinfo(CODESET), font_charset);
> > > > +    font_conv =3D iconv_open(local_codeset, font_charset);
> > > >      if (font_conv =3D=3D (iconv_t) -1) {
> > > >          iconv_close(ucs2_to_nativecharset);
> > > >          iconv_close(nativecharset_to_ucs2);
> > > > @@ -602,7 +602,7 @@ static void font_setup(void)
> > > >      /* DEL */
> > > >      convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
> > > >
> > > > -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> > > > +    if (strcmp(local_codeset, "UTF-8")) {
> > >
> > > If you're removing use of nl_langinfo / langinfo.h then you need
> > > to also update configure, because it is checking for this function
> > > and header file when validating curses library support.
> > The change of configure are waiting for meson 0.56, so I didn't post
that
> > yet And this patch
> > is a pre-request for msys2/mingw support and won't hurt other platform
> >
> > We are converting everything to meson, so I am not willing to change
> > configure this time
>
> I don't see why the configure change has any dependancy on meson 0.56.
> It just requires you to remove the mentioned header file and function
> from the configure check. This patch needs to include that or it is
> incomplete IMHO
>
Because the configure script change far more complicated than you imgaine.
And I post that before
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

--0000000000000e66de05b0b3b9e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Oct 3, 2020 at 12:42 AM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; On Sat, Oct 03, 2020 at 12:38:50AM +0800, =E7=BD=
=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>&gt; &gt; On Fri, Oct 2, 2020=
 at 11:36 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com">berrange@redhat.com</a>&gt;<br>&gt; &gt; wrote:<br>&gt; &gt; &gt;<br>&=
gt; &gt; &gt; On Fri, Oct 02, 2020 at 01:32:28AM +0800, Yonggang Luo wrote:=
<br>&gt; &gt; &gt; &gt; msys2/mingw lacks the POSIX-required langinfo.h.<br=
>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; gcc test.c -DNCURSES_WIDECHAR -=
I/mingw64/include/ncursesw -pipe<br>&gt; &gt; -lncursesw -lgnurx -ltre -lin=
tl -liconv<br>&gt; &gt; &gt; &gt; test.c:4:10: fatal error: langinfo.h: No =
such file or directory<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 4 | #include &l=
t;langinfo.h&gt;<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>&gt; &gt; &gt; &gt; compilation ter=
minated.<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; So we using g_get_co=
deset instead of nl_langinfo(CODESET)<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &=
gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmai=
l.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; &gt; &gt; Reviewed-by: Ge=
rd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&=
gt;<br>&gt; &gt; &gt; &gt; ---<br>&gt; &gt; &gt; &gt; =C2=A0ui/curses.c | 1=
0 +++++-----<br>&gt; &gt; &gt; &gt; =C2=A01 file changed, 5 insertions(+), =
5 deletions(-)<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; diff --git a/u=
i/curses.c b/ui/curses.c<br>&gt; &gt; &gt; &gt; index a59b23a9cf..12bc682cf=
9 100644<br>&gt; &gt; &gt; &gt; --- a/ui/curses.c<br>&gt; &gt; &gt; &gt; ++=
+ b/ui/curses.c<br>&gt; &gt; &gt; &gt; @@ -30,7 +30,6 @@<br>&gt; &gt; &gt; =
&gt; =C2=A0#endif<br>&gt; &gt; &gt; &gt; =C2=A0#include &lt;locale.h&gt;<br=
>&gt; &gt; &gt; &gt; =C2=A0#include &lt;wchar.h&gt;<br>&gt; &gt; &gt; &gt; =
-#include &lt;langinfo.h&gt;<br>&gt; &gt; &gt; &gt; =C2=A0#include &lt;icon=
v.h&gt;<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; =C2=A0#include &quot;=
qapi/error.h&quot;<br>&gt; &gt; &gt; &gt; @@ -526,6 +525,7 @@ static void f=
ont_setup(void)<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0iconv_t nativech=
arset_to_ucs2;<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0iconv_t font_conv=
;<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0int i;<br>&gt; &gt; &gt; &gt; =
+ =C2=A0 =C2=A0g_autofree gchar *local_codeset =3D g_get_codeset();<br>&gt;=
 &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0/*<br>&gt; &gt; =
&gt; &gt; =C2=A0 =C2=A0 =C2=A0 * Control characters are normally non-printa=
ble, but VGA does have<br>&gt; &gt; &gt; &gt; @@ -566,14 +566,14 @@ static =
void font_setup(void)<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A00x2=
5bc<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0};<br>&gt; &gt; &gt; &gt;<br=
>&gt; &gt; &gt; &gt; - =C2=A0 =C2=A0ucs2_to_nativecharset =3D iconv_open(nl=
_langinfo(CODESET), &quot;UCS-2&quot;);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0ucs2_to_nativecharset =3D iconv_open(local_codeset, &quot;UCS-2&quot;);<=
br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0if (ucs2_to_nativecharset =3D=3D=
 (iconv_t) -1) {<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
printf(stderr, &quot;Could not convert font glyphs from UCS-2:<br>&gt; &gt;=
 &#39;%s&#39;\n&quot;,<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strerror(errn=
o));<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>&=
gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; &gt; &gt;<br>&gt; &gt=
; &gt; &gt; - =C2=A0 =C2=A0nativecharset_to_ucs2 =3D iconv_open(&quot;UCS-2=
&quot;, nl_langinfo(CODESET));<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=A0native=
charset_to_ucs2 =3D iconv_open(&quot;UCS-2&quot;, local_codeset);<br>&gt; &=
gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0if (nativecharset_to_ucs2 =3D=3D (iconv_t=
) -1) {<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_clos=
e(ucs2_to_nativecharset);<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fprintf(stderr, &quot;Could not convert font glyphs to UCS-2:<br>=
&gt; &gt; &#39;%s&#39;\n&quot;,<br>&gt; &gt; &gt; &gt; @@ -581,7 +581,7 @@ =
static void font_setup(void)<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0exit(1);<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt; =
&gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; - =C2=A0 =C2=A0font_conv =3D iconv_op=
en(nl_langinfo(CODESET), font_charset);<br>&gt; &gt; &gt; &gt; + =C2=A0 =C2=
=A0font_conv =3D iconv_open(local_codeset, font_charset);<br>&gt; &gt; &gt;=
 &gt; =C2=A0 =C2=A0 =C2=A0if (font_conv =3D=3D (iconv_t) -1) {<br>&gt; &gt;=
 &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_close(ucs2_to_nativechar=
set);<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iconv_close(=
nativecharset_to_ucs2);<br>&gt; &gt; &gt; &gt; @@ -602,7 +602,7 @@ static v=
oid font_setup(void)<br>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0/* DEL */<b=
r>&gt; &gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0convert_ucs(0x7F, 0x2302, ucs2_to=
_nativecharset);<br>&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; - =C2=A0 =C2=
=A0if (strcmp(nl_langinfo(CODESET), &quot;UTF-8&quot;)) {<br>&gt; &gt; &gt;=
 &gt; + =C2=A0 =C2=A0if (strcmp(local_codeset, &quot;UTF-8&quot;)) {<br>&gt=
; &gt; &gt;<br>&gt; &gt; &gt; If you&#39;re removing use of nl_langinfo / l=
anginfo.h then you need<br>&gt; &gt; &gt; to also update configure, because=
 it is checking for this function<br>&gt; &gt; &gt; and header file when va=
lidating curses library support.<br>&gt; &gt; The change of configure are w=
aiting for meson 0.56, so I didn&#39;t post that<br>&gt; &gt; yet And this =
patch<br>&gt; &gt; is a pre-request for msys2/mingw support and won&#39;t h=
urt other platform<br>&gt; &gt;<br>&gt; &gt; We are converting everything t=
o meson, so I am not willing to change<br>&gt; &gt; configure this time<br>=
&gt;<br>&gt; I don&#39;t see why the configure change has any dependancy on=
 meson 0.56.<br>&gt; It just requires you to remove the mentioned header fi=
le and function<br>&gt; from the configure check. This patch needs to inclu=
de that or it is<br>&gt; incomplete IMHO<br>&gt;<div>Because the configure =
script change far more complicated than you imgaine. And I post that before=
<br>&gt; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://b=
errange.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=A0=
<a href=3D"https://www.flickr.com/photos/dberrange">https://www.flickr.com/=
photos/dberrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https://=
libvirt.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138.be=
rrange.com</a> :|<br>&gt; |: <a href=3D"https://entangle-photo.org">https:/=
/entangle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https://ww=
w.instagram.com/dberrange">https://www.instagram.com/dberrange</a> :|<br>&g=
t;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br=
>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincere=
ly,<br>Yonggang Luo</div></div>

--0000000000000e66de05b0b3b9e2--

