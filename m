Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148CDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3496214DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsC4nXjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3496214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4co-0003ur-Sj
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iw4bo-0003Co-Q2
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iw4bj-0007R4-0L
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:39:20 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>)
 id 1iw4bi-0007QI-Ok; Mon, 27 Jan 2020 08:39:14 -0500
Received: by mail-qk1-x743.google.com with SMTP id q15so3126045qki.2;
 Mon, 27 Jan 2020 05:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H7D6jVZnjaOcje68TvCjIgJoOgBnlyo3FvY99omvC18=;
 b=QsC4nXjTCE84YjejBEkIq6oAoy07OHaczNot8dZUGE9O6R0fJe3MTw3TdgZugxSFY/
 TzLurQ93DpklvZ+ZC51q88Al+vE8DSYD/HTDv6ES9kpfQMroQENx8pdxXp3Zrz8fOYWO
 UjEbZDThawBSm1fGNwZYxRs7twrByUnBRiySGjDmpzf1tNinM/ocU6nA1iwySTkEwde3
 iZaEe5ehkr5xdJRqn08pu3UJpR818I4LYx54QdfoToYM30TJYp940TUYA72B0SXHAt2N
 2WLMlMWBX9786hoFRYp9gX1PyIC68OTRcSD4o1sNdMRbq/qd87NjW2xk3wdIqHMpb+sA
 +DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H7D6jVZnjaOcje68TvCjIgJoOgBnlyo3FvY99omvC18=;
 b=O2EDmFMSlHRh/j7ujqO9FCRlEg8WUGLfht2ctoW7LW98h73WY3Xi7xyBMMQpV+prSt
 99kPhwkt1MOBiiz1meVTUsS2GxdzjT9YZ8iCBbnJ/D5VuXSdte5cwuN+MpWTEa7p4ZR3
 1T/GaK1/Gc6/ZgsAuCQjvtHPW24XjIyJK5Qe/lTy09TtWw5PTt37tIOF5rThx8zOIv7Y
 QxEG38dAWmgwwQZvukmPBmn0FoH6QkWAGwic4nadn3jsUxXuTTOdZRKlgWtfhTnNuhzi
 g3Whu+pzf34pdNkiLiARXh1mPssGfvrU0H1NoQlMy/9f3K+cPkzi9+2cyY4kGGw3Iti3
 Da4A==
X-Gm-Message-State: APjAAAUTV/eTyCOfRsTq2Ydz/6ylkuMnfCc1wouKhP+m5Fq8DJgmH+yj
 157ZLjL7KSJ8GqhRcIi3uaHa8PXMxoMovnz5i2Q=
X-Google-Smtp-Source: APXvYqwyv+zV+r0W5z4AUl92YNuOMpmXK0p669LAkwZkTA3I7OGBjPyQwoK97WQkw1fwrqypD0OtTkBigqgdA5yy600=
X-Received: by 2002:a37:bcc7:: with SMTP id
 m190mr16862199qkf.103.1580132353826; 
 Mon, 27 Jan 2020 05:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <8be57265-7077-45cc-5b5a-d3a4345b4eae@xcancerberox.com.ar>
In-Reply-To: <8be57265-7077-45cc-5b5a-d3a4345b4eae@xcancerberox.com.ar>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 27 Jan 2020 15:38:29 +0200
Message-ID: <CAK4993jHOZWcujAwD+mpir8UCAnbswaNjtRC2HxXCL0gSWMhBg@mail.gmail.com>
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
To: Joaquin de Andres <me@xcancerberox.com.ar>
Content-Type: multipart/alternative; boundary="000000000000a5e483059d1f3bd3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a5e483059d1f3bd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joaquin.

I looks like that the CPU families are not well defined. There are some
small variations within the families themselves i.e. some MCUs do not
support all the features of their families.
To get the features I looked at this file in gcc
https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c
Have a look here
https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-mcus.def.
you can see that not all xmega support RMW instructions. so whenever QEMU
has atxmega128d4 implemented, atxmega128d4 model it will have to remove RMW
feature.

Regards,
Michael Rolnik

On Mon, Jan 27, 2020 at 3:27 PM Joaquin de Andres <me@xcancerberox.com.ar>
wrote:

