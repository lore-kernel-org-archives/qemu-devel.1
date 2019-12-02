Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3DBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CDA2231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZwuwVzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CDA2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhbQ-0008TY-Hg
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibha9-0007Q5-2H
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibha7-0005Fy-67
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:01:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibha6-0005FZ-Q1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:01:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id i4so3485856otr.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 01:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=yXcORxTGPt1VrU/1lhDjcVCbReSDnNfKZVMf0iJfjoM=;
 b=cZwuwVzAmN5cyI8hq31cHJ50o0e0l8zoUnqu4BoxdIJFMyfc3gas53UrdKnp0pjVb4
 myoyJa7NlJ73v1HMiPCu/jhj9stYwbs0Ym0cvFQVFTcHu/DiUJHIl849qFpccGWwtAgo
 /PNT4+gbCcX7JUYZEDEHzX3FGfoUxp8mGKjzR1iE2icCaoy2pB8xXgnfE3PBcFjSfTCS
 GBe2dTLVhN6Yr9xOm2IbJc9kj/RX/F5YPj37wg1jPVYGg9KIwCduURd8/hE9nRsxjFo2
 0nK6ngOyAqvlwKEOiqWpRE5wSsHG9LTmBG7qMvxC3b9AnOkPb7isHXOTp1c2NMMcpJgG
 cCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=yXcORxTGPt1VrU/1lhDjcVCbReSDnNfKZVMf0iJfjoM=;
 b=DApokTnU3PcWxjUVpvRJmfWdeTDl90dEngAwCmQDvCusYrqeEgfmrLxS+BnFqbJExd
 gFYs0YzFpCdJevg+Dgh00nUYpLNch51wLmdMYOVEJt6xSS/xAzOME7wyHEJzEyHe0cj2
 7abfSS02T6TKa7VTiNvb/lKOkhBOWzJ2Ju79k1cmMb/QOv9bgvB56atj+tTMKAH0Ljhb
 ZpEkmtSqesbOd0Iluxu8mQlu8aB9UXMx2hyeVX1RNsr882AYLzBzxDKRqLfeDrOyuwld
 1yx4O+1CnKFfAFtEd98dJTMkAc1gv6XtJeQRU7bb57oMLUgwOx7/ZLjdT/AYBQalU1bE
 IjTw==
X-Gm-Message-State: APjAAAXg5kpU4OPXRIZyfofFAyfpBe7ShgeYThBZXEBw8lj65/+XHKnY
 kvx2Sh5O3PFmzpuKZyEAcSDfdHyqUOa9vYohDGg=
X-Google-Smtp-Source: APXvYqxKvB/A5eoCOZMNB1CHhSb75C+J/LhQSf7Zztawfop2UGonIDVXma/n5/lpaKsexpdxAQlphWFWPkZ4g3tJO9w=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr15061037oth.121.1575277281563; 
 Mon, 02 Dec 2019 01:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 2 Dec 2019 01:01:21 -0800 (PST)
In-Reply-To: <CAL1e-=gP+jBkvDtiB8_QWqP0_6weMYqe2TAwB+p_H43WPJhXKA@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
 <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
 <CAL1e-=gNsZeX8zdYO0Cjo8eYaRo-=MReR4u3UDcppPxV-bs+WQ@mail.gmail.com>
 <CAK4993h961Yy4tFdRYwF+LOLYGynY-d7E6pPss-YZ984j9UpsA@mail.gmail.com>
 <CAL1e-=gP+jBkvDtiB8_QWqP0_6weMYqe2TAwB+p_H43WPJhXKA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Dec 2019 10:01:21 +0100
Message-ID: <CAL1e-=jPCDQu2TOgj1qN1Rm8tpWRXrKg_hzVUgr5gxXvFpvggQ@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ca5f8d0598b4d232"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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

--000000000000ca5f8d0598b4d232
Content-Type: text/plain; charset="UTF-8"

On Monday, December 2, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:
>
>
> +
> +    /* update status register */
> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> +    gen_ZNSf(R);
> +    tcg_gen_mov_tl(Rd, R);
> +
>

My email client drives me crazy, all lines from the above segment should be
consecutive, without any empty lines in between. If you see empty lines,
that is because of my email client.


