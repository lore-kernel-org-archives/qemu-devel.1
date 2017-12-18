Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQs1l-00041h-3k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQs1k-0000GN-5k
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:48:05 -0500
MIME-Version: 1.0
References: <20171218015947.17293-1-f4bug@amsat.org>
In-Reply-To: <20171218015947.17293-1-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Dec 2017 09:47:52 +0000
Message-ID: <CAJ+F1C+42pi5=9KX6811ndi6P_8z_Yr75gRYpzmgZ3ZZRruPZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/tpm: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>

Le lun. 18 d=C3=A9c. 2017 =C3=A0 03:01, Philippe Mathieu-Daud=C3=A9 <f4bug@=
amsat.org> a
=C3=A9crit :

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
> Based-on: 1513446109-9013-33-git-send-email-stefanb@linux.vnet.ibm.com
> ---
>  hw/tpm/tpm_emulator.c    | 1 -
>  hw/tpm/tpm_passthrough.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 3ae8bf6c5a..38b6f175a1 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -33,7 +33,6 @@
>  #include "sysemu/tpm_backend.h"
>  #include "tpm_int.h"
>  #include "hw/hw.h"
> -#include "hw/i386/pc.h"
>  #include "tpm_util.h"
>  #include "tpm_ioctl.h"
>  #include "migration/blocker.h"
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 487aae2043..149fae63e6 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -29,7 +29,6 @@
>  #include "sysemu/tpm_backend.h"
>  #include "tpm_int.h"
>  #include "hw/hw.h"
> -#include "hw/i386/pc.h"
>  #include "qapi/clone-visitor.h"
>  #include "tpm_util.h"
>
> --
> 2.15.1
>
>
> --
Marc-Andr=C3=A9 Lureau
