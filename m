Received: from eggs.gnu.org ([2001:4830:134:3::10]:54453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPqKw-0003RL-9F
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gPqKu-0000qd-Ti
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:52:10 -0500
References: <154289709597.235079.13366613265527123490.stgit@bahia.lan>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2d93a332-33ad-3d3a-ab70-300d33b14e53@vivier.eu>
Date: Thu, 22 Nov 2018 15:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <154289709597.235079.13366613265527123490.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] spapr: drop redundant
 statement in spapr_populate_drconf_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 22/11/2018 15:31, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9c41098b5781..7771a628f879 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -893,8 +893,6 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
>      /* ibm,associativity-lookup-arrays */
>      buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
>      cur_index = int_buf = g_malloc0(buf_len);
> -
> -    cur_index = int_buf;
>      int_buf[0] = cpu_to_be32(nr_nodes);
>      int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
>      cur_index += 2;
> 
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
