Received: from eggs.gnu.org ([2001:4830:134:3::10]:46443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4YTX-0006Hb-Pl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4YTU-0002xb-JY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:28:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4YTU-0002ww-Cg
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:28:28 -0400
Date: Tue, 17 Oct 2017 16:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017202826.GB1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171016172609.23422-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 02/50] tcg: Propagate args to op->args
 in optimizer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Mon, Oct 16, 2017 at 10:25:21 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/optimize.c | 430 ++++++++++++++++++++++++++++++---------------------------
(snip)
> @@ -559,7 +557,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
>  void tcg_optimize(TCGContext *s)
>  {
>      int oi, oi_next, nb_temps, nb_globals;
> -    TCGArg *prev_mb_args = NULL;
> +    TCGOp *prev_mb = NULL;
>  
>      /* Array VALS has an element for each temp.
>         If this temp holds a constant then its value is kept in VALS' element.
> @@ -576,7 +574,6 @@ void tcg_optimize(TCGContext *s)
>          TCGArg tmp;
>  
>          TCGOp * const op = &s->gen_op_buf[oi];
> -        TCGArg * const args = op->args;

Reviewed-by: Emilio G. Cota <cota@braap.org>

Just for my own education: why doesn't gcc generate the same code when
leaving 'args' as above? I thought we could simplify the diff without
any side effects, but it turns out that more code is generated.

Thanks,

		E.
