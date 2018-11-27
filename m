Received: from eggs.gnu.org ([2001:4830:134:3::10]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gRdv6-0002Tl-AM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1gRdv0-00008E-Mq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:00:56 -0500
Date: Tue, 27 Nov 2018 15:00:16 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20181127140016.GD20151@toto>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332397198.541746.6299446399761681597.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154332397198.541746.6299446399761681597.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 7/9] virtex_ml507: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, Nov 27, 2018 at 02:06:12PM +0100, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/ppc/virtex_ml507.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index ee9b4b449086..517712057434 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -105,7 +105,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
>      ppc_dcr_init(env, NULL, NULL);
>  
>      /* interrupt controller */
> -    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
>      ppcuic_init(env, irqs, 0x0C0, 0, 1);
> 
