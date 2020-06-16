Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2533C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568822074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwezq/Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568822074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7Pr-0006FE-NQ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl7Oy-0005WZ-Qi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:57:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl7Ov-0001x9-D6
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:57:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id q25so2230719wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 01:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6HwlqiuV/plhobUDTZ1v9b619sAVzUI1i8zw+j4PBcY=;
 b=cwezq/IsL9pOOOuvQyyXf4V/4PpJ9dVlosJiTi6y/vzDdhiXJ7DrgMkX24vuA3hFza
 AS1EtGsGhJPRd6+GgFq/cgK0otUPr6uxau+l3h2HnI04M3pBqZZcttmQquOmXneJIrOa
 Z4XFONE6f9DFkCQ7KKS/OEos/8IkqFP6zvQahuWSlAB3O1S2oDcEXmTpSRI8854qjSOD
 hPAAZx87fxJy+3Z9fD73ey3p4kor+v/C3Ma3BhhkDuWwdnqG11jbCh4r/untleS3l2B8
 5tkrWnxQkMUvpMqktI21LuthO39dkP4sW93DFrPfajpHEhksDlfWE9tzk5SgrA69U9vy
 tYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6HwlqiuV/plhobUDTZ1v9b619sAVzUI1i8zw+j4PBcY=;
 b=q2cVUXU+J28QmFDc/CVaF0jOlahWGyXCXpeWVcmaCuwsutnoGDJ3XyIz6eZHLsUorf
 s972yV7eCvFhDCnk5jf3rqXlDJDxuQX/O9tqXYXaSZN1qmJH0J/DucVlb6c6snNGBw5I
 9meViVnc8lqthGROKcsIIC+jGMycRfsFh+pmm8ow+ryQ23Lm3aELIWX6X9T1JG2a+ZOl
 T36XVQQCi2pSxyn5szGOhu/Hjxm+LJzvM6yN19OpwOGdPfePlUHtMiGhAOdr+857V0C2
 n7+/7UUxzaYZ7YMWIbYCNT8Pexea8VGNq6ApJCjE7DcONkYxwbUgGNfDnvsT9lX7ZPL3
 dkTQ==
X-Gm-Message-State: AOAM533oV7wYOxWpr2krCYM+07p2UlT0QOt83EfMkxvNkXLGZCLrTkpi
 b4LFXV/Goc/txFFvzskQhuo=
X-Google-Smtp-Source: ABdhPJwppA4fBcWXQwwqLrGqJrZM2s1qXOa3faV2IsffckX3MucGGfT/74nrEzHlglpBUZML1QFj3g==
X-Received: by 2002:a1c:e90a:: with SMTP id q10mr2200321wmc.140.1592297819695; 
 Tue, 16 Jun 2020 01:56:59 -0700 (PDT)
Received: from [192.168.1.41] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w14sm764302wrt.55.2020.06.16.01.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 01:56:58 -0700 (PDT)
Subject: Re: [PATCH rc4 06/29] target/avr: Add defintions of AVR core types
To: Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580428993-4767-7-git-send-email-aleksandar.markovic@rt-rk.com>
 <87aab645-8ffb-dc0d-9d8d-bfeb4281821d@xcancerberox.com.ar>
 <CAL1e-=h9QVVPuNG+PO3TyT981XPXopmng9vn367LjaQjy64nHA@mail.gmail.com>
 <CAK4993h7GaKiSt5LNrEtvRhCDE3tsMyNh-t6551-eZjx39sq7w@mail.gmail.com>
 <CAK4993gOJz8F1DYsc08x46XcyUFbrs3-u8FTL7aJ0NdDS1keLw@mail.gmail.com>
 <CAL1e-=jEqfYWEf_XA=23RSH8wae-3Li2ADYgiyk0sBAP+0Lrmg@mail.gmail.com>
 <CAK4993iskF4Dqu38qABBkm4BLyWBRXqx-POe4C=PzevOQeT2kw@mail.gmail.com>
 <CAK4993gHzg2WGcsD6nrrsLAz9Qe4tbWOw_Z3hxzkmkWMsMCDbQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0eac9862-cd1c-2d4b-95b0-5e9f4df83a6d@amsat.org>
