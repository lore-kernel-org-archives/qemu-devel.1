Received: from eggs.gnu.org ([2001:4830:134:3::10]:34187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiNY-0000Xa-VM
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiNV-0001kR-SZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:56 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiNV-0001kF-MG
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:27:53 -0500
Received: by mail-wr0-f195.google.com with SMTP id 4so4535422wrt.0
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:27:53 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-3-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9e45e60c-c279-f243-2441-2a5c6d65b533@redhat.com>
Date: Mon, 6 Nov 2017 15:27:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-3-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/18] #include <sys/vfs.h> is not
 available under Windows.
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
>  fsdev/file-op-9p.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 474c79d003..3fc7b0532f 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -16,7 +16,9 @@
>  
>  #include <dirent.h>
>  #include <utime.h>
> -#include <sys/vfs.h>
> +#ifndef _WIN32
> +# include <sys/vfs.h>
> +#endif
>  #include "qemu-fsdev-throttle.h"
>  
>  #define SM_LOCAL_MODE_BITS    0600
> 

Like patch 4, this only makes sense in the same patch that stops using
function from /usr/include/sys/vfs.h.

Paolo
