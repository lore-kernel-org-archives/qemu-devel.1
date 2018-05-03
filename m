Received: from eggs.gnu.org ([2001:4830:134:3::10]:42391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKY2-0002d5-TN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKXy-0002uB-Pg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEKXy-0002tr-KL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:09:46 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-39-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d91daac6-7e5c-9cf4-d9df-4fec07f4e8cf@redhat.com>
Date: Thu, 3 May 2018 15:09:42 -0500
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-39-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 38/67] helper: replace command line flags
 with preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On 05/03/2018 02:51 PM, Michael S. Tsirkin wrote:
> Each target is currently built with a different set of include
> directories, this is what makes it possible to pull in a separate copy
> of helper.h depending on the target.
> 
> Replace with per-target ifdefs which are easier to understand.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/exec/helper.h | 2 ++
>   1 file changed, 2 insertions(+)
>   create mode 100644 include/exec/helper.h

Out-of-order patch; target-dir.h isn't created yet...

> 
> diff --git a/include/exec/helper.h b/include/exec/helper.h
> new file mode 100644
> index 0000000..55a48a0
> --- /dev/null
> +++ b/include/exec/helper.h
> @@ -0,0 +1,2 @@
> +#include "target-dir.h"
> +#include TARGET_DIR(helper.h)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
