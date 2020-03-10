Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03798C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B957C208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbXt4QTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B957C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBktK-0004Cx-S4
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 15:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBksO-0003gy-PW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBksN-00020r-IF
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 15:49:16 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:35141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBksK-0001xx-DY; Tue, 10 Mar 2020 15:49:12 -0400
Received: by mail-io1-xd42.google.com with SMTP id h8so14085707iob.2;
 Tue, 10 Mar 2020 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uI3JFUHhKOPjEYddkRjvpoV1Wbus4myLT0ZKlUz2e8k=;
 b=FbXt4QTPtEBYhXNQIALGPjvlKbzjTdneQdPmS+GAwxXzThsUQI7iLsTPT1ON08wfxu
 Yb6UCt8VKs86ZS2/vadlI1OG5EBT5kbC7mmVHYMQwO4o0UYEoqps0s1hurLtm+slIRv9
 yYrFfRC6tqMePKk6TvuzKn9vnH3MZUQZ9wyLB3axobBHvC7KA+GtKgzAX7ERnnGrkTvO
 /rNdOSp31k2xIAmH0M00c54rUeV2NCHNcLwbPjtASouoyU1xWTR2aTih0nMREEFR6+NI
 MKvfvtqLUWz5muSBJLmWKwFQOa9y7EnXqcH0bJ0tHDmx4zqfkLbcLK3sVPtbJRrKt2Xs
 qAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uI3JFUHhKOPjEYddkRjvpoV1Wbus4myLT0ZKlUz2e8k=;
 b=cyuydcsQy5yy77yWYdhACGTqIUoLDuZ6uDksV42CJRgaT9LUWzXjokJHxHrJ22pLB9
 QifnSx+MkL66lAUFSafXDHWhw/rPXskCOYyBcAU7fx4ibz6/3h+sUfzWKTOnPBpnPQtM
 db/piCvaB9RzL/zPJoO/PHQzGTl14JJyqiVh3liH1REZzXOU41IKtUs7JhK6fHziW0bG
 +YIZNKtTrjKjFVGQYTkWVbsgH5i7ogxzJMy5zQ2N1ycG2WcksbrldwLMLA71/0f0b6vI
 NpgGdzLp5q5tKcWd2bKKmGls7dwRtSGa82mGPsZbYXVVWUmXTEUh68ZaqQdKd0UT2dwh
 yGTA==
X-Gm-Message-State: ANhLgQ01OB2mtSDlLfsH3Y7t1sKKzBn1fOmwNK/9wy4X5Bg8aOlKh3IA
 hJGATm+lq3gB6GEUSRLXuPM2XqlXBSzM2fm6Z2o=
X-Google-Smtp-Source: ADFU+vt+WZzpVEwuecKC3cU40BJhHw4NM0oT4kXJZs8GtH4Y7doqJ1UNyZ81+ScMbzzQOw9OpcpteeZ+YDWUpGwhXNM=
X-Received: by 2002:a02:caa8:: with SMTP id e8mr22139910jap.126.1583869751241; 
 Tue, 10 Mar 2020 12:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200303091254.22373-1-imammedo@redhat.com>
 <aef518d0-d8e5-7972-0530-8f8a4c64f1e1@redhat.com>
 <20200306114838.27603031@redhat.com>