Date: Tue, 16 Jun 2020 10:56:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAK4993gHzg2WGcsD6nrrsLAz9Qe4tbWOw_Z3hxzkmkWMsMCDbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

Hi Michael,

On 3/6/20 2:34 PM, Michael Rolnik wrote:
> Hi all.
> 
> are there any action items for me?

I am not sure neither of the status of this. See below.

> 
> Regards,
> Michael Rolnik
> 
> On Thu, Feb 27, 2020 at 10:38 AM Michael Rolnik <mrolnik@gmail.com
> <mailto:mrolnik@gmail.com>> wrote:
> 
>     Hi all.
> 
>     I don't see how the fact that some MCUs have an instruction and some
>     don't within same AVR family.
>     Think about gnu binutils (not GCC) these utils have no idea about
>     MCUs all they are aware of AVR CPU only.
>     However, I don't mind removing -cpu flag.
> 
>     Regards,
>     Michael Ronik
> 
>     On Fri, Feb 21, 2020 at 5:31 PM Aleksandar Markovic
>     <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
>     wrote:
> 
>         On Fri, Feb 21, 2020 at 12:04 PM Michael Rolnik
>         <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>         >
>         > Hi all.
>         >
>         > How is it going?
>         >
>         > Regards,
>         > Michael.
>         >
> 
>         Michael,
> 
>         I think we are very close to merging.
> 
>         There is absolutely no need to support ALL AVR mcus or AVR core
>         types
>         in the first version that will be merged.
> 
>         But this issue (recently discovered during Jaoquin's review)
>         about the
>         fact that an avr core type doesn't determine in a complete way the
>         instruction set of a particular MCU is thorny.

I addressed Joaquin comments in the fork we use
with the following commit:
https://gitlab.com/philmd/qemu/-/commit/c6b227f1a0b2a3

But this was more than 3 months ago, so I don't remember much.

Anyway this thread is in the rc4, rc5 is on the list, you should
ping the rc5 thread instead.

> 
>         Should we switch from "-cpu <avr core type>" to "-cpu <mcu>"
>         (but keep
>         the current avr core type organization for internal purpose)? Or
>         something else?
> 
>         This is a high-level AVR suppot design issue. Let's think about it
>         without a rush.
> 
>         The problem is that once one organization/meaning of that switch is
>         upstreamed, it is very difficult to switch to other. There is a
>         procedural rule that deprecation process lasts at least 8
>         months, plus
>         there may be some technical obstacles and difficulties.
> 
>         In short, "-cpu <avr core type>" is not enough to emulate
>         accurately a
>         givem program.
> 
>         Regards,
>         Aleksandar
> 
>         > On Mon, Feb 10, 2020 at 9:39 AM Michael Rolnik
>         <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>         >>
>         >> Hi all.
>         >>
>         >> When I decided to implement AVR 8 bit CPU support for QEMU I
>         found this document which listed all AVR instructions.
>         >> After that I learned that there are several CPU flavours, I
>         looked into this GCC file to figure out what are they as I could
>         not find any official document explaining it.
>         >> Then I downloaded several datasheets and created a list of
>         instructions by CPU type (attached).It turned out that there are
>         some variations
>         >> e.g.
>         >> - AVTTINY - some have LDS, some don't
>         >> - AVR1, AVR25 - some have short SP, some don't
>         >> - AVRXMEGA2, AVRXMEGA4, AVRXMEGA5, AVRXMEGA6, AVRXMEGA7 -
>         some have RMW, some don't
>         >> - AVRXMEGA3 - some have RCALL, some don't
>         >>
>         >> I decided to leave CPU flavour definition as suggested by GCC
>         gcc/config/avr/avr-devices.c file and when a specific MCU is
>         created it will set / reset CPU features relevant to it.
>         >>
>         >> I hope this helps.
>         >>
>         >> Best Regards,
>         >> Michael Rolnik
>         >>
>         >>
>         >>
>         >>
>         >>
>         >>
>         >>
>         >> On Sat, Feb 8, 2020 at 9:35 AM Aleksandar Markovic
>         <aleksandar.m.mail@gmail.com
>         <mailto:aleksandar.m.mail@gmail.com>> wrote:
>         >>>
>         >>>
>         >>>
>         >>> On Sunday, February 2, 2020, Joaquin de Andres
>         <me@xcancerberox.com.ar <mailto:me@xcancerberox.com.ar>> wrote:
>         >>>>
>         >>>> On 1/31/20 1:02 AM, Aleksandar Markovic wrote:
>         >>>>>
>         >>>>> From: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         >>>>>
>         >>>>> AVR core types are:
>         >>>>>
>         >>>>>    - avr1
>         >>>>>    - avr2
>         >>>>>    - avr25
>         >>>>>    - avr3
>         >>>>>    - avr31
>         >>>>>    - avr35
>         >>>>>    - avr4
>         >>>>>    - avr5
>         >>>>>    - avr51
>         >>>>>    - avr6
>         >>>>>    - avrtiny
>         >>>>>    - xmega2
>         >>>>>    - xmega3
>         >>>>>    - xmega4
>         >>>>>    - xmega5
>         >>>>>    - xmega6
>         >>>>>    - xmega7
>         >>>>>
>         >>>>> Each core type covers multiple AVR MCUs, mentioned in the
>         comments
>         >>>>> before definition of particular AVR core type (part of
>         this patch).
>         >>>>>
>         >>>>> AVR core type defines shared features that are valid for
>         all AVR
>         >>>>> MCUs belonging in that type.
>         >>>>>
>         >>>>> [AM: Split a larger AVR introduction patch into logical units]
>         >>>>> Suggested-by: Aleksandar Markovic
>         <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
>         >>>>>
>         >>>>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         >>>>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>         <mailto:S.E.Harris@kent.ac.uk>>
>         >>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         >>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>         <mailto:S.E.Harris@kent.ac.uk>>
>         >>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         >>>>> Acked-by: Igor Mammedov <imammedo@redhat.com
>         <mailto:imammedo@redhat.com>>
>         >>>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
>         >>>>> Signed-off-by: Richard Henderson
>         <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>>
>         >>>>> Signed-off-by: Aleksandar Markovic
>         <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
>         >>>>> ---
>         >>>>>   target/avr/cpu.c | 601
>         +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>         >>>>>   1 file changed, 601 insertions(+)
>         >>>>>
>         >>>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>         >>>>> index f41a887..e0ae055 100644
>         >>>>> --- a/target/avr/cpu.c
>         >>>>> +++ b/target/avr/cpu.c
>         >>>>> @@ -215,3 +215,604 @@ static void
>         avr_cpu_class_init(ObjectClass *oc, void *data)
>         >>>>>       cc->gdb_num_core_regs = 35;
>         >>>>>       cc->gdb_core_xml_file = "avr-cpu.xml";
>         >>>>>   }
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr1
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * at90s1200, attiny11, attiny12, attiny15, attiny28
>         >>>>> + */
>         >>>>> +static void avr_avr1_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr2
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22,
>         attiny26, at90s4414,
>         >>>>> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
>         >>>>> + */
>         >>>>> +static void avr_avr2_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr25
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313,
>         attiny2313a, attiny24,
>         >>>>> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441,
>         attiny84, attiny84a,
>         >>>>> + * attiny25, attiny45, attiny85, attiny261, attiny261a,
>         attiny461, attiny461a,
>         >>>>> + * attiny861, attiny861a, attiny43u, attiny87, attiny48,
>         attiny88, attiny828,
>         >>>>> + * attiny841, at86rf401
>         >>>>> + */
>         >>>>> +static void avr_avr25_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr3
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * at43usb355, at76c711
>         >>>>> + */
>         >>>>> +static void avr_avr3_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr31
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atmega103, at43usb320
>         >>>>> + */
>         >>>>> +static void avr_avr31_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr35
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162,
>         atmega8u2, atmega16u2,
>         >>>>> + * atmega32u2, attiny167, attiny1634
>         >>>>> + */
>         >>>>> +static void avr_avr35_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr4
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * ata6285, ata6286, ata6289, ata6612c, atmega8,
>         atmega8a, atmega48, atmega48a,
>         >>>>> + * atmega48p, atmega48pa, atmega48pb, atmega88,
>         atmega88a, atmega88p,
>         >>>>> + * atmega88pa, atmega88pb, atmega8515, atmega8535,
>         atmega8hva, at90pwm1,
>         >>>>> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
>         >>>>> + */
>         >>>>> +static void avr_avr4_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr5
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791,
>         ata5795, ata5831, ata6613c,
>         >>>>> + * ata6614q, ata8210, ata8510, atmega16, atmega16a,
>         atmega161, atmega162,
>         >>>>> + * atmega163, atmega164a, atmega164p, atmega164pa,
>         atmega165, atmega165a,
>         >>>>> + * atmega165p, atmega165pa, atmega168, atmega168a,
>         atmega168p, atmega168pa,
>         >>>>> + * atmega168pb, atmega169, atmega169a, atmega169p,
>         atmega169pa, atmega16hvb,
>         >>>>> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a,
>         atmega32, atmega323,
>         >>>>> + * atmega324a, atmega324p, atmega324pa, atmega325,
>         atmega325a, atmega325p,
>         >>>>> + * atmega325pa, atmega3250, atmega3250a, atmega3250p,
>         atmega3250pa, atmega328,
>         >>>>> + * atmega328p, atmega328pb, atmega329, atmega329a,
>         atmega329p, atmega329pa,
>         >>>>> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa,
>         atmega32c1, atmega32m1,
>         >>>>> + * atmega32u4, atmega32u6, atmega406, atmega64,
>         atmega64a, atmega640, atmega644,
>         >>>>> + * atmega644a, atmega644p, atmega644pa, atmega645,
>         atmega645a, atmega645p,
>         >>>>> + * atmega6450, atmega6450a, atmega6450p, atmega649,
>         atmega649a, atmega649p,
>         >>>>> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb,
>         atmega6490a, atmega6490p,
>         >>>>> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2,
>         atmega64rfr2,
>         >>>>> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64,
>         at90pwm161, at90pwm216,
>         >>>>> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k,
>         m3000
>         >>>>> + */
>         >>>>> +static void avr_avr5_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr51
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atmega128, atmega128a, atmega1280, atmega1281,
>         atmega1284, atmega1284p,
>         >>>>> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2,
>         at90can128, at90usb1286,
>         >>>>> + * at90usb1287
>         >>>>> + */
>         >>>>> +static void avr_avr51_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avr6
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
>         >>>>> + */
>         >>>>> +static void avr_avr6_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type avrtiny
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
>         >>>>> + */
>         >>>>> +static void avr_avrtiny_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_1_BYTE_SP);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega2
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5,
>         atxmega32a4, atxmega32c3,
>         >>>>> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4,
>         atxmega32a4u,
>         >>>>> + * atxmega32c4, atxmega32e5
>         >>>>> + */
>         >>>>> +static void avr_xmega2_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega3
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * attiny212, attiny214, attiny412, attiny414, attiny416,
>         attiny417, attiny814,
>         >>>>> + * attiny816, attiny817, attiny1614, attiny1616,
>         attiny1617, attiny3214,
>         >>>>> + * attiny3216, attiny3217, atmega808, atmega809,
>         atmega1608, atmega1609,
>         >>>>> + * atmega3208, atmega3209, atmega4808, atmega4809
>         >>>>> + */
>         >>>>> +static void avr_xmega3_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega4
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u,
>         atxmega64b1,
>         >>>>> + * atxmega64b3, atxmega64c3, atxmega64d4
>         >>>>> + */
>         >>>>> +static void avr_xmega4_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega5
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atxmega64a1, atxmega64a1u
>         >>>>> + */
>         >>>>> +static void avr_xmega5_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega6
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atxmega128a3, atxmega128d3, atxmega192a3,
>         atxmega192d3, atxmega256a3,
>         >>>>> + * atxmega256a3b, atxmega256a3bu, atxmega256d3,
>         atxmega128a3u, atxmega128b1,
>         >>>>> + * atxmega128b3, atxmega128c3, atxmega128d4,
>         atxmega192a3u, atxmega192c3,
>         >>>>> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
>         >>>>> + */
>         >>>>> +static void avr_xmega6_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +/*
>         >>>>> + * Setting features of AVR core type xmega7
>         >>>>> + * --------------------------------------
>         >>>>> + *
>         >>>>> + * This type of AVR core is present in the following AVR
>         MCUs:
>         >>>>> + *
>         >>>>> + * atxmega128a1, atxmega128a1u, atxmega128a4u
>         >>>>> + */
>         >>>>> +static void avr_xmega7_initfn(Object *obj)
>         >>>>> +{
>         >>>>> +    AVRCPU *cpu = AVR_CPU(obj);
>         >>>>> +    CPUAVRState *env = &cpu->env;
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_IJMP_ICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ADIW_SBIW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_SRAM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_BREAK);
>         >>>>> +
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_3_BYTE_PC);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_2_BYTE_SP);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPD);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPY);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RAMPZ);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_EIJMP_EICALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_ELPM);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_JMP_CALL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_LPMX);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MOVW);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_MUL);
>         >>>>> +    set_avr_feature(env, AVR_FEATURE_RMW);
>         >>>>> +}
>         >>>>> +
>         >>>>> +typedef struct AVRCPUInfo {
>         >>>>> +    const char *name;
>         >>>>> +    void (*initfn)(Object *obj);
>         >>>>> +} AVRCPUInfo;
>         >>>>> +
>         >>>>> +
>         >>>>> +static void avr_cpu_list_entry(gpointer data, gpointer
>         user_data)
>         >>>>> +{
>         >>>>> +    const char *typename =
>         object_class_get_name(OBJECT_CLASS(data));
>         >>>>> +
>         >>>>> +    qemu_printf("%s\n", typename);
>         >>>>> +}
>         >>>>> +
>         >>>>> +void avr_cpu_list(void)
>         >>>>> +{
>         >>>>> +    GSList *list;
>         >>>>> +    list = object_class_get_list_sorted(TYPE_AVR_CPU, false);
>         >>>>> +    g_slist_foreach(list, avr_cpu_list_entry, NULL);
>         >>>>> +    g_slist_free(list);
>         >>>>> +}
>         >>>>> +
>         >>>>> +#define DEFINE_AVR_CPU_TYPE(model, initfn) \
>         >>>>> +    { \
>         >>>>> +        .parent = TYPE_AVR_CPU, \
>         >>>>> +        .instance_init = initfn, \
>         >>>>> +        .name = AVR_CPU_TYPE_NAME(model), \
>         >>>>> +    }
>         >>>>> +
>         >>>>> +static const TypeInfo avr_cpu_type_info[] = {
>         >>>>> +    {
>         >>>>> +        .name = TYPE_AVR_CPU,
>         >>>>> +        .parent = TYPE_CPU,
>         >>>>> +        .instance_size = sizeof(AVRCPU),
>         >>>>> +        .instance_init = avr_cpu_initfn,
>         >>>>> +        .class_size = sizeof(AVRCPUClass),
>         >>>>> +        .class_init = avr_cpu_class_init,
>         >>>>> +        .abstract = true,
>         >>>>> +    },
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avrtiny", avr_avrtiny_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr1", avr_avr1_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr2", avr_avr2_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr25", avr_avr25_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr3", avr_avr3_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr31", avr_avr31_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr35", avr_avr35_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr4", avr_avr4_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr5", avr_avr5_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr51", avr_avr51_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("avr6", avr_avr6_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega2", avr_xmega2_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega3", avr_xmega3_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega4", avr_xmega4_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega5", avr_xmega5_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega6", avr_xmega6_initfn),
>         >>>>> +    DEFINE_AVR_CPU_TYPE("xmega7", avr_xmega7_initfn),
>         >>>>> +};
>         >>>>> +
>         >>>>> +const char *avr_flags_to_cpu_type(uint32_t flags, const
>         char *def_cpu_type)
>         >>>>> +{
>         >>>>> +    switch (flags & EF_AVR_MACH) {
>         >>>>> +    case bfd_mach_avr1:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr1");
>         >>>>> +    case bfd_mach_avr2:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr2");
>         >>>>> +    case bfd_mach_avr25:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr25");
>         >>>>> +    case bfd_mach_avr3:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr3");
>         >>>>> +    case bfd_mach_avr31:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr31");
>         >>>>> +    case bfd_mach_avr35:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr35");
>         >>>>> +    case bfd_mach_avr4:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr4");
>         >>>>> +    case bfd_mach_avr5:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr5");
>         >>>>> +    case bfd_mach_avr51:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr51");
>         >>>>> +    case bfd_mach_avr6:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avr6");
>         >>>>> +    case bfd_mach_avrtiny:
>         >>>>> +        return AVR_CPU_TYPE_NAME("avrtiny");
>         >>>>> +    case bfd_mach_avrxmega2:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega2");
>         >>>>> +    case bfd_mach_avrxmega3:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega3");
>         >>>>> +    case bfd_mach_avrxmega4:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega4");
>         >>>>> +    case bfd_mach_avrxmega5:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega5");
>         >>>>> +    case bfd_mach_avrxmega6:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega6");
>         >>>>> +    case bfd_mach_avrxmega7:
>         >>>>> +        return AVR_CPU_TYPE_NAME("xmega7");
>         >>>>> +    default:
>         >>>>> +        return def_cpu_type;
>         >>>>> +    }
>         >>>>> +}
>         >>>>> +
>         >>>>> +DEFINE_TYPES(avr_cpu_type_info)
>         >>>>>
>         >>>>
>         >>>> Hi! me again. Following the RC2 discussion. I've being
>         looking in the GCC definition of the architecture and as far as
>         I can understand this definitions are the generic definitions of
>         the arch families.
>         >>>>
>         >>>>  avr_arch_types[] =
>         >>>>  {
>         >>>>    /* unknown device specified */
>         >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         NULL, AVR_MMCU_DEFAULT },
>         >>>>    /*
>         >>>>      A  M  J  LM E  E  E  X  R  T  d S     FPO     S O   A
>         >>>>      S  U  M  PO L  L  I  M  A  I  a t     lMff    F ff  r
>         >>>>      M  L  P  MV P  P  J  E  M  N  t a     a s     R s   c
>         >>>>               XW M  M  M  G  P  Y  a r     s e       e   h
>         >>>>                     X  P  A  D       t     h t       t 
>          ID   */
>         >>>>    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "1",   "avr1"  },
>         >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "2",   "avr2"  },
>         >>>>    { 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "25",  "avr25" },
>         >>>>    { 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "3",   "avr3"  },
>         >>>>    { 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "31",  "avr31" },
>         >>>>    { 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "35",  "avr35" },
>         >>>>    { 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "4",   "avr4"  },
>         >>>>    { 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0x0060, 0,      32,
>         "5",   "avr5"  },
>         >>>>    { 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0x0060, 0,      32,
>         "51",  "avr51" },
>         >>>>    { 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0x0060, 0,      32,
>         "6",   "avr6"  },
>         >>>>
>         >>>>    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0x0040, 0x4000, 0,
>         "100", "avrtiny"},
>         >>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0,      0,
>         "102", "avrxmega2" },
>         >>>>    { 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0x2000, 0x8000, 0,
>         "103", "avrxmega3" },
>         >>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0x2000, 0,      0,
>         "104", "avrxmega4" },
>         >>>>    { 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0x2000, 0,      0,
>         "105", "avrxmega5" },
>         >>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0x2000, 0,      0,
>         "106", "avrxmega6" },
>         >>>>    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0x2000, 0,      0,
>         "107", "avrxmega7"  }
>         >>>>  };
>         >>>>
>         >>>> And then you have features for the specific microcontrollers:
>         >>>>
>         >>>>  AVR_ISA_RMW
>         >>>>  AVR_SHORT_SP
>         >>>>  AVR_ERRATA_SKIP
>         >>>>  AVR_ISA_LDS
>         >>>>  AVR_ISA_RCALL
>         >>>>
>         >>>> They are mixed in the file 'avr-mcus.def' for family and
>         microcontroller definition. Only looking at the family definition:
>         >>>>
>         >>>>  AVR_MCU ("avr2",             ARCH_AVR2, AVR_ERRATA_SKIP,
>         NULL,              0x0060, 0x0, 0x60000, 0)
>         >>>>  AVR_MCU ("avr25",            ARCH_AVR25, AVR_ISA_NONE,
>         NULL,             0x0060, 0x0, 0x2000, 0)
>         >>>>  AVR_MCU ("avr3",             ARCH_AVR3, AVR_ISA_NONE,
>         NULL,             0x0060, 0x0, 0x6000, 0)
>         >>>>  AVR_MCU ("avr31",            ARCH_AVR31, AVR_ERRATA_SKIP,
>         NULL,             0x0060, 0x0, 0x20000, 0)
>         >>>>  AVR_MCU ("avr35",            ARCH_AVR35, AVR_ISA_NONE,
>         NULL,             0x0100, 0x0, 0x4000, 0)
>         >>>>  AVR_MCU ("avr4",             ARCH_AVR4, AVR_ISA_NONE, 
>         NULL,             0x0060, 0x0, 0x2000, 0)
>         >>>>  AVR_MCU ("avr5",             ARCH_AVR5, AVR_ISA_NONE,
>         NULL,             0x0060, 0x0, 0x4000, 0)
>         >>>>  AVR_MCU ("avr51",            ARCH_AVR51, AVR_ISA_NONE,
>         NULL,             0x0100, 0x0, 0x20000, 0)
>         >>>>  AVR_MCU ("avr6",             ARCH_AVR6, AVR_ISA_NONE,
>         NULL,             0x0200, 0x0, 0x40000, 0)
>         >>>>  AVR_MCU ("avrxmega2",        ARCH_AVRXMEGA2, AVR_ISA_NONE,
>         NULL,             0x2000, 0x0, 0x9000, 0)
>         >>>>  AVR_MCU ("avrxmega3",        ARCH_AVRXMEGA3,
>         AVR_ISA_NONE,  NULL,             0x3f00, 0x0, 0x8000, 0)
>         >>>>  AVR_MCU ("avrxmega4",        ARCH_AVRXMEGA4, AVR_ISA_NONE,
>         NULL,             0x2000, 0x0, 0x11000, 0)
>         >>>>  AVR_MCU ("avrxmega5",        ARCH_AVRXMEGA5, AVR_ISA_NONE,
>         NULL,             0x2000, 0x0, 0x11000, 0)
>         >>>>  AVR_MCU ("avrxmega6",        ARCH_AVRXMEGA6, AVR_ISA_NONE,
>         NULL,                 0x2000, 0x0, 0x60000, 0)
>         >>>>  AVR_MCU ("avrxmega7",        ARCH_AVRXMEGA7, AVR_ISA_NONE,
>         NULL,                 0x2000, 0x0, 0x22000, 0)
>         >>>>  AVR_MCU ("avrtiny",          ARCH_AVRTINY, AVR_ISA_NONE,
>         NULL,             0x0040, 0x0, 0x400, 0)
>         >>>>  AVR_MCU ("avr1",             ARCH_AVR1, AVR_ISA_NONE,
>         NULL,             0x0060, 0x0, 0x400, 0)
>         >>>>
>         >>>> I don't really understand how do you get to the proposed
>         family definition for qemu. Probably is my fault but if you can
>         help me to understand will be grate!
>         >>>>
>         >>>
>         >>> Michal, can you really give us more details on how this
>         mapping is done?
>         >>>
>         >>> I alredy asked a similar question a while ago, and then you
>         said you used wikipedia article + avr datasheets. Can you give
>         us more detailed info of the whole process of creating
>         ABRFeature list for a particular AVR core type, and how that
>         compares with the corresponding content in gcc, as Joakin
>         brought to our attention?
>         >>>
>         >>> Thanks, Aleksandar
>         >>>
>         >>>
>         >>>
>         >>>>
>         >>>> Regards,
>         >>>> --joa
>         >>
>         >>
>         >>
>         >> --
>         >> Best Regards,
>         >> Michael Rolnik
>         >
>         >
>         >
>         > --
>         > Best Regards,
>         > Michael Rolnik
> 
> 
> 
>     -- 
>     Best Regards,
>     Michael Rolnik
> 
> 
> 
> -- 
> Best Regards,
> Michael Rolnik


