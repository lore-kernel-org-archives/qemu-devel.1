Received: from eggs.gnu.org ([2001:4830:134:3::10]:39525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQsV-0007nx-HT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvQsU-0006u4-RA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:32:35 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:47489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvQsU-0006tM-Kx
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:32:34 -0400
Received: by mail-wr0-x230.google.com with SMTP id k20so1335639wre.4
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 09:32:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-4-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 17:32:13 +0100
Message-ID: <CAFEAcA9C1h0LBuSGiV1_UjgUuu5cjPVFbfK8nHBOsD1Bv6F8Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/34] block: remove "qemu/osdep.h" from
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 22 September 2017 at 16:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> applied using ./scripts/clean-includes
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/dmg.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/block/dmg.h b/block/dmg.h
> index b592d6fa8b..2ecf239ba5 100644
> --- a/block/dmg.h
> +++ b/block/dmg.h
> @@ -26,7 +26,6 @@
>  #ifndef BLOCK_DMG_H
>  #define BLOCK_DMG_H
>
> -#include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "block/block_int.h"
>  #include <zlib.h>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
