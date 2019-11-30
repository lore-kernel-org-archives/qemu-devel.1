Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E67EC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 23:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEF520725
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 23:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5CDT/XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEF520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibBuR-0005Wo-Uq
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 18:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibBtW-0004gr-Be
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibBtU-0004p2-Tm
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:11:18 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibBtU-0004l2-KD
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 18:11:16 -0500
Received: by mail-ot1-x341.google.com with SMTP id l14so27809239oti.10
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 15:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=qksgmx4kXeHyR4rq7zOb2n8ALnn8N5LN8fkASJjEryo=;
 b=o5CDT/XOuAccnKE+VUllSFGSF3z6tFrpYNwB6UsPQQrFXU21G63KdOk8OwWNAvD6OF
 tCi01tKJHqm1B9SrhzGtIPaTTtfHPYaFh3YDkbHFaYI2TpFTzAyfqNRpSYgU561S34cS
 AUJF6YcwkgkI+ENg21uH6eq0XZRpTirQT1YlqyYCax9CJEsWaAQEEzctXUV54OLEd9cr
 NMh9m/WMgFuIAKTB61BZi8FooAV85IqqiviBHnIURqTEAA4ZZnFqnEY/mdSYNEUwzgnH
 5a4O4+h31YNdS0Y0pOChvUyCpTxzS+m6XoeaR6kIFrXEaWGvOLCuVDhtkvto/D82Jm1G
 t25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=qksgmx4kXeHyR4rq7zOb2n8ALnn8N5LN8fkASJjEryo=;
 b=HngHqAKgLJ/+aXjJixn0vMD/2iSTjw5ciQHF5YlKKQ8QImJVrz1SX0MArxcbb2CqUg
 VGujjV+yoX1/OyuYC0fr2A7NlJgzWBYxkk8tbuL++Nk04SGtBX3pSwEJKlrxlPBqMArd
 TYzbZDEvPGmoWKIGdieyRtBAs52bwmLp5mKFGt18Ul92gO7PlVofExsUvPI+h3YBVZk0
 gbJJ1FyG3bVpZS/k2bfzyzC9y71XU5JfzSz7SE0naohKdh6uynywQEaNAD8+91AJFErA
 y8H2/3P8XlqQvebAAjzTQBJM/vS0qTcevaSJKaZcjuRDTdrQxjw3jobiBnFvxd6YIc/t
 VmOg==
X-Gm-Message-State: APjAAAVSaLBwFi4DCE5o8IBKB1LsO2N/yNodAYxSS1xlwk8HLtaxKZj4
 mzAWzzrxGpB+fcd9K3Whgjpe+huiaWKWw3tuBB0=
X-Google-Smtp-Source: APXvYqwHx6nK0DTqKdn/eC+IbJW6sRSLH9T10gKkSJjbyApZPA6T6HcsFHgxaWmy0G8XJnYUB2P/oU51qXBQaMCOgf4=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr10924720oth.121.1575155474754; 
 Sat, 30 Nov 2019 15:11:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 15:11:13
 -0800 (PST)
In-Reply-To: <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
 <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 00:11:13 +0100
Message-ID: <CAL1e-=gNsZeX8zdYO0Cjo8eYaRo-=MReR4u3UDcppPxV-bs+WQ@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000089f17d0598987674"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

--00000000000089f17d0598987674
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Aleksandar.
>
> thanks for pointing that out I was not aware of that.
> I can fix it.
>
>
Hey, Michael,

Please take alook at this:

https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_chart

It looks that all cases of AVR 16-gpr-registers cores belong to the
group "avrtiny10",
that actually you may want to add to your solution. Just a hint.

Best regards,
Aleksandar



