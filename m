Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB99C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4F22072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKziXG9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4F22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADAQ-00033z-3N
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1jAD8l-0000wR-B9
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1jAD8e-0007Hz-8y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:35:47 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:36367)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1jAD8d-00072A-Rm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:35:40 -0500
Received: by mail-qk1-x732.google.com with SMTP id u25so2282231qkk.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UmLpcyxalf9FYZwvz66KQsDqxDVbQXxXtxLlo6NoA3s=;
 b=nKziXG9/cjkkC1YAUj1kHBIZlQ+sV3LnjrsrEDDhNSNE9pH+VgQT4KSRU+hwhcy+s1
 4xhnzKe7ikD2TtTeDdEDAnKO5d8mx4u2EPA+Ldt0tg85obYm5vHYuK3CQvTJVSqaioXo
 Vcdk8qVjh+o81gLMQ/DDMFprfHWjXkNur8MmhC9PqpGFR9ULjhVz42+MxLCVUYOQODv/
 YD14x4m6R7eaJllbyywLcYEh8iJHwVzqHiracDj0ERSWCfjIsNA39PtgAB/Q3NB8ZC/m
 ftildnYYbCR5PgMv3QJz7vYwZ5KbzuvHJpFZokx9Gbqi9uzfUIOTiwfKykGTWLmC/CaI
 qjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UmLpcyxalf9FYZwvz66KQsDqxDVbQXxXtxLlo6NoA3s=;
 b=CeknLl7iNBK7Lh7YdPVj5rVBomp7kF9GaJcuLyAgO62Glmz0theOj0fozasm/xJnug
 kUoGtI+wUL5BuSjYQuZahNJ/SG65E48NpRrXOp8MVHryzskcfFa0OTD0rqERWWfcS89B
 w+3tz0WrBO90XBWokTB4gu3Py8JRqnRdm+gyGQ3wzbg/P249jbKfEw+iOTdpN5l7EhNw
 chV8rUasiCovXubef/GC3DSbPvd962NJIn1DYrmHzOmLFUKPwpNew6g2/lE8eErk4wU6
 3ouJjbMtXPitGJV1/7asne394zhCQW/h3OUGPwQENNfOifBYwgh0M/Jr1BnYXNOd0F8O
 zrrw==
X-Gm-Message-State: ANhLgQ0fFb58N17or5Mb5nR/cPgdlxO8faKj+vuxwRP0QIs6q/mDJGDF
 aUZ97lNwDzKuOm4uWNTT6peSnVXLdf6/qyIrurM=
X-Google-Smtp-Source: ADFU+vsAtsvFutOe7aVxjOXBFc4FCmpZYsmyzCWsPQXyHQLCubh6JUNE6CEvRhve1u3gFdKgGPWR4BCoSBtDMlhAG/c=
X-Received: by 2002:a37:ef04:: with SMTP id j4mr2922379qkk.68.1583501738282;
 Fri, 06 Mar 2020 05:35:38 -0800 (PST)
MIME-Version: 1.0
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <87aab645-8ffb-dc0d-9d8d-bfeb4281821d@xcancerberox.com.ar>
 <CAL1e-=h9QVVPuNG+PO3TyT981XPXopmng9vn367LjaQjy64nHA@mail.gmail.com>
 <CAK4993h7GaKiSt5LNrEtvRhCDE3tsMyNh-t6551-eZjx39sq7w@mail.gmail.com>
 <CAK4993gOJz8F1DYsc08x46XcyUFbrs3-u8FTL7aJ0NdDS1keLw@mail.gmail.com>
 <CAL1e-=jEqfYWEf_XA=23RSH8wae-3Li2ADYgiyk0sBAP+0Lrmg@mail.gmail.com>
 <CAK4993iskF4Dqu38qABBkm4BLyWBRXqx-POe4C=PzevOQeT2kw@mail.gmail.com>
In-Reply-To: <CAK4993iskF4Dqu38qABBkm4BLyWBRXqx-POe4C=PzevOQeT2kw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 6 Mar 2020 15:34:53 +0200
Message-ID: <CAK4993gHzg2WGcsD6nrrsLAz9Qe4tbWOw_Z3hxzkmkWMsMCDbQ@mail.gmail.com>
Subject: Re: [PATCH rc4 06/29] target/avr: Add defintions of AVR core types
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009c917505a02fba53"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::732
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

--0000000000009c917505a02fba53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

are there any action items for me?

Regards,
Michael Rolnik

