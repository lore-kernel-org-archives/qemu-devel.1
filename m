Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE284C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73582067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV0L0EsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73582067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWex-0005mO-PJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWde-00041f-2w
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWdc-00017b-DX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:10:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipWdc-00015J-5v
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 07:10:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so6983412otd.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 04:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uZSmNMhYuQ20psTn3/dUBKkbT7qVH1HAOiBfnzPTvdU=;
 b=HV0L0EsC+fYY5xB2UjvhBXTC5juq/B3HHjjnDptdAxvGi7HRwimy36hLt+J90TD8dn
 Qj/X4GpDXXQmL/RJb/ldpYbL9rXO8IANzZJP7eQg6sfH2RZ5t+6HwtW6RdT1Bsc5XNSs
 gDYhJ4A66S84svOIq4U7l60bM+upTyq982ahI4UHfhy7mcjLz7Rl0NFwJn/QB21KIaLn
 5CTUKu/uVtnyUG0MnqK06gNKhgUmd2kyfc12BG4FMVma737xyJ+3bU2/c5qc1OejXrTR
 ajZSNMh/nedBai31apthIpBFdi3akOaPJi1Tc55Rq9lZSUfCrMINBCq7ycNJqvmpwSuW
 h6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uZSmNMhYuQ20psTn3/dUBKkbT7qVH1HAOiBfnzPTvdU=;
 b=mrV1UR6RvkGKrMKHlThWStnMxOCFiz+DqO66DroqN0IHGp74HK5s2TNDuI8DkiKHMM
 gJqC1cgd++RQ0qtOHGLLmTsAC4McoGpra6YD/0dNxE6QjmCeiv3h7JUs3vBwIFzp4voW
 wX+V79TQexq9R18hbYmZYrRA8L++Pm0odyYJ/ke32hMUxl6p+q3osxTKYOxHhyX2fUf+
 yHa+bR/ZHqgl5VekQ56kzHCehnaddIDFuDHzBf1MyW1lnMHLcfl45HHcuJ0IWplM4iC0
 QFrrQukzxEVeE0sz9zx18xdTSIYDh+HlBU7IwMv869tGjbDK7m3V6zDmdmncjq1ncnWd
 xfjw==
X-Gm-Message-State: APjAAAXhA0U5ITTqW44gwzDREV6iDC5LQzbDHt9lgIippEE3ky9ADuEX
 mHG8Ig6snhBxYO/rEjXh1pChYkaptcRXXoOcCCok9g==
X-Google-Smtp-Source: APXvYqzwKmEXiElAiS6/rSCel9OQj546Bf/ASb1oBpSEpGY6uIuk1JsVD/P4eChfqHy6pvI3cdvqLzcz0X/B7JN4Mps=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr7936488otk.64.1578571807635;
 Thu, 09 Jan 2020 04:10:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 04:10:07 -0800 (PST)
In-Reply-To: <87r208j20o.fsf@linaro.org>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-5-richard.henderson@linaro.org>
 <87r208j20o.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 13:10:07 +0100
