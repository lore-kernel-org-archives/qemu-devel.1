Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F54BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F97215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 07:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrc5If4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F97215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibgNN-0001Vk-GN
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 02:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ibgML-0000fo-82
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ibgMJ-0002nc-Mg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:43:05 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ibgMJ-0002nK-HV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 02:43:03 -0500
Received: by mail-qk1-x741.google.com with SMTP id a10so8596775qko.9
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 23:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fKsU3zByUpThbgVmtsGF+aP/w1YZeOV3D4t+jftK1IQ=;
 b=mrc5If4YsJY6dP9lC00P/HtMb2YBvS71B+jhKbZhXzOk5Ek5o53qQL5A9sj/9wrYTj
 inMlJGMXZdpscVNzkdjSfSq/u8UOstC2/cZpJvZYES58U/PP1/Z0YaZzsAomRVjSQhVC
 OMo9MgtblC4PN0Sn6AQG/hZn/7EY/p60zsF3jeh6TG2epJeAVSRRj9+BOQXXA+IVMNbZ
 nxfYdSBQ028akBhuKhOvLIUs5/Euznd39oNZqUgpti9ZkhZOEoMjYfTxSWWwLj2HE92q
 BGhkpo8o1UScB76EuhPpfmcEAnfIrzfzlsI/E5CfX08he3vSeimauvokdlvvKG6XqLM/
 ONXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fKsU3zByUpThbgVmtsGF+aP/w1YZeOV3D4t+jftK1IQ=;
 b=NNog0ocj1Kdw0luw9o1KNAsjdnuIlVo83Fa3zwLLEla5X2P6knGGikmO5tq7A6xiD4
 HABaCZv5dWulkyGPxblHk4uShNhs1Ysrq2JLF9hP7nX8S5XUT7u+FXEBo0q3L7iSIK0D
 QC5UOx91Nig1QjemDZk3HL7X+8ieKuiGdrAImtr8Lr2+wnUhQWEsMj2GsbB7nbOTQ+DU
 8PXyqBpKdAOILriU91zWkN+8EY4XIr7qpM65AgWnH/q0l/ChMgxtQJ+2gBD6S7Y2VBEh
 i6dqE8gkc1Zb/dr3H4o8vpgydORyGtw7GCG4LcPWEJcTRKejHhJESGM1dasCuBwbRxLi
 RESA==
X-Gm-Message-State: APjAAAVzUgHYxLNsCDvw95uIc2fr4o4sI0FWzOtBrogbMTZRmYGrEAd2
 vjPYOayBx2d8fYurVVkhG19xVU2+r2JYFzSCigQ=
X-Google-Smtp-Source: APXvYqwBuCJL+FOiooHi3/kLsyUQDnlSNnnVAgF5ryss2gjK6X4mQui6hkmwxtbWMfur4YLdxyTD7LNxew8w94rceUE=
X-Received: by 2002:a37:7443:: with SMTP id p64mr31092635qkc.460.1575272582252; 
 Sun, 01 Dec 2019 23:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
 <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
 <CAL1e-=gNsZeX8zdYO0Cjo8eYaRo-=MReR4u3UDcppPxV-bs+WQ@mail.gmail.com>
In-Reply-To: <CAL1e-=gNsZeX8zdYO0Cjo8eYaRo-=MReR4u3UDcppPxV-bs+WQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 2 Dec 2019 09:41:51 +0200
Message-ID: <CAK4993h961Yy4tFdRYwF+LOLYGynY-d7E6pPss-YZ984j9UpsA@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b08f1c0598b3bad3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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

--000000000000b08f1c0598b3bad3
Content-Type: text/plain; charset="UTF-8"

Aleksandar.

I could not find what happens if an instruction with unsupported registers
is executed. So, I am leaving this tiny core for later.

Regards,
Michael Rolnik

