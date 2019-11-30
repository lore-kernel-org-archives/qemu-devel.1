Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF7C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 18:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4142084E
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 18:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrMFNY2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4142084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib7gX-0004su-6P
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 13:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ib7Vp-0002ho-K8
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 13:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ib6CI-0004Nd-Ce
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 12:06:19 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:41276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ib6CI-0004NN-82
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 12:06:18 -0500
Received: by mail-qv1-xf42.google.com with SMTP id b18so713332qvo.8
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 09:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/tecfdKtW0THS4cueiTfgYZS0wNxxt5XOZ9fATRo0YA=;
 b=UrMFNY2dku4pNkx3GVYrxOy+BRl+1TI2eh8wCDpE4OrdcQ/AKG9Osqt5q/OWWiWcXr
 BJ36eR2/PvaNbUJuBYe7dVb2hzjvZcKyV84KqwnqBxKr5Pk1MMV0e3XlyF4wUm2NJTr6
 9BH0S2D9DV4viYCI3slluuWbFLhvhLO9OQEP8U42EUy5rTVcZpQTHYB/RG0LS+X4plCk
 NEqusLzBt2DWZoSrZziVmh9W/lym3C8h8MXCUAW+ahz0jwPSMC8MdPyQiBl1xTVNEoIX
 +Bc/ea1yULO/iXRdIlqZ6V5ni8KsB0yey95bwdTDdFxwKbjUhwoCT6+YQxb9ti+PMGWf
 KvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/tecfdKtW0THS4cueiTfgYZS0wNxxt5XOZ9fATRo0YA=;
 b=BfC2VjqsSfAfFDw6gJK6kMpljIUf0bclc6+xPpb3TKZniHmJJNlnxJJm1kdzfcbrtd
 SPhXur4AqSnaDtISjAgv/MxzKQD8fmnL3ZlXX3Y2dgdJ2UUFU120rTSVxKx71HIYZpwc
 cOpc7v7MWreB8eb4L+cLnq+nkIaEoORFzcgyFJSZwkdR9Cc22oeWTPzKKZTlSB80ucGQ
 L7N1lsAakTonEeehCkI5fKs5k0D0CSS80Ch7d1T/98AG5eqd1r9HIE+/b+DPuankLMD4
 61YJNpaJAxFUrN7CDo5DJ+Qk6NUk5b1svxBOlRSN9p91DpOhvJArwINPmLmoS0t8HGc8
 dJAw==
X-Gm-Message-State: APjAAAVS2585y5SX4shjxfpFs5wHEldRFFaxwDKik4HyiJSZDChSJMCn
 eGJsRJZVrMfRy2wmHpjbz4ododgA9Au04wIaf14=
X-Google-Smtp-Source: APXvYqzy2FM51DhNYOXTYE02NyNya0ukn9S5eqeEOrCAfJqYumwVf6Ivoi1jpAUqxybql1C0aVW15qq3v20zKR5RxGw=
X-Received: by 2002:ad4:4cc4:: with SMTP id i4mr24324200qvz.137.1575133577170; 
 Sat, 30 Nov 2019 09:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
 <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
In-Reply-To: <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 30 Nov 2019 19:05:07 +0200
Message-ID: <CAK4993gztHpfAViSboHQAio7oHMOoJk3gDr_T9w4e9mjA9avBA@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000057554f0598935d3d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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

--00000000000057554f0598935d3d
Content-Type: text/plain; charset="UTF-8"

Hi Aleksandar.

thanks for pointing that out I was not aware of that.
I can fix it.

Regards,
Michael Rolnik

On Sat, Nov 30, 2019 at 6:29 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Saturday, November 30, 2019, Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>>
>> +
>>> +
>>> +/*
>>> + *  Performs the logical AND between the contents of register Rd and
>>> register
>>> + *  Rr and places the result in the destination register Rd.
>>> + */
>>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>>> +{
>>> +    TCGv Rd = cpu_r[a->rd];
>>> +    TCGv Rr = cpu_r[a->rr];
>>> +    TCGv R = tcg_temp_new_i32();
>>> +
>>> +    /* op */
>>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>>> +
>>> +    /* Vf */
>>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>>> +
>>> +    /* Zf */
>>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>>> +
>>> +    gen_ZNSf(R);
>>> +
>>> +    /* R */
>>> +    tcg_gen_mov_tl(Rd, R);
>>> +
>>> +    tcg_temp_free_i32(R);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +
>>>
>>
>> According to specs:
>>
>>
>> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf
>>
>> ... the chips in question have cores with 16 GPRs (that correspond to
>> GPRs R16-R31 of more common AVR cores with 32 GPRs).
>>
>>
> There are more examples;
>
>
> http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf
>
> Also ATtiny20, ATtiny40.
>
> How do you handle such cores?
>>
>> I don't see here anything preventing usage of all 32 GPRs, resulting, of
>> course, in an inaccurate emulation.
>>
>> Thanks,
>> Aleksandar
>>
>

-- 
Best Regards,
Michael Rolnik

--00000000000057554f0598935d3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Aleksandar.<div><br></div><div>thanks for pointing that=
 out I was not aware=C2=A0of that.</div><div>I can fix it.</div><div><br></=
div><div>Regards,</div><div>Michael Rolnik</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 30, 2019 at 6:2=
9 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com"=
>aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br><br>On Saturday, November 30, 2019, Aleksan=
dar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_=
blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><br><br>On Wednesday, November 27, 2019, Michae=
l Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik=
@gmail.com</a>&gt; wrote:<div><br><blockquote class=3D"gmail_quote" style=
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
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000057554f0598935d3d--

