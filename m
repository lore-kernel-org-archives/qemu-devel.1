Received: from eggs.gnu.org ([2001:4830:134:3::10]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dK8LP-0007Bb-MA
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 15:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dK8LK-00050C-OZ
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 15:16:15 -0400
References: <1496991197-1815-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <2b0f04b5-3c4b-4f07-f852-bc73ae8af915@reactos.org>
Date: Sun, 11 Jun 2017 21:15:51 +0200
MIME-Version: 1.0
In-Reply-To: <1496991197-1815-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

Le 09/06/2017 =E0 08:53, Thomas Huth a =E9crit :
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

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>

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
>      qbus_walk_children(BUS(isa_bus), prep_set_cmos_checksum, NULL, NUL=
L, NULL,
>                         &cmos_checksum);
>
> -    /* initialize audio subsystem */
> -    soundhw_init();
> -
>      /* add some more devices */
>      if (defaults_enabled()) {
>          isa_create_simple(isa_bus, "i8042");
>
