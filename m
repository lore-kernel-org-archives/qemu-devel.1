Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C01C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 15:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF522072B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 15:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdzBcP9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF522072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iih9L-0000m8-6P
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 10:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iih8g-0000Ib-Uv
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iih8e-0008RK-3B
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:57:58 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iih8d-0008LC-Mj
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 10:57:55 -0500
Received: by mail-qt1-x841.google.com with SMTP id k40so11210226qtk.8
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZsQwcnhHD4NwWetArphb9wl/kfmd1htRtDwK2T1q1DI=;
 b=TdzBcP9qWiYHa3dXnKnXvQ+SoRhCB0R5pEt0EJHGI+KrFIRv46VNRsv43OhGUsHHn+
 TNemZp2wR0mz5u4w1mnYDrj6m966mpI9eAZcpihnntPg8tF0uIa2PirdlfR7lX/5Z3DN
 7aFKc0d+fOmYmAbpuptHqSLve6h6IebWK/W5xsLnh8UPq+rPPP3zPGeKSXhzjg8ZFWWX
 eys3rcSMlLjVVe31SGzolnmQaAg5uuCxUXEcXO5rw2iOwulv219doFQRLHVHLosg8iaB
 gamJzhVu1SYzhEvxXMKYwGgVclZaFqL8uwz+gJgwU+yogTQsKGYMCEfl/0L+qMWC9P7p
 cbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZsQwcnhHD4NwWetArphb9wl/kfmd1htRtDwK2T1q1DI=;
 b=FzhDwMZCeCtYt+JTrgkhzLjkqitYtBGenGLh1+XNSIP62j2pOdO20v/UwW6kYlwAOs
 1Iuqp4qHXQ9QafpYiwBvRFGwSKvD7D525JHSN1mGZctNy6EC5iS7yquk7sXotgkrknnk
 XCB+u0DXn0WYtE+vf0vpxEWJyW5eiRLdt+OkA6NKVF+ENe7Q0/YEEMNHAkRjCd/qIp7p
 FaJTnV9F1vRNspKxG48rNcZRhJqV56lEC4THZH0FGQx/reiRq51AWz6LL2nJXmVct831
 N7F6cpOl84hTaoxbMAGOffsllM6ygyjLknOQXUG83WDClri3u2oPydpibKStgbMd+gmO
 /I9A==
X-Gm-Message-State: APjAAAW069fk4AAhNHEytsYdgrYSMTHz6vFRLEmUayiUeOj0vRm4BCPm
 I07jlENpng+J4wTMtHoVO5TVXu1pJ0DYCBZVDPU=
X-Google-Smtp-Source: APXvYqw2tY6DtJq6osscjjzSbwS23f+XRUVW/Vdc/Yy0EqqAKWV9S6Ei63TnooNZlOjd9GwiexaYmenZZzLgz1fahQ0=
X-Received: by 2002:aed:3c52:: with SMTP id u18mr16397105qte.382.1576943874274; 
 Sat, 21 Dec 2019 07:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-4-mrolnik@gmail.com>
 <CAL1e-=hB5FhRtuxo1OGBSKA-aw1GW4RgpisKJWaT0TPHKaTVhw@mail.gmail.com>
In-Reply-To: <CAL1e-=hB5FhRtuxo1OGBSKA-aw1GW4RgpisKJWaT0TPHKaTVhw@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 21 Dec 2019 17:57:04 +0200
Message-ID: <CAK4993iuuCZzyEzsqodpf_T_3xSSJeF-PP1XLO8PsXy6JwrgfA@mail.gmail.com>
Subject: Re: [PATCH v39 03/22] target/avr: Add instruction decoding
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000074faa0059a38db9b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

--00000000000074faa0059a38db9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksandar.

please explain.

