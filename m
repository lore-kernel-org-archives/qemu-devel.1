Received: from eggs.gnu.org ([2001:4830:134:3::10]:52277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dCVuP-0003Nb-8H
	for qemu-devel@nongnu.org; Sun, 21 May 2017 14:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dCVuK-0003JP-OK
	for qemu-devel@nongnu.org; Sun, 21 May 2017 14:48:53 -0400
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-4-git-send-email-bharata@linux.vnet.ibm.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <13948266-7fd2-a752-3546-cb236f87d16d@redhat.com>
Date: Sun, 21 May 2017 20:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <1495172439-1504-4-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/4] spapr: Make
 h_register_process_table hcall flags global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On 19/05/2017 07:40, Bharata B Rao wrote:
> The flags used in h_register_process_table hcall are needed in spapr.c
> and hence move them to a header file. While doing so, give them
> slightly specific names.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c   | 31 ++++++++++++++-----------------
>  include/hw/ppc/spapr.h | 10 ++++++++++
>  2 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index cea5d99..3915e6f 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -921,13 +921,6 @@ static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
>      return;
>  }
>  
> -#define FLAGS_MASK              0x01FULL
> -#define FLAG_MODIFY             0x10
> -#define FLAG_REGISTER           0x08
> -#define FLAG_RADIX              0x04
> -#define FLAG_HASH_PROC_TBL      0x02
> -#define FLAG_GTSE               0x01
> -
...
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index e581c4a..588872a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -685,4 +685,14 @@ int spapr_rng_populate_dt(void *fdt);
>  
>  void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
>  
> +/*
> + * Defines for flag value used in H_REGISTER_PROC_TBL hcall.
> + */
> +#define SPAPR_PROC_TABLE_MASK        0x01FULL
> +#define SPAPR_PROC_TABLE_MODIFY      0x10
> +#define SPAPR_PROC_TABLE_REGISTER    0x08
> +#define SPAPR_PROC_TABLE_RADIX       0x04
> +#define SPAPR_PROC_TABLE_HPT_PT      0x02
> +#define SPAPR_PROC_TABLE_GTSE        0x01

I think it should be cleaner if you use 0x1fULL

Laurent