> On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > From: Michael Rolnik <mrolnik@gmail.com>
> >
> > This includes:
> > - CPU data structures
> > - object model classes and functions
> > - migration functions
> > - GDB hooks
> >
> > Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> > Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Acked-by: Igor Mammedov <imammedo@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Message-Id: <20200118191416.19934-2-mrolnik@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> > ...
> > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > new file mode 100644
> > index 0000000000..c74c5106fe
> > --- /dev/null
> > +++ b/target/avr/cpu.c
> > @@ -0,0 +1,826 @@
> > ...
> > +/*
> > + * Setting features of AVR core type avr1
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at90s1200, attiny11, attiny12, attiny15, attiny28
> > + */
> > +static void avr_avr1_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +> +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Hi! According to the datasheets the at90s1200 is an special case and the
> LPM instruction is not present.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with at90s1200 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr2
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
> at90s4414,
> > + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> > + */
> > +static void avr_avr2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with at90s2313 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with at90s2313 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with at90s2313 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with at90s2313 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with at90s2313 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr25
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
> attiny24,
> > + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
> attiny84a,
> > + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
> attiny461a,
> > + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
> attiny828,
> > + * attiny841, at86rf401
> > + */
> > +static void avr_avr25_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with attiny13 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with attiny13 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with attiny13 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with attiny13 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with attiny13 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);> +    avr_set_feature(env,
> AVR_FEATURE_MOVW);
>
> Ok. Checked with attiny13 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr3
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * at43usb355, at76c711
> > + */
> > +static void avr_avr3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with at43usb355 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);> +
> avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with at43usb355 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with at43usb355 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> > +}
>
> I couldn't find the full instruction set for this microcontrollers, but
> according with this [1] (not a certainty at all) wikipedia page, all the
> instructions in the features are part of the instruction set (BREAK,
> ICALL, IJMP, JMP, CALL, ADIW, SBIW).
>
> > +
> > +/*
> > + * Setting features of AVR core type avr31
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega103, at43usb320
> > + */
> > +static void avr_avr31_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atmega103 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atmega103 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr35
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2,
> atmega16u2,
> > + * atmega32u2, attiny167, attiny1634
> > + */
> > +static void avr_avr35_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atmega8u2/16u2/32u2 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr4
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48,
> atmega48a,
> > + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
> > + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
> > + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
> > + */
> > +static void avr_avr4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atmega8 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr5
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,
> ata6613c,
> > + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
> atmega162,
> > + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
> atmega165a,
> > + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
> atmega168pa,
> > + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
> atmega16hvb,
> > + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
> atmega323,
> > + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
> atmega325p,
> > + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa,
> atmega328,
> > + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
> atmega329pa,
> > + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1,
> atmega32m1,
> > + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,
> atmega644,
> > + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
> atmega645p,
> > + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
> atmega649p,
> > + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a,
> atmega6490p,
> > + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
> > + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161,
> at90pwm216,
> > + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
> > + */
> > +static void avr_avr5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega640 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atmega8 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);> +
> avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atmega8 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atmega8 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr51
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
> atmega1284p,
> > + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
> at90usb1286,
> > + * at90usb1287
> > + */
> > +static void avr_avr51_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atmega128 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atmega128 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atmega128 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avr6
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
> > + */
> > +static void avr_avr6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atmega2560 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type avrtiny
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> > + */
> > +static void avr_avrtiny_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> According with the attiny4/5/9/10 datasheet there is no LPM instruction.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with attiny4/5/9/10 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with attiny4/5/9/10 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with attiny4/5/9/10 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega2
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4,
> atxmega32c3,
> > + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
> > + * atxmega32c4, atxmega32e5
> > + */
> > +static void avr_xmega2_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with atxmega8e5/16e5/32e5 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega3
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417,
> attiny814,
> > + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
> > + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
> > + * atmega3208, atmega3209, atmega4808, atmega4809
> > + */
> > +static void avr_xmega3_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with attiny212 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with attiny212 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with attiny212 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega4
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
> > + * atxmega64b3, atxmega64c3, atxmega64d4
> > + */
> > +static void avr_xmega4_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with atxmega64a3 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega5
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega64a1, atxmega64a1u
> > + */
> > +static void avr_xmega5_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with atxmega64a1 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega6
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
> > + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
> atxmega128b1,
> > + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
> atxmega192c3,
> > + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
> > + */
> > +static void avr_xmega6_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with atxmega128a3 datasheet.
>
> > +}
> > +
> > +/*
> > + * Setting features of AVR core type xmega7
> > + * --------------------------------------
> > + *
> > + * This type of AVR core is present in the following AVR MCUs:
> > + *
> > + * atxmega128a1, atxmega128a1u, atxmega128a4u
> > + */
> > +static void avr_xmega7_initfn(Object *obj)
> > +{
> > +    AVRCPU *cpu =3D AVR_CPU(obj);
> > +    CPUAVRState *env =3D &cpu->env;
> > +
> > +    avr_set_feature(env, AVR_FEATURE_LPM);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_SRAM);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_BREAK);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +
> > +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> > +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> > +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> > +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> > +    avr_set_feature(env, AVR_FEATURE_ELPM);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_LPMX);
> > +    avr_set_feature(env, AVR_FEATURE_MOVW);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_MUL);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +    avr_set_feature(env, AVR_FEATURE_RMW);
>
> Ok. Checked with atxmega128a1 datasheet.
>
> > +}
> > ...
>
>
> I hope this cross check is useful. The features that I didn't comment on
> is because I'm not sure.
>
> Really nice to have this in qemu :). Thanks!
>
> --joa
>
> [1] https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set
>


