Received: from eggs.gnu.org ([2001:4830:134:3::10]:40965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cQgKQ-0005WK-8n
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cQgKN-0001LG-1v
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:14:02 -0500
Date: Mon, 9 Jan 2017 21:13:54 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170109201354.GV9606@toto>
References: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Fix Coverity warning about
 unchecked NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org

On Mon, Jan 09, 2017 at 07:05:59PM +0000, Peter Maydell wrote:
> Coverity (CID 1005689) warns that we don't check that
> spec_reg_info() returned non-NULL before dereferencing.
> Add the check, though as the comment notes this is
> a can't-really-happen case because the earlier constraint
> matching should have ruled out the "unknown reg" case.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  disas/cris.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disas/cris.c b/disas/cris.c
> index 08161d1..8a1daf9 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -2490,7 +2490,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>  	const struct cris_spec_reg *sregp
>  	  = spec_reg_info ((insn >> 12) & 15, disdata->distype);
>  
> -	if (sregp->name == NULL)
> +	if (sregp == NULL || sregp->name == NULL)
>  	  /* Should have been caught as a non-match earlier.  */
>  	  *tp++ = '?';
>  	else
> -- 
> 2.7.4
> 
