Received: from eggs.gnu.org ([2001:4830:134:3::10]:59928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWMyA-0007ET-5t
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWMy6-0003pP-7b
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:55:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gWMy6-0003oW-1L
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 09:55:34 -0500
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5877a477-9f86-00e4-fce7-87485d54533e@redhat.com>
Date: Mon, 10 Dec 2018 15:55:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181207165103.3992-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] tests: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 12/07/18 17:51, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acpi-utils.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
> index 41dc1ea9b4..297af55d39 100644
> --- a/tests/acpi-utils.c
> +++ b/tests/acpi-utils.c
> @@ -15,7 +15,6 @@
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>  #include "qemu-common.h"
> -#include "hw/smbios/smbios.h"
>  #include "qemu/bitmap.h"
>  #include "acpi-utils.h"
>  #include "boot-sector.h"
>=20

Opinions vary whether empty commit message bodies are good style or not.
Personally I prefer to put at least one sentence in there, even if it
only repeats the subject line. Up to subsystem maintainers to decide I
guess.

With the commit message updated, or not:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
