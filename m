Received: from eggs.gnu.org ([2001:4830:134:3::10]:38190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ctyxf-0005zI-Kx
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ctyxc-0006Pd-GO
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:59:39 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ctyxc-0006OS-7w
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:59:36 -0400
Received: by mail-wr0-x244.google.com with SMTP id w43so21470713wrb.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 08:59:35 -0700 (PDT)
Date: Fri, 31 Mar 2017 17:59:33 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170331155933.GG9606@toto>
References: <1490970671-20560-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490970671-20560-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Avoid unintentional sign
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org

On Fri, Mar 31, 2017 at 03:31:11PM +0100, Peter Maydell wrote:
> Commit 001ebaca7b11 fixed some unintended sign extension issues
> spotted by Coverity (CID 1005402, 1005403), but didn't catch
> all of them. Fix the rest, so we behave consistently whether
> 'long' is 32 bit or 64 bit.

Thanks!
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  disas/cris.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/cris.c b/disas/cris.c
> index 30217f1..2dd56de 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -2048,7 +2048,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>  	  {
>  	    /* We're looking at [pc+], i.e. we need to output an immediate
>  	       number, where the size can depend on different things.  */
> -	    long number;
> +	    int32_t number;
>  	    int signedp
>  	      = ((*cs == 'z' && (insn & 0x20))
>  		 || opcodep->match == BDAP_QUICK_OPCODE);
> @@ -2290,7 +2290,7 @@ print_with_operands (const struct cris_opcode *opcodep,
>  
>  		    if ((prefix_insn & 0x400) && (prefix_insn & 15) == 15)
>  		      {
> -			long number;
> +			int32_t number;
>  			unsigned int nbytes;
>  
>  			/* It's a value.  Get its size.  */
> -- 
> 2.7.4
> 
