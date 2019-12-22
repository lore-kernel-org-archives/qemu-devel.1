Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24EC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 15:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CE320665
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prtWHPel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CE320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij3Mn-0007xV-BC
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 10:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ij3Lw-0007WH-Bk
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ij3Lu-00041b-JZ
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:41:08 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:34320)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ij3Lu-0003wV-7Q
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 10:41:06 -0500
Received: by mail-ot1-x336.google.com with SMTP id a15so18751041otf.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 07:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=9yyH/BmmB35JTfTx8zELE7vOt2UzHLGEpQYAcpRhsJo=;
 b=prtWHPelG+3ynfJc/oDpywP1ygIgsvAWNOgT0DMvLGylNg355ercS4SJrikWsstG0V
 m7/1pKqeNNq36Ywwb/Gch3l5BWdR+yqCLFi4b6cAh45itGW8btSm0fxWMHmiUpmkVsIa
 rx39s0CCI3PdCSwtisnH0vpj7j8FB3CH6lyRalzCvltm3+7oH1xZaDNgRKT9TANVZ7Ic
 9GJ6FiFwJKPdHRyUTF7hKLv/y/6fI8e4/yDzWqwhefmqpCJX2r2gHhKnDvZwy37rrfOv
 jRtw4woRHzLvlwDG+soRDLhHUPRSmM6Pt7JSAZWT52kc3hDAlzvUVfewCDM1Sj4KiBrE
 G4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=9yyH/BmmB35JTfTx8zELE7vOt2UzHLGEpQYAcpRhsJo=;
 b=D7PeZnJ5ixMD+JsgONEWhIohS4xdCwYV45dP5Ned1KpWP8G0h1tMIs8dZomsxAej2Z
 uJjfHMsgXICQb7OZVVBfiFl0Mcx/cfIo9H2vmqbY9tNYmvxD7F9dDL+84gE1H4t61M2H
 ukLaO41U9I6KELeKsCB98h0I24WUVlYPjqNAOg2RbKu7NgqFQjkCGI7loG+deY9JG1DE
 ZYXkjlqOkRXbnVCoRd1rX9w2O3vZINmiLyfW1xAB+5QjXoUfyR0+AMc9WoaxEoQ4uK4W
 T1BnzpDPoDeUMLW12hkwRQvaaEAUTAAIgDBgxhZcpGY3wdHbRgpZzp0wmOPJD9qT92Bo
 zAAw==
X-Gm-Message-State: APjAAAVkTOmncM41CtjCkGOrmerB0Qw4BJhyJoBYhFfsfggPv+vzIePI
 6Hd/GZH5NnGWgc13KHwVPaPkQnDgpLur54sF6lo=
X-Google-Smtp-Source: APXvYqyirOXWEkraPdnNTlBu2nVkgWQmAi8few/lYYfO9TcasX+lqt8eOmds1ZWEpr1i6GoWJH2Y8JUznErbBGOpbVY=
X-Received: by 2002:a9d:4c94:: with SMTP id m20mr22897387otf.341.1577029265124; 
 Sun, 22 Dec 2019 07:41:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sun, 22 Dec 2019 07:41:04 -0800 (PST)
In-Reply-To: <20191218210329.1960-6-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-6-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 22 Dec 2019 16:41:04 +0100
Message-ID: <CAL1e-=jKWmj9QUdEwsgrDvqb_quiHr7bfbWdt3Oyt322PP1Ltw@mail.gmail.com>
Subject: Re: [PATCH v39 05/22] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000025f3ea059a4cbd5a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

--00000000000025f3ea059a4cbd5a
Content-Type: text/plain; charset="UTF-8"

On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
> - ADD, ADC, ADIW
> - SBIW, SUB, SUBI, SBC, SBCI
> - AND, ANDI
> - OR, ORI, EOR
> - COM, NEG
> - INC, DEC
> - MUL, MULS, MULSU
> - FMUL, FMULS, FMULSU
> - DES
>
>
>
...

+
> +/*
> + *  Performs the logical AND between the contents of register Rd and
> register
> + *  Rr and places the result in the destination register Rd.
> + */
> +static bool trans_AND(DisasContext *ctx, arg_AND *a)
> +{
> +    TCGv Rd = cpu_r[a->rd];
> +    TCGv Rr = cpu_r[a->rr];
> +    TCGv R = tcg_temp_new_i32();
> +
> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */


Hi, Michael.

Please add before this line a blank line and a comment:

/* update status register */

This is needed to visually separate core functionality and updating status
register in trans_AND() function.

And please repeat that for all instructions that update status register.

Regards,
Aleksandar

--00000000000025f3ea059a4cbd5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, December 18, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">This includes:<br>
- ADD, ADC, ADIW<br>
- SBIW, SUB, SUBI, SBC, SBCI<br>
- AND, ANDI<br>
- OR, ORI, EOR<br>
- COM, NEG<br>
- INC, DEC<br>
- MUL, MULS, MULSU<br>
- FMUL, FMULS, FMULSU<br>
- DES<br>
<br><br></blockquote><div><br></div><div>...</div><div><br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
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
+=C2=A0 =C2=A0 tcg_gen_and_tl(R, Rd, Rr); /* Rd =3D Rd and Rr */<br>
+=C2=A0 =C2=A0 tcg_gen_movi_tl(cpu_Vf, 0); /* Vf =3D 0 */</blockquote><div>=
<br></div><div>Hi, Michael.</div><div><br></div><div>Please add before this=
 line a blank line and a comment:</div><div><br></div><div>/* update status=
 register */</div><div><br></div><div>This is needed to visually separate c=
ore functionality and updating status register in trans_AND() function.</di=
v><div><br></div><div>And please repeat that for all instructions that upda=
te status register.</div><div><br></div><div>Regards,</div><div>Aleksandar<=
/div><div><br></div>

--00000000000025f3ea059a4cbd5a--

