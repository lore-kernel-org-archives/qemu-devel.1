Received: from eggs.gnu.org ([2001:4830:134:3::10]:59528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4Yue-0003WS-Oe
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4Yua-0007gf-Qb
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:56:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e4Yua-0007g8-KF
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 16:56:28 -0400
Date: Tue, 17 Oct 2017 16:56:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171017205627.GG1345@flamenco>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
	<20171016172609.23422-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016172609.23422-8-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 07/50] tcg: Return NULL temp for
 TCG_CALL_DUMMY_ARG
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

On Mon, Oct 16, 2017 at 10:25:26 -0700, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/tcg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index fc4d1ed58b..5fcdec1fc5 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -731,7 +731,7 @@ extern bool parallel_cpus;
>  
>  static inline TCGTemp *arg_temp(TCGArg a)
>  {
> -    return &tcg_ctx.temps[a];
> +    return a == TCG_CALL_DUMMY_ARG ? NULL : &tcg_ctx.temps[a];
>  }

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