--=20
Best Regards,
Michael Rolnik

--000000000000a5e483059d1f3bd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Joaquin.<div><br></div><div>I looks like that the CPU f=
amilies are not well defined. There are some small variations within the fa=
milies themselves i.e. some MCUs do not support all the features of their f=
amilies.</div><div>To get the features I looked at this file in gcc=C2=A0<a=
 href=3D"https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-d=
evices.c">https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-=
devices.c</a></div><div>Have a look here=C2=A0<a href=3D"https://github.com=
/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-mcus.def">https://github.com=
/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-mcus.def</a>. you can see th=
at not all xmega support RMW instructions. so whenever QEMU has=C2=A0<span =
style=3D"color:rgb(36,41,46);font-family:SFMono-Regular,Consolas,&quot;Libe=
ration Mono&quot;,Menlo,monospace;font-size:12px;white-space:pre">atxmega12=
8d4 implemented, </span>atxmega128d4 model<span style=3D"color:rgb(36,41,46=
);font-family:SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,mon=
ospace;font-size:12px;white-space:pre"> it will have to remove RMW feature.=
</span></div><div><br></div><div>Regards,</div><div>Michael Rolnik</div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Jan 27, 2020 at 3:27 PM Joaquin de Andres &lt;<a href=3D"mailto:me@xca=
ncerberox.com.ar">me@xcancerberox.com.ar</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 1/24/20 1:51 AM, Philippe Mathie=
u-Daud=C3=A9 wrote:<br>
&gt; From: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=
=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; <br>
&gt; This includes:<br>
&gt; - CPU data structures<br>
&gt; - object model classes and functions<br>
&gt; - migration functions<br>
&gt; - GDB hooks<br>
&gt; <br>
&gt; Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.co=
m" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac=
.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.u=
k" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200118191416.19934-2-mrolnik@gmail=
.com" target=3D"_blank">20200118191416.19934-2-mrolnik@gmail.com</a>&gt;<br=
>
&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henders=
on@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; ...<br>
&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..c74c5106fe<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/cpu.c<br>
&gt; @@ -0,0 +1,826 @@<br>
&gt; ...<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr1<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at90s1200, attiny11, attiny12, attiny15, attiny28<br>
&gt; + */<br>
&gt; +static void avr_avr1_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Hi! According to the datasheets the at90s1200 is an special case and the<br=
>
LPM instruction is not present.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with at90s1200 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr2<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at=
90s4414,<br>
&gt; + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535<br>
&gt; + */<br>
&gt; +static void avr_avr2_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with at90s2313 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with at90s2313 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with at90s2313 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with at90s2313 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with at90s2313 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr25<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, a=
ttiny24,<br>
&gt; + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, a=
ttiny84a,<br>
&gt; + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, at=
tiny461a,<br>
&gt; + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, at=
tiny828,<br>
&gt; + * attiny841, at86rf401<br>
&gt; + */<br>
&gt; +static void avr_avr25_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);&gt; +=C2=A0 =C2=
=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with attiny13 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr3<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * at43usb355, at76c711<br>
&gt; + */<br>
&gt; +static void avr_avr3_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with at43usb355 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);&gt; +=C2=
=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with at43usb355 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with at43usb355 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
&gt; +}<br>
<br>
I couldn&#39;t find the full instruction set for this microcontrollers, but=
<br>
according with this [1] (not a certainty at all) wikipedia page, all the<br=
>
instructions in the features are part of the instruction set (BREAK,<br>
ICALL, IJMP, JMP, CALL, ADIW, SBIW).<br>
<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr31<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega103, at43usb320<br>
&gt; + */<br>
&gt; +static void avr_avr31_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atmega103 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr35<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, at=
mega16u2,<br>
&gt; + * atmega32u2, attiny167, attiny1634<br>
&gt; + */<br>
&gt; +static void avr_avr35_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atmega8u2/16u2/32u2 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr4<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, =
atmega48a,<br>
&gt; + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,=
<br>
&gt; + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pw=
m1,<br>
&gt; + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81<br>
&gt; + */<br>
&gt; +static void avr_avr4_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr5<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831=
, ata6613c,<br>
&gt; + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega=
162,<br>
&gt; + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega1=
65a,<br>
&gt; + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega=
168pa,<br>
&gt; + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmeg=
a16hvb,<br>
&gt; + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atme=
ga323,<br>
&gt; + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega=
325p,<br>
&gt; + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, a=
tmega328,<br>
&gt; + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega=
329pa,<br>
&gt; + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, at=
mega32m1,<br>
&gt; + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,=
 atmega644,<br>
