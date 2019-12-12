Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E767214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 09:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVJqv1pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E767214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifKX5-0005eK-Ld
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 04:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifKWQ-0005Fi-8S
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ifKWN-0007rv-R8
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:12:34 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ifKWN-0007oh-KD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 04:12:31 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so1058233otp.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 01:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IQrrKyBBYF7FQ7E7MReP9ehht403oLrVGzxKrFNoyOs=;
 b=MVJqv1pHukBhenQ4MnAvV69B1wT39dRvQ62889b9rA9SCw+Uy667XCh3BN99msnZAR
 n0bZHCcG0+G4+lwSt4YrbeWOinR6S0Hev34GVqC4+weq496s0Gm8opS85lGuer5VUzOQ
 /U468qGXBsItllvbAKIfmp+9GPmQkeAC+ulE9/dx76mJfXHrxEjcfIRoLJpR4kjbqXmK
 +tWUfr84orn3WVGP/SAzfXzPgLjMKfyMG36U4bjukMzxLaXr3mi3Eyyw62hyopRdZ/wz
 OLbbdB5ibT+6UkbQr/JomkUy8ysnhHcCwTcNbl/rTEiv9lG8ng3eTODU4oc0JjxvB8LK
 piPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IQrrKyBBYF7FQ7E7MReP9ehht403oLrVGzxKrFNoyOs=;
 b=IADI3AkJUkHUZH23NwMqXpM020qLqi1kLgD9W7pcemlfl/VzRmiLdsSWI6b4Vutajo
 0Pt76n3UiWn6FGxrf5/L/aIGpRfVINUO730XA3m7TMN1g7gCuUn9QIof/wFKwaUI1h8b
 qpPXbkDow45sG3ZJWzYq2J3/6udm62CzjdtG7BTeASxlVpCfMACRDTfeFeRCio27rKnL
 Ezd6wpXZCQ+7Ixj7xneGIXzylVmcoDzdxOyMuNkg9soO1Jd6RpWtBoHGYIcfgKmPX9Mb
 NsLvyBGPEwFUn9wqAelE7opFRnW7OPsY7cR+cYMpuKIZxmJi1FszPTkqgs6W/1Vjivgy
 8Bkg==
X-Gm-Message-State: APjAAAXn7CwA6N8l4tTiaLNPq9zyrkJjpCkWJTa0+b8qDeBMb1kP3D14
 Vl7DDiWKJuOnz1pa1FGNRo7CMGIFKH3eP4mPf2Y=
X-Google-Smtp-Source: APXvYqyP9CB73fALpqXoXX2bMsVkpbSVOnCkIfJF43yIYS4TAzycTLrcE3XzwrF5mFj+YtwbOX1x1B1rVbTPAiv2mCQ=
X-Received: by 2002:a9d:58c9:: with SMTP id s9mr6636965oth.121.1576141950296; 
 Thu, 12 Dec 2019 01:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-12-mrolnik@gmail.com>
 <CAL1e-=iPsFgtEmvT2xt-Fm8AiQBxq48_veVDcnnyMEqghF16hw@mail.gmail.com>
 <CAK4993ipego3-ELy82A85Rcd=PDiqCF0M5-COpHPUTL6UjVQZQ@mail.gmail.com>
 <CAL1e-=gkGa0GCjSMm1QK+KrsnSts_1ZgvcjjP6acCVt7xP3ZpQ@mail.gmail.com>
 <CAK4993jAANG-P_FeWhzu0ncZdiDEn=moWQ=qPKjNS_7SxzPFUQ@mail.gmail.com>
In-Reply-To: <CAK4993jAANG-P_FeWhzu0ncZdiDEn=moWQ=qPKjNS_7SxzPFUQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 12 Dec 2019 10:12:19 +0100
Message-ID: <CAL1e-=i-PViLdw1bT2JXnMf_MdKdswAGBFvYsWSbCRrgcmd_tQ@mail.gmail.com>
Subject: Re: [PATCH v38 11/22] target/avr: Add instruction disassembly function
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 10, 2019 at 8:18 AM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> You are right. See at the bottom of the file. There is a comment about it
>

