Received: from eggs.gnu.org ([2001:4830:134:3::10]:44414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fSBXR-0001mb-Nv
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fSBXQ-00062C-MI
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:22:29 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:43721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fSBXQ-00061r-GZ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:22:28 -0400
Received: by mail-ot0-x232.google.com with SMTP id i19-v6so21921247otk.10
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:22:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-17-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-17-f4bug@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 11 Jun 2018 13:22:27 +1200
Message-ID: <CAHNT7NtGEgDee=3ZsJU28=q_FYUpYbDEgNYmcSP4qf0c713UhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 16/40] hw/riscv: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Mon, Jun 11, 2018 at 1:14 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> It eases code review, unit is explicit.
>
> Patch generated using:
>
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/
> include/hw/
>
> and modified manually.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Michael Clark <mjc@sifive.com>


> ---
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ad03113e0f..34d48993a2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -84,7 +85,7 @@ static hwaddr load_initrd(const char *filename, uint64_=
t
> mem_size,
>       * halfway into RAM, and for boards with 256MB of RAM or more we put
>       * the initrd at 128MB.
>       */
> -    *start =3D kernel_entry + MIN(mem_size / 2, 128 * 1024 * 1024);
> +    *start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
>
>      size =3D load_ramdisk(filename, *start, mem_size - *start);
>      if (size =3D=3D -1) {
> --
> 2.17.1
>
>
