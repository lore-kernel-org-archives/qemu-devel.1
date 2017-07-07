Received: from eggs.gnu.org ([2001:4830:134:3::10]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTV1l-0003Vy-0W
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTV1h-0003eo-1M
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:40 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTV1g-0003ef-Sd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:18:36 -0400
Received: by mail-qt0-x232.google.com with SMTP id i2so29584968qta.3
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 08:18:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865462073.17063.17488435214703164893.stgit@frigg.lan>
	<20170630004134.GJ13979@flamenco> <87h8yofvka.fsf@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9104ecbc-fe41-e318-d35f-d59d618acbf4@twiddle.net>
Date: Fri, 7 Jul 2017 05:18:30 -1000
MIME-Version: 1.0
In-Reply-To: <87h8yofvka.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/06/2017 11:25 PM, Lluís Vilanova wrote:
>>> /* convert one instruction. s->base.is_jmp is set if the translation must
>>> be stopped. Return the next pc value */
>>> -static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
>>> -                               target_ulong pc_start)
>>> +static target_ulong disas_insn(DisasContextBase *dcbase, CPUState *cpu)
>>> {
>>> +    DisasContext *s = container_of(dcbase, DisasContext, base);
>>> +    CPUX86State *env = cpu->env_ptr;
> 
>> Minor nit: you can pass dc (*s) here directly, no need for container_of
> [...]
> 
> I prefer not to so that the code will work in the future (i.e., not assuming the
> location of base inside disascontext).

There's clearly a misunderstanding here.

Emilio is saying that disas_insn is not a hook and private to the front-end. 
Therefore the argument to the function should be "DisasContet *s" and not 
"DisasContextBase *dcbase".

And I agree.  Passing DisasContext should be preferred where possible.


r~