Regards,
> Michael Rolnik
>
> On Sat, Nov 30, 2019 at 6:29 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Saturday, November 30, 2019, Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>>
>>>
>>>
>>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>>> wrote:
>>>
>>> +
>>>> +
>>>> +/*
>>>> + *  Performs the logical AND between the contents of register Rd and
>>>> register
>>>> + *  Rr and places the result in the destination register Rd.
>>>> + */
>>>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>>>> +{
>>>> +    TCGv Rd = cpu_r[a->rd];
>>>> +    TCGv Rr = cpu_r[a->rr];
>>>> +    TCGv R = tcg_temp_new_i32();
>>>> +
>>>> +    /* op */
>>>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>>>> +
>>>> +    /* Vf */
>>>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>>>> +
>>>> +    /* Zf */
>>>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>>>> +
>>>> +    gen_ZNSf(R);
>>>> +
>>>> +    /* R */
>>>> +    tcg_gen_mov_tl(Rd, R);
>>>> +
>>>> +    tcg_temp_free_i32(R);
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +
>>>>
>>>
>>> According to specs:
>>>
>>> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-
>>> microcontrollers-attiny102-attiny104_datasheet.pdf
>>>
>>> ... the chips in question have cores with 16 GPRs (that correspond to
>>> GPRs R16-R31 of more common AVR cores with 32 GPRs).
>>>
>>>
>> There are more examples;
>>
>> http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-
>> microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
>>
>> Also ATtiny20, ATtiny40.
>>
>> How do you handle such cores?
>>>
>>> I don't see here anything preventing usage of all 32 GPRs, resulting, of
>>> course, in an inaccurate emulation.
>>>
>>> Thanks,
>>> Aleksandar
>>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>

--00000000000089f17d0598987674
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 30, 2019, Michael Rolnik &lt;<a href=3D"mailt=
o:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi Aleksandar.<div><br></div><div>thanks for=
 pointing that out I was not aware=C2=A0of that.</div><div>I can fix it.</d=
iv><div><br></div></div></blockquote><div><br></div><div>Hey, Michael,</div=
><div><br></div><div>Please take alook at this:</div><div><br></div><div><a=
 href=3D"https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_=
chart">https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_ch=
art</a></div><div><br></div><div>It looks that all cases of AVR 16-gpr-regi=
sters cores belong to the group &quot;<span style=3D"color:rgb(34,34,34);fo=
nt-family:-apple-system,BlinkMacSystemFont,&#39;Segoe UI&#39;,Roboto,Lato,H=
elvetica,Arial,sans-serif;font-size:16px;line-height:26.3999996185303px">av=
rtiny10&quot;, that actually you may want to add to your solution. Just a h=
int.</span></div><div><span style=3D"color:rgb(34,34,34);font-family:-apple=
-system,BlinkMacSystemFont,&#39;Segoe UI&#39;,Roboto,Lato,Helvetica,Arial,s=
ans-serif;font-size:16px;line-height:26.3999996185303px"><br></span></div><=
div><span style=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSy=
stemFont,&#39;Segoe UI&#39;,Roboto,Lato,Helvetica,Arial,sans-serif;font-siz=
e:16px;line-height:26.3999996185303px">Best regards,</span></div><div>Aleks=
andar</div><div><span style=3D"color:rgb(34,34,34);font-family:-apple-syste=
m,BlinkMacSystemFont,&#39;Segoe UI&#39;,Roboto,Lato,Helvetica,Arial,sans-se=
rif;font-size:16px;line-height:26.3999996185303px"><br></span></div><div><s=
pan style=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFo=
nt,&#39;Segoe UI&#39;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px=
;line-height:26.3999996185303px"><br></span></div><div><span style=3D"color=
:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&#39;Segoe UI&#=
39;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-height:26.39=
99996185303px"><br></span></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr"><div>Regards,</div><div>Michael Rolnik</div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 30, 2019 at 6:=
29 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com=
" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Saturday, Novembe=
r 30, 2019, Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gma=
il.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Wednesday, Novemb=
er 27, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=
=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<div><br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
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

--00000000000089f17d0598987674--

