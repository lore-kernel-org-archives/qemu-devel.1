Received: from eggs.gnu.org ([2001:4830:134:3::10]:56506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDBGW-0008KU-Jm
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dDBGV-00057b-Ro
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:58:28 -0400
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-7-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <79598bed-714f-7c3b-a806-3bf1a4968fd2@msgid.tls.msk.ru>
Date: Tue, 23 May 2017 17:58:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170508233918.9043-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] hw/arm: removed unnecessary include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

09.05.2017 02:39, Philippe Mathieu-Daud=C3=A9 wrote:
> "exec/memory.h" already includes it.

I think this sort of include cleanups isn't really necessary.
For a regular include file, it's better to include it if the
.c file in question uses definitions from there, no matter if
other .h files include that header already or not.

Thanks,

/mjt

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/arm.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index a3f79d3379..b9c11d3fb8 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -14,7 +14,6 @@
>  #include "exec/memory.h"
>  #include "target/arm/cpu-qom.h"
>  #include "hw/irq.h"
> -#include "qemu/notify.h"
> =20
>  typedef enum {
>      ARM_ENDIANNESS_UNKNOWN =3D 0,
>=20
