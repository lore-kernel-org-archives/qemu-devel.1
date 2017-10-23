Received: from eggs.gnu.org ([2001:4830:134:3::10]:33454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gf3-0006Ob-Hl
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e6gf0-0006UQ-Bf
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:37:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47999)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e6gf0-0006Tw-5v
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:37:10 -0400
Date: Mon, 23 Oct 2017 13:37:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171023173709.GF6901@flamenco>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-22-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020232023.15010-22-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v7 21/52] tcg: Use offsets not indices for
 TCGv_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, pbonzini@redhat.com

On Fri, Oct 20, 2017 at 16:19:52 -0700, Richard Henderson wrote:
> Using the offset of a temporary, relative to TCGContext, rather than
> its index means that we don't use 0.  That leaves offset 0 free for
> a NULL representation without having to leave index 0 unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.h | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/tcg/tcg.h b/tcg/tcg.h
> index 8f692bc6cf..7fe0fb9e07 100644
> --- a/tcg/tcg.h
> +++ b/tcg/tcg.h
> @@ -429,13 +429,13 @@ typedef TCGv_ptr TCGv_env;
>  #endif
(snip)
>  /* used to align parameters */
> -#define TCG_CALL_DUMMY_ARG      ((TCGArg)(-1))
> +#define TCG_CALL_DUMMY_ARG      ((TCGArg)0)

We're doing something clever here (on a first read I thought TCGContext
was a typo), so I'd leave a comment somewhere. TCG_CALL_DUMMY_ARG might
be a good place to do so; a copy of the commit's message should suffice.

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