Sorry, what file?

I also see that you disassemble instructions regardless of what AVR
CPU the current executable is built for, don't you? OK, not a very big
deal, but can be confusing for end user if disassembly text of an
instruction that is not supported by a particular CPU is displayed as
if it is supported.

> Sent from my cell phone, please ignore typos
>
> On Tue, Dec 10, 2019, 6:21 AM Aleksandar Markovic <aleksandar.m.mail@gmai=
l.com> wrote:
>>
>>
>>
>> On Monday, December 9, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>
>>> Hi Aleksandar.
>>>
>>> 1. all instructions are 16 bit long except CALL & JMP they are 32 bit l=
ong
>>
>>
>> Accordingto the doc, LDS and STS also have 32-bit coding.
>>
>>
>>>
>>> 2. next_word_used is set to true by next_word when called by append_16 =
when CALL & JMP are parsed
>>>
>>> Regards,
>>> Michael Rolnik
>>>
>>> On Mon, Dec 9, 2019 at 8:10 PM Aleksandar Markovic <aleksandar.m.mail@g=
mail.com> wrote:
>>>>
>>>>
>>>>
>>>> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
>>>>>
>>>>> Provide function disassembles executed instruction when `-d in_asm` i=
s
>>>>> provided
>>>>>
>>>>> Example:
>>>>> `./avr-softmmu/qemu-system-avr -bios free-rtos/Demo/AVR_ATMega2560_GC=
C/demo.elf -d in_asm` will produce something like the following
>>>>>
>>>>> ```
>>>>>     ...
>>>>>     IN:
>>>>>     0x0000014a:  CALL      0x3808
>>>>>
>>>>>     IN: main
>>>>>     0x00003808:  CALL      0x4b4
>>>>>
>>>>>     IN: vParTestInitialise
>>>>>     0x000004b4:  LDI       r24, 255
>>>>>     0x000004b6:  STS       r24, 0
>>>>>     0x000004b8:  MULS      r16, r20
>>>>>     0x000004ba:  OUT       $1, r24
>>>>>     0x000004bc:  LDS       r24, 0
>>>>>     0x000004be:  MULS      r16, r20
>>>>>     0x000004c0:  OUT       $2, r24
>>>>>     0x000004c2:  RET
>>>>>     ...
>>>>> ```
>>>>>
>>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> ---
>>>>>  target/avr/cpu.h       |   1 +
>>>>>  target/avr/cpu.c       |   2 +-
>>>>>  target/avr/disas.c     | 226 +++++++++++++++++++++++++++++++++++++++=
++
>>>>>  target/avr/translate.c |  11 ++
>>>>>  4 files changed, 239 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 target/avr/disas.c
>>>>>
>>>>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>>>>> index c217eefeb4..a8a3e7ade6 100644
>>>>> --- a/target/avr/cpu.h
>>>>> +++ b/target/avr/cpu.h
>>>>> @@ -178,6 +178,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int in=
t_req);
>>>>>  hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>>>>>  int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>>>>>  int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)=
;
>>>>> +int avr_print_insn(bfd_vma addr, disassemble_info *info);
>>>>>
>>>>>  static inline int avr_feature(CPUAVRState *env, int feature)
>>>>>  {
>>>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>>>>> index c5cafcae3c..be4b921e4d 100644
>>>>> --- a/target/avr/cpu.c
>>>>> +++ b/target/avr/cpu.c
>>>>> @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
>>>>>  static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info *=
info)
>>>>>  {
>>>>>      info->mach =3D bfd_arch_avr;
>>>>> -    info->print_insn =3D NULL;
>>>>> +    info->print_insn =3D avr_print_insn;
>>>>>  }
>>>>>
>>>>>  static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
>>>>> diff --git a/target/avr/disas.c b/target/avr/disas.c
>>>>> new file mode 100644
>>>>> index 0000000000..22863d2eb1
>>>>> --- /dev/null
>>>>> +++ b/target/avr/disas.c
>>>>> @@ -0,0 +1,226 @@
>>>>> +/*
>>>>> + * AVR disassembler
>>>>> + *
>>>>> + * Copyright (c) 2019 Richard Henderson <rth@twiddle.net>
>>>>> + * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
>>>>> + *
>>>>> + * This program is free software: you can redistribute it and/or mod=
ify
>>>>> + * it under the terms of the GNU General Public License as published=
 by
>>>>> + * the Free Software Foundation, either version 2 of the License, or
>>>>> + * (at your option) any later version.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + * You should have received a copy of the GNU General Public License
>>>>> + * along with this program.  If not, see <http://www.gnu.org/license=
s/>.
>>>>> + */
>>>>> +
>>>>> +#include "qemu/osdep.h"
>>>>> +#include "cpu.h"
>>>>> +
>>>>> +typedef struct {
>>>>> +    disassemble_info *info;
>>>>> +    uint16_t next_word;
>>>>> +    bool next_word_used;
>>>>> +} DisasContext;
>>>>> +
>>>>> +static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
>>>>> +{
>>>>> +    return 16 + (indx % 16);
>>>>> +}
>>>>> +
>>>>> +static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
>>>>> +{
>>>>> +    return 16 + (indx % 8);
>>>>> +}
>>>>> +static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
>>>>> +{
>>>>> +    return 24 + (indx % 4) * 2;
>>>>> +}
>>>>> +static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
>>>>> +{
>>>>> +    return (indx % 16) * 2;
>>>>> +}
>>>>> +
>>>>> +static uint16_t next_word(DisasContext *ctx)
>>>>> +{
>>>>> +    ctx->next_word_used =3D true;
>>>>> +    return ctx->next_word;
>>>>> +}
>>>>> +
>>>>> +static int append_16(DisasContext *ctx, int x)
>>>>> +{
>>>>> +    return x << 16 | next_word(ctx);
>>>>> +}
>>>>> +
>>>>> +
>>>>> +/* Include the auto-generated decoder.  */
>>>>> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
>>>>> +#include "decode_insn.inc.c"
>>>>> +
>>>>> +#define output(mnemonic, format, ...) \
>>>>> +    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
>>>>> +                        mnemonic, ##__VA_ARGS__))
>>>>> +
>>>>> +int avr_print_insn(bfd_vma addr, disassemble_info *info)
>>>>> +{
>>>>> +    DisasContext ctx;
>>>>> +    DisasContext *pctx =3D &ctx;
>>>>> +    bfd_byte buffer[4];
>>>>> +    uint16_t insn;
>>>>> +    int status;
>>>>> +
>>>>> +    ctx.info =3D info;
>>>>> +
>>>>> +    status =3D info->read_memory_func(addr, buffer, 4, info);
>>>>> +    if (status !=3D 0) {
>>>>> +        info->memory_error_func(status, addr, info);
>>>>> +        return -1;
>>>>> +    }
>>>>> +    insn =3D bfd_getl16(buffer);
>>>>> +    ctx.next_word =3D bfd_getl16(buffer + 2);
>>>>> +    ctx.next_word_used =3D false;
>>>>> +
>>>>> +    if (!decode_insn(&ctx, insn)) {
>>>>> +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
>>>>> +    }
>>>>> +
>>>>> +    return ctx.next_word_used ? 4 : 2;
>>>>> +}
>>>>
>>>>
>>>> Hi, Michael,
>>>>
>>>> What is the role of ctx.next_word_used, if it looks it is always "fals=
e"?
>>>>
>>>> Related to this, how do you disassemble 32-bit-coded instructions? Fro=
m this patch, it looks you treat all AVR instructions as 16-bit-coded?
>>>>
>>>> Thanks,
>>>> Aleksandar
>>>>
>>>>>
>>>>> +
>>>>> +
>>>>> +#define INSN(opcode, format, ...)                                   =
    \
