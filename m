Received: from eggs.gnu.org ([2001:4830:134:3::10]:53417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f44AZ-0008GV-HQ
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f44AT-0007DI-TE
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:39:11 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:55665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f44AT-0007D5-LF
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:39:05 -0400
Received: by mail-wm0-x242.google.com with SMTP id b127so5305749wmf.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:39:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180329151018.15319-1-brogers@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <daae58a6-29bc-e0e9-8658-fb27ee47e175@redhat.com>
Date: Thu, 5 Apr 2018 14:39:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180329151018.15319-1-brogers@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sys_membarrier: fix up include directives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org, mst@redhat.com

On 29/03/2018 17:10, Bruce Rogers wrote:
> Our rule right now is to use <> for external headers only.
> util/sys_membarrier.c violates that. Fix it up.
> 
> Signed-off-by: Bruce Rogers <brogers@suse.com>
> ---
>  util/sys_membarrier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/util/sys_membarrier.c b/util/sys_membarrier.c
> index 8dcb53e63e..1362c0c4c5 100644
> --- a/util/sys_membarrier.c
> +++ b/util/sys_membarrier.c
> @@ -6,9 +6,9 @@
>   * Author: Paolo Bonzini <pbonzini@redhat.com>
>   */
>  
> -#include <qemu/osdep.h>
> -#include <qemu/sys_membarrier.h>
> -#include <qemu/error-report.h>
> +#include "qemu/osdep.h"
> +#include "qemu/sys_membarrier.h"
> +#include "qemu/error-report.h"
>  
>  #ifdef CONFIG_LINUX
>  #include <linux/membarrier.h>
> 

Queued, thanks.

Paolo