On Thu, Feb 27, 2020 at 10:38 AM Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi all.
>
> I don't see how the fact that some MCUs have an instruction and some don'=
t
> within same AVR family.
> Think about gnu binutils (not GCC) these utils have no idea about MCUs al=
l
> they are aware of AVR CPU only.
> However, I don't mind removing -cpu flag.
>
> Regards,
> Michael Ronik
>
> On Fri, Feb 21, 2020 at 5:31 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>> On Fri, Feb 21, 2020 at 12:04 PM Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>> >
>> > Hi all.
>> >
>> > How is it going?
>> >
>> > Regards,
>> > Michael.
>> >
>>
>> Michael,
>>
>> I think we are very close to merging.
>>
>> There is absolutely no need to support ALL AVR mcus or AVR core types
>> in the first version that will be merged.
>>
>> But this issue (recently discovered during Jaoquin's review) about the
>> fact that an avr core type doesn't determine in a complete way the
>> instruction set of a particular MCU is thorny.
>>
>> Should we switch from "-cpu <avr core type>" to "-cpu <mcu>" (but keep
>> the current avr core type organization for internal purpose)? Or
>> something else?
>>
>> This is a high-level AVR suppot design issue. Let's think about it
>> without a rush.
>>
>> The problem is that once one organization/meaning of that switch is
>> upstreamed, it is very difficult to switch to other. There is a
>> procedural rule that deprecation process lasts at least 8 months, plus
>> there may be some technical obstacles and difficulties.
>>
>> In short, "-cpu <avr core type>" is not enough to emulate accurately a
>> givem program.
>>
>> Regards,
>> Aleksandar
>>
>> > On Mon, Feb 10, 2020 at 9:39 AM Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>> >>
>> >> Hi all.
>> >>
>> >> When I decided to implement AVR 8 bit CPU support for QEMU I found
>> this document which listed all AVR instructions.
>> >> After that I learned that there are several CPU flavours, I looked
>> into this GCC file to figure out what are they as I could not find any
>> official document explaining it.
>> >> Then I downloaded several datasheets and created a list of
>> instructions by CPU type (attached).It turned out that there are some
>> variations
>> >> e.g.
>> >> - AVTTINY - some have LDS, some don't
>> >> - AVR1, AVR25 - some have short SP, some don't
>> >> - AVRXMEGA2, AVRXMEGA4, AVRXMEGA5, AVRXMEGA6, AVRXMEGA7 - some have
>> RMW, some don't
>> >> - AVRXMEGA3 - some have RCALL, some don't
>> >>
>> >> I decided to leave CPU flavour definition as suggested by GCC
>> gcc/config/avr/avr-devices.c file and when a specific MCU is created it
>> will set / reset CPU features relevant to it.
>> >>
>> >> I hope this helps.
>> >>
>> >> Best Regards,
>> >> Michael Rolnik
>> >>
>> >>
>> >>
>> >>
>> >>
>> >>
>> >>
>> >> On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic <
>> aleksandar.m.mail@gmail.com> wrote:
>> >>>
>> >>>
>> >>>
>> >>> On Sunday, February 2, 2020, Joaquin de Andres <
>> me@xcancerberox.com.ar> wrote:
>> >>>>
>> >>>> On 1/31/20 1:02 AM, Aleksandar Markovic wrote:
>> >>>>>
>> >>>>> From: Michael Rolnik <mrolnik@gmail.com>
>> >>>>>
>> >>>>> AVR core types are:
>> >>>>>
>> >>>>>    - avr1
>> >>>>>    - avr2
>> >>>>>    - avr25
>> >>>>>    - avr3
>> >>>>>    - avr31
>> >>>>>    - avr35
>> >>>>>    - avr4
>> >>>>>    - avr5
>> >>>>>    - avr51
>> >>>>>    - avr6
>> >>>>>    - avrtiny
>> >>>>>    - xmega2
>> >>>>>    - xmega3
>> >>>>>    - xmega4
>> >>>>>    - xmega5
>> >>>>>    - xmega6
>> >>>>>    - xmega7
>> >>>>>
>> >>>>> Each core type covers multiple AVR MCUs, mentioned in the comments
>> >>>>> before definition of particular AVR core type (part of this patch)=
.
>> >>>>>
>> >>>>> AVR core type defines shared features that are valid for all AVR
>> >>>>> MCUs belonging in that type.
>> >>>>>
>> >>>>> [AM: Split a larger AVR introduction patch into logical units]
>> >>>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> >>>>>
>> >>>>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>> >>>>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> >>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> >>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>> >>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> >>>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>> >>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> >>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> >>>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>> >>>>> ---
>> >>>>>   target/avr/cpu.c | 601
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>> >>>>>   1 file changed, 601 insertions(+)
>> >>>>>
>> >>>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>> >>>>> index f41a887..e0ae055 100644
>> >>>>> --- a/target/avr/cpu.c
>> >>>>> +++ b/target/avr/cpu.c
>> >>>>> @@ -215,3 +215,604 @@ static void avr_cpu_class_init(ObjectClass
>> *oc, void *data)
>> >>>>>       cc->gdb_num_core_regs =3D 35;
>> >>>>>       cc->gdb_core_xml_file =3D "avr-cpu.xml";
>> >>>>>   }
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr1
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * at90s1200, attiny11, attiny12, attiny15, attiny28
>> >>>>> + */
>> >>>>> +static void avr_avr1_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr2
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26=
,
>> at90s4414,
>> >>>>> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>> >>>>> + */
>> >>>>> +static void avr_avr2_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr25
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313,
>> attiny2313a, attiny24,
>> >>>>> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441,
>> attiny84, attiny84a,
>> >>>>> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461=
,
>> attiny461a,
>> >>>>> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88=
,
>> attiny828,
>> >>>>> + * attiny841, at86rf401
>> >>>>> + */
>> >>>>> +static void avr_avr25_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr3
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * at43usb355, at76c711
>> >>>>> + */
>> >>>>> +static void avr_avr3_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr31
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atmega103, at43usb320
>> >>>>> + */
>> >>>>> +static void avr_avr31_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr35
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2=
,
>> atmega16u2,
>> >>>>> + * atmega32u2, attiny167, attiny1634
>> >>>>> + */
>> >>>>> +static void avr_avr35_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr4
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a,
>> atmega48, atmega48a,
>> >>>>> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a,
>> atmega88p,
>> >>>>> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva,
>> at90pwm1,
>> >>>>> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
>> >>>>> + */
>> >>>>> +static void avr_avr4_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr5
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795,
>> ata5831, ata6613c,
>> >>>>> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161,
>> atmega162,
>> >>>>> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165,
>> atmega165a,
>> >>>>> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p,
>> atmega168pa,
>> >>>>> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa,
>> atmega16hvb,
>> >>>>> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32,
>> atmega323,
>> >>>>> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a,
>> atmega325p,
>> >>>>> + * atmega325pa, atmega3250, atmega3250a, atmega3250p,
>> atmega3250pa, atmega328,
>> >>>>> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p,
>> atmega329pa,
>> >>>>> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1=
,
>> atmega32m1,
>> >>>>> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a,
>> atmega640, atmega644,
>> >>>>> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a,
>> atmega645p,
>> >>>>> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a,
>> atmega649p,
>> >>>>> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb,
>> atmega6490a, atmega6490p,
>> >>>>> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr=
2,
>> >>>>> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64,
>> at90pwm161, at90pwm216,
>> >>>>> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
>> >>>>> + */
>> >>>>> +static void avr_avr5_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr51
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284,
>> atmega1284p,
>> >>>>> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128,
>> at90usb1286,
>> >>>>> + * at90usb1287
>> >>>>> + */
>> >>>>> +static void avr_avr51_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avr6
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
>> >>>>> + */
>> >>>>> +static void avr_avr6_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type avrtiny
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>> >>>>> + */
>> >>>>> +static void avr_avrtiny_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega2
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4=
,
>> atxmega32c3,
>> >>>>> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4,
>> atxmega32a4u,
>> >>>>> + * atxmega32c4, atxmega32e5
>> >>>>> + */
>> >>>>> +static void avr_xmega2_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega3
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * attiny212, attiny214, attiny412, attiny414, attiny416,
>> attiny417, attiny814,
>> >>>>> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617,
>> attiny3214,
>> >>>>> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608,
>> atmega1609,
>> >>>>> + * atmega3208, atmega3209, atmega4808, atmega4809
>> >>>>> + */
>> >>>>> +static void avr_xmega3_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega4
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u,
>> atxmega64b1,
>> >>>>> + * atxmega64b3, atxmega64c3, atxmega64d4
>> >>>>> + */
>> >>>>> +static void avr_xmega4_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega5
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atxmega64a1, atxmega64a1u
>> >>>>> + */
>> >>>>> +static void avr_xmega5_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega6
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3,
>> atxmega256a3,
>> >>>>> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u,
>> atxmega128b1,
>> >>>>> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u,
>> atxmega192c3,
>> >>>>> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
>> >>>>> + */
>> >>>>> +static void avr_xmega6_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +/*
>> >>>>> + * Setting features of AVR core type xmega7
>> >>>>> + * --------------------------------------
>> >>>>> + *
>> >>>>> + * This type of AVR core is present in the following AVR MCUs:
>> >>>>> + *
>> >>>>> + * atxmega128a1, atxmega128a1u, atxmega128a4u
>> >>>>> + */
>> >>>>> +static void avr_xmega7_initfn(Object *obj)
>> >>>>> +{
>> >>>>> +    AVRCPU *cpu =3D AVR_CPU(obj);
>> >>>>> +    CPUAVRState *env =3D &cpu->env;
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>> >>>>> +
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>> >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>> >>>>> +}
>> >>>>> +
>> >>>>> +typedef struct AVRCPUInfo {
>> >>>>> +    const char *name;
>> >>>>> +    void (*initfn)(Object *obj);
>> >>>>> +} AVRCPUInfo;
>> >>>>> +
>> >>>>> +
>> >>>>> +static void avr_cpu_list_entry(gpointer data, gpointer user_data)
>> >>>>> +{
>> >>>>> +    const char *typename =3D
>> object_class_get_name(OBJECT_CLASS(data));
>> >>>>> +
>> >>>>> +    qemu_printf("%s\n", typename);
>> >>>>> +}
>> >>>>> +
>> >>>>> +void avr_cpu_list(void)
>> >>>>> +{
>> >>>>> +    GSList *list;
>> >>>>> +    list =3D object_class_get_list_sorted(TYPE_AVR_CPU, false);
>> >>>>> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
>> >>>>> +    g_slist_free(list);
>> >>>>> +}
>> >>>>> +
>> >>>>> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
>> >>>>> +    { \
>> >>>>> +        .parent =3D TYPE_AVR_CPU, \
>> >>>>> +        .instance_init =3D initfn, \
>> >>>>> +        .name =3D AVR_CPU_TYPE_NAME(model), \
>> >>>>> +    }
>> >>>>> +
>> >>>>> +static const TypeInfo avr_cpu_type_info[] =3D {
>> >>>>> +    {
>> >>>>> +        .name =3D TYPE_AVR_CPU,
>> >>>>> +        .parent =3D TYPE_CPU,
>> >>>>> +        .instance_size =3D sizeof(AVRCPU),
>> >>>>> +        .instance_init =3D avr_cpu_initfn,
>> >>>>> +        .class_size =3D sizeof(AVRCPUClass),
>> >>>>> +        .class_init =3D avr_cpu_class_init,
>> >>>>> +        .abstract =3D true,
>> >>>>> +    },
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
>> >>>>> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
>> >>>>> +};
>> >>>>> +
>> >>>>> +const char *avr_flags_to_cpu_type(uint32_t flags, const char
>> *def_cpu_type)
>> >>>>> +{
>> >>>>> +    switch (flags & EF_AVR_MACH) {
>> >>>>> +    case bfd_mach_avr1:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr1");
>> >>>>> +    case bfd_mach_avr2:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr2");
>> >>>>> +    case bfd_mach_avr25:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr25");
>> >>>>> +    case bfd_mach_avr3:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr3");
>> >>>>> +    case bfd_mach_avr31:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr31");
>> >>>>> +    case bfd_mach_avr35:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr35");
>> >>>>> +    case bfd_mach_avr4:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr4");
>> >>>>> +    case bfd_mach_avr5:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr5");
>> >>>>> +    case bfd_mach_avr51:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr51");
>> >>>>> +    case bfd_mach_avr6:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avr6");
>> >>>>> +    case bfd_mach_avrtiny:
>> >>>>> +        return AVR_CPU_TYPE_NAME("avrtiny");
>> >>>>> +    case bfd_mach_avrxmega2:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega2");
>> >>>>> +    case bfd_mach_avrxmega3:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega3");
>> >>>>> +    case bfd_mach_avrxmega4:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega4");
>> >>>>> +    case bfd_mach_avrxmega5:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega5");
>> >>>>> +    case bfd_mach_avrxmega6:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega6");
>> >>>>> +    case bfd_mach_avrxmega7:
>> >>>>> +        return AVR_CPU_TYPE_NAME("xmega7");
>> >>>>> +    default:
>> >>>>> +        return def_cpu_type;
>> >>>>> +    }
>> >>>>> +}
>> >>>>> +
>> >>>>> +DEFINE_TYPES(avr_cpu_type_info)
>> >>>>>
>> >>>>
>> >>>> Hi! me again. Following the RC2 discussion. I've being looking in
>> the GCC definition of the architecture and as far as I can understand th=
is
>> definitions are the generic definitions of the arch families.
>> >>>>
>> >>>>  avr_arch_types[] =3D
>> >>>>  {
>> >>>>    /* unknown device specified */
>> >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, NULL,
>> AVR_MMCU_DEFAULT },
>> >>>>    /*
>> >>>>      A  M  J  LM E  E  E  X  R  T  d S     FPO     S O   A
>> >>>>      S  U  M  PO L  L  I  M  A  I  a t     lMff    F ff  r
>> >>>>      M  L  P  MV P  P  J  E  M  N  t a     a s     R s   c
>> >>>>               XW M  M  M  G  P  Y  a r     s e       e   h
>> >>>>                     X  P  A  D       t     h t       t   ID   */
>> >>>>    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "1",
>>  "avr1"  },
>> >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "2",
>>  "avr2"  },
>> >>>>    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "25",
>> "avr25" },
>> >>>>    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "3",
>>  "avr3"  },
>> >>>>    { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,      32, "31",
>> "avr31" },
>> >>>>    { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "35",
>> "avr35" },
>> >>>>    { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "4",
>>  "avr4"  },
>> >>>>    { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32, "5",
>>  "avr5"  },
>> >>>>    { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,      32, "51",
>> "avr51" },
>> >>>>    { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,      32, "6",
>>  "avr6"  },
>> >>>>
>> >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0, "100",
>> "avrtiny"},
>> >>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,      0, "102",
>> "avrxmega2" },
>> >>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0, "103",
>> "avrxmega3" },
>> >>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,      0, "104",
>> "avrxmega4" },
>> >>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,      0, "105",
>> "avrxmega5" },
>> >>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,      0, "106",
>> "avrxmega6" },
>> >>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,      0, "107",
>> "avrxmega7"  }
>> >>>>  };
>> >>>>
>> >>>> And then you have features for the specific microcontrollers:
>> >>>>
>> >>>>  AVR_ISA_RMW
>> >>>>  AVR_SHORT_SP
>> >>>>  AVR_ERRATA_SKIP
>> >>>>  AVR_ISA_LDS
>> >>>>  AVR_ISA_RCALL
>> >>>>
>> >>>> They are mixed in the file 'avr-mcus.def' for family and
>> microcontroller definition. Only looking at the family definition:
>> >>>>
>> >>>>  AVR_MCU ("avr2",             ARCH_AVR2, AVR_ERRATA_SKIP, NULL,
>>         0x0060, 0x0, 0x60000, 0)
>> >>>>  AVR_MCU ("avr25",            ARCH_AVR25, AVR_ISA_NONE, NULL,
>>      0x0060, 0x0, 0x2000, 0)
>> >>>>  AVR_MCU ("avr3",             ARCH_AVR3, AVR_ISA_NONE, NULL,
>>      0x0060, 0x0, 0x6000, 0)
>> >>>>  AVR_MCU ("avr31",            ARCH_AVR31, AVR_ERRATA_SKIP, NULL,
>>          0x0060, 0x0, 0x20000, 0)
>> >>>>  AVR_MCU ("avr35",            ARCH_AVR35, AVR_ISA_NONE, NULL,
>>      0x0100, 0x0, 0x4000, 0)
>> >>>>  AVR_MCU ("avr4",             ARCH_AVR4, AVR_ISA_NONE,  NULL,
>>      0x0060, 0x0, 0x2000, 0)
>> >>>>  AVR_MCU ("avr5",             ARCH_AVR5, AVR_ISA_NONE, NULL,
>>      0x0060, 0x0, 0x4000, 0)
>> >>>>  AVR_MCU ("avr51",            ARCH_AVR51, AVR_ISA_NONE, NULL,
>>      0x0100, 0x0, 0x20000, 0)
>> >>>>  AVR_MCU ("avr6",             ARCH_AVR6, AVR_ISA_NONE, NULL,
>>      0x0200, 0x0, 0x40000, 0)
>> >>>>  AVR_MCU ("avrxmega2",        ARCH_AVRXMEGA2, AVR_ISA_NONE, NULL,
>>          0x2000, 0x0, 0x9000, 0)
>> >>>>  AVR_MCU ("avrxmega3",        ARCH_AVRXMEGA3, AVR_ISA_NONE,  NULL,
>>            0x3f00, 0x0, 0x8000, 0)
>> >>>>  AVR_MCU ("avrxmega4",        ARCH_AVRXMEGA4, AVR_ISA_NONE, NULL,
>>          0x2000, 0x0, 0x11000, 0)
>> >>>>  AVR_MCU ("avrxmega5",        ARCH_AVRXMEGA5, AVR_ISA_NONE, NULL,
>>          0x2000, 0x0, 0x11000, 0)
>> >>>>  AVR_MCU ("avrxmega6",        ARCH_AVRXMEGA6, AVR_ISA_NONE, NULL,
>>              0x2000, 0x0, 0x60000, 0)
>> >>>>  AVR_MCU ("avrxmega7",        ARCH_AVRXMEGA7, AVR_ISA_NONE, NULL,
>>              0x2000, 0x0, 0x22000, 0)
>> >>>>  AVR_MCU ("avrtiny",          ARCH_AVRTINY, AVR_ISA_NONE, NULL,
>>        0x0040, 0x0, 0x400, 0)
>> >>>>  AVR_MCU ("avr1",             ARCH_AVR1, AVR_ISA_NONE, NULL,
>>      0x0060, 0x0, 0x400, 0)
>> >>>>
>> >>>> I don't really understand how do you get to the proposed family
>> definition for qemu. Probably is my fault but if you can help me to
>> understand will be grate!
>> >>>>
>> >>>
>> >>> Michal, can you really give us more details on how this mapping is
>> done?
>> >>>
>> >>> I alredy asked a similar question a while ago, and then you said you
>> used wikipedia article + avr datasheets. Can you give us more detailed i=
nfo
>> of the whole process of creating ABRFeature list for a particular AVR co=
re
>> type, and how that compares with the corresponding content in gcc, as
>> Joakin brought to our attention?
>> >>>
>> >>> Thanks, Aleksandar
>> >>>
>> >>>
>> >>>
>> >>>>
>> >>>> Regards,
>> >>>> --joa
>> >>
>> >>
>> >>
>> >> --
>> >> Best Regards,
>> >> Michael Rolnik
>> >
>> >
>> >
>> > --
>> > Best Regards,
>> > Michael Rolnik
>>
>
>
> --
> Best Regards,
> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--0000000000009c917505a02fba53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all.<div><br></div><div>are there any action items for =
me?</div><div><br></div><div>Regards,</div><div>Michael Rolnik</div></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 Feb 27, 2020 at 10:38 AM Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmai=
l.com">mrolnik@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div dir=3D"ltr">Hi all.<div><br></div><div>I don&#=
39;t see how the fact that some MCUs have an instruction and some don&#39;t=
 within same AVR family.</div><div>Think about gnu binutils (not GCC) these=
 utils have no idea about MCUs all they are aware of AVR CPU only.</div><di=
