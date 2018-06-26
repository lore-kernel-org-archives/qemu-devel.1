Received: from eggs.gnu.org ([2001:4830:134:3::10]:49501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXr6y-0005c9-5C
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXr6v-0000Tm-2Y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:46:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626142214.27801-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <927c3763-d08e-9aea-900b-1977ca036a30@amsat.org>
Date: Tue, 26 Jun 2018 13:46:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180626142214.27801-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix pnv_core_realize() error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/26/2018 11:22 AM, Cédric Le Goater wrote:
> commit d35aefa9ae15 ("ppc/pnv: introduce a new intc_create() operation
> to the chip model") changed the object link in the pnv_core_realize()
> routine but a return was forgotten in case of error, which can lead to
> more problems afterwards (segv)
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ppc/pnv_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a9f129fc2c5f..9750464bf4a1 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -150,6 +150,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>      if (!chip) {
>          error_propagate(errp, local_err);
>          error_prepend(errp, "required link 'chip' not found: ");
> +        return;
>      }
>  
>      pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
> 
