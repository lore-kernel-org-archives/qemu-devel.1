Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26872C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F562073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6pd8hSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F562073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j567z-0004G4-W2
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1j566X-0002zB-D9
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1j566Q-0002CF-SB
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:04:21 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1j566Q-0002Br-Jp
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:04:14 -0500
Received: by mail-qk1-x741.google.com with SMTP id a141so1417612qkg.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WgFjg120TbKoWTRMyH907089rV70kRMmk6I9qmhD2fw=;
 b=K6pd8hSUfMTMyWWqv/JZvEj93h15HwLfQzq+fdmmXvjeqzRWbeLJgXX7R7/9ZUFADA
 vpJ+tYMGJgqw3ThPI+IJ533j9s2CS/Pc6xaJtaEqX3Kv2sG6HBRpNRAEkOMtvs8qDBfs
 +a3Q8FcDUqceztdCcEJxbKoWP8mVpH2Y/sPX+rBu+ur42hd7wNC1ohlLSsnoWRsLXj+B
 XQTA8/Gnr2GZRR/K130UEnSoMgu9zW97oz7p/LpEtD0fszwVcbQVgYgZlp4WjxojjQtN
 54hMg5DHJXrauwndmwGy9y8FnpdrNQgoZ2ujS7aAELGa9kcBYKFSy4rEsMCTMc8DFdka
 n0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WgFjg120TbKoWTRMyH907089rV70kRMmk6I9qmhD2fw=;
 b=N6QQo8TkKYsWolO2Z11eNOUAPbW+4qaRGFJicjdPMQtIDpwrH/aG6TUYUe0xIIJl2s
 v+sxa5tMFOSNsIZXMf3kbc4414BX4MFouk/0MvjOq0K1MMwxXS2O4RRn5UyyXENka6qY
 0fbfISKMq4nlzSeolgRTkLTfnaietVdmcuO/r1/kv4wvtRf0h/+5Y3k1RApxjXF+nG8w
 5eqqEssqcGxel3uEIzmAajWSEm4zObtx5dinlxCDA86cZWldsx2hYfuJ7hkjlaOouU8Z
 e7CwgeSFHTT1ZaUGUcBdkBG46z+pGm1wIywS39E8vWf4qzViM5VXWwuGfVnkGrLGHSVV
 DFQA==
X-Gm-Message-State: APjAAAUcVFX4dVFmM1/QBc1YAWpDGD+mXrgCFdniWJ+2XXiy4xb5V9AS
 n4K45L16HNg1bhw2QRFP5V+aOxw2lh+GvR5EuS0=
X-Google-Smtp-Source: APXvYqyUBnh0tPbWD05iwVrlFx5gCWiGUCFX14Jl7El8A+m0rRaD8j8Vv+grEbqtQEOkKi128tXaHgmMyiTT36r8AnE=
X-Received: by 2002:a37:6e87:: with SMTP id j129mr358059qkc.79.1582283053549; 
 Fri, 21 Feb 2020 03:04:13 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <87aab645-8ffb-dc0d-9d8d-bfeb4281821d@xcancerberox.com.ar>
 <CAL1e-=h9QVVPuNG+PO3TyT981XPXopmng9vn367LjaQjy64nHA@mail.gmail.com>
 <CAK4993h7GaKiSt5LNrEtvRhCDE3tsMyNh-t6551-eZjx39sq7w@mail.gmail.com>
In-Reply-To: <CAK4993h7GaKiSt5LNrEtvRhCDE3tsMyNh-t6551-eZjx39sq7w@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 21 Feb 2020 13:03:28 +0200
Message-ID: <CAK4993gOJz8F1DYsc08x46XcyUFbrs3-u8FTL7aJ0NdDS1keLw@mail.gmail.com>
Subject: Re: [PATCH rc4 06/29] target/avr: Add defintions of AVR core types
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000574f6c059f13fb14"
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000574f6c059f13fb14
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

How is it going?

Regards,
Michael.

