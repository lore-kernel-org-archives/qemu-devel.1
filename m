Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD3C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C3120869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTNnP1JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C3120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvRu-0002M4-Gd
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRvQJ-00018m-GC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iRvQH-0006DV-Rf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:46:51 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iRvQH-0006D4-GS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:46:49 -0500
Received: by mail-ot1-x342.google.com with SMTP id c19so970169otr.11
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xOaqK2lR5/e5h6h7xhh7IO++8GmJUgjamw2Cs7Orwgo=;
 b=jTNnP1JQ0IJliPMFL406lRmotwfPslOuCAeCtCcI48lgXxaRCT0ceo4vmo5MVarT36
 x0E5rWeWTw7evz/fdv3FAc/yMNKxUKG8TA+lkI5ltDdaezq+B279vs1CQc1fYU7CEi0/
 ZwURFsmgmg5cnsN778Og7Ya7/YAK8OOMv5TTEtvymMlSrs1k9ngBN+O8tOVzlDgKN1Sa
 oe0k2nuS1HrjlPhQOdvEnEZ/9+0HIVVpqXViRaY81zD0VTfZAOa9BoqDXUey1F4t/7TM
 Oe6jGj6wg67xd3lYfCi4TZDr4fdTzzurNrkkFG6e/wz1A/csa7ZR5vS8HwbgsH1b47gK
 oK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xOaqK2lR5/e5h6h7xhh7IO++8GmJUgjamw2Cs7Orwgo=;
 b=OVrjnU/IhQS3UTSwo25HVCLV8ZIynA0f0YXdilkF9Xfz4ELACCaEmDrJQ0bNWOTa0s
 8cZ6Fjgzi4BR0blQRH+igWI/c64LmmnGDGyUDYXczx20VQL75wEo3YHS6t4hSysthe3I
 9KGYPGPZM9dGNRAHqc0aj6uGtGgTpn3ZcgiUP9BoTbJ8qNZRWevCMOzvo2uzEz9Qq7au
 I1L2pnNQV0kuakNqyAGWk1c3NptBklJ2n454OocmAJplseDQR592l8MFhuV+72Z2naRg
 xEUe2P3Vcd7MFAfEkdZQL9GWwRZrq7jf37Eatv0+oVSZTLw9Ro8wjgfDr/48jnvEHaBU
 MGIg==
X-Gm-Message-State: APjAAAUstHzAHkTyp9EmUOdAA4bQgHTlujudEMipl1iNRDBk4rK9vnVk
 3VcXa4GldfCiEXsbVbh6m6RfGmEkQHK0TyaUTXI=
X-Google-Smtp-Source: APXvYqxaHFPKmbx9RJt8rz6rpNxTiItnMk39bD1n2FTibgppF5LAlmYQmBremM0hfDb7kvVWN3RkS9FiSUPO2tqAl7U=
X-Received: by 2002:a05:6830:2151:: with SMTP id
 r17mr23116351otd.341.1572947208202; 
 Tue, 05 Nov 2019 01:46:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Tue, 5 Nov 2019 01:46:47 -0800 (PST)
In-Reply-To: <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 5 Nov 2019 10:46:47 +0100
Message-ID: <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000986c170596964f22"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000986c170596964f22
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 5, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>> +
>> +/*
>> + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
>> multiplication
>> + *  and shifts the result one bit left.
>> + */
>> +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
>> +{
>> +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
>> +        return true;
>> +    }
>> +
>> +    TCGv R0 = cpu_r[0];
>> +    TCGv R1 = cpu_r[1];
>> +    TCGv Rd = cpu_r[a->rd];
>> +    TCGv Rr = cpu_r[a->rr];
>> +    TCGv R = tcg_temp_new_i32();
>> +    TCGv t0 = tcg_temp_new_i32();
>> +
>> +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
>> +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
>> +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
>> +
>> +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>> +
>> +    tcg_gen_shli_tl(R, R, 1);
>> +
>> +    tcg_gen_andi_tl(R0, R, 0xff);
>> +    tcg_gen_shri_tl(R1, R, 8);
>> +    tcg_gen_andi_tl(R1, R1, 0xff);
>> +
>> +    tcg_temp_free_i32(t0);
>> +    tcg_temp_free_i32(R);
>> +
>> +    return true;
>> +}
>> +
>
>
> Hi, Michael.
>
> The way I understand the spec is that a->rd and a->rd must be between 16
> and 23:
>
> https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html
>
> Is my interpretation right? If yes, where is the corresponding part in the
> implementation?
>
>
Or, perhaps,

