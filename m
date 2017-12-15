Received: from eggs.gnu.org ([2001:4830:134:3::10]:50665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePjig-0006iA-Eg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ePjid-0004Y4-By
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:43:42 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:42254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ePjid-0004Vz-5x
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 01:43:39 -0500
Received: by mail-it0-x241.google.com with SMTP id p139so17242370itb.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 22:43:37 -0800 (PST)
References: <20171215061739.9494-1-clg@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <df01dd59-d118-0bc4-3c1e-21bdaa3e47b0@ozlabs.ru>
Date: Fri, 15 Dec 2017 17:43:32 +1100
MIME-Version: 1.0
In-Reply-To: <20171215061739.9494-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: change powernv_ prefix
 to pnv_ for overall naming consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 15/12/17 17:17, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c         | 84 ++++++++++++++++++++++++++--------------------------
>  hw/ppc/pnv_core.c    |  8 ++---
>  hw/ppc/pnv_lpc.c     |  2 +-
>  include/hw/ppc/pnv.h |  8 ++---
>  4 files changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c35c439d816b..4bc5f61d0da7 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -77,7 +77,7 @@ static const char *pnv_chip_core_typename(const PnvChip *o)
>   * that has a different "affinity". In practice, it means one range
>   * per chip.
>   */
> -static void powernv_populate_memory_node(void *fdt, int chip_id, hwaddr start,
> +static void pnv_populate_memory_node(void *fdt, int chip_id, hwaddr start,
>                                           hwaddr size)

You may also want to fix indentations like the line above.




-- 
Alexey
