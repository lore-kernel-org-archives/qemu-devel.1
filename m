Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C282CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C252071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 06:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r335ElN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C252071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZqjM-0006xr-Hz
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 01:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iZqiT-0006WK-8b
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iZqiO-0005d6-HK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:22:21 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:40569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iZqiO-0005cn-AF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 01:22:16 -0500
Received: by mail-qt1-x835.google.com with SMTP id z22so3399563qto.7
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 22:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xE5eD0s26uDLHllZ9oGxZszEhShWcHPN8etwhSpNAkQ=;
 b=r335ElN3JKFERZhbA3yVjkHQQ9lqMCW/LVZ4fS/Tc2uk38LaT1leTBY4MnWfYENVgN
 akx6D21/jp0aJtgMIClqbVJM+WjrQpVYTl6GnDDZzWmup0iQqgFMxGUvbn7fR5kSqWdd
 aSUadpj3YcFi8lVBiGCVTAF7wFSFEp9sUQIRj8jZIF2sNna4YHAL4Gmi78wudJqcNATB
 vJHlBn1zgfRKan4bPh0u8/cTkn7hy8J7WAm48V0dtHsLYjomggJqOP67R87TGZ4o7SsG
 LW2aQXlXU4xYuWzUpYsMy4rXSrhPnS52nvIKuxAg35IY9l4SuI2oewD+vZGIe/UhNohB
 2rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xE5eD0s26uDLHllZ9oGxZszEhShWcHPN8etwhSpNAkQ=;
 b=YQtve8f8JudFk2szKJFeP0Z6pH42DkCRKyfibxQu4YjtDkz43v47g5NWXp44m/S+xx
 8nupZ+IAdwIc4lgR0ibO8LEiAIGUYMkIdk6WpCbtZDDpjwjgeUl7dYn8Uhi8y+ZTu8c8
 WqElyAhkO+cOOhXChHjB2UpATVBeoJNEDg/iZ2cYzcbjdGnH3P7qgB3v+XJ5DZNVCgFr
 ng72pYKNRewMa4d3bOD8rfcntmiNl0EFSsIOCVemyBWvKSrhrIIqlmItPoc92nkVQeZn
 dZ2jBCQQrjTN+s4ejAcYauoj/WuhGQdALwr6TpwV7uNsiUXWVWlGgt+6TaXlyO1vd2U6
 crrw==
X-Gm-Message-State: APjAAAVV6La7kuhTOYat7f+0sFftzHGPirlQBm7BaXxCsDOFr8oXTyoG
 Zm6rCp2xo+SGCv6RVGF14G3JIMjCjYomaKNQs9o=
X-Google-Smtp-Source: APXvYqyMNH3yF6F9zRKSS3qIETdIR0RMYUVyBn52+VFjUJ9yYS1mx9yO7lLaNjf86YITRfiW9JLBl56nQuuN9aEOnqo=
X-Received: by 2002:aed:24d9:: with SMTP id u25mr39424783qtc.229.1574835735272; 
 Tue, 26 Nov 2019 22:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-11-mrolnik@gmail.com>
 <20aa93b4-4039-bb02-c2c7-7e6aeca8c457@redhat.com>
