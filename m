Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A785C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18AE20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNvtMYkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18AE20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j13go-0001mA-3D
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 02:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1j13fq-00016z-K5
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1j13fj-0003pA-JL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:40:06 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:46861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1j13fj-0003lu-1y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 02:39:59 -0500
Received: by mail-qv1-xf42.google.com with SMTP id y2so2736374qvu.13
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2020 23:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OTy20U4G6cUgxMdPUWj4hGav/7N+VT+BGOev3VCl2xA=;
 b=eNvtMYkL1QmjAakOhDDYwgx31oMWBBXJm68z6IzTx5c5Dy2+fliVyFioty12HZX15Z
 Zcm7JnzEeFZZTBMPN7l/fAI2y4LkZJiNf82IptoNvRJSP8tJIxegxL7niAqgQ3v/Lu7q
 WL6FujCHuuRevt7s7krn8k3Vrm4LCzmfu/P+5kyPOvgmmj1pcG5lc+igmfDpkgYcLzPR
 TGzzHGSgZVWC0zArLHYA9kweqma38PZzXLTgnN0pLs29wKjDQlV7x3YtRgrocolFdBw9
 t/VrwAEKUCWztbsqIzUyETqMfxZ233oDu/p6zKEWBxbPZBH+F9I50Dr94t316/f3of9F
 t/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OTy20U4G6cUgxMdPUWj4hGav/7N+VT+BGOev3VCl2xA=;
 b=eQHDWdiY83zJ5qvrGUuCVC8jg6o421sJKd7vrFiL6RqOjG7g/NT7THIGsZqls2Ima/
 H25Nnp9NNVPj0jFdN6FMQPcaWvx900iWjJ89swYik0XGImAksLoW7SWLNdW+INZkyfIT
 OzO+t687PZTvNCzceIiO4NKQscno2vUdCaUCUZiV/j5Pv+O3G/OnNLaAzxMWVMdQjTH+
 YBDeuDiZvzHNUy74sPAK01u08k2NH6TLvQWUk63UqzG9wkdOco/uiU1iJ5rqnPJ6TaRm
 XChNDXckgoOYeXv/GZ95xHkZr2mJ8g623JyeVpQWXDrqt9fM8POqeChEJfS0mBnr314/
 bPOA==
X-Gm-Message-State: APjAAAUhrgwSEQ5xkgXTJ+aia48CQvD15V/iTduOdfUJ+kF/FRI6Rfkh
 /O9tezVYv8FRiG9lLm2L2xhFXn2wJh/LmFiwqcQ=
X-Google-Smtp-Source: APXvYqwuuXMq+NR1jGOcq4942T1JQhCAhKjFtIKp2lJVRpdOxzHEnaq+7jXbMgMjc7TmX7Er5tKYV6nm8fh1/ad46NI=
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mr8838422qvb.137.1581320398000; 
 Sun, 09 Feb 2020 23:39:58 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <87aab645-8ffb-dc0d-9d8d-bfeb4281821d@xcancerberox.com.ar>
 <CAL1e-=h9QVVPuNG+PO3TyT981XPXopmng9vn367LjaQjy64nHA@mail.gmail.com>
In-Reply-To: <CAL1e-=h9QVVPuNG+PO3TyT981XPXopmng9vn367LjaQjy64nHA@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 10 Feb 2020 09:39:14 +0200
Message-ID: <CAK4993h7GaKiSt5LNrEtvRhCDE3tsMyNh-t6551-eZjx39sq7w@mail.gmail.com>
Subject: Re: [PATCH rc4 06/29] target/avr: Add defintions of AVR core types
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000996f45059e33d88b"
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000996f45059e33d88b
Content-Type: multipart/alternative; boundary="000000000000996f44059e33d889"

--000000000000996f44059e33d889
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

When I decided to implement AVR 8 bit CPU support for QEMU I found this
document
<http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instruction=
-set-manual.pdf>
which
listed all AVR instructions.
After that I learned that there are several CPU flavours, I looked into
this GCC file
<https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c=
> to
figure out what are they as I could not find any official document
explaining it.
Then I downloaded several datasheets and created a list of instructions by
CPU type (attached).It turned out that there are some variations
e.g.
- AVTTINY - some have LDS, some don't
- AVR1, AVR25 - some have short SP, some don't
- AVRXMEGA2, AVRXMEGA4, AVRXMEGA5, AVRXMEGA6, AVRXMEGA7 - some have RMW,
some don't
- AVRXMEGA3 - some have RCALL, some don't

I decided to leave CPU flavour definition as suggested by GCC
gcc/config/avr/avr-devices.c
<https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c=
>
file and when a specific MCU is created it will set / reset CPU features
relevant to it.

I hope this helps.

Best Regards,
Michael Rolnik