&gt; + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega=
645p,<br>
&gt; + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmeg=
a649p,<br>
&gt; + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, a=
tmega6490p,<br>
&gt; + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,<b=
r>
&gt; + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, =
at90pwm216,<br>
&gt; + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000<br>
&gt; + */<br>
&gt; +static void avr_avr5_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega640 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);&gt; +=C2=
=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atmega8 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr51<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1=
284p,<br>
&gt; + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1=
286,<br>
&gt; + * at90usb1287<br>
&gt; + */<br>
&gt; +static void avr_avr51_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atmega128 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avr6<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2<br>
&gt; + */<br>
&gt; +static void avr_avr6_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atmega2560 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type avrtiny<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40<br>
&gt; + */<br>
&gt; +static void avr_avrtiny_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
According with the attiny4/5/9/10 datasheet there is no LPM instruction.<br=
>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with attiny4/5/9/10 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with attiny4/5/9/10 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with attiny4/5/9/10 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega2<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, at=
xmega32c3,<br>
&gt; + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,=
<br>
&gt; + * atxmega32c4, atxmega32e5<br>
&gt; + */<br>
&gt; +static void avr_xmega2_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with atxmega8e5/16e5/32e5 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega3<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, =
attiny814,<br>
&gt; + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny32=
14,<br>
&gt; + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega16=
09,<br>
&gt; + * atmega3208, atmega3209, atmega4808, atmega4809<br>
&gt; + */<br>
&gt; +static void avr_xmega3_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with attiny212 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega4<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,=
<br>
&gt; + * atxmega64b3, atxmega64c3, atxmega64d4<br>
&gt; + */<br>
&gt; +static void avr_xmega4_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with atxmega64a3 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega5<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega64a1, atxmega64a1u<br>
&gt; + */<br>
&gt; +static void avr_xmega5_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with atxmega64a1 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega6<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256=
a3,<br>
&gt; + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmeg=
a128b1,<br>
&gt; + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega19=
2c3,<br>
&gt; + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3<br>
&gt; + */<br>
&gt; +static void avr_xmega6_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with atxmega128a3 datasheet.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Setting features of AVR core type xmega7<br>
&gt; + * --------------------------------------<br>
&gt; + *<br>
&gt; + * This type of AVR core is present in the following AVR MCUs:<br>
&gt; + *<br>
&gt; + * atxmega128a1, atxmega128a1u, atxmega128a4u<br>
&gt; + */<br>
&gt; +static void avr_xmega7_initfn(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPM);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_SRAM);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_BREAK);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPD);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPY);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RAMPZ);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_ELPM);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_JMP_CALL);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_LPMX);<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MOVW);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_MUL);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +=C2=A0 =C2=A0 avr_set_feature(env, AVR_FEATURE_RMW);<br>
<br>
Ok. Checked with atxmega128a1 datasheet.<br>
<br>
&gt; +}<br>
&gt; ...<br>
<br>
<br>
I hope this cross check is useful. The features that I didn&#39;t comment o=
n<br>
is because I&#39;m not sure.<br>
<br>
Really nice to have this in qemu :). Thanks!<br>
<br>
--joa<br>
<br>
[1] <a href=3D"https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set" rel=
=3D"noreferrer" target=3D"_blank">https://en.wikipedia.org/wiki/Atmel_AVR_i=
nstruction_set</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000a5e483059d1f3bd3--