v>However, I don&#39;t mind removing -cpu flag.</div><div><br></div><div>Re=
gards,</div><div>Michael Ronik</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 21, 2020 at 5:31 PM Aleksan=
dar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_=
blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">On Fri, Feb 21, 2020 at 12:04 PM Michael =
Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@g=
mail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi all.<br>
&gt;<br>
&gt; How is it going?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Michael.<br>
&gt;<br>
<br>
Michael,<br>
<br>
I think we are very close to merging.<br>
<br>
There is absolutely no need to support ALL AVR mcus or AVR core types<br>
in the first version that will be merged.<br>
<br>
But this issue (recently discovered during Jaoquin&#39;s review) about the<=
br>
fact that an avr core type doesn&#39;t determine in a complete way the<br>
instruction set of a particular MCU is thorny.<br>
<br>
Should we switch from &quot;-cpu &lt;avr core type&gt;&quot; to &quot;-cpu =
&lt;mcu&gt;&quot; (but keep<br>
the current avr core type organization for internal purpose)? Or<br>
something else?<br>
<br>
This is a high-level AVR suppot design issue. Let&#39;s think about it<br>
without a rush.<br>
<br>
The problem is that once one organization/meaning of that switch is<br>
upstreamed, it is very difficult to switch to other. There is a<br>
procedural rule that deprecation process lasts at least 8 months, plus<br>
there may be some technical obstacles and difficulties.<br>
<br>
In short, &quot;-cpu &lt;avr core type&gt;&quot; is not enough to emulate a=
ccurately a<br>
givem program.<br>
<br>
Regards,<br>
Aleksandar<br>
<br>
&gt; On Mon, Feb 10, 2020 at 9:39 AM Michael Rolnik &lt;<a href=3D"mailto:m=
rolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi all.<br>
&gt;&gt;<br>
&gt;&gt; When I decided to implement AVR 8 bit CPU support for QEMU I found=
 this document which listed all AVR instructions.<br>
&gt;&gt; After that I learned that there are several CPU flavours, I looked=
 into this GCC file to figure out what are they as I could not find any off=
icial document explaining it.<br>
&gt;&gt; Then I downloaded several datasheets and created a list of instruc=
tions by CPU type (attached).It turned out that there are some variations<b=
r>
&gt;&gt; e.g.<br>
&gt;&gt; - AVTTINY - some have LDS, some don&#39;t<br>
&gt;&gt; - AVR1, AVR25 - some have short SP, some don&#39;t<br>
&gt;&gt; - AVRXMEGA2, AVRXMEGA4, AVRXMEGA5, AVRXMEGA6, AVRXMEGA7 - some hav=
e RMW, some don&#39;t<br>
&gt;&gt; - AVRXMEGA3 - some have RCALL, some don&#39;t<br>
&gt;&gt;<br>
&gt;&gt; I decided to leave CPU flavour definition as suggested by GCC gcc/=
config/avr/avr-devices.c file and when a specific MCU is created it will se=
t / reset CPU features relevant to it.<br>
&gt;&gt;<br>
&gt;&gt; I hope this helps.<br>
&gt;&gt;<br>
&gt;&gt; Best Regards,<br>
&gt;&gt; Michael Rolnik<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic &lt;<a href=3D"=
mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gma=
il.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Sunday, February 2, 2020, Joaquin de Andres &lt;<a href=3D"=
mailto:me@xcancerberox.com.ar" target=3D"_blank">me@xcancerberox.com.ar</a>=
&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 1/31/20 1:02 AM, Aleksandar Markovic wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; From: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gma=
il.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; AVR core types are:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr1<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr2<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr25<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr3<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr31<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr35<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr4<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr5<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr51<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avr6<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - avrtiny<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega2<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega3<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega4<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega5<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega6<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 - xmega7<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Each core type covers multiple AVR MCUs, mentioned in =
the comments<br>
&gt;&gt;&gt;&gt;&gt; before definition of particular AVR core type (part of=
 this patch).<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; AVR core type defines shared features that are valid f=
or all AVR<br>
&gt;&gt;&gt;&gt;&gt; MCUs belonging in that type.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; [AM: Split a larger AVR introduction patch into logica=
l units]<br>
&gt;&gt;&gt;&gt;&gt; Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.co=
m</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.=
E.Harris@kent.ac.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mr=
olnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.=
Harris@kent.ac.uk" target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mr=
olnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo=
@redhat.com" target=3D"_blank">imammedo@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto=
:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.o=
rg</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mail=
to:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.c=
om</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0target/avr/cpu.c | 601 +++++++++++++++++++=
++++++++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 601 insertions(+)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; index f41a887..e0ae055 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -215,3 +215,604 @@ static void avr_cpu_class_init(O=
bjectClass *oc, void *data)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;gdb_num_core_regs =3D=
 35;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cc-&gt;gdb_core_xml_file =3D=
 &quot;avr-cpu.xml&quot;;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr1<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * at90s1200, attiny11, attiny12, attiny15, attiny28<=
br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr1_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr2<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * at90s2313, at90s2323, at90s2333, at90s2343, attiny=
22, attiny26, at90s4414,<br>
&gt;&gt;&gt;&gt;&gt; + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8=
535<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr2_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr25<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * ata5272, ata6616c, attiny13, attiny13a, attiny2313=
, attiny2313a, attiny24,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny24a, attiny4313, attiny44, attiny44a, attiny=
441, attiny84, attiny84a,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny25, attiny45, attiny85, attiny261, attiny261=
a, attiny461, attiny461a,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny861, attiny861a, attiny43u, attiny87, attiny=
48, attiny88, attiny828,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny841, at86rf401<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr25_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr3<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * at43usb355, at76c711<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr3_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr31<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atmega103, at43usb320<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr31_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr35<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * ata5505, ata6617c, ata664251, at90usb82, at90usb16=
2, atmega8u2, atmega16u2,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega32u2, attiny167, attiny1634<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr35_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr4<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * ata6285, ata6286, ata6289, ata6612c, atmega8, atme=
ga8a, atmega48, atmega48a,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega48p, atmega48pa, atmega48pb, atmega88, atmeg=
a88a, atmega88p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega88pa, atmega88pb, atmega8515, atmega8535, at=
mega8hva, at90pwm1,<br>
&gt;&gt;&gt;&gt;&gt; + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm8=
1<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr4_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr5<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, =
ata5795, ata5831, ata6613c,<br>
&gt;&gt;&gt;&gt;&gt; + * ata6614q, ata8210, ata8510, atmega16, atmega16a, a=
tmega161, atmega162,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega163, atmega164a, atmega164p, atmega164pa, at=
mega165, atmega165a,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega165p, atmega165pa, atmega168, atmega168a, at=
mega168p, atmega168pa,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega168pb, atmega169, atmega169a, atmega169p, at=
mega169pa, atmega16hvb,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a=
, atmega32, atmega323,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega324a, atmega324p, atmega324pa, atmega325, at=
mega325a, atmega325p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega325pa, atmega3250, atmega3250a, atmega3250p,=
 atmega3250pa, atmega328,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega328p, atmega328pb, atmega329, atmega329a, at=
mega329p, atmega329pa,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega3290, atmega3290a, atmega3290p, atmega3290pa=
, atmega32c1, atmega32m1,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega32u4, atmega32u6, atmega406, atmega64, atmeg=
a64a, atmega640, atmega644,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega644a, atmega644p, atmega644pa, atmega645, at=
mega645a, atmega645p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega6450, atmega6450a, atmega6450p, atmega649, a=
tmega649a, atmega649p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb=
, atmega6490a, atmega6490p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2,=
 atmega64rfr2,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can=
64, at90pwm161, at90pwm216,<br>
&gt;&gt;&gt;&gt;&gt; + * at90pwm316, at90scr100, at90usb646, at90usb647, at=
94k, m3000<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr5_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr51<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atmega128, atmega128a, atmega1280, atmega1281, atm=
ega1284, atmega1284p,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90=
can128, at90usb1286,<br>
&gt;&gt;&gt;&gt;&gt; + * at90usb1287<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr51_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avr6<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atmega2560, atmega2561, atmega256rfr2, atmega2564r=
fr2<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avr6_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_=
EICALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type avrtiny<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * attiny4, attiny5, attiny9, attiny10, attiny20, att=
iny40<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_avrtiny_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_1_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega2<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5,=
 atxmega32a4, atxmega32c3,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c=
4, atxmega32a4u,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega32c4, atxmega32e5<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega2_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega3<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * attiny212, attiny214, attiny412, attiny414, attiny=
416, attiny417, attiny814,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny816, attiny817, attiny1614, attiny1616, atti=
ny1617, attiny3214,<br>
&gt;&gt;&gt;&gt;&gt; + * attiny3216, attiny3217, atmega808, atmega809, atme=
ga1608, atmega1609,<br>
&gt;&gt;&gt;&gt;&gt; + * atmega3208, atmega3209, atmega4808, atmega4809<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega3_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega4<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a=
4u, atxmega64b1,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega64b3, atxmega64c3, atxmega64d4<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega4_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega5<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega64a1, atxmega64a1u<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega5_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPD)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPY)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega6<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega1=
92d3, atxmega256a3,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxme=
ga128a3u, atxmega128b1,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega1=
92a3u, atxmega192c3,<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega=
384d3<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega6_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_=
EICALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * Setting features of AVR core type xmega7<br>
&gt;&gt;&gt;&gt;&gt; + * --------------------------------------<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This type of AVR core is present in the following =
AVR MCUs:<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * atxmega128a1, atxmega128a1u, atxmega128a4u<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_xmega7_initfn(Object *obj)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 AVRCPU *cpu =3D AVR_CPU(obj);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 CPUAVRState *env =3D &amp;cpu-&gt;env;<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPM);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_IJMP_I=
CALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ADIW_S=
BIW);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_SRAM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_BREAK)=
;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_3_BYTE=
_PC);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_2_BYTE=
_SP);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPD)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPY)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RAMPZ)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_EIJMP_=
EICALL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPMX)=
;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_ELPM);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_JMP_CA=
LL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_LPMX);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MOVW);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_MUL);<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 set_avr_feature(env, AVR_FEATURE_RMW);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +typedef struct AVRCPUInfo {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 const char *name;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 void (*initfn)(Object *obj);<br>
&gt;&gt;&gt;&gt;&gt; +} AVRCPUInfo;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static void avr_cpu_list_entry(gpointer data, gpointe=
r user_data)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 const char *typename =3D object_class_g=
et_name(OBJECT_CLASS(data));<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 qemu_printf(&quot;%s\n&quot;, typename)=
;<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +void avr_cpu_list(void)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 GSList *list;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 list =3D object_class_get_list_sorted(T=
YPE_AVR_CPU, false);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_slist_foreach(list, avr_cpu_list_entr=
y, NULL);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 g_slist_free(list);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#define DEFINE_AVR_CPU_TYPE(model, initfn) \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 { \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_AVR_CPU,=
 \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D initfn=