On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, February 2, 2020, Joaquin de Andres <me@xcancerberox.com.ar>
> wrote:
>
>> On 1/31/20 1:02 AM, Aleksandar Markovic wrote:
>>
>>> From: Michael Rolnik <mrolnik@gmail.com>
>>>
>>> AVR core types are:
>>>
>>>    - avr1
>>>    - avr2
>>>    - avr25
>>>    - avr3
>>>    - avr31
>>>    - avr35
>>>    - avr4
>>>    - avr5
>>>    - avr51
>>>    - avr6
>>>    - avrtiny
>>>    - xmega2
>>>    - xmega3
>>>    - xmega4
>>>    - xmega5
>>>    - xmega6
>>>    - xmega7
>>>
>>> Each core type covers multiple AVR MCUs, mentioned in the comments
>>> before definition of particular AVR core type (part of this patch).
>>>
>>> AVR core type defines shared features that are valid for all AVR
>>> MCUs belonging in that type.
>>>
>>> [AM: Split a larger AVR introduction patch into logical units]
>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>
>>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>> ---
>>>   target/avr/cpu.c | 601
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 601 insertions(+)
>>>
>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>>> index f41a887..e0ae055 100644
>>> --- a/target/avr/cpu.c
>>> +++ b/target/avr/cpu.c
>>> @@ -215,3 +215,604 @@ static void avr_cpu_class_init(ObjectClass *oc,
>>> void *data)
>>>       cc->gdb_num_core_regs =3D 35;
>>>       cc->gdb_core_xml_file =3D "avr-cpu.xml";
>>>   }
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr1
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * at90s1200, attiny11, attiny12, attiny15, attiny28
>>> + */
>>> +static void avr_avr1_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr2
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
>>> at90s4414,
>>> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>>> + */
>>> +static void avr_avr2_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr25
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
>>> attiny24,
>>> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
>>> attiny84a,
>>> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
>>> attiny461a,
>>> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
>>> attiny828,
>>> + * attiny841, at86rf401
>>> + */
>>> +static void avr_avr25_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr3
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * at43usb355, at76c711
>>> + */
>>> +static void avr_avr3_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr31
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atmega103, at43usb320
>>> + */
>>> +static void avr_avr31_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr35
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2,
>>> atmega16u2,
>>> + * atmega32u2, attiny167, attiny1634
>>> + */
>>> +static void avr_avr35_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr4
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48,
>>> atmega48a,
>>> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
>>> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
>>> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
>>> + */
>>> +static void avr_avr4_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr5
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,
>>> ata6613c,
>>> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
>>> atmega162,
>>> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
>>> atmega165a,
>>> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
>>> atmega168pa,
>>> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
>>> atmega16hvb,
>>> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
>>> atmega323,
>>> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
>>> atmega325p,
>>> + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa,
>>> atmega328,
>>> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
>>> atmega329pa,
>>> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1,
>>> atmega32m1,
>>> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,
>>> atmega644,
>>> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
>>> atmega645p,
>>> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
>>> atmega649p,
>>> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a,
>>> atmega6490p,
>>> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
>>> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161,
>>> at90pwm216,
>>> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
>>> + */
>>> +static void avr_avr5_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr51
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
>>> atmega1284p,
>>> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
>>> at90usb1286,
>>> + * at90usb1287
>>> + */
>>> +static void avr_avr51_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avr6
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
>>> + */
>>> +static void avr_avr6_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type avrtiny
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>>> + */
>>> +static void avr_avrtiny_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega2
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4,
>>> atxmega32c3,
>>> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
>>> + * atxmega32c4, atxmega32e5
>>> + */
>>> +static void avr_xmega2_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega3
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417,
>>> attiny814,
>>> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
>>> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
>>> + * atmega3208, atmega3209, atmega4808, atmega4809
>>> + */
>>> +static void avr_xmega3_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega4
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
>>> + * atxmega64b3, atxmega64c3, atxmega64d4
>>> + */
>>> +static void avr_xmega4_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega5
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atxmega64a1, atxmega64a1u
>>> + */
>>> +static void avr_xmega5_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega6
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
>>> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
>>> atxmega128b1,
>>> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
>>> atxmega192c3,
>>> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
>>> + */
>>> +static void avr_xmega6_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +/*
>>> + * Setting features of AVR core type xmega7
>>> + * --------------------------------------
>>> + *
>>> + * This type of AVR core is present in the following AVR MCUs:
>>> + *
>>> + * atxmega128a1, atxmega128a1u, atxmega128a4u
>>> + */
>>> +static void avr_xmega7_initfn(Object *obj)
>>> +{
>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>> +    CPUAVRState *env =3D &cpu->env;
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>> +
>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>> +}
>>> +
>>> +typedef struct AVRCPUInfo {
>>> +    const char *name;
>>> +    void (*initfn)(Object *obj);
>>> +} AVRCPUInfo;
>>> +
>>> +
>>> +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
>>> +{
>>> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data))=
;
>>> +
>>> +    qemu_printf("%s\n", typename);
>>> +}
>>> +
>>> +void avr_cpu_list(void)
>>> +{
>>> +    GSList *list;
>>> +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
>>> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
>>> +    g_slist_free(list);
>>> +}
>>> +
>>> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
>>> +    { \
>>> +        .parent =3D TYPE_AVR_CPU, \
>>> +        .instance_init =3D initfn, \
>>> +        .name =3D AVR_CPU_TYPE_NAME(model), \
>>> +    }
>>> +
>>> +static const TypeInfo avr_cpu_type_info[] =3D {
>>> +    {
>>> +        .name =3D TYPE_AVR_CPU,
>>> +        .parent =3D TYPE_CPU,
>>> +        .instance_size =3D sizeof(AVRCPU),
>>> +        .instance_init =3D avr_cpu_initfn,
>>> +        .class_size =3D sizeof(AVRCPUClass),
>>> +        .class_init =3D avr_cpu_class_init,
>>> +        .abstract =3D true,
>>> +    },
>>> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
>>> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
>>> +};
>>> +
>>> +const char *avr_flags_to_cpu_type(uint32_t flags, const char
>>> *def_cpu_type)
>>> +{
>>> +    switch (flags & EF_AVR_MACH) {
>>> +    case bfd_mach_avr1:
>>> +        return AVR_CPU_TYPE_NAME("avr1");
>>> +    case bfd_mach_avr2:
>>> +        return AVR_CPU_TYPE_NAME("avr2");
>>> +    case bfd_mach_avr25:
>>> +        return AVR_CPU_TYPE_NAME("avr25");
>>> +    case bfd_mach_avr3:
>>> +        return AVR_CPU_TYPE_NAME("avr3");
>>> +    case bfd_mach_avr31:
>>> +        return AVR_CPU_TYPE_NAME("avr31");
>>> +    case bfd_mach_avr35:
>>> +        return AVR_CPU_TYPE_NAME("avr35");
>>> +    case bfd_mach_avr4:
>>> +        return AVR_CPU_TYPE_NAME("avr4");
>>> +    case bfd_mach_avr5:
>>> +        return AVR_CPU_TYPE_NAME("avr5");
>>> +    case bfd_mach_avr51:
>>> +        return AVR_CPU_TYPE_NAME("avr51");
>>> +    case bfd_mach_avr6:
>>> +        return AVR_CPU_TYPE_NAME("avr6");
>>> +    case bfd_mach_avrtiny:
>>> +        return AVR_CPU_TYPE_NAME("avrtiny");
>>> +    case bfd_mach_avrxmega2:
>>> +        return AVR_CPU_TYPE_NAME("xmega2");
>>> +    case bfd_mach_avrxmega3:
>>> +        return AVR_CPU_TYPE_NAME("xmega3");
>>> +    case bfd_mach_avrxmega4:
>>> +        return AVR_CPU_TYPE_NAME("xmega4");
>>> +    case bfd_mach_avrxmega5:
>>> +        return AVR_CPU_TYPE_NAME("xmega5");
>>> +    case bfd_mach_avrxmega6:
>>> +        return AVR_CPU_TYPE_NAME("xmega6");
>>> +    case bfd_mach_avrxmega7:
>>> +        return AVR_CPU_TYPE_NAME("xmega7");
>>> +    default:
>>> +        return def_cpu_type;
>>> +    }
>>> +}
>>> +
>>> +DEFINE_TYPES(avr_cpu_type_info)
>>>
>>>
>> Hi! me again. Following the RC2 discussion. I've being looking in the GC=
C
>> definition of the architecture and as far as I can understand this
>> definitions are the generic definitions of the arch families.
>>
>>  avr_arch_types[] =3D
>>  {
>>    /* unknown device specified */
>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, NULL,
>> AVR_MMCU_DEFAULT },
>>    /*
>>      A  M  J  LM E  E  E  X  R  T  d S     FPO     S O   A
>>      S  U  M  PO L  L  I  M  A  I  a t     lMff    F ff  r
>>      M  L  P  MV P  P  J  E  M  N  t a     a s     R s   c
>>               XW M  M  M  G  P  Y  a r     s e       e   h
>>                     X  P  A  D       t     h t       t   ID   */
>>    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "1",   "avr1"  },
>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "2",   "avr2"  },
>>    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "25",  "avr25" },
>>    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "3",   "avr3"  },
>>    { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,      32, "31",  "avr31" },
>>    { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "35",  "avr35" },
>>    { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "4",   "avr4"  },
>>    { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "5",   "avr5"  },
>>    { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,      32, "51",  "avr51" },
>>    { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,      32, "6",   "avr6"  },
>>
>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0, "100", "avrtiny"},
>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,      0, "102", "avrxmega2"
>> },
>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0, "103", "avrxmega3"
>> },
>>    { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,      0, "104", "avrxmega4"
>> },
>>    { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,      0, "105", "avrxmega5"
>> },
>>    { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,      0, "106", "avrxmega6"
>> },
>>    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,      0, "107", "avrxmega7"
>> }
>>  };
>>
>> And then you have features for the specific microcontrollers:
>>
>>  AVR_ISA_RMW
>>  AVR_SHORT_SP
>>  AVR_ERRATA_SKIP
>>  AVR_ISA_LDS
>>  AVR_ISA_RCALL
>>
>> They are mixed in the file 'avr-mcus.def' for family and microcontroller
>> definition. Only looking at the family definition:
>>
>>  AVR_MCU ("avr2",             ARCH_AVR2, AVR_ERRATA_SKIP, NULL,
>>     0x0060, 0x0, 0x60000, 0)
>>  AVR_MCU ("avr25",            ARCH_AVR25, AVR_ISA_NONE, NULL,
>>  0x0060, 0x0, 0x2000, 0)
>>  AVR_MCU ("avr3",             ARCH_AVR3, AVR_ISA_NONE, NULL,
>>  0x0060, 0x0, 0x6000, 0)
>>  AVR_MCU ("avr31",            ARCH_AVR31, AVR_ERRATA_SKIP, NULL,
>>    0x0060, 0x0, 0x20000, 0)
>>  AVR_MCU ("avr35",            ARCH_AVR35, AVR_ISA_NONE, NULL,
>>  0x0100, 0x0, 0x4000, 0)
>>  AVR_MCU ("avr4",             ARCH_AVR4, AVR_ISA_NONE,  NULL,
>>  0x0060, 0x0, 0x2000, 0)
>>  AVR_MCU ("avr5",             ARCH_AVR5, AVR_ISA_NONE, NULL,
>>  0x0060, 0x0, 0x4000, 0)
>>  AVR_MCU ("avr51",            ARCH_AVR51, AVR_ISA_NONE, NULL,
>>  0x0100, 0x0, 0x20000, 0)
>>  AVR_MCU ("avr6",             ARCH_AVR6, AVR_ISA_NONE, NULL,
>>  0x0200, 0x0, 0x40000, 0)
>>  AVR_MCU ("avrxmega2",        ARCH_AVRXMEGA2, AVR_ISA_NONE, NULL,
>>      0x2000, 0x0, 0x9000, 0)
>>  AVR_MCU ("avrxmega3",        ARCH_AVRXMEGA3, AVR_ISA_NONE,  NULL,
>>      0x3f00, 0x0, 0x8000, 0)
>>  AVR_MCU ("avrxmega4",        ARCH_AVRXMEGA4, AVR_ISA_NONE, NULL,
>>      0x2000, 0x0, 0x11000, 0)
>>  AVR_MCU ("avrxmega5",        ARCH_AVRXMEGA5, AVR_ISA_NONE, NULL,
>>      0x2000, 0x0, 0x11000, 0)
>>  AVR_MCU ("avrxmega6",        ARCH_AVRXMEGA6, AVR_ISA_NONE, NULL,
>>          0x2000, 0x0, 0x60000, 0)
>>  AVR_MCU ("avrxmega7",        ARCH_AVRXMEGA7, AVR_ISA_NONE, NULL,
>>          0x2000, 0x0, 0x22000, 0)
>>  AVR_MCU ("avrtiny",          ARCH_AVRTINY, AVR_ISA_NONE, NULL,
>>    0x0040, 0x0, 0x400, 0)
>>  AVR_MCU ("avr1",             ARCH_AVR1, AVR_ISA_NONE, NULL,
>>  0x0060, 0x0, 0x400, 0)
>>
>> I don't really understand how do you get to the proposed family
>> definition for qemu. Probably is my fault but if you can help me to
>> understand will be grate!
>>
>>
> Michal, can you really give us more details on how this mapping is done?
>
> I alredy asked a similar question a while ago, and then you said you used
> wikipedia article + avr datasheets. Can you give us more detailed info of
> the whole process of creating ABRFeature list for a particular AVR core
> type, and how that compares with the corresponding content in gcc, as
> Joakin brought to our attention?
>
> Thanks, Aleksandar
>
>
>
>
>> Regards,
>> --joa
>>
>

