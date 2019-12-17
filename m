Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76577206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELMsKSH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76577206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihKLr-0003z9-Iw
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 16:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihKKr-0003AG-Ui
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihKKm-0004j6-IM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:24:53 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:45937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihKKm-0004Xh-8h
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:24:48 -0500
Received: by mail-qk1-x744.google.com with SMTP id x1so9527180qkl.12
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wrM7rB9pVHT5V1kK2pPGKlRMapQ1S/b61bhQoEHgAhs=;
 b=ELMsKSH+2SlWHaScRPJBNmh27QycbB1tyjfzdXp5GJaqYmV2+iyJuQkP5iQW8UmyuI
 gGox+rVd8fMkcgOjCGEok2bF4QOzaUsWWoR3v7sgpySnq2rvfxRZ8/qpQ8k8+gS6MYj8
 fwhnMMIhBUbwilyT3yvuFImGMOF+TMNB5kUjdvAQVMceQ0b3sSs/+tZTempkuZrgP/dA
 kYp5ebaGA6tRFqOK/toCBZJTQjXaPgfidHCgKTnOzsDcPSyhPnAIJW/iD2m6N+EDScK5
 l8p3kxt7H9nGrRMmO4Znl18/mS9/p1WKD3jVWAodbgYP7p31g4x+rlgkPryPKIUqMNnm
 B7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wrM7rB9pVHT5V1kK2pPGKlRMapQ1S/b61bhQoEHgAhs=;
 b=lrem+uVwrouUEtX6Zfy2eWqi6BMvnsLAgAGoiIEtMVSK574HPDyx+PWFftWTXm7n99
 kTQ3urcRJPmuvoP7I8gsh3nipphMlyCB2PP8eRLpYFmS9FpSmoANWJyzlHi+xRzuH/rF
 k2l6hgUq1IcmLdQ3J4xx8mVEhLmo7B+kitcGgJ5T7gCSO7HO+b8l2UoawFqhd2U5J6Zp
 GTS6VxXz+O1/tUmISNzLWZZmTbMfvRlUBEmQGz/5y3KuiEv/qfaLJR8a5DqvBDELoI04
 6iFEAoe3f65XszXXwLNKFYHK0kuNB2c+ffM4eEWo4qdiLKZnKtZ2YdQE+SD/amn23P9C
 POyg==
X-Gm-Message-State: APjAAAUxtbEbl1IFFepWz1KFY+3kQ92iIBtO+4yk2+Ede7zNuJ36vT14
 bl3x18V3ydwj8bTZXnGSOdaABtKlk/uAaFM5Pxg=
X-Google-Smtp-Source: APXvYqxI7qIGxpbA9mTO9q4Avd2KYHJVla3nMi/tBPyvU75uSZIfjvnmYsQ89HF+dvMgmIk/77UyGtQMWGvN9R8Uc28=
X-Received: by 2002:a37:7443:: with SMTP id p64mr20122qkc.460.1576617886910;
 Tue, 17 Dec 2019 13:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20191208183922.13757-1-mrolnik@gmail.com>
 <20191208183922.13757-12-mrolnik@gmail.com>
 <CAL1e-=iPsFgtEmvT2xt-Fm8AiQBxq48_veVDcnnyMEqghF16hw@mail.gmail.com>
 <CAK4993ipego3-ELy82A85Rcd=PDiqCF0M5-COpHPUTL6UjVQZQ@mail.gmail.com>
 <CAL1e-=gkGa0GCjSMm1QK+KrsnSts_1ZgvcjjP6acCVt7xP3ZpQ@mail.gmail.com>
 <CAK4993jAANG-P_FeWhzu0ncZdiDEn=moWQ=qPKjNS_7SxzPFUQ@mail.gmail.com>
 <CAL1e-=i-PViLdw1bT2JXnMf_MdKdswAGBFvYsWSbCRrgcmd_tQ@mail.gmail.com>
In-Reply-To: <CAL1e-=i-PViLdw1bT2JXnMf_MdKdswAGBFvYsWSbCRrgcmd_tQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 17 Dec 2019 23:24:00 +0200
Message-ID: <CAK4993iBnFL18MLr-v_cCkvnUmQ+nnmbs_HNgdPRSdPQNJvNng@mail.gmail.com>
Subject: Re: [PATCH v38 11/22] target/avr: Add instruction disassembly function
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000001891e70599ecf5e9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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

--0000000000001891e70599ecf5e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Aleksandar.

1. inst.decode file
2. avr features are not accessible from avr_print_insn as it does not
receive a pointer to CPU context. So, there is not way to inform the user
that some instructions are not supported unless I define several
different avr_print_insn functions.

Regards,
Michael Rolnik



