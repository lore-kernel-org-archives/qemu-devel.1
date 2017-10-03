Received: from eggs.gnu.org ([2001:4830:134:3::10]:58030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dzQt7-0000SU-Op
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dzQt2-0005DF-QI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:21:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dzQt2-0005Cm-Hq
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:21:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v93HKMCk112633
	for <qemu-devel@nongnu.org>; Tue, 3 Oct 2017 13:21:34 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dccgm8rh1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 13:21:34 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 3 Oct 2017 11:21:33 -0600
References: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 3 Oct 2017 14:21:27 -0300
MIME-Version: 1.0
In-Reply-To: <150703999112.6139.714822137654210421.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <8498924e-39ce-7bcc-fe07-60ca4eda8c90@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc: use 0 instead of
 fdt_path_offset(fdt, "/")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>



On 10/03/2017 11:13 AM, Greg Kurz wrote:
> The offset of the root node is guaranteed to be 0.
>
> This doesn't fix anything, it's just trivial cleanup of the two
> remaining places where this was done under hw/ppc.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

> ---
>   hw/ppc/pnv.c   |    3 +--
>   hw/ppc/spapr.c |    3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index d46d91c76f5c..84b2389ea60b 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -92,8 +92,7 @@ static int get_cpus_node(void *fdt)
>       int cpus_offset = fdt_path_offset(fdt, "/cpus");
>
>       if (cpus_offset < 0) {
> -        cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
> -                                      "cpus");
> +        cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
>           if (cpus_offset) {
>               _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
>               _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ff87f155d55e..352ff3d614e8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -353,8 +353,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
>
>           cpus_offset = fdt_path_offset(fdt, "/cpus");
>           if (cpus_offset < 0) {
> -            cpus_offset = fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
> -                                          "cpus");
> +            cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
>               if (cpus_offset < 0) {
>                   return cpus_offset;
>               }
>
>
