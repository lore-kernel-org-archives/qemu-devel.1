Received: from eggs.gnu.org ([2001:4830:134:3::10]:36337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLF2v-0006Q7-UJ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLF2s-0007lw-Qw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:37:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLF2s-0007lm-M2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:37:42 -0400
Date: Wed, 14 Jun 2017 16:37:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170614203741.GC8420@flamenco>
References: <20170614194821.8754-1-rth@twiddle.net>
	<20170614194821.8754-3-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614194821.8754-3-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/alpha: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com

On Wed, Jun 14, 2017 at 12:48:18 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
(snip)
> @@ -1198,7 +1205,10 @@ static ExitStatus gen_call_pal(DisasContext *ctx, int palcode)
>              tcg_gen_andi_i64(tmp, ctx->ir[IR_A0], PS_INT_MASK);
>              tcg_gen_st8_i64(tmp, cpu_env, offsetof(CPUAlphaState, ps));
>              tcg_temp_free(tmp);
> -            break;
> +
> +            /* Allow interrupts to be recognized right away.  */
> +            tcg_gen_movi_i64(cpu_pc, ctx.pc);

ctx->pc though

Tested-by: Emilio G. Cota <cota@braap.org>

Thanks!

		E.
