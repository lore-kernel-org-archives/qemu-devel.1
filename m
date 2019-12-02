Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A979C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D3E214AF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8mZcSEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D3E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhVB-00037E-V6
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibhUT-0002eV-GL
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibhUR-0002vX-Pp
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:55:33 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibhUP-0002uV-AA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:55:31 -0500
Received: by mail-oi1-x244.google.com with SMTP id l136so16093181oig.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=24gZ/6gg8QS7cCnA9sSTA4xreKt6kedURzox1Y/jxT0=;
 b=D8mZcSEWid96bvg/A7QHapGswYx+tO0bcg+dqB/oCw9YWE+eZQl25xaXSXLXvu1ln2
 Cv3+OxrWjDGVNYzboXXO0v4dDuARduoErJvaoVmV7Iee7ehtFbsPfhKbw7gRNLRmNI/G
 yH2h4n6VLGaiOXkvuopvgKBOJwyJ5CdBQhNS+egz2jEYZxcHyB71NQwDcekaL/OhbJGx
 6c7u5rtwsemNo5yc7DGPXpSMS3ZO8n2tk4fi9OCiJwd3eswJreVTfzzVIjnq8W09+3Np
 a+tsnONBAmKe+dbn/YdFmVZSYYlHvLTJtHK7dTMXTXabsuo4S0psFAeJjrURB6UmGrw3
 42Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=24gZ/6gg8QS7cCnA9sSTA4xreKt6kedURzox1Y/jxT0=;
 b=MNef7jV+BQwE3CCl8mQOfScQYrnETKYr6OdqlvEQ7EOYhr6tTtRsy/XwozO3L99uEQ
 IKN6v6uEo0yCkdSac/IaFYni5BLdc6BFulNIo/0iY6LEiD6THN0geGaGv7tMuKboag3E
 k0utT1N3JPG7nBbd1kpZmaZTbHWYgoQY7OpJYTTiA1dJq7YvfQ7wiSj0bOc5L8DYFIcQ
 uV+D3dCg+fA36RbltwbhluVIkNLiZ7zH09XeQV9Fdbi0y0la/bXnlrodjJJGG47WNCJ+
 8Ey/pRXUaDeTHxAKp0a3mvyr+Qq1+VGGxUIfZbR+veB522tmylPdpzJmIgrW2qcq1oL2
 2agw==
X-Gm-Message-State: APjAAAUj9SGR0/ixiRukJCh+3Jc7A5oXCpISEHZh1ZvXAH3X4ksARPqY
 BmITZ4XXR86+gFHHWvxYCrz5cNHYuizhzVZ3QL4=
X-Google-Smtp-Source: APXvYqzyhMhok2jNfKmCE+Uio1JApuqxgKy+6JQVS9vCqKomSJFLN5atcrjCivqLhQtC/zfUeovCN0LT91a4xeGSqsk=
X-Received: by 2002:aca:1817:: with SMTP id h23mr15582695oih.53.1575276927913; 
 Mon, 02 Dec 2019 00:55:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 2 Dec 2019 00:55:27 -0800 (PST)
In-Reply-To: <CAK4993h961Yy4tFdRYwF+LOLYGynY-d7E6pPss-YZ984j9UpsA@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
 <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
 <CAL1e-=gNsZeX8zdYO0Cjo8eYaRo-=MReR4u3UDcppPxV-bs+WQ@mail.gmail.com>
 <CAK4993h961Yy4tFdRYwF+LOLYGynY-d7E6pPss-YZ984j9UpsA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Dec 2019 09:55:27 +0100
Message-ID: <CAL1e-=gP+jBkvDtiB8_QWqP0_6weMYqe2TAwB+p_H43WPJhXKA@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b615570598b4bd34"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b615570598b4bd34
Content-Type: text/plain; charset="UTF-8"

On Monday, December 2, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Aleksandar.
>
> I could not find what happens if an instruction with unsupported registers
> is executed. So, I am leaving this tiny core for later.
>
>
No problem with me. You already have instruction support for a rich variety
of cores. These can certainly added it in future.

May I suggest, then, a following cosmetic change: In order for a reader to
get a brtter "first glance" feeling for emulations of ALL instructions that
involve updating status register, I suggest that the code blocks like this
one:

