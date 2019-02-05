Received: from eggs.gnu.org ([209.51.188.92]:49775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqxFb-0003MO-8m
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqxFX-0007OY-Mc
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:42:42 -0500
References: <20190204210433.26088-1-philmd@redhat.com>
	<20190204210433.26088-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <67868e05-4481-707a-0311-617a388c8b50@redhat.com>
Date: Tue, 5 Feb 2019 10:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190204210433.26088-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/3] hw/unicore32/puv3: Drop
 useless inclusion of "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>

On 2019-02-04 22:04, Philippe Mathieu-Daud=C3=A9 wrote:
> In 47973a2dbf we split the last generic chipset out of the PC
> board, but forgot to remove the include of "hw/i386/pc.h".
> Since it is now unused, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/unicore32/puv3.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 830fe3face..b42e600f74 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -15,7 +15,6 @@
>  #include "ui/console.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/i386/pc.h"
>  #include "sysemu/qtest.h"
> =20
>  #undef DEBUG_PUV3
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
