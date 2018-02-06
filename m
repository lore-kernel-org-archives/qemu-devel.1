Received: from eggs.gnu.org ([2001:4830:134:3::10]:51928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBRE-0001Xe-2w
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBRD-0004ZO-89
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:10:04 -0500
Date: Tue, 6 Feb 2018 20:09:53 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206220953.GA13301@localhost.localdomain>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694904-64879-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/25] nios2: 10m50_devboard: replace
 cpu_model with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Tue, Jan 23, 2018 at 09:08:00AM +0100, Igor Mammedov wrote:
> use cpu_create() instead of being removed cpu_generic_init()
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Chris Wulff <crwulff@gmail.com>
> CC: Marek Vasut <marex@denx.de>
> ---
>  hw/nios2/10m50_devboard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
> index e4007f6..42053b2 100644
> --- a/hw/nios2/10m50_devboard.c
> +++ b/hw/nios2/10m50_devboard.c
> @@ -75,7 +75,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
>                                  phys_ram_alias);
>  
>      /* Create CPU -- FIXME */
> -    cpu = NIOS2_CPU(cpu_generic_init(TYPE_NIOS2_CPU, "nios2"));
> +    cpu = NIOS2_CPU(cpu_create(TYPE_NIOS2_CPU));

Matches what nios2_cpu_class_by_name() does.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
