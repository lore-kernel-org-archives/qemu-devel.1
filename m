Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdkS-0001jJ-0y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdkO-00071R-1n
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:49:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRdkN-00070Y-P5
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:49:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id l3so52125wme.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:49:51 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332396179.541746.10027261414540930953.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2cd5fe2f-d01c-b195-318b-e08eede46cd6@redhat.com>
Date: Tue, 27 Nov 2018 14:49:49 +0100
MIME-Version: 1.0
In-Reply-To: <154332396179.541746.10027261414540930953.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 6/9] sam460ex: use g_new(T,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/ppc/sam460ex.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 5aac58f36ee1..4b051c0950a9 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -430,7 +430,7 @@ static void sam460ex_init(MachineState *machine)
>      ppc4xx_plb_init(env);
>  
>      /* interrupt controllers */
> -    irqs = g_malloc0(sizeof(*irqs) * PPCUIC_OUTPUT_NB);
> +    irqs = g_new0(qemu_irq, PPCUIC_OUTPUT_NB);
>      irqs[PPCUIC_OUTPUT_INT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_INT];
>      irqs[PPCUIC_OUTPUT_CINT] = ((qemu_irq *)env->irq_inputs)[PPC40x_INPUT_CINT];
>      uic[0] = ppcuic_init(env, irqs, 0xc0, 0, 1);
> 
> 
