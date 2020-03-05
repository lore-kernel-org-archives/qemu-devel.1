Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FDC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28C4207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 20:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew4+zdbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28C4207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9wnB-0004u4-7N
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 15:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9wmA-0003F1-8a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j9wm8-0001AR-P5
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 15:07:22 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e]:38544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j9wm8-0001A6-GE; Thu, 05 Mar 2020 15:07:20 -0500
Received: by mail-il1-x12e.google.com with SMTP id f5so6199489ilq.5;
 Thu, 05 Mar 2020 12:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KEzPboJB6JCs5k214g5oOJeAWpMAUeoVymAHK5jdb0U=;
 b=Ew4+zdbBWdux/czmoU/zebNdM7su8m0gnxumYsbuP3/9JggPjPs+rtNZGddzA+I75c
 ufkaw1zudVhFopWrN2cAtOEZhRicl9ixlRJnnB2vf62wI7nw4hNeL/1ZhuuNPIvu1ftP
 E5VPzCxGb1YbhlVWZARya6NGgMjZX/PBQiakfCG/NOA3OPC+PSuF5gprzXYlWwJwjrgT
 rym4TMLsGJCduTXxKFqBjBOBKbM+YUqT4Q53WqlX6QS7WMR7R+CkdCOo+/TwpkDF7aGk
 yJfGqrLQmmx7ThTANUD9WI1rZsNGl2Zbw3hiwv3rWSE0Ry8ry9g3gT6sspirInZh9TVv
 da8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KEzPboJB6JCs5k214g5oOJeAWpMAUeoVymAHK5jdb0U=;
 b=t9LOCpPwJcQFg4ZxyH7bH///lMunrSCTcaIm+w2TvLLh4ttm/Ac8PORusOWyjk2bfF
 yFLlCV02yqcM4dtcdpgZXCJru/rDnF8jj/aizHdCx5UtDg85m7zqv1zgoRG4qAj13Hef
 W/1oJAg6mYj5u6qjnFvgFzUWc3MBE8yCyDrQwCtMiPVW1BOGaZEEAQ6o5ERxUC8bVIpX
 hGQhCgfxuafEN8MzMmvy7/WwpQe582oOXlwKSKyg0Zxhn47XC5muM1rVZx/W8j7AJWFx
 GkJ1n92fMvDGKn0PwajV9sS0lhEvGv01fMt5j1fyVGhSgaplBh2HAhS5MjtBMYlI0ejn
 87Mw==
X-Gm-Message-State: ANhLgQ2C/SsA8KFJcmJI0fYfFZWPM1tkAgYo2S01OaJ5pUjmSAAlprvK
 BcjrsxaC1FjJtIqjmPGm/0gkpiox1Xa4+AWvWD0=
X-Google-Smtp-Source: ADFU+vtJ17b6xarMyQT0RoN9IxOGRnrfivjwEA6o58D+al+Jdfx9/YblNkU9nFysKdQuUuySdACxhV+1YpHp0M73Tl0=
X-Received: by 2002:a92:90c:: with SMTP id y12mr656860ilg.306.1583438839867;
 Thu, 05 Mar 2020 12:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20200303091254.22373-1-imammedo@redhat.com>
In-Reply-To: <20200303091254.22373-1-imammedo@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 5 Mar 2020 21:07:08 +0100
Message-ID: <CAPan3Wqr8HuXSmZL1DZTSjD_PfcoxNO5FkKAr36rzY8+vyOORg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000092f06005a021157f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12e
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, drjones@redhat.com,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000092f06005a021157f
Content-Type: text/plain; charset="UTF-8"

Hi Igor,

On Tue, Mar 3, 2020 at 10:13 AM Igor Mammedov <imammedo@redhat.com> wrote:

> SOC object returned by object_new() is leaked in current code.
> Set SOC parent explicitly to board and then unref to SOC object
> to make sure that refererence returned by object_new() is taken
> care of.
>
> The SOC object will be kept alive by its parent (machine) and
> will be automatically freed when MachineState is destroyed.
>

