Received: from eggs.gnu.org ([2001:4830:134:3::10]:33889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiMp-0008Qg-Ft
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiMm-0001W2-Bv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiMm-0001Vi-4h
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:08 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so14119858wmd.0
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:27:08 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-5-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84fb3ddb-f2e1-abb1-2d2a-40d25abcf2b0@redhat.com>
Date: Mon, 6 Nov 2017 15:27:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-5-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/18] Don't include sys/resource.h on
 Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
> Signed-off-by: Michael Fritscher <michael@fritscher.net>
> ---
>  hw/9pfs/9p.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index d1cfeaf10e..c2dd782620 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -3,7 +3,9 @@
>  
>  #include <dirent.h>
>  #include <utime.h>
> -#include <sys/resource.h>
> +#ifndef _WIN32
> +# include <sys/resource.h>
> +#endif
>  #include "fsdev/file-op-9p.h"
>  #include "fsdev/9p-iov-marshal.h"
>  #include "qemu/thread.h"
> 

This is probably related to patch 14, and should be included in there.

Paolo