--=20
Best Regards,
Michael Rolnik

--000000000000996f44059e33d889
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all.<div><br></div><div>When I decided to implement AVR=
 8 bit CPU support for QEMU I found this <a href=3D"http://ww1.microchip.co=
m/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf">documen=
t</a>=C2=A0which listed all AVR instructions.=C2=A0</div><div>After that I =
learned that there are several CPU flavours, I looked into this GCC <a href=
=3D"https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-device=
s.c">file</a>=C2=A0to figure out what are they as I could not find any offi=
cial document explaining it.</div><div>Then I downloaded=C2=A0several datas=
heets and created a list of instructions by CPU type (attached).It turned o=
ut that there are some variations=C2=A0</div><div>e.g.=C2=A0</div><div>- AV=
TTINY - some have LDS, some don&#39;t</div><div>- AVR1, AVR25 - some have s=
hort SP, some don&#39;t</div><div>- AVRXMEGA2,=C2=A0AVRXMEGA4,=C2=A0AVRXMEG=
A5,=C2=A0AVRXMEGA6,=C2=A0AVRXMEGA7 - some have RMW, some don&#39;t</div><di=
v>-=C2=A0AVRXMEGA3 - some have RCALL, some don&#39;t</div><div><br></div><d=
iv>I decided to leave CPU flavour definition as suggested by GCC <a href=3D=
"https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices.c=
">gcc/config/avr/avr-devices.c</a> file and when a specific MCU is created =
it will set / reset CPU features relevant to it.</div><div><br></div><div>I=
 hope this helps.</div><div><br></div><div>Best Regards,</div><div>Michael =
Rolnik</div><div><br></div><div><br></div><div><br></div><div><br></div><di=
v><br></div><div>=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Mar=
kovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br><br>On Sunday, February 2, 2020, Joaquin de Andres &lt;<a hr=
ef=3D"mailto:me@xcancerberox.com.ar" target=3D"_blank">me@xcancerberox.com.=
ar</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 1=
/31/20 1:02 AM, Aleksandar Markovic wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
From: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_bl=
ank">mrolnik@gmail.com</a>&gt;<br>
<br>
AVR core types are:<br>
<br>
=C2=A0 =C2=A0- avr1<br>
=C2=A0 =C2=A0- avr2<br>
=C2=A0 =C2=A0- avr25<br>
=C2=A0 =C2=A0- avr3<br>
=C2=A0 =C2=A0- avr31<br>
=C2=A0 =C2=A0- avr35<br>
=C2=A0 =C2=A0- avr4<br>
=C2=A0 =C2=A0- avr5<br>
=C2=A0 =C2=A0- avr51<br>
=C2=A0 =C2=A0- avr6<br>
=C2=A0 =C2=A0- avrtiny<br>
=C2=A0 =C2=A0- xmega2<br>
=C2=A0 =C2=A0- xmega3<br>
=C2=A0 =C2=A0- xmega4<br>
=C2=A0 =C2=A0- xmega5<br>
=C2=A0 =C2=A0- xmega6<br>
=C2=A0 =C2=A0- xmega7<br>
<br>
Each core type covers multiple AVR MCUs, mentioned in the comments<br>
before definition of particular AVR core type (part of this patch).<br>
<br>
AVR core type defines shared features that are valid for all AVR<br>
MCUs belonging in that type.<br>
<br>
[AM: Split a larger AVR introduction patch into logical units]<br>
Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@g=
mail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" =
target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" ta=
rget=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=
=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0 target/avr/cpu.c | 601 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++<br>
=C2=A0 1 file changed, 601 insertions(+)<br>
<br>
diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
index f41a887..e0ae055 100644<br>
--- a/target/avr/cpu.c<br>
+++ b/target/avr/cpu.c<br>
@@ -215,3 +215,604 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)<br>
=C2=A0 =C2=A0 =C2=A0 cc-&gt;gdb_num_core_regs =3D 35;<br>
=C2=A0 =C2=A0 =C2=A0 cc-&gt;gdb_core_xml_file =3D &quot;avr-cpu.xml&quot;;<=
br>
=C2=A0 }<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr1<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * at90s1200, attiny11, attiny12, attiny15, attiny28<br>
+ */<br>
+static void avr_avr1_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr2<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at90s44=
14,<br>
+ * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535<br>
+ */<br>
+static void avr_avr2_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr25<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, attiny=
24,<br>
+ * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, attiny=
84a,<br>
+ * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, attiny4=
61a,<br>
+ * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, attiny8=
28,<br>
+ * attiny841, at86rf401<br>
+ */<br>
+static void avr_avr25_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr3<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * at43usb355, at76c711<br>
+ */<br>
+static void avr_avr3_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr31<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atmega103, at43usb320<br>
+ */<br>
+static void avr_avr31_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr35<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atmega1=
6u2,<br>
+ * atmega32u2, attiny167, attiny1634<br>
+ */<br>
+static void avr_avr35_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr4<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, atmeg=
a48a,<br>
+ * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,<br>
+ * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm1,<b=
r>
+ * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81<br>
+ */<br>
+static void avr_avr4_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr5<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831, ata=
6613c,<br>
+ * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega162,<=
br>
+ * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega165a,<=
br>
+ * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega168pa=
,<br>
+ * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega16hv=
b,<br>
+ * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmega323=
,<br>
+ * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega325p,=
<br>
+ * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, atmega=
328,<br>
+ * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega329pa=
,<br>
+ * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atmega3=
2m1,<br>
+ * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, atme=
ga644,<br>
+ * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega645p,=
<br>
+ * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega649p=
,<br>
+ * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, atmega=
6490p,<br>
+ * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,<br>
+ * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, at90p=
wm216,<br>
+ * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000<br>
+ */<br>
+static void avr_avr5_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr51<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega1284p,=
<br>
+ * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb1286,<=
br>
+ * at90usb1287<br>
+ */<br>
+static void avr_avr51_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avr6<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2<br>
+ */<br>
+static void avr_avr6_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type avrtiny<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40<br>
+ */<br>
+static void avr_avrtiny_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega2<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atxmega=
32c3,<br>
+ * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,<br>
+ * atxmega32c4, atxmega32e5<br>
+ */<br>
+static void avr_xmega2_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega3<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, attin=
y814,<br>
+ * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny3214,<b=
r>
+ * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega1609,<b=
r>
+ * atmega3208, atmega3209, atmega4808, atmega4809<br>
+ */<br>
+static void avr_xmega3_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega4<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,<br>
+ * atxmega64b3, atxmega64c3, atxmega64d4<br>
+ */<br>
+static void avr_xmega4_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega5<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atxmega64a1, atxmega64a1u<br>
+ */<br>
+static void avr_xmega5_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPD);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPY);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega6<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a3,<b=
r>
+ * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega128b=
1,<br>
+ * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192c3,<=
br>
+ * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3<br>
+ */<br>
+static void avr_xmega6_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+/*<br>
+ * Setting features of AVR core type xmega7<br>
+ * --------------------------------------<br>
+ *<br>
+ * This type of AVR core is present in the following AVR MCUs:<br>
+ *<br>
+ * atxmega128a1, atxmega128a1u, atxmega128a4u<br>
+ */<br>
+static void avr_xmega7_initfn(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
+=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK);<br>
+<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPD);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPY);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CALL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<br>
+=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<br>
+}<br>
+<br>
+typedef struct AVRCPUInfo {<br>
+=C2=A0 =C2=A0 const char *name;<br>
+=C2=A0 =C2=A0 void (*initfn)(Object *obj);<br>
+} AVRCPUInfo;<br>
+<br>
+<br>
+static void avr_cpu_list_entry(gpointer data, gpointer user_data)<br>
+{<br>
+=C2=A0 =C2=A0 const char *typename =3D object_class_get_name(OBJECT_CLASS(=
data));<br>
+<br>
+=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename);<br>
+}<br>
+<br>
+void avr_cpu_list(void)<br>
+{<br>
+=C2=A0 =C2=A0 GSList *list;<br>
+=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);<=
br>
+=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entry, NULL);<br>
+=C2=A0 =C2=A0 g_slist_free(list);<br>
+}<br>
+<br>
+#define DEFINE_AVR_CPU_TYPE(model, initfn) \<br>
+=C2=A0 =C2=A0 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D AVR_CPU_TYPE_NAME(model), \<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+static const TypeInfo avr_cpu_type_info[] =3D {<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof(AVRCPU),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cpu_initfn,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AVRCPUClass),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_class_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
+=C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avrtiny&quot;, avr_avrtiny_initfn)=
,<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, avr_avr1_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, avr_avr2_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, avr_avr25_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, avr_avr3_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, avr_avr31_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, avr_avr35_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr4&quot;, avr_avr4_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr5&quot;, avr_avr5_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr51&quot;, avr_avr51_initfn),<br=
>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr6&quot;, avr_avr6_initfn),<br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega2&quot;, avr_xmega2_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega3&quot;, avr_xmega3_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega4&quot;, avr_xmega4_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega5&quot;, avr_xmega5_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega6&quot;, avr_xmega6_initfn),<=
br>
+=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega7&quot;, avr_xmega7_initfn),<=
br>
+};<br>
+<br>
+const char *avr_flags_to_cpu_type(uint32_t flags, const char *def_cpu_type=
)<br>
+{<br>
+=C2=A0 =C2=A0 switch (flags &amp; EF_AVR_MACH) {<br>
+=C2=A0 =C2=A0 case bfd_mach_avr1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr1&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avr2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr2&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avr25:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr25&quot;);<b=
r>
+=C2=A0 =C2=A0 case bfd_mach_avr3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr3&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avr31:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr31&quot;);<b=
r>
+=C2=A0 =C2=A0 case bfd_mach_avr35:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr35&quot;);<b=
r>
+=C2=A0 =C2=A0 case bfd_mach_avr4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr4&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avr5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr5&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avr51:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr51&quot;);<b=
r>
+=C2=A0 =C2=A0 case bfd_mach_avr6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avr6&quot;);<br=
>
+=C2=A0 =C2=A0 case bfd_mach_avrtiny:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;avrtiny&quot;);=
<br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega2:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega2&quot;);<=
br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega3:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega3&quot;);<=
br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega4:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega4&quot;);<=
br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega5:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega5&quot;);<=
br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega6&quot;);<=
br>
+=C2=A0 =C2=A0 case bfd_mach_avrxmega7:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(&quot;xmega7&quot;);<=
br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return def_cpu_type;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+DEFINE_TYPES(avr_cpu_type_info)<br>
<br>
</blockquote>
<br>
Hi! me again. Following the RC2 discussion. I&#39;ve being looking in the G=
CC definition of the architecture and as far as I can understand this defin=
itions are the generic definitions of the arch families.<br>
<br>
=C2=A0avr_arch_types[] =3D<br>
=C2=A0{<br>
=C2=A0 =C2=A0/* unknown device specified */<br>
=C2=A0 =C2=A0{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, NULL, AVR_MMCU_DEFAULT },<br>
=C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0A=C2=A0 M=C2=A0 J=C2=A0 LM E=C2=A0 E=C2=A0 E=C2=A0 X=C2=
=A0 R=C2=A0 T=C2=A0 d S=C2=A0 =C2=A0 =C2=A0FPO=C2=A0 =C2=A0 =C2=A0S O=C2=A0=
 =C2=A0A<br>
=C2=A0 =C2=A0 =C2=A0S=C2=A0 U=C2=A0 M=C2=A0 PO L=C2=A0 L=C2=A0 I=C2=A0 M=C2=
=A0 A=C2=A0 I=C2=A0 a t=C2=A0 =C2=A0 =C2=A0lMff=C2=A0 =C2=A0 F ff=C2=A0 r<b=
r>
=C2=A0 =C2=A0 =C2=A0M=C2=A0 L=C2=A0 P=C2=A0 MV P=C2=A0 P=C2=A0 J=C2=A0 E=C2=
=A0 M=C2=A0 N=C2=A0 t a=C2=A0 =C2=A0 =C2=A0a s=C2=A0 =C2=A0 =C2=A0R s=C2=A0=
 =C2=A0c<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 XW M=C2=A0 M=C2=A0 M=C2=A0=
 G=C2=A0 P=C2=A0 Y=C2=A0 a r=C2=A0 =C2=A0 =C2=A0s e=C2=A0 =C2=A0 =C2=A0 =C2=
=A0e=C2=A0 =C2=A0h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 X=C2=
=A0 P=C2=A0 A=C2=A0 D=C2=A0 =C2=A0 =C2=A0 =C2=A0t=C2=A0 =C2=A0 =C2=A0h t=C2=
=A0 =C2=A0 =C2=A0 =C2=A0t=C2=A0 =C2=A0ID=C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;1&quot;,=C2=A0 =C2=A0&quot;avr1&quot;=C2=A0 },<br>
=C2=A0 =C2=A0{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;2&quot;,=C2=A0 =C2=A0&quot;avr2&quot;=C2=A0 },<br>
=C2=A0 =C2=A0{ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;25&quot;,=C2=A0 &quot;avr25&quot; },<br>
=C2=A0 =C2=A0{ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;3&quot;,=C2=A0 =C2=A0&quot;avr3&quot;=C2=A0 },<br>
=C2=A0 =C2=A0{ 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;31&quot;,=C2=A0 &quot;avr31&quot; },<br>
=C2=A0 =C2=A0{ 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;35&quot;,=C2=A0 &quot;avr35&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;4&quot;,=C2=A0 =C2=A0&quot;avr4&quot;=C2=A0 },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;5&quot;,=C2=A0 =C2=A0&quot;avr5&quot;=C2=A0 },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;51&quot;,=C2=A0 &quot;avr51&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,=C2=A0 =C2=A0 =C2=A0=
 32, &quot;6&quot;,=C2=A0 =C2=A0&quot;avr6&quot;=C2=A0 },<br>
