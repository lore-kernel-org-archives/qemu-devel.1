Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE578C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9922075A
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRY5rHEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9922075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ib052-0001Iw-Ml
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib048-0000cV-UP
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:33:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ib047-0000mp-KP
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:33:28 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:38328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ib047-0000jH-Ek
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:33:27 -0500
Received: by mail-oi1-x234.google.com with SMTP id a14so28161929oid.5
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=hAtPzMBnwd3fo1ch5mTGVUYcKSXr4cCztY+KSkm0F1g=;
 b=cRY5rHEuAYPYeBdJ3ZZqQX+1+1T8k3APyHAUdPGw7UjQQOmZ3Cn8SUTUSfaw9s9Us5
 TUXtMe4kF28w943tV1ytX2IrFOb56nu86U1fzgOoeGZ4fVPoaJaWQfIlVm24w76gEHfe
 EXg+Lsxt+K/YtrOottKoQ/dt3dTPcThtpG/Qegx6sF3kR1J66lK+I+DJk3cnHiBaS3Wc
 B6va3DIbko2TOfCKCjgKpGTjTiWxPNofVyjN1DzuC8MROvlojI06XYNLi2E8HtQeEnYC
 vBGJekCKsPJDi04nONzndhCXjVSIhRL7IqzdhHWfMLoF4Bp4G2uXfbiwpshXUEs0+gvp
 Roig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=hAtPzMBnwd3fo1ch5mTGVUYcKSXr4cCztY+KSkm0F1g=;
 b=hL02PEGdd6ThUDfvnxsvB98vJMeNVwr3HzYS83SErKpaLX6i57oIVmIdpzKudpVLDi
 PoeimmUbuSTUMjJfUxmoNtGMyYeqz9IDONDtO5Z0risQRuWbhS3Ngyh1A7aaMkiLWnDj
 NGdX9mEvmoc6HyVvQtSq9LyKxkHPH1VHhIQ57qKdlXeJDE4lttMPRxTTGGeLeIi4lKR8
 P6wZTDVf9KysS9qWdcQpS4Y3bNaW0Y4XW+pGlQpx6nZvaOVN1RZnvNysQfUoOJJtn+WQ
 dW3mKRhds9ZDQ7PmuJZSARz70hoVDbjAsWPz32tAgVYvw+wc7ZnzMZP7JbTam4D+e3UQ
 fm3A==
X-Gm-Message-State: APjAAAWsV3ORsolilDuAXuaYhdBRlrRfwbPNSRjQ8VZA1IPpYetjcF3n
 om9Lo1lm447ty9El6X+xxNltaZURkeb1dOqh7Sw=
X-Google-Smtp-Source: APXvYqwydmIgwVbvSuV09gnGYqrnw84db1lGjJs4N4gMPuk55xM0gPpqOOcVWZP1FsquKKk6Bo93LcPhKksbS7lrG8Q=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr1724119oic.62.1575110006764; 
 Sat, 30 Nov 2019 02:33:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sat, 30 Nov 2019 02:33:26
 -0800 (PST)
In-Reply-To: <20191127175257.23480-6-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-6-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 30 Nov 2019 11:33:26 +0100
Message-ID: <CAL1e-=jzJ3XAEqHOr4Z4UwyRZcfNs_nbKjvvUiX+BSKv6sPH5g@mail.gmail.com>
Subject: Re: [PATCH v37 05/17] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006f77a405988de010"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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

--0000000000006f77a405988de010
Content-Type: text/plain; charset="UTF-8"

On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

+
> +
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
> +    /* op */
> +    tcg_gen_and_tl(R, Rd, Rr); /* Rd = Rd and Rr */
> +
> +    /* Vf */
> +    tcg_gen_movi_tl(cpu_Vf, 0); /* Vf = 0 */
> +
> +    /* Zf */
> +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> +
> +    gen_ZNSf(R);
> +
> +    /* R */
> +    tcg_gen_mov_tl(Rd, R);
> +
> +    tcg_temp_free_i32(R);
> +
> +    return true;
> +}
> +
> +
>

According to specs:

http://ww1.microchip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf

... the chips in question have cores with 16 GPRs (that correspond to GPRs
R16-R31 of more common AVR cores with 32 GPRs).

How do you handle such cores?

I don't see here anything preventing usage of all 32 GPRs, resulting, of
course, in an inaccurate emulation.

Thanks,
Aleksandar

--0000000000006f77a405988de010
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, November 27, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<div><br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
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
-bit-avr-microcontrollers-attiny102-attiny104_datasheet.pdf">http://ww1.mic=
rochip.com/downloads/en/devicedoc/atmel-42505-8-bit-avr-microcontrollers-at=
tiny102-attiny104_datasheet.pdf</a><br></div></div><div><br></div><div>... =
the chips in question have cores with 16 GPRs (that correspond to GPRs R16-=
R31 of more common AVR cores with 32 GPRs).</div><div><br></div><div>How do=
 you handle such cores?</div><div><br></div><div>I don&#39;t see here anyth=
ing preventing usage of all 32 GPRs, resulting, of course, in an inaccurate=
 emulation.</div><div><br></div><div>Thanks,</div><div>Aleksandar</div>

--0000000000006f77a405988de010--

