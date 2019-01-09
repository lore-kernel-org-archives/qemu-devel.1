Received: from eggs.gnu.org ([209.51.188.92]:33912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAwZ-00070h-KE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAwY-0008UU-SY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:18:39 -0500
References: <1546614146-10525-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <17de2d6a-7b80-ca81-f517-25cf68b2e2d7@vivier.eu>
Date: Wed, 9 Jan 2019 11:18:16 +0100
MIME-Version: 1.0
In-Reply-To: <1546614146-10525-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/audio/marvell: Don't
 include unnecessary i2c.h header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>

On 04/01/2019 16:02, Thomas Huth wrote:
> This device does not use I2C, so no need to include the header file here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/audio/marvell_88w8618.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
> index 6600ab4..035dd76 100644
> --- a/hw/audio/marvell_88w8618.c
> +++ b/hw/audio/marvell_88w8618.c
> @@ -12,7 +12,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "hw/hw.h"
> -#include "hw/i2c/i2c.h"
>  #include "hw/audio/wm8750.h"
>  #include "audio/audio.h"
>  #include "qapi/error.h"
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
