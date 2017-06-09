Received: from eggs.gnu.org ([2001:4830:134:3::10]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1dJGqU-000344-BX
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sahid.ferdjaoui@redhat.com>) id 1dJGqR-0004R1-3v
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:08:46 -0400
Date: Fri, 9 Jun 2017 12:08:38 +0200
From: Sahid Orentino Ferdjaoui <sferdjao@redhat.com>
Message-ID: <20170609100838.GA32246@redhat>
References: <1496991197-1815-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496991197-1815-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Remove superfluous call to
 soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Jun 09, 2017 at 08:53:17AM +0200, Thomas Huth wrote:
> When using the 40p machine, soundhw_init() is currently called twice,
> one time from vl.c and one time from ibm_40p_init(). The call in
> ibm_40p_init() was likely just a copy-and-paste from a old version
> of the prep machine - but there the call to audio_init() (which was
> the previous name of this function) has been removed many years ago
> already, with commit b3e6d591b05538056d665572f3e3bbfb3cbb70e7
> ("audio: enable PCI audio cards for all PCI-enabled targets"), so
> we certainly also do not need the soundhw_init() in the 40p function
> anymore nowadays.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Sahid Ferdjaoui <sferdjao@redhat.com>

For information:
  b3e6d591 - audio: enable PCI audio cards for all PCI-enabled targets
  4c565674 - audio: Rename audio_init() to soundhw_init()	    

> ---
>  hw/ppc/prep.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index d16646c..36d3dcd 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -36,7 +36,6 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/boards.h"
> -#include "hw/audio/soundhw.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "hw/ide.h"
> @@ -782,9 +781,6 @@ static void ibm_40p_init(MachineState *machine)
>      qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NULL, NULL,
>                         &cmos_checksum);
>  
> -    /* initialize audio subsystem */
> -    soundhw_init();
> -
>      /* add some more devices */
>      if (defaults_enabled()) {
>          isa_create_simple(isa_bus, "i8042");
> -- 
> 1.8.3.1
> 