, \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D AVR_CPU_TYPE_NA=
ME(model), \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static const TypeInfo avr_cpu_type_info[] =3D {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D TYPE_AVR_CPU,<b=
r>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent =3D TYPE_CPU,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_size =3D sizeof=
(AVRCPU),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .instance_init =3D avr_cp=
u_initfn,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_size =3D sizeof(AV=
RCPUClass),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init =3D avr_cpu_c=
lass_init,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .abstract =3D true,<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 },<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avrtiny&quot;=
, avr_avrtiny_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr1&quot;, a=
vr_avr1_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr2&quot;, a=
vr_avr2_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr25&quot;, =
avr_avr25_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr3&quot;, a=
vr_avr3_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr31&quot;, =
avr_avr31_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr35&quot;, =
avr_avr35_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr4&quot;, a=
vr_avr4_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr5&quot;, a=
vr_avr5_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr51&quot;, =
avr_avr51_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;avr6&quot;, a=
vr_avr6_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega2&quot;,=
 avr_xmega2_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega3&quot;,=
 avr_xmega3_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega4&quot;,=
 avr_xmega4_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega5&quot;,=
 avr_xmega5_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega6&quot;,=
 avr_xmega6_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DEFINE_AVR_CPU_TYPE(&quot;xmega7&quot;,=
 avr_xmega7_initfn),<br>