Message-ID: <CAL1e-=iiGx6EZHNUpQLDLyx8kbfg4G2hERMA1ZOhJpo_sN2E+w@mail.gmail.com>
Subject: [PATCH 4/4] vl: Only choose enabled accelerators in
 configure_accelerators
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d8ba2c059bb3e35b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d8ba2c059bb3e35b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thursday, January 9, 2020, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
> > By choosing "tcg:kvm" when kvm is not enabled, we generate
> > an incorrect warning: "invalid accelerator kvm".
> >
> > Presumably the inverse is also true with --disable-tcg.
> >
> > Fixes: 28a0961757fc
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  vl.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index 887dbfbb5d..9b7651c80d 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2759,11 +2759,10 @@ static void configure_accelerators(const char
> *progname)
> >
> >          if (accel =3D=3D NULL) {
> >              /* Select the default accelerator */
> > -            if (!accel_find("tcg") && !accel_find("kvm")) {
> > -                error_report("No accelerator selected and"
> > -                             " no default accelerator available");
> > -                exit(1);
> > -            } else {
> > +            bool have_tcg =3D accel_find("tcg");
> > +            bool have_kvm =3D accel_find("kvm");
> > +
> > +            if (have_tcg && have_kvm) {
> >                  int pnlen =3D strlen(progname);
> >                  if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3],
> >          "kvm")) {
>
> I know you're not touching this bit but:
>
> modified   vl.c
> @@ -2763,8 +2763,7 @@ static void configure_accelerators(const char
> *progname)
>              bool have_kvm =3D accel_find("kvm");
>
>              if (have_tcg && have_kvm) {
> -                int pnlen =3D strlen(progname);
> -                if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3],
> "kvm")) {
> +                if (g_str_has_suffix(progname, "kvm")) {
>                      /* If the program name ends with "kvm", we prefer KV=
M
> */
>                      accel =3D "kvm:tcg";
>                  } else {
>
>
> >                      /* If the program name ends with "kvm", we prefer
> KVM */
> > @@ -2771,9 +2770,16 @@ static void configure_accelerators(const char
> *progname)
> >                  } else {
> >                      accel =3D "tcg:kvm";
> >                  }
> > +            } else if (have_kvm) {
> > +                accel =3D "kvm";
> > +            } else if (have_tcg) {
> > +                accel =3D "tcg";
> > +            } else {
> > +                error_report("No accelerator selected and"
> > +                             " no default accelerator available");
> > +                exit(1);
> >              }
> >          }
> > -
> >          accel_list =3D g_strsplit(accel, ":", 0);
> >
> >          for (tmp =3D accel_list; *tmp; tmp++) {
>
> Anyway:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
>
With or without Alex' hint:

Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>

Alex' hint could be a separate patch. If you decide to do it, for that
patch too you can include my r-b.


--=20
> Alex Benn=C3=A9e
>
>

--000000000000d8ba2c059bb3e35b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Alex Benn=C3=A9e &lt;<a href=3D"mailt=
o:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br>
Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" targe=
t=3D"_blank">richard.henderson@linaro.org</a>&gt; writes:<br>
<br>
&gt; By choosing &quot;tcg:kvm&quot; when kvm is not enabled, we generate<b=
r>
&gt; an incorrect warning: &quot;invalid accelerator kvm&quot;.<br>
&gt;<br>
&gt; Presumably the inverse is also true with --disable-tcg.<br>
&gt;<br>
&gt; Fixes: 28a0961757fc<br>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 vl.c | 18 ++++++++++++------<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/vl.c b/vl.c<br>
&gt; index 887dbfbb5d..9b7651c80d 100644<br>
&gt; --- a/vl.c<br>
&gt; +++ b/vl.c<br>
&gt; @@ -2759,11 +2759,10 @@ static void configure_accelerators(const char =
*progname)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accel =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Select the default =
accelerator */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!accel_find(&quot;tcg&q=
uot;) &amp;&amp; !accel_find(&quot;kvm&quot;)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(=
&quot;No accelerator selected and&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; no default accelerator available&=
quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool have_tcg =3D accel_fin=
d(&quot;tcg&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool have_kvm =3D accel_fin=
d(&quot;kvm&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (have_tcg &amp;&amp; hav=
e_kvm) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pnle=
n =3D strlen(progname);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pnle=
n &gt;=3D 3 &amp;&amp; g_str_equal(&amp;progname[pnlen - 3],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;kvm&quot;)) {<br>
<br>
I know you&#39;re not touching this bit but:<br>
<br>
modified=C2=A0 =C2=A0vl.c<br>
@@ -2763,8 +2763,7 @@ static void configure_accelerators(const char *progna=
me)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool have_kvm =3D accel_fin=
d(&quot;kvm&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (have_tcg &amp;&amp; hav=
e_kvm) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pnlen =3D strl=
en(progname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pnlen &gt;=3D =
3 &amp;&amp; g_str_equal(&amp;progname[pnlen - 3], &quot;kvm&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_str_has_suff=
ix(progname, &quot;kvm&quot;)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* If the program name ends with &quot;kvm&quot;, we prefer KVM */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0accel =3D &quot;kvm:tcg&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* If the program name ends with &quot;kvm&quot;, we prefer KVM */<b=
r>
&gt; @@ -2771,9 +2770,16 @@ static void configure_accelerators(const char *=
progname)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 accel =3D &quot;tcg:kvm&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (have_kvm) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 accel =3D &qu=
ot;kvm&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (have_tcg) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 accel =3D &qu=
ot;tcg&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(=
&quot;No accelerator selected and&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; no default accelerator available&=
quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 accel_list =3D g_strsplit(accel, &qu=
ot;:&quot;, 0);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (tmp =3D accel_list; *tmp; tmp++=
) {<br>
<br>
Anyway:<br>
<br>
Reviewed-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
 target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
<br></blockquote><div><br></div><div>With or without Alex&#39; hint:</div><=
div><br></div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-h=
eight:22.1200008392334px">Reviewed by: Aleksandar Markovic &lt;</span><a hr=
ef=3D"mailto:amarkovic@wavecomp.com" target=3D"_blank" style=3D"font-size:1=
4px;line-height:22.1200008392334px">amarkovic@wavecomp.com</a><span style=
=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px">&gt;=
</span><br></div><div>=C2=A0</div><div>Alex&#39; hint could be a separate p=
atch. If you decide to do it, for that patch too you can include my r-b.</d=
iv><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br>
<br>
</blockquote>

--000000000000d8ba2c059bb3e35b--

