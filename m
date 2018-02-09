Received: from eggs.gnu.org ([2001:4830:134:3::10]:42690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekDiH-0007Zp-2M
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekDiG-00034P-6r
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:47:57 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180209181330.17371-1-danielhb@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c698bcc-707f-8c2e-704d-285b6cba12f4@amsat.org>
Date: Fri, 9 Feb 2018 15:47:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180209181330.17371-1-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/ppc: rename functions in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 02/09/2018 03:13 PM, Daniel Henrique Barboza wrote:
> Commit bcb5ce08cf ("spapr: Rename machine init functions for clarity")
> renamed ppc_spapr_reset to spapr_machine_reset and ppc_spapr_init
> to spapr_machine_init. Let's also rename the references in
> comments.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/spapr.c       | 3 ++-
>  hw/ppc/spapr_hcall.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 659be6b746..96515036e6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -464,7 +464,8 @@ static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
>              }
>          }
>          if (!mem_start) {
> -            /* ppc_spapr_init() checks for rma_size <= node0_size already */
> +            /* spapr_machine_init() checks for rma_size <= node0_size
> +             * already */
>              spapr_populate_memory_node(fdt, i, 0, spapr->rma_size);
>              mem_start += spapr->rma_size;
>              node_size -= spapr->rma_size;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d0e6eb0cf..badf01cece 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1635,7 +1635,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      spapr->cas_legacy_guest_workaround = !spapr_ovec_test(ov1_guest,
>                                                            OV1_PPC_3_00);
>      if (!spapr->cas_reboot) {
> -        /* If ppc_spapr_reset() did not set up a HPT but one is necessary
> +        /* If spapr_machine_reset() did not set up a HPT but one is necessary
>           * (because the guest isn't going to use radix) then set it up here. */
>          if ((spapr->patb_entry & PATBE1_GR) && !guest_radix) {
>              /* legacy hash or new hash: */
> 