Thanks for reporting this issue. In the Allwinner H3 series, I actually
inherited this pattern as well,
so I'll include this fix as well in the next version of that series.


>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/cubieboard.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 089f9a30c1..12f8ac798d 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo = {
>
>  static void cubieboard_init(MachineState *machine)
>  {
> -    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
> +    AwA10State *a10;
>      Error *err = NULL;
>
> +    a10 = AW_A10(object_new(TYPE_AW_A10));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
> +                              &error_abort);
> +    object_unref(OBJECT(a10));
>

I see that there are a few machines which also do
object_property_add_child() to add its
SoC object to the machine, but they do not do the object_unref(). Can you
explain why it is needed here?
Or do the other machines still have a leak due to the missing
object_unref()? Examples are:
  hw/arm/sabrelite.c
  hw/arm/mcimx7d-sabre.c
  hw/arm/mcimx6ul-evk.c

Regards,
Niek


> +
>      object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
>      if (err != NULL) {
>          error_reportf_err(err, "Couldn't set phy address: ");
> --
> 2.18.1
>
>
>

-- 
Niek Linnenbank

--00000000000092f06005a021157f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Igor,<br></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, 2020 at 10:13 AM Igor Mamm=
edov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">SOC obje=
ct returned by object_new() is leaked in current code.<br>
Set SOC parent explicitly to board and then unref to SOC object<br>
to make sure that refererence returned by object_new() is taken<br>
care of.<br>
<br>
The SOC object will be kept alive by its parent (machine) and<br>
will be automatically freed when MachineState is destroyed.<br></blockquote=
><div><br></div><div>Thanks for reporting this issue. In the Allwinner H3 s=
eries, I actually inherited this pattern as well,</div><div>so I&#39;ll inc=
lude this fix as well in the next version of that series.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Reported-by: Andrew Jones &lt;<a href=3D"mailto:drjones@redhat.com" target=
=3D"_blank">drjones@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/cubieboard.c | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c<br>
index 089f9a30c1..12f8ac798d 100644<br>
--- a/hw/arm/cubieboard.c<br>
+++ b/hw/arm/cubieboard.c<br>
@@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo =3D {<br>
<br>
=C2=A0static void cubieboard_init(MachineState *machine)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 AwA10State *a10 =3D AW_A10(object_new(TYPE_AW_A10));<br>
+=C2=A0 =C2=A0 AwA10State *a10;<br>
=C2=A0 =C2=A0 =C2=A0Error *err =3D NULL;<br>
<br>
+=C2=A0 =C2=A0 a10 =3D AW_A10(object_new(TYPE_AW_A10));<br>
+=C2=A0 =C2=A0 object_property_add_child(OBJECT(machine), &quot;soc&quot;, =
OBJECT(a10),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
+=C2=A0 =C2=A0 object_unref(OBJECT(a10));<br></blockquote><div><br></div><d=
iv>I see that there are a few machines which also do object_property_add_ch=
ild() to add its</div><div>SoC object to the machine, but they do not do th=
e object_unref(). Can you explain why it is needed here?</div><div>Or do th=
e other machines still have a leak due to the missing object_unref()? Examp=
les are:</div><div>=C2=A0 hw/arm/sabrelite.c</div><div>=C2=A0 hw/arm/mcimx7=
d-sabre.c</div><div>=C2=A0 hw/arm/mcimx6ul-evk.c</div><div><br></div><div>R=
egards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(&amp;a10-&gt;emac), 1, &=
quot;phy-addr&quot;, &amp;err);<br>
=C2=A0 =C2=A0 =C2=A0if (err !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_reportf_err(err, &quot;Couldn&#39;t=
 set phy address: &quot;);<br>
-- <br>
2.18.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000092f06005a021157f--

