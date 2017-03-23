Received: from eggs.gnu.org ([2001:4830:134:3::10]:56634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cr8bx-0001Gt-Ic
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cr8bt-0003Ze-N4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:41:29 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cr8bt-0003Xu-Fs
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 15:41:25 -0400
Received: by mail-wm0-x243.google.com with SMTP id x124so1279563wmf.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 12:41:25 -0700 (PDT)
Date: Thu, 23 Mar 2017 20:41:22 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170323194122.GD9606@toto>
References: <1490272961-1128-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490272961-1128-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9] disas/microblaze: Remove unused
 REG_PC define
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

On Thu, Mar 23, 2017 at 12:42:41PM +0000, Peter Maydell wrote:
> The REG_PC define in disas/microblaze.c clashes with a define in
> the Linux SPARC system headers:
> 
> /home/pm215/qemu/disas/microblaze.c:162:0: error: "REG_PC" redefined [-Werror]
>  #define REG_PC  32 /* PC */
> 
> In file included from /usr/include/signal.h:326:0,
>                  from /home/pm215/qemu/include/qemu/osdep.h:86,
>                  from /home/pm215/qemu/disas/microblaze.c:36:
> /usr/include/sparc64-linux-gnu/sys/ucontext.h:96:0: note: this is the location of the previous definition
>  #define REG_PC  (1)
> 
> Since the code doesn't actually use the REG_PC define
> anywhere, the simplest fix is just to remove it.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  disas/microblaze.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 407c0a3..7795a0b 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -159,7 +159,7 @@ enum microblaze_instr_type {
>  #define MIN_PVR_REGNUM 0
>  #define MAX_PVR_REGNUM 15
>  
> -#define REG_PC  32 /* PC */
> +/* 32 is REG_PC */
>  #define REG_MSR 33 /* machine status reg */
>  #define REG_EAR 35 /* Exception reg */
>  #define REG_ESR 37 /* Exception reg */
> -- 
> 2.7.4
> 
