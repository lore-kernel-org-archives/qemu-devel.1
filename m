Received: from eggs.gnu.org ([2001:4830:134:3::10]:44311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKaX-00052T-3V
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKaW-00052B-0A
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:12:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35128 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEKaV-00051r-Re
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:12:23 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-42-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <84109984-6157-7fe3-ae35-2487f0c65b22@redhat.com>
Date: Thu, 3 May 2018 15:12:16 -0500
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-42-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 41/67] tcg-pool.inc.c: replace command line
 flags with preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On 05/03/2018 02:51 PM, Michael S. Tsirkin wrote:
> Each target is currently built with a different set of include
> directories, this is what makes it possible to pull in a separate copy
> of cpu.h depending on the target.
> 
> Replace with per-target ifdefs which are easier to understand.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/tcg-pool.inc.c | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 include/tcg-pool.inc.c
> 
> diff --git a/include/tcg-pool.inc.c b/include/tcg-pool.inc.c
> new file mode 100644
> index 0000000..d04a981
> --- /dev/null
> +++ b/include/tcg-pool.inc.c
> @@ -0,0 +1 @@
> +#include_next "../tcg/tcg-pool.inc.c"

Bad copy-and-paste in the commit message?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