On Sat, Dec 21, 2019 at 1:18 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote=
:
>
>> This includes:
>> - encoding of all 16 bit instructions
>> - encoding of all 32 bit instructions
>>
>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>
>
> Michael,
>
> I am very pleased that you rearranged the order to be in sync with the
> documentation.
>
> Now, for the next version, I would ask you to make this patch disappear.
>
> More precisely, "MCU Control Instructions" section of insn.decode file
> move to be a part of "Add MCU Control Instructions" (not sure abiut the
> title, but it is 6 or 7 patches after this one)  patch, and so on, in the
> same fashion, for all groups of instructions.
>
> Kind regards,
>
> Aleksandar
>
>
>
>  target/avr/insn.decode | 183 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 183 insertions(+)
>>  create mode 100644 target/avr/insn.decode
>>
>> diff --git a/target/avr/insn.decode b/target/avr/insn.decode
>> new file mode 100644
>> index 0000000000..0e4ec9ddf0
>> --- /dev/null
>> +++ b/target/avr/insn.decode
>> @@ -0,0 +1,183 @@
>> +#
>> +# AVR instruction decode definitions.
>> +#
>> +# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
>> +#
>> +# This library is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU Lesser General Public
>> +# License as published by the Free Software Foundation; either
>> +# version 2.1 of the License, or (at your option) any later version.
>> +#
>> +# This library is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> +# Lesser General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU Lesser General Public
>> +# License along with this library; if not, see <
>> http://www.gnu.org/licenses/>.
>> +#
>> +
>> +#
>> +#   regs_16_31_by_one =3D [16 .. 31]
>> +#   regs_16_23_by_one =3D [16 .. 23]
>> +#   regs_24_30_by_two =3D [24, 26, 28, 30]
>> +#   regs_00_30_by_two =3D [0, 2, 4, 6, 8, .. 30]
>> +
>> +%rd             4:5
>> +%rr             9:1 0:4
>> +
>> +%rd_a           4:4
>>  !function=3Dto_regs_16_31_by_one
>> +%rd_b           4:3
>>  !function=3Dto_regs_16_23_by_one
>> +%rd_c           4:2
>>  !function=3Dto_regs_24_30_by_two
>> +%rd_d           4:4
>>  !function=3Dto_regs_00_30_by_two
>> +%rr_a           0:4
>>  !function=3Dto_regs_16_31_by_one
>> +%rr_b           0:3
>>  !function=3Dto_regs_16_23_by_one
>> +%rr_d           0:4
>>  !function=3Dto_regs_00_30_by_two
>> +
>> +%imm6           6:2 0:4
>> +%imm8           8:4 0:4
>> +
>> +%io_imm         9:2 0:4
>> +%ldst_d_imm     13:1 10:2 0:3
>> +
>> +# The 22-bit immediate is partially in the opcode word,
>> +# and partially in the next.  Use append_16 to build the
>> +# complete 22-bit value.
>> +%imm_call       4:5 0:1                     !function=3Dappend_16
>> +
>> +
>> +&rd_rr          rd rr
>> +&rd_imm         rd imm
>> +
>> +@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=3D%rd rr=3D%=
rr
>> +@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=3D%rd_c
>> imm=3D%imm6
>> +@op_rd_imm8     .... .... .... ....         &rd_imm     rd=3D%rd_a
>> imm=3D%imm8
>> +@op_bit         .... .... . bit:3 ....
>> +@op_bit_imm     .... .. imm:s7 bit:3
>> +@fmul           .... .... . ... . ...       &rd_rr      rd=3D%rd_b rr=
=3D%rr_b
>> +@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=3D%rd
>> imm=3D%io_imm
>> +@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=3D%ldst_d_i=
mm
>> +
>> +# The 16-bit immediate is completely in the next word.
>> +# Fields cannot be defined with no bits, so we cannot play
>> +# the same trick and append to a zero-bit value.
>> +# Defer reading the immediate until trans_{LDS,STS}.
>> +@ldst_s         .... ... rd:5 ....          imm=3D0
>> +
>> +#
>> +# Arithmetic Instructions
>> +#
>> +ADD             0000 11 . ..... ....        @op_rd_rr
>> +ADC             0001 11 . ..... ....        @op_rd_rr
>> +ADIW            1001 0110 .. .. ....        @op_rd_imm6
>> +SUB             0001 10 . ..... ....        @op_rd_rr
>> +SUBI            0101 .... .... ....         @op_rd_imm8
>> +SBC             0000 10 . ..... ....        @op_rd_rr
>> +SBCI            0100 .... .... ....         @op_rd_imm8
>> +SBIW            1001 0111 .. .. ....        @op_rd_imm6
>> +AND             0010 00 . ..... ....        @op_rd_rr
>> +ANDI            0111 .... .... ....         @op_rd_imm8
>> +OR              0010 10 . ..... ....        @op_rd_rr
>> +ORI             0110 .... .... ....         @op_rd_imm8
>> +EOR             0010 01 . ..... ....        @op_rd_rr
>> +COM             1001 010 rd:5 0000
>> +NEG             1001 010 rd:5 0001
>> +INC             1001 010 rd:5 0011
>> +DEC             1001 010 rd:5 1010
>> +MUL             1001 11 . ..... ....        @op_rd_rr
>> +MULS            0000 0010 .... ....         &rd_rr      rd=3D%rd_a rr=
=3D%rr_a
>> +MULSU           0000 0011 0 ... 0 ...       @fmul
>> +FMUL            0000 0011 0 ... 1 ...       @fmul
>> +FMULS           0000 0011 1 ... 0 ...       @fmul
>> +FMULSU          0000 0011 1 ... 1 ...       @fmul
>> +DES             1001 0100 imm:4 1011
>> +
>> +#
>> +# Branch Instructions
>> +#
>> +RJMP            1100 imm:s12
>> +IJMP            1001 0100 0000 1001
>> +EIJMP           1001 0100 0001 1001
>> +JMP             1001 010 ..... 110 .        imm=3D%imm_call
>> +RCALL           1101 imm:s12
>> +ICALL           1001 0101 0000 1001
>> +EICALL          1001 0101 0001 1001
>> +CALL            1001 010 ..... 111 .        imm=3D%imm_call
>> +RET             1001 0101 0000 1000
>> +RETI            1001 0101 0001 1000
>> +CPSE            0001 00 . ..... ....        @op_rd_rr
>> +CP              0001 01 . ..... ....        @op_rd_rr
>> +CPC             0000 01 . ..... ....        @op_rd_rr
>> +CPI             0011 .... .... ....         @op_rd_imm8
>> +SBRC            1111 110 rr:5 0 bit:3
>> +SBRS            1111 111 rr:5 0 bit:3
>> +SBIC            1001 1001 reg:5 bit:3
>> +SBIS            1001 1011 reg:5 bit:3
>> +BRBS            1111 00 ....... ...         @op_bit_imm
>> +BRBC            1111 01 ....... ...         @op_bit_imm
>> +
>> +#
>> +# Data Transfer Instructions
>> +#
>> +MOV             0010 11 . ..... ....        @op_rd_rr
>> +MOVW            0000 0001 .... ....         &rd_rr      rd=3D%rd_d rr=
=3D%rr_d
>> +LDI             1110 .... .... ....         @op_rd_imm8
>> +LDS             1001 000 ..... 0000         @ldst_s
>> +LDX1            1001 000 rd:5 1100
>> +LDX2            1001 000 rd:5 1101
>> +LDX3            1001 000 rd:5 1110
>> +LDY2            1001 000 rd:5 1001
>> +LDY3            1001 000 rd:5 1010
>> +LDZ2            1001 000 rd:5 0001
>> +LDZ3            1001 000 rd:5 0010
>> +LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
>> +LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
>> +STS             1001 001 ..... 0000         @ldst_s
>> +STX1            1001 001 rr:5 1100
>> +STX2            1001 001 rr:5 1101
>> +STX3            1001 001 rr:5 1110
>> +STY2            1001 001 rd:5 1001
>> +STY3            1001 001 rd:5 1010
>> +STZ2            1001 001 rd:5 0001
>> +STZ3            1001 001 rd:5 0010
>> +STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
>> +STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
>> +LPM1            1001 0101 1100 1000
>> +LPM2            1001 000 rd:5 0100
>> +LPMX            1001 000 rd:5 0101
>> +ELPM1           1001 0101 1101 1000
>> +ELPM2           1001 000 rd:5 0110
>> +ELPMX           1001 000 rd:5 0111
>> +SPM             1001 0101 1110 1000
>> +SPMX            1001 0101 1111 1000
>> +IN              1011 0 .. ..... ....        @io_rd_imm
>> +OUT             1011 1 .. ..... ....        @io_rd_imm
>> +PUSH            1001 001 rd:5 1111
>> +POP             1001 000 rd:5 1111
>> +XCH             1001 001 rd:5 0100
>> +LAC             1001 001 rd:5 0110
>> +LAS             1001 001 rd:5 0101
>> +LAT             1001 001 rd:5 0111
>> +
>> +#
>> +# Bit and Bit-test Instructions
>> +#
>> +LSR             1001 010 rd:5 0110
>> +ROR             1001 010 rd:5 0111
>> +ASR             1001 010 rd:5 0101
>> +SWAP            1001 010 rd:5 0010
>> +SBI             1001 1010 reg:5 bit:3
>> +CBI             1001 1000 reg:5 bit:3
>> +BST             1111 101 rd:5 0 bit:3
>> +BLD             1111 100 rd:5 0 bit:3
>> +BSET            1001 0100 0 bit:3 1000
>> +BCLR            1001 0100 1 bit:3 1000
>> +
>> +#
>> +# MCU Control Instructions
>> +#
>> +BREAK           1001 0101 1001 1000
>> +NOP             0000 0000 0000 0000
>> +SLEEP           1001 0101 1000 1000
>> +WDR             1001 0101 1010 1000
>> +
>> --
>> 2.17.2 (Apple Git-113)
>>
>>

