Received: from eggs.gnu.org ([2001:4830:134:3::10]:54683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dAV1E-00076G-Cm
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dAV1A-0000vx-Ej
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:27:36 -0400
References: <20170516052439.16214-1-kraxel@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ed22959a-4ca8-0556-6ea7-f7866a20fe7d@weilnetz.de>
Date: Tue, 16 May 2017 07:27:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170516052439.16214-1-kraxel@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix mingw build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

Am 16.05.2017 um 07:24 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  crypto/random-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/crypto/random-platform.c b/crypto/random-platform.c
> index 0eddb915b7..92eed0ee78 100644
> --- a/crypto/random-platform.c
> +++ b/crypto/random-platform.c
> @@ -23,7 +23,7 @@
>  #include "crypto/random.h"
>
>  #ifdef _WIN32
> -#include <Wincrypt.h>
> +#include <wincrypt.h>
>  static HCRYPTPROV hCryptProv;
>  #else
>  static int fd; /* a file handle to either /dev/urandom or /dev/random */
>

Thank you.

Reviewed-by: Stefan Weil <sw@weilnetz.de>

cc`ing qemu-trivial.