TCGv Rd = cpu_r[a->rd];

should be

TCGv Rd = cpu_r[a->rd + 16];

(and the same for rs)

?


Yours, Aleksandar
>
>
>>

--000000000000986c170596964f22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 5, 2019, Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
+<br>
+/*<br>
+ *=C2=A0 This instruction performs 8-bit x 8-bit -&gt; 16-bit signed multi=
plication<br>
+ *=C2=A0 and shifts the result one bit left.<br>
+ */<br>
+static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)<br>
+{<br>
+=C2=A0 =C2=A0 if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 TCGv R0 =3D cpu_r[0];<br>
+=C2=A0 =C2=A0 TCGv R1 =3D cpu_r[1];<br>
+=C2=A0 =C2=A0 TCGv Rd =3D cpu_r[a-&gt;rd];<br>
+=C2=A0 =C2=A0 TCGv Rr =3D cpu_r[a-&gt;rr];<br>
+=C2=A0 =C2=A0 TCGv R =3D tcg_temp_new_i32();<br>
+=C2=A0 =C2=A0 TCGv t0 =3D tcg_temp_new_i32();<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */<b=
r>
+=C2=A0 =C2=A0 tcg_gen_mul_tl(R, t0, Rr); /* R =3D Rd * Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf =3D R(15) */<br>
+=C2=A0 =C2=A0 tcg_gen_setcondi_tl(TCG_COND_E<wbr>Q, cpu_Zf, R, 0); /* Zf =
=3D R =3D=3D 0 */<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_shli_tl(R, R, 1);<br>
+<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R0, R, 0xff);<br>
+=C2=A0 =C2=A0 tcg_gen_shri_tl(R1, R, 8);<br>
+=C2=A0 =C2=A0 tcg_gen_andi_tl(R1, R1, 0xff);<br>
+<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(t0);<br>
+=C2=A0 =C2=A0 tcg_temp_free_i32(R);<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+</blockquote><div><br></div><div>Hi, Michael.</div><div><br></div><div>The=
 way I understand the spec is that a-&gt;rd and a-&gt;rd must be between 16=
 and 23:</div><div><br></div><div><a href=3D"https://www.microchip.com/webd=
oc/avrassembler/avrassembler.wb_FMULSU.html" target=3D"_blank">https://www.=
microchip.com/<wbr>webdoc/avrassembler/<wbr>avrassembler.wb_FMULSU.html</a>=
<br></div><div><br></div><div>Is my interpretation right? If yes, where is =
the corresponding part in the implementation?</div><div><br></div></blockqu=
ote><div><br></div><div>Or, perhaps,</div><div><br></div><div><span style=
=3D"color:rgb(0,123,53);font-size:14px;line-height:22.1200008392334px">TCGv=
 Rd =3D cpu_r[a-&gt;rd];</span><br></div><div><span style=3D"color:rgb(0,12=
3,53);font-size:14px;line-height:22.1200008392334px"><br></span></div><div>=
should be</div><div><br></div><div><span style=3D"color:rgb(0,123,53);font-=
size:14px;line-height:22.1200008392334px">TCGv Rd =3D cpu_r[a-&gt;rd + 16];=
</span><br></div><div>=C2=A0</div><div>(and the same for rs)</div><div><br>=
</div><div>?</div><div><br></div><div><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div>Yours, Aleksandar</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x"><br>
</blockquote>
</blockquote>

--000000000000986c170596964f22--

