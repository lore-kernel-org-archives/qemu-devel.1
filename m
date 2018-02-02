Received: from eggs.gnu.org ([2001:4830:134:3::10]:32789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ehT1n-00056U-Lb
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 23:33:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1ehT0j-0005iF-Gq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 23:32:43 -0500
Message-ID: <1517545890.2332.23.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 02 Feb 2018 15:31:30 +1100
In-Reply-To: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
References: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: add missing break in
 h_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Thu, 2018-02-01 at 20:47 +0100, Greg Kurz wrote:
> Detected by Coverity (CID 1385702). This fixes the recently added
> hypercall
> to let guests properly apply Spectre and Meltdown workarounds.
> 
> Fixes: c59704b25473 "target/ppc/spapr: Add H-Call
> H_GET_CPU_CHARACTERISTICS"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

> ---
>  hw/ppc/spapr_hcall.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4d0e6eb0cf1d..596f58378a40 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1697,6 +1697,7 @@ static target_ulong
> h_get_cpu_characteristics(PowerPCCPU *cpu,
>      switch (safe_indirect_branch) {
>      case SPAPR_CAP_FIXED:
>          characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
> +        break;
>      default: /* broken */
>          assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
>          break;
> 
