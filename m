Received: from eggs.gnu.org ([2001:4830:134:3::10]:36691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dST2x-0000Dr-KL
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dST2s-0006KD-PF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:59:39 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:36908 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dST2s-0006Jt-C0
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:59:34 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
	<528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net>
Date: Tue, 04 Jul 2017 20:59:15 +0200
In-Reply-To: <528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net> (Richard
	Henderson's message of "Sat, 1 Jul 2017 16:37:43 -0700")
Message-ID: <8760f8av0c.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 06/28/2017 05:32 AM, Llu=C3=ADs Vilanova wrote:
>> +    void (*init_disas_context)(DisasContextBase *db, CPUState *cpu);
>> +    void (*init_globals)(DisasContextBase *db, CPUState *cpu);
>> +    void (*tb_start)(DisasContextBase *db, CPUState *cpu);
>> +    void (*insn_start)(DisasContextBase *db, CPUState *cpu);
>> +    BreakpointCheckType (*breakpoint_check)(DisasContextBase *db, CPUSt=
ate *cpu,
>> +                                            const CPUBreakpoint *bp);
>> +    target_ulong (*translate_insn)(DisasContextBase *db, CPUState *cpu);
>> +    void (*tb_stop)(DisasContextBase *db, CPUState *cpu);
>> +    void (*disas_log)(const DisasContextBase *db, CPUState *cpu);

> Any reason not to stuff the cpu pointer into the DisasContextBase instead=
 of
> passing it around separately?

None, really. I'll move it from DisasContext (in targets where it's present)
into DisasContextBase, and use that one everywhere.


> Otherwise,

> Reviewed-by: Richard Henderson <rth@twiddle.net>


Thanks,
  Lluis