In-Reply-To: <20aa93b4-4039-bb02-c2c7-7e6aeca8c457@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 27 Nov 2019 08:21:07 +0200
Message-ID: <CAK4993hTeD4VZ8XxsvsL3r5JPa5Tmt_=ZZKAx2tjFV_iRJV4+w@mail.gmail.com>
Subject: Re: [PATCH v36 10/17] target/avr: Add instruction disassembly function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000949f5505984e044c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::835
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000949f5505984e044c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 1:59 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 11/24/19 6:02 AM, Michael Rolnik wrote:
> > Provide function disassembles executed instruction when `-d in_asm` is
> > provided
>
> Maybe "Implement the disassemble_info::print_insn() callback which print
> a disassembled instruction."
>
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > ---
> >   target/avr/cpu.h       |   1 +
> >   target/avr/cpu.c       |   2 +-
> >   target/avr/disas.c     | 214 ++++++++++++++++++++++++++++++++++++++++=
+
> >   target/avr/translate.c |  11 +++
> >   4 files changed, 227 insertions(+), 1 deletion(-)
> >   create mode 100644 target/avr/disas.c
> >
> > diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> > index ed9218af5f..574118beab 100644
> > --- a/target/avr/cpu.h
> > +++ b/target/avr/cpu.h
> > @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int
> int_req);
> >   hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >   int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> >   int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> > +int avr_print_insn(bfd_vma addr, disassemble_info *info);
> >
> >   static inline int avr_feature(CPUAVRState *env, int feature)
> >   {
> > diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> > index dae56d7845..52ec21dd16 100644
> > --- a/target/avr/cpu.c
> > +++ b/target/avr/cpu.c
> > @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
> >   static void avr_cpu_disas_set_info(CPUState *cpu, disassemble_info
> *info)
> >   {
> >       info->mach =3D bfd_arch_avr;
> > -    info->print_insn =3D NULL;
> > +    info->print_insn =3D avr_print_insn;
> >   }
> >
> >   static void avr_cpu_realizefn(DeviceState *dev, Error **errp)
> > diff --git a/target/avr/disas.c b/target/avr/disas.c
> > new file mode 100644
> > index 0000000000..727fc463ce
> > --- /dev/null
> > +++ b/target/avr/disas.c
> > @@ -0,0 +1,214 @@
> > +/*
> > + * OpenRISC disassembler
>
> AVR?
>
> > + *
> > + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net>
>
> Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>?
>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "disas/dis-asm.h"
> > +#include "qemu/bitops.h"
> > +#include "cpu.h"
> > +
> > +typedef struct {
> > +    disassemble_info *info;
> > +    uint16_t next_word;
> > +    bool next_word_used;
> > +} DisasContext;
> > +
> > +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16)=
;
> }
> > +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8);=
 }
> > +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4) =
*
> 2; }
> > +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2;=
 }
> > +
> > +static uint16_t next_word(DisasContext *ctx)
> > +{
> > +    ctx->next_word_used =3D true;
> > +    return ctx->next_word;
> > +}
> > +
> > +static int append_16(DisasContext *ctx, int x)
> > +{
> > +    return x << 16 | next_word(ctx);
> > +}
> > +
> > +
> > +/* Include the auto-generated decoder.  */
> > +static bool decode_insn(DisasContext *ctx, uint16_t insn);
> > +#include "decode_insn.inc.c"
> > +
> > +#define output(mnemonic, format, ...) \
> > +    (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format, \
> > +                        mnemonic, ##__VA_ARGS__))
> > +
> > +int avr_print_insn(bfd_vma addr, disassemble_info *info)
> > +{
> > +    DisasContext ctx;
> > +    DisasContext *pctx =3D &ctx;
> > +    bfd_byte buffer[4];
> > +    uint16_t insn;
> > +    int status;
> > +
> > +    ctx.info =3D info;
> > +
> > +    status =3D info->read_memory_func(addr, buffer, 4, info);
> > +    if (status !=3D 0) {
> > +        info->memory_error_func(status, addr, info);
> > +        return -1;
> > +    }
> > +    insn =3D bfd_getl16(buffer);
> > +    ctx.next_word =3D bfd_getl16(buffer + 2);
> > +    ctx.next_word_used =3D false;
> > +
> > +    if (!decode_insn(&ctx, insn)) {
> > +        output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
> > +    }
> > +
> > +    return ctx.next_word_used ? 4 : 2;
> > +}
> > +
> > +
> > +#define INSN(opcode, format, ...)
>  \
> > +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
> \
> > +{
>  \
> > +    output(#opcode, format, ##__VA_ARGS__);
>  \
> > +    return true;
> \
> > +}
> > +
> > +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)
> \
> > +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)
> \
> > +{
>  \
> > +    output(mnemonic, format, ##__VA_ARGS__);
> \
> > +    return true;
> \
> > +}
> > +
> > +/*
> > + *   C       Z       N       V       S       H       T       I
> > + *   0       1       2       3       4       5       6       7
> > + */
> > +static const char *brbc[] =3D {
> > +    "BRCC", "BRNE", "BRPL", "BRVC", "BRGE", "BRHC", "BRTC", "BRID"
> > +};
> > +
> > +static const char *brbs[] =3D {
> > +    "BRCS", "BREQ", "BRMI", "BRVS", "BRLT", "BRHS", "BRTS", "BRIE"
> > +};
> > +
> > +static const char *bset[] =3D {
> > +    "SEC",  "SEZ",  "SEN",  "SEZ",  "SES",  "SEH",  "SET",  "SEI"
> > +};
> > +
> > +static const char *bclr[] =3D {
> > +    "CLC",  "CLZ",  "CLN",  "CLZ",  "CLS",  "CLH",  "CLT",  "CLI"
> > +};
> > +
> > +INSN(ADC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ADD,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
>
> I suppose this is a typo and you want:
>
> -- >8 --
> -INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
> +INSN(ADIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> ---
>
> Because I'm getting:
>
> target/avr/disas.c: In function =E2=80=98trans_ADIW=E2=80=99:
> target/avr/disas.c:53:51: error: unknown conversion type character =E2=80=
=98r=E2=80=99
> in format [-Werror=3Dformat=3D]
>     53 |     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format=
,
> \
>        |                                                   ^~~~~~~
> target/avr/disas.c:86:5: note: in expansion of macro =E2=80=98output=E2=
=80=99
>     86 |     output(#opcode, format, ##__VA_ARGS__);
>          \
>        |     ^~~~~~
> target/avr/disas.c:119:1: note: in expansion of macro =E2=80=98INSN=E2=80=
=99
>    119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
>        | ^~~~
> target/avr/disas.c:119:21: note: format string is defined here
>    119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
>        |                     ^
> target/avr/disas.c:53:51: error: too many arguments for format
> [-Werror=3Dformat-extra-args]
>     53 |     (pctx->info->fprintf_func(pctx->info->stream, "%-9s " format=
,
> \
>        |                                                   ^~~~~~~
> target/avr/disas.c:86:5: note: in expansion of macro =E2=80=98output=E2=
=80=99
>     86 |     output(#opcode, format, ##__VA_ARGS__);
>          \
>        |     ^~~~~~
> target/avr/disas.c:119:1: note: in expansion of macro =E2=80=98INSN=E2=80=
=99
>    119 | INSN(ADIW,   "r%d:r%r, %d", a->rd + 1, a->rd, a->imm)
>        | ^~~~
> cc1: all warnings being treated as errors
> make[1]: *** [rules.mak:69: target/avr/disas.o] Error 1
>
>
> > +INSN(AND,    "r%d, r%d", a->rd, a->rr)
> > +INSN(ANDI,   "r%d, %d", a->rd, a->imm)
> > +INSN(ASR,    "r%d", a->rd)
> > +INSN_MNEMONIC(BCLR,  bclr[a->bit], "")
> > +INSN(BLD,    "r%d, %d", a->rd, a->bit)
> > +INSN_MNEMONIC(BRBC,  brbc[a->bit], ".%+d", a->imm * 2)
> > +INSN_MNEMONIC(BRBS,  brbs[a->bit], ".%+d", a->imm * 2)
> > +INSN(BREAK,  "")
> > +INSN_MNEMONIC(BSET,  bset[a->bit], "")
> > +INSN(BST,    "r%d, %d", a->rd, a->bit)
> > +INSN(CALL,   "0x%x", a->imm * 2)
> > +INSN(CBI,    "%d, %d", a->reg, a->bit)
> > +INSN(COM,    "r%d", a->rd)
> > +INSN(CP,     "r%d, r%d", a->rd, a->rr)
> > +INSN(CPC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(CPI,    "r%d, %d", a->rd, a->imm)
> > +INSN(CPSE,   "r%d, r%d", a->rd, a->rr)
> > +INSN(DEC,    "r%d", a->rd)
> > +INSN(DES,    "%d", a->imm)
> > +INSN(EICALL, "")
> > +INSN(EIJMP,  "")
> > +INSN(ELPM1,  "")
> > +INSN(ELPM2,  "r%d, Z", a->rd)
> > +INSN(ELPMX,  "r%d, Z+", a->rd)
> > +INSN(EOR,    "r%d, r%d", a->rd, a->rr)
> > +INSN(FMUL,   "r%d, r%d", a->rd, a->rr)
> > +INSN(FMULS,  "r%d, r%d", a->rd, a->rr)
> > +INSN(FMULSU, "r%d, r%d", a->rd, a->rr)
> > +INSN(ICALL,  "")
> > +INSN(IJMP,   "")
> > +INSN(IN,     "r%d, $%d", a->rd, a->imm)
> > +INSN(INC,    "r%d", a->rd)
> > +INSN(JMP,    "0x%x", a->imm * 2)
> > +INSN(LAC,    "Z, r%d", a->rd)
> > +INSN(LAS,    "Z, r%d", a->rd)
> > +INSN(LAT,    "Z, r%d", a->rd)
> > +INSN(LDDY,   "r%d, Y+%d", a->rd, a->imm)
> > +INSN(LDDZ,   "r%d, Z+%d", a->rd, a->imm)
> > +INSN(LDI,    "r%d, %d", a->rd, a->imm)
> > +INSN(LDS,    "r%d, %d", a->rd, a->imm)
> > +INSN(LDX1,   "r%d, X", a->rd)
> > +INSN(LDX2,   "r%d, X+", a->rd)
> > +INSN(LDX3,   "r%d, -X", a->rd)
> > +INSN(LDY2,   "r%d, Y+", a->rd)
> > +INSN(LDY3,   "r%d, -Y", a->rd)
> > +INSN(LDZ2,   "r%d, Z+", a->rd)
> > +INSN(LDZ3,   "r%d, -Z", a->rd)
> > +INSN(LPM1,   "")
> > +INSN(LPM2,   "r%d, Z", a->rd)
> > +INSN(LPMX,   "r%d, Z+", a->rd)
> > +INSN(LSR,    "r%d", a->rd)
> > +INSN(MOV,    "r%d, r%d", a->rd, a->rr)
> > +INSN(MOVW,   "r%d:r%d, r%d,r:r%d", a->rd + 1, a->rd, a->rr + 1, a->rr)
> > +INSN(MUL,    "r%d, r%d", a->rd, a->rr)
> > +INSN(MULS,   "r%d, r%d", a->rd, a->rr)
> > +INSN(MULSU,  "r%d, r%d", a->rd, a->rr)
> > +INSN(NEG,    "r%d", a->rd)
> > +INSN(NOP,    "")
> > +INSN(OR,     "r%d, r%d", a->rd, a->rr)
> > +INSN(ORI,    "r%d, %d", a->rd, a->imm)
> > +INSN(OUT,    "$%d, r%d", a->imm, a->rd)
> > +INSN(POP,    "r%d", a->rd)
> > +INSN(PUSH,   "r%d", a->rd)
> > +INSN(RCALL,  ".%+d", a->imm * 2)
> > +INSN(RET,    "")
> > +INSN(RETI,   "")
> > +INSN(RJMP,   ".%+d", a->imm * 2)
> > +INSN(ROR,    "r%d", a->rd)
> > +INSN(SBC,    "r%d, r%d", a->rd, a->rr)
> > +INSN(SBCI,   "r%d, %d", a->rd, a->imm)
> > +INSN(SBI,    "$%d, %d", a->reg, a->bit)
> > +INSN(SBIC,   "$%d, %d", a->reg, a->bit)
> > +INSN(SBIS,   "$%d, %d", a->reg, a->bit)
> > +INSN(SBIW,   "r%d:r%d, %d", a->rd + 1, a->rd, a->imm)
> > +INSN(SBRC,   "r%d, %d", a->rr, a->bit)
> > +INSN(SBRS,   "r%d, %d", a->rr, a->bit)
> > +INSN(SLEEP,  "")
> > +INSN(SPM,    "")
> > +INSN(SPMX,   "Z+")
> > +INSN(STDY,   "r%d, Y+%d", a->rd, a->imm)
> > +INSN(STDZ,   "r%d, Z+%d", a->rd, a->imm)
> > +INSN(STS,    "r%d, %d", a->rd, a->imm)
> > +INSN(STX1,   "r%d, X", a->rr)
> > +INSN(STX2,   "r%d, X+", a->rr)
> > +INSN(STX3,   "r%d, -X", a->rr)
> > +INSN(STY2,   "r%d, Y+", a->rd)
> > +INSN(STY3,   "r%d, -Y", a->rd)
> > +INSN(STZ2,   "r%d, Z+", a->rd)
> > +INSN(STZ3,   "r%d, -Z", a->rd)
> > +INSN(SUB,    "r%d, r%d", a->rd, a->rr)
> > +INSN(SUBI,   "r%d, %d", a->rd, a->imm)
> > +INSN(SWAP,   "r%d", a->rd)
> > +INSN(WDR,    "")
> > +INSN(XCH,    "Z, r%d", a->rd)
> > +
> > diff --git a/target/avr/translate.c b/target/avr/translate.c
> > index fdf4e11f58..0446009d68 100644
> > --- a/target/avr/translate.c
> > +++ b/target/avr/translate.c
> > @@ -3019,6 +3019,17 @@ done_generating:
> >
> >       tb->size =3D (ctx.npc - pc_start) * 2;
> >       tb->icount =3D num_insns;
> > +
> > +#ifdef DEBUG_DISAS
> > +    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
> > +        && qemu_log_in_addr_range(tb->pc)) {
> > +        qemu_log_lock();
> > +        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
> > +        log_target_disas(cs, tb->pc, tb->size);
> > +        qemu_log("\n");
> > +        qemu_log_unlock();
> > +    }
> > +#endif
> >   }
> >
> >   void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
> >
>
> Testing time...
>
> $ avr-softmmu/qemu-system-avr -M sample -bios demo.elf -d in_asm,unimp,in=
t
> IN:
> 0x00000000:  JMP       0x110
>
> IN:
> 0x00000110:  EOR       r1, r1
> 0x00000112:  OUT       $63, r1
> 0x00000114:  LDI       r28, 255
> 0x00000116:  LDI       r29, 33
> 0x00000118:  OUT       $62, r29
> 0x0000011a:  OUT       $61, r28
> 0x0000011c:  LDI       r16, 0
> 0x0000011e:  OUT       $60, r16
> 0x00000120:  LDI       r17, 2
> 0x00000122:  LDI       r26, 0
> 0x00000124:  LDI       r27, 2
> 0x00000126:  LDI       r30, 80
> 0x00000128:  LDI       r31, 87
> 0x0000012a:  LDI       r16, 0
> 0x0000012c:  OUT       $59, r16
> 0x0000012e:  RJMP      .+4
>
> IN:
> 0x00000134:  CPI       r26, 96
> 0x00000136:  CPC       r27, r17
> 0x00000138:  BRNE      .-10
> IN:
> 0x00000130:  ELPMX     r0, Z+
> 0x00000132:  STX2      r0, X+
> 0x00000134:  CPI       r26, 96
> 0x00000136:  CPC       r27, r17
> 0x00000138:  BRNE      .-10
>
> IN:
> 0x0000013a:  LDI       r18, 18
> 0x0000013c:  LDI       r26, 96
> 0x0000013e:  LDI       r27, 2
> 0x00000140:  RJMP      .+2
>
> IN:
> 0x00000144:  CPI       r26, 208
> 0x00000146:  CPC       r27, r18
> 0x00000148:  BRNE      .-8
>
> IN:
> 0x00000142:  STX2      r1, X+
> 0x00000144:  CPI       r26, 208
> 0x00000146:  CPC       r27, r18
> 0x00000148:  BRNE      .-8
>
> IN:
> 0x0000014a:  CALL      0x156
>
> IN: main
> IN: main
> 0x00000156:  PUSH      r14
> 0x00000158:  PUSH      r15
> 0x0000015a:  PUSH      r16
> 0x0000015c:  PUSH      r28
> 0x0000015e:  PUSH      r29
> 0x00000160:  IN        r28, $61
> 0x00000162:  IN        r29, $62
> 0x00000164:  CALL      0x26c
>
> IN: prvIncrementResetCount
> 0x0000026c:  PUSH      r28
> 0x0000026e:  PUSH      r29
> 0x00000270:  IN        r28, $61
> 0x00000272:  IN        r29, $62
> 0x00000274:  NOP
> 0x00000276:  POP       r29
> 0x00000278:  POP       r28
> 0x0000027a:  RET
>
> IN: main
> 0x00000168:  CALL      0x5c6
>
> IN: vParTestInitialise
> 0x000005c6:  PUSH      r28
> 0x000005c8:  PUSH      r29
> 0x000005ca:  IN        r28, $61
> 0x000005cc:  IN        r29, $62
> 0x000005ce:  LDI       r24, 255
> 0x000005d0:  STS       r24, 0
> 0x000005d2:  MULS      r16, r20
> 0x000005d4:  LDI       r24, 33
> 0x000005d6:  LDI       r25, 0
> 0x000005d8:  LDI       r18, 255
> 0x000005da:  MOVW      r31:r30, r25,r:r24
> 0x000005dc:  STDZ      r18, Z+0
> 0x000005de:  LDI       r24, 34
> 0x000005e0:  LDI       r25, 0
> 0x000005e2:  LDS       r18, 0
> 0x000005e4:  MULS      r16, r20
> 0x000005e6:  MOVW      r31:r30, r25,r:r24
> 0x000005e8:  STDZ      r18, Z+0
> 0x000005ea:  NOP
> 0x000005ec:  POP       r29
> 0x000005ee:  POP       r28
> 0x000005f0:  RET
>
> IN: vParTestInitialise
> 0x000005dc:  STDZ      r18, Z+0
>
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x1)
> [...]
>
> IN: vParTestToggleLED
> 0x000006c0:  LDI       r24, 34
> 0x000006c2:  LDI       r25, 0
> 0x000006c4:  LDS       r18, 0
> 0x000006c6:  MULS      r16, r20
> 0x000006c8:  MOVW      r31:r30, r25,r:r24
> 0x000006ca:  STDZ      r18, Z+0
> 0x000006cc:  CALL      0x30d6
>
> IN: vParTestToggleLED
> 0x000006ca:  STDZ      r18, Z+0
>
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> IN: vParTestToggleLED
> 0x000006cc:  CALL      0x30d6
>
> IN: vParTestToggleLED
> 0x000006d0:  NOP
> 0x000006d2:  POP       r0
> 0x000006d4:  POP       r0
> 0x000006d6:  POP       r29
> 0x000006d8:  POP       r28
> 0x000006da:  RET
> [...]
>
> IN: vParTestToggleLED
> 0x000006b4:  LDS       r25, 0
> 0x000006b6:  MULS      r16, r20
> 0x000006b8:  LDDY      r24, Y+1
> 0x000006ba:  OR        r24, r25
> 0x000006bc:  STS       r24, 0
> 0x000006be:  MULS      r16, r20
> 0x000006c0:  LDI       r24, 34
> 0x000006c2:  LDI       r25, 0
> 0x000006c4:  LDS       r18, 0
> 0x000006c6:  MULS      r16, r20
> 0x000006c8:  MOVW      r31:r30, r25,r:r24
> 0x000006ca:  STDZ      r18, Z+0
> 0x000006cc:  CALL      0x30d6
>
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)
> gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)
>
> We have a blinking LED!
>
>
> $ avr-softmmu/qemu-system-avr -M sample -bios
> ATmegaBOOT_168_atmega328.elf -d in_asm,unimp,int
> [...]
> 0x00007800:  JMP       0x7868
>
> IN:
> 0x00007868:  EOR       r1, r1
> 0x0000786a:  OUT       $63, r1
> 0x0000786c:  LDI       r28, 255
> 0x0000786e:  LDI       r29, 8
> 0x00007870:  OUT       $62, r29
> 0x00007872:  OUT       $61, r28
> 0x00007874:  LDI       r17, 1
> 0x00007876:  LDI       r26, 0
> 0x00007878:  LDI       r27, 1
> 0x0000787a:  LDI       r30, 226
> 0x0000787c:  LDI       r31, 133
> 0x0000787e:  RJMP      .+4
>
> IN:
> 0x00007884:  CPI       r26, 2
> 0x00007886:  CPC       r27, r17
> 0x00007888:  BRNE      .-10
>
> IN:
> 0x00007880:  LPMX      r0, Z+
> 0x00007882:  STX2      r0, X+
> 0x00007884:  CPI       r26, 2
> 0x00007886:  CPC       r27, r17
> 0x00007888:  BRNE      .-10
>
> gpio H: unimplemented device write (size 1, value 0x80, offset 0x0)
> gpio H: unimplemented device write (size 1, value 0x0, offset 0x1)
> IN:
> 0x0000788a:  LDI       r18, 2
> 0x0000788c:  LDI       r26, 2
> 0x0000788e:  LDI       r27, 1
> 0x00007890:  RJMP      .+2
>
> IN:
> 0x00007894:  CPI       r26, 13
> 0x00007896:  CPC       r27, r18
> 0x00007898:  BRNE      .-8
>
> IN:
> 0x00007892:  STX2      r1, X+
> 0x00007894:  CPI       r26, 13
> 0x00007896:  CPC       r27, r18
> 0x00007898:  BRNE      .-8
>
> gpio H: unimplemented device write (size 1, value 0x0, offset 0x2)
> gpio J: unimplemented device write (size 1, value 0x0, offset 0x0)
> gpio J: unimplemented device write (size 1, value 0x0, offset 0x1)
> gpio J: unimplemented device write (size 1, value 0x0, offset 0x2)
> gpio K: unimplemented device write (size 1, value 0x0, offset 0x0)
> gpio K: unimplemented device write (size 1, value 0x0, offset 0x1)
> gpio K: unimplemented device write (size 1, value 0x0, offset 0x2)
> gpio L: unimplemented device write (size 1, value 0x0, offset 0x0)
> gpio L: unimplemented device write (size 1, value 0x0, offset 0x1)
> gpio L: unimplemented device write (size 1, value 0x0, offset 0x2)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x0)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x1)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x2)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x3)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x4)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x5)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x6)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x7)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x8)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0x9)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0xa)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0xb)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0xc)
> timer-counter-16bit 5: unimplemented device write (size 1, value 0x0,
> offset 0xd)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x0)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x1)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x2)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x3)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x4)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x5)
> usart 3: unimplemented device write (size 1, value 0x0, offset 0x6)
> IN:
> 0x0000789a:  CALL      0x7b8c
>
> IN: main
> [...]
>
> Wow, congratulation, I'm impressed how fast you implemented that!
>
Thanks Philippe.

