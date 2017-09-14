Received: from eggs.gnu.org ([2001:4830:134:3::10]:46189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVK0-0005Vx-Il
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVJv-0002J3-JE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:40:52 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:42258)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dsVJv-0002Hf-8j
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:40:47 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506035158.19604.740046564057160055.stgit@frigg.lan>
	<6ded11bd-dcae-2e98-5af6-3f2cc77706d8@linaro.org>
Date: Thu, 14 Sep 2017 17:40:38 +0300
In-Reply-To: <6ded11bd-dcae-2e98-5af6-3f2cc77706d8@linaro.org> (Richard
	Henderson's message of "Wed, 13 Sep 2017 10:02:58 -0700")
Message-ID: <871sn9qr6h.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] trace: Add event "guest_inst_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Richard Henderson writes:

> On 09/10/2017 09:19 AM, Llu=C3=ADs Vilanova wrote:
>> while (true) {
>> +        target_ulong pc_insn =3D db->pc_next;

> Why not just "pc"?

>> +
db-> num_insns++;
ops-> insn_start(db, cpu);
>> tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
>> @@ -96,6 +98,7 @@ void translator_loop(const TranslatorOps *ops, DisasCo=
ntextBase *db,
>> if (db->num_insns =3D=3D 1) {
>> trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_first);
>> }
>> +        trace_guest_inst_before_tcg(cpu, tcg_ctx.tcg_env, pc_insn);

> I prefer "insn" over "inst".  There are enough other words that begin with
> "inst" (e.g. instance) to possibly be confusing.  Either that or it's my =
20
> years working on gcc that ingrained "insn".  ;-)

Both work for me, so no problem in switching to pc and insn.

Thanks,
  Lluis