--=20
Best Regards,
Michael Rolnik

--00000000000074faa0059a38db9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgQWxla3NhbmRhci48ZGl2Pjxicj48L2Rpdj48ZGl2PnBsZWFzZSBl
eHBsYWluLjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9
Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwgRGVjIDIxLCAyMDE5IGF0IDE6MTggUE0g
QWxla3NhbmRhciBNYXJrb3ZpYyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIubS5tYWls
QGdtYWlsLmNvbSI+YWxla3NhbmRhci5tLm1haWxAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJy
PjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHgg
MHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRk
aW5nLWxlZnQ6MWV4Ij48YnI+PGJyPk9uIFdlZG5lc2RheSwgRGVjZW1iZXIgMTgsIDIwMTksIE1p
Y2hhZWwgUm9sbmlrICZsdDs8YSBocmVmPSJtYWlsdG86bXJvbG5pa0BnbWFpbC5jb20iIHRhcmdl
dD0iX2JsYW5rIj5tcm9sbmlrQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+VGhp
cyBpbmNsdWRlczo8YnI+DQotIGVuY29kaW5nIG9mIGFsbCAxNiBiaXQgaW5zdHJ1Y3Rpb25zPGJy
Pg0KLSBlbmNvZGluZyBvZiBhbGwgMzIgYml0IGluc3RydWN0aW9uczxicj4NCjxicj4NClNpZ25l
ZC1vZmYtYnk6IE1pY2hhZWwgUm9sbmlrICZsdDs8YSBocmVmPSJtYWlsdG86bXJvbG5pa0BnbWFp
bC5jb20iIHRhcmdldD0iX2JsYW5rIj5tcm9sbmlrQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KVGVz
dGVkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSAmbHQ7PGEgaHJlZj0ibWFpbHRvOnBoaWxt
ZEByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0Ozxi
cj4NCi0tLTwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pk1pY2hhZWwsPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5JIGFtIHZlcnkgcGxlYXNlZCB0aGF0IHlvdSByZWFycmFuZ2VkIHRo
ZSBvcmRlciB0byBiZSBpbiBzeW5jIHdpdGggdGhlIGRvY3VtZW50YXRpb24uPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5Ob3csIGZvciB0aGUgbmV4dCB2ZXJzaW9uLCBJIHdvdWxkIGFzayB5b3Ug
dG8gbWFrZSB0aGlzIHBhdGNoIGRpc2FwcGVhci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk1v
cmUgcHJlY2lzZWx5LCAmcXVvdDtNQ1UgQ29udHJvbCBJbnN0cnVjdGlvbnMmcXVvdDsgc2VjdGlv
biBvZsKgaW5zbi5kZWNvZGUgZmlsZSBtb3ZlIHRvIGJlIGEgcGFydCBvZiAmcXVvdDtBZGQgTUNV
IENvbnRyb2wgSW5zdHJ1Y3Rpb25zJnF1b3Q7IChub3Qgc3VyZSBhYml1dCB0aGUgdGl0bGUsIGJ1
dCBpdCBpcyA2IG9yIDcgcGF0Y2hlcyBhZnRlciB0aGlzIG9uZSkgwqBwYXRjaCwgYW5kIHNvIG9u
LCBpbiB0aGUgc2FtZSBmYXNoaW9uLCBmb3IgYWxsIGdyb3VwcyBvZiBpbnN0cnVjdGlvbnMuPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5LaW5kIHJlZ2FyZHMsPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5BbGVrc2FuZGFyPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3Bh
ZGRpbmctbGVmdDoxZXgiPg0KwqB0YXJnZXQvYXZyL2luc24uZGVjb2RlIHwgMTgzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KwqAxIGZpbGUgY2hhbmdlZCwg
MTgzIGluc2VydGlvbnMoKyk8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvYXZyL2lu
c24uZGVjb2RlPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL3RhcmdldC9hdnIvaW5zbi5kZWNvZGUg
Yi90YXJnZXQvYXZyL2luc24uZGVjb2RlPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQpp
bmRleCAwMDAwMDAwMDAwLi4wZTRlYzlkZGYwPGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBi
L3RhcmdldC9hdnIvaW5zbi5kZWNvZGU8YnI+DQpAQCAtMCwwICsxLDE4MyBAQDxicj4NCisjPGJy
Pg0KKyMgQVZSIGluc3RydWN0aW9uIGRlY29kZSBkZWZpbml0aW9ucy48YnI+DQorIzxicj4NCisj
IENvcHlyaWdodCAoYykgMjAxOSBNaWNoYWVsIFJvbG5payAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1y
b2xuaWtAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0
Ozxicj4NCisjPGJyPg0KKyMgVGhpcyBsaWJyYXJ5IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vcjxicj4NCisjIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMg
b2YgdGhlIEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWM8YnI+DQorIyBMaWNlbnNlIGFzIHB1Ymxp
c2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXI8YnI+DQorIyB2ZXJz
aW9uIDIuMSBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi48YnI+DQorIzxicj4NCisjIFRoaXMgbGlicmFyeSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4NCisjIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mPGJyPg0KKyMgTUVSQ0hB
TlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLsKgIFNlZSB0aGUg
R05VPGJyPg0KKyMgTGVzc2VyIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWls
cy48YnI+DQorIzxicj4NCisjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWM8YnI+DQorIyBMaWNlbnNlIGFsb25nIHdpdGggdGhp
cyBsaWJyYXJ5OyBpZiBub3QsIHNlZSAmbHQ7PGEgaHJlZj0iaHR0cDovL3d3dy5nbnUub3JnL2xp
Y2Vuc2VzLyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy88L2E+
Jmd0Oy48YnI+DQorIzxicj4NCis8YnI+DQorIzxicj4NCisjwqAgwqByZWdzXzE2XzMxX2J5X29u
ZSA9IFsxNiAuLiAzMV08YnI+DQorI8KgIMKgcmVnc18xNl8yM19ieV9vbmUgPSBbMTYgLi4gMjNd
PGJyPg0KKyPCoCDCoHJlZ3NfMjRfMzBfYnlfdHdvID0gWzI0LCAyNiwgMjgsIDMwXTxicj4NCisj
wqAgwqByZWdzXzAwXzMwX2J5X3R3byA9IFswLCAyLCA0LCA2LCA4LCAuLiAzMF08YnI+DQorPGJy
Pg0KKyVyZMKgIMKgIMKgIMKgIMKgIMKgIMKgNDo1PGJyPg0KKyVycsKgIMKgIMKgIMKgIMKgIMKg
IMKgOToxIDA6NDxicj4NCis8YnI+DQorJXJkX2HCoCDCoCDCoCDCoCDCoCDCoDQ6NMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWZ1bmN0aW9uPXRvX3JlZ3NfMTZfMzFfYnlf
b25lPGJyPg0KKyVyZF9iwqAgwqAgwqAgwqAgwqAgwqA0OjPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19yZWdzXzE2XzIzX2J5X29uZTxicj4NCislcmRf
Y8KgIMKgIMKgIMKgIMKgIMKgNDoywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAhZnVuY3Rpb249dG9fcmVnc18yNF8zMF9ieV90d288YnI+DQorJXJkX2TCoCDCoCDCoCDCoCDC
oCDCoDQ6NMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWZ1bmN0aW9uPXRv
X3JlZ3NfMDBfMzBfYnlfdHdvPGJyPg0KKyVycl9hwqAgwqAgwqAgwqAgwqAgwqAwOjTCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19yZWdzXzE2XzMxX2J5
X29uZTxicj4NCislcnJfYsKgIMKgIMKgIMKgIMKgIMKgMDozwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAhZnVuY3Rpb249dG9fcmVnc18xNl8yM19ieV9vbmU8YnI+DQorJXJy
X2TCoCDCoCDCoCDCoCDCoCDCoDA6NMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIWZ1bmN0aW9uPXRvX3JlZ3NfMDBfMzBfYnlfdHdvPGJyPg0KKzxicj4NCislaW1tNsKgIMKg
IMKgIMKgIMKgIMKgNjoyIDA6NDxicj4NCislaW1tOMKgIMKgIMKgIMKgIMKgIMKgODo0IDA6NDxi
cj4NCis8YnI+DQorJWlvX2ltbcKgIMKgIMKgIMKgIMKgOToyIDA6NDxicj4NCislbGRzdF9kX2lt
bcKgIMKgIMKgMTM6MSAxMDoyIDA6Mzxicj4NCis8YnI+DQorIyBUaGUgMjItYml0IGltbWVkaWF0
ZSBpcyBwYXJ0aWFsbHkgaW4gdGhlIG9wY29kZSB3b3JkLDxicj4NCisjIGFuZCBwYXJ0aWFsbHkg
aW4gdGhlIG5leHQuwqAgVXNlIGFwcGVuZF8xNiB0byBidWlsZCB0aGU8YnI+DQorIyBjb21wbGV0
ZSAyMi1iaXQgdmFsdWUuPGJyPg0KKyVpbW1fY2FsbMKgIMKgIMKgIMKgNDo1IDA6McKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWZ1bmN0aW9uPWFwcGVuZF8xNjxicj4NCis8YnI+DQor
PGJyPg0KKyZhbXA7cmRfcnLCoCDCoCDCoCDCoCDCoCByZCBycjxicj4NCismYW1wO3JkX2ltbcKg
IMKgIMKgIMKgIMKgcmQgaW1tPGJyPg0KKzxicj4NCitAb3BfcmRfcnLCoCDCoCDCoCDCoC4uLi4g
Li4gLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgJmFtcDtyZF9ycsKgIMKgIMKgIHJkPSVyZCBycj0l
cnI8YnI+DQorQG9wX3JkX2ltbTbCoCDCoCDCoC4uLi4gLi4uLiAuLiAuLiAuLi4uwqAgwqAgwqAg
wqAgJmFtcDtyZF9pbW3CoCDCoCDCoHJkPSVyZF9jIGltbT0laW1tNjxicj4NCitAb3BfcmRfaW1t
OMKgIMKgIMKgLi4uLiAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgJmFtcDtyZF9pbW3CoCDC
oCDCoHJkPSVyZF9hIGltbT0laW1tODxicj4NCitAb3BfYml0wqAgwqAgwqAgwqAgwqAuLi4uIC4u
Li4gLiBiaXQ6MyAuLi4uPGJyPg0KK0BvcF9iaXRfaW1twqAgwqAgwqAuLi4uIC4uIGltbTpzNyBi
aXQ6Mzxicj4NCitAZm11bMKgIMKgIMKgIMKgIMKgIMKgLi4uLiAuLi4uIC4gLi4uIC4gLi4uwqAg
wqAgwqAgwqAmYW1wO3JkX3JywqAgwqAgwqAgcmQ9JXJkX2IgcnI9JXJyX2I8YnI+DQorQGlvX3Jk
X2ltbcKgIMKgIMKgIC4uLi4gLiAuLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgJmFtcDtyZF9pbW3C
oCDCoCDCoHJkPSVyZCBpbW09JWlvX2ltbTxicj4NCitAbGRzdF9kwqAgwqAgwqAgwqAgwqAuLiAu
IC4gLi4gLiByZDo1wqAgLiAuLi7CoCDCoCDCoCZhbXA7cmRfaW1twqAgwqAgwqBpbW09JWxkc3Rf
ZF9pbW08YnI+DQorPGJyPg0KKyMgVGhlIDE2LWJpdCBpbW1lZGlhdGUgaXMgY29tcGxldGVseSBp
biB0aGUgbmV4dCB3b3JkLjxicj4NCisjIEZpZWxkcyBjYW5ub3QgYmUgZGVmaW5lZCB3aXRoIG5v
IGJpdHMsIHNvIHdlIGNhbm5vdCBwbGF5PGJyPg0KKyMgdGhlIHNhbWUgdHJpY2sgYW5kIGFwcGVu
ZCB0byBhIHplcm8tYml0IHZhbHVlLjxicj4NCisjIERlZmVyIHJlYWRpbmcgdGhlIGltbWVkaWF0
ZSB1bnRpbCB0cmFuc197TERTLFNUU30uPGJyPg0KK0BsZHN0X3PCoCDCoCDCoCDCoCDCoC4uLi4g
Li4uIHJkOjUgLi4uLsKgIMKgIMKgIMKgIMKgIGltbT0wPGJyPg0KKzxicj4NCisjPGJyPg0KKyMg
QXJpdGhtZXRpYyBJbnN0cnVjdGlvbnM8YnI+DQorIzxicj4NCitBRETCoCDCoCDCoCDCoCDCoCDC
oCDCoDAwMDAgMTEgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK0FEQ8Kg
IMKgIMKgIMKgIMKgIMKgIMKgMDAwMSAxMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRf
cnI8YnI+DQorQURJV8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDExMCAuLiAuLiAuLi4uwqAgwqAg
wqAgwqAgQG9wX3JkX2ltbTY8YnI+DQorU1VCwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAxIDEwIC4g
Li4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4NCitTVUJJwqAgwqAgwqAgwqAgwqAg
wqAgMDEwMSAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9wX3JkX2ltbTg8YnI+DQorU0JD
wqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAwIDEwIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9y
ZF9ycjxicj4NCitTQkNJwqAgwqAgwqAgwqAgwqAgwqAgMDEwMCAuLi4uIC4uLi4gLi4uLsKgIMKg
IMKgIMKgIMKgQG9wX3JkX2ltbTg8YnI+DQorU0JJV8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDEx
MSAuLiAuLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX2ltbTY8YnI+DQorQU5EwqAgwqAgwqAgwqAg
wqAgwqAgwqAwMDEwIDAwIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4NCitB
TkRJwqAgwqAgwqAgwqAgwqAgwqAgMDExMSAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9w
X3JkX2ltbTg8YnI+DQorT1LCoCDCoCDCoCDCoCDCoCDCoCDCoCAwMDEwIDEwIC4gLi4uLi4gLi4u
LsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4NCitPUknCoCDCoCDCoCDCoCDCoCDCoCDCoDAxMTAg
Li4uLiAuLi4uIC4uLi7CoCDCoCDCoCDCoCDCoEBvcF9yZF9pbW04PGJyPg0KK0VPUsKgIMKgIMKg
IMKgIMKgIMKgIMKgMDAxMCAwMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+
DQorQ09NwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCByZDo1IDAwMDA8YnI+DQorTkVHwqAg
wqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCByZDo1IDAwMDE8YnI+DQorSU5DwqAgwqAgwqAgwqAg
wqAgwqAgwqAxMDAxIDAxMCByZDo1IDAwMTE8YnI+DQorREVDwqAgwqAgwqAgwqAgwqAgwqAgwqAx
MDAxIDAxMCByZDo1IDEwMTA8YnI+DQorTVVMwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDExIC4g
Li4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4NCitNVUxTwqAgwqAgwqAgwqAgwqAg
wqAgMDAwMCAwMDEwIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgJmFtcDtyZF9ycsKgIMKgIMKgIHJk
PSVyZF9hIHJyPSVycl9hPGJyPg0KK01VTFNVwqAgwqAgwqAgwqAgwqAgwqAwMDAwIDAwMTEgMCAu
Li4gMCAuLi7CoCDCoCDCoCDCoEBmbXVsPGJyPg0KK0ZNVUzCoCDCoCDCoCDCoCDCoCDCoCAwMDAw
IDAwMTEgMCAuLi4gMSAuLi7CoCDCoCDCoCDCoEBmbXVsPGJyPg0KK0ZNVUxTwqAgwqAgwqAgwqAg
wqAgwqAwMDAwIDAwMTEgMSAuLi4gMCAuLi7CoCDCoCDCoCDCoEBmbXVsPGJyPg0KK0ZNVUxTVcKg
IMKgIMKgIMKgIMKgIDAwMDAgMDAxMSAxIC4uLiAxIC4uLsKgIMKgIMKgIMKgQGZtdWw8YnI+DQor
REVTwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMDAgaW1tOjQgMTAxMTxicj4NCis8YnI+DQor
Izxicj4NCisjIEJyYW5jaCBJbnN0cnVjdGlvbnM8YnI+DQorIzxicj4NCitSSk1QwqAgwqAgwqAg
wqAgwqAgwqAgMTEwMCBpbW06czEyPGJyPg0KK0lKTVDCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAx
MDAgMDAwMCAxMDAxPGJyPg0KK0VJSk1QwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMDAgMDAwMSAx
MDAxPGJyPg0KK0pNUMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAgLi4uLi4gMTEwIC7CoCDC
oCDCoCDCoCBpbW09JWltbV9jYWxsPGJyPg0KK1JDQUxMwqAgwqAgwqAgwqAgwqAgwqAxMTAxIGlt
bTpzMTI8YnI+DQorSUNBTEzCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAwMDAwIDEwMDE8YnI+
DQorRUlDQUxMwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAxIDAwMDEgMTAwMTxicj4NCitDQUxMwqAg
wqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAgLi4uLi4gMTExIC7CoCDCoCDCoCDCoCBpbW09JWltbV9j
YWxsPGJyPg0KK1JFVMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAxIDAwMDAgMTAwMDxicj4N
CitSRVRJwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAxIDAwMDEgMTAwMDxicj4NCitDUFNFwqAg
wqAgwqAgwqAgwqAgwqAgMDAwMSAwMCAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8
YnI+DQorQ1DCoCDCoCDCoCDCoCDCoCDCoCDCoCAwMDAxIDAxIC4gLi4uLi4gLi4uLsKgIMKgIMKg
IMKgIEBvcF9yZF9ycjxicj4NCitDUEPCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMDAgMDEgLiAuLi4u
LiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK0NQScKgIMKgIMKgIMKgIMKgIMKgIMKg
MDAxMSAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9wX3JkX2ltbTg8YnI+DQorU0JSQ8Kg
IMKgIMKgIMKgIMKgIMKgIDExMTEgMTEwIHJyOjUgMCBiaXQ6Mzxicj4NCitTQlJTwqAgwqAgwqAg
wqAgwqAgwqAgMTExMSAxMTEgcnI6NSAwIGJpdDozPGJyPg0KK1NCSUPCoCDCoCDCoCDCoCDCoCDC
oCAxMDAxIDEwMDEgcmVnOjUgYml0OjM8YnI+DQorU0JJU8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEg
MTAxMSByZWc6NSBiaXQ6Mzxicj4NCitCUkJTwqAgwqAgwqAgwqAgwqAgwqAgMTExMSAwMCAuLi4u
Li4uIC4uLsKgIMKgIMKgIMKgIMKgQG9wX2JpdF9pbW08YnI+DQorQlJCQ8KgIMKgIMKgIMKgIMKg
IMKgIDExMTEgMDEgLi4uLi4uLiAuLi7CoCDCoCDCoCDCoCDCoEBvcF9iaXRfaW1tPGJyPg0KKzxi
cj4NCisjPGJyPg0KKyMgRGF0YSBUcmFuc2ZlciBJbnN0cnVjdGlvbnM8YnI+DQorIzxicj4NCitN
T1bCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMTAgMTEgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9w
X3JkX3JyPGJyPg0KK01PVlfCoCDCoCDCoCDCoCDCoCDCoCAwMDAwIDAwMDEgLi4uLiAuLi4uwqAg
wqAgwqAgwqAgwqAmYW1wO3JkX3JywqAgwqAgwqAgcmQ9JXJkX2QgcnI9JXJyX2Q8YnI+DQorTERJ
wqAgwqAgwqAgwqAgwqAgwqAgwqAxMTEwIC4uLi4gLi4uLiAuLi4uwqAgwqAgwqAgwqAgwqBAb3Bf
cmRfaW1tODxicj4NCitMRFPCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDAwIC4uLi4uIDAwMDDC
oCDCoCDCoCDCoCDCoEBsZHN0X3M8YnI+DQorTERYMcKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAw
IHJkOjUgMTEwMDxicj4NCitMRFgywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDAgcmQ6NSAxMTAx
PGJyPg0KK0xEWDPCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMCByZDo1IDExMTA8YnI+DQorTERZ
MsKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAwIHJkOjUgMTAwMTxicj4NCitMRFkzwqAgwqAgwqAg
wqAgwqAgwqAgMTAwMSAwMDAgcmQ6NSAxMDEwPGJyPg0KK0xEWjLCoCDCoCDCoCDCoCDCoCDCoCAx
MDAxIDAwMCByZDo1IDAwMDE8YnI+DQorTERaM8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAwIHJk
OjUgMDAxMDxicj4NCitMRERZwqAgwqAgwqAgwqAgwqAgwqAgMTAgLiAwIC4uIDAgLi4uLi4gMSAu
Li7CoCDCoCDCoEBsZHN0X2Q8YnI+DQorTEREWsKgIMKgIMKgIMKgIMKgIMKgIDEwIC4gMCAuLiAw
IC4uLi4uIDAgLi4uwqAgwqAgwqBAbGRzdF9kPGJyPg0KK1NUU8KgIMKgIMKgIMKgIMKgIMKgIMKg
MTAwMSAwMDEgLi4uLi4gMDAwMMKgIMKgIMKgIMKgIMKgQGxkc3Rfczxicj4NCitTVFgxwqAgwqAg
wqAgwqAgwqAgwqAgMTAwMSAwMDEgcnI6NSAxMTAwPGJyPg0KK1NUWDLCoCDCoCDCoCDCoCDCoCDC
oCAxMDAxIDAwMSBycjo1IDExMDE8YnI+DQorU1RYM8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAx
IHJyOjUgMTExMDxicj4NCitTVFkywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDEgcmQ6NSAxMDAx
PGJyPg0KK1NUWTPCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSByZDo1IDEwMTA8YnI+DQorU1Ra
MsKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIHJkOjUgMDAwMTxicj4NCitTVFozwqAgwqAgwqAg
wqAgwqAgwqAgMTAwMSAwMDEgcmQ6NSAwMDEwPGJyPg0KK1NURFnCoCDCoCDCoCDCoCDCoCDCoCAx
MCAuIDAgLi4gMSAuLi4uLiAxIC4uLsKgIMKgIMKgQGxkc3RfZDxicj4NCitTVERawqAgwqAgwqAg
wqAgwqAgwqAgMTAgLiAwIC4uIDEgLi4uLi4gMCAuLi7CoCDCoCDCoEBsZHN0X2Q8YnI+DQorTFBN
McKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDEwMSAxMTAwIDEwMDA8YnI+DQorTFBNMsKgIMKgIMKg
IMKgIMKgIMKgIDEwMDEgMDAwIHJkOjUgMDEwMDxicj4NCitMUE1YwqAgwqAgwqAgwqAgwqAgwqAg
MTAwMSAwMDAgcmQ6NSAwMTAxPGJyPg0KK0VMUE0xwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMDEg
MTEwMSAxMDAwPGJyPg0KK0VMUE0ywqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAwMCByZDo1IDAxMTA8
YnI+DQorRUxQTVjCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDAwIHJkOjUgMDExMTxicj4NCitTUE3C
oCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAxMTEwIDEwMDA8YnI+DQorU1BNWMKgIMKgIMKg
IMKgIMKgIMKgIDEwMDEgMDEwMSAxMTExIDEwMDA8YnI+DQorSU7CoCDCoCDCoCDCoCDCoCDCoCDC
oCAxMDExIDAgLi4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBpb19yZF9pbW08YnI+DQorT1VUwqAg
wqAgwqAgwqAgwqAgwqAgwqAxMDExIDEgLi4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBpb19yZF9p
bW08YnI+DQorUFVTSMKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIHJkOjUgMTExMTxicj4NCitQ
T1DCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDAwIHJkOjUgMTExMTxicj4NCitYQ0jCoCDCoCDC
oCDCoCDCoCDCoCDCoDEwMDEgMDAxIHJkOjUgMDEwMDxicj4NCitMQUPCoCDCoCDCoCDCoCDCoCDC
oCDCoDEwMDEgMDAxIHJkOjUgMDExMDxicj4NCitMQVPCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEg
MDAxIHJkOjUgMDEwMTxicj4NCitMQVTCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDAxIHJkOjUg
MDExMTxicj4NCis8YnI+DQorIzxicj4NCisjIEJpdCBhbmQgQml0LXRlc3QgSW5zdHJ1Y3Rpb25z
PGJyPg0KKyM8YnI+DQorTFNSwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCByZDo1IDAxMTA8
YnI+DQorUk9SwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCByZDo1IDAxMTE8YnI+DQorQVNS
wqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCByZDo1IDAxMDE8YnI+DQorU1dBUMKgIMKgIMKg
IMKgIMKgIMKgIDEwMDEgMDEwIHJkOjUgMDAxMDxicj4NCitTQknCoCDCoCDCoCDCoCDCoCDCoCDC
oDEwMDEgMTAxMCByZWc6NSBiaXQ6Mzxicj4NCitDQknCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEg
MTAwMCByZWc6NSBiaXQ6Mzxicj4NCitCU1TCoCDCoCDCoCDCoCDCoCDCoCDCoDExMTEgMTAxIHJk
OjUgMCBiaXQ6Mzxicj4NCitCTETCoCDCoCDCoCDCoCDCoCDCoCDCoDExMTEgMTAwIHJkOjUgMCBi
aXQ6Mzxicj4NCitCU0VUwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAwIDAgYml0OjMgMTAwMDxi
cj4NCitCQ0xSwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAwIDEgYml0OjMgMTAwMDxicj4NCis8
YnI+DQorIzxicj4NCisjIE1DVSBDb250cm9sIEluc3RydWN0aW9uczxicj4NCisjPGJyPg0KK0JS
RUFLwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMDEgMTAwMSAxMDAwPGJyPg0KK05PUMKgIMKgIMKg
IMKgIMKgIMKgIMKgMDAwMCAwMDAwIDAwMDAgMDAwMDxicj4NCitTTEVFUMKgIMKgIMKgIMKgIMKg
IMKgMTAwMSAwMTAxIDEwMDAgMTAwMDxicj4NCitXRFLCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEg
MDEwMSAxMDEwIDEwMDA8YnI+DQorPGJyPg0KLS0gPGJyPg0KMi4xNy4yIChBcHBsZSBHaXQtMTEz
KTxicj4NCjxicj4NCjwvYmxvY2txdW90ZT4NCjwvYmxvY2txdW90ZT48L2Rpdj48YnIgY2xlYXI9
ImFsbCI+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9z
aWduYXR1cmUiPkJlc3QgUmVnYXJkcyw8YnI+TWljaGFlbCBSb2xuaWs8L2Rpdj4NCg==
--00000000000074faa0059a38db9b--

