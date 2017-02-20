Received: from eggs.gnu.org ([2001:4830:134:3::10]:47820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfgL2-0003kn-Lv
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 00:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cfgL1-0003Hl-LS
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 00:16:40 -0500
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 20 Feb 2017 16:16:26 +1100
Message-ID: <20170220051626.GA661@balbir.ozlabs.ibm.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-2-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487563478-22265-2-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 01/10]
 target/ppc/POWER9: Add ISAv3.00 MMU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Mon, Feb 20, 2017 at 03:04:29PM +1100, Suraj Jitindar Singh wrote:
> POWER9 processors implement the mmu as defined in version 3.00 of the ISA.
> 
> Add a definition for this mmu model and set the POWER9 cpu model to use
> this mmu model.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  target/ppc/cpu-qom.h        | 5 ++++-
>  target/ppc/mmu_helper.c     | 2 ++
>  target/ppc/translate_init.c | 3 +--
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index b7977ba..4e3132b 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -86,10 +86,13 @@ enum powerpc_mmu_t {
>      POWERPC_MMU_2_07       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
>                               | POWERPC_MMU_64K
>                               | POWERPC_MMU_AMR | 0x00000004,
> -    /* FIXME Add POWERPC_MMU_3_OO defines */
>      /* Architecture 2.07 "degraded" (no 1T segments)           */
>      POWERPC_MMU_2_07a      = POWERPC_MMU_64 | POWERPC_MMU_AMR
>                               | 0x00000004,
> +    /* Architecture 3.00 variant                               */
> +    POWERPC_MMU_3_00       = POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> +                             | POWERPC_MMU_64K
> +                             | POWERPC_MMU_AMR | 0x00000005,

I wonder if we need a POWERPC_MMU_RADIX that we can then attach
with future versions

Balbir Singh.
