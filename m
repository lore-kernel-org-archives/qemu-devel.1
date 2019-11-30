Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B225C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 18:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290782082E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 18:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dubnSMsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290782082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib7aD-00081W-5X
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 13:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib7Va-0003DC-8M
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 13:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib6Jz-0000KT-HQ
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 12:14:16 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ib6Jz-0000KE-AI
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 12:14:15 -0500
Received: by mail-oi1-x242.google.com with SMTP id a124so5009350oii.13
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=tEJX813xRO4hBm2i8UTGTU77czTWGr1JsvPGVdiF6EA=;
 b=dubnSMsj3XjMg+vCLCUBFePF73cCkv8w6HDV5rOSaPbC5Se+ymDustxZeMa+fbBJCg
 7Rs3qFzLFpFzYlLntc96fEKIC/0BTvhRWLUq7uhaAqH4KjM79AiLNOQz0wiOGOUkqy2Q
 9WoU0HgjEIVf2Ua8eRt8fXRjtvFDQWGD/XwJOnNMDDHlzTYo09uK2H+AuW0qwsqQ/f7a
 iLfE80gOE9xzNd6LD8/FvOJHfhNVDU5RUm2V8Ck7pNzixiQx4R+tpenVTgjkGcVSmCZa
 LKP2OPPXXbiaRP38D9beJ+xtYWOJ1J7bSgOVFDv7l1ksVK6Xf7t6wIFLl9rixZbv9bmT
 SeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=tEJX813xRO4hBm2i8UTGTU77czTWGr1JsvPGVdiF6EA=;
 b=eAD1GzGPiAz2BTh/+7a+pkol4AdjjYr8bChWX3xt67ruBBEL6gh6K5gUV55R59cP8T
 9Q45Wp6y0O8HJWqVJzsZsmqEznX8KoyLcXIiN2ZMiTykvoFf+zSeVozmzQeOc+kxEkZS
 k3V1KAgSqW8Jp7OUuVl0/5T8YFkOt50+dQwMOVUHRQfvMPsiLIVTqqojd7nrQajXOdut
 8wXW8aaSy9AJ7FP+xNbGQuEbY3yOtTxM8qVn4G07KZwHXc6Cjcnid4Jr7RYKJ9M8JUh3
 6Va0WoyZhOwjaVoD8kM5WxQ7GsrXsX17rdd4RDi8FJsvkpvTKj2jyVzR21n68vY5R8f0
 8NfQ==
X-Gm-Message-State: APjAAAXJTRuZD44/+utjlqfh3NkHrrGOVVkXK43ZDRk45erG5MUSY2QQ
 drBM4SBoa3J+52uIDfKVwLUfqi0WyO3x6lGvZFg=
X-Google-Smtp-Source: APXvYqw2vhhVu2oFHeHugYj7R9cM7Zp+9AQUaiZWRCrut5UavE1g4loRIHn8pgl7uDsQgvBJDdikJ/JmVi6uxm7TDSU=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr3052638oic.62.1575134054397; 
 Sat, 30 Nov 2019 09:14:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 09:14:13
 -0800 (PST)
In-Reply-To: <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
 <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 Nov 2019 18:14:13 +0100
Message-ID: <CAL1e-=ix-h9GHKdh9auec+TMrzY4wQMsbtN=Dh7J9yP=p02t3A@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000c939cd05989379cf"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--000000000000c939cd05989379cf
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 30, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Aleksandar.
>
> thanks for pointing that out I was not aware of that.
> I can fix it.
>

That'd be great!

Thanks,
Aleksandar



>
> Regards,
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

--000000000000c939cd05989379cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 30, 2019, Michael Rolnik &lt;<a href=3D"mailt=
o:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi Aleksandar.<div><br></div><div>thanks for=
 pointing that out I was not aware=C2=A0of that.</div><div>I can fix it.</d=
iv></div></blockquote><div><br></div><div>That&#39;d be great!</div><div><b=
r></div><div>Thanks,</div><div>Aleksandar</div><div><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><br></div><div>Reg=
ards,</div><div>Michael Rolnik</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 30, 2019 at 6:29 PM Aleksan=
dar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_=
blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><br><br>On Saturday, November 30, 2019, A=
leksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" targe=
t=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><br><br>On Wednesday, November 27, 2019, =
Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">m=
rolnik@gmail.com</a>&gt; wrote:<div><br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
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

--000000000000c939cd05989379cf--

