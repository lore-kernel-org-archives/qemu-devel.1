Received: from eggs.gnu.org ([2001:4830:134:3::10]:36799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d7wx1-0007ZH-HI
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1d7www-0008Bl-Is
	for qemu-devel@nongnu.org; Tue, 09 May 2017 00:40:43 -0400
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<20170508205735.23444-4-ehabkost@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <04e27551-61a7-8f35-7a80-efddfee0f62e@reactos.org>
Date: Tue, 9 May 2017 06:40:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170508205735.23444-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] audio: Rename hw/audio/audio.h to
 hw/audio/soundhw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Gerd Hoffmann <kraxel@redhat.com>, agraf@suse.de

Le 08/05/2017 =E0 22:57, Eduardo Habkost a =E9crit :
> All the functions in hw/audio/audio.h are called "soundhw_*()"
> and live in hw/audio/audiohw.c. Rename the header file for
> consistency.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>

> ---
> Changes v2 -> v3:
> * Update header name at hw/ppc/prep.c too
>
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> ---
>  include/hw/audio/{audio.h =3D> soundhw.h} | 0
>  arch_init.c                             | 2 +-
>  hw/audio/ac97.c                         | 2 +-
>  hw/audio/adlib.c                        | 2 +-
>  hw/audio/cs4231a.c                      | 2 +-
>  hw/audio/es1370.c                       | 2 +-
>  hw/audio/gus.c                          | 2 +-
>  hw/audio/intel-hda.c                    | 2 +-
>  hw/audio/pcspk.c                        | 2 +-
>  hw/audio/sb16.c                         | 2 +-
>  hw/audio/soundhw.c                      | 2 +-
>  hw/ppc/prep.c                           | 2 +-
>  vl.c                                    | 2 +-
>  13 files changed, 12 insertions(+), 12 deletions(-)
>  rename include/hw/audio/{audio.h =3D> soundhw.h} (100%)
>
> diff --git a/include/hw/audio/audio.h b/include/hw/audio/soundhw.h
> similarity index 100%
> rename from include/hw/audio/audio.h
> rename to include/hw/audio/soundhw.h
> diff --git a/arch_init.c b/arch_init.c
> index 74ca62f508..a0b8ed6167 100644
> --- a/arch_init.c
> +++ b/arch_init.c
> @@ -27,7 +27,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/arch_init.h"
>  #include "hw/pci/pci.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qmp-commands.h"
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index c30657501c..959c786261 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -19,7 +19,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/pci/pci.h"
>  #include "sysemu/dma.h"
> diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
> index 09b8248cda..c6e0f10c16 100644
> --- a/hw/audio/adlib.c
> +++ b/hw/audio/adlib.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/isa/isa.h"
>
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index 3ecd0582bf..096e8e98d7 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -23,7 +23,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev.h"
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index fe64c1ac37..dd7c23d185 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -28,7 +28,7 @@
>
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/pci/pci.h"
>  #include "sysemu/dma.h"
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index ec103a4db9..3e864cd36d 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -24,7 +24,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/isa/isa.h"
>  #include "gusemu.h"
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 2c497eb174..06acc98f7b 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -22,7 +22,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
>  #include "qemu/timer.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "intel-hda.h"
>  #include "intel-hda-defs.h"
>  #include "sysemu/dma.h"
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 798002277b..c815a2b9ca 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -26,7 +26,7 @@
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/isa/isa.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "qemu/timer.h"
>  #include "hw/timer/i8254.h"
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 6b4427f242..6ab2f6f89a 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -23,7 +23,7 @@
>   */
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev.h"
> diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
> index 29565da93d..e698909d34 100644
> --- a/hw/audio/soundhw.c
> +++ b/hw/audio/soundhw.c
> @@ -28,7 +28,7 @@
>  #include "qom/object.h"
>  #include "hw/isa/isa.h"
>  #include "hw/pci/pci.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>
>  struct soundhw {
>      const char *name;
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 4a7d2cfbe0..d16646c95d 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -36,7 +36,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/ppc/ppc.h"
>  #include "hw/boards.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "hw/ide.h"
> diff --git a/vl.c b/vl.c
> index 42fd66ac0d..54b44937e6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -89,7 +89,7 @@ int main(int argc, char **argv)
>  #include "migration/block.h"
>  #include "sysemu/tpm.h"
>  #include "sysemu/dma.h"
> -#include "hw/audio/audio.h"
> +#include "hw/audio/soundhw.h"
>  #include "audio/audio.h"
>  #include "migration/migration.h"
>  #include "sysemu/cpus.h"
>