>>>>> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)    =
    \
>>>>> +{                                                                   =
    \
>>>>> +    output(#opcode, format, ##__VA_ARGS__);                         =
    \
>>>>> +    return true;                                                    =
    \
>>>>> +}
>>>>> +
>>>>> +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)                =
    \
>>>>> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)    =
    \
>>>>> +{                                                                   =
    \
>>>>> +    output(mnemonic, format, ##__VA_ARGS__);                        =
    \
>>>>> +    return true;                                                    =
    \
>>>>> +}
>>>>> +
>>>>> +/*
>>>>> + *   C       Z       N       V       S       H       T       I
>>>>> + *   0       1       2       3       4       5       6       7
>>>>> + */
>>>>> +static const char *brbc[] =3D {
>>>>> +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
>>>>> +};
>>>>> +
>>>>> +static const char *brbs[] =3D {
>>>>> +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
>>>>> +};
>>>>> +
>>>>> +static const char *bset[] =3D {
>>>>> +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
>>>>> +};
>>>>> +
>>>>> +static const char *bclr[] =3D {
>>>>> +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
>>>>> +};
>>>>> +
>>>>> +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
>>>>> +INSN(AND,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(ANDI,   "r%d, %d", a->rd, a->imm)
>>>>> +INSN(ASR,    "r%d", a->rd)
>>>>> +INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
>>>>> +INSN(BLD,    "r%d, %d", a->rd, a->bit)
>>>>> +INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
>>>>> +INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
>>>>> +INSN(BREAK,  "")
>>>>> +INSN_MNEMONIC(BSET,  bset[a->bit], "")
>>>>> +INSN(BST,    "r%d, %d", a->rd, a->bit)
>>>>> +INSN(CALL,   "0x%x", a->imm * 2)
>>>>> +INSN(CBI,    "%d, %d", a->reg, a->bit)
>>>>> +INSN(COM,    "r%d", a->rd)
>>>>> +INSN(CP,     "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(CPC,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(CPI,    "r%d, %d", a->rd, a->imm)
>>>>> +INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(DEC,    "r%d", a->rd)
>>>>> +INSN(DES,    "%d", a->imm)
>>>>> +INSN(EICALL, "")
>>>>> +INSN(EIJMP,  "")
>>>>> +INSN(ELPM1,  "")
>>>>> +INSN(ELPM2,  "r%d, Z", a->rd)
>>>>> +INSN(ELPMX,  "r%d, Z+", a->rd)
>>>>> +INSN(EOR,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(ICALL,  "")
>>>>> +INSN(IJMP,   "")
>>>>> +INSN(IN,     "r%d, $%d", a->rd, a->imm)
>>>>> +INSN(INC,    "r%d", a->rd)
>>>>> +INSN(JMP,    "0x%x", a->imm * 2)
>>>>> +INSN(LAC,    "Z, r%d", a->rd)
>>>>> +INSN(LAS,    "Z, r%d", a->rd)
>>>>> +INSN(LAT,    "Z, r%d", a->rd)
>>>>> +INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
>>>>> +INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
>>>>> +INSN(LDI,    "r%d, %d", a->rd, a->imm)
>>>>> +INSN(LDS,    "r%d, %d", a->rd, a->imm)
>>>>> +INSN(LDX1,   "r%d, X", a->rd)
>>>>> +INSN(LDX2,   "r%d, X+", a->rd)
>>>>> +INSN(LDX3,   "r%d, -X", a->rd)
>>>>> +INSN(LDY2,   "r%d, Y+", a->rd)
>>>>> +INSN(LDY3,   "r%d, -Y", a->rd)
>>>>> +INSN(LDZ2,   "r%d, Z+", a->rd)
>>>>> +INSN(LDZ3,   "r%d, -Z", a->rd)
>>>>> +INSN(LPM1,   "")
>>>>> +INSN(LPM2,   "r%d, Z", a->rd)
>>>>> +INSN(LPMX,   "r%d, Z+", a->rd)
>>>>> +INSN(LSR,    "r%d", a->rd)
>>>>> +INSN(MOV,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1, a->r=
r)
>>>>> +INSN(MUL,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(MULS,   "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(NEG,    "r%d", a->rd)
>>>>> +INSN(NOP,    "")
>>>>> +INSN(OR,     "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(ORI,    "r%d, %d", a->rd, a->imm)
>>>>> +INSN(OUT,    "$%d, r%d", a->imm, a->rd)
>>>>> +INSN(POP,    "r%d", a->rd)
>>>>> +INSN(PUSH,   "r%d", a->rd)
>>>>> +INSN(RCALL,  ".%+d", a->imm * 2)
>>>>> +INSN(RET,    "")
>>>>> +INSN(RETI,   "")
>>>>> +INSN(RJMP,   ".%+d", a->imm * 2)
>>>>> +INSN(ROR,    "r%d", a->rd)
>>>>> +INSN(SBC,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(SBCI,   "r%d, %d", a->rd, a->imm)
>>>>> +INSN(SBI,    "$%d, %d", a->reg, a->bit)
>>>>> +INSN(SBIC,   "$%d, %d", a->reg, a->bit)
>>>>> +INSN(SBIS,   "$%d, %d", a->reg, a->bit)
>>>>> +INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
>>>>> +INSN(SBRC,   "r%d, %d", a->rr, a->bit)
>>>>> +INSN(SBRS,   "r%d, %d", a->rr, a->bit)
>>>>> +INSN(SLEEP,  "")
>>>>> +INSN(SPM,    "")
>>>>> +INSN(SPMX,   "Z+")
>>>>> +INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
>>>>> +INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
>>>>> +INSN(STS,    "r%d, %d", a->rd, a->imm)
>>>>> +INSN(STX1,   "r%d, X", a->rr)
>>>>> +INSN(STX2,   "r%d, X+", a->rr)
>>>>> +INSN(STX3,   "r%d, -X", a->rr)
>>>>> +INSN(STY2,   "r%d, Y+", a->rd)
>>>>> +INSN(STY3,   "r%d, -Y", a->rd)
>>>>> +INSN(STZ2,   "r%d, Z+", a->rd)
>>>>> +INSN(STZ3,   "r%d, -Z", a->rd)
>>>>> +INSN(SUB,    "r%d, r%d", a->rd, a->rr)
>>>>> +INSN(SUBI,   "r%d, %d", a->rd, a->imm)
>>>>> +INSN(SWAP,   "r%d", a->rd)
>>>>> +INSN(WDR,    "")
>>>>> +INSN(XCH,    "Z, r%d", a->rd)
>>>>> +
>>>>> diff --git a/target/avr/translate.c b/target/avr/translate.c
>>>>> index c8c6f798bf..a621195817 100644
>>>>> --- a/target/avr/translate.c
>>>>> +++ b/target/avr/translate.c
>>>>> @@ -2917,6 +2917,17 @@ done_generating:
>>>>>
>>>>>      tb->size =3D (ctx.npc - pc_start) * 2;
>>>>>      tb->icount =3D num_insns;
>>>>> +
>>>>> +#ifdef DEBUG_DISAS
>>>>> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
>>>>> +        && qemu_log_in_addr_range(tb->pc)) {
>>>>> +        qemu_log_lock();
>>>>> +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
>>>>> +        log_target_disas(cs, tb->pc, tb->size);
>>>>> +        qemu_log("\n");
>>>>> +        qemu_log_unlock();
>>>>> +    }
>>>>> +#endif
>>>>>  }
>>>>>
>>>>>  void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
>>>>> --
>>>>> 2.17.2 (Apple Git-113)
>>>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik

