Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C93C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B523E20659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlsKFwwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B523E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFknu-0001C9-Ob
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkn5-0000gr-EV; Tue, 08 Sep 2020 17:04:35 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:36347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFkn3-0003oz-He; Tue, 08 Sep 2020 17:04:35 -0400
Received: by mail-lj1-x235.google.com with SMTP id r24so739075ljm.3;
 Tue, 08 Sep 2020 14:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=9ayBa1ll75Oo0fwGyZ1LXoZQI9TnTqj1WA7RNHKFdAE=;
 b=MlsKFwwu2xn8ouUYBk9/0RfRhNkpIcUwdYUuMVKYauAGhvnpv58F++BRoAXmvU3cxK
 uJ5TlEqyVBhtHY1Wou6Hsx5XKI0lAFi7whBL2x1aOkyRQ6BI2GXfnpO6HXcCpp/Lj56N
 lXkCnqixqLt4qp5Y+OoPVMoRkkk9LjVA2NuEyGq3DNZYcgNDBVShQv4w11NqgTwA31ab
 6YhQ4Pc4xWJm0G0s8RaF4GFec2iONq0bNEO2KekOSjKxjBzRkxifbZeuvcygHFzc3KZn
 ER2JApKyHaDr+2nW58J1LqlyZZHJxUqyzZrG2PAldPDyTDXGHaUVC9U7AxytNiNQsh4w
 OSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=9ayBa1ll75Oo0fwGyZ1LXoZQI9TnTqj1WA7RNHKFdAE=;
 b=V/p2nwuyxQK9guzDmlo/D7CArG8Tf8Ovl79BBoqHWtK7S2VcEY3RKRXhkbgUqzvx7w
 v1LwsTTCqcKhWCGiXzvXffzIKbCTxd6jXWKoZdYHkr3P0lHMQxgtnvXgDbeqF4A2V3t8
 s2Z3gducxRTdH7bxqpJqnYLZA5YEH0aenSCLGfNjdiqIzQXBKT0XRtgJScwspngePk87
 MBKsrNEQkXTT5jfRjEFfN16rQ4LgofDsOl02wY4xLOTBCeAdh4UIArDjKPPKIlKORxG2
 mZqISCow9anGELsqcT7gJZAgzZhUS4BtUyctXPxuzw6tHOyeaCXdIXFjXAAvUR7BWRsD
 ISdg==
X-Gm-Message-State: AOAM532/XL7OkA1Q9YH70VJuJhEYJS1Rios244mqv8RhL4pID+nRj7AN
 X+7yNh9ZtHhoLLHXQA73bjeM+0+UMd8Mq1Xh6vg=
X-Google-Smtp-Source: ABdhPJwJKbAd8IpC4iNCxtW3I2Xf96hzM441Lo+19ssBwWwr0WXLgBY/T8OpNn62KJW8moWD6Hi8EcfokhzVADwOXBY=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr187106ljd.467.1599599070967; 
 Tue, 08 Sep 2020 14:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200908184918.1085-1-luoyonggang@gmail.com>
 <20200908184918.1085-5-luoyonggang@gmail.com>
 <CAFEAcA-FGVMKNObinzWgq6sYm9p0GCgPb3mXgx1LD5UnX0wZCQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-FGVMKNObinzWgq6sYm9p0GCgPb3mXgx1LD5UnX0wZCQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 05:04:19 +0800
Message-ID: <CAE2XoE9rS4jBoQftniS19Xmj6LzDvAUJ-P5Oyu6ACTpOxogLfw@mail.gmail.com>
Subject: Re: [PULL 04/16] curses: Fixes curses compiling errors.
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000687ccc05aed3ae7d"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000687ccc05aed3ae7d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:29 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 8 Sep 2020 at 19:56, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > This is the compiling error:
> > ../ui/curses.c: In function 'curses_refresh':
> > ../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr,
> maybe_keycode)
> >       |     ^~~~~~~~~~
> > ../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
> >   302 |             enum maybe_keycode next_maybe_keycode;
> >       |                                ^~~~~~~~~~~~~~~~~~
> > ../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized
> in this function [-Werror=3Dmaybe-uninitialized]
> >   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr,
> maybe_keycode)
> >       |     ^~~~~~~~~~
> > ../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
> >   265 |     enum maybe_keycode maybe_keycode;
> >       |                        ^~~~~~~~~~~~~
> > cc1.exe: all warnings being treated as errors
>
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  ui/curses.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/curses.c b/ui/curses.c
> > index 12bc682cf9..e4f9588c3e 100644
> > --- a/ui/curses.c
> > +++ b/ui/curses.c
> > @@ -262,7 +262,7 @@ static int curses2foo(const int _curses2foo[], cons=
t
> int _curseskey2foo[],
> >  static void curses_refresh(DisplayChangeListener *dcl)
> >  {
> >      int chr, keysym, keycode, keycode_alt;
> > -    enum maybe_keycode maybe_keycode;
> > +    enum maybe_keycode maybe_keycode =3D CURSES_KEYCODE;
> >
> >      curses_winch_check();
> >
> > @@ -299,7 +299,7 @@ static void curses_refresh(DisplayChangeListener
> *dcl)
> >
> >          /* alt or esc key */
> >          if (keycode =3D=3D 1) {
> > -            enum maybe_keycode next_maybe_keycode;
> > +            enum maybe_keycode next_maybe_keycode =3D CURSES_KEYCODE;
> >              int nextchr =3D console_getch(&next_maybe_keycode);
> >
> >              if (nextchr !=3D -1) {
>
> The problem here is that the compiler hasn't noticed that it's
> impossible to return something other than -1 from console_getch()
> without initializing next_maybe_keycode.
>
> There are two possible reasons for this:
> (1) your gcc is a bit old -- newer gcc are better at working
> out this kind of thing. But you said on irc that you're using
> gcc 10.2.0, which is new...
>
> (2) this is a variant of the problem with the system headers
> that causes us to have to redefine assert() in osdep.h, only
> with abort() (ie abort() is perhaps not marked as noreturn in
> the system headers). If this theory is true, then changing
> the abort() in console_getch() to instead be g_assert_not_reached()
> would be a different way to avoid the warnings (and if that works
> we should probably fix up abort() the way we do assert()).
>
Tried   g_assert_not_reached still not fixes the issue, and I verified
on debug build, either g_assert_not_reached or abort, the compiling error
doesn't appear,
the debug build are the build that configured with --enable-debug-info
--enable-debug

this compiling error only appear in release build.

>
> thanks
> -- PMM
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000687ccc05aed3ae7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:29 AM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Tue, 8 Sep 2020 at 19:56, Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This is the compiling error:<br>
&gt; ../ui/curses.c: In function &#39;curses_refresh&#39;:<br>
&gt; ../ui/curses.c:256:5: error: &#39;next_maybe_keycode&#39; may be used =
uninitialized in this function [-Werror=3Dmaybe-uninitialized]<br>
&gt;=C2=A0 =C2=A0256 |=C2=A0 =C2=A0 =C2=A0curses2foo(_curses2keycode, _curs=
eskey2keycode, chr, maybe_keycode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>
&gt; ../ui/curses.c:302:32: note: &#39;next_maybe_keycode&#39; was declared=
 here<br>
&gt;=C2=A0 =C2=A0302 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum =
maybe_keycode next_maybe_keycode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~=
~~~~~~~~~~~~~<br>
&gt; ../ui/curses.c:256:5: error: &#39;maybe_keycode&#39; may be used unini=
tialized in this function [-Werror=3Dmaybe-uninitialized]<br>
&gt;=C2=A0 =C2=A0256 |=C2=A0 =C2=A0 =C2=A0curses2foo(_curses2keycode, _curs=
eskey2keycode, chr, maybe_keycode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>
&gt; ../ui/curses.c:265:24: note: &#39;maybe_keycode&#39; was declared here=
<br>
&gt;=C2=A0 =C2=A0265 |=C2=A0 =C2=A0 =C2=A0enum maybe_keycode maybe_keycode;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>
&gt; cc1.exe: all warnings being treated as errors<br>
<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 ui/curses.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/ui/curses.c b/ui/curses.c<br>
&gt; index 12bc682cf9..e4f9588c3e 100644<br>
&gt; --- a/ui/curses.c<br>
&gt; +++ b/ui/curses.c<br>
&gt; @@ -262,7 +262,7 @@ static int curses2foo(const int _curses2foo[], con=
st int _curseskey2foo[],<br>
&gt;=C2=A0 static void curses_refresh(DisplayChangeListener *dcl)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int chr, keysym, keycode, keycode_alt;<br>
&gt; -=C2=A0 =C2=A0 enum maybe_keycode maybe_keycode;<br>
&gt; +=C2=A0 =C2=A0 enum maybe_keycode maybe_keycode =3D CURSES_KEYCODE;<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 curses_winch_check();<br>
&gt;<br>
&gt; @@ -299,7 +299,7 @@ static void curses_refresh(DisplayChangeListener *=
dcl)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* alt or esc key */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (keycode =3D=3D 1) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum maybe_keycode next_may=
be_keycode;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum maybe_keycode next_may=
be_keycode =3D CURSES_KEYCODE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int nextchr =3D consol=
e_getch(&amp;next_maybe_keycode);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (nextchr !=3D -1) {=
<br>
<br>
The problem here is that the compiler hasn&#39;t noticed that it&#39;s<br>
impossible to return something other than -1 from console_getch()<br>
without initializing next_maybe_keycode.<br>
<br>
There are two possible reasons for this:<br>
(1) your gcc is a bit old -- newer gcc are better at working<br>
out this kind of thing. But you said on irc that you&#39;re using<br>
gcc 10.2.0, which is new...<br>
<br>
(2) this is a variant of the problem with the system headers<br>
that causes us to have to redefine assert() in osdep.h, only<br>
with abort() (ie abort() is perhaps not marked as noreturn in<br>
the system headers). If this theory is true, then changing<br>
the abort() in console_getch() to instead be g_assert_not_reached()<br>
would be a different way to avoid the warnings (and if that works<br>
we should probably fix up abort() the way we do assert()).<br></blockquote>=
<div>Tried=C2=A0=C2=A0

g_assert_not_reached still not fixes the issue, and I verified=C2=A0</div><=
div>on debug build, either g_assert_not_reached or abort, the compiling err=
or doesn&#39;t appear,</div><div>the debug build are the build that configu=
red with=C2=A0--enable-debug-info --enable-debug </div><div><br></div><div>=
this compiling error only appear in release build.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000687ccc05aed3ae7d--