On Thu, Dec 12, 2019 at 11:12 AM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Tue, Dec 10, 2019 at 8:18 AM Michael Rolnik <mrolnik@gmail.com> wrote:
> >
> > You are right. See at the bottom of the file. There is a comment about =
it
> >
>
> Sorry, what file?
>
> I also see that you disassemble instructions regardless of what AVR
> CPU the current executable is built for, don't you? OK, not a very big
> deal, but can be confusing for end user if disassembly text of an
> instruction that is not supported by a particular CPU is displayed as
> if it is supported.
>
> > Sent from my cell phone, please ignore typos
> >
> > On Tue, Dec 10, 2019, 6:21 AM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
> >>
> >>
> >>
> >> On Monday, December 9, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:
> >>>
> >>> Hi Aleksandar.
> >>>
> >>> 1. all instructions are 16 bit long except CALL & JMP they are 32 bit
> long
> >>
> >>
> >> Accordingto the doc, LDS and STS also have 32-bit coding.
> >>
> >>
> >>>
> >>> 2. next_word_used is set to true by next_word when called by append_1=
6
> when CALL & JMP are parsed
> >>>
> >>> Regards,
> >>> Michael Rolnik
> >>>
> >>> On Mon, Dec 9, 2019 at 8:10 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On Sunday, December 8, 2019, Michael Rolnik <mrolnik@gmail.com>
> wrote:
> >>>>>
> >>>>> Provide function disassembles executed instruction when `-d in_asm`
> is
> >>>>> provided
> >>>>>
> >>>>> Example:
> >>>>> `./avr-softmmu/qemu-system-avr -bios
> free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf -d in_asm` will produce
> something like the following
> >>>>>
> >>>>> ```
> >>>>>     ...
> >>>>>     IN:
> >>>>>     0x0000014a:  CALL      0x3808
> >>>>>
> >>>>>     IN: main
> >>>>>     0x00003808:  CALL      0x4b4
> >>>>>
> >>>>>     IN: vParTestInitialise
> >>>>>     0x000004b4:  LDI       r24, 255
> >>>>>     0x000004b6:  STS       r24, 0
> >>>>>     0x000004b8:  MULS      r16, r20
> >>>>>     0x000004ba:  OUT       $1, r24
> >>>>>     0x000004bc:  LDS       r24, 0
> >>>>>     0x000004be:  MULS      r16, r20
> >>>>>     0x000004c0:  OUT       $2, r24
> >>>>>     0x000004c2:  RET
> >>>>>     ...
> >>>>> ```
> >>>>>
> >>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> >>>>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> >>>>> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>>> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> >>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>>> ---
> >>>>>  target/avr/cpu.h       |   1 +
> >>>>>  target/avr/cpu.c       |   2 +-
> >>>>>  target/avr/disas.c     | 226
> +++++++++++++++++++++++++++++++++++++++++
> >>>>>  target/avr/translate.c |  11 ++
> >>>>>  4 files changed, 239 insertions(+), 1 deletion(-)
> >>>>>  create mode 100644 target/avr/disas.c
> >>>>>
> >>>>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> >>>>> index c217eefeb4..a8a3e7ade6 100644
> >>>>> --- a/target/avr/cpu.h
> >>>>> +++ b/target/avr/cpu.h
> >>>>> @@ -178,6 +178,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int
> int_req);
> >>>>>  hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >>>>>  int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg=
);
> >>>>>  int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int
> reg);
> >>>>> +int avr_print_insn(bfd_vma addr, disassemble_info *info);
> >>>>>
> >>>>>  static inline int avr_feature(CPUAVRState *env, int feature)
> >>>>>  {
> >>>>> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> >>>>> index c5cafcae3c..be4b921e4d 100644
> >>>>> --- a/target/avr/cpu.c
> >>>>> +++ b/target/avr/cpu.c
> >>>>> @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
> >>>>>  static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
> *info)
> >>>>>  {
> >>>>>      info->mach =3D bfd_arch_avr;
> >>>>> -    info->print_insn =3D NULL;
> >>>>> +    info->print_insn =3D avr_print_insn;
> >>>>>  }
> >>>>>
> >>>>>  static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> >>>>> diff --git a/target/avr/disas.c b/target/avr/disas.c
> >>>>> new file mode 100644
> >>>>> index 0000000000..22863d2eb1
> >>>>> --- /dev/null
> >>>>> +++ b/target/avr/disas.c
> >>>>> @@ -0,0 +1,226 @@
> >>>>> +/*
> >>>>> + * AVR disassembler
> >>>>> + *
> >>>>> + * Copyright (c) 2019 Richard Henderson <rth@twiddle.net>
> >>>>> + * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
> >>>>> + *
> >>>>> + * This program is free software: you can redistribute it and/or
> modify
> >>>>> + * it under the terms of the GNU General Public License as
> published by
> >>>>> + * the Free Software Foundation, either version 2 of the License, =
or
> >>>>> + * (at your option) any later version.
> >>>>> + *
> >>>>> + * This program is distributed in the hope that it will be useful,
> >>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>>> + * GNU General Public License for more details.
> >>>>> + *
> >>>>> + * You should have received a copy of the GNU General Public Licen=
se
> >>>>> + * along with this program.  If not, see <
> http://www.gnu.org/licenses/>.
> >>>>> + */
> >>>>> +
> >>>>> +#include "qemu/osdep.h"
> >>>>> +#include "cpu.h"
> >>>>> +
> >>>>> +typedef struct {
> >>>>> +    disassemble_info *info;
> >>>>> +    uint16_t next_word;
> >>>>> +    bool next_word_used;
> >>>>> +} DisasContext;
> >>>>> +
> >>>>> +static int to_regs_16_31_by_one(DisasContext *ctx, int indx)
> >>>>> +{
> >>>>> +    return 16 + (indx % 16);
> >>>>> +}
> >>>>> +
> >>>>> +static int to_regs_16_23_by_one(DisasContext *ctx, int indx)
> >>>>> +{
> >>>>> +    return 16 + (indx % 8);
> >>>>> +}
> >>>>> +static int to_regs_24_30_by_two(DisasContext *ctx, int indx)
> >>>>> +{
> >>>>> +    return 24 + (indx % 4) * 2;
> >>>>> +}
> >>>>> +static int to_regs_00_30_by_two(DisasContext *ctx, int indx)
> >>>>> +{
> >>>>> +    return (indx % 16) * 2;
> >>>>> +}
> >>>>> +
> >>>>> +static uint16_t next_word(DisasContext *ctx)
> >>>>> +{
> >>>>> +    ctx->next_word_used =3D true;
> >>>>> +    return ctx->next_word;
> >>>>> +}
> >>>>> +
> >>>>> +static int append_16(DisasContext *ctx, int x)
> >>>>> +{
> >>>>> +    return x << 16 | next_word(ctx);
> >>>>> +}
> >>>>> +
> >>>>> +
> >>>>> +/* Include the auto-generated decoder.  */
> >>>>> +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> >>>>> +#include "decode_insn.inc.c"
> >>>>> +
> >>>>> +#define output(mnemonic, format, ...) \
> >>>>> +    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, =
\
> >>>>> +                        mnemonic, ##__VA_ARGS__))
> >>>>> +
> >>>>> +int avr_print_insn(bfd_vma addr, disassemble_info *info)
> >>>>> +{
> >>>>> +    DisasContext ctx;
> >>>>> +    DisasContext *pctx =3D &ctx;
> >>>>> +    bfd_byte buffer[4];
> >>>>> +    uint16_t insn;
> >>>>> +    int status;
> >>>>> +
> >>>>> +    ctx.info =3D info;
> >>>>> +
> >>>>> +    status =3D info->read_memory_func(addr, buffer, 4, info);
> >>>>> +    if (status !=3D 0) {
> >>>>> +        info->memory_error_func(status, addr, info);
> >>>>> +        return -1;
> >>>>> +    }
> >>>>> +    insn =3D bfd_getl16(buffer);
> >>>>> +    ctx.next_word =3D bfd_getl16(buffer + 2);
> >>>>> +    ctx.next_word_used =3D false;
> >>>>> +
> >>>>> +    if (!decode_insn(&ctx, insn)) {
> >>>>> +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
> >>>>> +    }
> >>>>> +
> >>>>> +    return ctx.next_word_used ? 4 : 2;
> >>>>> +}
> >>>>
> >>>>
> >>>> Hi, Michael,
> >>>>
> >>>> What is the role of ctx.next_word_used, if it looks it is always
> "false"?
> >>>>
> >>>> Related to this, how do you disassemble 32-bit-coded instructions?
> From this patch, it looks you treat all AVR instructions as 16-bit-coded?
> >>>>
> >>>> Thanks,
> >>>> Aleksandar
> >>>>
> >>>>>
> >>>>> +
> >>>>> +
> >>>>> +#define INSN(opcode, format, ...)
>      \
> >>>>> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
>     \
> >>>>> +{
>      \
> >>>>> +    output(#opcode, format, ##__VA_ARGS__);
>      \
> >>>>> +    return true;
>     \
> >>>>> +}
> >>>>> +
> >>>>> +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)
>     \
> >>>>> +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
>     \
> >>>>> +{
>      \
> >>>>> +    output(mnemonic, format, ##__VA_ARGS__);
>     \
> >>>>> +    return true;
>     \
> >>>>> +}
> >>>>> +
> >>>>> +/*
> >>>>> + *   C       Z       N       V       S       H       T       I
> >>>>> + *   0       1       2       3       4       5       6       7
> >>>>> + */
> >>>>> +static const char *brbc[] =3D {
> >>>>> +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
> >>>>> +};
> >>>>> +
> >>>>> +static const char *brbs[] =3D {
> >>>>> +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
> >>>>> +};
> >>>>> +
> >>>>> +static const char *bset[] =3D {
> >>>>> +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
> >>>>> +};
> >>>>> +
> >>>>> +static const char *bclr[] =3D {
> >>>>> +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
> >>>>> +};
> >>>>> +
> >>>>> +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> >>>>> +INSN(AND,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(ANDI,   "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(ASR,    "r%d", a->rd)
> >>>>> +INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
> >>>>> +INSN(BLD,    "r%d, %d", a->rd, a->bit)
> >>>>> +INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
> >>>>> +INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
> >>>>> +INSN(BREAK,  "")
> >>>>> +INSN_MNEMONIC(BSET,  bset[a->bit], "")
> >>>>> +INSN(BST,    "r%d, %d", a->rd, a->bit)
> >>>>> +INSN(CALL,   "0x%x", a->imm * 2)
> >>>>> +INSN(CBI,    "%d, %d", a->reg, a->bit)
> >>>>> +INSN(COM,    "r%d", a->rd)
> >>>>> +INSN(CP,     "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(CPC,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(CPI,    "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(DEC,    "r%d", a->rd)
> >>>>> +INSN(DES,    "%d", a->imm)
> >>>>> +INSN(EICALL, "")
> >>>>> +INSN(EIJMP,  "")
> >>>>> +INSN(ELPM1,  "")
> >>>>> +INSN(ELPM2,  "r%d, Z", a->rd)
> >>>>> +INSN(ELPMX,  "r%d, Z+", a->rd)
> >>>>> +INSN(EOR,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(ICALL,  "")
> >>>>> +INSN(IJMP,   "")
> >>>>> +INSN(IN,     "r%d, $%d", a->rd, a->imm)
> >>>>> +INSN(INC,    "r%d", a->rd)
> >>>>> +INSN(JMP,    "0x%x", a->imm * 2)
> >>>>> +INSN(LAC,    "Z, r%d", a->rd)
> >>>>> +INSN(LAS,    "Z, r%d", a->rd)
> >>>>> +INSN(LAT,    "Z, r%d", a->rd)
> >>>>> +INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
> >>>>> +INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
> >>>>> +INSN(LDI,    "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(LDS,    "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(LDX1,   "r%d, X", a->rd)
> >>>>> +INSN(LDX2,   "r%d, X+", a->rd)
> >>>>> +INSN(LDX3,   "r%d, -X", a->rd)
> >>>>> +INSN(LDY2,   "r%d, Y+", a->rd)
> >>>>> +INSN(LDY3,   "r%d, -Y", a->rd)
> >>>>> +INSN(LDZ2,   "r%d, Z+", a->rd)
> >>>>> +INSN(LDZ3,   "r%d, -Z", a->rd)
> >>>>> +INSN(LPM1,   "")
> >>>>> +INSN(LPM2,   "r%d, Z", a->rd)
> >>>>> +INSN(LPMX,   "r%d, Z+", a->rd)
> >>>>> +INSN(LSR,    "r%d", a->rd)
> >>>>> +INSN(MOV,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1,
> a->rr)
> >>>>> +INSN(MUL,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(MULS,   "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(NEG,    "r%d", a->rd)
> >>>>> +INSN(NOP,    "")
> >>>>> +INSN(OR,     "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(ORI,    "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(OUT,    "$%d, r%d", a->imm, a->rd)
> >>>>> +INSN(POP,    "r%d", a->rd)
> >>>>> +INSN(PUSH,   "r%d", a->rd)
> >>>>> +INSN(RCALL,  ".%+d", a->imm * 2)
> >>>>> +INSN(RET,    "")
> >>>>> +INSN(RETI,   "")
> >>>>> +INSN(RJMP,   ".%+d", a->imm * 2)
> >>>>> +INSN(ROR,    "r%d", a->rd)
> >>>>> +INSN(SBC,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(SBCI,   "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(SBI,    "$%d, %d", a->reg, a->bit)
> >>>>> +INSN(SBIC,   "$%d, %d", a->reg, a->bit)
> >>>>> +INSN(SBIS,   "$%d, %d", a->reg, a->bit)
> >>>>> +INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> >>>>> +INSN(SBRC,   "r%d, %d", a->rr, a->bit)
> >>>>> +INSN(SBRS,   "r%d, %d", a->rr, a->bit)
> >>>>> +INSN(SLEEP,  "")
> >>>>> +INSN(SPM,    "")
> >>>>> +INSN(SPMX,   "Z+")
> >>>>> +INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
> >>>>> +INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
> >>>>> +INSN(STS,    "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(STX1,   "r%d, X", a->rr)
> >>>>> +INSN(STX2,   "r%d, X+", a->rr)
> >>>>> +INSN(STX3,   "r%d, -X", a->rr)
> >>>>> +INSN(STY2,   "r%d, Y+", a->rd)
> >>>>> +INSN(STY3,   "r%d, -Y", a->rd)
> >>>>> +INSN(STZ2,   "r%d, Z+", a->rd)
> >>>>> +INSN(STZ3,   "r%d, -Z", a->rd)
> >>>>> +INSN(SUB,    "r%d, r%d", a->rd, a->rr)
> >>>>> +INSN(SUBI,   "r%d, %d", a->rd, a->imm)
> >>>>> +INSN(SWAP,   "r%d", a->rd)
> >>>>> +INSN(WDR,    "")
> >>>>> +INSN(XCH,    "Z, r%d", a->rd)
> >>>>> +
> >>>>> diff --git a/target/avr/translate.c b/target/avr/translate.c
> >>>>> index c8c6f798bf..a621195817 100644
> >>>>> --- a/target/avr/translate.c
> >>>>> +++ b/target/avr/translate.c
> >>>>> @@ -2917,6 +2917,17 @@ done_generating:
> >>>>>
> >>>>>      tb->size =3D (ctx.npc - pc_start) * 2;
> >>>>>      tb->icount =3D num_insns;
> >>>>> +
> >>>>> +#ifdef DEBUG_DISAS
> >>>>> +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> >>>>> +        && qemu_log_in_addr_range(tb->pc)) {
> >>>>> +        qemu_log_lock();
> >>>>> +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
> >>>>> +        log_target_disas(cs, tb->pc, tb->size);
> >>>>> +        qemu_log("\n");
> >>>>> +        qemu_log_unlock();
> >>>>> +    }
> >>>>> +#endif
> >>>>>  }
> >>>>>
> >>>>>  void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
> >>>>> --
> >>>>> 2.17.2 (Apple Git-113)
> >>>>>
> >>>
> >>>
> >>> --
> >>> Best Regards,
> >>> Michael Rolnik
>


--=20
Best Regards,
Michael Rolnik

--0000000000001891e70599ecf5e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Aleksandar.</div><div><br></div><div>1. inst.decode f=
ile</div>2. avr features are not accessible from=C2=A0avr_print_insn as it =
does not receive a pointer to CPU context. So, there is not way to inform t=
he user that some instructions are not supported unless I define several di=
fferent=C2=A0avr_print_insn functions.<div><br></div><div>Regards,</div><di=
v>Michael Rolnik<br><div><br></div><div><br></div></div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 12, 201=
9 at 11:12 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@g=
mail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On Tue, Dec 10, 2019 at 8:18 AM Michae=
l Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik=
@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; You are right. See at the bottom of the file. There is a comment about=
 it<br>
&gt;<br>
<br>
Sorry, what file?<br>
<br>
I also see that you disassemble instructions regardless of what AVR<br>
CPU the current executable is built for, don&#39;t you? OK, not a very big<=
br>
deal, but can be confusing for end user if disassembly text of an<br>
instruction that is not supported by a particular CPU is displayed as<br>
if it is supported.<br>
<br>
&gt; Sent from my cell phone, please ignore typos<br>
&gt;<br>
&gt; On Tue, Dec 10, 2019, 6:21 AM Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.co=
m</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Monday, December 9, 2019, Michael Rolnik &lt;<a href=3D"mailto:=
mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Aleksandar.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 1. all instructions are 16 bit long except CALL &amp; JMP they=
 are 32 bit long<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Accordingto the doc, LDS and STS also have 32-bit coding.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 2. next_word_used is set to true by next_word when called by a=
ppend_16 when CALL &amp; JMP are parsed<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt; Michael Rolnik<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Mon, Dec 9, 2019 at 8:10 PM Aleksandar Markovic &lt;<a href=
=3D"mailto:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail=
@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Sunday, December 8, 2019, Michael Rolnik &lt;<a href=3D=
"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt; wrot=
e:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Provide function disassembles executed instruction whe=
n `-d in_asm` is<br>
&gt;&gt;&gt;&gt;&gt; provided<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Example:<br>
&gt;&gt;&gt;&gt;&gt; `./avr-softmmu/qemu-system-avr -bios free-rtos/Demo/AV=
R_ATMega2560_GCC/demo.elf -d in_asm` will produce something like the follow=
ing<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0IN:<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x0000014a:=C2=A0 CALL=C2=A0 =C2=A0=
 =C2=A0 0x3808<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0IN: main<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x00003808:=C2=A0 CALL=C2=A0 =C2=A0=
 =C2=A0 0x4b4<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0IN: vParTestInitialise<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004b4:=C2=A0 LDI=C2=A0 =C2=A0 =
=C2=A0 =C2=A0r24, 255<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004b6:=C2=A0 STS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0r24, 0<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004b8:=C2=A0 MULS=C2=A0 =C2=A0=
 =C2=A0 r16, r20<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004ba:=C2=A0 OUT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0$1, r24<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004bc:=C2=A0 LDS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0r24, 0<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004be:=C2=A0 MULS=C2=A0 =C2=A0=
 =C2=A0 r16, r20<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004c0:=C2=A0 OUT=C2=A0 =C2=A0 =
=C2=A0 =C2=A0$2, r24<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A00x000004c2:=C2=A0 RET<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mr=
olnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Suggested-by: Richard Henderson &lt;<a href=3D"mailto:=
richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.or=
g</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Suggested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<b=
r>
&gt;&gt;&gt;&gt;&gt; Suggested-by: Aleksandar Markovic &lt;<a href=3D"mailt=
o:aleksandar.m.mail@gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.co=
m</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<b=
r>
&gt;&gt;&gt;&gt;&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"=
mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 +<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A02 +-<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 target/avr/disas.c=C2=A0 =C2=A0 =C2=A0| 226 ++++=
+++++++++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 target/avr/translate.c |=C2=A0 11 ++<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 4 files changed, 239 insertions(+), 1 deletion(-=
)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 create mode 100644 target/avr/disas.c<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt;&gt;&gt;&gt;&gt; index c217eefeb4..a8a3e7ade6 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/target/avr/cpu.h<br>
&gt;&gt;&gt;&gt;&gt; +++ b/target/avr/cpu.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -178,6 +178,7 @@ bool avr_cpu_exec_interrupt(CPUSta=
te *cpu, int int_req);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu=
, vaddr addr);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 int avr_cpu_gdb_read_register(CPUState *cpu, uin=
t8_t *buf, int reg);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 int avr_cpu_gdb_write_register(CPUState *cpu, ui=
nt8_t *buf, int reg);<br>
&gt;&gt;&gt;&gt;&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *in=
fo);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 static inline int avr_feature(CPUAVRState *env, =
int feature)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; index c5cafcae3c..be4b921e4d 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/target/avr/cpu.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *=
cs)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 static void avr_cpu_disas_set_info(CPUState *cpu=
, disassemble_info *info)<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 {<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 info-&gt;mach =3D bfd_arch_avr;<br=
>
&gt;&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 info-&gt;print_insn =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 info-&gt;print_insn =3D avr_print_insn;=
<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 static void avr_cpu_realizefn(DeviceState *dev, =
Error **errp)<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/target/avr/disas.c b/target/avr/disas.c<b=
r>
&gt;&gt;&gt;&gt;&gt; new file mode 100644<br>
&gt;&gt;&gt;&gt;&gt; index 0000000000..22863d2eb1<br>
&gt;&gt;&gt;&gt;&gt; --- /dev/null<br>
&gt;&gt;&gt;&gt;&gt; +++ b/target/avr/disas.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -0,0 +1,226 @@<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + * AVR disassembler<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * Copyright (c) 2019 Richard Henderson &lt;<a href=
=3D"mailto:rth@twiddle.net" target=3D"_blank">rth@twiddle.net</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; + * Copyright (c) 2019 Michael Rolnik &lt;<a href=3D"m=
ailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This program is free software: you can redistribut=
e it and/or modify<br>
&gt;&gt;&gt;&gt;&gt; + * it under the terms of the GNU General Public Licen=
se as published by<br>
&gt;&gt;&gt;&gt;&gt; + * the Free Software Foundation, either version 2 of =
the License, or<br>
&gt;&gt;&gt;&gt;&gt; + * (at your option) any later version.<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * This program is distributed in the hope that it wi=
ll be useful,<br>
&gt;&gt;&gt;&gt;&gt; + * but WITHOUT ANY WARRANTY; without even the implied=
 warranty of<br>
&gt;&gt;&gt;&gt;&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.=C2=A0 See the<br>
&gt;&gt;&gt;&gt;&gt; + * GNU General Public License for more details.<br>
&gt;&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt;&gt; + * You should have received a copy of the GNU General=
 Public License<br>
&gt;&gt;&gt;&gt;&gt; + * along with this program.=C2=A0 If not, see &lt;<a =
href=3D"http://www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">=
http://www.gnu.org/licenses/</a>&gt;.<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt;&gt;&gt;&gt;&gt; +#include &quot;cpu.h&quot;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +typedef struct {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 disassemble_info *info;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint16_t next_word;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 bool next_word_used;<br>
&gt;&gt;&gt;&gt;&gt; +} DisasContext;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static int to_regs_16_31_by_one(DisasContext *ctx, in=
t indx)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return 16 + (indx % 16);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static int to_regs_16_23_by_one(DisasContext *ctx, in=
t indx)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return 16 + (indx % 8);<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +static int to_regs_24_30_by_two(DisasContext *ctx, in=
t indx)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return 24 + (indx % 4) * 2;<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +static int to_regs_00_30_by_two(DisasContext *ctx, in=
t indx)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return (indx % 16) * 2;<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static uint16_t next_word(DisasContext *ctx)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ctx-&gt;next_word_used =3D true;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return ctx-&gt;next_word;<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static int append_16(DisasContext *ctx, int x)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<=
br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/* Include the auto-generated decoder.=C2=A0 */<br>
&gt;&gt;&gt;&gt;&gt; +static bool decode_insn(DisasContext *ctx, uint16_t i=
nsn);<br>
&gt;&gt;&gt;&gt;&gt; +#include &quot;decode_insn.inc.c&quot;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#define output(mnemonic, format, ...) \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 (pctx-&gt;info-&gt;fprintf_func(pctx-&g=
t;info-&gt;stream, &quot;%-9s &quot; format, \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mnemonic, ##__VA_ARGS__))<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *in=
fo)<br>
&gt;&gt;&gt;&gt;&gt; +{<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DisasContext ctx;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 DisasContext *pctx =3D &amp;ctx;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 bfd_byte buffer[4];<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 uint16_t insn;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 int status;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 <a href=3D"http://ctx.info" rel=3D"nore=
ferrer" target=3D"_blank">ctx.info</a> =3D info;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 status =3D info-&gt;read_memory_func(ad=
dr, buffer, 4, info);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (status !=3D 0) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;memory_error_fun=
c(status, addr, info);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 insn =3D bfd_getl16(buffer);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ctx.next_word =3D bfd_getl16(buffer + 2=
);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 ctx.next_word_used =3D false;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (!decode_insn(&amp;ctx, insn)) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 output(&quot;.db&quot;, &=
quot;0x%02x, 0x%02x&quot;, buffer[0], buffer[1]);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return ctx.next_word_used ? 4 : 2;<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi, Michael,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; What is the role of ctx.next_word_used, if it looks it is =
always &quot;false&quot;?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Related to this, how do you disassemble 32-bit-coded instr=
uctions? From this patch, it looks you treat all AVR instructions as 16-bit=
-coded?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; Aleksandar<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#define INSN(opcode, format, ...)=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##=
opcode * a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 output(#opcode, format, ##__VA_ARGS__);=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##=
opcode * a)=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 output(mnemonic, format, ##__VA_ARGS__)=
;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 \<br>
&gt;&gt;&gt;&gt;&gt; +}<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +/*<br>
&gt;&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A0C=C2=A0 =C2=A0 =C2=A0 =C2=A0Z=C2=A0 =
=C2=A0 =C2=A0 =C2=A0N=C2=A0 =C2=A0 =C2=A0 =C2=A0V=C2=A0 =C2=A0 =C2=A0 =C2=
=A0S=C2=A0 =C2=A0 =C2=A0 =C2=A0H=C2=A0 =C2=A0 =C2=A0 =C2=A0T=C2=A0 =C2=A0 =
=C2=A0 =C2=A0I<br>
&gt;&gt;&gt;&gt;&gt; + *=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =
=C2=A0 =C2=A0 =C2=A02=C2=A0 =C2=A0 =C2=A0 =C2=A03=C2=A0 =C2=A0 =C2=A0 =C2=
=A04=C2=A0 =C2=A0 =C2=A0 =C2=A05=C2=A0 =C2=A0 =C2=A0 =C2=A06=C2=A0 =C2=A0 =
=C2=A0 =C2=A07<br>
&gt;&gt;&gt;&gt;&gt; + */<br>
&gt;&gt;&gt;&gt;&gt; +static const char *brbc[] =3D {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 &quot;BRCC&quot;, &quot;BRNE&quot;, &qu=
ot;BRPL&quot;, &quot;BRVC&quot;, &quot;BRGE&quot;, &quot;BRHC&quot;, &quot;=
BRTC&quot;, &quot;BRID&quot;<br>
&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static const char *brbs[] =3D {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 &quot;BRCS&quot;, &quot;BREQ&quot;, &qu=
ot;BRMI&quot;, &quot;BRVS&quot;, &quot;BRLT&quot;, &quot;BRHS&quot;, &quot;=
BRTS&quot;, &quot;BRIE&quot;<br>
&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static const char *bset[] =3D {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 &quot;SEC&quot;,=C2=A0 &quot;SEZ&quot;,=
=C2=A0 &quot;SEN&quot;,=C2=A0 &quot;SEZ&quot;,=C2=A0 &quot;SES&quot;,=C2=A0=
 &quot;SEH&quot;,=C2=A0 &quot;SET&quot;,=C2=A0 &quot;SEI&quot;<br>
&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +static const char *bclr[] =3D {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 &quot;CLC&quot;,=C2=A0 &quot;CLZ&quot;,=
=C2=A0 &quot;CLN&quot;,=C2=A0 &quot;CLZ&quot;,=C2=A0 &quot;CLS&quot;,=C2=A0=
 &quot;CLH&quot;,=C2=A0 &quot;CLT&quot;,=C2=A0 &quot;CLI&quot;<br>
&gt;&gt;&gt;&gt;&gt; +};<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ADC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ADD,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%d, %d&quot;, a-&gt=
;rd + 1, a-&gt;rd, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(AND,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ANDI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ASR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN_MNEMONIC(BCLR,=C2=A0 bclr[a-&gt;bit], &quot;&quo=
t;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(BLD,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN_MNEMONIC(BRBC,=C2=A0 brbc[a-&gt;bit], &quot;.%+d=
&quot;, a-&gt;imm * 2)<br>
&gt;&gt;&gt;&gt;&gt; +INSN_MNEMONIC(BRBS,=C2=A0 brbs[a-&gt;bit], &quot;.%+d=
&quot;, a-&gt;imm * 2)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(BREAK,=C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN_MNEMONIC(BSET,=C2=A0 bset[a-&gt;bit], &quot;&quo=
t;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(BST,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CALL,=C2=A0 =C2=A0&quot;0x%x&quot;, a-&gt;imm * =
2)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CBI,=C2=A0 =C2=A0 &quot;%d, %d&quot;, a-&gt;reg,=
 a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(COM,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CP,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&=
gt;rd, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CPC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CPI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(CPSE,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(DEC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(DES,=C2=A0 =C2=A0 &quot;%d&quot;, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(EICALL, &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(EIJMP,=C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ELPM1,=C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ELPM2,=C2=A0 &quot;r%d, Z&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ELPMX,=C2=A0 &quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(EOR,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(FMUL,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(FMULS,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&=
gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(FMULSU, &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr=
)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ICALL,=C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(IJMP,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(IN,=C2=A0 =C2=A0 =C2=A0&quot;r%d, $%d&quot;, a-&=
gt;rd, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(INC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(JMP,=C2=A0 =C2=A0 &quot;0x%x&quot;, a-&gt;imm * =
2)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LAC,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(LAS,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(LAT,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;r=
d, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;r=
d, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LDZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LPM1,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LPM2,=C2=A0 =C2=A0&quot;r%d, Z&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(LPMX,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(LSR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(MOV,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(MOVW,=C2=A0 =C2=A0&quot;r%d:r%d, r%d,r:r%d&quot;=
, a-&gt;rd + 1, a-&gt;rd, a-&gt;rr + 1, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(MUL,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(MULS,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(MULSU,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&=
gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(NEG,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(NOP,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(OR,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&=
gt;rd, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ORI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(OUT,=C2=A0 =C2=A0 &quot;$%d, r%d&quot;, a-&gt;im=
m, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(POP,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(PUSH,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(RCALL,=C2=A0 &quot;.%+d&quot;, a-&gt;imm * 2)<br=
>
&gt;&gt;&gt;&gt;&gt; +INSN(RET,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(RETI,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(RJMP,=C2=A0 =C2=A0&quot;.%+d&quot;, a-&gt;imm * =
2)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(ROR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBCI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBI,=C2=A0 =C2=A0 &quot;$%d, %d&quot;, a-&gt;reg=
, a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBIC,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg=
, a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBIS,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg=
, a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBIW,=C2=A0 =C2=A0&quot;r%d:r%d, %d&quot;, a-&gt=
;rd + 1, a-&gt;rd, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBRC,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr,=
 a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SBRS,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr,=
 a-&gt;bit)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SLEEP,=C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SPM,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SPMX,=C2=A0 =C2=A0&quot;Z+&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;r=
d, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;r=
d, a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rr)<=
br>
&gt;&gt;&gt;&gt;&gt; +INSN(STX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rr)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rr)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(STZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)=
<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SUB,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd=
, a-&gt;rr)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SUBI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd,=
 a-&gt;imm)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(SWAP,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(WDR,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt;&gt;&gt;&gt;&gt; +INSN(XCH,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<=
br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/target/avr/translate.c b/target/avr/trans=
late.c<br>
&gt;&gt;&gt;&gt;&gt; index c8c6f798bf..a621195817 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/target/avr/translate.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/target/avr/translate.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -2917,6 +2917,17 @@ done_generating:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 tb-&gt;size =3D (ctx.npc - pc_star=
t) * 2;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 tb-&gt;icount =3D num_insns;<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +#ifdef DEBUG_DISAS<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (qemu_loglevel_mask(CPU_LOG_TB_IN_AS=
M)<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; qemu_log_in_ad=
dr_range(tb-&gt;pc)) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_lock();<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IN: %s\n&q=
uot;, lookup_symbol(tb-&gt;pc));<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_target_disas(cs, tb-&=
gt;pc, tb-&gt;size);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;\n&quot;);=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_unlock();<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +#endif<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 void restore_state_to_opc(CPUAVRState *env, Tran=
slationBlock *tb,<br>
&gt;&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt;&gt; 2.17.2 (Apple Git-113)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; Best Regards,<br>
&gt;&gt;&gt; Michael Rolnik<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--0000000000001891e70599ecf5e9--