In-Reply-To: <20200306114838.27603031@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 10 Mar 2020 20:49:00 +0100
Message-ID: <CAPan3WqN4dFcsLz6eCrfA_MT-iQoOvmKxFYyq0=mZnVkEPG8QQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e4b07405a0856905"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e4b07405a0856905
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Fri, Mar 6, 2020 at 11:49 AM Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 6 Mar 2020 11:33:07 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>
> > On 3/3/20 10:12 AM, Igor Mammedov wrote:
> > > SOC object returned by object_new() is leaked in current code.
> > > Set SOC parent explicitly to board and then unref to SOC object
> > > to make sure that refererence returned by object_new() is taken
> > > care of.
> > >
> > > The SOC object will be kept alive by its parent (machine) and
> > > will be automatically freed when MachineState is destroyed.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Reported-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >   hw/arm/cubieboard.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> > > index 089f9a30c1..12f8ac798d 100644
> > > --- a/hw/arm/cubieboard.c
> > > +++ b/hw/arm/cubieboard.c
> > > @@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo =3D {
> > >
> > >   static void cubieboard_init(MachineState *machine)
> > >   {
> > > -    AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10));
> > > +    AwA10State *a10;
> > >       Error *err =3D NULL;
> > >
> >
> > What about using object_new_with_props similarly to commit e4c81e3a451f=
?
> I prefer explicit object_property_add_child() and would use
> above only if there are list of properties to feed to it.
>
>
> >      a10 =3D AW_A10(object_new_with_props(TYPE_AW_A10, OBJECT(s), "soc"=
,
> >                                         &err, NULL));
> >      if (err !=3D NULL) {
> >          error_propagate(errp, err);
> >          return;
> >      }
> >
> > > +    a10 =3D AW_A10(object_new(TYPE_AW_A10));
> > > +    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
> > > +                              &error_abort);
> > > +    object_unref(OBJECT(a10));
>

Thanks, I added this same solution to the Allwinner H3 series, and its
working fine there.

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> > > +
> > >       object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err=
);
> > >       if (err !=3D NULL) {
> > >           error_reportf_err(err, "Couldn't set phy address: ");
> > >
> >
>
>
>

--=20
Niek Linnenbank

--000000000000e4b07405a0856905
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Igor,<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 6, 2020 at 11:49 =
AM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">On Fri, 6 Mar 2020 11:33:07 +0100<br>
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=
=3D"_blank">philmd@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On 3/3/20 10:12 AM, Igor Mammedov wrote:<br>
&gt; &gt; SOC object returned by object_new() is leaked in current code.<br=
>
&gt; &gt; Set SOC parent explicitly to board and then unref to SOC object<b=
r>
&gt; &gt; to make sure that refererence returned by object_new() is taken<b=
r>
&gt; &gt; care of.<br>
&gt; &gt; <br>
&gt; &gt; The SOC object will be kept alive by its parent (machine) and<br>
&gt; &gt; will be automatically freed when MachineState is destroyed.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redha=
t.com" target=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; &gt; Reported-by: Andrew Jones &lt;<a href=3D"mailto:drjones@redhat.co=
m" target=3D"_blank">drjones@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 =C2=A0hw/arm/cubieboard.c | 7 ++++++-<br>
&gt; &gt;=C2=A0 =C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>
&gt; &gt; index 089f9a30c1..12f8ac798d 100644<br>
&gt; &gt; --- a/hw/arm/cubieboard.c<br>
&gt; &gt; +++ b/hw/arm/cubieboard.c<br>
&gt; &gt; @@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo =
=3D {<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0static void cubieboard_init(MachineState *machine)<br=
>
&gt; &gt;=C2=A0 =C2=A0{<br>
&gt; &gt; -=C2=A0 =C2=A0 AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10)=
);<br>
&gt; &gt; +=C2=A0 =C2=A0 AwA10State *a10;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt; <br>
&gt; What about using object_new_with_props similarly to commit e4c81e3a451=
f?<br>
I prefer explicit object_property_add_child() and would use<br>
above only if there are list of properties to feed to it.<br>
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 a10 =3D AW_A10(object_new_with_props(TYPE_AW_A10, =
OBJECT(s), &quot;soc&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;err, NULL));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (err !=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; <br>
&gt; &gt; +=C2=A0 =C2=A0 a10 =3D AW_A10(object_new(TYPE_AW_A10));<br>
&gt; &gt; +=C2=A0 =C2=A0 object_property_add_child(OBJECT(machine), &quot;s=
oc&quot;, OBJECT(a10),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
&gt; &gt; +=C2=A0 =C2=A0 object_unref(OBJECT(a10));<br></blockquote><div><b=
r></div><div>Thanks, I added this same solution to the Allwinner H3 series,=
 and its working fine there.</div><div><br></div><div>Tested-by: Niek Linne=
nbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.=
com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt; &gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(&amp;a10=
-&gt;emac), 1, &quot;phy-addr&quot;, &amp;err);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D NULL) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_reportf_err(err, &q=
uot;Couldn&#39;t set phy address: &quot;);<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; <br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000e4b07405a0856905--

