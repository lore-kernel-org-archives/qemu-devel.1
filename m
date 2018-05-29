Received: from eggs.gnu.org ([2001:4830:134:3::10]:48708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNcuF-0005Vc-DT
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fNcuE-0000zm-O8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 07:35:11 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-21-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54a3e4cc-86d8-47b4-26ff-290fbd76da41@redhat.com>
Date: Tue, 29 May 2018 13:35:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-21-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/21] hw/ide: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: "open list:IDE" <qemu-block@nongnu.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 29.05.2018 01:27, Philippe Mathieu-Daud=C3=A9 wrote:
> There is no need to include pci.h in this file.
> (Continue f23c81073a cleanup).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/ide/core.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 866c659498..cc9ca28c33 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -25,7 +25,6 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/hw.h"
> -#include "hw/pci/pci.h"
>  #include "hw/isa/isa.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