+
+    /* Vf */
+    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
+
+    /* Zf */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+
+    gen_ZNSf(R);
+
+    /* R */
+    tcg_gen_mov_tl(Rd, R);
+

be replaced with this one:

+
+    /* update status register */
+    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
+    gen_ZNSf(R);
+    tcg_gen_mov_tl(Rd, R);
+

The idea is to distinguish visually better the portions for updating status
register from the central part of the operation (usually marked by "/* op
*/" comment. The code also gets more compact, which looks like a good thing
too.

Aleksandar


> Regards,
> Michael Rolnik
>
> On Sun, Dec 1, 2019 at 1:11 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>
>>> Hi Aleksandar.
>>>
>>> thanks for pointing that out I was not aware of that.
>>> I can fix it.
>>>
>>>
>> Hey, Michael,
>>
>> Please take alook at this:
>>
>> https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_chart
>>
>> It looks that all cases of AVR 16-gpr-registers cores belong to the group
>> "avrtiny10", that actually you may want to add to your solution. Just a
>> hint.
>>
>> Best regards,
>> Aleksandar
>>
>>
>>
>> Regards,
>>> Michael Rolnik
>>>
>>> On Sat, Nov 30, 2019 at 6:29 PM Aleksandar Markovic <
>>> aleksandar.m.mail@gmail.com> wrote:
>>>
>>>>
>>>>
>>>> On Saturday, November 30, 2019, Aleksandar Markovic <
>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>>>>> wrote:
>>>>>
>>>>> +
>>>>>> +
>>>>>> +/*
>>>>>> + *  Performs the logical AND between the contents of register Rd and
>>>>>> register
>>>>>> + *  Rr and places the result in the destination register Rd.
>>>>>> + */
>>>>>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>>>>>> +{
>>>>>> +    TCGv Rd = cpu_r[a->rd];
>>>>>> +    TCGv Rr = cpu_r[a->rr];
>>>>>> +    TCGv R = tcg_temp_new_i32();
>>>>>> +
>>>>>> +    /* op */
>>>>>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>>>>>> +
>>>>>> +    /* Vf */
>>>>>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>>>>>> +
>>>>>> +    /* Zf */
>>>>>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0
>>>>>> */
>>>>>> +
>>>>>> +    gen_ZNSf(R);
>>>>>> +
>>>>>> +    /* R */
>>>>>> +    tcg_gen_mov_tl(Rd, R);
>>>>>> +
>>>>>> +    tcg_temp_free_i32(R);
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>> +
>>>>>>
>>>>>
>>>>> According to specs:
>>>>>
>>>>> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-
>>>>> microcontrollers-attiny102-attiny104_datasheet.pdf
>>>>>
>>>>> ... the chips in question have cores with 16 GPRs (that correspond to
>>>>> GPRs R16-R31 of more common AVR cores with 32 GPRs).
>>>>>
>>>>>
>>>> There are more examples;
>>>>
>>>> http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-
>>>> microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
>>>>
>>>> Also ATtiny20, ATtiny40.
>>>>
>>>> How do you handle such cores?
>>>>>
>>>>> I don't see here anything preventing usage of all 32 GPRs, resulting,
>>>>> of course, in an inaccurate emulation.
>>>>>
>>>>> Thanks,
>>>>> Aleksandar
>>>>>
>>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik
>>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>

--000000000000b615570598b4bd34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 2, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><div dir=3D"ltr">Aleksandar.<div><br></div><div>I could not find =
what happens if an instruction with unsupported registers is executed. So, =
I am leaving this tiny core for later.</div><div><br></div></div></blockquo=
te><div><br></div><div>No problem with me. You already have instruction sup=
port for a rich variety of cores. These can certainly added it in future.</=
div><div><br></div><div>May I suggest, then, a following cosmetic change: I=
n order for a reader to get a brtter &quot;first glance&quot; feeling for e=
mulations of ALL instructions that involve updating status register, I sugg=
est that the code blocks like this one:</div><div><br></div><div><span styl=
e=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">+</=
span><br style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008=
392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.=
1200008392334px">+=C2=A0 =C2=A0 /* Vf */</span><br style=3D"color:rgb(0,123=
,53);font-size:14px;line-height:22.1200008392334px"><span style=3D"color:rg=
b(0,123,53);font-size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 t=
cg_gen_movi_tl(cpu_Vf, 0); /* Vf =3D 0 */</span><br style=3D"color:rgb(0,12=
3,53);font-size:14px;line-height:22.1200008392334px"><span style=3D"color:r=
gb(0,123,53);font-size:14px;line-height:22.1200008392334px">+</span><br sty=
le=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><s=
pan style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.120000839233=
4px">+=C2=A0 =C2=A0 /* Zf */</span><br style=3D"color:rgb(0,123,53);font-si=
ze:14px;line-height:22.1200008392334px"><span style=3D"color:rgb(0,123,53);=
font-size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 tcg_gen_setco=
ndi_tl(TCG_COND_</span><wbr style=3D"color:rgb(0,123,53);font-size:14px;lin=
e-height:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-size:1=
4px;line-height:22.1200008392334px">EQ, cpu_Zf, R, 0); /* Zf =3D R =3D=3D 0=
 */</span><br style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.12=
00008392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;line-heigh=
t:22.1200008392334px">+</span><br style=3D"color:rgb(0,123,53);font-size:14=
px;line-height:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-=
size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 gen_ZNSf(R);</span=
><br style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.12000083923=
34px"><span style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200=
008392334px">+</span><br style=3D"color:rgb(0,123,53);font-size:14px;line-h=
eight:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-size:14px=
;line-height:22.1200008392334px">+=C2=A0 =C2=A0 /* R */</span><br style=3D"=
color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><span st=
yle=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">+=
=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);</span><br style=3D"color:rgb(0,123,53)=
;font-size:14px;line-height:22.1200008392334px"><span style=3D"color:rgb(0,=
123,53);font-size:14px;line-height:22.1200008392334px">+</span><br style=3D=
"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"></div><=
div><span style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.120000=
8392334px"><br></span></div><div>be replaced with this one:<br></div><div><=
br></div><div><span style=3D"color:rgb(0,123,53);font-size:14px;line-height=
:22.1200008392334px">+</span><br style=3D"color:rgb(0,123,53);font-size:14p=
x;line-height:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-s=
ize:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 /* update status re=
gister */</span><br style=3D"color:rgb(0,123,53);font-size:14px;line-height=
:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;line=
-height:22.1200008392334px">+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0); /* V=
f =3D 0 */</span><br style=3D"color:rgb(0,123,53);font-size:14px;line-heigh=
t:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;lin=
e-height:22.1200008392334px">+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_</=
span><wbr style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.120000=
8392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;line-height:22=
.1200008392334px">EQ, cpu_Zf, R, 0); /* Zf =3D R =3D=3D 0 */</span><br styl=
e=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><sp=
an style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334=
px">+=C2=A0 =C2=A0 gen_ZNSf(R);</span><br style=3D"color:rgb(0,123,53);font=
-size:14px;line-height:22.1200008392334px"><span style=3D"color:rgb(0,123,5=
3);font-size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 tcg_gen_mo=
v_tl(Rd, R);</span><br style=3D"color:rgb(0,123,53);font-size:14px;line-hei=
ght:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-size:14px;l=
ine-height:22.1200008392334px">+</span><br style=3D"color:rgb(0,123,53);fon=
t-size:14px;line-height:22.1200008392334px"></div><div><span style=3D"color=
:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><br></span></=
div><div><div>The idea is to distinguish visually better the portions for u=
pdating status register from the central part of the operation (usually mar=
ked by &quot;/* op */&quot; comment. The code also gets more compact, which=
 looks like a good thing too.</div></div><div><br></div><div>Aleksandar</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Reg=
ards,</div><div>Michael Rolnik</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 1, 2019 at 1:11 AM Aleksand=
ar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_b=
lank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br><br>On Saturday, November 30, 2019, Mi=
chael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mro=
lnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr">Hi Aleksandar.<div><br></div><div>thanks for point=
ing that out I was not aware=C2=A0of that.</div><div>I can fix it.</div><di=
v><br></div></div></blockquote><div><br></div><div>Hey, Michael,</div><div>=
<br></div><div>Please take alook at this:</div><div><br></div><div><a href=
=3D"https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_chart=
" target=3D"_blank">https://en.m.wikipedia.org/<wbr>wiki/ATtiny_microcontro=
ller_<wbr>comparison_chart</a></div><div><br></div><div>It looks that all c=
ases of AVR 16-gpr-registers cores belong to the group &quot;<span style=3D=
"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&quot;Seg=
oe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-heig=
ht:26.4px">avrtiny10&quot;, that actually you may want to add to your solut=
ion. Just a hint.</span></div><div><span style=3D"color:rgb(34,34,34);font-=
family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,He=
lvetica,Arial,sans-serif;font-size:16px;line-height:26.4px"><br></span></di=
v><div><span style=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMa=
cSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;fon=
t-size:16px;line-height:26.4px">Best regards,</span></div><div>Aleksandar</=
div><div><span style=3D"color:rgb(34,34,34);font-family:-apple-system,Blink=
MacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;f=
ont-size:16px;line-height:26.4px"><br></span></div><div><span style=3D"colo=
r:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI=
&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-height:26=
.4px"><br></span></div><div><span style=3D"color:rgb(34,34,34);font-family:=
-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica=
,Arial,sans-serif;font-size:16px;line-height:26.4px"><br></span></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Regards,=
</div><div>Michael Rolnik</div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sat, Nov 30, 2019 at 6:29 PM Aleksandar M=
arkovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank=
">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br><br>On Saturday, November 30, 2019, Aleksa=
ndar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"=
_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br><br>On Wednesday, November 27, 2019, Micha=
el Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolni=
k@gmail.com</a>&gt; wrote:<div><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+<br>
+/*<br>
+ *=C2=A0 Performs the logical AND between the contents of register Rd and =
register<br>
+ *=C2=A0 Rr and places the result in the destination register Rd.<br>
+ */<br>
+static bool trans_AND(DisasContext *ctx, arg_AND *a)<br>
+{<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 /* op */<br>
+=C2=A0 =C2=A0 tcg_gen_and_tl(R, Rd, Rr); /* Rd =3D Rd and Rr */<br>
+<br>
+=C2=A0 =C2=A0 /* Vf */<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0); /* Vf =3D 0 */<br>
+<br>
+=C2=A0 =C2=A0 /* Zf */<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_<wbr>EQ, cpu_Zf, R, 0); /* Zf =
=3D R =3D=3D 0 */<br>
+<br>
+=C2=A0 =C2=A0 gen_ZNSf(R);<br>
+<br>
+=C2=A0 =C2=A0 /* R */<br>
+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+<br>
</blockquote><div><br></div><div>According to specs:</div><div><br></div><d=
iv><a href=3D"http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8=
-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf" target=3D"_bla=
nk">http://ww1.microchip.com/<wbr>downloads/en/devicedoc/atmel-<wbr>42505-8=
-bit-avr-<wbr>microcontrollers-attiny102-<wbr>attiny104_datasheet.pdf</a><b=
r></div></div><div><br></div><div>... the chips in question have cores with=
 16 GPRs (that correspond to GPRs R16-R31 of more common AVR cores with 32 =
GPRs).</div><div><br></div></blockquote><div><br></div><div>There are more =
examples;</div><div><br></div><div><a href=3D"http://ww1.microchip.com/down=
loads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-att=
iny9-attiny10_datasheet.pdf" target=3D"_blank">http://ww1.microchip.com/<wb=
r>downloads/en/DeviceDoc/atmel-<wbr>8127-avr-8-bit-<wbr>microcontroller-att=
iny4-<wbr>attiny5-attiny9-attiny10_<wbr>datasheet.pdf</a><br></div><div><br=
></div><div>Also ATtiny20, ATtiny40.</div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div>How do you handle such cores?</div><d=
iv><br></div><div>I don&#39;t see here anything preventing usage of all 32 =
GPRs, resulting, of course, in an inaccurate emulation.</div><div><br></div=
><div>Thanks,</div><div>Aleksandar</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--000000000000b615570598b4bd34--

