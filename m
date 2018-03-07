Received: from eggs.gnu.org ([2001:4830:134:3::10]:43478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQj9-00069q-Js
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etQj8-0006Sz-Hn
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:30:55 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:34435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etQj8-0006St-Bz
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 23:30:54 -0500
Received: by mail-oi0-x22d.google.com with SMTP id c83so727465oib.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 20:30:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Nvm2L52Rt+EquCsLa9itaNb1GDo2xDDN9UtvhrC_5JKRA@mail.gmail.com>
References: <1520369037-37977-1-git-send-email-mjc@sifive.com>
	<1520369037-37977-8-git-send-email-mjc@sifive.com>
	<8787c302-b90a-df1f-9eb3-3ee16022a92e@amsat.org>
	<CAHNT7Nvm2L52Rt+EquCsLa9itaNb1GDo2xDDN9UtvhrC_5JKRA@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 7 Mar 2018 17:30:53 +1300
Message-ID: <CAHNT7NuSGqH3A4eGthE_zm16_iji7+wPF9g+BxvBG-W36mHb4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/22] RISC-V: Remove unused class
 definitions from
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches machines <patches@groups.riscv.org>

On Wed, Mar 7, 2018 at 5:14 PM, Michael Clark <mjc@sifive.com> wrote:

>
>
> On Wed, Mar 7, 2018 at 12:27 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
>
>>
>> Ok until here.
>>
>> > diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
>> > index 0aebc57..818fbdc 100644
>> > --- a/include/hw/riscv/sifive_e.h
>> > +++ b/include/hw/riscv/sifive_e.h
>> > @@ -19,16 +19,7 @@
>> >  #ifndef HW_SIFIVE_E_H
>> >  #define HW_SIFIVE_E_H
>> >
>> > -#define TYPE_SIFIVE_E "riscv.sifive_e"
>> > -
>> > -#define SIFIVE_E(obj) \
>> > -    OBJECT_CHECK(SiFiveEState, (obj), TYPE_SIFIVE_E)
>> > -
>> >  typedef struct SiFiveEState {
>> > -    /*< private >*/
>> > -    SysBusDevice parent_obj;
>>
>> I'd keep however a 'Object parent_obj' here, to stay QOM; but your patch
>> is valid.
>>
>
> Okay I'll keep parent_obj when I respin.
>

BTW is the string constant in DEFINE_MACHINE a QOM type?

i.e. should I keep the type conversion and type name macros and use the
type name macro in DEFINE_MACHINE?
