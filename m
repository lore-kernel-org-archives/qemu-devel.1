Received: from eggs.gnu.org ([2001:4830:134:3::10]:49246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCu0-0002hv-JZ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emCtz-00060N-BY
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:20:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1emCty-00060A-Qc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:20:15 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-5-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <10d2d3a9-f483-10d9-be50-076889896faa@redhat.com>
Date: Thu, 15 Feb 2018 07:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/30] hw/lm32/milkymist: remove unused
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Michael Walle <michael@walle.cc>

On 15.02.2018 05:28, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/lm32/milkymist.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 471a74eaa1..c28379399f 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -30,7 +30,6 @@
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "elf.h"
> -#include "sysemu/block-backend.h"
>  #include "milkymist-hw.h"
>  #include "lm32.h"
>  #include "exec/address-spaces.h"

Works indeed without that include.

Tested-by: Thomas Huth <thuth@redhat.com>