On Sun, Dec 1, 2019 at 1:11 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Hi Aleksandar.
>>
>> thanks for pointing that out I was not aware of that.
>> I can fix it.
>>
>>
> Hey, Michael,
>
> Please take alook at this:
>
> https://en.m.wikipedia.org/wiki/ATtiny_microcontroller_comparison_chart
>
> It looks that all cases of AVR 16-gpr-registers cores belong to the group "avrtiny10",
> that actually you may want to add to your solution. Just a hint.
>
> Best regards,
> Aleksandar
>
>
>
> Regards,
>> Michael Rolnik
>>
>> On Sat, Nov 30, 2019 at 6:29 PM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>>
>>>
>>>
>>> On Saturday, November 30, 2019, Aleksandar Markovic <
>>> aleksandar.m.mail@gmail.com> wrote:
>>>
>>>>
>>>>
>>>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>>>> wrote:
>>>>
>>>> +
>>>>> +
>>>>> +/*
>>>>> + *  Performs the logical AND between the contents of register Rd and
>>>>> register
>>>>> + *  Rr and places the result in the destination register Rd.
>>>>> + */
>>>>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>>>>> +{
>>>>> +    TCGv Rd = cpu_r[a->rd];
>>>>> +    TCGv Rr = cpu_r[a->rr];
>>>>> +    TCGv R = tcg_temp_new_i32();
>>>>> +
>>>>> +    /* op */
>>>>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>>>>> +
>>>>> +    /* Vf */
>>>>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>>>>> +
>>>>> +    /* Zf */
>>>>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>>>>> +
>>>>> +    gen_ZNSf(R);
>>>>> +
>>>>> +    /* R */
>>>>> +    tcg_gen_mov_tl(Rd, R);
>>>>> +
>>>>> +    tcg_temp_free_i32(R);
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +
>>>>>
>>>>
>>>> According to specs:
>>>>
>>>>
>>>> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf
>>>>
>>>> ... the chips in question have cores with 16 GPRs (that correspond to
>>>> GPRs R16-R31 of more common AVR cores with 32 GPRs).
>>>>
>>>>
>>> There are more examples;
>>>
>>>
>>> http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
>>>
>>> Also ATtiny20, ATtiny40.
>>>
>>> How do you handle such cores?
>>>>
>>>> I don't see here anything preventing usage of all 32 GPRs, resulting,
>>>> of course, in an inaccurate emulation.
>>>>
>>>> Thanks,
>>>> Aleksandar
>>>>
>>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>>
>

-- 
Best Regards,
Michael Rolnik

--000000000000b08f1c0598b3bad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Aleksandar.<div><br></div><div>I could not find what happe=
ns if an instruction with unsupported registers is executed. So, I am leavi=
ng this tiny core for later.</div><div><br></div><div>Regards,</div><div>Mi=
chael Rolnik</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Sun, Dec 1, 2019 at 1:11 AM Aleksandar Markovic &lt;<a=
 href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a=
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
pedia.org/wiki/ATtiny_microcontroller_comparison_chart</a></div><div><br></=
div><div>It looks that all cases of AVR 16-gpr-registers cores belong to th=
e group &quot;<span style=3D"color:rgb(34,34,34);font-family:-apple-system,=
BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-se=
rif;font-size:16px;line-height:26.4px">avrtiny10&quot;, that actually you m=
ay want to add to your solution. Just a hint.</span></div><div><span style=
=3D"color:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&quot;=
Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-h=
eight:26.4px"><br></span></div><div><span style=3D"color:rgb(34,34,34);font=
-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,H=
elvetica,Arial,sans-serif;font-size:16px;line-height:26.4px">Best regards,<=
/span></div><div>Aleksandar</div><div><span style=3D"color:rgb(34,34,34);fo=
nt-family:-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato=
,Helvetica,Arial,sans-serif;font-size:16px;line-height:26.4px"><br></span><=
/div><div><span style=3D"color:rgb(34,34,34);font-family:-apple-system,Blin=
kMacSystemFont,&quot;Segoe UI&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;=
font-size:16px;line-height:26.4px"><br></span></div><div><span style=3D"col=
or:rgb(34,34,34);font-family:-apple-system,BlinkMacSystemFont,&quot;Segoe U=
I&quot;,Roboto,Lato,Helvetica,Arial,sans-serif;font-size:16px;line-height:2=
6.4px"><br></span></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div>Regards,</div><div>Michael Rolnik</div></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 30,=
 2019 at 6:29 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mai=
l@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Saturd=
ay, November 30, 2019, Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar=
.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Wednes=
day, November 27, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.=
com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<div><br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
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
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf =3D R =
=3D=3D 0 */<br>
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
nk">http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-m=
icrocontrollers-attiny102-attiny104_datasheet.pdf</a><br></div></div><div><=
br></div><div>... the chips in question have cores with 16 GPRs (that corre=
spond to GPRs R16-R31 of more common AVR cores with 32 GPRs).</div><div><br=
></div></blockquote><div><br></div><div>There are more examples;</div><div>=
<br></div><div><a href=3D"http://ww1.microchip.com/downloads/en/DeviceDoc/a=
tmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datash=
eet.pdf" target=3D"_blank">http://ww1.microchip.com/downloads/en/DeviceDoc/=
atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datas=
heet.pdf</a><br></div><div><br></div><div>Also ATtiny20, ATtiny40.</div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>How do y=
ou handle such cores?</div><div><br></div><div>I don&#39;t see here anythin=
g preventing usage of all 32 GPRs, resulting, of course, in an inaccurate e=
mulation.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000b08f1c0598b3bad3--