&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +const char *avr_flags_to_cpu_type(uint32_t flags, con=
st char *def_cpu_type)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 switch (flags &amp; EF_AVR_MACH) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr1:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr1&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr2:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr2&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr25:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr25&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr3:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr3&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr31:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr31&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr35:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr35&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr4:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr4&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr5:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr5&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr51:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr51&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avr6:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avr6&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrtiny:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;avrtiny&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega2:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega2&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega3:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega3&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega4:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega4&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega5:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega5&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega6:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega6&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 case bfd_mach_avrxmega7:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AVR_CPU_TYPE_NAME(=
&quot;xmega7&quot;);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return def_cpu_type;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +DEFINE_TYPES(avr_cpu_type_info)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi! me again. Following the RC2 discussion. I&#39;ve being=
 looking in the GCC definition of the architecture and as far as I can unde=
rstand this definitions are the generic definitions of the arch families.<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 avr_arch_types[] =3D<br>
&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 /* unknown device specified */<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, NULL, AVR_MMCU_DEFAULT },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 /*<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 A=C2=A0 M=C2=A0 J=C2=A0 LM E=C2=A0 E=
=C2=A0 E=C2=A0 X=C2=A0 R=C2=A0 T=C2=A0 d S=C2=A0 =C2=A0 =C2=A0FPO=C2=A0 =C2=
=A0 =C2=A0S O=C2=A0 =C2=A0A<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 S=C2=A0 U=C2=A0 M=C2=A0 PO L=C2=A0 L=
=C2=A0 I=C2=A0 M=C2=A0 A=C2=A0 I=C2=A0 a t=C2=A0 =C2=A0 =C2=A0lMff=C2=A0 =
=C2=A0 F ff=C2=A0 r<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 M=C2=A0 L=C2=A0 P=C2=A0 MV P=C2=A0 P=
=C2=A0 J=C2=A0 E=C2=A0 M=C2=A0 N=C2=A0 t a=C2=A0 =C2=A0 =C2=A0a s=C2=A0 =C2=
=A0 =C2=A0R s=C2=A0 =C2=A0c<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XW M=
=C2=A0 M=C2=A0 M=C2=A0 G=C2=A0 P=C2=A0 Y=C2=A0 a r=C2=A0 =C2=A0 =C2=A0s e=
=C2=A0 =C2=A0 =C2=A0 =C2=A0e=C2=A0 =C2=A0h<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0X=C2=A0 P=C2=A0 A=C2=A0 D=C2=A0 =C2=A0 =C2=A0 =C2=A0t=C2=
=A0 =C2=A0 =C2=A0h t=C2=A0 =C2=A0 =C2=A0 =C2=A0t=C2=A0 =C2=A0ID=C2=A0 =C2=
=A0*/<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;1&quot;,=C2=A0 =C2=A0&quot;avr1&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;2&quot;,=C2=A0 =C2=A0&quot;avr2&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;25&quot;,=C2=A0 &quot;avr25&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;3&quot;,=C2=A0 =C2=A0&quot;avr3&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;31&quot;,=C2=A0 &quot;avr31&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;35&quot;,=C2=A0 &quot;avr35&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;4&quot;,=C2=A0 =C2=A0&quot;avr4&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;5&quot;,=C2=A0 =C2=A0&quot;avr5&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;51&quot;,=C2=A0 &quot;avr51&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,=C2=
=A0 =C2=A0 =C2=A0 32, &quot;6&quot;,=C2=A0 =C2=A0&quot;avr6&quot;=C2=A0 },<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x400=
0, 0, &quot;100&quot;, &quot;avrtiny&quot;},<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,=C2=
=A0 =C2=A0 =C2=A0 0, &quot;102&quot;, &quot;avrxmega2&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x800=
0, 0, &quot;103&quot;, &quot;avrxmega3&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,=C2=
=A0 =C2=A0 =C2=A0 0, &quot;104&quot;, &quot;avrxmega4&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,=C2=
=A0 =C2=A0 =C2=A0 0, &quot;105&quot;, &quot;avrxmega5&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,=C2=
=A0 =C2=A0 =C2=A0 0, &quot;106&quot;, &quot;avrxmega6&quot; },<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,=C2=
=A0 =C2=A0 =C2=A0 0, &quot;107&quot;, &quot;avrxmega7&quot;=C2=A0 }<br>
&gt;&gt;&gt;&gt;=C2=A0 };<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; And then you have features for the specific microcontrolle=
rs:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_ISA_RMW<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_SHORT_SP<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_ERRATA_SKIP<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_ISA_LDS<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_ISA_RCALL<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; They are mixed in the file &#39;avr-mcus.def&#39; for fami=
ly and microcontroller definition. Only looking at the family definition:<b=
r>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr2&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR2, AVR_ERRATA_SKIP, NULL,=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0060, 0x0, 0x60000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr25&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ARCH_AVR25, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x2000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr3&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR3, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x6000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr31&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ARCH_AVR31, AVR_ERRATA_SKIP, NULL,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x20000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr35&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ARCH_AVR35, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0100, 0x0, 0x4000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr4&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR4, AVR_ISA_NONE,=C2=A0 NULL,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x2000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr5&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR5, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x4000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr51&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ARCH_AVR51, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x0100, 0x0, 0x20000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr6&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR6, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0200, 0x0, 0x40000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega2&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA2, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x2000, 0x0, 0x9000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega3&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA3, AVR_ISA_NONE,=C2=A0 NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x3f00, 0x0, 0x8000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega4&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA4, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x2000, 0x0, 0x11000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega5&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA5, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x2000, 0x0, 0x11000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega6&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA6, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2000, 0x0, 0x60000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrxmega7&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ARCH_AVRXMEGA7, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2000, 0x0, 0x22000, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avrtiny&quot;,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ARCH_AVRTINY, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x0040, 0x0, 0x400, 0)<br>
&gt;&gt;&gt;&gt;=C2=A0 AVR_MCU (&quot;avr1&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ARCH_AVR1, AVR_ISA_NONE, NULL,=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0060, 0x0, 0x400, 0)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I don&#39;t really understand how do you get to the propos=
ed family definition for qemu. Probably is my fault but if you can help me =
to understand will be grate!<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Michal, can you really give us more details on how this mappin=
g is done?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I alredy asked a similar question a while ago, and then you sa=
id you used wikipedia article + avr datasheets. Can you give us more detail=
ed info of the whole process of creating ABRFeature list for a particular A=
VR core type, and how that compares with the corresponding content in gcc, =
as Joakin brought to our attention?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks, Aleksandar<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt; --joa<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Best Regards,<br>
&gt;&gt; Michael Rolnik<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Best Regards,<br>
&gt; Michael Rolnik<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000009c917505a02fba53--