On Mon, Feb 10, 2020 at 9:39 AM Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi all.
>
> When I decided to implement AVR 8 bit CPU support for QEMU I found this
> document
> <http://ww1.microchip.com/downloads/en/devicedoc/atmel-0856-avr-instructi=
on-set-manual.pdf> which
> listed all AVR instructions.
> After that I learned that there are several CPU flavours, I looked into
> this GCC file
> <https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices=
.c> to
> figure out what are they as I could not find any official document
> explaining it.
> Then I downloaded several datasheets and created a list of instructions b=
y
> CPU type (attached).It turned out that there are some variations
> e.g.
> - AVTTINY - some have LDS, some don't
> - AVR1, AVR25 - some have short SP, some don't
> - AVRXMEGA2, AVRXMEGA4, AVRXMEGA5, AVRXMEGA6, AVRXMEGA7 - some have RMW,
> some don't
> - AVRXMEGA3 - some have RCALL, some don't
>
> I decided to leave CPU flavour definition as suggested by GCC
> gcc/config/avr/avr-devices.c
> <https://github.com/gcc-mirror/gcc/blob/master/gcc/config/avr/avr-devices=
.c>
> file and when a specific MCU is created it will set / reset CPU features
> relevant to it.
>
> I hope this helps.
>
> Best Regards,
> Michael Rolnik
>
>
>
>
>
>
>
> On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Sunday, February 2, 2020, Joaquin de Andres <me@xcancerberox.com.ar>
>> wrote:
>>
>>> On 1/31/20 1:02 AM, Aleksandar Markovic wrote:
>>>
>>>> From: Michael Rolnik <mrolnik@gmail.com>
>>>>
>>>> AVR core types are:
>>>>
>>>>    - avr1
>>>>    - avr2
>>>>    - avr25
>>>>    - avr3
>>>>    - avr31
>>>>    - avr35
>>>>    - avr4
>>>>    - avr5
>>>>    - avr51
>>>>    - avr6
>>>>    - avrtiny
>>>>    - xmega2
>>>>    - xmega3
>>>>    - xmega4
>>>>    - xmega5
>>>>    - xmega6
>>>>    - xmega7
>>>>
>>>> Each core type covers multiple AVR MCUs, mentioned in the comments
>>>> before definition of particular AVR core type (part of this patch).
>>>>
>>>> AVR core type defines shared features that are valid for all AVR
>>>> MCUs belonging in that type.
>>>>
>>>> [AM: Split a larger AVR introduction patch into logical units]
>>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>>
>>>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>> ---
>>>>   target/avr/cpu.c | 601
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 601 insertions(+)
>>>>
>>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>>>> index f41a887..e0ae055 100644
>>>> --- a/target/avr/cpu.c
>>>> +++ b/target/avr/cpu.c
>>>> @@ -215,3 +215,604 @@ static void avr_cpu_class_init(ObjectClass *oc,
>>>> void *data)
>>>>       cc->gdb_num_core_regs =3D 35;
>>>>       cc->gdb_core_xml_file =3D "avr-cpu.xml";
>>>>   }
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr1
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * at90s1200, attiny11, attiny12, attiny15, attiny28
>>>> + */
>>>> +static void avr_avr1_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr2
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26,
>>>> at90s4414,
>>>> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>>>> + */
>>>> +static void avr_avr2_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr25
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a,
>>>> attiny24,
>>>> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84,
>>>> attiny84a,
>>>> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461,
>>>> attiny461a,
>>>> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88,
>>>> attiny828,
>>>> + * attiny841, at86rf401
>>>> + */
>>>> +static void avr_avr25_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr3
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * at43usb355, at76c711
>>>> + */
>>>> +static void avr_avr3_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr31
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atmega103, at43usb320
>>>> + */
>>>> +static void avr_avr31_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr35
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2,
>>>> atmega16u2,
>>>> + * atmega32u2, attiny167, attiny1634
>>>> + */
>>>> +static void avr_avr35_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr4
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48,
>>>> atmega48a,
>>>> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
>>>> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva,
>>>> at90pwm1,
>>>> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
>>>> + */
>>>> +static void avr_avr4_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr5
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831=
,
>>>> ata6613c,
>>>> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
>>>> atmega162,
>>>> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
>>>> atmega165a,
>>>> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
>>>> atmega168pa,
>>>> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
>>>> atmega16hvb,
>>>> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
>>>> atmega323,
>>>> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
>>>> atmega325p,
>>>> + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa,
>>>> atmega328,
>>>> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
>>>> atmega329pa,
>>>> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1,
>>>> atmega32m1,
>>>> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640,
>>>> atmega644,
>>>> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
>>>> atmega645p,
>>>> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
>>>> atmega649p,
>>>> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a,
>>>> atmega6490p,
>>>> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
>>>> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161,
>>>> at90pwm216,
>>>> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
>>>> + */
>>>> +static void avr_avr5_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr51
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
>>>> atmega1284p,
>>>> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
>>>> at90usb1286,
>>>> + * at90usb1287
>>>> + */
>>>> +static void avr_avr51_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avr6
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
>>>> + */
>>>> +static void avr_avr6_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type avrtiny
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>>>> + */
>>>> +static void avr_avrtiny_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega2
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4,
>>>> atxmega32c3,
>>>> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
>>>> + * atxmega32c4, atxmega32e5
>>>> + */
>>>> +static void avr_xmega2_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega3
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417,
>>>> attiny814,
>>>> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617,
>>>> attiny3214,
>>>> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608,
>>>> atmega1609,
>>>> + * atmega3208, atmega3209, atmega4808, atmega4809
>>>> + */
>>>> +static void avr_xmega3_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega4
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
>>>> + * atxmega64b3, atxmega64c3, atxmega64d4
>>>> + */
>>>> +static void avr_xmega4_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega5
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atxmega64a1, atxmega64a1u
>>>> + */
>>>> +static void avr_xmega5_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega6
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3,
>>>> atxmega256a3,
>>>> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
>>>> atxmega128b1,
>>>> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
>>>> atxmega192c3,
>>>> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
>>>> + */
>>>> +static void avr_xmega6_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Setting features of AVR core type xmega7
>>>> + * --------------------------------------
>>>> + *
>>>> + * This type of AVR core is present in the following AVR MCUs:
>>>> + *
>>>> + * atxmega128a1, atxmega128a1u, atxmega128a4u
>>>> + */
>>>> +static void avr_xmega7_initfn(Object *obj)
>>>> +{
>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>>>> +    CPUAVRState *env =3D &cpu->env;
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>>>> +
>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>>>> +}
>>>> +
>>>> +typedef struct AVRCPUInfo {
>>>> +    const char *name;
>>>> +    void (*initfn)(Object *obj);
>>>> +} AVRCPUInfo;
>>>> +
>>>> +
>>>> +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
>>>> +{
>>>> +    const char *typename =3D object_class_get_name(OBJECT_CLASS(data)=
);
>>>> +
>>>> +    qemu_printf("%s\n", typename);
>>>> +}
>>>> +
>>>> +void avr_cpu_list(void)
>>>> +{
>>>> +    GSList *list;
>>>> +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
>>>> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
>>>> +    g_slist_free(list);
>>>> +}
>>>> +
>>>> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
>>>> +    { \
>>>> +        .parent =3D TYPE_AVR_CPU, \
>>>> +        .instance_init =3D initfn, \
>>>> +        .name =3D AVR_CPU_TYPE_NAME(model), \
>>>> +    }
>>>> +
>>>> +static const TypeInfo avr_cpu_type_info[] =3D {
>>>> +    {
>>>> +        .name =3D TYPE_AVR_CPU,
>>>> +        .parent =3D TYPE_CPU,
>>>> +        .instance_size =3D sizeof(AVRCPU),
>>>> +        .instance_init =3D avr_cpu_initfn,
>>>> +        .class_size =3D sizeof(AVRCPUClass),
>>>> +        .class_init =3D avr_cpu_class_init,
>>>> +        .abstract =3D true,
>>>> +    },
>>>> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
>>>> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
>>>> +};
>>>> +
>>>> +const char *avr_flags_to_cpu_type(uint32_t flags, const char
>>>> *def_cpu_type)
>>>> +{
>>>> +    switch (flags & EF_AVR_MACH) {
>>>> +    case bfd_mach_avr1:
>>>> +        return AVR_CPU_TYPE_NAME("avr1");
>>>> +    case bfd_mach_avr2:
>>>> +        return AVR_CPU_TYPE_NAME("avr2");
>>>> +    case bfd_mach_avr25:
>>>> +        return AVR_CPU_TYPE_NAME("avr25");
>>>> +    case bfd_mach_avr3:
>>>> +        return AVR_CPU_TYPE_NAME("avr3");
>>>> +    case bfd_mach_avr31:
>>>> +        return AVR_CPU_TYPE_NAME("avr31");
>>>> +    case bfd_mach_avr35:
>>>> +        return AVR_CPU_TYPE_NAME("avr35");
>>>> +    case bfd_mach_avr4:
>>>> +        return AVR_CPU_TYPE_NAME("avr4");
>>>> +    case bfd_mach_avr5:
>>>> +        return AVR_CPU_TYPE_NAME("avr5");
>>>> +    case bfd_mach_avr51:
>>>> +        return AVR_CPU_TYPE_NAME("avr51");
>>>> +    case bfd_mach_avr6:
>>>> +        return AVR_CPU_TYPE_NAME("avr6");
>>>> +    case bfd_mach_avrtiny:
>>>> +        return AVR_CPU_TYPE_NAME("avrtiny");
>>>> +    case bfd_mach_avrxmega2:
>>>> +        return AVR_CPU_TYPE_NAME("xmega2");
>>>> +    case bfd_mach_avrxmega3:
>>>> +        return AVR_CPU_TYPE_NAME("xmega3");
>>>> +    case bfd_mach_avrxmega4:
>>>> +        return AVR_CPU_TYPE_NAME("xmega4");
>>>> +    case bfd_mach_avrxmega5:
>>>> +        return AVR_CPU_TYPE_NAME("xmega5");
>>>> +    case bfd_mach_avrxmega6:
>>>> +        return AVR_CPU_TYPE_NAME("xmega6");
>>>> +    case bfd_mach_avrxmega7:
>>>> +        return AVR_CPU_TYPE_NAME("xmega7");
>>>> +    default:
>>>> +        return def_cpu_type;
>>>> +    }
>>>> +}
>>>> +
>>>> +DEFINE_TYPES(avr_cpu_type_info)
>>>>
>>>>
>>> Hi! me again. Following the RC2 discussion. I've being looking in the
>>> GCC definition of the architecture and as far as I can understand this
>>> definitions are the generic definitions of the arch families.
>>>
>>>  avr_arch_types[] =3D
>>>  {
>>>    /* unknown device specified */
>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, NULL,
>>> AVR_MMCU_DEFAULT },
>>>    /*
>>>      A  M  J  LM E  E  E  X  R  T  d S     FPO     S O   A
>>>      S  U  M  PO L  L  I  M  A  I  a t     lMff    F ff  r
>>>      M  L  P  MV P  P  J  E  M  N  t a     a s     R s   c
>>>               XW M  M  M  G  P  Y  a r     s e       e   h
>>>                     X  P  A  D       t     h t       t   ID   */
>>>    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "1",   "avr1"  }=
,
>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "2",   "avr2"  }=
,
>>>    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "25",  "avr25" }=
,
>>>    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "3",   "avr3"  }=
,
>>>    { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,      32, "31",  "avr31" }=
,
>>>    { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "35",  "avr35" }=
,
>>>    { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "4",   "avr4"  }=
,
>>>    { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "5",   "avr5"  }=
,
>>>    { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,      32, "51",  "avr51" }=
,
>>>    { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,      32, "6",   "avr6"  }=
,
>>>
>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0, "100", "avrtiny"}=
,
>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,      0, "102", "avrxmega2=
"
>>> },
>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0, "103", "avrxmega3=
"
>>> },
>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,      0, "104", "avrxmega4=
"
>>> },
>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,      0, "105", "avrxmega5=
"
>>> },
>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,      0, "106", "avrxmega6=
"
>>> },
>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,      0, "107",
>>> "avrxmega7"  }
>>>  };
>>>
>>> And then you have features for the specific microcontrollers:
>>>
>>>  AVR_ISA_RMW
>>>  AVR_SHORT_SP
>>>  AVR_ERRATA_SKIP
>>>  AVR_ISA_LDS
>>>  AVR_ISA_RCALL
>>>
>>> They are mixed in the file 'avr-mcus.def' for family and microcontrolle=
r
>>> definition. Only looking at the family definition:
>>>
>>>  AVR_MCU ("avr2",             ARCH_AVR2, AVR_ERRATA_SKIP, NULL,
>>>     0x0060, 0x0, 0x60000, 0)
>>>  AVR_MCU ("avr25",            ARCH_AVR25, AVR_ISA_NONE, NULL,
>>>  0x0060, 0x0, 0x2000, 0)
>>>  AVR_MCU ("avr3",             ARCH_AVR3, AVR_ISA_NONE, NULL,
>>>  0x0060, 0x0, 0x6000, 0)
>>>  AVR_MCU ("avr31",            ARCH_AVR31, AVR_ERRATA_SKIP, NULL,
>>>      0x0060, 0x0, 0x20000, 0)
>>>  AVR_MCU ("avr35",            ARCH_AVR35, AVR_ISA_NONE, NULL,
>>>  0x0100, 0x0, 0x4000, 0)
>>>  AVR_MCU ("avr4",             ARCH_AVR4, AVR_ISA_NONE,  NULL,
>>>  0x0060, 0x0, 0x2000, 0)
>>>  AVR_MCU ("avr5",             ARCH_AVR5, AVR_ISA_NONE, NULL,
>>>  0x0060, 0x0, 0x4000, 0)
>>>  AVR_MCU ("avr51",            ARCH_AVR51, AVR_ISA_NONE, NULL,
>>>  0x0100, 0x0, 0x20000, 0)
>>>  AVR_MCU ("avr6",             ARCH_AVR6, AVR_ISA_NONE, NULL,
>>>  0x0200, 0x0, 0x40000, 0)
>>>  AVR_MCU ("avrxmega2",        ARCH_AVRXMEGA2, AVR_ISA_NONE, NULL,
>>>      0x2000, 0x0, 0x9000, 0)
>>>  AVR_MCU ("avrxmega3",        ARCH_AVRXMEGA3, AVR_ISA_NONE,  NULL,
>>>        0x3f00, 0x0, 0x8000, 0)
>>>  AVR_MCU ("avrxmega4",        ARCH_AVRXMEGA4, AVR_ISA_NONE, NULL,
>>>      0x2000, 0x0, 0x11000, 0)
>>>  AVR_MCU ("avrxmega5",        ARCH_AVRXMEGA5, AVR_ISA_NONE, NULL,
>>>      0x2000, 0x0, 0x11000, 0)
>>>  AVR_MCU ("avrxmega6",        ARCH_AVRXMEGA6, AVR_ISA_NONE, NULL,
>>>          0x2000, 0x0, 0x60000, 0)
>>>  AVR_MCU ("avrxmega7",        ARCH_AVRXMEGA7, AVR_ISA_NONE, NULL,
>>>          0x2000, 0x0, 0x22000, 0)
>>>  AVR_MCU ("avrtiny",          ARCH_AVRTINY, AVR_ISA_NONE, NULL,
>>>    0x0040, 0x0, 0x400, 0)
>>>  AVR_MCU ("avr1",             ARCH_AVR1, AVR_ISA_NONE, NULL,
>>>  0x0060, 0x0, 0x400, 0)
>>>
>>> I don't really understand how do you get to the proposed family
>>> definition for qemu. Probably is my fault but if you can help me to
>>> understand will be grate!
>>>
>>>
>> Michal, can you really give us more details on how this mapping is done?
>>
>> I alredy asked a similar question a while ago, and then you said you use=
d
>> wikipedia article + avr datasheets. Can you give us more detailed info o=
f
>> the whole process of creating ABRFeature list for a particular AVR core
>> type, and how that compares with the corresponding content in gcc, as
>> Joakin brought to our attention?
>>
>> Thanks, Aleksandar
>>
>>
>>
>>
>>> Regards,
>>> --joa
>>>
>>
>
> --
> Best Regards,
> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--000000000000574f6c059f13fb14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all.<div><br></div><div>How is it going?</div><div><br>=
</div><div>Regards,</div><div>Michael.</div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 10, 2020 at 9:39 AM=
 Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">Hi all.<div><br></div><div>When I decided to implement AVR =