<br>
=C2=A0 =C2=A0{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0, &quot;100&q=
uot;, &quot;avrtiny&quot;},<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,=C2=A0 =C2=A0 =C2=A0=
 0, &quot;102&quot;, &quot;avrxmega2&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0, &quot;103&q=
uot;, &quot;avrxmega3&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,=C2=A0 =C2=A0 =C2=A0=
 0, &quot;104&quot;, &quot;avrxmega4&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,=C2=A0 =C2=A0 =C2=A0=
 0, &quot;105&quot;, &quot;avrxmega5&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,=C2=A0 =C2=A0 =C2=A0=
 0, &quot;106&quot;, &quot;avrxmega6&quot; },<br>
=C2=A0 =C2=A0{ 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,=C2=A0 =C2=A0 =C2=A0=
 0, &quot;107&quot;, &quot;avrxmega7&quot;=C2=A0 }<br>
=C2=A0};<br>
<br>
And then you have features for the specific microcontrollers:<br>
<br>
=C2=A0AVR_ISA_RMW<br>
=C2=A0AVR_SHORT_SP<br>
=C2=A0AVR_ERRATA_SKIP<br>
=C2=A0AVR_ISA_LDS<br>
=C2=A0AVR_ISA_RCALL<br>
<br>
They are mixed in the file &#39;avr-mcus.def&#39; for family and microcontr=
oller definition. Only looking at the family definition:<br>
<br>
=C2=A0AVR_MCU (&quot;avr2&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR2, AVR_ERRATA_SKIP, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x0060, 0x0, 0x60000, 0)<br>
=C2=A0AVR_MCU (&quot;avr25&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ARCH_AVR25, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0060, 0x0, 0x2000, 0)<br>
=C2=A0AVR_MCU (&quot;avr3&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR3, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0060, 0x0, 0x6000, 0)<br>
=C2=A0AVR_MCU (&quot;avr31&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ARCH_AVR31, AVR_ERRATA_SKIP, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00x0060, 0x0, 0x20000, 0)<br>
=C2=A0AVR_MCU (&quot;avr35&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ARCH_AVR35, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0100, 0x0, 0x4000, 0)<br>
=C2=A0AVR_MCU (&quot;avr4&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR4, AVR_ISA_NONE,=C2=A0 NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0060, 0x0, 0x2000, 0)<br>
=C2=A0AVR_MCU (&quot;avr5&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR5, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0060, 0x0, 0x4000, 0)<br>
=C2=A0AVR_MCU (&quot;avr51&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ARCH_AVR51, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x0100, 0x0, 0x20000, 0)<br>
=C2=A0AVR_MCU (&quot;avr6&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR6, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0200, 0x0, 0x40000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega2&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA2, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
2000, 0x0, 0x9000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega3&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA3, AVR_ISA_NONE,=C2=A0 NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x3f00, 0x0, 0x8000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega4&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA4, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
2000, 0x0, 0x11000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega5&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA5, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
2000, 0x0, 0x11000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega6&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA6, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x2000, 0x0, 0x60000, 0)<br>
=C2=A0AVR_MCU (&quot;avrxmega7&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_AVRXM=
EGA7, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x2000, 0x0, 0x22000, 0)<br>
=C2=A0AVR_MCU (&quot;avrtiny&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ARCH_=
AVRTINY, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0040, 0x0, 0x400, 0)<br>
=C2=A0AVR_MCU (&quot;avr1&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ARCH_AVR1, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x0060, 0x0, 0x400, 0)<br>
<br>
I don&#39;t really understand how do you get to the proposed family definit=
ion for qemu. Probably is my fault but if you can help me to understand wil=
l be grate!<br>
<br></blockquote><div><br></div><div>Michal, can you really give us more de=
tails on how this mapping is done?</div><div><br></div><div>I alredy asked =
a similar question a while ago, and then you said you used wikipedia articl=
e + avr datasheets. Can you give us more detailed info of the whole process=
 of creating ABRFeature list for a particular AVR core type, and how that c=
