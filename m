Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxscf-0005Ys-4b
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxscb-00051b-6M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:34:21 -0400
Date: Fri, 29 Sep 2017 18:34:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170929103411.GF26066@lemon.lan>
References: <20170920085952.3872-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920085952.3872-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb: Use angle brackets for cacard include
 directive
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Wed, 09/20 16:59, Fam Zheng wrote:
> This is a library header, so angle brackets are more appropriate; also
> move the line to before QEMU headers, as is recommended in HACKING.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/usb/ccid-card-passthru.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
> index 45d96b03c6..117711862e 100644
> --- a/hw/usb/ccid-card-passthru.c
> +++ b/hw/usb/ccid-card-passthru.c
> @@ -9,11 +9,11 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include <cacard/vscard_common.h>
>  #include "chardev/char-fe.h"
>  #include "qemu/error-report.h"
>  #include "qemu/sockets.h"
>  #include "ccid.h"
> -#include "cacard/vscard_common.h"
>  
>  #define DPRINTF(card, lvl, fmt, ...)                    \
>  do {                                                    \
> -- 
> 2.13.5
> 
> 

Cc: qemu-trivial@nongnu.org
