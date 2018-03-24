Received: from eggs.gnu.org ([208.118.235.92]:34570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eziQF-0001K9-Ax
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 08:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezgvL-00075g-G3
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 07:04:18 -0400
MIME-Version: 1.0
In-Reply-To: <4e8dcc24123a09587ecc427f2e80727ba41a7866.1521868380.git.mprivozn@redhat.com>
References: <4e8dcc24123a09587ecc427f2e80727ba41a7866.1521868380.git.mprivozn@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 24 Mar 2018 12:01:20 +0100
Message-ID: <CAJ+F1CJgXUY888Bo-SQ2yiDWeKk0NKe06bdzkZFL7A-6B4FusQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Sat, Mar 24, 2018 at 6:13 AM, Michal Privoznik <mprivozn@redhat.com> wro=
te:
> When trying to build with latest libcacard-2.5.1, I hit the
> following error:
>
> In file included from hw/usb/ccid-card-passthru.c:12:0:
> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacar=
d.h> can be included directly" [-Werror=3Dcpp]
>  #warning "Only <libcacard.h> can be included directly"
>

The warning was promptly removed in 2.5.2:
https://cgit.freedesktop.org/spice/libcacard/commit/?id=3D998db1e88eb821926=
4476c022d1446f3cb4330e8

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  hw/usb/ccid-card-emulated.c | 5 +----
>  hw/usb/ccid-card-passthru.c | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
> index ea42e4681d..7b538ae6da 100644
> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -27,10 +27,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include <eventt.h>
> -#include <vevent.h>
> -#include <vreader.h>
> -#include <vcard_emul.h>
> +#include <cacard/libcacard.h>
>
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index b7dd3602dc..982d575edd 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -9,7 +9,7 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include <cacard/vscard_common.h>
> +#include <cacard/libcacard.h>
>  #include "chardev/char-fe.h"
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
> --
> 2.16.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