ompares with the corresponding content in gcc, as Joakin brought to our att=
ention?</div><div><br></div><div>Thanks, Aleksandar</div><div><br></div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Regards,<br>
--joa<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000996f44059e33d889--

--000000000000996f45059e33d88b
Content-Type: text/markdown; charset="US-ASCII"; name="avr-instructions.md"
Content-Disposition: attachment; filename="avr-instructions.md"
Content-Transfer-Encoding: base64
Content-ID: <f_k6g4xx8e0>
X-Attachment-Id: f_k6g4xx8e0

fCBNQ1UgICB8IERBVEFTSEVFVCBVUkwgICB8CnwtLS0tLS0tfC0tLS0tLS0tLS0tLS0tLS0tfAp8
QUxMCXxodHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL2RldmljZWRvYy9hdG1l
bC0wODU2LWF2ci1pbnN0cnVjdGlvbi1zZXQtbWFudWFsLnBkZgkJCQkJCQkJCQkKfEFWUjEJfGh0
dHA6Ly93dzEubWljcm9jaGlwLmNvbS9kb3dubG9hZHMvZW4vZGV2aWNlZG9jL2RvYzA4MzgucGRm
CQkJCQkJCQkJCQp8QVZSMgl8aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9E
ZXZpY2VEb2MvRE9DMDgzOS5QREYJCQkJCQkJCQkJCnxBVlIyNQl8aHR0cDovL3d3MS5taWNyb2No
aXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvZG9jODM3MS5wZGYJCQkJCQkJCQkJCnxBVlIz
CXwJCQkJCQkJCQkJCnxBVlIzMQl8aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9l
bi9EZXZpY2VEb2MvZG9jMDk0NS5wZGYJCQkJCQkJCQkJCnxBVlIzNQl8aHR0cDovL3d3MS5taWNy
b2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRtZWwtODMwMy04LWJpdC1BVlItTWlj
cm9jb250cm9sbGVyLXRpbnlBVlItQVR0aW55MTYzNF9EYXRhc2hlZXQucGRmCQkJCQkJCQkJCQp8
QVZSNAl8aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRt
ZWwtNzUzMC1BdXRvbW90aXZlLU1pY3JvY29udHJvbGxlcnMtQVRtZWdhNDgtQVRtZWdhODgtQVRt
ZWdhMTY4X0RhdGFzaGVldC5wZGYJCQkJCQkJCQkJCnxBVlI1CXxodHRwOi8vd3cxLm1pY3JvY2hp
cC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9kb2M3NzM0LnBkZgkJCQkJCQkJCQkKfEFWUjUx
CXxodHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9kb2MyNDY3
LnBkZgkJCQkJCQkJCQkKfEFWUjYJfGh0dHBzOi8vY2RuLnNwYXJrZnVuLmNvbS9kYXRhc2hlZXRz
L0NvbXBvbmVudHMvR2VuZXJhbCUyMElDLzI1NDlTLnBkZgkJCQkJCQkJCQkKfFhNRUdBMgl8aHR0
cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRtZWwtODA2OS04
LWFuZC0xNi1iaXQtQVZSLUFNRUdBLUE0LU1pY3JvY29udHJvbGxlcnNfRGF0YXNoZWV0LnBkZgkJ
CQkJCQkJCQkKfFhNRUdBMwl8aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9E
ZXZpY2VEb2MvNDAwMDE5MTFBLnBkZgkJCQkJCQkJCQkKfFhNRUdBNAl8aHR0cDovL3d3MS5taWNy
b2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvQXRtZWwtODA2OC04LWFuZDE2LWJpdC1B
VlItWE1FR0EtQTMtTWljcm9jb250cm9sbGVyc19EYXRhc2hlZXQucGRmCQkJCQkJCQkJCQp8WE1F
R0E1CXxodHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2VuL0RldmljZURvYy9hdG1l
bC04Mzg1LTgtYW5kLTE2LWJpdC1hdnItbWljcm9jb250cm9sbGVyLWF0eG1lZ2E2NGExdS1hdHht
ZWdhMTI4YTF1X2RhdGFzaGVldC5wZGYJCQkJCQkJCQkJCnxYTUVHQTYJfGh0dHA6Ly93dzEubWlj
cm9jaGlwLmNvbS9kb3dubG9hZHMvZW4vRGV2aWNlRG9jL0F0bWVsLTgwNjgtOC1hbmQxNi1iaXQt
QVZSLVhNRUdBLUEzLU1pY3JvY29udHJvbGxlcnNfRGF0YXNoZWV0LnBkZgkJCQkJCQkJCQkKfFhN
RUdBNwl8aHR0cDovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25sb2Fkcy9lbi9EZXZpY2VEb2MvZG9j
ODA3Ny5wZGYJCQkJCQkJCQkJCnxBVlJUSU5ZCXxodHRwOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93
bmxvYWRzL2VuL0RldmljZURvYy9hdG1lbC04MTI3LWF2ci04LWJpdC1taWNyb2NvbnRyb2xsZXIt
YXR0aW55NC1hdHRpbnk1LWF0dGlueTktYXR0aW55MTBfZGF0YXNoZWV0LnBkZgoKLS0tLQoKCnwg
QUxMIHwgQVZSMSB8IEFWUjIgfCBBVlIyNSB8QVZSMyB8IEFWUjMxIHwgQVZSMzUgfCBBVlI0IHwg
QVZSNSB8IEFWUjYgfCBBVlJUSU5ZIHwgWE1FR0EyIHwgWE1BR0EzIHwgWE1BR0E0IHwgWE1BR0E1
IHwgWE1BR0E2IHwgWE1BR0E3IHwKfC0tLXwtLS18LS0tfC0tLXwtLS18LS0tfC0tLXwtLS18LS0t
fC0tLXwtLS18LS0tfC0tLXwtLS18LS0tfC0tLXwtLS18IAp8QURDCXxBREMJfEFEQwl8QURDCXwJ
fEFEQwl8QURDCXxBREMJfEFEQwl8QURDCXxBREMJfEFEQwl8QURDCXxBREMJfEFEQwl8QURDCXxB
REMJfEFEQwp8QURECXxBREQJfEFERAl8QURECXwJfEFERAl8QURECXxBREQJfEFERAl8QURECXxB
REQJfEFERAl8QURECXxBREQJfEFERAl8QURECXxBREQJfEFERAp8QURJVwl8CXxBRElXCXxBRElX
CXwJfEFESVcJfEFESVcJfEFESVcJfEFESVcJfEFESVcJfEFESVcJfAl8QURJVwl8QURJVwl8QURJ
Vwl8QURJVwl8QURJVwl8QURJVwp8QU5ECXxBTkQJfEFORAl8QU5ECXwJfEFORAl8QU5ECXxBTkQJ
fEFORAl8QU5ECXxBTkQJfEFORAl8QU5ECXxBTkQJfEFORAl8QU5ECXxBTkQJfEFORAp8QU5ESQl8
QU5ESQl8QU5ESQl8QU5ESQl8CXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxB
TkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCXxBTkRJCnxBU1IJfEFTUgl8QVNSCXxB
U1IJfAl8QVNSCXxBU1IJfEFTUgl8QVNSCXxBU1IJfEFTUgl8QVNSCXxBU1IJfEFTUgl8QVNSCXxB
U1IJfEFTUgl8QVNSCnxCQ0xSCXxCQ0xSCXxCQ0xSCXxCQ0xSCXwJfEJDTFIJfEJDTFIJfEJDTFIJ
fEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJDTFIJfEJD
TFIKfEJMRAl8QkxECXxCTEQJfEJMRAl8CXxCTEQJfEJMRAl8QkxECXxCTEQJfEJMRAl8QkxECXxC
TEQJfEJMRAl8QkxECXxCTEQJfEJMRAl8QkxECXxCTEQKfEJSQkMJfEJSQkMJfEJSQkMJfEJSQkMJ
fAl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwl8
QlJCQwl8QlJCQwl8QlJCQwl8QlJCQwp8QlJCUwl8QlJCUwl8QlJCUwl8QlJCUwl8CXxCUkJTCXxC
UkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJTCXxCUkJT
CXxCUkJTCXxCUkJTCnxCUkNDCXxCUkNDCXxCUkNDCXxCUkNDCXwJfEJSQ0MJfEJSQ0MJfEJSQ0MJ
fEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJSQ0MJfEJS
Q0MKfEJSQ1MJfEJSQ1MJfEJSQ1MJfEJSQ1MJfAl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJD
Uwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwl8QlJDUwp8QlJFQUsJ
fAl8CXxCUkVBSwl8CXwJfEJSRUFLCXxCUkVBSwl8QlJFQUsJfEJSRUFLCXxCUkVBSwl8QlJFQUsJ
fEJSRUFLCXxCUkVBSwl8QlJFQUsJfEJSRUFLCXxCUkVBSwl8QlJFQUsKfEJSRVEJfEJSRVEJfEJS
RVEJfEJSRVEJfAl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJF
UQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQl8QlJFUQp8QlJHRQl8QlJHRQl8QlJHRQl8QlJHRQl8
CXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxCUkdFCXxC
UkdFCXxCUkdFCXxCUkdFCXxCUkdFCnxCUkhDCXxCUkhDCXxCUkhDCXxCUkhDCXwJfEJSSEMJfEJS
SEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJfEJSSEMJ
fEJSSEMJfEJSSEMKfEJSSFMJfEJSSFMJfEJSSFMJfEJSSFMJfAl8QlJIUwl8QlJIUwl8QlJIUwl8
QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJIUwl8QlJI
Uwp8QlJJRAl8QlJJRAl8QlJJRAl8QlJJRAl8CXxCUklECXxCUklECXxCUklECXxCUklECXxCUklE
CXxCUklECXxCUklECXxCUklECXxCUklECXxCUklECXxCUklECXxCUklECXxCUklECnxCUklFCXxC
UklFCXxCUklFCXxCUklFCXwJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJS
SUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUJfEJSSUUKfEJSTE8JfEJSTE8JfEJSTE8J
fEJSTE8JfAl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8
QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwl8QlJMTwp8QlJMVAl8QlJMVAl8QlJMVAl8QlJMVAl8CXxC
UkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxUCXxCUkxU
CXxCUkxUCXxCUkxUCXxCUkxUCnxCUk1JCXxCUk1JCXxCUk1JCXxCUk1JCXwJfEJSTUkJfEJSTUkJ
fEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJSTUkJfEJS
TUkJfEJSTUkKfEJSTkUJfEJSTkUJfEJSTkUJfEJSTkUJfAl8QlJORQl8QlJORQl8QlJORQl8QlJO
RQl8QlJORQl8QlJORQl8QlJORQl8QlJORQl8QlJORQl8QlJORQl8QlJORQl8QlJORQl8QlJORQp8
QlJQTAl8QlJQTAl8QlJQTAl8QlJQTAl8CXxCUlBMCXxCUlBMCXxCUlBMCXxCUlBMCXxCUlBMCXxC
UlBMCXxCUlBMCXxCUlBMCXwJfEJSUEwJfEJSUEwJfEJSUEwJfEJSUEwKfEJSU0gJfEJSU0gJfEJS
U0gJfEJSU0gJfAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJT
SAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAl8QlJTSAp8QlJUQwl8QlJUQwl8QlJUQwl8QlJUQwl8
CXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxCUlRDCXxC
UlRDCXxCUlRDCXxCUlRDCXxCUlRDCnxCUlRTCXxCUlRTCXxCUlRTCXxCUlRTCXwJfEJSVFMJfEJS
VFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJfEJSVFMJ
fEJSVFMJfEJSVFMKfEJSVkMJfEJSVkMJfEJSVkMJfEJSVkMJfAl8QlJWQwl8QlJWQwl8QlJWQwl8
QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJWQwl8QlJW
Qwp8QlJWUwl8QlJWUwl8QlJWUwl8QlJWUwl8CXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZT
CXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCXxCUlZTCnxCU0VUCXxC
U0VUCXxCU0VUCXxCU0VUCXwJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJT
RVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQJfEJTRVQKfEJTVAl8QlNUCXxCU1QJfEJT
VAl8CXxCU1QJfEJTVAl8QlNUCXxCU1QJfEJTVAl8QlNUCXxCU1QJfEJTVAl8QlNUCXxCU1QJfEJT
VAl8QlNUCXxCU1QKfENBTEwJfAl8CXwJfAl8Q0FMTAl8Q0FMTAl8Q0FMTAl8Q0FMTAl8Q0FMTAl8
Q0FMTAl8CXxDQUxMCXxDQUxMCXxDQUxMCXxDQUxMCXxDQUxMCXxDQUxMCnxDQkkJfENCSQl8Q0JJ
CXxDQkkJfAl8Q0JJCXxDQkkJfENCSQl8Q0JJCXxDQkkJfENCSQl8Q0JJCXxDQkkJfENCSQl8Q0JJ
CXxDQkkJfENCSQl8Q0JJCnxDQlIJfENCUgl8Q0JSCXxDQlIJfAl8Q0JSCXxDQlIJfENCUgl8Q0JS
CXxDQlIJfENCUgl8Q0JSCXxDQlIJfENCUgl8Q0JSCXxDQlIJfENCUgl8Q0JSCnxDTEMJfENMQwl8
Q0xDCXxDTEMJfAl8Q0xDCXxDTEMJfENMQwl8Q0xDCXxDTEMJfENMQwl8Q0xDCXxDTEMJfENMQwl8
Q0xDCXxDTEMJfENMQwl8Q0xDCnxDTEgJfENMSAl8Q0xICXxDTEgJfAl8Q0xICXxDTEgJfENMSAl8
Q0xICXxDTEgJfENMSAl8Q0xICXxDTEgJfENMSAl8Q0xICXxDTEgJfENMSAl8Q0xICnxDTEkJfENM
SQl8Q0xJCXxDTEkJfAl8Q0xJCXxDTEkJfENMSQl8Q0xJCXxDTEkJfENMSQl8Q0xJCXxDTEkJfENM
SQl8Q0xJCXxDTEkJfENMSQl8Q0xJCnxDTE4JfENMTgl8Q0xOCXxDTE4JfAl8Q0xOCXxDTE4JfENM
Tgl8Q0xOCXxDTE4JfENMTgl8Q0xOCXxDTE4JfENMTgl8Q0xOCXxDTE4JfENMTgl8Q0xOCnxDTFIJ
fENMUgl8Q0xSCXxDTFIJfAl8Q0xSCXxDTFIJfENMUgl8Q0xSCXxDTFIJfENMUgl8Q0xSCXxDTFIJ
fENMUgl8Q0xSCXxDTFIJfENMUgl8Q0xSCnxDTFMJfENMUwl8Q0xTCXxDTFMJfAl8Q0xTCXxDTFMJ
fENMUwl8Q0xTCXxDTFMJfENMUwl8Q0xTCXxDTFMJfENMUwl8Q0xTCXxDTFMJfENMUwl8Q0xTCnxD
TFQJfENMVAl8Q0xUCXxDTFQJfAl8Q0xUCXxDTFQJfENMVAl8Q0xUCXxDTFQJfENMVAl8Q0xUCXxD
TFQJfENMVAl8Q0xUCXxDTFQJfENMVAl8Q0xUCnxDTFYJfENMVgl8Q0xWCXxDTFYJfAl8Q0xWCXxD
TFYJfENMVgl8Q0xWCXxDTFYJfENMVgl8Q0xWCXxDTFYJfENMVgl8Q0xWCXxDTFYJfENMVgl8Q0xW
CnxDTFoJfENMWgl8Q0xaCXxDTFoJfAl8Q0xaCXxDTFoJfENMWgl8Q0xaCXxDTFoJfENMWgl8Q0xa
CXxDTFoJfENMWgl8Q0xaCXxDTFoJfENMWgl8Q0xaCnxDT00JfENPTQl8Q09NCXxDT00JfAl8Q09N
CXxDT00JfENPTQl8Q09NCXxDT00JfENPTQl8Q09NCXxDT00JfENPTQl8Q09NCXxDT00JfENPTQl8
Q09NCnxDUAl8Q1AJfENQCXxDUAl8CXxDUAl8Q1AJfENQCXxDUAl8Q1AJfENQCXxDUAl8Q1AJfENQ
CXxDUAl8Q1AJfENQCXxDUAp8Q1BDCXxDUEMJfENQQwl8Q1BDCXwJfENQQwl8Q1BDCXxDUEMJfENQ
Qwl8Q1BDCXxDUEMJfENQQwl8Q1BDCXxDUEMJfENQQwl8Q1BDCXxDUEMJfENQQwp8Q1BJCXxDUEkJ
fENQSQl8Q1BJCXwJfENQSQl8Q1BJCXxDUEkJfENQSQl8Q1BJCXxDUEkJfENQSQl8Q1BJCXxDUEkJ
fENQSQl8Q1BJCXxDUEkJfENQSQp8Q1BTRQl8Q1BTRQl8Q1BTRQl8Q1BTRQl8CXxDUFNFCXxDUFNF
CXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxDUFNFCXxD
UFNFCXxDUFNFCnxERUMJfERFQwl8REVDCXxERUMJfAl8REVDCXxERUMJfERFQwl8REVDCXxERUMJ
fERFQwl8REVDCXxERUMJfERFQwl8REVDCXxERUMJfERFQwl8REVDCnxERVMJfAl8CXwJfAl8CXwJ
fAl8CXwJfAl8CXxERVMJfAl8REVTCXxERVMJfERFUwl8REVTCnxFSUNBTEwJfAl8CXwJfAl8CXwJ
fAl8CXwJfEVJQ0FMTAl8CXxFSUNBTEwJfAl8RUlDQUxMCXxFSUNBTEwJfEVJQ0FMTAl8RUlDQUxM
CnxFSUpNUAl8CXwJfAl8CXwJfAl8CXwJfAl8RUlKTVAJfAl8RUlKTVAJfAl8RUlKTVAJfEVJSk1Q
CXxFSUpNUAl8RUlKTVAKfEVJTkQJfAl8CXwJfAl8CXwJfAl8CXwJfAl8CXxFSU5ECXwJfEVJTkQJ
fEVJTkQJfEVJTkQJfEVJTkQKfEVMUE0JfAl8CXwJfAl8RUxQTQl8CXwJfAl8RUxQTQl8RUxQTQl8
CXxFTFBNCXwJfEVMUE0JfEVMUE0JfEVMUE0JfEVMUE0KfEVPUgl8RU9SCXxFT1IJfEVPUgl8CXxF
T1IJfEVPUgl8RU9SCXxFT1IJfEVPUgl8RU9SCXxFT1IJfEVPUgl8RU9SCXxFT1IJfEVPUgl8RU9S
CXxFT1IKfEZNVUwJfAl8CXwJfAl8CXwJfEZNVUwJfEZNVUwJfEZNVUwJfEZNVUwJfAl8Rk1VTAl8
Rk1VTAl8Rk1VTAl8Rk1VTAl8Rk1VTAl8Rk1VTAp8Rk1VTFMJfAl8CXwJfAl8CXwJfEZNVUxTCXxG
TVVMUwl8Rk1VTFMJfEZNVUxTCXwJfEZNVUxTCXxGTVVMUwl8Rk1VTFMJfEZNVUxTCXxGTVVMUwl8
Rk1VTFMKfEZNVUxTVQl8CXwJfAl8CXwJfAl8Rk1VTFNVCXxGTVVMU1UJfEZNVUxTVQl8Rk1VTFNV
CXwJfEZNVUxTVQl8Rk1VTFNVCXxGTVVMU1UJfEZNVUxTVQl8Rk1VTFNVCXxGTVVMU1UKfElDQUxM
CXwJfElDQUxMCXxJQ0FMTAl8CXxJQ0FMTAl8SUNBTEwJfElDQUxMCXxJQ0FMTAl8SUNBTEwJfElD
QUxMCXxJQ0FMTAl8SUNBTEwJfElDQUxMCXxJQ0FMTAl8SUNBTEwJfElDQUxMCXxJQ0FMTAp8SUpN
UAl8CXxJSk1QCXxJSk1QCXwJfElKTVAJfElKTVAJfElKTVAJfElKTVAJfElKTVAJfElKTVAJfElK
TVAJfElKTVAJfElKTVAJfElKTVAJfElKTVAJfElKTVAJfElKTVAKfElOCXxJTgl8SU4JfElOCXwJ
fElOCXxJTgl8SU4JfElOCXxJTgl8SU4JfElOCXxJTgl8SU4JfElOCXxJTgl8SU4JfElOCnxJTkMJ
fElOQwl8SU5DCXxJTkMJfAl8SU5DCXxJTkMJfElOQwl8SU5DCXxJTkMJfElOQwl8SU5DCXxJTkMJ
fElOQwl8SU5DCXxJTkMJfElOQwl8SU5DCnxKTVAJfAl8CXwJfAl8Sk1QCXxKTVAJfEpNUAl8Sk1Q
CXxKTVAJfEpNUAl8CXxKTVAJfEpNUAl8Sk1QCXxKTVAJfEpNUAl8Sk1QCnxMQUMJfAl8CXwJfAl8
CXwJfAl8CXwJfAl8CXwJfAl8CXxMQUMJfAl8CnxMQVMJfAl8CXwJfAl8CXwJfAl8CXwJfAl8CXwJ
fAl8CXxMQVMJfAl8CnxMQVQJfAl8CXwJfAl8CXwJfAl8CXwJfAl8CXwJfAl8CXxMQVQJfAl8CnxM
RAl8TEQJfExECXxMRAl8CXxMRAl8TEQJfExECXxMRAl8TEQJfExECXxMRAl8TEQJfExECXxMRAl8
TEQJfExECXxMRAp8TERECXwJfExERAl8TERECXwJfExERAl8TERECXxMREQJfExERAl8TERECXxM
REQJfAl8TERECXxMREQJfExERAl8TERECXxMREQJfExERAp8TERJCXxMREkJfExESQl8TERJCXwJ
fExESQl8TERJCXxMREkJfExESQl8TERJCXxMREkJfExESQl8TERJCXxMREkJfExESQl8TERJCXxM
REkJfExESQp8TERTCXwJfExEUwl8TERTCXwJfExEUwl8TERTCXxMRFMJfExEUwl8TERTCXxMRFMJ
fExEUwl8TERTCXxMRFMJfExEUwl8TERTCXxMRFMJfExEUwp8TFBNCXwJfExQTQl8TFBNCXwJfExQ
TQl8TFBNCXxMUE0JfExQTQl8TFBNCXxMUE0JfAl8TFBNCXxMUE0JfExQTQl8TFBNCXxMUE0JfExQ
TQp8TFNMCXxMU0wJfExTTAl8TFNMCXwJfExTTAl8TFNMCXxMU0wJfExTTAl8TFNMCXxMU0wJfExT
TAl8TFNMCXxMU0wJfExTTAl8TFNMCXxMU0wJfExTTAp8TFNSCXxMU1IJfExTUgl8TFNSCXwJfExT
Ugl8TFNSCXxMU1IJfExTUgl8TFNSCXxMU1IJfExTUgl8TFNSCXxMU1IJfExTUgl8TFNSCXxMU1IJ
fExTUgp8TU9WCXxNT1YJfE1PVgl8TU9WCXwJfE1PVgl8TU9WCXxNT1YJfE1PVgl8TU9WCXxNT1YJ
fE1PVgl8TU9WCXxNT1YJfE1PVgl8TU9WCXxNT1YJfE1PVgp8TU9WVwl8CXwJfE1PVlcJfAl8CXxN
T1ZXCXxNT1ZXCXxNT1ZXCXxNT1ZXCXxNT1ZXCXwJfE1PVlcJfE1PVlcJfE1PVlcJfE1PVlcJfE1P
VlcJfE1PVlcKfE1VTAl8CXwJfAl8CXwJfAl8TVVMCXxNVUwJfE1VTAl8TVVMCXwJfE1VTAl8TVVM
CXxNVUwJfE1VTAl8TVVMCXxNVUwKfE1VTFMJfAl8CXwJfAl8CXwJfE1VTFMJfE1VTFMJfE1VTFMJ
fE1VTFMJfAl8TVVMUwl8TVVMUwl8TVVMUwl8TVVMUwl8TVVMUwl8TVVMUwp8TVVMU1UJfAl8CXwJ
fAl8CXwJfE1VTFNVCXxNVUxTVQl8TVVMU1UJfE1VTFNVCXwJfE1VTFNVCXxNVUxTVQl8TVVMU1UJ
fE1VTFNVCXxNVUxTVQl8TVVMU1UKfE5FRwl8TkVHCXxORUcJfE5FRwl8CXxORUcJfE5FRwl8TkVH
CXxORUcJfE5FRwl8TkVHCXxORUcJfE5FRwl8TkVHCXxORUcJfE5FRwl8TkVHCXxORUcKfE5PUAl8
Tk9QCXxOT1AJfE5PUAl8CXxOT1AJfE5PUAl8Tk9QCXxOT1AJfE5PUAl8Tk9QCXxOT1AJfE5PUAl8
Tk9QCXxOT1AJfE5PUAl8Tk9QCXxOT1AKfE9SCXxPUgl8T1IJfE9SCXwJfE9SCXxPUgl8T1IJfE9S
CXxPUgl8T1IJfE9SCXxPUgl8T1IJfE9SCXxPUgl8T1IJfE9SCnxPUkkJfE9SSQl8T1JJCXxPUkkJ
fAl8T1JJCXxPUkkJfE9SSQl8T1JJCXxPUkkJfE9SSQl8T1JJCXxPUkkJfE9SSQl8T1JJCXxPUkkJ
fE9SSQl8T1JJCnxPVVQJfE9VVAl8T1VUCXxPVVQJfAl8T1VUCXxPVVQJfE9VVAl8T1VUCXxPVVQJ
fE9VVAl8T1VUCXxPVVQJfE9VVAl8T1VUCXxPVVQJfE9VVAl8T1VUCnxQT1AJfAl8UE9QCXxQT1AJ
fAl8UE9QCXxQT1AJfFBPUAl8UE9QCXxQT1AJfFBPUAl8UE9QCXxQT1AJfFBPUAl8UE9QCXxQT1AJ
fFBPUAl8UE9QCnxQVVNICXwJfFBVU0gJfFBVU0gJfAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8
UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAl8UFVTSAp8UkNB
TEwJfFJDQUxMCXxSQ0FMTAl8UkNBTEwJfAl8UkNBTEwJfFJDQUxMCXxSQ0FMTAl8UkNBTEwJfFJD
QUxMCXxSQ0FMTAl8UkNBTEwJfFJDQUxMCXxSQ0FMTAl8UkNBTEwJfFJDQUxMCXxSQ0FMTAl8UkNB
TEwKfFJFVAl8UkVUCXxSRVQJfFJFVAl8CXxSRVQJfFJFVAl8UkVUCXxSRVQJfFJFVAl8UkVUCXxS
RVQJfFJFVAl8UkVUCXxSRVQJfFJFVAl8UkVUCXxSRVQKfFJFVEkJfFJFVEkJfFJFVEkJfFJFVEkJ
fAl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQl8
UkVUSQl8UkVUSQl8UkVUSQl8UkVUSQp8UkpNUAl8UkpNUAl8UkpNUAl8UkpNUAl8CXxSSk1QCXxS
Sk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1QCXxSSk1Q
CXxSSk1QCXxSSk1QCnxST0wJfFJPTAl8Uk9MCXxST0wJfAl8Uk9MCXxST0wJfFJPTAl8Uk9MCXxS
T0wJfFJPTAl8Uk9MCXxST0wJfFJPTAl8Uk9MCXxST0wJfFJPTAl8Uk9MCnxST1IJfFJPUgl8Uk9S
CXxST1IJfAl8Uk9SCXxST1IJfFJPUgl8Uk9SCXxST1IJfFJPUgl8Uk9SCXxST1IJfFJPUgl8Uk9S
CXxST1IJfFJPUgl8Uk9SCnxTQkMJfFNCQwl8U0JDCXxTQkMJfAl8U0JDCXxTQkMJfFNCQwl8U0JD
CXxTQkMJfFNCQwl8U0JDCXxTQkMJfFNCQwl8U0JDCXxTQkMJfFNCQwl8U0JDCnxTQkNJCXxTQkNJ
CXxTQkNJCXxTQkNJCXwJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJ
fFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kJfFNCQ0kKfFNCSQl8U0JJCXxTQkkJfFNCSQl8
CXxTQkkJfFNCSQl8U0JJCXxTQkkJfFNCSQl8U0JJCXxTQkkJfFNCSQl8U0JJCXxTQkkJfFNCSQl8
U0JJCXxTQkkKfFNCSUMJfFNCSUMJfFNCSUMJfFNCSUMJfAl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJ
Qwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwl8U0JJQwp8
U0JJUwl8U0JJUwl8U0JJUwl8U0JJUwl8CXxTQklTCXxTQklTCXxTQklTCXxTQklTCXxTQklTCXxT
QklTCXxTQklTCXxTQklTCXxTQklTCXxTQklTCXxTQklTCXxTQklTCXxTQklTCnxTQklXCXwJfFNC
SVcJfFNCSVcJfAl8U0JJVwl8U0JJVwl8U0JJVwl8U0JJVwl8U0JJVwl8U0JJVwl8CXxTQklXCXxT
QklXCXxTQklXCXxTQklXCXxTQklXCXxTQklXCnxTQlIJfFNCUgl8U0JSCXxTQlIJfAl8U0JSCXxT
QlIJfFNCUgl8U0JSCXxTQlIJfFNCUgl8U0JSCXxTQlIJfFNCUgl8U0JSCXxTQlIJfFNCUgl8U0JS
CnxTQlJDCXxTQlJDCXxTQlJDCXxTQlJDCXwJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJ
fFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMJfFNCUkMKfFNCUlMJfFNC
UlMJfFNCUlMJfFNCUlMJfAl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JS
Uwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwl8U0JSUwp8U0VDCXxTRUMJfFNFQwl8U0VD
CXwJfFNFQwl8U0VDCXxTRUMJfFNFQwl8U0VDCXxTRUMJfFNFQwl8U0VDCXxTRUMJfFNFQwl8U0VD
CXxTRUMJfFNFQwp8U0VICXxTRUgJfFNFSAl8U0VICXwJfFNFSAl8U0VICXxTRUgJfFNFSAl8U0VI
CXxTRUgJfFNFSAl8U0VICXxTRUgJfFNFSAl8U0VICXxTRUgJfFNFSAp8U0VJCXxTRUkJfFNFSQl8
U0VJCXwJfFNFSQl8U0VJCXxTRUkJfFNFSQl8U0VJCXxTRUkJfFNFSQl8U0VJCXxTRUkJfFNFSQl8
U0VJCXxTRUkJfFNFSQp8U0VOCXxTRU4JfFNFTgl8U0VOCXwJfFNFTgl8U0VOCXxTRU4JfFNFTgl8
U0VOCXxTRU4JfFNFTgl8U0VOCXxTRU4JfFNFTgl8U0VOCXxTRU4JfFNFTgp8U0VSCXxTRVIJfFNF
Ugl8U0VSCXwJfFNFUgl8U0VSCXxTRVIJfFNFUgl8U0VSCXxTRVIJfFNFUgl8U0VSCXxTRVIJfFNF
Ugl8U0VSCXxTRVIJfFNFUgp8U0VTCXxTRVMJfFNFUwl8U0VTCXwJfFNFUwl8U0VTCXxTRVMJfFNF
Uwl8U0VTCXxTRVMJfFNFUwl8U0VTCXxTRVMJfFNFUwl8U0VTCXxTRVMJfFNFUwp8U0VUCXxTRVQJ
fFNFVAl8U0VUCXwJfFNFVAl8U0VUCXxTRVQJfFNFVAl8U0VUCXxTRVQJfFNFVAl8U0VUCXxTRVQJ
fFNFVAl8U0VUCXxTRVQJfFNFVAp8U0VWCXxTRVYJfFNFVgl8U0VWCXwJfFNFVgl8U0VWCXxTRVYJ
fFNFVgl8U0VWCXxTRVYJfFNFVgl8U0VWCXxTRVYJfFNFVgl8U0VWCXxTRVYJfFNFVgp8U0VaCXxT
RVoJfFNFWgl8U0VaCXwJfFNFWgl8U0VaCXxTRVoJfFNFWgl8U0VaCXxTRVoJfFNFWgl8U0VaCXxT
RVoJfFNFWgl8U0VaCXxTRVoJfFNFWgp8U0xFRVAJfFNMRUVQCXxTTEVFUAl8U0xFRVAJfAl8U0xF
RVAJfFNMRUVQCXxTTEVFUAl8U0xFRVAJfFNMRUVQCXxTTEVFUAl8U0xFRVAJfFNMRUVQCXxTTEVF
UAl8U0xFRVAJfFNMRUVQCXxTTEVFUAl8U0xFRVAKfFNQTQl8CXwJfFNQTQl8CXwJfFNQTQl8U1BN
CXxTUE0JfFNQTQl8U1BNCXwJfFNQTQl8CXxTUE0JfFNQTQl8U1BNCXxTUE0KfFNUCXxTVAl8U1QJ
fFNUCXwJfFNUCXxTVAl8U1QJfFNUCXxTVAl8U1QJfFNUCXxTVAl8U1QJfFNUCXxTVAl8U1QJfFNU
CnxTVEQJfAl8U1RECXxTVEQJfAl8U1RECXxTVEQJfFNURAl8U1RECXxTVEQJfFNURAl8CXxTVEQJ
fFNURAl8U1RECXxTVEQJfFNURAl8U1RECnxTVFMJfAl8U1RTCXxTVFMJfAl8U1RTCXxTVFMJfFNU
Uwl8U1RTCXxTVFMJfFNUUwl8U1RTCXxTVFMJfFNUUwl8U1RTCXxTVFMJfFNUUwl8U1RTCnxTVUIJ
fFNVQgl8U1VCCXxTVUIJfAl8U1VCCXxTVUIJfFNVQgl8U1VCCXxTVUIJfFNVQgl8U1VCCXxTVUIJ
fFNVQgl8U1VCCXxTVUIJfFNVQgl8U1VCCnxTVUJJCXxTVUJJCXxTVUJJCXxTVUJJCXwJfFNVQkkJ
fFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNVQkkJfFNV
QkkJfFNVQkkJfFNVQkkKfFNXQVAJfFNXQVAJfFNXQVAJfFNXQVAJfAl8U1dBUAl8U1dBUAl8U1dB
UAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8U1dBUAl8
U1dBUAp8VFNUCXxUU1QJfFRTVAl8VFNUCXwJfFRTVAl8VFNUCXxUU1QJfFRTVAl8VFNUCXxUU1QJ
fFRTVAl8VFNUCXxUU1QJfFRTVAl8VFNUCXxUU1QJfFRTVAp8V0RSCXxXRFIJfFdEUgl8V0RSCXwJ
fFdEUgl8V0RSCXxXRFIJfFdEUgl8V0RSCXxXRFIJfFdEUgl8V0RSCXxXRFIJfFdEUgl8V0RSCXxX
RFIJfFdEUgp8WENICXwJfAl8CXwJfAl8CXwJfAl8CXwJfAl8CXwJfAl8WENICXwJfAo=
--000000000000996f45059e33d88b--

