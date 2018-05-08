Received: from eggs.gnu.org ([2001:4830:134:3::10]:59661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG2yo-0000FJ-H5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG2yl-00006V-95
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:48:34 -0400
Date: Tue, 8 May 2018 15:48:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508154822.6815da73.cohuck@redhat.com>
In-Reply-To: <1525376963-79623-64-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-64-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 63/67] hw/s390x: use target headers
 explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Thu, 3 May 2018 22:51:43 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This way they are easier to find.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 435f7c9..418dc48 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -33,7 +33,7 @@
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/css-bridge.h"
>  #include "migration/register.h"
> -#include "cpu_models.h"
> +#include "target/s390x/cpu_models.h"
>  #include "hw/nmi.h"
>  
>  S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)

Acked-by: Cornelia Huck <cohuck@redhat.com>
