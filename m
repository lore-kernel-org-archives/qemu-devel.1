Received: from eggs.gnu.org ([2001:4830:134:3::10]:40415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTWhl-0002qr-DL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTWhi-00066A-8I
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:06:09 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:53662)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTWhh-00064c-RX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:06:06 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865462073.17063.17488435214703164893.stgit@frigg.lan>
	<20170630004134.GJ13979@flamenco> <87h8yofvka.fsf@frigg.lan>
	<9104ecbc-fe41-e318-d35f-d59d618acbf4@twiddle.net>
Date: Fri, 07 Jul 2017 19:05:47 +0200
In-Reply-To: <9104ecbc-fe41-e318-d35f-d59d618acbf4@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 05:18:30 -1000")
Message-ID: <87shi8ch3o.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 10/29] target/i386: [tcg] Refactor
 translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 07/06/2017 11:25 PM, Llu=C3=ADs Vilanova wrote:
>>>> /* convert one instruction. s->base.is_jmp is set if the translation m=
ust
>>>> be stopped. Return the next pc value */
>>>> -static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
>>>> -                               target_ulong pc_start)
>>>> +static target_ulong disas_insn(DisasContextBase *dcbase, CPUState *cp=
u)
>>>> {
>>>> +    DisasContext *s =3D container_of(dcbase, DisasContext, base);
>>>> +    CPUX86State *env =3D cpu->env_ptr;
>>=20
>>> Minor nit: you can pass dc (*s) here directly, no need for container_of
>> [...]
>>=20
>> I prefer not to so that the code will work in the future (i.e., not assu=
ming the
>> location of base inside disascontext).

> There's clearly a misunderstanding here.

> Emilio is saying that disas_insn is not a hook and private to the
> front-end. Therefore the argument to the function should be "DisasContet =
*s" and
> not "DisasContextBase *dcbase".

> And I agree.  Passing DisasContext should be preferred where possible.

Woooops, my bad! :)


Thanks,
  Lluis
