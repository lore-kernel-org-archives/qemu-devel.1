Received: from eggs.gnu.org ([2001:4830:134:3::10]:55621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fY8Yy-00048s-2t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fY8Yt-0003sj-64
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:24:40 -0400
Date: Wed, 27 Jun 2018 13:24:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627132429.03e418ec@redhat.com>
In-Reply-To: <20180625124238.25339-13-f4bug@amsat.org>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 12/46] hw/tpm: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, 25 Jun 2018 09:42:04 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/h=
w/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/tpm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 46ac4dc581..3580ffd50c 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -16,6 +16,7 @@
>  #ifndef HW_ACPI_TPM_H
>  #define HW_ACPI_TPM_H
> =20
> +#include "qemu/units.h"
>  #include "hw/registerfields.h"
> =20
>  #define TPM_TIS_ADDR_BASE           0xFED40000
> @@ -176,7 +177,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_CRB_ADDR_CTRL           (TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ)
>  #define TPM_CRB_R_MAX               R_CRB_DATA_BUFFER
> =20
> -#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
> +#define TPM_LOG_AREA_MINIMUM_SIZE   (64 * KiB)
> =20
>  #define TPM_TCPA_ACPI_CLASS_CLIENT  0
>  #define TPM_TCPA_ACPI_CLASS_SERVER  1
