Received: from eggs.gnu.org ([2001:4830:134:3::10]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sUw-0000BV-5S
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7sUv-0000aO-Cx
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:55:26 -0400
Date: Tue, 9 May 2017 01:55:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508235520.clhgs5erpofurtlt@aurel32.net>
References: <20170508233918.9043-1-f4bug@amsat.org>
	<20170508233918.9043-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170508233918.9043-6-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 05/11] hw/mips: add missing include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Yongbok Kim <yongbok.kim@imgtec.com>

On 2017-05-08 20:39, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  include/hw/mips/mips.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/hw/mips/mips.h b/include/hw/mips/mips.h
> index e0065ce808..16412dc150 100644
> --- a/include/hw/mips/mips.h
> +++ b/include/hw/mips/mips.h
> @@ -6,6 +6,7 @@
>  #define INITRD_PAGE_MASK (~((1 << 16) - 1))
> =20
>  #include "exec/memory.h"
> +#include "hw/irq.h"
> =20
>  /* gt64xxx.c */
>  PCIBus *gt64120_register(qemu_irq *pic);

Acked-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
