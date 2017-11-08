Received: from eggs.gnu.org ([2001:4830:134:3::10]:32918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eCOY2-00040Z-S7
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eCOXz-0000BR-MG
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:29:34 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:51161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eCOXz-0000Ag-FI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 06:29:31 -0500
Received: from player774.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id EB8A711E1B2
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 12:29:29 +0100 (CET)
Date: Wed, 8 Nov 2017 12:29:24 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171108122924.57660092@bahia.lan>
In-Reply-To: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] spapr_pci: fix the path
 while fetching loc-code from host DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue,  7 Nov 2017 18:48:58 +0530
Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com> wrote:

> The function spapr_phb_vfio_get_loc_code uses wrong path for
> fetching loc-code from host DT
> 

Why is it wrong ? Are you experiencing actual issues ?

> this is the call that needs to be fixed:
> /* Construct and read from host device tree the loc-code */
> path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
> 

This statement is useless, especially with such a trivial patch.

Have a look at the following page:

https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message

Cheers,

--
Greg

> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5a3122a..ae86322 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -762,7 +762,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice *pdev)
>      g_free(path);
>  
>      /* Construct and read from host device tree the loc-code */
> -    path = g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
> +    path = g_strdup_printf("/proc/device-tree/%s/ibm,loc-code", buf);
>      g_free(buf);
>      if (!g_file_get_contents(path, &buf, NULL, NULL)) {
>          goto err_out;
