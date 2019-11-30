Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A5C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 16:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46D020715
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW26VVGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46D020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib5d9-00029U-0M
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 11:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib5cT-0001Wa-HX
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib5cS-0002Fp-8r
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:29:17 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ib5cS-0002D9-3T
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 11:29:16 -0500
Received: by mail-ot1-x342.google.com with SMTP id r24so27309437otk.12
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=oxwBlqTEWSwmKsYchd2NnwVbPln5Sc7i9qaTKfaNX3w=;
 b=bW26VVGqB7x1aifYbzlrv0Ls7x2X5GJSFEgZ426QdPzShqPZ0+QON0iIOzywFk6pVg
 4ivH42+UJk1Su3sDA2NEVkH5k+IDleZYwShKKa9Epy8DeEiBoa5tEhLRk0J7t11U2bv9
 5Ugl25xZ9/cRzq/Rp6zo75PqwAaqG3Bmn/FLwLCzyaYqDRwj2lXXs+dUrUv+Nj9yA1e5
 DoP7DlqxgrhH/GEg2r2NhEoxgMsh52TnGX6AGAjJfnfeuyLc9gfijz9Alg6qTcQ2tBaC
 eZ8roybvZZq6DjFUVVItpx/d1tcLTxe4AhnQ9jOn3JeESRXL7TBbhnOoK+rYgDLsw8uw
 5RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=oxwBlqTEWSwmKsYchd2NnwVbPln5Sc7i9qaTKfaNX3w=;
 b=gUSbrR+fTHSYEi+ki6HkCtIaLki5mWSnPh8R0rKGJQhvHr4N2y5GSCBSfSBiOmJM1a
 e3YeqQ0SPoPg6Al8Vlku34XZfMXc91YHSSdgiso1JxKq2hBuNwldIkenJopq2k620HsW
 zBXfqJw6SfmTYp5hrFBzfiMG9sbO/YwstB5JH+iv+oz+nnKwMbJG0lSQKuXHcZFAJGK/
 XKmL1CU4uZfyOPB4ZOzmA1Ou7zUNtEzfqniptmnAs4rj76q61drxzOp2m1BjEpEe/ixG
 4OZN3AiGQQt7jjd9QAO5CgE4jrCBJKZ8nsAM9rW+O6hB9i3TpJu+Qlz4Vxnxe8d7Wjg9
 xcXQ==
X-Gm-Message-State: APjAAAWkU27ib+bGnRieMqcVhgFn7D0MqfpSaQUJOK5j18K8sNlVqwMa
 u0YiKeVG87ECZHNNuZrSibodpNl5c7nM+vzLZw8=
X-Google-Smtp-Source: APXvYqxslgKST8tJ/o1NJZb9h21zXKEM0MMn6NTGr1/SD9vqck0FpFnPv0r90q6ifpABYvH5kiAhExDI2fUWReokz2o=
X-Received: by 2002:a9d:1b3:: with SMTP id e48mr15663508ote.341.1575131354750; 
 Sat, 30 Nov 2019 08:29:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 08:29:14
 -0800 (PST)
In-Reply-To: <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
 <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 Nov 2019 17:29:14 +0100
Message-ID: <CAL1e-=i9ft-Py65fjuNt=TBFqw+EOerp9JBUsZa2i0wN8mAPJw@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000dfe477059892d8d9"
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
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dfe477059892d8d9
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 30, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>
> +
>> +
>> +/*
>> + *  Performs the logical AND between the contents of register Rd and
>> register
>> + *  Rr and places the result in the destination register Rd.
>> + */
>> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
>> +{
>> +    TCGv Rd = cpu_r[a->rd];
>> +    TCGv Rr = cpu_r[a->rr];
>> +    TCGv R = tcg_temp_new_i32();
>> +
>> +    /* op */
>> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
>> +
>> +    /* Vf */
>> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
>> +
>> +    /* Zf */
>> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
>> +
>> +    gen_ZNSf(R);
>> +
>> +    /* R */
>> +    tcg_gen_mov_tl(Rd, R);
>> +
>> +    tcg_temp_free_i32(R);
>> +
>> +    return true;
>> +}
>> +
>> +
>>
>
> According to specs:
>
> http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-
> microcontrollers-attiny102-attiny104_datasheet.pdf
>
> ... the chips in question have cores with 16 GPRs (that correspond to GPRs
> R16-R31 of more common AVR cores with 32 GPRs).
>
>
There are more examples;

http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_datasheet.pdf

Also ATtiny20, ATtiny40.

How do you handle such cores?
>
> I don't see here anything preventing usage of all 32 GPRs, resulting, of
> course, in an inaccurate emulation.
>
> Thanks,
> Aleksandar
>

--000000000000dfe477059892d8d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 30, 2019, Aleksandar Markovic &lt;<a href=3D"=
mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><br><br>On Wednesday, November 27, 20=
19, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blan=
k">mrolnik@gmail.com</a>&gt; wrote:<div><br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
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
nk">http://ww1.microchip.com/<wbr>downloads/en/devicedoc/atmel-<wbr>42505-8=
-bit-avr-<wbr>microcontrollers-attiny102-<wbr>attiny104_datasheet.pdf</a><b=
r></div></div><div><br></div><div>... the chips in question have cores with=
 16 GPRs (that correspond to GPRs R16-R31 of more common AVR cores with 32 =
GPRs).</div><div><br></div></blockquote><div><br></div><div>There are more =
examples;</div><div><br></div><div><a href=3D"http://ww1.microchip.com/down=
loads/en/DeviceDoc/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-att=
iny9-attiny10_datasheet.pdf">http://ww1.microchip.com/downloads/en/DeviceDo=
c/atmel-8127-avr-8-bit-microcontroller-attiny4-attiny5-attiny9-attiny10_dat=
asheet.pdf</a><br></div><div><br></div><div>Also ATtiny20, ATtiny40.</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div>How do you handle such co=
res?</div><div><br></div><div>I don&#39;t see here anything preventing usag=
e of all 32 GPRs, resulting, of course, in an inaccurate emulation.</div><d=
iv><br></div><div>Thanks,</div><div>Aleksandar</div>
</blockquote>

--000000000000dfe477059892d8d9--

