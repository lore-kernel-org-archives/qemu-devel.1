Received: from eggs.gnu.org ([2001:4830:134:3::10]:48006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdi1-0007IP-OX
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdhx-0003yW-Os
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:47:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRdhv-0003va-OZ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:47:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so22783640wrw.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:47:19 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332397198.541746.6299446399761681597.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c53fd40e-fb41-25c9-5e6f-7a291f98319d@redhat.com>
Date: Tue, 27 Nov 2018 14:47:16 +0100
MIME-Version: 1.0
In-Reply-To: <154332397198.541746.6299446399761681597.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/11/18 14:06, Greg Kurz wrote:
> Because it is a recommended coding practice (see HACKING).
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
>      ppcuic_init(env, irqs, 0x0C0, 0, 1);
> 
> 
