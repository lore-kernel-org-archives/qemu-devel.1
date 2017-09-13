Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsB48-00066u-38
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsB42-0000xx-Bc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:03:08 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:46670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsB42-0000xO-5y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 13:03:02 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e199so1170931pfh.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:03:02 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506035158.19604.740046564057160055.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6ded11bd-dcae-2e98-5af6-3f2cc77706d8@linaro.org>
Date: Wed, 13 Sep 2017 10:02:58 -0700
MIME-Version: 1.0
In-Reply-To: <150506035158.19604.740046564057160055.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] trace: Add event "guest_inst_before"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/10/2017 09:19 AM, Lluís Vilanova wrote:
>      while (true) {
> +        target_ulong pc_insn = db->pc_next;

Why not just "pc"?

> +
>          db->num_insns++;
>          ops->insn_start(db, cpu);
>          tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
> @@ -96,6 +98,7 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>          if (db->num_insns == 1) {
>              trace_guest_bbl_before_tcg(cpu, tcg_ctx.tcg_env, db->pc_first);
>          }
> +        trace_guest_inst_before_tcg(cpu, tcg_ctx.tcg_env, pc_insn);

I prefer "insn" over "inst".  There are enough other words that begin with
"inst" (e.g. instance) to possibly be confusing.  Either that or it's my 20
years working on gcc that ingrained "insn".  ;-)


r~
