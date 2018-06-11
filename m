Received: from eggs.gnu.org ([2001:4830:134:3::10]:45188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSRmR-00036z-Ar
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSRmN-0002Pg-WA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:43:03 -0400
Date: Mon, 11 Jun 2018 15:42:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611184257.GS7451@localhost.localdomain>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180611011501.10235-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/40] x86/cpu: Use definitions from
 "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sun, Jun 10, 2018 at 10:14:24PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Nice, thanks!

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

> ---
>  target/i386/cpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 94260412e2..56c63615fe 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -18,6 +18,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/cutils.h"
> =20
>  #include "cpu.h"
> @@ -64,9 +65,6 @@ struct CPUID2CacheDescriptorInfo {
>      int associativity;
>  };
> =20
> -#define KiB 1024
> -#define MiB (1024 * 1024)
> -
>  /*
>   * Known CPUID 2 cache descriptors.
>   * From Intel SDM Volume 2A, CPUID instruction
> --=20
> 2.17.1
>=20

--=20
Eduardo