8 bit CPU support for QEMU I found this <a href=3D"http://ww1.microchip.com=
/downloads/en/devicedoc/atmel-0856-avr-instruction-set-manual.pdf" target=
=3D"_blank">document</a>=C2=A0which listed all AVR instructions.=C2=A0</div=
><div>After that I learned that there are several CPU flavours, I looked in=
to this GCC <a href=3D"https://github.com/gcc-mirror/gcc/blob/master/gcc/co=
nfig/avr/avr-devices.c" target=3D"_blank">file</a>=C2=A0to figure out what =
are they as I could not find any official document explaining it.</div><div=
>Then I downloaded=C2=A0several datasheets and created a list of instructio=
ns by CPU type (attached).It turned out that there are some variations=C2=
=A0</div><div>e.g.=C2=A0</div><div>- AVTTINY - some have LDS, some don&#39;=
t</div><div>- AVR1, AVR25 - some have short SP, some don&#39;t</div><div>- =
AVRXMEGA2,=C2=A0AVRXMEGA4,=C2=A0AVRXMEGA5,=C2=A0AVRXMEGA6,=C2=A0AVRXMEGA7 -=
 some have RMW, some don&#39;t</div><div>-=C2=A0AVRXMEGA3 - some have RCALL=
, some don&#39;t</div><div><br></div><div>I decided to leave CPU flavour de=
finition as suggested by GCC <a href=3D"https://github.com/gcc-mirror/gcc/b=
lob/master/gcc/config/avr/avr-devices.c" target=3D"_blank">gcc/config/avr/a=
vr-devices.c</a> file and when a specific MCU is created it will set / rese=
t CPU features relevant to it.</div><div><br></div><div>I hope this helps.<=
/div><div><br></div><div>Best Regards,</div><div>Michael Rolnik</div><div><=
br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic &lt;<a href=
=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
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
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--000000000000574f6c059f13fb14--

