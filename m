Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16CDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 00:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F1E2078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 00:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CinAQnau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F1E2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjtu3-0003Lt-JQ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 20:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jjttM-0002Xa-Fz
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 20:19:24 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935]:33736)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jjttJ-0002Kr-Jb
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 20:19:24 -0400
Received: by mail-ua1-x935.google.com with SMTP id b10so3819652uaf.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fePs81fA+XH2lGKybDVVekfZVoP1uy6wDnoFXdUsDDw=;
 b=CinAQnauJYNORGoTD1BsTNa3j/4gsBkChCiWeuB/0VgO29M+ie3EvSIATS6kDMMxTO
 aeGr7kDX3zt7XIGdUdQ9fyhfrDxrCld2tZk5W82ouMwEucjSfintecmYWvhzoIUs2/GR
 keDhEIeorMFODMGlilIT/ws04Tc9/b+yIU+zgp6zJ1tdyCkKiFKyeGHipKOQulY2OoyT
 hHjnLjxNE4IrXNLEn+Nl74gqIDwy8cr8Gzwg4Uthq4vKsVRTfKeZT5HD45g3419gqoUw
 Q3QZbuQmkliIadgaAwMDy0K2dHkgeSo4GpkS8+USudCCxOgvcM8FpAGGNrTS0T5oAzlW
 jE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fePs81fA+XH2lGKybDVVekfZVoP1uy6wDnoFXdUsDDw=;
 b=H+9Ho7npBUAB43AkGIVSMv4K0LH5E6YExnOgn1iIIKUxkucVm0YDaevUVL6hVSUYfO
 YMn8u0yadXW5ML9jLPv9Tj82P2lxLLvJ8jF7+CHkhpZvUbM9FKO+zNz5nRPPyPnOkt6Z
 zIFxvXqhURIPAySrwHzMFW9rZuVIvFLa8JxnFzQzTKEboBxwK6A0JqR9/J4o1C3YbNck
 +Yf4GXyPBVDcAhZ3pwc4nRiwtwr93bPyFi+MBIQFo74SILcB2mHeneblMR8x6FC9oF6i
 aA2x/3vUfUJvt1aqTa9OzvIdQ7WqOXW7wOS35hPYn6Ne4iRBfMTR7HrfLcazKf7b9199
 psgQ==
X-Gm-Message-State: AOAM530nKMaI0CHQXuHKFirc+5bB5RcTiFtJQmDlWk9HUM2Wg+01/Kxa
 cGGLSoj7Mlnt59jdjHSES/DUT19AYnnmKhOL9kPJvQ==
X-Google-Smtp-Source: ABdhPJzsRIcA44a75RBASCfUoLej7OTrb3qdR4URlJo6kzxtVbr3IzWe/dm+mnOWSw4+L+8c12W4V8SteaCeiH1fn+A=
X-Received: by 2002:ab0:6ec6:: with SMTP id c6mr14608973uav.7.1592007554624;
 Fri, 12 Jun 2020 17:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200611223016.259837-1-hskinnemoen@google.com>
 <20200611223016.259837-12-hskinnemoen@google.com>
In-Reply-To: <20200611223016.259837-12-hskinnemoen@google.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 12 Jun 2020 17:19:03 -0700
Message-ID: <CAFQmdRbMb5HBvhV02rd8beC4KtxyMjLb0SXrmgRSSDY3eG_N2A@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] hw/arm: Wire up BMC boot flash for npcm750-evb
 and quanta-gsj
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="000000000000c6637705a7ec2424"
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x935.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c6637705a7ec2424
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 11, 2020 at 3:30 PM Havard Skinnemoen <hskinnemoen@google.com>
wrote:

> @@ -57,18 +72,30 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState
> *machine)
>  static void npcm750_evb_init(MachineState *machine)
>  {
>      NPCM7xxState *soc;
> +    DriveInfo *dinfo;
>
>      soc = npcm7xx_create_soc(machine);
>
> +    dinfo = drive_get(IF_MTD, 0, 0);
> +    if (dinfo) {
> +        npcm7xx_connect_flash(&soc->fiu[0], 0, "w25q256", dinfo);
>

Btw, this does not actually work. I initially tested it with the same flash
chip as gsj, which seems to work, but after switching to the Winbond model
(as per the npcm750 evb schematics) it looks like it reads incorrect data
in DIO mode.

While trying to figure out what's going wrong, I stumbled across this patch:

https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg01586.html

which I don't understand. It looks like the winbond model wants one dummy
cycle after the address, since dummy cycles are modeled as byte transfers.
This doesn't seem to match the data sheet, which specifies 4 dummy cycles
in DIO mode (which is actually a special command byte transferred across
two data lines).

If the "continuous read mode command" is actually modeled as a single byte,
then it makes sense because that works out to 4 dummy cycles in DIO mode.
However, I don't understand how the flash controller model is supposed to
detect this situation, and I don't see any flash controller models that
support sending anything but dummy _bits_ between the address and data
phases.

Could you please clarify how this is supposed to work? Are there any
existing machines that use a w25 chip in DIO mode?

Havard

--000000000000c6637705a7ec2424
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 11, 2020 at 3:30 PM Havard Sk=
innemoen &lt;<a href=3D"mailto:hskinnemoen@google.com">hskinnemoen@google.c=
om</a>&gt; wrote:</div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
@@ -57,18 +72,30 @@ static NPCM7xxState *npcm7xx_create_soc(MachineState *m=
achine)<br>
=C2=A0static void npcm750_evb_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0NPCM7xxState *soc;<br>
+=C2=A0 =C2=A0 DriveInfo *dinfo;<br>
<br>
=C2=A0 =C2=A0 =C2=A0soc =3D npcm7xx_create_soc(machine);<br>
<br>
+=C2=A0 =C2=A0 dinfo =3D drive_get(IF_MTD, 0, 0);<br>
+=C2=A0 =C2=A0 if (dinfo) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm7xx_connect_flash(&amp;soc-&gt;fiu[0], 0, =
&quot;w25q256&quot;, dinfo);<br></blockquote><div><br></div><div>Btw, this =
does not actually work. I initially tested it with the same flash chip as g=
sj, which seems to work, but after switching to the=C2=A0Winbond model (as =
per the npcm750 evb schematics) it looks like it reads incorrect data in DI=
O mode.</div><div><br></div><div>While trying to figure out what&#39;s goin=
g wrong, I stumbled across this patch:</div><div><br></div><div><a href=3D"=
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg01586.html">https:=
//lists.gnu.org/archive/html/qemu-devel/2016-07/msg01586.html</a></div><div=
><br></div><div>which I don&#39;t understand. It looks like the winbond mod=
el wants one dummy cycle after the address, since dummy cycles are modeled =
as byte transfers. This doesn&#39;t seem to match the data sheet, which spe=
cifies 4 dummy cycles in DIO mode (which is actually a special command byte=
 transferred across two data lines).</div><div><br></div><div>If the &quot;=
continuous read mode command&quot; is actually modeled as a single byte, th=
en it makes sense because that works out to 4 dummy cycles in DIO mode. How=
ever, I don&#39;t understand how the flash controller model is supposed to =
detect this situation, and I don&#39;t see any flash controller models that=
 support sending anything but dummy _bits_ between the address and data pha=
ses.</div><div><br></div><div>Could you please clarify how this is supposed=
 to work? Are there any existing machines that use a w25 chip in DIO mode?<=
/div><div><br></div><div>Havard</div></div></div>

--000000000000c6637705a7ec2424--

