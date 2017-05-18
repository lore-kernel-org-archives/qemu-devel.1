Received: from eggs.gnu.org ([2001:4830:134:3::10]:42484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBQ2a-0006Fb-7G
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dBQ2Z-0008Ch-Eq
	for qemu-devel@nongnu.org; Thu, 18 May 2017 14:20:48 -0400
Date: Thu, 18 May 2017 15:20:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170518182039.GO4748@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495094971-177754-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] numa: silence incomplete mapping
 warning under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, May 18, 2017 at 10:09:31AM +0200, Igor Mammedov wrote:
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Where exactly is the test code that triggers those messages and
requires this patch? I would like to document that in the commit
message.

> ---
> CC: Markus Armbruster <armbru@redhat.com>
> 
> ---
>  hw/core/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2e91aa9..21ebef8 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -21,6 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/qtest.h"
>  
>  static char *machine_get_accel(Object *obj, Error **errp)
>  {
> @@ -732,7 +733,7 @@ static void machine_numa_finish_init(MachineState *machine)
>              }
>          }
>      }
> -    if (s->len) {
> +    if (s->len && !qtest_enabled()) {
>          error_report("warning: CPU(s) not present in any NUMA nodes: %s",
>                       s->str);
>          error_report("warning: All CPU(s) up to maxcpus should be described "
> -- 
> 2.7.4
> 

-- 
Eduardo
