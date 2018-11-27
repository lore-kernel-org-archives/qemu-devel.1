Received: from eggs.gnu.org ([2001:4830:134:3::10]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdde-0003tS-L4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdda-0008Ms-MY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRdda-0008ME-HG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:42:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so22743080wrt.7
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:42:50 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332393835.541746.592813777514601908.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bbbf2939-7109-301b-4aa9-f8dcd0742601@redhat.com>
Date: Tue, 27 Nov 2018 14:42:48 +0100
MIME-Version: 1.0
In-Reply-To: <154332393835.541746.592813777514601908.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/9] ppc405_uc: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/11/18 14:05, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/ppc/ppc405_uc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
> index 5c58415cf1fd..e1aadf126d59 100644
> --- a/hw/ppc/ppc405_uc.c
> +++ b/hw/ppc/ppc405_uc.c
> @@ -1519,7 +1519,7 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
>      /* OBP arbitrer */
>      ppc4xx_opba_init(0xef600600);
>      /* Universal interrupt controller */
> -    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =
>          ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =
> @@ -1877,7 +1877,7 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
>      /* Initialize timers */
>      ppc_booke_timers_init(cpu, sysclk, 0);
>      /* Universal interrupt controller */
> -    irqs = g_malloc0(sizeof(qemu_irq) * PPCUIC_OUTPUT_NB);
> +    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] =
>          ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] =
> 
> 