> The idea is to distinguish visually better the portions for updating
> status register from the central part of the operation (usually marked by
> "/* op */" comment. The code also gets more compact, which looks like a
> good thing too.
>
> Aleksandar
>
>
>> Regards,
>> Michael Rolnik
>>
>> On Sun, Dec 1, 2019 at 1:11 AM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>>
>>>
>>>
>>> On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com>
>>> wrote:
>>>
>>>> Hi Aleksandar.
>>>>
>>>> thanks for pointing that out I was not aware of that.
>>>> I can fix it.
>>>>
>>>>
>>> Hey, Michael,
>>>
>>> Please take alook at this:
>>>
>>> https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_chart
>>>
>>> It looks that all cases of AVR 16-gpr-registers cores belong to the
>>> group "avrtiny10", that actually you may want to add to your solution.
>>> Just a hint.
>>>
>>> Best regards,
>>> Aleksandar
>>>
>>>
>>>
>>> Regards,
>>>> Michael Rolnik
>>>>
>>>> On Sat, Nov 30, 2019 at 6:29 PM Aleksandar Markovic <
>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Saturday, November 30, 2019, Aleksandar Markovic <
>>>>> aleksandar.m.mail@gmail.com> wrote:
>>>>>
>>>>>>
>>>>>>
>>>>>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>>>>>> wrote:
>>>>>>
>>>>>> +
>>>>>>> +
>>>>>>> +/*
>>>>>>> + *  Performs the logical AND between the contents of register Rd
>>>>>>> and register
>>>>>>> + *  Rr and places the result in the destination register Rd.
>>>>>>> + */
>>>>>>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>>>>>>> +{
>>>>>>> +    TCGv Rd = cpu_r[a->rd];
>>>>>>> +    TCGv Rr = cpu_r[a->rr];
>>>>>>> +    TCGv R = tcg_temp_new_i32();
>>>>>>> +
>>>>>>> +    /* op */
>>>>>>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>>>>>>> +
>>>>>>> +    /* Vf */
>>>>>>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>>>>>>> +
>>>>>>> +    /* Zf */
>>>>>>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0
>>>>>>> */
>>>>>>> +
>>>>>>> +    gen_ZNSf(R);
>>>>>>> +
>>>>>>> +    /* R */
>>>>>>> +    tcg_gen_mov_tl(Rd, R);
>>>>>>> +
>>>>>>> +    tcg_temp_free_i32(R);
>>>>>>> +
>>>>>>> +    return true;
>>>>>>> +}
>>>>>>> +
>>>>>>> +
>>>>>>>
>>>>>>
>>>>>> According to specs:
>>>>>>
>>>>>> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-
>>>>>> 8-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf
>>>>>>
>>>>>> ... the chips in question have cores with 16 GPRs (that correspond to
>>>>>> GPRs R16-R31 of more common AVR cores with 32 GPRs).
>>>>>>
>>>>>>
>>>>> There are more examples;
>>>>>
>>>>> http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-
>>>>> avr-8-bit-microcontroller-attiny4-attiny5-attiny9-
>>>>> attiny10_datasheet.pdf
>>>>>
>>>>> Also ATtiny20, ATtiny40.
>>>>>
>>>>> How do you handle such cores?
>>>>>>
>>>>>> I don't see here anything preventing usage of all 32 GPRs, resulting,
>>>>>> of course, in an inaccurate emulation.
>>>>>>
>>>>>> Thanks,
>>>>>> Aleksandar
>>>>>>
>>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Michael Rolnik
>>>>
>>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>>
>

--000000000000ca5f8d0598b4d232
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, December 2, 2019, Aleksandar Markovic &lt;<a href=3D"mai=
lto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><br></div><div><span style=3D"color:rgb=
(0,123,53);font-size:14px;line-height:22.1200008392334px">+</span><br style=
=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><spa=
n style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334p=
x">+=C2=A0 =C2=A0 /* update status register */</span><br style=3D"color:rgb=
(0,123,53);font-size:14px;line-height:22.1200008392334px"><span style=3D"co=
lor:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">+=C2=A0 =
=C2=A0 tcg_gen_movi_tl(cpu_Vf, 0); /* Vf =3D 0 */</span><br style=3D"color:=
rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><span style=3D=
"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">+=C2=A0=
 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_</span><span style=3D"color:rgb(0,123,=
53);font-size:14px;line-height:22.1200008392334px">E<wbr>Q, cpu_Zf, R, 0); =
/* Zf =3D R =3D=3D 0 */</span><br style=3D"color:rgb(0,123,53);font-size:14=
px;line-height:22.1200008392334px"><span style=3D"color:rgb(0,123,53);font-=
size:14px;line-height:22.1200008392334px">+=C2=A0 =C2=A0 gen_ZNSf(R);</span=
><br style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.12000083923=
34px"><span style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200=
008392334px">+=C2=A0 =C2=A0 tcg_gen_mov_tl(Rd, R);</span><br style=3D"color=
:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px"><span style=
=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">+</s=
pan><br style=3D"color:rgb(0,123,53);font-size:14px;line-height:22.12000083=
92334px"></div><div></div></blockquote><div><br></div><div>My email client =
drives me crazy, all lines from the above segment should be consecutive, wi=
thout any empty lines in between. If you see empty lines, that is because o=
f my email client.=C2=A0</div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><div></div><div><span style=3D"color:rgb(0,123,53);font-size:14px;line-hei=
ght:22.1200008392334px"><br></span></div><div><div>The idea is to distingui=
sh visually better the portions for updating status register from the centr=
al part of the operation (usually marked by &quot;/* op */&quot; comment. T=
he code also gets more compact, which looks like a good thing too.</div></d=
iv><div><br></div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div>Regards,</div><div>Michael Rolnik</div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Sun, Dec 1, 2019 at 1:11 AM Aleksandar Markovic &lt;<a href=3D"mailto:al=
eksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br=
><br>On Saturday, November 30, 2019, Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Aleksand=
ar.<div><br></div><div>thanks for pointing that out I was not aware=C2=A0of=
 that.</div><div>I can fix it.</div><div><br></div></div></blockquote><div>=
<br></div><div>Hey, Michael,</div><div><br></div><div>Please take alook at =
this:</div><div><br></div><div><a href=3D"https://en.m.wikipedia.org/wiki/A=
Ttiny_microcontroller_comparison_chart" target=3D"_blank">https://en.m.wiki=
pedia.org/wik<wbr>i/ATtiny_microcontroller_compa<wbr>rison_chart</a></div><=
div><br></div><div>It looks that all cases of AVR 16-gpr-registers cores be=
long to the group &quot;<span style=3D"color:rgb(34,34,34);font-family:-app=
le-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Ari=
al,sans-serif;font-size:16px;line-height:26.4px">avrtiny10&quot;, that actu=
ally you may want to add to your solution. Just a hint.</span></div><div><s=
pan style=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFo=
nt,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16=
px;line-height:26.4px"><br></span></div><div><span style=3D"color:rgb(34,34=
,34);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Robo=
to,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-height:26.4px">Best =
regards,</span></div><div>Aleksandar</div><div><span style=3D"color:rgb(34,=
34,34);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Ro=
boto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-height:26.4px"><br=
></span></div><div><span style=3D"color:rgb(34,34,34);font-family:-apple-sy=
stem,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sa=
ns-serif;font-size:16px;line-height:26.4px"><br></span></div><div><span sty=
le=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&quo=
t;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line=
-height:26.4px"><br></span></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div>Regards,</div><div>Michael Rolnik</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat=
, Nov 30, 2019 at 6:29 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksan=
dar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>=
On Saturday, November 30, 2019, Aleksandar Markovic &lt;<a href=3D"mailto:a=
leksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</=
a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>=
On Wednesday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mailto:mroln=
ik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<div><br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_E<wbr>Q, cpu_Zf, R, 0); /* Zf =
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
nk">http://ww1.microchip.com/downl<wbr>oads/en/devicedoc/atmel-42505-<wbr>8=
-bit-avr-microcontrollers-<wbr>attiny102-attiny104_datasheet.<wbr>pdf</a><b=
r></div></div><div><br></div><div>... the chips in question have cores with=
 16 GPRs (that correspond to GPRs R16-R31 of more common AVR cores with 32 =
GPRs).</div><div><br></div></blockquote><div><br></div><div>There are more =
examples;</div><div><br></div><div><a href=3D"http://ww1.microchip.com/down=
loads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-att=
iny9-attiny10_datasheet.pdf" target=3D"_blank">http://ww1.microchip.com/dow=
nl<wbr>oads/en/DeviceDoc/atmel-8127-<wbr>avr-8-bit-microcontroller-<wbr>att=
iny4-attiny5-attiny9-<wbr>attiny10_datasheet.pdf</a><br></div><div><br></di=
v><div>Also ATtiny20, ATtiny40.</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div>How do you handle such cores?</div><div><br=
></div><div>I don&#39;t see here anything preventing usage of all 32 GPRs, =
resulting, of course, in an inaccurate emulation.</div><div><br></div><div>=
Thanks,</div><div>Aleksandar</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote>

--000000000000ca5f8d0598b4d232--