>
> :) :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000949f5505984e044c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 27, 2019 at 1:59 AM Philippe =
Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 11/24/19 6:02 AM, Michael Rolnik wrote:<br>
&gt; Provide function disassembles executed instruction when `-d in_asm` is=
<br>
&gt; provided<br>
<br>
Maybe &quot;Implement the disassemble_info::print_insn() callback which pri=
nt <br>
a disassembled instruction.&quot;<br>
<br>
&gt; Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com"=
 target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01=
 +<br>
&gt;=C2=A0 =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02=
 +-<br>
&gt;=C2=A0 =C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0| 214 ++++++++++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0target/avr/translate.c |=C2=A0 11 +++<br>
&gt;=C2=A0 =C2=A04 files changed, 227 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 target/avr/disas.c<br>
&gt; <br>
&gt; diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
&gt; index ed9218af5f..574118beab 100644<br>
&gt; --- a/target/avr/cpu.h<br>
&gt; +++ b/target/avr/cpu.h<br>
&gt; @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu, int int=
_req);<br>
&gt;=C2=A0 =C2=A0hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr ad=
dr);<br>
&gt;=C2=A0 =C2=A0int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf,=
 int reg);<br>
&gt;=C2=A0 =C2=A0int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf=
, int reg);<br>
&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *info);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static inline int avr_feature(CPUAVRState *env, int featur=
e)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; diff --git a/target/avr/cpu.c b/target/avr/cpu.c<br>
&gt; index dae56d7845..52ec21dd16 100644<br>
&gt; --- a/target/avr/cpu.c<br>
&gt; +++ b/target/avr/cpu.c<br>
&gt; @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)<br>
&gt;=C2=A0 =C2=A0static void avr_cpu_disas_set_info(CPUState *cpu, disassem=
ble_info *info)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0info-&gt;mach =3D bfd_arch_avr;<br>
&gt; -=C2=A0 =C2=A0 info-&gt;print_insn =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;print_insn =3D avr_print_insn;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void avr_cpu_realizefn(DeviceState *dev, Error **er=
rp)<br>
&gt; diff --git a/target/avr/disas.c b/target/avr/disas.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..727fc463ce<br>
&gt; --- /dev/null<br>
&gt; +++ b/target/avr/disas.c<br>
&gt; @@ -0,0 +1,214 @@<br>
&gt; +/*<br>
&gt; + * OpenRISC disassembler<br>
<br>
AVR?<br>
<br>
&gt; + *<br>
&gt; + * Copyright (c) 2018 Richard Henderson &lt;<a href=3D"mailto:rth@twi=
ddle.net" target=3D"_blank">rth@twiddle.net</a>&gt;<br>
<br>
Copyright (c) 2019 Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" =
target=3D"_blank">mrolnik@gmail.com</a>&gt;?<br>
<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;disas/dis-asm.h&quot;<br>
&gt; +#include &quot;qemu/bitops.h&quot;<br>
&gt; +#include &quot;cpu.h&quot;<br>
&gt; +<br>
&gt; +typedef struct {<br>
&gt; +=C2=A0 =C2=A0 disassemble_info *info;<br>
&gt; +=C2=A0 =C2=A0 uint16_t next_word;<br>
&gt; +=C2=A0 =C2=A0 bool next_word_used;<br>
&gt; +} DisasContext;<br>
&gt; +<br>
&gt; +static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16=
); }<br>
&gt; +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8)=
; }<br>
&gt; +static int to_C(DisasContext *ctx, int indx) { return 24 + (indx % 4)=
 * 2; }<br>
&gt; +static int to_D(DisasContext *ctx, int indx) { return (indx % 16) * 2=
; }<br>
&gt; +<br>
&gt; +static uint16_t next_word(DisasContext *ctx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 ctx-&gt;next_word_used =3D true;<br>
&gt; +=C2=A0 =C2=A0 return ctx-&gt;next_word;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int append_16(DisasContext *ctx, int x)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return x &lt;&lt; 16 | next_word(ctx);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +/* Include the auto-generated decoder.=C2=A0 */<br>
&gt; +static bool decode_insn(DisasContext *ctx, uint16_t insn);<br>
&gt; +#include &quot;decode_insn.inc.c&quot;<br>
&gt; +<br>
&gt; +#define output(mnemonic, format, ...) \<br>
&gt; +=C2=A0 =C2=A0 (pctx-&gt;info-&gt;fprintf_func(pctx-&gt;info-&gt;strea=
m, &quot;%-9s &quot; format, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 mnemonic, ##__VA_ARGS__))<br>
&gt; +<br>
&gt; +int avr_print_insn(bfd_vma addr, disassemble_info *info)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DisasContext ctx;<br>
&gt; +=C2=A0 =C2=A0 DisasContext *pctx =3D &amp;ctx;<br>
&gt; +=C2=A0 =C2=A0 bfd_byte buffer[4];<br>
&gt; +=C2=A0 =C2=A0 uint16_t insn;<br>
&gt; +=C2=A0 =C2=A0 int status;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 <a href=3D"http://ctx.info" rel=3D"noreferrer" target=
=3D"_blank">ctx.info</a> =3D info;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 status =3D info-&gt;read_memory_func(addr, buffer, 4, i=
nfo);<br>
&gt; +=C2=A0 =C2=A0 if (status !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;memory_error_func(status, addr, =
info);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 insn =3D bfd_getl16(buffer);<br>
&gt; +=C2=A0 =C2=A0 ctx.next_word =3D bfd_getl16(buffer + 2);<br>
&gt; +=C2=A0 =C2=A0 ctx.next_word_used =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!decode_insn(&amp;ctx, insn)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 output(&quot;.db&quot;, &quot;0x%02x, 0x%=
02x&quot;, buffer[0], buffer[1]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return ctx.next_word_used ? 4 : 2;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +#define INSN(opcode, format, ...)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 output(#opcode, format, ##__VA_ARGS__);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +#define INSN_MNEMONIC(opcode, mnemonic, format, ...)=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +static bool trans_##opcode(DisasContext *pctx, arg_##opcode * a)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +{=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt; +=C2=A0 =C2=A0 output(mnemonic, format, ##__VA_ARGS__);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + *=C2=A0 =C2=A0C=C2=A0 =C2=A0 =C2=A0 =C2=A0Z=C2=A0 =C2=A0 =C2=A0 =C2=
=A0N=C2=A0 =C2=A0 =C2=A0 =C2=A0V=C2=A0 =C2=A0 =C2=A0 =C2=A0S=C2=A0 =C2=A0 =
=C2=A0 =C2=A0H=C2=A0 =C2=A0 =C2=A0 =C2=A0T=C2=A0 =C2=A0 =C2=A0 =C2=A0I<br>
&gt; + *=C2=A0 =C2=A00=C2=A0 =C2=A0 =C2=A0 =C2=A01=C2=A0 =C2=A0 =C2=A0 =C2=
=A02=C2=A0 =C2=A0 =C2=A0 =C2=A03=C2=A0 =C2=A0 =C2=A0 =C2=A04=C2=A0 =C2=A0 =
=C2=A0 =C2=A05=C2=A0 =C2=A0 =C2=A0 =C2=A06=C2=A0 =C2=A0 =C2=A0 =C2=A07<br>
&gt; + */<br>
&gt; +static const char *brbc[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;BRCC&quot;, &quot;BRNE&quot;, &quot;BRPL&quot;, &=
quot;BRVC&quot;, &quot;BRGE&quot;, &quot;BRHC&quot;, &quot;BRTC&quot;, &quo=
t;BRID&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *brbs[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;BRCS&quot;, &quot;BREQ&quot;, &quot;BRMI&quot;, &=
quot;BRVS&quot;, &quot;BRLT&quot;, &quot;BRHS&quot;, &quot;BRTS&quot;, &quo=
t;BRIE&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *bset[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;SEC&quot;,=C2=A0 &quot;SEZ&quot;,=C2=A0 &quot;SEN=
&quot;,=C2=A0 &quot;SEZ&quot;,=C2=A0 &quot;SES&quot;,=C2=A0 &quot;SEH&quot;=
,=C2=A0 &quot;SET&quot;,=C2=A0 &quot;SEI&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const char *bclr[] =3D {<br>
&gt; +=C2=A0 =C2=A0 &quot;CLC&quot;,=C2=A0 &quot;CLZ&quot;,=C2=A0 &quot;CLN=
&quot;,=C2=A0 &quot;CLZ&quot;,=C2=A0 &quot;CLS&quot;,=C2=A0 &quot;CLH&quot;=
,=C2=A0 &quot;CLT&quot;,=C2=A0 &quot;CLI&quot;<br>
&gt; +};<br>
&gt; +<br>
&gt; +INSN(ADC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ADD,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd + 1, a-&gt;r=
d, a-&gt;imm)<br>
<br>
I suppose this is a typo and you want:<br>
<br>
-- &gt;8 --<br>
-INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd + 1, a-&gt;rd, a-=
&gt;imm)<br>
+INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%d, %d&quot;, a-&gt;rd + 1, a-&gt;rd, a-=
&gt;imm)<br>
---<br>
<br>
Because I&#39;m getting:<br>
<br>
target/avr/disas.c: In function =E2=80=98trans_ADIW=E2=80=99:<br>
target/avr/disas.c:53:51: error: unknown conversion type character =E2=80=
=98r=E2=80=99 <br>
in format [-Werror=3Dformat=3D]<br>
=C2=A0 =C2=A0 53 |=C2=A0 =C2=A0 =C2=A0(pctx-&gt;info-&gt;fprintf_func(pctx-=
&gt;info-&gt;stream, &quot;%-9s &quot; format, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<br>
target/avr/disas.c:86:5: note: in expansion of macro =E2=80=98output=E2=80=
=99<br>
=C2=A0 =C2=A0 86 |=C2=A0 =C2=A0 =C2=A0output(#opcode, format, ##__VA_ARGS__=
); <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~<br>
target/avr/disas.c:119:1: note: in expansion of macro =E2=80=98INSN=E2=80=
=99<br>
=C2=A0 =C2=A0119 | INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd=
 + 1, a-&gt;rd, a-&gt;imm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^~~~<br>
target/avr/disas.c:119:21: note: format string is defined here<br>
=C2=A0 =C2=A0119 | INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd=
 + 1, a-&gt;rd, a-&gt;imm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
target/avr/disas.c:53:51: error: too many arguments for format <br>
[-Werror=3Dformat-extra-args]<br>
=C2=A0 =C2=A0 53 |=C2=A0 =C2=A0 =C2=A0(pctx-&gt;info-&gt;fprintf_func(pctx-=
&gt;info-&gt;stream, &quot;%-9s &quot; format, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<br>
target/avr/disas.c:86:5: note: in expansion of macro =E2=80=98output=E2=80=
=99<br>
=C2=A0 =C2=A0 86 |=C2=A0 =C2=A0 =C2=A0output(#opcode, format, ##__VA_ARGS__=
); <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~<br>
target/avr/disas.c:119:1: note: in expansion of macro =E2=80=98INSN=E2=80=
=99<br>
=C2=A0 =C2=A0119 | INSN(ADIW,=C2=A0 =C2=A0&quot;r%d:r%r, %d&quot;, a-&gt;rd=
 + 1, a-&gt;rd, a-&gt;imm)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^~~~<br>
cc1: all warnings being treated as errors<br>
make[1]: *** [rules.mak:69: target/avr/disas.o] Error 1<br>
<br>
<br>
&gt; +INSN(AND,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ANDI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(ASR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN_MNEMONIC(BCLR,=C2=A0 bclr[a-&gt;bit], &quot;&quot;)<br>
&gt; +INSN(BLD,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;bit)<br>
&gt; +INSN_MNEMONIC(BRBC,=C2=A0 brbc[a-&gt;bit], &quot;.%+d&quot;, a-&gt;im=
m * 2)<br>
&gt; +INSN_MNEMONIC(BRBS,=C2=A0 brbs[a-&gt;bit], &quot;.%+d&quot;, a-&gt;im=
m * 2)<br>
&gt; +INSN(BREAK,=C2=A0 &quot;&quot;)<br>
&gt; +INSN_MNEMONIC(BSET,=C2=A0 bset[a-&gt;bit], &quot;&quot;)<br>
&gt; +INSN(BST,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;bit)<br>
&gt; +INSN(CALL,=C2=A0 =C2=A0&quot;0x%x&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(CBI,=C2=A0 =C2=A0 &quot;%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(COM,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(CP,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)=
<br>
&gt; +INSN(CPC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(CPI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(CPSE,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(DEC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(DES,=C2=A0 =C2=A0 &quot;%d&quot;, a-&gt;imm)<br>
&gt; +INSN(EICALL, &quot;&quot;)<br>
&gt; +INSN(EIJMP,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(ELPM1,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(ELPM2,=C2=A0 &quot;r%d, Z&quot;, a-&gt;rd)<br>
&gt; +INSN(ELPMX,=C2=A0 &quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(EOR,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMUL,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMULS,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(FMULSU, &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(ICALL,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(IJMP,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(IN,=C2=A0 =C2=A0 =C2=A0&quot;r%d, $%d&quot;, a-&gt;rd, a-&gt;imm=
)<br>
&gt; +INSN(INC,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(JMP,=C2=A0 =C2=A0 &quot;0x%x&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(LAC,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LAS,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LAT,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(LDDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(LDDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(LDI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(LDS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(LDX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rd)<br>
&gt; +INSN(LDX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rd)<br>
&gt; +INSN(LDY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)<br>
&gt; +INSN(LDZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(LDZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)<br>
&gt; +INSN(LPM1,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(LPM2,=C2=A0 =C2=A0&quot;r%d, Z&quot;, a-&gt;rd)<br>
&gt; +INSN(LPMX,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(LSR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(MOV,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MOVW,=C2=A0 =C2=A0&quot;r%d:r%d, r%d,r:r%d&quot;, a-&gt;rd + 1, =
a-&gt;rd, a-&gt;rr + 1, a-&gt;rr)<br>
&gt; +INSN(MUL,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MULS,=C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(MULSU,=C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(NEG,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(NOP,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(OR,=C2=A0 =C2=A0 =C2=A0&quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)=
<br>
&gt; +INSN(ORI,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(OUT,=C2=A0 =C2=A0 &quot;$%d, r%d&quot;, a-&gt;imm, a-&gt;rd)<br>
&gt; +INSN(POP,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(PUSH,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(RCALL,=C2=A0 &quot;.%+d&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(RET,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(RETI,=C2=A0 =C2=A0&quot;&quot;)<br>
&gt; +INSN(RJMP,=C2=A0 =C2=A0&quot;.%+d&quot;, a-&gt;imm * 2)<br>
&gt; +INSN(ROR,=C2=A0 =C2=A0 &quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(SBC,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(SBCI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(SBI,=C2=A0 =C2=A0 &quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIC,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIS,=C2=A0 =C2=A0&quot;$%d, %d&quot;, a-&gt;reg, a-&gt;bit)<br>
&gt; +INSN(SBIW,=C2=A0 =C2=A0&quot;r%d:r%d, %d&quot;, a-&gt;rd + 1, a-&gt;r=
d, a-&gt;imm)<br>
&gt; +INSN(SBRC,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr, a-&gt;bit)<br>
&gt; +INSN(SBRS,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rr, a-&gt;bit)<br>
&gt; +INSN(SLEEP,=C2=A0 &quot;&quot;)<br>
&gt; +INSN(SPM,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(SPMX,=C2=A0 =C2=A0&quot;Z+&quot;)<br>
&gt; +INSN(STDY,=C2=A0 =C2=A0&quot;r%d, Y+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(STDZ,=C2=A0 =C2=A0&quot;r%d, Z+%d&quot;, a-&gt;rd, a-&gt;imm)<br=
>
&gt; +INSN(STS,=C2=A0 =C2=A0 &quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(STX1,=C2=A0 =C2=A0&quot;r%d, X&quot;, a-&gt;rr)<br>
&gt; +INSN(STX2,=C2=A0 =C2=A0&quot;r%d, X+&quot;, a-&gt;rr)<br>
&gt; +INSN(STX3,=C2=A0 =C2=A0&quot;r%d, -X&quot;, a-&gt;rr)<br>
&gt; +INSN(STY2,=C2=A0 =C2=A0&quot;r%d, Y+&quot;, a-&gt;rd)<br>
&gt; +INSN(STY3,=C2=A0 =C2=A0&quot;r%d, -Y&quot;, a-&gt;rd)<br>
&gt; +INSN(STZ2,=C2=A0 =C2=A0&quot;r%d, Z+&quot;, a-&gt;rd)<br>
&gt; +INSN(STZ3,=C2=A0 =C2=A0&quot;r%d, -Z&quot;, a-&gt;rd)<br>
&gt; +INSN(SUB,=C2=A0 =C2=A0 &quot;r%d, r%d&quot;, a-&gt;rd, a-&gt;rr)<br>
&gt; +INSN(SUBI,=C2=A0 =C2=A0&quot;r%d, %d&quot;, a-&gt;rd, a-&gt;imm)<br>
&gt; +INSN(SWAP,=C2=A0 =C2=A0&quot;r%d&quot;, a-&gt;rd)<br>
&gt; +INSN(WDR,=C2=A0 =C2=A0 &quot;&quot;)<br>
&gt; +INSN(XCH,=C2=A0 =C2=A0 &quot;Z, r%d&quot;, a-&gt;rd)<br>
&gt; +<br>
&gt; diff --git a/target/avr/translate.c b/target/avr/translate.c<br>
&gt; index fdf4e11f58..0446009d68 100644<br>
&gt; --- a/target/avr/translate.c<br>
&gt; +++ b/target/avr/translate.c<br>
&gt; @@ -3019,6 +3019,17 @@ done_generating:<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tb-&gt;size =3D (ctx.npc - pc_start) * 2;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tb-&gt;icount =3D num_insns;<br>
&gt; +<br>
&gt; +#ifdef DEBUG_DISAS<br>
&gt; +=C2=A0 =C2=A0 if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; qemu_log_in_addr_range(tb-&gt;=
pc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_lock();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IN: %s\n&quot;, lookup_sym=
bol(tb-&gt;pc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_target_disas(cs, tb-&gt;pc, tb-&gt;si=
ze);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_unlock();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void restore_state_to_opc(CPUAVRState *env, TranslationBlo=
ck *tb,<br>
&gt; <br>
<br>
Testing time...<br>
<br>
$ avr-softmmu/qemu-system-avr -M sample -bios demo.elf -d in_asm,unimp,int<=
br>
IN:<br>
0x00000000:=C2=A0 JMP=C2=A0 =C2=A0 =C2=A0 =C2=A00x110<br>
<br>
IN:<br>
0x00000110:=C2=A0 EOR=C2=A0 =C2=A0 =C2=A0 =C2=A0r1, r1<br>
0x00000112:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$63, r1<br>
0x00000114:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r28, 255<br>
0x00000116:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r29, 33<br>
0x00000118:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$62, r29<br>
0x0000011a:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$61, r28<br>
0x0000011c:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r16, 0<br>
0x0000011e:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$60, r16<br>
0x00000120:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r17, 2<br>
0x00000122:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 0<br>
0x00000124:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, 2<br>
0x00000126:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r30, 80<br>
0x00000128:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r31, 87<br>
0x0000012a:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r16, 0<br>
0x0000012c:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$59, r16<br>
0x0000012e:=C2=A0 RJMP=C2=A0 =C2=A0 =C2=A0 .+4<br>
<br>
IN:<br>
0x00000134:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 96<br>
0x00000136:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r17<br>
0x00000138:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-10<br>
IN:<br>
0x00000130:=C2=A0 ELPMX=C2=A0 =C2=A0 =C2=A0r0, Z+<br>
0x00000132:=C2=A0 STX2=C2=A0 =C2=A0 =C2=A0 r0, X+<br>
0x00000134:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 96<br>
0x00000136:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r17<br>
0x00000138:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-10<br>
<br>
IN:<br>
0x0000013a:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 18<br>
0x0000013c:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 96<br>
0x0000013e:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, 2<br>
0x00000140:=C2=A0 RJMP=C2=A0 =C2=A0 =C2=A0 .+2<br>
<br>
IN:<br>
0x00000144:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 208<br>
0x00000146:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r18<br>
0x00000148:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-8<br>
<br>
IN:<br>
0x00000142:=C2=A0 STX2=C2=A0 =C2=A0 =C2=A0 r1, X+<br>
0x00000144:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 208<br>
0x00000146:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r18<br>
0x00000148:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-8<br>
<br>
IN:<br>
0x0000014a:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x156<br>
<br>
IN: main<br>
IN: main<br>
0x00000156:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r14<br>
0x00000158:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r15<br>
0x0000015a:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r16<br>
0x0000015c:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r28<br>
0x0000015e:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r29<br>
0x00000160:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r28, $61<br>
0x00000162:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r29, $62<br>
0x00000164:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x26c<br>
<br>
IN: prvIncrementResetCount<br>
0x0000026c:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r28<br>
0x0000026e:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r29<br>
0x00000270:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r28, $61<br>
0x00000272:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r29, $62<br>
0x00000274:=C2=A0 NOP<br>
0x00000276:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r29<br>
0x00000278:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r28<br>
0x0000027a:=C2=A0 RET<br>
<br>
IN: main<br>
0x00000168:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x5c6<br>
<br>
IN: vParTestInitialise<br>
0x000005c6:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r28<br>
0x000005c8:=C2=A0 PUSH=C2=A0 =C2=A0 =C2=A0 r29<br>
0x000005ca:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r28, $61<br>
0x000005cc:=C2=A0 IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 r29, $62<br>
0x000005ce:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 255<br>
0x000005d0:=C2=A0 STS=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 0<br>
0x000005d2:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000005d4:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 33<br>
0x000005d6:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r25, 0<br>
0x000005d8:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 255<br>
0x000005da:=C2=A0 MOVW=C2=A0 =C2=A0 =C2=A0 r31:r30, r25,r:r24<br>
0x000005dc:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
0x000005de:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 34<br>
0x000005e0:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r25, 0<br>
0x000005e2:=C2=A0 LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 0<br>
0x000005e4:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000005e6:=C2=A0 MOVW=C2=A0 =C2=A0 =C2=A0 r31:r30, r25,r:r24<br>
0x000005e8:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
0x000005ea:=C2=A0 NOP<br>
0x000005ec:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r29<br>
0x000005ee:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r28<br>
0x000005f0:=C2=A0 RET<br>
<br>
IN: vParTestInitialise<br>
0x000005dc:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x1)<br>
[...]<br>
<br>
IN: vParTestToggleLED<br>
0x000006c0:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 34<br>
0x000006c2:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r25, 0<br>
0x000006c4:=C2=A0 LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 0<br>
0x000006c6:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000006c8:=C2=A0 MOVW=C2=A0 =C2=A0 =C2=A0 r31:r30, r25,r:r24<br>
0x000006ca:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
0x000006cc:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x30d6<br>
<br>
IN: vParTestToggleLED<br>
0x000006ca:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
IN: vParTestToggleLED<br>
0x000006cc:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x30d6<br>
<br>
IN: vParTestToggleLED<br>
0x000006d0:=C2=A0 NOP<br>
0x000006d2:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r0<br>
0x000006d4:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r0<br>
0x000006d6:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r29<br>
0x000006d8:=C2=A0 POP=C2=A0 =C2=A0 =C2=A0 =C2=A0r28<br>
0x000006da:=C2=A0 RET<br>
[...]<br>
<br>
IN: vParTestToggleLED<br>
0x000006b4:=C2=A0 LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0r25, 0<br>
0x000006b6:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000006b8:=C2=A0 LDDY=C2=A0 =C2=A0 =C2=A0 r24, Y+1<br>
0x000006ba:=C2=A0 OR=C2=A0 =C2=A0 =C2=A0 =C2=A0 r24, r25<br>
0x000006bc:=C2=A0 STS=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 0<br>
0x000006be:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000006c0:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r24, 34<br>
0x000006c2:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r25, 0<br>
0x000006c4:=C2=A0 LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 0<br>
0x000006c6:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r20<br>
0x000006c8:=C2=A0 MOVW=C2=A0 =C2=A0 =C2=A0 r31:r30, r25,r:r24<br>
0x000006ca:=C2=A0 STDZ=C2=A0 =C2=A0 =C2=A0 r18, Z+0<br>
0x000006cc:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x30d6<br>
<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xff, offset 0x2)<br>
gpio A: unimplemented device write (size 1, value 0xef, offset 0x2)<br>
<br>
We have a blinking LED!<br>
<br>
<br>
$ avr-softmmu/qemu-system-avr -M sample -bios <br>
ATmegaBOOT_168_atmega328.elf -d in_asm,unimp,int<br>
[...]<br>
0x00007800:=C2=A0 JMP=C2=A0 =C2=A0 =C2=A0 =C2=A00x7868<br>
<br>
IN:<br>
0x00007868:=C2=A0 EOR=C2=A0 =C2=A0 =C2=A0 =C2=A0r1, r1<br>
0x0000786a:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$63, r1<br>
0x0000786c:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r28, 255<br>
0x0000786e:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r29, 8<br>
0x00007870:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$62, r29<br>
0x00007872:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$61, r28<br>
0x00007874:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r17, 1<br>
0x00007876:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 0<br>
0x00007878:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, 1<br>
0x0000787a:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r30, 226<br>
0x0000787c:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r31, 133<br>
0x0000787e:=C2=A0 RJMP=C2=A0 =C2=A0 =C2=A0 .+4<br>
<br>
IN:<br>
0x00007884:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 2<br>
0x00007886:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r17<br>
0x00007888:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-10<br>
<br>
IN:<br>
0x00007880:=C2=A0 LPMX=C2=A0 =C2=A0 =C2=A0 r0, Z+<br>
0x00007882:=C2=A0 STX2=C2=A0 =C2=A0 =C2=A0 r0, X+<br>
0x00007884:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 2<br>
0x00007886:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r17<br>
0x00007888:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-10<br>
<br>
gpio H: unimplemented device write (size 1, value 0x80, offset 0x0)<br>
gpio H: unimplemented device write (size 1, value 0x0, offset 0x1)<br>
IN:<br>
0x0000788a:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r18, 2<br>
0x0000788c:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 2<br>
0x0000788e:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, 1<br>
0x00007890:=C2=A0 RJMP=C2=A0 =C2=A0 =C2=A0 .+2<br>
<br>
IN:<br>
0x00007894:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 13<br>
0x00007896:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r18<br>
0x00007898:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-8<br>
<br>
IN:<br>
0x00007892:=C2=A0 STX2=C2=A0 =C2=A0 =C2=A0 r1, X+<br>
0x00007894:=C2=A0 CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0r26, 13<br>
0x00007896:=C2=A0 CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0r27, r18<br>
0x00007898:=C2=A0 BRNE=C2=A0 =C2=A0 =C2=A0 .-8<br>
<br>
gpio H: unimplemented device write (size 1, value 0x0, offset 0x2)<br>
gpio J: unimplemented device write (size 1, value 0x0, offset 0x0)<br>
gpio J: unimplemented device write (size 1, value 0x0, offset 0x1)<br>
gpio J: unimplemented device write (size 1, value 0x0, offset 0x2)<br>
gpio K: unimplemented device write (size 1, value 0x0, offset 0x0)<br>
gpio K: unimplemented device write (size 1, value 0x0, offset 0x1)<br>
gpio K: unimplemented device write (size 1, value 0x0, offset 0x2)<br>
gpio L: unimplemented device write (size 1, value 0x0, offset 0x0)<br>
gpio L: unimplemented device write (size 1, value 0x0, offset 0x1)<br>
gpio L: unimplemented device write (size 1, value 0x0, offset 0x2)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x0)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x1)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x2)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x3)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x4)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x5)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x6)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x7)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x8)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0x9)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0xa)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0xb)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0xc)<br>
timer-counter-16bit 5: unimplemented device write (size 1, value 0x0, <br>
offset 0xd)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x0)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x1)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x2)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x3)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x4)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x5)<br>
usart 3: unimplemented device write (size 1, value 0x0, offset 0x6)<br>
IN:<br>
0x0000789a:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x7b8c<br>
<br>
IN: main<br>
[...]<br>
<br>
Wow, congratulation, I&#39;m impressed how fast you implemented that!<br></=
blockquote><div>Thanks Philippe.=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
:) :)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div></div>

--000000000000949f5505984e044c--

