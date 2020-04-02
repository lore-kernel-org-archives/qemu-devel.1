Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50498C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A71820757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 16:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ3Ob8sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71820757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK2vd-0003aO-5s
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 12:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK2ub-0002qp-Ni
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK2ua-0002al-67
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:41:49 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jK2uZ-0002Zz-Rm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 12:41:48 -0400
Received: by mail-lf1-x142.google.com with SMTP id n20so3263790lfl.10
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wt8fUxqLd8RvXB0yovBCZ52KDsQP1pA2Yei+DiLfdiU=;
 b=jQ3Ob8sMjpyttmAtBOSb7ZirOoMPjvyYBKr/KNS88+Pmmiv1MyXM9zhqID7NsQixPM
 U7MEP+Jg+gJWCqngh+YWUBa1oFqxaIbHrt4FkMnQoFP6NlsSeMbvt5A4Psy7sIaB3rgA
 ZWT64qqTkDRNgQBtkdgtFR44Ns1Gd86nudXw5tFcpCHcf69EbqXIuX2YVgAKoPILSES3
 2CrXTsDT4RM7t+rISnjF8gh/KIy7/u5u6Xr1wBl2cT90Gb3m7k4uIURv+tmQRTTdnFnJ
 TUAn+iPkXe64KjQaN3T5WRUPKw9uPOTsGGoS1o3fDd2abSPEzFRwmVx2I10gCYePOt6P
 hz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wt8fUxqLd8RvXB0yovBCZ52KDsQP1pA2Yei+DiLfdiU=;
 b=WZLOm/iG05oRbDwH4xiyaByoqacnR0Szvdf6o3BTLdX0kxSkkv1m3MK/PSDZ0lSgmX
 HHeLbsrLQ0vl/NLlXyhZL8mv1tLQ70/dObntw0vwvXZu+2BFmqPaW6WcpSxCIvt3WlF3
 Sy6uJxONllq4e+vhNOZm4Tf9hvh1YN3QE1lkSXVdSHvft+mmnf9Dh+GQLyhQ6QejEUxk
 lnbeLLTAimfUMRUGOvOiraADFagSFDlpSwvBhS/pzH6OSDOJ/+PIylJqzibEOViUfZwS
 pnHUTVpgNnCbNm5R2wVTFjO87EaHwS9FI61feSIFTCe9x+LSdtjtVrjPCS+3eZA1CIW2
 OJKQ==
X-Gm-Message-State: AGi0PuZ2raY0RfnsiKLTjNVUgWeXYBfB3IhrKDRuzP/AhdsdxvviKGnS
 kh1g9JsPhWqFCv9XMAs09OXIz5YjatHu67qKEWE=
X-Google-Smtp-Source: APiQypJZCeEBLfUvn3AqOU30ZUMYklshtktndTF9CNnSkdSku5RNfJgcdHC33rg7JNxj9GYIdYIMCUridT6dQjaVkGs=
X-Received: by 2002:a19:7913:: with SMTP id u19mr2698582lfc.114.1585845706280; 
 Thu, 02 Apr 2020 09:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200402121313.GA5563@simran-Inspiron-5558>
 <c955d844-9d39-930a-fb92-75fd97bb0330@redhat.com>
In-Reply-To: <c955d844-9d39-930a-fb92-75fd97bb0330@redhat.com>
From: Simran Singhal <singhalsimran0@gmail.com>
Date: Thu, 2 Apr 2020 22:11:32 +0530
Message-ID: <CALrZqyPM9oz6W24V8JnNnJadd3P0Nn8F6vCu=ON2vdgh3=NcdA@mail.gmail.com>
Subject: Re: [PATCH] qobject: json-streamer: Remove double test
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fdd42e05a2517932"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fdd42e05a2517932
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 2, 2020 at 6:42 PM Eric Blake <eblake@redhat.com> wrote:

> On 4/2/20 7:13 AM, Simran Singhal wrote:
> > Remove the duplicate test "parser->bracket_count >= 0".
> >
> > Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> > ---
> >   qobject/json-streamer.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
> > index 47dd7ea576..ef48185283 100644
> > --- a/qobject/json-streamer.c
> > +++ b/qobject/json-streamer.c
> > @@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer,
> GString *input,
> >       g_queue_push_tail(&parser->tokens, token);
> >
>
> Adding some context:
>
> >       if ((parser->brace_count > 0 || parser->bracket_count > 0)
> > -        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
> > +        && parser->bracket_count >= 0) {
> >           return;
> >       }
> >
> >     json = json_parser_parse(parser->tokens, parser->ap, &err);
> >     parser->tokens = NULL;
> >
> > out_emit:
>
> This code was rewritten in commit 8d3265b3.  Prior to that, it read:
>
>
>      if (parser->brace_count < 0 ||
>          parser->bracket_count < 0 ||
>          (parser->brace_count == 0 &&
>           parser->bracket_count == 0)) {
>          json = json_parser_parse(parser->tokens, parser->ap, &err);
>          parser->tokens = NULL;
>          goto out_emit;
>      }
>
>      return;
>
> out_emit:
>
> Obviously, the goal of the rewrite was to convert:
>
> if (cond) {
>    do stuff
> } else {
>    return
> }
> more stuff
>
> into the more legible
>
> if (!cond) {
>    return
> }
> do stuff
> more stuff
>
> Let's re-read my original review:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03017.html
>
> > Applying deMorgan's rules:
> >
> > !(brace < 0 || bracket < 0 || (brace == 0 && bracket == 0))
> > !(brace < 0) && !(bracket < 0) && !(brace == 0 && bracket == 0)
> > brace >= 0 && bracket >= 0 && (!(brace == 0) || !(bracket == 0))
> > brace >= 0 && bracket >= 0 && (brace != 0 || bracket != 0)
> >
> > But based on what we learned in the first two conjunctions, we can
> rewrite the third:
> >
> >
> > brace >= 0 && bracket >= 0 && (brace > 0 || bracket > 0)
> >
> > and then commute the logic:
> >
> > (brace > 0 || bracket > 0) && brace >= 0 && bracket >= 0
> >
>
> What I missed was the typo: we checked bracket >= 0 twice, instead of
> the intended brace >= 0 && bracket >= 0.  This needs a v2.
>

Hello Eric,

Thanks for the explanation.
I'll send v2 with the required changes.

--
Simran


>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--000000000000fdd42e05a2517932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 6:42 PM Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/2/20 7:=
13 AM, Simran Singhal wrote:<br>
&gt; Remove the duplicate test &quot;parser-&gt;bracket_count &gt;=3D 0&quo=
t;.<br>
&gt; <br>
&gt; Signed-off-by: Simran Singhal &lt;<a href=3D"mailto:singhalsimran0@gma=
il.com" target=3D"_blank">singhalsimran0@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0qobject/json-streamer.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c<br>
&gt; index 47dd7ea576..ef48185283 100644<br>
&gt; --- a/qobject/json-streamer.c<br>
&gt; +++ b/qobject/json-streamer.c<br>
&gt; @@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer, GS=
tring *input,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_queue_push_tail(&amp;parser-&gt;tokens, to=
ken);<br>
&gt;=C2=A0 =C2=A0<br>
<br>
Adding some context:<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((parser-&gt;brace_count &gt; 0 || parser=
-&gt;bracket_count &gt; 0)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; parser-&gt;bracket_count &gt;=
=3D 0 &amp;&amp; parser-&gt;bracket_count &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; parser-&gt;bracket_count &gt;=
=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0json =3D json_parser_parse(parser-&gt;tokens, parse=
r-&gt;ap, &amp;err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0parser-&gt;tokens =3D NULL;<br>
&gt; <br>
&gt; out_emit:<br>
<br>
This code was rewritten in commit 8d3265b3.=C2=A0 Prior to that, it read:<b=
r>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (parser-&gt;brace_count &lt; 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser-&gt;bracket_count &lt; 0 ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(parser-&gt;brace_count =3D=3D 0 &amp;&am=
p;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser-&gt;bracket_count =3D=3D 0)) {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0json =3D json_parser_parse(parser-&gt;tok=
ens, parser-&gt;ap, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parser-&gt;tokens =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_emit;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return;<br>
<br>
out_emit:<br>
<br>
Obviously, the goal of the rewrite was to convert:<br>
<br>
if (cond) {<br>
=C2=A0 =C2=A0do stuff<br>
} else {<br>
=C2=A0 =C2=A0return<br>
}<br>
more stuff<br>
<br>
into the more legible<br>
<br>
if (!cond) {<br>
=C2=A0 =C2=A0return<br>
}<br>
do stuff<br>
more stuff<br>
<br>
Let&#39;s re-read my original review:<br>
<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03017.h=
tml" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.org/archive/htm=
l/qemu-devel/2018-08/msg03017.html</a><br>
<br>
&gt; Applying deMorgan&#39;s rules:<br>
&gt; <br>
&gt; !(brace &lt; 0 || bracket &lt; 0 || (brace =3D=3D 0 &amp;&amp; bracket=
 =3D=3D 0))<br>
&gt; !(brace &lt; 0) &amp;&amp; !(bracket &lt; 0) &amp;&amp; !(brace =3D=3D=
 0 &amp;&amp; bracket =3D=3D 0)<br>
&gt; brace &gt;=3D 0 &amp;&amp; bracket &gt;=3D 0 &amp;&amp; (!(brace =3D=
=3D 0) || !(bracket =3D=3D 0))<br>
&gt; brace &gt;=3D 0 &amp;&amp; bracket &gt;=3D 0 &amp;&amp; (brace !=3D 0 =
|| bracket !=3D 0)<br>
&gt; <br>
&gt; But based on what we learned in the first two conjunctions, we can rew=
rite the third:<br>
&gt; <br>
&gt; <br>
&gt; brace &gt;=3D 0 &amp;&amp; bracket &gt;=3D 0 &amp;&amp; (brace &gt; 0 =
|| bracket &gt; 0)<br>
&gt; <br>
&gt; and then commute the logic:<br>
&gt; <br>
&gt; (brace &gt; 0 || bracket &gt; 0) &amp;&amp; brace &gt;=3D 0 &amp;&amp;=
 bracket &gt;=3D 0<br>
&gt; <br>
<br>
What I missed was the typo: we checked bracket &gt;=3D 0 twice, instead of =
<br>
the intended brace &gt;=3D 0 &amp;&amp; bracket &gt;=3D 0.=C2=A0 This needs=
 a v2.<br></blockquote><div><br></div><div>Hello Eric,</div><div><br></div>=
<div>Thanks for the explanation.</div><div>I&#39;ll send v2 with the requir=
ed changes.</div><div><br></div><div>--<br></div><div>Simran<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div></div>

--000000000000fdd42e05a2517932--

