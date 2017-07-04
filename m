Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSITq-0007LN-LA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSITn-00009Z-BD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:42:42 -0400
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-2-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b11aa61c-ff73-3568-f924-e10828c0e92c@redhat.com>
Date: Tue, 4 Jul 2017 09:42:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170703131455.25424-2-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v3 1/2] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Singh <sursingh@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

On 03.07.2017 15:14, Laurent Vivier wrote:
> CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> 
> When we run qemu on a POWER9 DD1 host, we must use either
> "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> 
>     Unable to find sPAPR CPU Core definition
> 
> because POWER9 DD1 doesn't appear in the list of known CPUs.
> 
> This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> PVR instead of CPU_POWERPC_POWER9_BASE. It also adds POWER_v2.0
> with POWER9 DD2 PVR to avoid to trigger kernel POWER9 DD1 workaround
> in TCG mode.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 5 ++++-
>  target/ppc/cpu-models.c | 6 ++++--
>  target/ppc/cpu-models.h | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 9fb896b..00918a5 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -249,8 +249,11 @@ static const char *spapr_core_models[] = {
>      /* POWER8NVL */
>      "POWER8NVL_v1.0",
>  
> -    /* POWER9 */
> +    /* POWER9 DD1 */
>      "POWER9_v1.0",
> +
> +    /* POWER9 DD2 */
> +    "POWER9_v2.0",

In case you re-spin, what about a more compact listing:

    /* POWER9 */
    "POWER9_v1.0",
    "POWER9_v2.0",

?

Anyway, patch looks good to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
